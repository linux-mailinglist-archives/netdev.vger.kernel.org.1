Return-Path: <netdev+bounces-177151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C1BA6E1A0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978A33BC90F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47748266EF4;
	Mon, 24 Mar 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZAE83rU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16009264A82;
	Mon, 24 Mar 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838001; cv=none; b=lhctGcuV+HejKwW6Mrah6A0h5dp53ALVy5jbAwf6jjiDdp7Md3Ux46wkn/K2lT48bMOJli2T7mYIJ/Bpj+wEIz7B3+gDWXNlJYXWdMTJLW2BA3AxM6VWWxMPgUmmkLWndcfJ8hVarh/OZHRpVMxadNQFgog1nsrtNqNmVSd4nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838001; c=relaxed/simple;
	bh=0h3fEpcG2h6vwvSoH1vLGxdZ+ohIYB6B1qTUxw1rpi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CeoR4e+ZYbgFvEuQDpS5m/001A5yL3HL+SCXNCFwZcVHOCIXc/dx2/aNbWJnAPhzuHEbSz3pos1xFeUlIMMyI6dtvIsxziEibC+7z/dQrSCyftC3DlWnKDn7Qit61LAWUwkUrvNVLE5FNrpTODPJ+11qSnKHwPPC2inA0i7Zoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZAE83rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0013C4CEDD;
	Mon, 24 Mar 2025 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838000;
	bh=0h3fEpcG2h6vwvSoH1vLGxdZ+ohIYB6B1qTUxw1rpi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VZAE83rU2ecbwSpVIYvv4e8JplIj11RHcuiKPpFnc/EscujBHB1xwEoqadeA/gSMu
	 gF7o/LcKPUDksoAWvIC7N7r5fqLb2Lao8vr2k1iV9af/hCFciuzOOP0Dy3OQWqG1XM
	 J1gqJQa7hj6qlS7dOsv6fEjWUW/qcLkziUaNK1zp7yNrrQy79ek33QuOTZgg5Tnwph
	 /tSV5tPQs8hNY4CfQ2wsMWA0MGQNi5u48Kr2COVP2gQKbLSZBuLQ91RFCYT/RUQanG
	 aRN4k8zgJLRwZNr6SOhDVTaq9+1vJBlaIN4bazM0TNJRoO3YA71tm4sJi1u8gaM+M+
	 of1yLauXpYNFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344CD380664D;
	Mon, 24 Mar 2025 17:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: adjust the file entry in INTEL PMC CORE
 DRIVER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174283803703.4111679.16944875339662746816.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 17:40:37 +0000
References: <20250317092717.322862-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20250317092717.322862-1-lukas.bulwahn@redhat.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@intel.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, chao.qin@intel.com,
 yong.liang.choong@linux.intel.com, kuba@kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, lukas.bulwahn@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 10:27:17 +0100 you wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add
> SoC register access") adds a new file entry referring to the non-existent
> file linux/platform_data/x86/intel_pmc_ipc.h in section INTEL PMC CORE
> DRIVER rather than referring to the file
> include/linux/platform_data/x86/intel_pmc_ipc.h added with this commit.
> Note that it was missing 'include' in the beginning.
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: adjust the file entry in INTEL PMC CORE DRIVER
    https://git.kernel.org/netdev/net-next/c/fd88253605a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



