Return-Path: <netdev+bounces-143183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422899C15A1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F31B233EB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894591C6F4E;
	Fri,  8 Nov 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYTxawbD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F71CF29E
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041429; cv=none; b=LiY9WrApTgWVoucUZJQh1joMUuMe+pjnZVaempBZNDB3O65jQVPISuck8c5KuFqLyYFR6/fg63Nc9HAGBMy7D+J2ETnI6eOEv83JcVAnjZVuRtGW8FveMs/wVgwyT6VcckqQeqYINYXzfzsNI4/Pga0QGXCLSDLOk30J7/F4N4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041429; c=relaxed/simple;
	bh=B4nnxFVVZNVTXyceeJ/3x1pSemQiuAbz0gYMgZp6Nac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=go/UbWI11RjtiUGG6t2HK2Cr6gTiNcXXUykH2hlvhvmTjFnbEteWgf5Tn9wCFCDdqOdn/tWGQmqz5srbPJu51dtlYg3LGE45zV82/1KWkZIlGDxViDFMZQX48vWwvHXmePsKQls65h0pvDZw6d6ReZKP+zPuAN4PkKEJ96QThGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYTxawbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B34C4AF09;
	Fri,  8 Nov 2024 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731041428;
	bh=B4nnxFVVZNVTXyceeJ/3x1pSemQiuAbz0gYMgZp6Nac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XYTxawbDwJOA2jsA0n70UaRSBxD5+sg9DI1Rz0F95Xikx/iM1UJ43LGzTa9/pvAYo
	 qJinzbVGqdhLv3deY/uiXooL4wJ9uqN6X/IlC/S64DeB/OJHuslMZpa791ESXR8xqR
	 iuvu4qH7kLEg6Dy6iS5MXeJ5wkT4XRWdAcSqdQrnCZSGtmGjFt47Ta4nbu5GiuOZ9a
	 TKOhHZBBJJqpWu830Xb9wE9HKNeft95HfLtzTAsKSAux5U3GkGnpunMgedwNVU8X5B
	 u8EMx4kYcHUiKTOsgkbuKkVYh7VI+QwrTJ63Wb7CsEz5Hx2+8Px2f+oZkN5DFPIAEg
	 UOLVRjcc1IY2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711D03809A80;
	Fri,  8 Nov 2024 04:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] netlink: specs: Add neigh and rule YNL specs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173104143799.2196790.1518650944719093198.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 04:50:37 +0000
References: <20241106090718.64713-1-donald.hunter@gmail.com>
In-Reply-To: <20241106090718.64713-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@redhat.com, idosch@nvidia.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 09:07:16 +0000 you wrote:
> Add YNL specs for the FDB neighbour tables and FIB rules from the
> rtnelink families.
> 
> v2 -> v3:
>  - removed spurious dump parameter, thanks to Ido Schimmel
> 
> v1 -> v2:
>  - added 'dscp' attribute, thanks to Ido Schimmel
>  - fixed types in fib-rule-uid-range, thanks to Stanislav Fomichev
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] netlink: specs: Add a spec for neighbor tables in rtnetlink
    https://git.kernel.org/netdev/net-next/c/bc515ed06652
  - [net-next,v3,2/2] netlink: specs: Add a spec for FIB rule management
    https://git.kernel.org/netdev/net-next/c/a852e3c35641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



