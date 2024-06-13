Return-Path: <netdev+bounces-103286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C237F90761E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0271FB20E84
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8336A14901C;
	Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOsUBndO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A7148FFC
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291430; cv=none; b=M7Yt0IyC0S8rzpjLMbROA9RHBQC+/Vtaq/YM3pXEKjBjOg+zPe/dfmkJKpvaBR+bI/jGiJ1CQyb/Dx05ABanYzKiYCVaCTFnBeDmNE1zuaIREmZ2ZpqASGq36KZJF5gR5mrpJV7Rk1mFNCrUFBnFHyYzpLAJSuLWZnX4bHkjARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291430; c=relaxed/simple;
	bh=5U0/TAI9/zfYg4LTTIn2d/iR66ESO4XHiONizuHGhwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F87NfA+xamc/eGifv/wAq3ITtgRUWcY6SNOxu2fn5A+vDNHjQEVnCp3R+rxzmH/y1N7RdnTGia+heACRHYPmQr3gKU5y4qd7cPTxu9NX0Yv3FRm+yWnX+H5kBZ3LaBHNYMrKJ+YS9kBVerDHOtn6K0qYq0DKrsfPDkcUH1AS1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOsUBndO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0956FC4AF1C;
	Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291430;
	bh=5U0/TAI9/zfYg4LTTIn2d/iR66ESO4XHiONizuHGhwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GOsUBndOUXxzEY3taI83WqQtUzkx/AnDm1S+TXZS2goTqFjxy2rYCDxMWVECD+R9m
	 X4ic/TEGuPxIB5uJN56e2Ob/xvHJ85hXz5mbIhy2mAqv5XxiprjC4mDNrmzRon1FwQ
	 e+plcU3AgoVTAowqfkqmYuIWvCN1kvOCV/akKDtRVILP7ytHf30jMjXlSgvJMtZV1n
	 jSmpHAkUJBvij9Zygz1reuRZ8IIVNqGA12SQlSrIjejKpWMrS1TgY367WsmU2CjNRL
	 e83GyVOokb7nWGfQuZJVUuzyjiTwvsPY/gunYi2dMWv6cAstiHxpJ5Nsr6EewOoA21
	 tec6/Xqb5m/Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE475C43616;
	Thu, 13 Jun 2024 15:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded
 response
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171829142997.24472.14963620739351943299.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 15:10:29 +0000
References: <20240612231736.57823-1-michael.chan@broadcom.com>
In-Reply-To: <20240612231736.57823-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
 horms@kernel.org, przemyslaw.kitszel@intel.com, somnath.kotur@broadcom.com,
 pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jun 2024 16:17:36 -0700 you wrote:
> Firmware interface 1.10.2.118 has increased the size of
> HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
> forwarded.  When the VF's link state is not the default auto state,
> the PF will need to forward the response back to the VF to indicate
> the forced state.  This regression may cause the VF to fail to
> initialize.
> 
> [...]

Here is the summary with links:
  - [net,v3] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response
    https://git.kernel.org/netdev/net/c/7d9df38c9c03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



