Return-Path: <netdev+bounces-276931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPVRNoN912nMOwgAu9opvQ
	(envelope-from <netdev+bounces-276931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:20:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0A3C91C3
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 610EC3009157
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185C38A72E;
	Thu,  9 Apr 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diPZoToe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39037F726
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729884; cv=none; b=l/3FXezOWp6iZIgrXOjeh9Og0lFAOOCfSjrXLH2wtlB16g1BfaQSnE/Rrztf36TtTUSsLiYBZgm2V7KPQ543zQj0NFryAnAvfLuu2UA9fJL9VizecOUcS/PggwMp76xpvYuUysRmShnikXq0xisi6I3qxfNJdkm6eeSgJryiiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729884; c=relaxed/simple;
	bh=1q55tMVWI6mammcOjxW3cDmiubItxP9+kw3A0KT6WcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCCBs4ye93MNV9OE9vtBzGhNQ5Ebc1JC3ApBy74r8+7k2JZTTgicqWRFtwm0IYaD1pJxM0tEtNAJQERX+1qLEJh4V48Mw50jdtTwHmgzz4hBeuAf6wNzBaJEJl6hfgME7Xo9uiQBTTsS8kREfAbon3I3UnQiUlNSwqc7lD7P/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diPZoToe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1D3C4CEF7;
	Thu,  9 Apr 2026 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775729883;
	bh=1q55tMVWI6mammcOjxW3cDmiubItxP9+kw3A0KT6WcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diPZoToeLPTG2VxoOZvSjnoVWmBsNr7r4d3xnZc0zd1zacObvo0j38t78J6gE/uzq
	 orhI5+rIUmX2F6u/Z+9Kv8DF8rnV5gY3kaUde+ItIMP1/vIOoyzWwBaFJqWUVJxEW5
	 d80sGPf1r9h41POwY9zpirZfCniaCi0KuhBENl6C//XAp+JQSILVg6RfNguUE4SxdZ
	 jBVJ1kURBPW0+TmOpLu0ipnIwbG64AMdf0fcFI/dDJMdQDN9WfTS5wlOXFIRj6DJOf
	 UDdCApi9mwzA7Qgoghgj966XRjbwk7X6nup4qZmhmbwp7pB/wulBn/tetMUqwJPyGp
	 u8510KdfO1onA==
Date: Thu, 9 Apr 2026 11:17:59 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-nfc@lists.01.org, davem@davemloft.net, kuba@kernel.org,
	=?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
Subject: Re: [PATCH] nfc: nci: fix OOB heap read in
 nci_core_init_rsp_packet_v2()
Message-ID: <20260409101759.GL469338@kernel.org>
References: <20260404180049.1304711-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260404180049.1304711-1-snowwlake@icloud.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276931-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.01.org,davemloft.net,kernel.org,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[icloud.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 41F0A3C91C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 08:00:49PM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nci_core_init_rsp_packet_v2() walks the chip-supplied
> supported_rf_interfaces[] flexible array using a plain pointer
> with no bounds check.  Each iteration advances supported_rf_interface
> by (1 + 1 + rf_extension_cnt) bytes, where rf_extension_cnt comes
> directly from the chip.  A hostile NCI v2 chip can set
> rf_extension_cnt=255 per entry and num_supported_rf_interfaces=4,
> driving the pointer up to ~1028 bytes past the end of the skb into
> adjacent kernel heap.
> 
> Add two guards per loop iteration:
>  - check that at least 2 bytes remain before reading the interface
>    byte and extension count byte;
>  - check that sufficient bytes remain for the declared extension
>    block before advancing over it.
> 
> Also add an upfront sizeof(*rsp) check so that accessing the fixed
> header fields (nfcc_features, max_logical_connections, ...) is safe
> before the loop is reached.
> 
> Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>

I believe that my review of "[PATCH] nfc: nci: fix OOB heap read in
nci_core_init_rsp_packet_v1()" is relevant here.

- https://lore.kernel.org/all/20260408190505.GK469338@kernel.org/

I would appreciate it if you could create a v2 patchset, including
an updated version of this patch and that one.

Thanks!

-- 
pw-bot: changes-requested

