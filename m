Return-Path: <netdev+bounces-214244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1106B289B3
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8EC3B5CFB
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09FC15624D;
	Sat, 16 Aug 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8ENgSOX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7D72622
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309003; cv=none; b=pB3S3ZiVRgmdU5vQE33FXf8E8HjvOvx67bTDbgow6wbc1pLN07wW736elbeNEVe2BeD3d/YlrKYLOkcBFlU4AJVMAYFHVDU9D3+Gkc/5ZASVN494hrFWX0GcZDgOqKj/qy6whd0POcIlgd7ldSF3gfbjynfJLlSa31t/DEA19hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309003; c=relaxed/simple;
	bh=NUeLcI7trZzUy7CFTZa1YoXQgracuZw120oU+97GdoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S/L4xqdrJsvtR6gwVYZne64kWAWRp0emF2Aa9n3Ws6v9V2+W6TGO3O4Jr88XEicGgS0qwb6qtsiloXjh/RuqKzJGXeHu8KOftcu6XhxRBID1S4N4bzEqJQBv1u7Isv/W7EZJtitJoNosRYetg2gJqm4qRpsb1ekCQjdE4yXYAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8ENgSOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF4DC4CEEB;
	Sat, 16 Aug 2025 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755309003;
	bh=NUeLcI7trZzUy7CFTZa1YoXQgracuZw120oU+97GdoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y8ENgSOXRGIxInZ0eS13dTO1I7RMdvj1CKtzyAJgW1Ll+1amuLSlxLDmzTJU3t34w
	 8VCo5tDzfH1Z0W6R8CQ2Xbino5Z2caERjuHI7cQPGAPYZPx/v4/P6N+kkj0oghbxWV
	 7shfcY/91+ZEKPCPivtXeTnZTtoivuOGiyrMH7oQIjlH2dXsyLv5mqV/8IkFTzDZtA
	 uSydNej6JnHclahgNoEJg5Zn+pZedmcl6TOT/a+Dg/60Yp/juX8yHi+tetXFSXFBmW
	 04E7+Ku2Cq6N1PTiA/RLgNXPRiLmvE7cIqu2GeBi1P6Rj1HB0MJoHNTp0a4bVs1whk
	 hUOtUgv9UErpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE039D0C3D;
	Sat, 16 Aug 2025 01:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] ice: implement SRIOV VF
 Active-Active LAG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175530901425.1336593.16019070068904989473.git-patchwork-notify@kernel.org>
Date: Sat, 16 Aug 2025 01:50:14 +0000
References: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 david.m.ertman@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 14 Aug 2025 16:08:47 -0700 you wrote:
> Dave Ertman says:
> 
> Implement support for SRIOV VFs over an Active-Active link aggregate.
> The same restrictions apply as are in place for the support of
> Active-Backup bonds.
> 
> - the two interfaces must be on the same NIC
> - the FW LLDP engine needs to be disabled
> - the DDP package that supports VF LAG must be loaded on device
> - the two interfaces must have the same QoS config
> - only the first interface added to the bond will have VF support
> - the interface with VFs must be in switchdev mode
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ice: Remove casts on void pointers in LAG code
    https://git.kernel.org/netdev/net-next/c/ba7fad179699
  - [net-next,2/7] ice: replace u8 elements with bool where appropriate
    https://git.kernel.org/netdev/net-next/c/5b35b83d0d75
  - [net-next,3/7] ice: Add driver specific prefix to LAG defines
    https://git.kernel.org/netdev/net-next/c/a66b3b537d21
  - [net-next,4/7] ice: move LAG function in code to prepare for Active-Active
    https://git.kernel.org/netdev/net-next/c/b2e97152df79
  - [net-next,5/7] ice: Cleanup variable initialization in LAG code
    https://git.kernel.org/netdev/net-next/c/148c8cb32b2f
  - [net-next,6/7] ice: cleanup capabilities evaluation
    https://git.kernel.org/netdev/net-next/c/fb2f2a86f0cd
  - [net-next,7/7] ice: Implement support for SRIOV VFs across Active/Active bonds
    https://git.kernel.org/netdev/net-next/c/28f073b38372

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



