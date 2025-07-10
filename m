Return-Path: <netdev+bounces-205608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA1AFF680
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC4E5A5C77
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E727E7CF;
	Thu, 10 Jul 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se0Qf2AK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69D2D78A
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752112203; cv=none; b=e4cwC2r4iw39K8tT/8HMBlKxVyVAivw2X0/FX36x/5Z1Cj8eXsY2qXYiPMdGjX/UYzsAfeHFRYPiHPBdWZ/Ei8830KeM4sFX0REcMGa2Fqj8Nb/aV++M7N+T8zhOdL610XhnzteeIUS3ViqlPU7TQHn0CAF6uBlvO64Tu24svvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752112203; c=relaxed/simple;
	bh=K6pQ4XrkUWHo97uLv6k+x9FoaN/bZFI/7F3Pc8AaV7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xv7lUW41iOf6YgtbEQDodqj9p/zZ/Tagavu00E3DfU22y56K4yfFmnOMl8wUSAdJ1WBkBEra7usm7YZYdE04Skh3nXKV7KCrYDalYp390dAcqwNVFHdBhuS0TPp0ej/WFuvbD5jgS35crguZmiXFcvUMLEHOJwv08jtxQywWPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se0Qf2AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDDEC4CEEF;
	Thu, 10 Jul 2025 01:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752112202;
	bh=K6pQ4XrkUWHo97uLv6k+x9FoaN/bZFI/7F3Pc8AaV7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Se0Qf2AKaOB1rOf9rZ/pmZJSAVikJtlDM05Kxoxe63JiF6IWTySgIQsAMw6fNS2l9
	 qurrNt1+KuDeELEGlVlvHOKv/kUapK6TNIfZQqSW0qRZxeWFd+Qzlpg0Wd+Y4cHxmR
	 oktf0JsFO0yrdov389J1Na1BlKbFtwKE6hgstfSHFDmZ7P+/BJxKlekrnX1pQeKMvu
	 mFXq3OAcHiGod4RAvh+7bEK3RHwYgp0XzaVZrllrIsI9Zj8mE1vc9g59EXwuB5QzS6
	 /RnxFHZtOnfFzrxpIIzJ+KY1y7kb188B3hHqk6oGrMlsKRkuT+pTDsEg1Kw5mG4tOs
	 YXcSVd9orRDAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7E383B261;
	Thu, 10 Jul 2025 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/12] Add vf drivers for wangxun virtual
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211222501.955880.5880493276955983984.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 01:50:25 +0000
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
In-Reply-To: <20250704094923.652-1-mengyuanlou@net-swift.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 duanqiangwen@net-swift.com, linglingzhang@trustnetic.com,
 jiawenwu@trustnetic.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Jul 2025 17:49:11 +0800 you wrote:
> Introduces basic support for Wangxun’s virtual function (VF) network
> drivers, specifically txgbevf and ngbevf. These drivers provide SR-IOV
> VF functionality for Wangxun 10/25/40G network devices.
> The first three patches add common APIs for Wangxun VF drivers, including
> mailbox communication and shared initialization logic.These abstractions
> are placed in libwx to reduce duplication across VF drivers.
> Patches 4–8 introduce the txgbevf driver, including:
> PCI device initialization, Hardware reset, Interrupt setup, Rx/Tx datapath
> implementation and link status changeing flow.
> Patches 9–12 implement the ngbevf driver, mirroring the functionality
> added in txgbevf.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/12] net: libwx: add mailbox api for wangxun vf drivers
    https://git.kernel.org/netdev/net-next/c/8259946e6703
  - [net-next,v3,02/12] net: libwx: add base vf api for vf drivers
    https://git.kernel.org/netdev/net-next/c/ba3b8490bc2e
  - [net-next,v3,03/12] net: libwx: add wangxun vf common api
    https://git.kernel.org/netdev/net-next/c/eb4898fde1de
  - [net-next,v3,04/12] net: wangxun: add txgbevf build
    https://git.kernel.org/netdev/net-next/c/377d180bd71c
  - [net-next,v3,05/12] net: txgbevf: add sw init pci info and reset hardware
    https://git.kernel.org/netdev/net-next/c/4ee8afb44aee
  - [net-next,v3,06/12] net: txgbevf: init interrupts and request irqs
    https://git.kernel.org/netdev/net-next/c/fd0a2e03bf60
  - [net-next,v3,07/12] net: txgbevf: Support Rx and Tx process path
    https://git.kernel.org/netdev/net-next/c/ce12ba254655
  - [net-next,v3,08/12] net: txgbevf: add link update flow
    https://git.kernel.org/netdev/net-next/c/bf68010acc4b
  - [net-next,v3,09/12] net: wangxun: add ngbevf build
    https://git.kernel.org/netdev/net-next/c/a0008a3658a3
  - [net-next,v3,10/12] net: ngbevf: add sw init pci info and reset hardware
    https://git.kernel.org/netdev/net-next/c/85494c9bf5b0
  - [net-next,v3,11/12] net: ngbevf: init interrupts and request irqs
    https://git.kernel.org/netdev/net-next/c/0f71e3a6e59d
  - [net-next,v3,12/12] net: ngbevf: add link update flow
    https://git.kernel.org/netdev/net-next/c/cfeedf6a420d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



