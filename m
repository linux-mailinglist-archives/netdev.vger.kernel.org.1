Return-Path: <netdev+bounces-13747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F5873CD30
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25615281111
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC87DDDD;
	Sat, 24 Jun 2023 22:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B4A953
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 086C5C433C8;
	Sat, 24 Jun 2023 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687644620;
	bh=65d6ADRFQflcOt+dEtKU45F1wQAOLj4hjVBFonSVyOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G9Qu/udbCRyoAzhfwtCOCc0zRnQaAAObPoDGorArqFzj3PhuG+4/7dSO5JbyAW+bd
	 MpJXvKX88eehnGyRbDi8WHdoxmBvYGPT1ZXpbZkY1iaNPeUNBHvNH8BSBLJXPeEjkh
	 SqFvYAEwvBNCh4AyXnlbJ9ssmM/3HOD4M97o6c6mvEv77lFKlLQcsVUbywj81Ht/jy
	 ELiXbyND/OVKvgdU9r8jpwkemBBkFSW6aZDMp4MeV203pqigDJiX3uHkQR7nI/BOH3
	 2XzyVl1KJDwC1F9M0JchWqCDTHE6qqOAXiD+ndhZI37omSBGB31bRmDdNCLSTWIbGI
	 rp8IRddmOnw2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2EBFC395F1;
	Sat, 24 Jun 2023 22:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4][pull request] igc: TX timestamping fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764461985.18414.6171868913658722136.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:10:19 +0000
References: <20230622165244.2202786-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230622165244.2202786-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 22 Jun 2023 09:52:40 -0700 you wrote:
> This is the fixes part of the series intended to add support for using
> the 4 timestamp registers present in i225/i226.
> 
> Moving the timestamp handling to be inline with the interrupt handling
> has the advantage of improving the TX timestamping retrieval latency,
> here are some numbers using ntpperf:
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] igc: Fix race condition in PTP tx code
    https://git.kernel.org/netdev/net/c/9c50e2b150c8
  - [net,v2,2/4] igc: Check if hardware TX timestamping is enabled earlier
    https://git.kernel.org/netdev/net/c/ce58c7cc8b99
  - [net,v2,3/4] igc: Retrieve TX timestamp during interrupt handling
    https://git.kernel.org/netdev/net/c/afa141583d82
  - [net,v2,4/4] igc: Work around HW bug causing missing timestamps
    https://git.kernel.org/netdev/net/c/c789ad7cbebc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



