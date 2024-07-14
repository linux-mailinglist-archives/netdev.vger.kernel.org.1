Return-Path: <netdev+bounces-111348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05789930A73
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C43B1F2125F
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203F41AAC;
	Sun, 14 Jul 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEjGpkqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE91C68D
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720969556; cv=none; b=J89QjwOtfLpO57APoXpL9/YNd2mPUu++ZkDI57LpX6g78KuF3FeZZiSAMAs0eS3+pQ6UVWwo4wJfrmWxSt6tdeIX8VQ3NUs3JO6ya5mC8RD1XyLpT0fvOV2SNQ4ucwxu5ej0dNRk4h7oW3tjmyVfU1XqK3tsDkDiS82gg0+pMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720969556; c=relaxed/simple;
	bh=OcilRDSgHzP9m7JOvXvEqJtgQZc/+G/blo1Cph4V0A4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf2zOi6ZuGofLbJNG7ufDPHtlCQ43uhNB2VWYZs4U13/Ait1K2XRsuwAyz+NizH5wk/dfQlypgtRyO5XQLAlJer69+wALqLejgT3Lj1rA7aQw6TH0K8cSKewIA8zBhZ0EqNiCV9ya+M6wmLDZTFzCHgI++NAZu0BesMazuKCGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEjGpkqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24A7C116B1;
	Sun, 14 Jul 2024 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720969556;
	bh=OcilRDSgHzP9m7JOvXvEqJtgQZc/+G/blo1Cph4V0A4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lEjGpkqYjHi3WKq5NFsnlXXGlmrSEVYaihgGRK+TX8rAb1wQ7aPIT6QRcR+drzFN+
	 nxZw/lV1gvMpsdhTCHAyTWQEYvJ8kf0lwZaUvBh/6si6L1FJmFg7sciP3nbaliwU3B
	 ol7QcMLUAys1oKsadXEOUeVyOfagd5sGOFz+ZaYPl1pvkYDeh41W66XxelXwNVwa0+
	 PmBOC4zXHywHa6Zucf1mzZrAWgIb0y+vIlSqe0OlqB8dg4+2Z8vff8c0uqvIt9Pawa
	 uMbSSnZgG2UVXJwsmIVMEXkIrvzXPVeC2/ad0vE53lrglXVi2akrgRvaoZN4nD+W2c
	 lmvzwDglsImlg==
Date: Sun, 14 Jul 2024 08:05:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH] [net,v2] net: wwan: t7xx: add support for Dell DW5933e
Message-ID: <20240714080549.4ae15f36@kernel.org>
In-Reply-To: <20240711060959.61908-1-wojackbb@gmail.com>
References: <20240711060959.61908-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 14:09:59 +0800 wojackbb@gmail.com wrote:
> From: jackbb_wu <wojackbb@gmail.com>
> 
> add support for Dell DW5933e (0x14c0, 0x4d75)
> 
> Signed-off-by: Jack Wu <wojackbb@gmail.com>

Please change the name in the "From" field as well
(you have to update it in the commit, git commit --amend --reset-author)
-- 
pw-bot: cr

