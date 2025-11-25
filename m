Return-Path: <netdev+bounces-241397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D4C835C8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B793ADC7C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E621D3EA;
	Tue, 25 Nov 2025 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+1iTx7S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A513777E;
	Tue, 25 Nov 2025 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046561; cv=none; b=eSoAzvHzXLjfcTqeltUBmYiaQtnMi9c2AiaBaPcTC5UdETT0WmuIl0dGihYMmGl79RE9uBjTVqRyPLemKj6v/zuVeYuWi3TRnFivAA/ZkHBAQVzS5VZPq8g9EvZ0YdEWAHs5vcUA3e/OaVD5CGOgKjC4VrLAQ/dG+Vu3M6WKpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046561; c=relaxed/simple;
	bh=/mEny0NKX2iSik1Rj4RafVjhPmCQi0Zei1V/lU3lcEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSyEcFi1CFMamZGvqr+fYK8sYaHzbvFm07FAM5KJVuHKSTQ6nLOjS8NjkVsBMRF0AtPiUs4Ko1N+l+CkKGR9BtYQt2AU5A1VsPhfkxoL8K4eCyCxLX9SPeYu/N3Ij1wmn2qpBJ+0i8gMJxONDTQwvkvLQDW7g1hM7SnxcpTasuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+1iTx7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4172C116B1;
	Tue, 25 Nov 2025 04:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764046559;
	bh=/mEny0NKX2iSik1Rj4RafVjhPmCQi0Zei1V/lU3lcEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+1iTx7SeEOVxvuxmb0e200RmqLxL/JYJ1ptAOj3uE8yE6T4ftBE1zzrGZ1sGDoyQ
	 0S6fkFx5GSxRXVIm+G3+zixAiSktxoQh3rauDS4mVsFPxxpgK4rKasb9EjxGOBCuNt
	 Md/6TCKREGZT2IHaGUrKX/Zn0jbfSH73eX6HYmjEv0UWWgpWRKwohJxmK/Q1c1TNoG
	 lGSoVDxz7QnIPQ5MEsoL/9Bzu5Yoz/YVvpJGgFEP4eNWShKZXMKAMk1OcTObZXesqw
	 ziB01CVbadO+7MFbq2GlPswUlnpRCro8y93kZ3kFdbqlXgXpCA5fLmIrPEfoLaU85F
	 3a28UjlMobi7A==
Date: Tue, 25 Nov 2025 10:25:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, ryazanov.s.a@gmail.com, johannes@sipsolutions.net, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
Message-ID: <mo2f3j475zadtaouv4t3gtjgpnwckpatixyn5hy7lhe6zphsw4@gwho33yxgkb6>
References: <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
 <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
 <CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
 <623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
 <20251124184219.0a34e86e@kernel.org>
 <33bc243d.33c6.19ab8fa1cb4.Coremail.slark_xiao@163.com>
 <20251124191226.5c4efa14@kernel.org>
 <2188324.36f7.19ab902e6b5.Coremail.slark_xiao@163.com>
 <20251124192111.566126f9@kernel.org>
 <1a29d59a.3b7b.19ab910e6bc.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a29d59a.3b7b.19ab910e6bc.Coremail.slark_xiao@163.com>

On Tue, Nov 25, 2025 at 11:31:23AM +0800, Slark Xiao wrote:
> 
> At 2025-11-25 11:21:11, "Jakub Kicinski" <kuba@kernel.org> wrote:
> >On Tue, 25 Nov 2025 11:16:06 +0800 (CST) Slark Xiao wrote:
> >> At 2025-11-25 11:12:26, "Jakub Kicinski" <kuba@kernel.org> wrote:
> >> >On Tue, 25 Nov 2025 11:06:30 +0800 (CST) Slark Xiao wrote:  
> >> >> >Are you saying you have to concurrent submissions changing one file?
> >> >> >If yes please repost them as a series.    
> >> >> One patch of previous series has been applied.   
> >> >
> >> >To the mhi tree?  
> >> 
> >> Yes. It has been applied to mhi-next branch. That patch applied
> >> before posting this patch .
> >
> >In this tree? 
> >https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/
> Yes. 
> >That'd be unacceptable for a drivers/net/ patch.
> >But I don't see such a patch here. 
> >Just patches to drivers/bus/mhi/
> The patch for drivers/net still in a reviewed status, but not applied.
> MHI side has inform NET side about the apply status. 
> https://lore.kernel.org/netdev/176361751471.6039.14437856360980124388.b4-ty@oss.qualcomm.com/
> 
> So currently it shall be pending in NET side?

This patch has no build dependency with the MHI patch that I applied to
mhi-next [1]. So please rebase on top of net/net-next and repost, so that this
one can go through netdev for v6.19.

- Mani

[1] https://lore.kernel.org/all/20251119105615.48295-2-slark_xiao@163.com

-- 
மணிவண்ணன் சதாசிவம்

