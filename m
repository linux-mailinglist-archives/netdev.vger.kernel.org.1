Return-Path: <netdev+bounces-250426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39827D2B050
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E2613012E8A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBCF344021;
	Fri, 16 Jan 2026 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpvOPjKL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6452857FC;
	Fri, 16 Jan 2026 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535633; cv=none; b=eTSvanfU9tutKcwOY0gW0wfYXXfoz1P97PfFiqKSQiv8xox7v3r4PzF59oA8vlXfqcSTpQmssocJvuHIw9utO+3b2ez+hxtBBXE8WqGvf///YJVmGZQUDEX8Im17H9m2+Q3wlSzrSamgRaRS4RMVVvUewXlXnvdGzB1+l0EXxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535633; c=relaxed/simple;
	bh=fcULW8yshL4lWkFyY9KfLsxw7N73/Vl7asBiwFY65zk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C6vSj1VCprx0I/soPqTmt5yn8NQhZ1OctvkdfmxK4H+hcZw4/XH1hvfWwU//Q5yYjYrdjkKBkqfsg5XSaHuYO7JtzVKBXAKIjFWS7JbyaIPnYCm1PBA2x77Qq9T5DhIbDsxS9NFsfUiSJ0LAZk3gjz1vZGflqk9dTrmg11oE9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpvOPjKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56669C116C6;
	Fri, 16 Jan 2026 03:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535633;
	bh=fcULW8yshL4lWkFyY9KfLsxw7N73/Vl7asBiwFY65zk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DpvOPjKLEQdSpdqB0ODjfToXwhI1Nc1Bikk1iYN3jdasCBh9Yeaem2tcX7J4JMV2e
	 4WXN0aCZW2OBi5cS5Fi34Cs2xJZVAHJ9P6/JNGVGWhMe2ZPz90ZsdM9iyNC/Tc/40t
	 ptb8ck3DZ1c0FYzNgKsjVg/vk8sLdgYAQrcRIl5TrwE4gCV40vyOTlR0AxQNuflOb4
	 9bqEz+ebzHXqnMXVp/dpjZK6H7PFFHTzW4Gt8yo4iAiPHk3bJL2Axv1Cjulw370dzn
	 JKJ4DSpunaEPmjRU/OPEL0IC6/5d5r1fs4Yw9oM/KeITKnyaRKgXSDewuvgk65Dbvt
	 h1kJLyrwIuRhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786CB380AA4C;
	Fri, 16 Jan 2026 03:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: sr9700: fix byte numbering in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853542503.73880.9350290605838337341.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:50:25 +0000
References: <20260113075327.85435-1-enelsonmoore@gmail.com>
In-Reply-To: <20260113075327.85435-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 23:53:21 -0800 you wrote:
> The comments describing the RX/TX headers and status response use
> a combination of 0- and 1-based indexing, leading to confusion. Correct
> the numbering and make it consistent. Also fix a typo "pm" for "pn".
> 
> This issue also existed in dm9601 and was fixed in commit 61189c78bda8
> ("dm9601: trivial comment fixes").
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: sr9700: fix byte numbering in comments
    https://git.kernel.org/netdev/net-next/c/acbe4a141e89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



