Return-Path: <netdev+bounces-281214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ08FX3N7mlMxwAAu9opvQ
	(envelope-from <netdev+bounces-281214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CDC46C38C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F8E73002B2D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D803264F9;
	Mon, 27 Apr 2026 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q8YwRJLA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A35317152;
	Mon, 27 Apr 2026 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257849; cv=none; b=tEQ5jY5jXN3xOkaCFU11ywtBNaQwXBykYpUfK9YDrrXe6gqPZsWUizxK0Rt8d7d89DfFdT4540v4EWl+wpcuwBqgaSAKRKM3fcny+D3r2BzqdF1Ysvo54CByDvgwGCXkXMIiIEUDUkMeQp/KDzksANe+vjANN6VG6oo/Gcjtfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257849; c=relaxed/simple;
	bh=bwq7UmPXpiyBFem7scGzKoglqeqYeeXrLGMOEdKaNVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5jqQEMtFIjUb3sLpyybAKdivAma5VMRs41n0ACpMe6Sr7Y5R38e3oBSHvr91KV2nDj8tbAFkc6StjPwTwbDKrZ+CwSkEE++A3YKuFm1JhqadkleSHPWmFJ/9ntNvwUvPIuAELvsxiMH5jKqa/xHH09dJVJH0Jyr6Thzj95kaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q8YwRJLA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=de3n8QAqtMqjOUG+N0taZAecD02pSJYllqt1wYHtl6Y=; b=q8YwRJLAMKC9pSmmrM9AH9Fx0C
	603rc6MUxQIuZL0G4mKNB0WdHPyTorWoIbg9uMsdOq5X9g749MyvoZrOGuvcWvlCkmtNaAKhzqJdd
	RWdxPYaiavorZuLkN6eiWnetuUqfbUc9sYcZ+jX6gXgcOZdwphRB630bN3N3rXIJ6Zj4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHBx0-0005n3-Vp; Mon, 27 Apr 2026 04:43:58 +0200
Date: Mon, 27 Apr 2026 04:43:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hayeswang@realtek.com,
	hsu.chih.kai@realtek.com, kees@kernel.org, mail@birger-koblitz.de,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G v2.0
Message-ID: <f7f13bc4-6a2c-454c-86e7-5420e839ab11@lunn.ch>
References: <20260426214909.3426105-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426214909.3426105-1-olek2@wp.pl>
X-Rspamd-Queue-Id: E2CDC46C38C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281214-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]

On Sun, Apr 26, 2026 at 11:49:00PM +0200, Aleksander Jan Bajkowski wrote:
> The TRENDnet TUC-ET2G V2.0 is an RTL8156B based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

I don't think i've seen an email yet that netdev is open after the
merge window.

Please post again when it does, and include Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

