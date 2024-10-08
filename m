Return-Path: <netdev+bounces-132990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9D994201
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207711F265E3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396E1DF985;
	Tue,  8 Oct 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHm3V9Op"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9251D54E9;
	Tue,  8 Oct 2024 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374429; cv=none; b=GDtaqt/lWxdOZmOFC7SRRIaSnLC4X9DZh1sVu3AkQHxPKBdGBOUetM9YZzbdZa6g9hcmr6vgepSf2CmKYLv2Fea/yu2WGNL9IsgnXvS5pBLlsp3lxuBv0yxbMSSgWZWwGSn4Mgjak/PH6HT8EX8J4sgNR3PMvgkcapaKv8IN5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374429; c=relaxed/simple;
	bh=67JNBW8CcgBGuIotE/zcSMHPL5kZc/Dco2QQfO4QbSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P88lxNtfiXhFjHUbzjJm40iomJFJnsCq/PUPpXm75MigaTqeYMU8yo5/6Lxu5h/VeUeXDoeYrxArVawWPiFnZFbtEqtRR2O/0taMDmuFiMYtHnrEKi1sT5cPGEOn8PMwVaEu45TPcTktPp1IKQYvI18z8g443UJm5XXxRcP9oF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHm3V9Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA0CC4CEC7;
	Tue,  8 Oct 2024 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728374427;
	bh=67JNBW8CcgBGuIotE/zcSMHPL5kZc/Dco2QQfO4QbSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YHm3V9OpA4RyhHnLvU8woL+C3D970vUQhXrhlgE2+guiMWUVwhXwnZqBHlsciYXkN
	 1Xe/OFyjxlWG795yDG3wh4SaiX4LL4WAbb69gufbVLI2KYTd8S/Fy717bWvh33B8P7
	 tNqStfeE9Hnm/giTyEqG1moLml5KPNxyUwINloZfG4kiRTp8RJGjmnTRznwV3czB5w
	 fShAHGv5VHzFarMLSxIMLxlZH5obd9HZ6joX7hAhI73sZT/djwFtTK04LIGM7/IkT+
	 DMEDN+5SqM3MYavIiaLgHmRZi8jZrcyz944CF3KOy8TGiMKSJJOf5+a0adWa9qKmbk
	 GuEaNVzYmXlew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AECDF3810938;
	Tue,  8 Oct 2024 08:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172837443152.434453.3560718688892261102.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 08:00:31 +0000
References: <20241003-qcom_emac_fix-v6-1-0658e3792ca4@quicinc.com>
In-Reply-To: <20241003-qcom_emac_fix-v6-1-0658e3792ca4@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: timur@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zijun_hu@icloud.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 3 Oct 2024 10:27:27 -0700 you wrote:
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> [...]

Here is the summary with links:
  - [net-next,v6] net: qcom/emac: Find sgmii_ops by device_for_each_child()
    https://git.kernel.org/netdev/net-next/c/138d21b68b71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



