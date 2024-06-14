Return-Path: <netdev+bounces-103432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A0908024
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C358F1F22FEF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0F19D88E;
	Fri, 14 Jun 2024 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuYLBKgB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97FB67A;
	Fri, 14 Jun 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718324442; cv=none; b=eSWIZxCSOuoKz91QgXbRxMa/53NsUjEA31xY9XIw5JyU3JruhQf8eRE/bwQa+VeeNGc2JUmranbEAZy9BKly/wOOr6aDHfvP3W3YEI2zj6xBXcxBv7HpLQuZDmn52Z8nSaiTwgS5hHNFGMkrP8N7nUkA1sA1Lw4nsCgYEthdCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718324442; c=relaxed/simple;
	bh=S/2pfU1IGSj701N+VWuSME9P0RlCpEu9nKujv7ihyS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kX5R2LBZO0EBThK+WMyo6dMh7WMWljbrT/9kkpXbiOcTxzDMy13cxS/N0FrfBaoxoABD0uQXVyVpYOIYCjys0ujQDuHQYYvqOMEZ4LNLJceI00awU/fCGWsvHX9PLPff+UgDjgYOKbPtHBz4iuIyFncC4diDHRPeEm+n4UsaY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuYLBKgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FB8BC4AF1C;
	Fri, 14 Jun 2024 00:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718324441;
	bh=S/2pfU1IGSj701N+VWuSME9P0RlCpEu9nKujv7ihyS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uuYLBKgBes4bUU62q0xu2I8Alf3Td9Ku5reUbAWCaNF0i7eNNGH2MehRwPmx1EdsX
	 k+Bth8QON6oZtZtNRkUd2p+8TCyIXB51ajDUvlaqohRNu/5E/l3QGvS4mEo0nnFkgz
	 mTeWE8GHgwb1unMmdRXLHLtkN6tHoTHSJ+02OSUiRDY+HVBsTAqZ5mFU+aYL80jVZ7
	 dL299+AO2CZSfFTrYaXJAIlFUaZEnFXJAldGOOX5dt4UiMFVWrWziapKpGDj++9PDk
	 PCFOzx00gIi8q7y1boqAmMgNWbnvG30oh/Fg6xj7dvg4ZzKUXhMczewB84Z3PqJ5Nc
	 VJXf88jggKrDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82C7BC43619;
	Fri, 14 Jun 2024 00:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/12] net: dsa: lantiq_gswip: code improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171832444153.14234.12409372518780096116.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 00:20:41 +0000
References: <20240611135434.3180973-1-ms@dev.tdt.de>
In-Reply-To: <20240611135434.3180973-1-ms@dev.tdt.de>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jun 2024 15:54:22 +0200 you wrote:
> This patchset for the lantiq_gswip driver is a collection of minor fixes
> and coding improvements by Martin Blumenstingl without any real changes
> in the actual functionality.
> 
> === Changelog ===
> From v4:
> - merge dt-bindings patches to satisfy 'make dt_bindings_check' and add
>   some improvements suggested by Rob Herring
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/12] dt-bindings: net: dsa: lantiq,gswip: convert to YAML schema
    https://git.kernel.org/netdev/net-next/c/c7f75954212b
  - [net-next,v5,02/12] net: dsa: lantiq_gswip: Only allow phy-mode = "internal" on the CPU port
    https://git.kernel.org/netdev/net-next/c/b98f122ebdac
  - [net-next,v5,03/12] net: dsa: lantiq_gswip: add terminating \n where missing
    https://git.kernel.org/netdev/net-next/c/dd6d364e1895
  - [net-next,v5,04/12] net: dsa: lantiq_gswip: Use dev_err_probe where appropriate
    https://git.kernel.org/netdev/net-next/c/1763b155da02
  - [net-next,v5,05/12] net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
    https://git.kernel.org/netdev/net-next/c/f5ebf9ab6094
  - [net-next,v5,06/12] net: dsa: lantiq_gswip: do also enable or disable cpu port
    https://git.kernel.org/netdev/net-next/c/86b9ea6412af
  - [net-next,v5,07/12] net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in gswip_port_change_mtu()
    https://git.kernel.org/netdev/net-next/c/7168ec1b0669
  - [net-next,v5,08/12] net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
    https://git.kernel.org/netdev/net-next/c/c927b6e47b5c
  - [net-next,v5,09/12] net: dsa: lantiq_gswip: Consistently use macros for the mac bridge table
    https://git.kernel.org/netdev/net-next/c/e6c34597f89a
  - [net-next,v5,10/12] net: dsa: lantiq_gswip: Remove dead code from gswip_add_single_port_br()
    https://git.kernel.org/netdev/net-next/c/b068706b7831
  - [net-next,v5,11/12] net: dsa: lantiq_gswip: Update comments in gswip_port_vlan_filtering()
    https://git.kernel.org/netdev/net-next/c/e19fbe3996aa
  - [net-next,v5,12/12] net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()
    https://git.kernel.org/netdev/net-next/c/3b0a95ed7782

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



