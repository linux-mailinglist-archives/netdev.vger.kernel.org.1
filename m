Return-Path: <netdev+bounces-109089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CC5926D89
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A931C20E02
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8899FC02;
	Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rveda8gD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374517543
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060829; cv=none; b=eMKWkJeSfQn/LhSA7SFysXrrty8uN1Ut5JNjVmMsSklu/1F0AGoOGp0Xq958KwQXrwE/OGT1vR6bcTqQtrZJIdrMdEEKYsEMoEgfn7BpSnyc78XrRjc0HN3T4CtJdW1Y8BIwTbNCAj51GOKqjiMQfeYdaF2quE+cKJ6gSYComoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060829; c=relaxed/simple;
	bh=bp9st4QS2tJ9r7hD1G8amVRkD7w0Jtm5BEcxeqZg+0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=swCvA7J1MvFW/CLLwHRgNhpBAWv+9U3r3D5iQwxYl0WplrV5gCCAJrfJR3Twrou+xR5OD5SIR2GWtmoqOwRldiok17K5W6cFerNR7BP9ylAZ2KaFXcxdSS3jWDXrIq64ZcCrXE3pzsSLFtQggD6CoGaTC/fvodB8LMNZzrqvOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rveda8gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B80DC4AF07;
	Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720060829;
	bh=bp9st4QS2tJ9r7hD1G8amVRkD7w0Jtm5BEcxeqZg+0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rveda8gDtSbK7Z7bxrcc5W6M22v1oGvbnEUqMYcTQ6nqQ4WNc3pIP89wK082d3M2S
	 e0YyrcbYgUAGZs4q+AHj3iGZqJfHzAQIIeiP7RY/OqTnHduCTdje4j5vZnO0tCbL+8
	 wREeDSpE8kU0DTojdSB0/fIbIpbO+LhKS9UyFAqvIiRn6U/UyfTyt1bxf/vGsCgRT/
	 m9n9gt2nisQodBAtuym+OoXVGnT5QQMFdE/SlOnJH2TnSbSveSBl0oVrCWvBS+gz08
	 74nBM4yseGXJMVMwPsw7OytWUkzIKhm8/NFHYmWkeW+06WsKQL4RyEhd7Cnb7CdqMI
	 CKEhRuhRd6ntw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ABDBC43446;
	Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: fix compat with old RSS context API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006082904.10999.3101326452343638462.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:40:29 +0000
References: <20240702164157.4018425-1-kuba@kernel.org>
In-Reply-To: <20240702164157.4018425-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com, andrew@lunn.ch,
 ecree.xilinx@gmail.com, ahmed.zaki@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jul 2024 09:41:57 -0700 you wrote:
> Device driver gets access to rxfh_dev, while rxfh is just a local
> copy of user space params. We need to check what RSS context ID
> driver assigned in rxfh_dev, not rxfh.
> 
> Using rxfh leads to trying to store all contexts at index 0xffffffff.
> From the user perspective it leads to "driver chose duplicate ID"
> warnings when second context is added and inability to access any
> contexts even tho they were successfully created - xa_load() for
> the actual context ID will return NULL, and syscall will return -ENOENT.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: fix compat with old RSS context API
    https://git.kernel.org/netdev/net-next/c/1a16cdf77e0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



