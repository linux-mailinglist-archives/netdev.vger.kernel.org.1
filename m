Return-Path: <netdev+bounces-171832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14DA4EEC1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BB318861B5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82A25290A;
	Tue,  4 Mar 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOxgv0LM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD0156C76
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121399; cv=none; b=iGZz1Hkl2V1UGZY6MQGkBEDiRaTm5i/mG8cxXChiGIG+sMqKztw2F+//ajT339I0ZkgklGiyhqhsfW373xM2PwJdT7aEmDj4vo2mzhhcsIDmHnDUv8PpfbRAX0I1b4h3n5hMpKAF2KHwxsEdD1dYf8xeLyNWiuAMfIgIsr51JHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121399; c=relaxed/simple;
	bh=QM9bYeDl2rCbCd+OzCl3JkUGHYBC/3VFPIveW126hiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lj0+u7VRI7TiSP1Cj+idpd+FMqxiEBoepN4odyEGi3k9fqpZK6U7KeTqx++IOYBwgydabIWw61f+Yp/Ka7/kf9oz/NyEBoLFZym7f3sMJf14L2SBD1w2SXHzSxqPRikhODGL1mIrUtk4/p9fEQpb574MfA7bJI+c5vi44QUwPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOxgv0LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D81CC4CEE5;
	Tue,  4 Mar 2025 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741121399;
	bh=QM9bYeDl2rCbCd+OzCl3JkUGHYBC/3VFPIveW126hiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOxgv0LMm/6QnmrDpjWGRKnaTktZGYVrsc/R+grIwDxsfHb44qVbT1TMDwc/702FC
	 urpOVEAERReuYNc0twpghu7sPMOQl+MZmZrtZA6U2EwPtORT/m5SLuU7NgCzH/eVO3
	 00EhZdn6zb5bjD3MoNckHa4ELmQVs7Ta+QR2PEYZmZskMWkNYn0nNYjuxGVQwHaI5n
	 o8qdyRJL6ERNJY2JjxNIl/YY8I862TAW4/smHzcMXB+5Gng1hNaazZL7Xoz02x20ax
	 Bh4bxLMMEzgsMpsc70GzXa36qZ9cxCpTiJndPPYhOmQXcsBT6ccwvH97JYJyVP+DTU
	 d6036LPPuFc8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71812380CEF6;
	Tue,  4 Mar 2025 20:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] Add OVN to rt_protos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174112143226.288499.7061017585436282969.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 20:50:32 +0000
References: <Z77szIaLjeMSNJP3@SIT-SDELAP4051.int.lidl.net>
In-Reply-To: <Z77szIaLjeMSNJP3@SIT-SDELAP4051.int.lidl.net>
To: Felix Huettner <felix.huettner@stackit.cloud>
Cc: netdev@vger.kernel.org, jonas.gottlieb@stackit.cloud

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 26 Feb 2025 11:28:28 +0100 you wrote:
> From: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
> 
> - OVN is using ID 84 for routes it installs
> - Kernel has accepted 84 in `rtnetlink.h`
> - For more information: https://github.com/ovn-org/ovn
> 
> Signed-off-by: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] Add OVN to rt_protos
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=131810fb264f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



