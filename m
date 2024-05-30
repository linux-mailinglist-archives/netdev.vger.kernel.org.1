Return-Path: <netdev+bounces-99223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B18D426C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957F8B22EFD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF88C06;
	Thu, 30 May 2024 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="addJ60m3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8E8814
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717029631; cv=none; b=jjcB0hTGCP/C1m7M/FintEWIvdwIh1uSZA8DyMaqk2gLlE4mSfa/4nCtPDZOiXA5LQhm4WNfOVOWUuT1p0cEOFUz4iW+jHgufzKG1bv3CQQMCw2ZA62cZOkEHqOpAMZW+m6MY2h8/4+Dg3Q5dSc6dH2J/Xtkl+s1oXLciVpTsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717029631; c=relaxed/simple;
	bh=Q6q9YU3biXxibAWrsAr2tGiUyS25FG9GSw3CXDdSxQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qw7tYU6ahHxXwF41BXFXE1BPZkjbtiq+VXgOLH8ofDl52zejzFM8gvj/FuA46mTCEYIZr2N044zu3P8d0k5ZBXuFbQfeTsxa6+cHQ+bLBQTjZTGo9l4M2VmBuP6dWXAhsJaWoR6d71GRBB3davmbgUSXgsGZ1KyPI9ovjLbQxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=addJ60m3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D55BC32782;
	Thu, 30 May 2024 00:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717029630;
	bh=Q6q9YU3biXxibAWrsAr2tGiUyS25FG9GSw3CXDdSxQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=addJ60m3bXnDmI/4oLrPWcztb4VGMW8XyG8hi3qFlz4UCwf5U7FXBeIQ7XdHMw4an
	 1mXHIJBMPkKgdz1mXKCiokLDURKDUMoVU2pp7IebxI4vIqsq5Lvagj5e51rh0dKFsC
	 XhPS4sVRXaMrLfUWWLeldmrV8dtVoqVIFSqw+8p7uwpV8CW0hfQVHwtZ6pgMBt0hDO
	 S2PZYouEJFc6GptvCGnFF1HY2ZnujLn7z8mVDiciJnb+CPFnXWPE5ccX2bl4zEF92F
	 8ac265NY3BiHRigWfdk+TNY3Eeoiqg8km1wiXJ+MIKlnVjw7KK/oc2ZBtcdpDxVB8q
	 QZUXmM8vS62PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49DA7D40190;
	Thu, 30 May 2024 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: ethernet: ti: am65-cpsw-nuss: support
 stacked switches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171702963029.23871.907831153377572719.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 00:40:30 +0000
References: <20240528075954.3608118-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20240528075954.3608118-1-alexander.sverdlin@siemens.com>
To: A. Sverdlin <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, rogerq@kernel.org, grygorii.strashko@ti.com,
 c-vankar@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 09:59:48 +0200 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Currently an external Ethernet switch connected to a am65-cpsw-nuss CPU
> port will not be probed successfully because of_find_net_device_by_node()
> will not be able to find the netdev of the CPU port.
> 
> It's necessary to populate of_node of the struct device for the
> am65-cpsw-nuss ports. DT nodes of the ports are already stored in per-port
> private data, but because of some legacy reasons the naming ("phy_node")
> was misleading.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: ethernet: ti: am65-cpsw-nuss: rename phy_node -> port_np
    https://git.kernel.org/netdev/net-next/c/78269025e192
  - [net-next,2/2] net: ethernet: ti: am65-cpsw-nuss: populate netdev of_node
    https://git.kernel.org/netdev/net-next/c/29c71bf2a05a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



