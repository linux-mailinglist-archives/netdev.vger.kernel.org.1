Return-Path: <netdev+bounces-165391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D8A31D31
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 05:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F95B3A526B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBCB1E7C1E;
	Wed, 12 Feb 2025 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsLvIwWO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481EC1E7C0E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332804; cv=none; b=RWf2ucpkn0fO2WgiU8okkolzXEK5KsGeKP2VKTYujyMfcuLFXwXIyIHgPQ5Re5Qh2iWATDsaOoutHxt50I00pBhQFTScQSHk38GDWNagGo+C2LDehliYnmllZJGlUExzQo4pe5IIgbDhLqFXJFFHwVUcdeeILL8UusQHZiehmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332804; c=relaxed/simple;
	bh=MBGU+Pq0MBuQC+vgEt5exhhxwTNOYq2/S9TaX4AIpiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ipEhiIf1pfKRwl0j5XadpcoFRHKzXeQNKYlJYIW1KbnQPJTnJXnX2loMXs5x9TZqNUdBU/V9up6eItxhAmHAxJHzc9K3JPOm+9W8MMvD12bCC4oitRSXmC7EulFma629IVz1MQBwP5UE8i9u5wISmEoy1JEskyvhUXsyFynxL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsLvIwWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A954DC4CEDF;
	Wed, 12 Feb 2025 04:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739332803;
	bh=MBGU+Pq0MBuQC+vgEt5exhhxwTNOYq2/S9TaX4AIpiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bsLvIwWOzXHBgwjocTPVrnT9qD48TTSMDvweE5de+mQIMSrBtVySNFY6QJp0v6+Tb
	 XL2LZtU7+9HefnXq2aJOKVH3iHkaBbuERI82/kJGZDMsDPHDejdrxh/HVmjKZI4J9R
	 9mxG26KrZPyK02UrJP7KyYYRZ8xQ/tcrTk5SC1jENXmIZuzMUhif23Svl9FrbiFHr5
	 fdsBOPWq6jQAzEIUAbhwB5QbqOJP73EIFSojGVn395jN2oX+W6EZRRdX+nVBYr8awu
	 XRUzMrAcY6dbYfnJ3mlzbLl5AjEcQiOMi2oMNUWO580UvbqGH9dFR29YnNXR69j172
	 kJqOPI7bDD/BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF479380AAFF;
	Wed, 12 Feb 2025 04:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10][pull request] Intel Wired LAN Driver Updates
 2025-02-10 (ice, igc, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173933283233.91069.10683338308401242928.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 04:00:32 +0000
References: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 10 Feb 2025 11:23:38 -0800 you wrote:
> For ice:
> 
> Karol, Jake, and Michal add PTP support for E830 devices. Karol
> refactors and cleans up PTP code. Jake allows for a common
> cross-timestamp implementation to be shared for all devices and
> Michal adds E830 support.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] ice: Don't check device type when checking GNSS presence
    https://git.kernel.org/netdev/net-next/c/e2c6737e6e82
  - [net-next,02/10] ice: Remove unnecessary ice_is_e8xx() functions
    https://git.kernel.org/netdev/net-next/c/9973ac9f23a7
  - [net-next,03/10] ice: Use FIELD_PREP for timestamp values
    https://git.kernel.org/netdev/net-next/c/ea7029fe10f4
  - [net-next,04/10] ice: Process TSYN IRQ in a separate function
    https://git.kernel.org/netdev/net-next/c/f9472aaabd1f
  - [net-next,05/10] ice: Add unified ice_capture_crosststamp
    https://git.kernel.org/netdev/net-next/c/92456e795ac6
  - [net-next,06/10] ice: Refactor ice_ptp_init_tx_*
    https://git.kernel.org/netdev/net-next/c/381d5779623a
  - [net-next,07/10] ice: Implement PTP support for E830 devices
    https://git.kernel.org/netdev/net-next/c/f00307522786
  - [net-next,08/10] ice: refactor ice_fdir_create_dflt_rules() function
    https://git.kernel.org/netdev/net-next/c/5a7b0b6ff49b
  - [net-next,09/10] igc: Avoid unnecessary link down event in XDP_SETUP_PROG process
    https://git.kernel.org/netdev/net-next/c/be324b790368
  - [net-next,10/10] e1000e: Fix real-time violations on link up
    https://git.kernel.org/netdev/net-next/c/13e22972471d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



