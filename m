Return-Path: <netdev+bounces-215071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186D9B2D0A0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F42372A8211
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44A137923;
	Wed, 20 Aug 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzOi18Az"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245314AA9;
	Wed, 20 Aug 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649197; cv=none; b=C7GA9ogCEsIJN8/rghLPbJ+a2d0jODzHnZm6CnbXT2nYskMOWKSF8jattAwaU7SXV1UplneIpKIdjIpmTuU2HrdwOeHzgAmbDbsjSwzPb1RUWMGuQ/xftsfox0AxEnhZCb+4/2KUqzvARJl5WUSosBwJXQD/97NLtLsQPl8yo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649197; c=relaxed/simple;
	bh=DFQuF+9gVHvauBVjTFYL7wS9dkyVumGk6PQbpSd7cAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g3JjJUCc02fKEXmJxSq7Tl30RujKpkJXxBqhM7OkMMHYZZcFeFRqEGa5OYTudsLWY6fUtngdZfmd6fttm+QKygcV3fCVW8Ii2EfDzz//Wj8vQ1hQOpI2HeNRtMLLSirG6+xVKwIbn2a/IkUpBAI1ebxjZkUebgKX+gMmR1buZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzOi18Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D28C4CEF1;
	Wed, 20 Aug 2025 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755649196;
	bh=DFQuF+9gVHvauBVjTFYL7wS9dkyVumGk6PQbpSd7cAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RzOi18AznHen6aIT/lXpW1Rw1VngHW2ApZi6HHTV5g4m8HmjMnSG+OaTI+BFx/Bjr
	 o1Q/nMpWYUmaGuGD53wz4tmp84G7SbPGKmOPF0wfY7wR462HIqRQktMFxQvLV5gADt
	 fXizUHYvMENjCJfO61++9uH1K2jbdWLKCRyTJDW640ALjVctVKLO2+vaDGTwB7ttXL
	 9P4frqKePTp3U2Rh9BVx4Dr2kWb43oEReMJ7qOJ4G2QDWE8WTaZELkB8woFR+On7NH
	 pLOC9RVgDN6b6EwuwqLp6fz/vPhAFvuGmV5fS7NTiI2pKWvj/mbhSRoYkyuAyh5tjp
	 KG5mjiG7vOoeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C63383BF58;
	Wed, 20 Aug 2025 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as
 WWAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175564920600.3741041.6447752879042143793.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 00:20:06 +0000
References: <20250814154214.250103-1-lkundrak@v3.sk>
In-Reply-To: <20250814154214.250103-1-lkundrak@v3.sk>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: oliver@neukum.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Aug 2025 17:42:14 +0200 you wrote:
> This lets NetworkManager/ModemManager know that this is a modem and
> needs to be connected first.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> To: Oliver Neukum <oliver@neukum.org>
> Cc: linux-usb@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as WWAN
    https://git.kernel.org/netdev/net/c/4a73a36cb704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



