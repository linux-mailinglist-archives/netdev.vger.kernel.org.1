Return-Path: <netdev+bounces-42994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB237D0F4E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6041C2100D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A340419BA6;
	Fri, 20 Oct 2023 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igJs/pQ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525D199C8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57351C433CA;
	Fri, 20 Oct 2023 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697803226;
	bh=KlzZfoPdOT+KItdXvDjxmh7aTGIlzfD9x9J+d8lTbp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=igJs/pQ+Wy4TXnznMwtin0EbzpM7KL78HyNLV3V7zkv06EXobH666mG//GGnyw5hN
	 hOadsU8kF5a/5KRLyCFRdFKoa+oXURtRGgRlWSLiXI4KS6jm4kMMoIrOEv5iVTM7is
	 2di0eFOOjdoj75tjWOg3ObBqqR5O07Dz1hQlTiLWrifEgQjlda1uCvEVUl8FLlFeFk
	 Zb/9YJUYM1V017eUn6TfdOPlHtbeuPOUc7MjVN3UJQ2LefjvZRNJ0zmAMXmXf+zRoi
	 0S6HdUjh83S9JzrPiYJKUe5HwxcLhkOa54RqYVTzythMioT3j0vsXmVj6ggUHYPvWf
	 nC4TwxC75ajXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4312FC595CE;
	Fri, 20 Oct 2023 12:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] Intel Wired LAN Driver Updates 2023-10-19
 (ice, igb, ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169780322627.10600.13502314734290160505.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 12:00:26 +0000
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Oct 2023 10:32:16 -0700 you wrote:
> This series contains improvements to the ice driver related to VF MSI-X
> resource tracking, as well as other minor cleanups.
> 
> Dan fixes code in igb and ixgbe where the conversion to list_for_each_entry
> failed to account for logic which assumed a NULL pointer after iteration.
> 
> Jacob makes ice_get_pf_c827_idx static, and refactors ice_find_netlist_node
> based on feedback that got missed before the function merged.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] ice: remove unused ice_flow_entry fields
    https://git.kernel.org/netdev/net-next/c/4cd7bc7144ec
  - [net-next,02/11] ice: add drop rule matching on not active lport
    https://git.kernel.org/netdev/net-next/c/9dffb97da291
  - [net-next,03/11] ice: store VF's pci_dev ptr in ice_vf
    (no matching commit)
  - [net-next,04/11] ice: implement num_msix field per VF
    https://git.kernel.org/netdev/net-next/c/fe1c5ca2fe76
  - [net-next,05/11] ice: add bitmap to track VF MSI-X usage
    https://git.kernel.org/netdev/net-next/c/ea4af9b4005d
  - [net-next,06/11] ice: set MSI-X vector count on VF
    https://git.kernel.org/netdev/net-next/c/05c16687e0cc
  - [net-next,07/11] ice: manage VFs MSI-X using resource tracking
    https://git.kernel.org/netdev/net-next/c/4d38cb44bd32
  - [net-next,08/11] ice: make ice_get_pf_c827_idx static
    https://git.kernel.org/netdev/net-next/c/67918b6b2671
  - [net-next,09/11] ice: cleanup ice_find_netlist_node
    https://git.kernel.org/netdev/net-next/c/640a65f80133
  - [net-next,10/11] igb: Fix an end of loop test
    https://git.kernel.org/netdev/net-next/c/4690aea589e7
  - [net-next,11/11] ixgbe: fix end of loop test in ixgbe_set_vf_macvlan()
    https://git.kernel.org/netdev/net-next/c/a41654c3ed1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



