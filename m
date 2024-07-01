Return-Path: <netdev+bounces-108015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0891D8CF
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4732F1C21474
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A340374047;
	Mon,  1 Jul 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FAKKloPn"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827C6BFC7
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818276; cv=none; b=RCAqWb1IP2HxJJn2wi6Zl82WDNl3K/4Kn9nE2a0qUufr2M9kmikR7lYK/3jRW3oX5z/FtSi8a0bMfh7rR+7GPlVocwSmMqXMyd+2+xKub7/pmlYY8z2IXQ/ifW+e5datAjkUfbY+CAcSWB/zDDE53vyoSer9V1S5TCKgNFngrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818276; c=relaxed/simple;
	bh=sy+6/M4hUxxEREy+NgMGoGKalzOtYZKD06VabQoFiSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYc5EDTJCeARUHydn43yEamPTr6n+0jI/iNlwMdnE6kE/1jp0AjQRE8BUyvNYEq+pR+XEV39ZuO7JIUPuXiJrv6WRmf7RBtWRt7BPm/Nd3JzkmzUXF7MOZzTDD2Q+rby3G2D79upx43Gh6ocKeuwx66LrQKSdcEPCtcbf/ddLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAKKloPn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E8D4C1140060;
	Mon,  1 Jul 2024 03:17:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 01 Jul 2024 03:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719818273; x=1719904673; bh=4ULBriEQoqjYbpQysNCpp1RNPd6R
	GRB5QdiOjLgkkYM=; b=FAKKloPnNCBYofPzfrQTzR97yQErqlKwrE4ezZt2l6LO
	v1Q+x/VLbiLi5wH/62O9aOmpKB/G26MW6JVqDkowpR9Xm6tNNbtD+xWOXqNAu7t5
	hDLH/QjppDVzvNSOP8BR/xNWTSF4GLCbcqYuOVwBJqycPK93IptMgn8fC3Kc9Ukk
	gIfBJij4dwDbnCWZdntUvjJKO3lB5xAzxtYO3EFtUyrL6tAKcL1FL6zkkr4j+e7/
	beZofX/JxkhdpZO80sBQ40guQWBnXHmfCXp+AkR+pte5jMK4RJqVdB/ZBcD8MZN9
	mckLm/CVcPt4bWSub5+/vpscio2sQrGmufkHX7OoVg==
X-ME-Sender: <xms:IViCZoQ9LQbNYy-Z8DJaD18mB_prz262JChsIpGqpFTpeEifJwQ5tg>
    <xme:IViCZlzlLbyEToBrWnlBo29VQ2IIROWCcujS5vJedEGp_roO342wCP7Lhf_TzO7kZ
    HyksZZ8xYZ3ryA>
X-ME-Received: <xmr:IViCZl2oy4uIsti4MRa346qfl6owDmLAslilSfKeBwqXEJFOgvS-vahkKl3V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:IViCZsCpmZ9JPC02ZjRrVcGNgSY6jUVVL7EofqhKqoH-nIwVtkGDtw>
    <xmx:IViCZhiLMzx1veQzTmGve5ENpPZ9nc8kFxpgKSCpPGs9hS2TuYtdBw>
    <xmx:IViCZopl8HugRGTz6sqNcZW8XVoJ33MHViYTjVviFSza-mwz_6IppA>
    <xmx:IViCZkjJanrZ9EmSYBiYGfEwBhzQ2eUYF_CLvqGWsdFz2HbZG8Zbdg>
    <xmx:IViCZkvjS4Vj2LdztIiBi_QTcP7E3hMMQRU5pMBNdlnN__Tn6bySfUh4>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 03:17:52 -0400 (EDT)
Date: Mon, 1 Jul 2024 10:17:46 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "ip route show dev enp0s9" does not show all routes for enp0s9
Message-ID: <ZoJYGv7WXuBUeZM4@shredder.mtl.com>
References: <SJ0PR84MB2088DCBDCCCD49FFB9DFFBAAD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <20240627193632.5ea88216@hermes.local>
 <SJ0PR84MB20889120746B75792B83693CD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <ZoE15-y0wMhzQEYg@shredder.mtl.com>
 <20240630092308.0288083a@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630092308.0288083a@hermes.local>

On Sun, Jun 30, 2024 at 09:23:08AM -0700, Stephen Hemminger wrote:
> Good catch, original code did not handle multipath in filtering.
> 
> Suggest moving the loop into helper function for clarity

Thanks, looks good. Do you want to submit it?

You can add:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

