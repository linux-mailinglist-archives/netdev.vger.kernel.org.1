Return-Path: <netdev+bounces-241375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C943CC8335F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BEFC34B521
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270321E08D;
	Tue, 25 Nov 2025 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM+GBR3A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0721146C;
	Tue, 25 Nov 2025 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040873; cv=none; b=JiUaLT3U1AuSmePWRuPjZ5DliavAU/uFJzoC5tkb8p0WGdSYVEaISdar94PJVnGY/TfC83LtOp2oX9m3GKYs/r0mzULlZH0xSLuUD6aymuyPsVNbdyQSbRHhoV6OZM51h9U/rwu4rq6iDlcZ0Q79a7fDCQDcgRl77Qq4U5+S4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040873; c=relaxed/simple;
	bh=xlG1r6oX/4H47lab/8da3RjqRYRxqjarY/DRox3C/aU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyTpsrbs4pPpadCNaS49mSUbxYmNKKiUY+xwTZ+pD/W7sQgYcyiZ8CNgteQIKB/AGqgyfZdPVj4/LHDlT09uUUvVWEQVROG4O2OvMBJ6jGmiY2TAFrqxhoDth4Cc7ZXqvaTcpjOVmudjHzBFzf+K2qWz+kTgG6glapBydn0DLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM+GBR3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6208C4CEF1;
	Tue, 25 Nov 2025 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040872;
	bh=xlG1r6oX/4H47lab/8da3RjqRYRxqjarY/DRox3C/aU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dM+GBR3A6AiwJJ3U5QVZUyWP/YxWUtFmH4rC93By6q2lL0n9MVBbJFtWgeEBCwkcG
	 IiolxQMApo5PmDME3R+hLUm8KAtmtfYJ1Vs+hfrnQLWKOYUSoPaWYfyJFCW6hIIBo1
	 oodod/XDllfijj97pslKFPy3cKnpYWRU9a6zKeZPp5pEpVYtcgwa7KqVufI/s2QYrg
	 ByobFhoGG+CEpKxrSVZc4RyjPqTte055zT0p/bwKZRO2VkgQRT1LbwbLQgoo07tegC
	 dBc3d96g31SGTUXDbGbwjAhmiWR5TZc01gDjs1ZzkKNlUA4OUD9/dB3ocFAI0kQxyZ
	 WLwy+dw8V/vbA==
Date: Mon, 24 Nov 2025 19:21:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Slark Xiao" <slark_xiao@163.com>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
Message-ID: <20251124192111.566126f9@kernel.org>
In-Reply-To: <2188324.36f7.19ab902e6b5.Coremail.slark_xiao@163.com>
References: <20251120114115.344284-1-slark_xiao@163.com>
	<20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
	<605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
	<CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
	<623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
	<20251124184219.0a34e86e@kernel.org>
	<33bc243d.33c6.19ab8fa1cb4.Coremail.slark_xiao@163.com>
	<20251124191226.5c4efa14@kernel.org>
	<2188324.36f7.19ab902e6b5.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 11:16:06 +0800 (CST) Slark Xiao wrote:
> At 2025-11-25 11:12:26, "Jakub Kicinski" <kuba@kernel.org> wrote:
> >On Tue, 25 Nov 2025 11:06:30 +0800 (CST) Slark Xiao wrote:  
> >> >Are you saying you have to concurrent submissions changing one file?
> >> >If yes please repost them as a series.    
> >> One patch of previous series has been applied.   
> >
> >To the mhi tree?  
> 
> Yes. It has been applied to mhi-next branch. That patch applied
> before posting this patch .

In this tree? 
https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/
That'd be unacceptable for a drivers/net/ patch.
But I don't see such a patch here. 
Just patches to drivers/bus/mhi/

