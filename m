Return-Path: <netdev+bounces-136271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B89A1229
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B169E1F224E0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9152139C9;
	Wed, 16 Oct 2024 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaLFxaRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504A212627;
	Wed, 16 Oct 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105098; cv=none; b=bksv9yZP5jcjFV7TInIqyEa/FfckZfaAxNjuTdm4ZLDLN4GP6gjSlT6/NCbeAKAzjZAhySGPj44TTDHR+6XEK9Y6Zg5Zck2Q/CZDrwzqGNOQRwDa9zRQeoid8L7YURdIGcOqaqOINxwqt9wtDbepiCclHyYl8jIqXflIb5swCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105098; c=relaxed/simple;
	bh=DI3vXOs2FhFrx3JN5uzYaOYxEOMRWbXlYRHowN6BJ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWedph5MHiO9bxD8TTKs6Ml/p+tiroZ/8ez5XIJzQuhIibE77d0asS98ocDYSw5cBXplFY64QMfziPpJ7FXAi27j0JgNscT43wfmLMoqiknu/n0gQkdemooHT4U9KJGMQaJeoLN4vjRItTN1dn/QjXIprCrIEkcAbM3V04We/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaLFxaRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A48C4CEC5;
	Wed, 16 Oct 2024 18:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105097;
	bh=DI3vXOs2FhFrx3JN5uzYaOYxEOMRWbXlYRHowN6BJ1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FaLFxaRBwMouJqTGwQCi8Yd5NnSQSDeodJdyqNVUIn0NJp/d46McB2rselzO9Laze
	 m99l/Icwlm2YZho4RVZrZYGmwfmM38H6kNCGE6CfTWP3iCqVx9AiByZ4iBB5ykm/nU
	 wP9dkP0rAieddfzfLpRSY/kcaf+dJvnMbP2T8ALSlFrjl3IpuGzQ9QWxY9EWIAhRhl
	 9B/vlic1SnNh+Flbvyq0gwKBNb00AT2+zPRhhJ2okrs4uC2OHL0Dtg95UC/UOL6z7O
	 UdGXY8i6IjOaGQJoiLjcYUhkvgy4DagbBTMgXkEZXzoYkEkHgcqDlJJAbkTqAVbEqr
	 tJ4X+A0B4RaaQ==
Date: Wed, 16 Oct 2024 19:58:12 +0100
From: Simon Horman <horms@kernel.org>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>
Subject: Re: [PATCH net-next 1/1] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
Message-ID: <20241016185812.GN2162@kernel.org>
References: <20241014040521.24949-1-SkyLake.Huang@mediatek.com>
 <20241014081823.GL77519@kernel.org>
 <d2c24d063bea99be5380203ec4fafe3e4f0f9043.camel@mediatek.com>
 <20241016143431.GJ2162@kernel.org>
 <a498aca1ac932d66d38282fbfe614d927691ec01.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a498aca1ac932d66d38282fbfe614d927691ec01.camel@mediatek.com>

On Wed, Oct 16, 2024 at 04:25:14PM +0000, SkyLake Huang (黃啟澤) wrote:
> > I do think that would be best.
> > But if you strongly think otherwise I can try to review it as-is.
> 
> Hi Simon,
>   If this does cause trouble for reviewing, I can split it into a few
> patches:
> Patch 1: Fix spelling errors + reverse Xmas tree + remove unnecessary
> parens
> Patch 2: Shrink mtk-ge-soc.c line wrapping to 80 characters.
> Patch 3: Propagate error code correctly in cal_cycle() + FIELD_GET()
> change
> Patch 4: Fix multi functions with FIELD_PREP().
> 
>   Is this okay for you? Do I need to split them into more patches?

Yes, I think that is a good way to split things up.

