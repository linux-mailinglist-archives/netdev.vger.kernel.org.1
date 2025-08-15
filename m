Return-Path: <netdev+bounces-213888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29981B2742B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A81C26E5F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5DD189F43;
	Fri, 15 Aug 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfiPRp5F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7617A305
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218415; cv=none; b=LPZV7SE0dEwLGFKxiki5P+hN7ckYRuYznA9O73IUGVRY2pIzm6LecbKqF4wGb89Mv9IhPxIIhhPXBhTKi6IKxQAAFaenBMThYYu2QPAST3K/uHJXGPyf8MMvpTna8swsesvnSKbwMFsb/+YyN3hgKQsLBs3OLnHYL6gNgUE2OTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218415; c=relaxed/simple;
	bh=QfT06nCjDfHc6tsJDPduZ66Kyng8UMQ0MDyDCcBx43s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VJ9eYBVVF8kGc/ucJrIT3YP4QNswAh2tav0oHhnJcouSnvWEuOjRAcyJvx3NTbVW5D0K81kSckph77EnXPKeGuh5HuCm6936iDh8bHAY2aJXbJkTxZBnVHF3NNUYNIgVhT1idcjua4u71bPRubzW3A7CeCOrzan8tVBpAvAKHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfiPRp5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8905C4CEF5;
	Fri, 15 Aug 2025 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218414;
	bh=QfT06nCjDfHc6tsJDPduZ66Kyng8UMQ0MDyDCcBx43s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MfiPRp5FE/64qjmuoxOq/zf80pKY0qTBUnV+p7eyuK2gLtntU9lWR/2wmTRXEWWze
	 gVrZ3vWxw1Q42+bMGOnJINrJKl/Nhxotihu87Y8mYR7PP3eLqZS+LAZq0erJl+djMS
	 UbVK9UIonNWHLgvnZflnpyoDJD63lgtX/jQvbjzbeo3LegFEntA69+kCs/uOEJNEpD
	 foUaDJcdcTz3iEuNF76CStL3q2w5Pd+iJaZzeg4G5xrNcMd8U0WLg6c3wU/k8tzN6g
	 VC539LcHeER2i6cnSKkqLvwLpEs7kbKYdcluRKae3AvW3TB6lZvx7sLJRIGy2qfV1z
	 uHDcorKcAOoZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7939D0C3E;
	Fri, 15 Aug 2025 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: phy: realtek: convert RTL8226-CG to c45
 only
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521842601.497413.2494041877987540683.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:40:26 +0000
References: <20250813054407.1108285-1-markus.stockhausen@gmx.de>
In-Reply-To: <20250813054407.1108285-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael@fossekall.de, daniel@makrotopia.org, netdev@vger.kernel.org,
 jan@3e8.eu

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 01:44:07 -0400 you wrote:
> Short: Convert the RTL8226-CG to c45 so it can be used in its
> Realtek based ecosystems.
> 
> Long: The RTL8226-CG can be mainly found on devices of the
> Realtek Otto switch platform. Devices like the Zyxel XGS1210-12
> are based on it. These implement a hardware based phy polling
> in the background to update SoC status registers.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: realtek: convert RTL8226-CG to c45 only
    https://git.kernel.org/netdev/net-next/c/34167f1a024d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



