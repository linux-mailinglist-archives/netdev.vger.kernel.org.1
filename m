Return-Path: <netdev+bounces-236856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B1C40C84
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BD5188F79B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FA2D7DFF;
	Fri,  7 Nov 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryG8EX6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE501A262D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531834; cv=none; b=eVOFCH4Ci0nfr34ynZhA/vQTTDCh5Q2EArBmWypzaNB4+rXp51IzncA9RACHh8n4PEd1WK5JOKywMmzHeEL2shs7bhMZlC8/+88+H86SmLYvojZn1hPLogHnnmFkswSkK4otH5etAWcMM8s6bpb4ozlJkc7UcrqgS2Iuz6ZkV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531834; c=relaxed/simple;
	bh=sGOem1m7OhwimK4RF1V2mAnRHqw8+4zwmoFZ02G+4FM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vqn6dJxCznxwpgK3fkSgXAgdjvMesDYsvaCg/mjEroKtYZzjXIGHpjBFVIZNfNnvUbyeRNSB9osW3ngDN+WNaZ93SEtrZeC/WPh90GAZQSWijiad+FBM0I0425dyzvr6O7MPfnzEE/GC61BepF0uXkGTiUkJgUSx2wrV7RIq+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryG8EX6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF69C4CEF5;
	Fri,  7 Nov 2025 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531834;
	bh=sGOem1m7OhwimK4RF1V2mAnRHqw8+4zwmoFZ02G+4FM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ryG8EX6ZnCM3hn2jK0lWPSRCgOCIraEf0QhbrKF32jfmXiTobsjTdryvrSomTDmec
	 MtXX1PktNN4zB9uFxCZzCiRpog7FTLgmaNOx9AD0C0lgOsMmbT7yERHPZVZErEPW4s
	 idKwpL2YztB6zDKuMkxumXx9UEBn7ncYlMA79xkCG+fcMnrvU26tsH+DbMozkxo1sv
	 5k2oXNIM+vnoTyRowM91wgTOsOXYRpn1AfYnJV5bq+R2ZOPCsEdO8biAGmT1HNSTwP
	 jMI4sVabzJ6SE7XSYs2iDREYOiuO2F9tDm11ss2Brx9PHI/WXCcPTK6hrfW/dpj9So
	 TPHe7p2MeYomw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2C439EFFCF;
	Fri,  7 Nov 2025 16:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] tools: ynl: turn the page-pool sample into a
 real tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176253180650.1079535.5744220053432172276.git-patchwork-notify@kernel.org>
Date: Fri, 07 Nov 2025 16:10:06 +0000
References: <20251104232348.1954349-1-kuba@kernel.org>
In-Reply-To: <20251104232348.1954349-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Nov 2025 15:23:43 -0800 you wrote:
> The page-pool YNL sample is quite useful. It's helps calculate
> recycling rate and memory consumption. Since we still haven't
> figured out a way to integrate with iproute2 (not for the lack
> of thinking how to solve it) - create a ynltool command in ynl.
> 
> Add page-pool and qstats support.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] netlink: specs: netdev add missing stats to qstat-get
    https://git.kernel.org/netdev/net-next/c/c6934c4e049c
  - [net-next,2/5] tools: ynltool: create skeleton for the C command
    (no matching commit)
  - [net-next,3/5] tools: ynltool: add page-pool stats
    (no matching commit)
  - [net-next,4/5] tools: ynltool: add qstats support
    (no matching commit)
  - [net-next,5/5] tools: ynltool: add traffic distribution balance
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



