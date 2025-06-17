Return-Path: <netdev+bounces-198747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3FADD7D3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E607A721F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FC22DF80;
	Tue, 17 Jun 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IerOSroE"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3020CCFB
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178769; cv=none; b=ZKaQbD2hbzQU4Y5cXTiKx2CD31HRaoPQ+MipopJ2JtXXMHhBjGbOJT5jAIJl0uT9oS6LVStyJ/UzIVL7N0NcMfh3cbi41eHvfKWBv/LhK5vlEst0NfpooJP8eAVnU+KEDOfXkNejIxXWGSOXKJ8+eGH4awgklSuUibbgx9NtRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178769; c=relaxed/simple;
	bh=uWfAziTOz1MRs6LVuvbVnfVycgqVL9M9QBH/O0iFVkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk0Ehhhz5w/qBn0Msy2yG+71GTyBOpsZg5n0qEEun/6JvwJo2lP+EJ6cdnp2wJHGCFz26CUag5Zz1vlowGRuFiT2cLpzaGcBK7+LmyJsGz0L66bd4owPXPTKFmLHkKlug6Qn3NZMvOKj/AYu+dMs6684p7vSfe5z1i0Th7rbsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IerOSroE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DA7011401D2;
	Tue, 17 Jun 2025 12:46:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Jun 2025 12:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750178766; x=1750265166; bh=C60h2rY3ZjJ1acxDqWM2lsFLfdoAgNVk1jw
	o0JoHuec=; b=IerOSroEODtHDFT3ueVeX403N69lTG7o2P0Kz6TAhXz5xEjqM8x
	KSC2ETsvj1sxHHAro105ydn6Vg2aH1wR/+MxCNsFL/DmgP9fqGnJWLxWsdhYglvr
	lMU+MP9t4ULcCkHZrU84p0pw14rRov8aRndK8VSS7DUnRSuw3Dsx5PVsEItbC4LX
	QQYmTgv53Pr546Gl65Q6cGeNaHvLc8FG5SscOhnh09DCKKnaVi5bFqO+u0DX1tX3
	dv+UHg9DXIjx0ah37MHIDeSzYSCmXrDChu5qwJGhvNezAIji2jRBTnPCpgJ1GjoA
	4zZQ+h8phvT6x/c/ILh/iGzbi4s6JGVvbtA==
X-ME-Sender: <xms:zZtRaJxQByv7W1tlf0xH0Gkfwo-PoEn6SrSeQv280YUi8oGvB-0Sqw>
    <xme:zZtRaJSWT8QU4I3W3L7C6B-VdaNCpek3k-9xYoqIZsltY_htbaP0Jc4tvINEGS8PG
    8Xk8Pf8c4oiF0E>
X-ME-Received: <xmr:zZtRaDVt_DYLl_BSq2Qkim18V7_9lJ1LyKZXpWV8Dq0UaRLkpt9AYxoMZPxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgnhgruhhlthesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhise
    hrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughsrghhvghr
    nheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zZtRaLiJVxtLgSViuD4eTX0Y-cRRjXV7gwItw2FuT6A0pjD7cSeqKg>
    <xmx:zZtRaLC35AvaWI1pnkcVOflHqy-dBputD-GmNR-HiYQeKNB-OfAuAw>
    <xmx:zZtRaELykAT24X4bGcJSDRmyrNuFp_IfZ4Vc7qms_uHIVrE_X6sUEA>
    <xmx:zZtRaKAD1C7k_rq3SYjdOWPFttzn4FpixEinGVXVilUrLQ9UasPUrQ>
    <xmx:zptRaCX0JO0mPRuY1e1m076X37Ma7wCyfNo1FZSmkKYwDfm_AGV14a-x>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 12:46:04 -0400 (EDT)
Date: Tue, 17 Jun 2025 19:46:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] ipv6: Simplify link-local address generation
 for IPv6 GRE.
Message-ID: <aFGbyuXocIo3ejFC@shredder>
References: <a9144be9c7ec3cf09f25becae5e8fdf141fde9f6.1750075076.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9144be9c7ec3cf09f25becae5e8fdf141fde9f6.1750075076.git.gnault@redhat.com>

On Mon, Jun 16, 2025 at 01:58:29PM +0200, Guillaume Nault wrote:
> Since commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
> generation."), addrconf_gre_config() has stopped handling IP6GRE
> devices specially and just calls the regular addrconf_addr_gen()
> function to create their link-local IPv6 addresses.
> 
> We can thus avoid using addrconf_gre_config() for IP6GRE devices and
> use the normal IPv6 initialisation path instead (that is, jump directly
> to addrconf_dev_config() in addrconf_init_auto_addrs()).
> 
> See commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
> generation.") for a deeper explanation on how and why GRE devices
> started handling their IPv6 link-local address generation specially,
> why it was a problem, and why this is not even necessary in most cases
> (especially for GRE over IPv6).
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

