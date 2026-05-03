Return-Path: <netdev+bounces-283529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJP1LiSx9mmgXgIAu9opvQ
	(envelope-from <netdev+bounces-283529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:21:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5F4B421B
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60F94300678E
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B602389DF3;
	Sun,  3 May 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN2/APS/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BE314B6E;
	Sun,  3 May 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774876; cv=none; b=Myo0BTDQMSM4Y+DwSfnqDYDSWLcI0Thjlj+T5v2wlzxlrWRZupdbP/xVg7grMYsJjwZCLBramKpsaXT/rZhWiSgebLOJHgiyAl3tXY4fVMb7SlCYcyNKRYKKtRMDwYNx3nvRoRN9Ej1TUlgxxL6BV+ewpzPDYNzzXlkoi+PQ/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774876; c=relaxed/simple;
	bh=7/2FttqZOTYZaevy/I9Wm5pYiOwh6xxN/NRIh5nUNrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lxZvi+jGujYAMaV+wlMSroZsv49eO9v5ObxWqdZGfwQhkPCR6IkEvA8vI8fyyTgioQ73UxF7Le1vrPd+qOqdF3dEvl0T6VrZdvJ0ss3HXRirl3inlGt4ygiY9nIJVKRwjWNACiaXU6+TOcfX976BidV59wd7B6XZQCytb8bdVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN2/APS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F44C19425;
	Sun,  3 May 2026 02:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774876;
	bh=7/2FttqZOTYZaevy/I9Wm5pYiOwh6xxN/NRIh5nUNrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DN2/APS/lkHDiLq6nB4dxsTJU78TiHXEzqMUQh4VCSOoIS5Y9WkKGVhv4AGx7j9bm
	 ub5fehTU4+Q55U3pMgsd7jJcqVD2P6z82VeJ409TqNmh7wcm3fPq+nO+0dxBfMeHFG
	 GbbHrd+UKoWWMih7W322BLQRDj8IHxq2e9ZslyvbLJtj9GpzI/t6jR/UnkYF12EC5k
	 rCsl+IwgENAFd/M3fHOuQyoMkj1/aWUVHctaKY+gVNzXlpISw/sS7/AH2VLClAzo+x
	 M/d+TS7VVeWfsIzaVgtVY5tkXpLRXHUOXHwvOiZMW0bm8uKffUxS2s1ak8j61dPrL3
	 OgHHS/xev8a+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDF3380CFEC;
	Sun,  3 May 2026 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] Intel Wired LAN Updates 2024-04-30 (ixgbe,
 i40e, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177777482779.3993534.10771712863528181433.git-patchwork-notify@kernel.org>
Date: Sun, 03 May 2026 02:20:27 +0000
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aleksander.lobakin@intel.com, horms@kernel.org,
 michal.swiatkowski@linux.intel.com, jedrzej.jagielski@intel.com,
 aleksandr.loktionov@intel.com, grzegorz.nitka@intel.com, ivecera@redhat.com,
 arkadiusz.kubalewski@intel.com, anthony.l.nguyen@intel.com,
 stefan.wegrzyn@intel.com, piotr.kwapulinski@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sx.rinitha@intel.com,
 pmenzel@molgen.mpg.de, byungchul@sk.com, alexander.nowlin@intel.com,
 david@kernel.org, przemyslaw.korba@intel.com, sunithax.d.mekala@intel.com
X-Rspamd-Queue-Id: 2FE5F4B421B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283529-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 23:37:11 -0700 you wrote:
> This series includes updates to support Energy-Efficient Ethernet (EEE) on
> E610 devices in the ixgbe driver, support for an unmanaged DPLL output on
> E830, as well as some other minor cleanups and improvements across ixgbe,
> i40e, and ice.
> 
> Jedrzej begins with the first six patches preparing the ixgbe driver to
> support EEE, adding a EEE capability flag, updating the supported EEE
> speeds, updating the ACI command structures with the fields related to
> EEE, moving the EEE config validation out for re-use, and finally
> implementing the EEE support for E610 hardware.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] ixgbe: E610: add discovering EEE capability
    https://git.kernel.org/netdev/net-next/c/54f63d24ce20
  - [net-next,02/15] ixgbe: E610: update EEE supported speeds
    https://git.kernel.org/netdev/net-next/c/c5f1ee0c6a7b
  - [net-next,03/15] ixgbe: E610: use new version of 0x601 ACI command buffer
    (no matching commit)
  - [net-next,04/15] ixgbe: E610: update ACI command structs with EEE fields
    (no matching commit)
  - [net-next,05/15] ixgbe: move EEE config validation out of ixgbe_set_eee()
    https://git.kernel.org/netdev/net-next/c/e4607a52723f
  - [net-next,06/15] ixgbe: E610: add EEE support
    https://git.kernel.org/netdev/net-next/c/b61dbdeff3a9
  - [net-next,07/15] ixgbe: E610: add ACI dynamic debug
    (no matching commit)
  - [net-next,08/15] ixgbe: E610: remove redundant assignment
    (no matching commit)
  - [net-next,09/15] ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
    https://git.kernel.org/netdev/net-next/c/eae23ec14a9c
  - [net-next,10/15] i40e: only timestamp PTP event packets
    https://git.kernel.org/netdev/net-next/c/b71fcc5c0bb3
  - [net-next,11/15] ice: mention fw_activate action along with devlink reload
    https://git.kernel.org/netdev/net-next/c/3f923a48dac0
  - [net-next,12/15] ice: access @pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/b9fa4b9e051b
  - [net-next,13/15] ice: dpll: Fix compilation warning
    https://git.kernel.org/netdev/net-next/c/586483cb41f4
  - [net-next,14/15] ice: dpll: fix rclk pin state get and misplaced header macros
    (no matching commit)
  - [net-next,15/15] ice: add support for unmanaged DPLL on E830 NIC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



