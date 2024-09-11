Return-Path: <netdev+bounces-127195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9575A97487C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298B3289721
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A22839FE4;
	Wed, 11 Sep 2024 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOS90N80"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEA18651
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726024241; cv=none; b=k0mDYS74hxX1i0SXUyz2ReBeZXpp8NJqPTGIgws0mKlR93bNzpc0mI541usMkNDZkSEcAbwGzhHIZAH1HO7ZCh27ZM1yG64jiJ74sXivPLNGcwm3RJBrpX4eLCfX97+THJpak1BA6CIDiT/2q5/vL3osapzDmL13zvEitMSNnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726024241; c=relaxed/simple;
	bh=ZKzFqB9fvzuUK5Jxa7r9iW/eRGH6Eq9N7dsgoZuupHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lxisr0dZi1gQLOUHrX1vMsP2QXSiLUrkIwD+IkL7AHcTFD2wa71SxKzQ8qS38o5Xa9IGnl8ec0NA81TzLzrroDnoygbjtH2u6YFCAUfaZGe+Zllg3U6uMB3nYG1XAy/DzmaHaWengeZubaf3u0sl/hu9tu37EaRjICLL02rDCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOS90N80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC105C4CEC4;
	Wed, 11 Sep 2024 03:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726024240;
	bh=ZKzFqB9fvzuUK5Jxa7r9iW/eRGH6Eq9N7dsgoZuupHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uOS90N809i+B9948CFPerffeELGac75HVf3Gic3mLLK8J3B092Ol4dZ+HxV2TD5iV
	 F8muPrgISOj0nlf4GfOgWuPQqMXRHICohg7CrUrahWwdwtX4xAl0UZ+8RGmskkJQ1p
	 A2tRTYQnxhhoYkVcNoa3msvPh6q6qUIys6IeM34tJmTndGr1Zhv7p0h7hREOxLfBwy
	 e61+Aw8y2qIbY68gPFDDVaxs25FynLJHQv9UKfIQ3A9OjCqFDwVbrpa5kgwzgJg8Ed
	 h/K4dliI785d8F8JtkMvWbrB4O4OpEP9bh0MNpuW7FHJ7zeNKVlb1Yjz/aEZMn2Y2x
	 8i7SvFXS770YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE283822FA4;
	Wed, 11 Sep 2024 03:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/15][pull request] ice: support devlink
 subfunction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602424149.471616.16275966274391337938.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 03:10:41 +0000
References: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, jiri@nvidia.com, shayd@nvidia.com,
 wojciech.drewek@intel.com, horms@kernel.org, sridhar.samudrala@intel.com,
 mateusz.polchlopek@intel.com, kalesh-anakkur.purayil@broadcom.com,
 michal.kubiak@intel.com, pio.raczynski@gmail.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 maciej.fijalkowski@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri,  6 Sep 2024 15:29:51 -0700 you wrote:
> Michal Swiatkowski says:
> 
> Currently ice driver does not allow creating more than one networking
> device per physical function. The only way to have more hardware backed
> netdev is to use SR-IOV.
> 
> Following patchset adds support for devlink port API. For each new
> pcisf type port, driver allocates new VSI, configures all resources
> needed, including dynamically MSIX vectors, program rules and registers
> new netdev.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/15] ice: add new VSI type for subfunctions
    https://git.kernel.org/netdev/net-next/c/597b8af58bb2
  - [net-next,v5,02/15] ice: export ice ndo_ops functions
    https://git.kernel.org/netdev/net-next/c/004688c4cb5b
  - [net-next,v5,03/15] ice: add basic devlink subfunctions support
    https://git.kernel.org/netdev/net-next/c/eda69d654c7e
  - [net-next,v5,04/15] ice: treat subfunction VSI the same as PF VSI
    https://git.kernel.org/netdev/net-next/c/747967b0bbfa
  - [net-next,v5,05/15] ice: allocate devlink for subfunction
    https://git.kernel.org/netdev/net-next/c/f43e3be662e6
  - [net-next,v5,06/15] ice: base subfunction aux driver
    https://git.kernel.org/netdev/net-next/c/177ef7f1e2a0
  - [net-next,v5,07/15] ice: implement netdev for subfunction
    https://git.kernel.org/netdev/net-next/c/8f9b681adb44
  - [net-next,v5,08/15] ice: make representor code generic
    https://git.kernel.org/netdev/net-next/c/415db8399d06
  - [net-next,v5,09/15] ice: create port representor for SF
    https://git.kernel.org/netdev/net-next/c/977514fb0fa8
  - [net-next,v5,10/15] ice: don't set target VSI for subfunction
    https://git.kernel.org/netdev/net-next/c/ef2509037172
  - [net-next,v5,11/15] ice: check if SF is ready in ethtool ops
    https://git.kernel.org/netdev/net-next/c/0f00a897c9fc
  - [net-next,v5,12/15] ice: implement netdevice ops for SF representor
    https://git.kernel.org/netdev/net-next/c/54f077123952
  - [net-next,v5,13/15] ice: support subfunction devlink Tx topology
    https://git.kernel.org/netdev/net-next/c/7cde47431df5
  - [net-next,v5,14/15] ice: basic support for VLAN in subfunctions
    https://git.kernel.org/netdev/net-next/c/0c6a3cb6f181
  - [net-next,v5,15/15] ice: subfunction activation and base devlink ops
    https://git.kernel.org/netdev/net-next/c/13acc5c4cdbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



