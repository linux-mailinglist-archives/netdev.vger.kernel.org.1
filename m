Return-Path: <netdev+bounces-162778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB991A27E2A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F73A3C5C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5C21ADCC;
	Tue,  4 Feb 2025 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqTxvH8D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C71FAC5C;
	Tue,  4 Feb 2025 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707606; cv=none; b=rrRUIDrHbKXPR/hP0g5PE11cy6N7nBHJpkoV2GGnk6HH+ht/7hVipHfryPbZOJbMKudfyMLkHyeCM5LsCb/mx/eeiL4O3Upok9XBGnnLetFOw0O2SwzIWuhFvwnZEQ9Hll3A/cTEj7g5APRNEym5GnJ2OemuWYv4eJbduEP15WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707606; c=relaxed/simple;
	bh=HWUZxbxxlfRII5fR5qoo/z6Lap3FCCYecC2bT8Mxaq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hieJfz3a5juOy3m2CkqpCQXY7q46922stBncCG3lV/bS4e1fihLb84w9dRgImfxQF4oUVRsHT+AYDn9URy0/vMisxgxZBg5JFtddo1KXXhn/Y7ZBVCIa9ollrOMKmdolT4acm3L0J2U+wgx+e0uBOF/JF2s8O4SVD6AdtrRQ0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqTxvH8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D84AC4CEDF;
	Tue,  4 Feb 2025 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707605;
	bh=HWUZxbxxlfRII5fR5qoo/z6Lap3FCCYecC2bT8Mxaq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YqTxvH8D411ZXFF9tvgxeRyKYi7PgEhyFa2JcaSbP/c+3/ZovvdnSeFvytip6Yd9e
	 1F5pyFLGUXdv2KB/tq3CF6y3BPUJKMhUF4DO2XmkxI/TCih62hPc7xR/bRegxDfTZI
	 S0KbREGHA6L1bIF4MAZ/0EuqzDCQ5/J6ET5VUC+0XC9sslz9OiwzeJhr93ox0zPXc+
	 hGFciiWp3bhfiY9O6fYkzOqrVQ+8uZwa2k3JihY/DhGEn0HOF5WEYg7qNzDdVdh3R1
	 CB3uQro5xOrUzgBuVPRgCAzkiaouFmVEStBSYuAQmbp4/QeoAiwrm9LPKV9oSPyO1u
	 CxwXN3Gjd2YGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE94380AA7E;
	Tue,  4 Feb 2025 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: atlantic: fix warning during hot unplug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870763231.165851.17410649919538989009.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:32 +0000
References: <20250203143604.24930-3-mail@jakemoroni.com>
In-Reply-To: <20250203143604.24930-3-mail@jakemoroni.com>
To: Jacob Moroni <mail@jakemoroni.com>
Cc: irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Pavel.Belous@aquantia.com, Alexander.Loktionov@aquantia.com,
 Dmitrii.Tarakanov@aquantia.com, vomlehn@texas.net,
 Dmitry.Bezrukov@aquantia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 09:36:05 -0500 you wrote:
> Firmware deinitialization performs MMIO accesses which are not
> necessary if the device has already been removed. In some cases,
> these accesses happen via readx_poll_timeout_atomic which ends up
> timing out, resulting in a warning at hw_atl2_utils_fw.c:112:
> 
> [  104.595913] Call Trace:
> [  104.595915]  <TASK>
> [  104.595918]  ? show_regs+0x6c/0x80
> [  104.595923]  ? __warn+0x8d/0x150
> [  104.595925]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595934]  ? report_bug+0x182/0x1b0
> [  104.595938]  ? handle_bug+0x6e/0xb0
> [  104.595940]  ? exc_invalid_op+0x18/0x80
> [  104.595942]  ? asm_exc_invalid_op+0x1b/0x20
> [  104.595944]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595952]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595959]  aq_nic_deinit.part.0+0xbd/0xf0 [atlantic]
> [  104.595964]  aq_nic_deinit+0x17/0x30 [atlantic]
> [  104.595970]  aq_ndev_close+0x2b/0x40 [atlantic]
> [  104.595975]  __dev_close_many+0xad/0x160
> [  104.595978]  dev_close_many+0x99/0x170
> [  104.595979]  unregister_netdevice_many_notify+0x18b/0xb20
> [  104.595981]  ? __call_rcu_common+0xcd/0x700
> [  104.595984]  unregister_netdevice_queue+0xc6/0x110
> [  104.595986]  unregister_netdev+0x1c/0x30
> [  104.595988]  aq_pci_remove+0xb1/0xc0 [atlantic]
> 
> [...]

Here is the summary with links:
  - [net,v2] net: atlantic: fix warning during hot unplug
    https://git.kernel.org/netdev/net/c/028676bb189e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



