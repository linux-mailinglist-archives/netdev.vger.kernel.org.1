Return-Path: <netdev+bounces-53698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD01E804281
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 00:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1D82813DC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EA631724;
	Mon,  4 Dec 2023 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFlCdbjC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E122F1C
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 23:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64B11C433CA;
	Mon,  4 Dec 2023 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701732027;
	bh=nrC7js2PUxI7vQ3TgU/CCWzo4pr7jXjlfPvkqZ0EHuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eFlCdbjCqlaF5ydUqnjnEcHlYTshBphhmSYBruRAy7eYP4OsKFs5QpQnPpqDFzIcr
	 yKEUutWj9HyQbs9vn0jhlsK243nIhas0HjIFO2DTJkSuCM2DtofgdqMKsGTW6LlZL4
	 JWYJpzvmjJsiZGfpuGer31Mgf+eu/7YmDAMbwgGLKqPCP5+eGN7XxTDLXOBeSvn+JT
	 adqLcQK0mrfpSJNFxepTkS25QkFtRszTO6FvvNmicfkrwWI/JTRQQPFFQ1s7PiR/At
	 4kiCBBo/xSj7xDRvdam/8JQHAQtQh82bgGWxyUwkZqnAtNsBVDSJqgdgErUANFO4aE
	 tPX2vlnEi/l3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 477FEC595C4;
	Mon,  4 Dec 2023 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] bnxt_en: Support new 5760X P7 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170173202728.29919.5530352874107888937.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 23:20:27 +0000
References: <20231201223924.26955-1-michael.chan@broadcom.com>
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Dec 2023 14:39:09 -0800 you wrote:
> This series completes the basic support for the new 5760X P7 devices
> with new PCI IDs added in the last patch.
> 
> Thie first patch fixes a backing store issue introduced in the last
> patchset last week.  The 2nd patch is the new firmware interface
> required to support the new chips.  The next few patches are doorbell
> changes, refactoring, and new hardware interface structures.  New
> changes to support packet reception including TPA are added in patch 10.
> The next 4 patches are ethernet link related changes to support the
> new chip.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] bnxt_en: Fix backing store V2 logic
    https://git.kernel.org/netdev/net-next/c/08b386b132c6
  - [net-next,02/15] bnxt_en: Update firmware interface to 1.10.3.15
    https://git.kernel.org/netdev/net-next/c/397d44bf1721
  - [net-next,03/15] bnxt_en: Define basic P7 macros
    https://git.kernel.org/netdev/net-next/c/a432a45bdba4
  - [net-next,04/15] bnxt_en: Consolidate DB offset calculation
    https://git.kernel.org/netdev/net-next/c/d3c16475dc06
  - [net-next,05/15] bnxt_en: Implement the new toggle bit doorbell mechanism on P7 chips
    https://git.kernel.org/netdev/net-next/c/d846992e6387
  - [net-next,06/15] bnxt_en: Refactor RSS capability fields
    https://git.kernel.org/netdev/net-next/c/8243345bfaec
  - [net-next,07/15] bnxt_en: Add new P7 hardware interface definitions
    https://git.kernel.org/netdev/net-next/c/13d2d3d381ee
  - [net-next,08/15] bnxt_en: Refactor RX VLAN acceleration logic.
    https://git.kernel.org/netdev/net-next/c/c2f8063309da
  - [net-next,09/15] bnxt_en: Refactor and refine bnxt_tpa_start() and bnxt_tpa_end().
    https://git.kernel.org/netdev/net-next/c/39b2e62be370
  - [net-next,10/15] bnxt_en: Add support for new RX and TPA_START completion types for P7
    https://git.kernel.org/netdev/net-next/c/a7445d69809f
  - [net-next,11/15] bnxt_en: Refactor ethtool speeds logic
    https://git.kernel.org/netdev/net-next/c/cf47fa5ca5bb
  - [net-next,12/15] bnxt_en: Support new firmware link parameters
    https://git.kernel.org/netdev/net-next/c/30c0bb63c2ea
  - [net-next,13/15] bnxt_en: Support force speed using the new HWRM fields
    https://git.kernel.org/netdev/net-next/c/7b60cf2b641a
  - [net-next,14/15] bnxt_en: Report the new ethtool link modes in the new firmware interface
    https://git.kernel.org/netdev/net-next/c/047a2d38e40c
  - [net-next,15/15] bnxt_en: Add 5760X (P7) PCI IDs
    https://git.kernel.org/netdev/net-next/c/2012a6abc876

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



