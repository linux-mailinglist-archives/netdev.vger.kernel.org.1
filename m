Return-Path: <netdev+bounces-270010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBggH56NvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:10:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D72DF352
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE3430480BC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C0C30C37E;
	Fri, 20 Mar 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc0AiC8H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542B30595C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029898; cv=none; b=gmgqL/7kq+4zKRtLbwAtSKAChlkxLEtwAyWeQwPdjRmn5VY4JcVrpIB2sJVnqDbOX0o4aDEJNI7DVijvLjWHXe/p5xfVTX5f8BlioVXKsIUXXa2vMjE6JeN/yxBFrAxoIj4e9rA8yglX1BRgFef2JAtkjj/srYIiTgnse8Oyrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029898; c=relaxed/simple;
	bh=MWjx9x4Xl1BkLqNJhEJUVwdMpzVxVl0W3+B/XEfda4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6NRdiwHHA36hkZyM2u3rN49DTBLEPfjE0GuhCylaNDzuv5kk2b81D70vU+Pqxm1uDeEYftldgb0MI3rKqKVOT6hPYnIrc7vhcG8nGfBxicX881xGB6xiKa3OwTFJUlRdScW/CMPw1Mno0fFM7OSbSvBFX1RmsAY2kj4Tq75F2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc0AiC8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCA6C4CEF7;
	Fri, 20 Mar 2026 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774029897;
	bh=MWjx9x4Xl1BkLqNJhEJUVwdMpzVxVl0W3+B/XEfda4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dc0AiC8HWTroundPkJREjzoBqtTidxTGkbEz+xDedXhWDrPx+RDNPXHM2KD8gmXYP
	 KpwKXdRQsTfzAR63tQ32OonJdjglD3N9CjI0f0kYajnGzR7kYcx6YSPu9sgB8on4YR
	 rTia+oqnQNk2Q00ZewQsImi8HfDjswi89+oGBuhAlq/Jw5q3H5333iefqkdemL3GWy
	 gI3OYciTiYbAeIInMnOA/CbABpSZYZtbYo+jWofrouZ6jFius9a8Pes+KTxxdnIptf
	 DmchDyYme+S4+lisudfyRW5i7gtFUvY8zjAdR0tigvgaYXtVzBmzLWPpBY+5cuiolK
	 iQUrB6KfH10gw==
Date: Fri, 20 Mar 2026 18:04:54 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Subject: Re: [PATCH] ice: add missing reset of the mac header
Message-ID: <20260320180410.GA151863@horms.kernel.org>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE5D72DF352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:05:18AM +0100, Aleksandr Loktionov wrote:
> From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> 
> By default skb->mac_header is not set, so reset prevents access to an
> invalid pointer.
> 
> Call skb_reset_mac_header() before accessing the mac header from skb.
> 
> Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Hi Katarzyna and Aleksandr,

I am curious:

Is this a bug? If so then it should probably have a fixes tag and
a bit more of a description around how this can happen.

If it is not a bug, then is this defensive? And if so, is it really necessary?

...

