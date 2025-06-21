Return-Path: <netdev+bounces-199986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F3AE29D9
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D37A87FD
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EBF21171D;
	Sat, 21 Jun 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH0smesm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C22AE8D
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519787; cv=none; b=LjCWpb4xjMmM4aOyXimkN0k0psfBBrjmC37Nezp12+H19enttylLkj11KuOMkyVLFCWZEWZaVvv2N8HGHGmxfbsIh7ltrrVImUe9tMOZOP+nE3sHqm8STBVAkkfbRkiXDSCgtHyjNhFRxaMpRYsPjUX0Te5/DTeW6rxRu7ty39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519787; c=relaxed/simple;
	bh=0sOl46Fqyta5hEsuIgoFswul/PQm5Xb+k1G3TrZCyN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tAw7fbuUIwFYTT1rpNfarQIvnG19Hz0SbPnevp6/SRDvh6urTUqNMjbnGcxQeg2/BoRikJCTAHohysqp3USfUdI/cjElLafFLum9Glni4ZRPYvFKIH2HRO3YzSfKTz2JYFMcR6Pa6R3sbUxlI8BDOFA5jid0k+sB4K8cRvEzXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH0smesm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F6DC4CEE7;
	Sat, 21 Jun 2025 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750519785;
	bh=0sOl46Fqyta5hEsuIgoFswul/PQm5Xb+k1G3TrZCyN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pH0smesmRIb8HSo6Qi9DjgkGIMAcCOGkH0Xa++JXK1VVoZiTfO1FwUwNK8XtovC6q
	 a/+DXnAnkqfXo5jsSDSCj3El8SLcXXnZ4ZUjR7Rauht3+cO28q4Za8MJ162xOaha2f
	 8d7A4CXQoIDoOPvE2YXAvzhsez4S75gbX4mxJrFP6PfdrwUwrcTlxxBOVrwNEl9EMJ
	 vVZFFNjEbTn8JODAH5dGCS4g5/phV0Ffwq0yEV/7oOuM1KlWSWZHHxpTYlFNxyOEwh
	 koGJoLQr0ypzSAu7vqGrUb6NqfU4LXFHq7cm94YQOZ9HPt1qynssYRe4TkLM7Idtq4
	 4EQR9ouPGRcCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE838111DD;
	Sat, 21 Jun 2025 15:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] ice: Separate TSPLL from PTP
 and
 clean up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051981350.1884019.11630901452981986071.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:30:13 +0000
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 karol.kolacinski@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 18 Jun 2025 10:42:12 -0700 you wrote:
> Jake Keller says:
> 
> Separate TSPLL related functions and definitions from all PTP-related
> files and clean up the code by implementing multiple helpers.
> 
> Adjust TSPLL wait times and fall back to TCXO on lock failure to ensure
> proper init flow of TSPLL.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] ice: move TSPLL functions to a separate file
    https://git.kernel.org/netdev/net-next/c/be7f0c1f47c7
  - [net-next,02/15] ice: rename TSPLL and CGU functions and definitions
    https://git.kernel.org/netdev/net-next/c/1ff7a6c5d3f5
  - [net-next,03/15] ice: fix E825-C TSPLL register definitions
    https://git.kernel.org/netdev/net-next/c/bf12bc439407
  - [net-next,04/15] ice: remove ice_tspll_params_e825 definitions
    https://git.kernel.org/netdev/net-next/c/b14b2d076ce8
  - [net-next,05/15] ice: use designated initializers for TSPLL consts
    https://git.kernel.org/netdev/net-next/c/b3b26c983a55
  - [net-next,06/15] ice: add TSPLL log config helper
    https://git.kernel.org/netdev/net-next/c/0dffcea4121a
  - [net-next,07/15] ice: add ICE_READ/WRITE_CGU_REG_OR_DIE helpers
    (no matching commit)
  - [net-next,08/15] ice: clear time_sync_en field for E825-C during reprogramming
    (no matching commit)
  - [net-next,09/15] ice: read TSPLL registers again before reporting status
    (no matching commit)
  - [net-next,10/15] ice: use bitfields instead of unions for CGU regs
    (no matching commit)
  - [net-next,11/15] ice: add multiple TSPLL helpers
    (no matching commit)
  - [net-next,12/15] ice: wait before enabling TSPLL
    (no matching commit)
  - [net-next,13/15] ice: fall back to TCXO on TSPLL lock fail
    (no matching commit)
  - [net-next,14/15] ice: move TSPLL init calls to ice_ptp.c
    (no matching commit)
  - [net-next,15/15] ice: default to TIME_REF instead of TXCO on E825-C
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



