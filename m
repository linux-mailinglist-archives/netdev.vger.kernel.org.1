Return-Path: <netdev+bounces-44646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 543757D8DFF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D10B211F7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C353AA;
	Fri, 27 Oct 2023 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUQNbpuB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3235245
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9722EC433C8;
	Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698383450;
	bh=cfGJ+iowbb8mx6LpCPs28r6qgXcaTvJqhxPbgRaBND4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUQNbpuB7ObUjPBzXsylw4aC3J0xqS4V/GHjkDlb9KgdMHJPeb4Ur1xY2VsuOxdd6
	 TWVtx/iV1ge+l1zOaYiIh5RVnQQw28Ufwv4iMAaWbBKWL3uIJmNWCUgeuPy4BGzNyI
	 r9AILv77u1acnNP2SM70Bd/oTjACndrlheDQmp/nVGJmUSS2vhhM/V2FImA4E7KzbF
	 dWPO7xLIrwxwbgsnFb6qdtpBoTrEfo0tyu27t1KHE/Z+bpQr6C1sRonkkdvbTuTbYI
	 Ck5fMDn3JAXjCiU5pbJ6Fl9S/MPIdNFW//jxmAvo8E9ee+TOTWzvgIs721G1lvQAtV
	 KfKWC4V6/j0EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81B3EC691EF;
	Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] Intel Wired LAN Driver Updates for 2023-10-25
 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169838345052.10513.926800877011870802.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 05:10:50 +0000
References: <20231025214157.1222758-1-jacob.e.keller@intel.com>
In-Reply-To: <20231025214157.1222758-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 14:41:51 -0700 you wrote:
> This series extends the ice driver with basic support for the E830 device
> line. It does not include support for all device features, but enables basic
> functionality to load and pass traffic.
> 
> Alice adds the 200G speed and PHY types supported by E830 hardware.
> 
> Dan extends the DDP package logic to support the E830 package segment.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] ice: Add E830 device IDs, MAC type and registers
    (no matching commit)
  - [net-next,2/6] ice: Add 200G speed/phy type use
    https://git.kernel.org/netdev/net-next/c/24407a01e57c
  - [net-next,3/6] ice: Add ice_get_link_status_datalen
    https://git.kernel.org/netdev/net-next/c/2777d24ec6d1
  - [net-next,4/6] ice: Add support for E830 DDP package segment
    (no matching commit)
  - [net-next,5/6] ice: Remove redundant zeroing of the fields.
    https://git.kernel.org/netdev/net-next/c/f8ab08c0b769
  - [net-next,6/6] ice: Hook up 4 E830 devices by adding their IDs
    https://git.kernel.org/netdev/net-next/c/ba20ecb1d1bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



