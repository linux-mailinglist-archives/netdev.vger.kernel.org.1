Return-Path: <netdev+bounces-133328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B97995B01
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49035B22B7A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472921645E;
	Tue,  8 Oct 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH03uo0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16A21643E;
	Tue,  8 Oct 2024 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427294; cv=none; b=ZmngcYCPP4xhFEFOXRglSFFJSG0coe91wKmae+BlPeMUTrWr0rFlkLiP+Yu1ErJLUY/WTbmFOQVLqTUa61Fui8zDRoTH6anOKrzVC5pmT+VFPZ4z8HJgsoPEV6do8sC77ezia8hSpvqgfN04E7G0ijqLs5KQHcVNR/bfVwjk8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427294; c=relaxed/simple;
	bh=raM/mlhM4VorvND0Esv5fHFvDT+jxGtEgsukLDJ91MI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G1QIeakP4EgcJLyt6Q/OVNkaCKNJWWywrQC5pIdbOiBi67tZd3LuvocmVNBEqZmzoNiJPErGtQxGpp99yViTn4JErYERpXkExj9Z+80zd1JmkbS7NeQfyHQrLVwl0xSv0daZYHK0j1mSp4h7leFIQYgBa6e7wTDuwZEXJPrEUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH03uo0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E9AC4CEC7;
	Tue,  8 Oct 2024 22:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728427294;
	bh=raM/mlhM4VorvND0Esv5fHFvDT+jxGtEgsukLDJ91MI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PH03uo0ECwfYeNrM9HjzRsuKYXzT3tJJNIZfngPfsCPY73lOXkl46Z9OKIQsc+AwP
	 rcD4qjSJQsgXcBXHVSgRSvfFtADGICoc3zjn4gfF5npQPYXz7AH3THaqfL74FG9g2g
	 kqPex01wN1SMUxPOU9/aI676xC4FjBjpauyNokp7CqoDTyGagkcar9noycWNYpUtA2
	 wl4WJbiM4xyeec1f+iaG3254aHPdkQwR4hSbp1W0/AoWR5F7albPWI8c+qATYeIFNa
	 +Frf9R1X+IJDwR5J1naZ7VlV3d8gWglrz6wt2wuDTbESsFky/Sgy7mOd5bmML642wg
	 BCevMmW50s7Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C9CB53A8D14D;
	Tue,  8 Oct 2024 22:41:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add FID map cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172842729875.704916.15514639822183276622.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 22:41:38 +0000
References: <20241006212905.3142976-1-aryan.srivastava@alliedtelesis.co.nz>
In-Reply-To: <20241006212905.3142976-1-aryan.srivastava@alliedtelesis.co.nz>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, kabel@kernel.org, kuba@kernel.org, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 10:29:05 +1300 you wrote:
> Add a cached FID bitmap. This mitigates the need to walk all VTU entries
> to find the next free FID.
> 
> When flushing the VTU (during init), zero the FID bitmap. Use and
> manipulate this bitmap from now on, instead of reading HW for the FID
> map.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: mv88e6xxx: Add FID map cache
    https://git.kernel.org/netdev/net-next/c/ada5c3229b32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



