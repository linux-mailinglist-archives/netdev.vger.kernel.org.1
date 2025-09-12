Return-Path: <netdev+bounces-222379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A35B54019
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D1B5A70FF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA31F1E0DD9;
	Fri, 12 Sep 2025 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoDv3bZG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF331DEFE9;
	Fri, 12 Sep 2025 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642433; cv=none; b=eXWkZ3dsDyyNVY2mmh/P47Nt5B5qiU1Fp6+NyhPTM5f5AKVPvea/SySuIH0TefmaJTdfizqshj//n/xviWaq00s2l0TXsFj/lb1t3C0OhxZ+edPJW0ZJKKN1VQ/GqNeWY4HskjV5qVHeyzNrpLI1WL7jHsrpG/ENHsxOJPthmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642433; c=relaxed/simple;
	bh=gGvFxaMqyFyGHZn/o/+L3+laFcesPAjWvEOC2O7DL9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QhF1o4zTP9Qdel9zqG6eZ1hhBacKw4jo3gEEmWdTWnuxgRCWDj+YrU6KXbcaSfVCppZzUmN6KYoPbScJezn0WDMRmfSV2eZAfJiQzLuHGtqM2/uYkfxT3RJWJTVgMzHg0kNmJBAjmAdmn4qomB2yXOkJRn5KPinkz+HM64TT0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoDv3bZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C429C4CEF0;
	Fri, 12 Sep 2025 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642433;
	bh=gGvFxaMqyFyGHZn/o/+L3+laFcesPAjWvEOC2O7DL9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YoDv3bZGToj7JfOnv4sQim7ZPQwkLCyfeVRPqCmNkvSQawGvmaSwcygpJuWuBsax/
	 j5Zv+4f5/eE/i76zEy+YlpOdznWp71ogOYfoj0+HBX4X6LPe+7iD0TJlBEzc9OT1VO
	 Lv9YnV1f/3pRXT8Ni5fcpc7qlHyZKYRETgnPmqNoXPWacjCIRZ6oMonJlULu9OzMDu
	 0o+NUop9FxBKdzfle+BUxSe0Wv8Gb9aAEc9pt6jFBMBmafJsk1iSj8dgm47NO13Z85
	 GMxVMW23CHO0D0IDU1Qp6aV+pJC0rkvAsvnBZfV0XfdvuRKZ1Pshw7pen8SPgyOT+G
	 g0zzHkqmFNinQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF00383BF69;
	Fri, 12 Sep 2025 02:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] dt-bindings: net: Convert apm,xgene-enet to DT
 schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764243549.2373516.4669532326019334550.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:00:35 +0000
References: <20250908231016.2070305-1-robh@kernel.org>
In-Reply-To: <20250908231016.2070305-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Sep 2025 18:10:13 -0500 you wrote:
> Convert the APM XGene Ethernet binding to DT schema format.
> 
> Add the missing apm,xgene2-sgenet and apm,xgene2-xgenet compatibles.
> Drop "reg-names" as required. Add support for up to 16 interrupts.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: net: Convert apm,xgene-enet to DT schema
    https://git.kernel.org/netdev/net-next/c/0b467f5a7f19
  - [v2,2/2] dt-bindings: net: Convert APM XGene MDIO to DT schema
    https://git.kernel.org/netdev/net-next/c/e663ad6e06a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



