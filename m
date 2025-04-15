Return-Path: <netdev+bounces-182653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF50A897FE
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6F916BA5A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484781DBB03;
	Tue, 15 Apr 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmv5Mnzc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6E1D47AD
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709412; cv=none; b=cU4v5FTBPhZ9RLelS6d9370+lUqH/pViTzeCGZnHar6R/9VbxclRoy75z/3InSitDSZBx/3pMa858kBMyEsBxNacQLnhud8LaVyyjpT1fy+XT580WTIsEoUO1NKz7el+Kxpa5ZqGKobKglWO/buLOyHZkjfTB3PI2VXTsoQqnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709412; c=relaxed/simple;
	bh=l+88SWgtJOVnJuladrxD8b80ktPYtCakBo5UVW6Tqn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XgnXBB6G7ISOjDLVg7+jlMZ+w8O7L8JSOl54frklecouWymlTKHmtKJ3QiQQeuAm46CNypt5aaCN2nCtRaCKfaQq290gCp/gns9XK5MBeOEWfROcsAjEOOvUSVRF4hipn9MH0fNAsJKYPpF+mBCwfwz13f5KtDBBdjKhG4BP8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmv5Mnzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D1C4CEDD;
	Tue, 15 Apr 2025 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744709410;
	bh=l+88SWgtJOVnJuladrxD8b80ktPYtCakBo5UVW6Tqn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mmv5MnzcekiDfy38zilO/UIfayIBPp+gFb6xSfJ2HLrfzIVg8PYORBsfYnlZ+VStC
	 M41MRYZI6i3pOkad89FhBHhBqDXI/oYK1GSd8DjQcOnh2O1S7Ni4qwBZV8TeSU7MCV
	 8QvBDfWD924mPBrvEPOMOrhzP0Pul4W2162nMP1+73+2ow89hyw5lPEiCGRL0KoWWt
	 jkRi6H+MPKfb1/bb0VhQZ9jgc5t6Xe20ctkqDlHDPm8RajoOhA9sPINKWji10c0ZEP
	 oGBddr76nVs3TuPOYAmyGX8c2XGqU8mUMRp3pWVMqa8v/eHUxZ+whFWMByx4uZ226J
	 izvdShqSSN66g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0C3822D55;
	Tue, 15 Apr 2025 09:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5 V2] eth: fbnic: extend hardware stats coverage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174470944858.2555550.16908319297941089764.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 09:30:48 +0000
References: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jdamato@fastly.com,
 kalesh-anakkur.purayil@broadcom.com, kernel-team@meta.com, pabeni@redhat.com,
 richardcochran@gmail.com, sanman.p211993@gmail.com, sdf@fomichev.me,
 vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Apr 2025 00:08:54 -0700 you wrote:
> This patch series extends the coverage for hardware stats reported via
> `ethtool -S`, queue API, and rtnl link stats. The patchset is organized
> as follow:
> 
> - The first patch adds locking support to protect hardware stats.
> - The second patch provides coverage to the hardware queue stats.
> - The third patch covers the RX buffer related stats.
> - The fourth patch covers the TMI (TX MAC Interface) stats.
> - The last patch cover the TTI (TX TEI Interface) stats.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5,V2] eth: fbnic: add locking support for hw stats
    https://git.kernel.org/netdev/net-next/c/9f61eb2d185b
  - [net-next,2/5,V2] eth: fbnic: add coverage for hw queue stats
    https://git.kernel.org/netdev/net-next/c/8f20a2bfa4b7
  - [net-next,3/5,V2] eth: fbnic: add coverage for RXB stats
    https://git.kernel.org/netdev/net-next/c/986c63a0295e
  - [net-next,4/5,V2] eth: fbnic: add support for TMI stats
    https://git.kernel.org/netdev/net-next/c/5f8bd2ce8269
  - [net-next,5/5,V2] eth: fbnic: add support for TTI HW stats
    https://git.kernel.org/netdev/net-next/c/f2957147ae7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



