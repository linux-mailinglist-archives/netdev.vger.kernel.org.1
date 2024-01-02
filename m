Return-Path: <netdev+bounces-60902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF5821D2F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D1EB21C42
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB6FC08;
	Tue,  2 Jan 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUtRdRLP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1D101C4
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97523C433C8;
	Tue,  2 Jan 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704204028;
	bh=sGn04kJ7m2ltUKVLSiThy6PoLEsMXeg+nb2hqpFiMvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUtRdRLPYHkxtudzeQQvSrZ1FxMxaYyMneaHd2L6I89ZFyVORVPnSyNNQ7a+xcCzL
	 yys1npW6U8go4I9t3lTPxREGFKfP7TdphM1uLEH2Cw7Kc8kdIH5iQTALG4at0uLIXZ
	 /61tWsmOdUDh9OipAZ4J20E7LziY2vu43oeXP/Mvz2krJ9z0XLIUDoHW1lgoxok25e
	 /4I5coj5g6xDig5pthw8uG1Mjh6Lup0qJ0l3QzlpZIY42bN3hpUYfKrvJlEdtyytjF
	 2Zp7nFOXmW4uP7zFSCE0LVT+O2Rt2GP9976lmA1tUR6xebE3z9lZW8t+LgFcXbnMFp
	 VJN839WD+T4BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E5E1DCB6D1;
	Tue,  2 Jan 2024 14:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13] bnxt_en: Add basic ntuple filter support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420402851.2320.10719178135275424943.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 14:00:28 +0000
References: <20231223042210.102485-1-michael.chan@broadcom.com>
In-Reply-To: <20231223042210.102485-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 20:21:57 -0800 you wrote:
> The current driver only supports ntuple filters added by aRFS.  This
> patch series adds basic support for user defined TCP/UDP ntuple filters
> added by the user using ethtool.  Many of the patches are refactoring
> patches to make the existing code more general to support both aRFS
> and user defined filters.  aRFS filters always have the Toeplitz hash
> value from the NIC.  A Toepliz hash function is added in patch 5 to
> get the same hash value for user defined filters.  The hash is used
> to store all ntuple filters in the table and all filters must be
> hashed identically using the same function and key.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] bnxt_en: Refactor bnxt_ntuple_filter structure.
    https://git.kernel.org/netdev/net-next/c/992d38d2b988
  - [net-next,v2,02/13] bnxt_en: Add bnxt_l2_filter hash table.
    https://git.kernel.org/netdev/net-next/c/1f6e77cb9b32
  - [net-next,v2,03/13] bnxt_en: Re-structure the bnxt_ntuple_filter structure.
    https://git.kernel.org/netdev/net-next/c/bfeabf7e4615
  - [net-next,v2,04/13] bnxt_en: Refactor L2 filter alloc/free firmware commands.
    https://git.kernel.org/netdev/net-next/c/96c9bedc755e
  - [net-next,v2,05/13] bnxt_en: Add function to calculate Toeplitz hash
    https://git.kernel.org/netdev/net-next/c/d3c982851c15
  - [net-next,v2,06/13] bnxt_en: Add bnxt_lookup_ntp_filter_from_idx() function
    https://git.kernel.org/netdev/net-next/c/cb5bdd292dc0
  - [net-next,v2,07/13] bnxt_en: Add new BNXT_FLTR_INSERTED flag to bnxt_filter_base struct.
    https://git.kernel.org/netdev/net-next/c/ee908d05dd2a
  - [net-next,v2,08/13] bnxt_en: Refactor filter insertion logic in bnxt_rx_flow_steer().
    https://git.kernel.org/netdev/net-next/c/59cde76f33fa
  - [net-next,v2,09/13] bnxt_en: Refactor the hash table logic for ntuple filters.
    https://git.kernel.org/netdev/net-next/c/80cfde29ce1f
  - [net-next,v2,10/13] bnxt_en: Refactor ntuple filter removal logic in bnxt_cfg_ntp_filters().
    https://git.kernel.org/netdev/net-next/c/4faeadfd7ed6
  - [net-next,v2,11/13] bnxt_en: Add ntuple matching flags to the bnxt_ntuple_filter structure.
    https://git.kernel.org/netdev/net-next/c/300c19180098
  - [net-next,v2,12/13] bnxt_en: Add support for ntuple filters added from ethtool.
    https://git.kernel.org/netdev/net-next/c/c029bc30b9f6
  - [net-next,v2,13/13] bnxt_en: Add support for ntuple filter deletion by ethtool.
    https://git.kernel.org/netdev/net-next/c/8d7ba028aa9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



