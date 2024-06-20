Return-Path: <netdev+bounces-105091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516A90FA43
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D841C20C9F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1E15A8;
	Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN33LKQG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E97F8
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843427; cv=none; b=tab3n2/cGpX1hecS/A4k1KZ/1jQQLgZE+KySBW5IkEUAqQTS6hhJ5kL4H5R04DjVFZiL9EzUUth42L48AIJcSA8O5kcoP04gCdLRhfgUv0OC+nVDWP6u7tSIpp4+pdEA1tJ6S8lEtTNjkelKz51u1mUxk0K4agKlqFkQaFLCWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843427; c=relaxed/simple;
	bh=0jK9OG/Ew2FVIcJuDA8L/zrqX//bm3IP398EhhXkHxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UvGDC1XaYCHs2GHF3hknQty9x9EmPv9AhqsNruWZR+wMfZEUmGtHpgK/kc3Wr2wXrftJfN6YWUlLQuYTSofPYPcIK7encSD1EkESb6HQUNUpjoyzb1Ch2SvZdQxWlCnP23BuN8W2T+/FvIYia0EQtjglb9blU9dI1py5+fOPHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN33LKQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26906C32786;
	Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843427;
	bh=0jK9OG/Ew2FVIcJuDA8L/zrqX//bm3IP398EhhXkHxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uN33LKQGmLjMUWl7MODtgOSc+Pm3ylGVjSBSPEmC6es8/K77U+iWlmVHugMbkaeTo
	 5SNfR+LJqG11lW0cVqtaztCeUVJ+1gIYFBbmyLMcmW4Lt6EAgHu6EsZdzmor6ica4g
	 /9ykWWE7YYIyL+nrUwYhSBHzn4zqEjVAVmAcu/YY3ZL7WR0UxBM99EyKU4NXszvBrW
	 wkml/0zhjuRl8gkmErlnA7ki42zNl2yxpAkTpHXyVqi3nIFTaog+xUUCLHAN+IRAR5
	 PUbY0OB/E61RlYec5y2h/n7I8pTAwsJC55064ikq0xCD8v46ClM5KA6EWtsHOxF5J4
	 c6zOFq7b6WIoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DD51E7C4C9;
	Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Fix VSI list rule with ICE_SW_LKUP_LAST type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884342705.23279.3795305156255637763.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:30:27 +0000
References: <20240618210206.981885-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240618210206.981885-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, marcin.szycik@linux.intel.com,
 michal.swiatkowski@linux.intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, horms@kernel.org, sujai.buvaneswaran@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 14:02:05 -0700 you wrote:
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> Adding/updating VSI list rule, as well as allocating/freeing VSI list
> resource are called several times with type ICE_SW_LKUP_LAST, which fails
> because ice_update_vsi_list_rule() and ice_aq_alloc_free_vsi_list()
> consider it invalid. Allow calling these functions with ICE_SW_LKUP_LAST.
> 
> [...]

Here is the summary with links:
  - [net] ice: Fix VSI list rule with ICE_SW_LKUP_LAST type
    https://git.kernel.org/netdev/net/c/74382aebc903

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



