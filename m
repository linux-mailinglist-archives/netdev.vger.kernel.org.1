Return-Path: <netdev+bounces-131855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C798FBA5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125831F22625
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED662367;
	Fri,  4 Oct 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkbyG+gj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913F1849
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002429; cv=none; b=E4jx6g8vuCGJaena0ajCPrvyRnYOFKJrQYy54Hu9D3LFL/a9eI9q4lst0cxBB0gaIbgpLVVZaSRNFiEOehTTAjI4pAni/MyxExP+cMhP/Mc0vTv0G8D8CQAiz0ydrIIZv7CsZHCqymKscP3dX1k2y+xUBw0m6QN4Pkt67ckQcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002429; c=relaxed/simple;
	bh=FuDsl+3Qc2jxNYeKpI5RIBSPsFnUD3bVYGsvbwd1DlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AiL2NriZXxIn1R7woYB2kc2eqyZiT4kcJYwif4mL+Nnb2p0oXlokU1CHB2XK2rwMj8e1a248lL2Pyfz69Ld19F84CXmPzsJ0KT9FV/pUu6V+OVVRaI5sLmI3gqZXMsxQiLgz7VBqcGQy7GxbY5n01y+IRtYrIWq7Vo/te6aYqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkbyG+gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4770CC4CEC5;
	Fri,  4 Oct 2024 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002429;
	bh=FuDsl+3Qc2jxNYeKpI5RIBSPsFnUD3bVYGsvbwd1DlA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SkbyG+gj/+4Y43mEFP5cHgSlaQ6ZVa31KCDzHeK8DHD9mzFQK+JyDm4FVU8PBGyMO
	 WX4qRrGjF1J9p7yI8vgtFcDpRRJqhzm/t1WOcFe+M3OtrZN5InPGHg2JSSBPfog0j4
	 coeSjeqOBw7QWomYYHWqruD2T2bkTpNaKERvU8FH5CIdT4HQBZFGaC2R4jeKSewg2R
	 ZmAxKkj0ynIkukcZJ2nioam2CLqBcI71N/N14Pe9QHGb2kr04xhmg8fXYlEDW09ju3
	 o0MAOKvVw3NbCP6PYAktS5JrkptP77gL0iUQdp5WGDdq9qJoWbPCFHvMbhLY9jPopZ
	 X5UjncyIcwYGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4A3803263;
	Fri,  4 Oct 2024 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates
 2024-09-30 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800243276.2046214.17048231492451473680.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:40:32 +0000
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 30 Sep 2024 15:35:47 -0700 you wrote:
> This series contains updates to ice and idpf drivers:
> 
> For ice:
> 
> Michal corrects setting of dst VSI on LAN filters and adds clearing of
> port VLAN configuration during reset.
> 
> [...]

Here is the summary with links:
  - [net,01/10] ice: set correct dst VSI in only LAN filters
    https://git.kernel.org/netdev/net/c/839e3f9bee42
  - [net,02/10] ice: Fix improper handling of refcount in ice_dpll_init_rclk_pins()
    https://git.kernel.org/netdev/net/c/ccca30a18e36
  - [net,03/10] ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()
    https://git.kernel.org/netdev/net/c/d517cf89874c
  - [net,04/10] ice: clear port vlan config during reset
    https://git.kernel.org/netdev/net/c/d019b1a9128d
  - [net,05/10] ice: fix memleak in ice_init_tx_topology()
    https://git.kernel.org/netdev/net/c/c188afdc3611
  - [net,06/10] ice: disallow DPLL_PIN_STATE_SELECTABLE for dpll output pins
    https://git.kernel.org/netdev/net/c/afe6e30e7701
  - [net,07/10] ice: fix VLAN replay after reset
    https://git.kernel.org/netdev/net/c/0eae2c136cb6
  - [net,08/10] idpf: fix VF dynamic interrupt ctl register initialization
    https://git.kernel.org/netdev/net/c/d382c7bc236d
  - [net,09/10] idpf: use actual mbx receive payload length
    https://git.kernel.org/netdev/net/c/640f70063e6d
  - [net,10/10] idpf: deinit virtchnl transaction manager after vport and vectors
    https://git.kernel.org/netdev/net/c/09d0fb5cb30e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



