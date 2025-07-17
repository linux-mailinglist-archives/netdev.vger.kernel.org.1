Return-Path: <netdev+bounces-207887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646CAB08E6D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4599F3AE02F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AF2EBDD0;
	Thu, 17 Jul 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUtfAx9m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6A2D6606;
	Thu, 17 Jul 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759593; cv=none; b=Dk/fzJhDs441/9V/8MyQDG/2UdLw8LqWgBm9u76je9PHBtOID/uo999SZT5jMcjxtbZ2Bv25d2iZDWO2oQtvRsXXO27a8QGPKDmMi/LC+C+VRpWcqhHPc5I0Z96SDtsnsoRcWjVkLS5zkNj1NeiaPTEO6/ke9jtA6R8QYpBMJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759593; c=relaxed/simple;
	bh=TqclGTTShZO4+jfTCBcVIhCy+UtsHn+i+aJUuf/0uNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zxd6DAzl/B+Ntc03OlFv+gp4WGnk2MqfjT+GkL1uZajQlLFqZpe+1vYNIWkMPrLHw7aaoHCeDYEaiOxqIKCC1YVzK7lz0+3QPY5vxfPnPNMxl6kVz/Q0zlvyKEwL1PzLIQIGSkXsSdqHea+hTrapJNd8ie+l6InW+x4pXWFnZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUtfAx9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DC5C4CEE3;
	Thu, 17 Jul 2025 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752759592;
	bh=TqclGTTShZO4+jfTCBcVIhCy+UtsHn+i+aJUuf/0uNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YUtfAx9mPHZu7aSDASu0lOPBX641xYZ4z2EcaoTj39Ga6WPZmIkWKCsFKPGoJTXVk
	 1sfaIJrDiGuQQ4oxp9392i52W29aDlVNtV5rUtziPvjp+9wMDV3z5uWYePBa0UC8x8
	 PTn81csh0wAUTENMFlhx6/xXp7Qj9nT8tAOsB7fe31OnGsHArehbWT/SuCDs5cYFxl
	 qcMO3pnHC2BSIRECcnaWFg5ff3+H4xEFHENU14Uk8RCQKUlt9lyYFMquxveTgw+T1j
	 6ilWdJca1cIoktiHFuRZsJLdScGRxqcO7ZWqCSZtNMAXSMnxJXCMi5nuL2+kEGUKDx
	 QfFZfqgEp1TDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFD383BF47;
	Thu, 17 Jul 2025 13:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] dpll: zl3073x: Add misc features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175275961274.1939134.3264961890974154099.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 13:40:12 +0000
References: <20250715144633.149156-1-ivecera@redhat.com>
In-Reply-To: <20250715144633.149156-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 Prathosh.Satish@microchip.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, mschmidt@redhat.com,
 poros@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Jul 2025 16:46:28 +0200 you wrote:
> Add several new features missing in initial submission:
> 
> * Embedded sync for both pin types
> * Phase offset reporting for connected input pin
> * Selectable phase offset monitoring (aka all inputs phase monitor)
> * Phase adjustments for both pin types
> * Fractional frequency offset reporting for input pins
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] dpll: zl3073x: Add support to get/set esync on pins
    https://git.kernel.org/netdev/net-next/c/634ca2cb06d2
  - [net-next,v2,2/5] dpll: zl3073x: Add support to get phase offset on connected input pin
    https://git.kernel.org/netdev/net-next/c/86ed4cd5fc0d
  - [net-next,v2,3/5] dpll: zl3073x: Implement phase offset monitor feature
    https://git.kernel.org/netdev/net-next/c/b7dbde2b82cc
  - [net-next,v2,4/5] dpll: zl3073x: Add support to adjust phase
    https://git.kernel.org/netdev/net-next/c/6287262f761e
  - [net-next,v2,5/5] dpll: zl3073x: Add support to get fractional frequency offset
    https://git.kernel.org/netdev/net-next/c/904c99ea36bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



