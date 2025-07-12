Return-Path: <netdev+bounces-206307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0985B028C7
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D295B1C8250B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CBE190679;
	Sat, 12 Jul 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URMTS3sY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0F1E487
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752282001; cv=none; b=naj7w3N/xxqhuc6tZxSdEUAn2AKqCAPiHQ5MBaxZBBrWHsIID2P1x6AAbV+f46lOnh5sw/M/AiSyerYlpMBX49jj5WIWFNN2WM4FuqQA/lQTykxNWS/rHfjIrbxA+o+NIykAUHzQjstiZAMqYKosjXy01ULGSa4fOREdvCUmvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752282001; c=relaxed/simple;
	bh=4T7fjmzTyO1c8GQIMbIsxqQD4A/zrKoiseiYePpKnTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XKwncjGj0XZaU2VjB5oFyWAjr8/MZBZr5ujutXsi2Pqam6UNtEb8Bba7xgMep911tRgtlI+V2KCSU4IcMAiDWKkBIacnjNvFJ8WIjcpDfox/VJ65XC3PhS7Kicbg9DqpGsLxRJEU5nFwLJqNtQ/3HgvgPIDk8VPLFC191lFBrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URMTS3sY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320BCC4CEED;
	Sat, 12 Jul 2025 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752282001;
	bh=4T7fjmzTyO1c8GQIMbIsxqQD4A/zrKoiseiYePpKnTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=URMTS3sYuXIJecPJoKLqpGpd3tjn8/bTWppEDWxl7kVo6J+5n6qCjPPpNO37t/XBJ
	 aoQOEvRvwYCLRZKJ5NML2T5lJ/lTvrg83EEfugBEh3Kpm5FhFtPOOzQ+qmrKcZavd7
	 d5CMz09YbAApd6LE+sYeFhPI8PFe6hLQDed97UQXYIr8uV4oKXsHGXX61kpnf8+kri
	 bzTORsW/nlE4ggZwzOccD69VIu7fcDCyo779sJYWQcdhLmjYppJzeWN4RK/8bUb9b+
	 6zIIWgConRLXMoi+VrZBpgaNlh0tpEMnlvP8sQfTdlO/PnfoSWY6e9dJtMh6vzHR/g
	 IEENE2z4Zj2JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB313383B275;
	Sat, 12 Jul 2025 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8][pull request] ice: cleanups and preparation
 for
 live migration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175228202249.2451869.6977283175523382881.git-patchwork-notify@kernel.org>
Date: Sat, 12 Jul 2025 01:00:22 +0000
References: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, madhu.chittim@intel.com, yahui.cao@intel.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 10 Jul 2025 14:45:09 -0700 you wrote:
> Jake Keller says:
> 
> Various cleanups and preparation to the ice driver code for supporting
> SR-IOV live migration.
> 
> The logic for unpacking Rx queue context data is added. This is the inverse
> of the existing packing logic. Thanks to <linux/packing.h> this is trivial
> to add.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ice: add support for reading and unpacking Rx queue context
    https://git.kernel.org/netdev/net-next/c/ef41603d09f1
  - [net-next,2/8] ice: add functions to get and set Tx queue context
    https://git.kernel.org/netdev/net-next/c/b6f82e9b79b1
  - [net-next,3/8] ice: save RSS hash configuration for migration
    https://git.kernel.org/netdev/net-next/c/5ff8d9562357
  - [net-next,4/8] ice: move ice_vsi_update_l2tsel to ice_lib.c
    https://git.kernel.org/netdev/net-next/c/4f98ac2d8e53
  - [net-next,5/8] ice: expose VF functions used by live migration
    https://git.kernel.org/netdev/net-next/c/066c2715ada8
  - [net-next,6/8] ice: use pci_iov_vf_id() to get VF ID
    https://git.kernel.org/netdev/net-next/c/4ef21c83ea4b
  - [net-next,7/8] ice: avoid rebuilding if MSI-X vector count is unchanged
    https://git.kernel.org/netdev/net-next/c/922683498e84
  - [net-next,8/8] ice: introduce ice_get_vf_by_dev() wrapper
    https://git.kernel.org/netdev/net-next/c/2d925db5b2c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



