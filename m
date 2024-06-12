Return-Path: <netdev+bounces-102773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D246904901
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E1F1C2108B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD09B651;
	Wed, 12 Jun 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCvRs1zP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE584A3F;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159431; cv=none; b=ETzdfnMY7UmvgLSyJmpaJQmIUh1EDVDwvogsVaHPFo1wns2PFSCWLpqeGOdG0i/P/4eqPiWtF76gvZgq/Vocs1tdtYnsqEwrpeW6h0ViBfMekw01Sm/Y6A7MSzcY6GG/sHZP8GuZIfBAbCXgubI41NTzNsvZMwuTygVePYz8vxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159431; c=relaxed/simple;
	bh=pKpI39iBovXdgdRsYICuKhODnQY2dmmn8Dzzk41tlT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mAMZVYp2JQJqssYxObCrQM0p96qW4z7dBMa72QLPGtEkXZEnF2f+wYHWTHdkEMLqqFk4yS3yFLwqcNmXf5QHu9IVG7DZY15yuUa86fBK35AkKNt7mE1Wy7LWdI4TfNai7Z3PGiUxjdGazsT0V3uQKZw20YLiDV306jDAPhU4z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCvRs1zP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 420F5C32789;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159430;
	bh=pKpI39iBovXdgdRsYICuKhODnQY2dmmn8Dzzk41tlT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCvRs1zP15kDjrKVC76+STyzd6nLRulStnbtY3HG0ju0QwJC/qV6Hw+rhbYnp7DJi
	 g6PyV0eM6LoyM+17I4PulfLkPlttvHifj78ffz3DThQiOW61L4xoAHeW8PhbTcXNgH
	 BHYtylBOKo3QV7VEz4pDbVF49PEQ2fKTo3NCiWyx6A76naTWtJ/RPZDI/xtoppvwy+
	 7AzD8+IQOQTiH3RGbwr0I8UEI8Vr8hw9dWMdKd6vNk1coA/qopxX7JHJCziL3a/+bc
	 WqmiTNpsJOZm/572stYvBi/FC48tO6zrVaUG4SiFBkNBugSQO7r92AIE+7EL3st5N1
	 ByCrnNrUQS6XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28FBFC43614;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: Fix typo in NET_DSA_TAG_RTL4_A Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171815943016.29023.10648003717964902246.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 02:30:30 +0000
References: <20240607020843.1380735-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240607020843.1380735-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 14:08:43 +1200 you wrote:
> Fix a minor typo in the help text for the NET_DSA_TAG_RTL4_A config
> option.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  net/dsa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: dsa: Fix typo in NET_DSA_TAG_RTL4_A Kconfig
    https://git.kernel.org/netdev/net-next/c/983e44f0ee00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



