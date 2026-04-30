Return-Path: <netdev+bounces-282755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3+b/Bdcq82nMxwEAu9opvQ
	(envelope-from <netdev+bounces-282755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313C4A08ED
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B8A3052A29
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1FC3A6B99;
	Thu, 30 Apr 2026 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUbGELC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23D377ECA
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543266; cv=none; b=ssQzObgDJ6WqddYyTJbqgCT9/dZL7EE8IwqF3fVVaHTqyIgBxuKKtA4/upTAPHKQezEH2xKdHXuSRCI2BdmtCSIuosvK9Z/VZ+gqp1atkFDHiC5HmRpeODfwTOzLKWZZxo0OI7josxl74CkU/Y39z2/ov3uMZlHzDwoQAbjMcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543266; c=relaxed/simple;
	bh=4uNn5VjlMIxviBM8I2EAC/V5geQPmRJJ5m8IuNt0Bi0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FkxYv2z4zV9yiDHB7n+zlEVlB6UzkQr9j9ZCdqRpFsZB1vqwAGKhPYgQfFaQsVhJtH1hC2Mn9aGwVwp2sSTMXBSyrgh3NqS6ErRDtFjv2TpOJB8+mDDhUjvL2XNh3iJXNODY/xYTDrTguhsmLFdaCWaREhlgt6NX3kO5MdgvRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUbGELC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15B2C2BCB3;
	Thu, 30 Apr 2026 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543265;
	bh=4uNn5VjlMIxviBM8I2EAC/V5geQPmRJJ5m8IuNt0Bi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lUbGELC0pfLQ+kxFkajY+Xn1bZUl/Af1m/GldBcX8VN6spiicOj1321B1595Vii1r
	 16mC/Km8J7Phv+FY/rCUga6MJXBdz3bpF3Si3PUeEYiLy9deVJELbaRTa9003Ta5yn
	 Mz+HBn3J0xpjtvlwPfBSgSfbFQH/CYxGrzEpWY2g7Zy0m77FVa67IhB/fWDdnBDVEp
	 0P/pbG5OkP++6RyYWGeWoGT0yFpSS/uQXnZ2nfmkKaWoUh2mY7cFzphLZMELcPGNed
	 P/28ZdLyt6HbeVdfehAN4wthejrWMkUDzfiHAcpn9Mz2tkBLgnf4NuTjt6E0HjobK+
	 cPEDI/+5UdFfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F34380A965;
	Thu, 30 Apr 2026 10:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/11] Intel Wired LAN Update 2026-04-27 (ice, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177754322054.2492956.9695571168501500899.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 10:00:20 +0000
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, poros@redhat.com,
 rafal.romanowski@intel.com, pmenzel@molgen.mpg.de,
 alexander.nowlin@intel.com, ivecera@redhat.com,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev
X-Rspamd-Queue-Id: 6313C4A08ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282755-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 27 Apr 2026 22:22:12 -0700 you wrote:
> Petr Oros from RedHat has accumulated a number of fixes for the Intel ice
> and iavf drivers, bundled together in this series.
> 
> First, a series of 4 fixes to resolve issues with the iavf driver logic for
> handling VLAN filters. This includes keeping VLAN filters while the
> interface is brought down, waiting for confirmation on filter deletion
> before deleting filters from the driver tracking structures, and handling
> the VIRTCHNL_OP_ADD_VLAN for the old v1 VLAN_ADD command.
> 
> [...]

Here is the summary with links:
  - [net,01/11] iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
    https://git.kernel.org/netdev/net/c/70d62b669f1f
  - [net,02/11] iavf: stop removing VLAN filters from PF on interface down
    https://git.kernel.org/netdev/net/c/f2ce65b9b917
  - [net,03/11] iavf: wait for PF confirmation before removing VLAN filters
    https://git.kernel.org/netdev/net/c/bbcbe4ed70de
  - [net,04/11] iavf: add VIRTCHNL_OP_ADD_VLAN to success completion handler
    https://git.kernel.org/netdev/net/c/34d33313b52e
  - [net,05/11] ice: fix NULL pointer dereference in ice_reset_all_vfs()
    https://git.kernel.org/netdev/net/c/54ef02487914
  - [net,06/11] ice: fix infinite recursion in ice_cfg_tx_topo via ice_init_dev_hw
    https://git.kernel.org/netdev/net/c/70ad216411e0
  - [net,07/11] ice: fix missing SMA pin initialization in DPLL subsystem
    https://git.kernel.org/netdev/net/c/56a643aed0f0
  - [net,08/11] ice: fix SMA and U.FL pin state changes affecting paired pin
    https://git.kernel.org/netdev/net/c/6f9d8393c9f5
  - [net,09/11] dpll: export __dpll_pin_change_ntf() for use under dpll_lock
    (no matching commit)
  - [net,10/11] ice: fix missing dpll notifications for SW pins
    https://git.kernel.org/netdev/net/c/1a41b58fd4dc
  - [net,11/11] ice: add dpll peer notification for paired SMA and U.FL pins
    https://git.kernel.org/netdev/net/c/9e5dead140af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



