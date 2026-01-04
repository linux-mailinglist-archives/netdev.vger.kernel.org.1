Return-Path: <netdev+bounces-246820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71FCF152F
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 22:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 814A0300942A
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 21:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F5231C9F;
	Sun,  4 Jan 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VlV7CeH7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CA3A1E8D
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767562039; cv=none; b=LNWscgHQ86CSsQieXZeCw6US+lJ7xfDFh8UTje8msNO8Jho+JtHYXOCIXrd7IY/c5mpa/YDcxiMxY6xhkBQL9Gr0zG5B/nwpuxQekUt3GV1bAjGXXLLpSm3HA+QIY6IYjBw0Bl6hlrZKsxyDVEY7PsoDUrWFfBnfwWTzlIbf7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767562039; c=relaxed/simple;
	bh=m5ztMroyEZ1N/RfKN4SyVVo6xiy9KFd+3qiWvW7vX5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7oO2mkWG9jTUbYWjA4ornsKYsHYKCo0tjZ+WiAwtH9yJu5RSArMPh7Qemr2yoi2h357cjnfazHiCSlM3nH2OIW+i9dsYAqv35ZKVCiwkqFwGF7QVtfRO1CAXNYLp+Dk6jkRuP52SwChoMSpGL61WJM2FmpAeSxnowqbwev/ncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VlV7CeH7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wWHycdFDWAU+oKVB4fxe2FlYD66mClX9694LAh3JzSc=; b=VlV7CeH7KjRTKGW8JyOOQ1fxvb
	8Tr7vKTZCxSz1OPR7KV2TsRY19isa610JO67YPvyrxso0ConQDNPgl+aMpe20f52yJ3p+VJlGlDGr
	abkuizpGXOnT7wZJCofQOKFGCzx4+l2UdRrxEifwLbWBGSjcIqZEJmBmM15UXWxHsf6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcVNQ-001OgE-6T; Sun, 04 Jan 2026 22:11:04 +0100
Date: Sun, 4 Jan 2026 22:11:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: fix return value in
 rtl8365mb_phy_ocp_write
Message-ID: <e78b1c9b-984e-41a0-a3a8-02c6b43489af@lunn.ch>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
 <97f5fb4a-f71b-4737-b637-321d41b067b6@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f5fb4a-f71b-4737-b637-321d41b067b6@yahoo.com>

On Sun, Jan 04, 2026 at 12:25:56PM +0100, Mieczyslaw Nalewaj wrote:
> What else can I do to add this patch?

I suggest you first get "net: dsa: realtek: rtl8365mb: remove
ifOutDiscards from rx_packets" accepted, so that you know you have
working email client, and have read the netdev FAQ so don't get
anything else wrong.

It takes a while to get processes correct.

   Andrew

