Return-Path: <netdev+bounces-103287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A890761D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DED1C2245E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD51494A7;
	Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe5P0v+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74D1487CD;
	Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291430; cv=none; b=RDceNvyruP+UiEeINxGeXP4j7zH/LxmDpsPWqFYSWcFpn2pvRo5Ibm7EmJrPr78/qRD8GiFDAOUSI/heZBkMLBS/2GXp0ju87ckMWN/PX8kXMgmd5i/zFSstesY199Dh8Dz22DWYZD+d57ELFI9Jcc0ouO4SQ9MQQcOt+kWkvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291430; c=relaxed/simple;
	bh=mH4t85OK7LJEv4wy7C9LOqpgb8ccwZIPq8ZKg5t2YHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NQGw95gvoYsrRv3cp2hQbUkLZkgtbtdItbxztCfbmF1zOwPI3yfMSaS2iCEgnKmmV2mQpi3zp1vfwIHoFriSHzL2y9YEeaNxI0kyZIg87SPUHOcPuBbet344q2/8BaxYezRqamsGaV0EmLEVuh/N0bhdRsuuBsQIIfyxW+/Z45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe5P0v+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03C95C32786;
	Thu, 13 Jun 2024 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291430;
	bh=mH4t85OK7LJEv4wy7C9LOqpgb8ccwZIPq8ZKg5t2YHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pe5P0v+kFyC/X3IQE1nd6ZaB3GljwuPUNv5mHvxqlDlihq0D4llkvDx7b0Z+BCJF0
	 dN0OLo9tEYfPKoTKhU5EKzUwk8V1IgJb8FJSYouRywSUTCQfIFN7HK1JgmE6HuH9T9
	 FQmG/m7WPl54UIOOB45kpmNONWfwf5O04sx9+1shuAI4nqk6nP1N7GT/ePsBeifofs
	 t7vT4a9jYP8xzZ7FCYjiunVWV4Me1fjfq+GcQwLd3QDLJdKR2YRWxwbmab8KfBVtq+
	 75f0Xb6Bp4+z3agPG02Mj7rVCNxsD7Hcb0cbZlHS6TIS1x0GiDlYhPRudR3jOpD34K
	 Z2sxArIBuyY3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E29EEC43619;
	Thu, 13 Jun 2024 15:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] bnxt_en: Adjust logging of firmware messages in case
 of released token in __hwrm_send()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171829142992.24472.4309474315730518205.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 15:10:29 +0000
References: <20240611082547.12178-1-amishin@t-argos.ru>
In-Reply-To: <20240611082547.12178-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: edwin.peer@broadcom.com, michael.chan@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, wojciech.drewek@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jun 2024 11:25:46 +0300 you wrote:
> In case of token is released due to token->state == BNXT_HWRM_DEFERRED,
> released token (set to NULL) is used in log messages. This issue is
> expected to be prevented by HWRM_ERR_CODE_PF_UNAVAILABLE error code. But
> this error code is returned by recent firmware. So some firmware may not
> return it. This may lead to NULL pointer dereference.
> Adjust this issue by adding token pointer check.
> 
> [...]

Here is the summary with links:
  - [net,v3] bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()
    https://git.kernel.org/netdev/net/c/a9b9741854a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



