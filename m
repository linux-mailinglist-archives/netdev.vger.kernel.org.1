Return-Path: <netdev+bounces-167149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4C5A39044
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D805E171CC6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A913AA5D;
	Tue, 18 Feb 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2t11Z/B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BB1D52B
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841618; cv=none; b=jJSYx5IGl1fwc+yF8k2b78G5mGP/WBmufQzSrm1fdFqV5OYyqLfAdT1mqeTmjoElpCjtqV3OLJsbrSjoExTlP08CP+G4zxTiqux+nzRW+IhAnLbIxQMjJMaYyHZipKfhmxPDJMFYS/7vADrydBxXDPCs4c3keefGP2a4pu4Hg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841618; c=relaxed/simple;
	bh=62ykx+NprHU870eKrEb3e/xXgurLmgy4kqEkLtSU4qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WlxFBlOlZn0umLgRkeHHQ9WOrdwATUhjsq3yTV9rkueAhBbAtyL/7PKXEAwAnR/RSoeTzSnvIPVH5ueKEQ6RntyK2M33kyixWgrYJs0wD+BqvB2GrSh5lNc2x1BdaV+fF/JkHn87Lko/rWBpy6bWkj2bKHi2e6//r/SnYHZuYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2t11Z/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2CFC4CED1;
	Tue, 18 Feb 2025 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841617;
	bh=62ykx+NprHU870eKrEb3e/xXgurLmgy4kqEkLtSU4qc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2t11Z/BXXuNMb3tiuiyH5z8rzto5ghZ5Bk3dBiGjvsVNn04xXNGNIkcLCfN5QJ2R
	 vNDerq6m8v5UkpdkY7VrD7XEUyNyc+ksLovW39bRcXDkdebbsV0k12FDKtN/pyo9rO
	 y4xcRK5ZECB9tJZw8oScTrxJthuYdnoSkxbWh8nRgiQkZpwjqRFETKG/I5L2sxjcRY
	 c6CFDm2ObNZbXa5fo8Nsr7B7yDau1oLiDDlQpCdxhovUC+I2oZhHPv3SHZ3sscenPP
	 usTxSrTFD5D1Pth0ijzhtHaQ1EfrvkhCsNeCJygkE/2XCU6Sp7x4m138aHMoMmJphL
	 QX4UBy/ThnQQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E85380AAD5;
	Tue, 18 Feb 2025 01:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14][pull request] ice,
 iavf: Add support for Rx timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984164724.3591662.3212685059102199325.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:47 +0000
References: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mateusz.polchlopek@intel.com, jacob.e.keller@intel.com,
 richardcochran@gmail.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 14 Feb 2025 11:27:21 -0800 you wrote:
> Mateusz Polchlopek says:
> 
> Initially, during VF creation it registers the PTP clock in
> the system and negotiates with PF it's capabilities. In the
> meantime the PF enables the Flexible Descriptor for VF.
> Only this type of descriptor allows to receive Rx timestamps.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] virtchnl: add support for enabling PTP on iAVF
    https://git.kernel.org/netdev/net-next/c/27ebd8bf9e4b
  - [net-next,02/14] ice: support Rx timestamp on flex descriptor
    https://git.kernel.org/netdev/net-next/c/7c1178a9df58
  - [net-next,03/14] virtchnl: add enumeration for the rxdid format
    https://git.kernel.org/netdev/net-next/c/6a88c797ab40
  - [net-next,04/14] iavf: add support for negotiating flexible RXDID format
    https://git.kernel.org/netdev/net-next/c/2a86e210f1a1
  - [net-next,05/14] iavf: negotiate PTP capabilities
    https://git.kernel.org/netdev/net-next/c/3247d65ad9de
  - [net-next,06/14] iavf: add initial framework for registering PTP clock
    https://git.kernel.org/netdev/net-next/c/d734223b2f0d
  - [net-next,07/14] iavf: add support for indirect access to PHC time
    https://git.kernel.org/netdev/net-next/c/52e3beac764d
  - [net-next,08/14] iavf: periodically cache PHC time
    https://git.kernel.org/netdev/net-next/c/7c01dbfc8a1c
  - [net-next,09/14] libeth: move idpf_rx_csum_decoded and idpf_rx_extracted
    https://git.kernel.org/netdev/net-next/c/ce5cf4af7ceb
  - [net-next,10/14] iavf: define Rx descriptors as qwords
    https://git.kernel.org/netdev/net-next/c/e9f476d7b39c
  - [net-next,11/14] iavf: refactor iavf_clean_rx_irq to support legacy and flex descriptors
    https://git.kernel.org/netdev/net-next/c/2dc8e7c36d80
  - [net-next,12/14] iavf: Implement checking DD desc field
    https://git.kernel.org/netdev/net-next/c/8447357e7b04
  - [net-next,13/14] iavf: handle set and get timestamps ops
    https://git.kernel.org/netdev/net-next/c/51534239ef13
  - [net-next,14/14] iavf: add support for Rx timestamps to hotpath
    https://git.kernel.org/netdev/net-next/c/48ccdcd87e0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



