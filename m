Return-Path: <netdev+bounces-44049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C97D5EF5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650F1281BFF
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705CF180;
	Wed, 25 Oct 2023 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1fXKORo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA797E1
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB269C433C7;
	Wed, 25 Oct 2023 00:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698192622;
	bh=AXvKLQknXER8A7vV8B44Ez52Rv1m21dVq73GKbxbjY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o1fXKORoThS2bnbqmE/DZNmb4TR8E47UAu+HuP79Fr/7hydB8TbD7mrwIRrQ60iQC
	 8SMIdULdJyLuY2fEyKi4f6fas0+S1I2vh4TPtjgJpsyIPyGmuPBpqGjJW6u0HkrKsF
	 ZA+ozIz8oaNwap7bxzIUXpBHVZsUSc8dHjbL8LBgH3rRXrfpK8YdM3QQmiD4NCyzAh
	 QvAW48T9wuljOMbwM3H5r13Sq5a8fOh7qLEJhikOWCGw616jMSRrdWtYOCK10ZMWU1
	 P1p9Cj2Mp7Z4IRHo90iXBh1zd32cJKLGoBZDbqRymxhiRnEHlAbjUlGccYQW6fdyrM
	 7CA2VY9/6i3CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F825C41620;
	Wed, 25 Oct 2023 00:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169819262265.24368.9631951944750985561.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 00:10:22 +0000
References: <20231023212714.178032-1-jacob.e.keller@intel.com>
In-Reply-To: <20231023212714.178032-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 ivecera@redhat.com, himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 14:27:14 -0700 you wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.
> 
> Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR feature for X722")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
    https://git.kernel.org/netdev/net/c/77a8c982ff0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



