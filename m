Return-Path: <netdev+bounces-182501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D24BA88E8A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B52166F94
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D11F3B8B;
	Mon, 14 Apr 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl52Bnem"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD601DEFDB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667426; cv=none; b=U1+WSpzxAr6Ff2Q65lTdhL6/b+YyzIvGakt9pDvdXUhv06KeOgpfGWJuhm5QW8JTwKVKdymRoKkf0PpNSffoZjJCIk2XoAFUyN5528oA122Cu1k3pnSHwe+D7lr5xnOzw4XwTK9YWbxw8pKhaCcgA6mf3x/Cl1tkeC3J3JWMbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667426; c=relaxed/simple;
	bh=5qTNGT2ndNEx2I689qvJvmb6Qjp9I35HVUyG3aIm6qA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G2/IMltoVKDnDbs3+IerQiHH3JZYsX2LSQZ+IQA9FfQ0zZla3iAauFgU3SMoYlek/YHnDDjlBXl7ccPe2870raieGZsl+YBQhRyXUa1uFsTqW1IuGH2aiPJ+h826scQjo4nsgwp2lr7gCq7uFdGO8IAiLPq+RffypY+J4kfhF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl52Bnem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929D5C4CEE5;
	Mon, 14 Apr 2025 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744667425;
	bh=5qTNGT2ndNEx2I689qvJvmb6Qjp9I35HVUyG3aIm6qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kl52BnemfyPuwALn9KiH7OP2cW3/iYDAkf9ncE6csJlSTrXgKg68NPLvvzW6mUiGI
	 1yYTQxfIDkOI5kC4hOAdJUbTSNr5iiN+hD3Abd1dOQWsaVFN3YVI2x8OdNiAdiz5Kr
	 nHGNewb2YRQv8KhfJXz4NFSFARMa7BqzECdlYbBizcI/xS/VzZM04d9P2W3welgsep
	 hKjipfV2ZrFiNLBG2peEHF8plbHBFG8YlF/EYF6cJi3MebX1Fe/UUNJrb+cPAR6wIV
	 yLhtYeZRMFfNinGuPairxI3uuU3aDP5uCWAfPUU7HUSCNT30Ys3LZkC17CPwlWi9P8
	 moqP/gsm28M1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB933822D1A;
	Mon, 14 Apr 2025 21:51:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: ovs_vport: align with C codegen
 capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174466746343.2047719.8418124222059114864.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 21:51:03 +0000
References: <20250409145541.580674-1-kuba@kernel.org>
In-Reply-To: <20250409145541.580674-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 07:55:41 -0700 you wrote:
> We started generating C code for OvS a while back, but actually
> C codegen only supports fixed headers specified at the family
> level right now (schema also allows specifying them per op).
> ovs_flow and ovs_datapath already specify the fixed header
> at the family level but ovs_vport does it per op.
> Move the property, all ops use the same header.
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: ovs_vport: align with C codegen capabilities
    https://git.kernel.org/netdev/net/c/747fb8413aaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



