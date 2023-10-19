Return-Path: <netdev+bounces-42590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2B57CF768
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A11281FA2
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65951DDFC;
	Thu, 19 Oct 2023 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thXYzELZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCE168BE
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9A70C433C8;
	Thu, 19 Oct 2023 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697716223;
	bh=TdY+XiXmmLD91TpIQcO/N8dKvhER81eOGRqSvvlvp90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=thXYzELZ4SFp/pwUtNac/XwJOsb/5eBCmGhLHEmFGw8pBxFA1BNVanb7bLL9kfsMC
	 dlgpxKXQfTFy0Y+b3sZtiLNwxOPSjl+3+LpIozYMpmdgSWM5WWuMEkkiZ60XOrdw6C
	 qIZoo8XF0v6DBPIDxPIyY0843ygwZZSxM9vHzv2m1939dM0VeRtNfQiTtbQeGraLdC
	 USKTGI+eubkaoeCpXcjogQqxh0zy/T1ViK1KslpbpVavDsBr25Hlt3jQVKpaNXV4g6
	 L6JxoizAg2tIDpRceqWfKArlp0VEQaKRVqQX1+jn0Z8wGZaCTmhfHUjea9FOYxZWe+
	 z1TQfswP6V9wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5D3EC595CE;
	Thu, 19 Oct 2023 11:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] iavf: delete unused iavf_mac_info fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169771622387.21633.5843251100307704107.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 11:50:23 +0000
References: <20231018111527.78194-1-mschmidt@redhat.com>
In-Reply-To: <20231018111527.78194-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 13:15:27 +0200 you wrote:
> 'san_addr' and 'mac_fcoeq' members of struct iavf_mac_info are unused.
> 'type' is write-only. Delete all three.
> 
> The function iavf_set_mac_type that sets 'type' also checks if the PCI
> vendor ID is Intel. This is unnecessary. Delete the whole function.
> 
> If in the future there's a need for the MAC type (or other PCI
> ID-dependent data), I would prefer to use .driver_data in iavf_pci_tbl[]
> for this purpose.
> 
> [...]

Here is the summary with links:
  - [net-next] iavf: delete unused iavf_mac_info fields
    https://git.kernel.org/netdev/net-next/c/a0e6323dbae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



