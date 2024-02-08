Return-Path: <netdev+bounces-70304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0C84E4F3
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A17B27E45
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5887E569;
	Thu,  8 Feb 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NyfTss4Y"
X-Original-To: netdev@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC981ABF;
	Thu,  8 Feb 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409297; cv=none; b=oFr0enjwwLSSAJlHuhdNMKCZFnYflKZuNhSa05l84ec5qbFGAVpFUnfUFyzFj4JRRbiQmk+Ioi1of1IHLqA9oNZ07EXvqulZnGGI2DN24aHDmvOeHAg3kMknnzzEPleRoXLVp1aEzMayrpcy5z+SpzfzPgf1hrSqPcZ1KqQSzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409297; c=relaxed/simple;
	bh=13stO1tT1lQFQjJ06BTUULRPTA7BEpx1JRFoOnV9bUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHmuWqJZW+BJGmgrXjqOaXMx1iWsamegevlaDQmt+vGqeOqeD9XKx62AuSQGQs6qbs2g9oXRTQ4KDos/NAxkClUZ3BUzp4Jr8C1SuvvS+iHXWQRTgGGIU+fGdJRJD/1q1UE70f49wrqnVc9CvroNQs4U5pnQSSUSH7RkImHjdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NyfTss4Y; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 20D385C00BE;
	Thu,  8 Feb 2024 11:21:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 08 Feb 2024 11:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707409295; x=1707495695; bh=U4hCbHFKfdC6uS3nIwXToZoziuxN
	4tX7Cz0LIy8vu20=; b=NyfTss4YRGw6cbWC/rJg6+DJWytl4PdzVu0a0GC5kkxo
	2B4RZ1rXTdX80a5ny/t23z2hOxCDaTVhgoSy+sTxXJMiMx+FqnZ8b7DX0cb1xjY2
	6QJx7BOG8OUqCOeUOskgjmvhMHBmVv75Ct+vZ4LMXMfmC0Wc983GQ1SFpCM4HOmB
	DqU2D7WjU+7BL5kCK+NhFERlpsO1zGrl1Afm20H0eYLewmPa4bqukRRfbYXeGBkn
	0iN6wIThSiHCNuIs2+KcmdBs1lMdnEgve87HlMQtjWZ6yJWmeNfDRoWsR7Cw+80K
	i9UqvMyFz2xqWUUglt3W4dsiobTrPd3yHPsVzth6Xg==
X-ME-Sender: <xms:jv_EZf7qwcjb1Kf0FwtbnkmIqcHORn9-yfvZ0_XTMfDg1MONVniGsQ>
    <xme:jv_EZU5ez-F7iQyXu6tB1A4ddA4JaK5Hnis7YkZTejyxco9_YO-cQIJpcVjSXFX_V
    8ZPCjab6L0m-Uk>
X-ME-Received: <xmr:jv_EZWeTTf_lWE-Lm-AI2ZdmZiAsPUf2JxlqFIeZvDRWuS3HFYJSYNLCyjeF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepieehffeivddtheejjeffkefftdeihe
    eujeevgfetieeugeekleelfefgleetudeinecuffhomhgrihhnpehlihhnuhigrdguvghv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:jv_EZQK5TeBk3j9fciEz_J_RRf5RvSp2yEsceTY1ZjjAE9xmTjC2aA>
    <xmx:jv_EZTJWa9tActVYoElnlSRwJhxvNKnbXN3S5z14r3nBK1FQcw88tA>
    <xmx:jv_EZZw7Iy8CMbyxe3VGSxND53NECFfPSZ4Q6Eg0aarhSlYEP5LSBA>
    <xmx:j__EZVwWvYZQN-HC2BxfGuyJsgKRVf3hGoMwzkf_TDfpvWbNbV2f1g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 11:21:34 -0500 (EST)
Date: Thu, 8 Feb 2024 18:21:29 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] bridge tests (was: net-next is OPEN)
Message-ID: <ZcT_iSwnYmORF-8A@shredder>
References: <ZbedgjUqh8cGGcs3@shredder>
 <ZbeeKFke4bQ_NCFd@shredder>
 <20240129070057.62d3f18d@kernel.org>
 <ZbfZwZrqdBieYvPi@shredder>
 <20240129091810.0af6b81a@kernel.org>
 <ZbpJ5s6Lcl5SS3ck@shredder>
 <20240131080137.50870aa4@kernel.org>
 <Zbugr2V8cYdMlSrx@shredder>
 <20240201073025.04cc760f@kernel.org>
 <20240201161619.0d248e4e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161619.0d248e4e@kernel.org>

On Thu, Feb 01, 2024 at 04:16:19PM -0800, Jakub Kicinski wrote:
> On Thu, 1 Feb 2024 07:30:25 -0800 Jakub Kicinski wrote:
> > On Thu, 1 Feb 2024 15:46:23 +0200 Ido Schimmel wrote:
> > > > selftests-net/test-bridge-neigh-suppress-sh
> > > >  - fails across all, so must be the OS rather than the "speed"    
> > > 
> > > Yes, it's something related to the OS. From the log below:
> > > 
> > > ```
> > >  COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
> > >  Raw IPv6 socket: Operation not permitted
> > >  TEST: ndisc6                                                        [FAIL]
> > >      rc=1, expected 0
> > > ```
> > > 
> > > The test is supposed to be run as root so I'm not sure what this error
> > > is about. Do you have something like AppArmor or SELinux running? The
> > > program creates an IPv6 raw socket and requires CAP_NET_RAW.  
> > 
> > Ah, ugh, sorry for the misdirection, you're right.
> 
> Confirmed, with the SUID cleared test-bridge-neigh-suppress-sh now
> passes on everything with the exception of metal+debug kernel.

I'm sorry for bothering you with this, but I checked today's logs and it
seems there is a similar problem with arping:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/456561/8-test-bridge-neigh-suppress-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/456562/6-test-bridge-neigh-suppress-sh/stdout

And according to this log the ndisc6 problem resurfaced:
https://netdev-3.bots.linux.dev/vmksft-net/results/456382/6-test-bridge-neigh-suppress-sh/stdout

Any chance that something in the OS changed since last week?

