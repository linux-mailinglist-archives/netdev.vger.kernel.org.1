Return-Path: <netdev+bounces-225456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C08B93C53
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EE52A4DA5
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9E1DDC08;
	Tue, 23 Sep 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCN97v0g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E215ECCC;
	Tue, 23 Sep 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589226; cv=none; b=J2S2z5vqAAPoQQffmCzBLh+fxX3Kjt5+q6k68mNpv/FL5EQcuom9obetQ/XM9d39LGwVX4khclOhy1f2U5GxPI07/rcbT/JoDAZV5751Bzm/mHmVgg7E3z6KOTRL1/1yCa8XYwFjGTLSI0IKul16t5yJE3DljmUYHtD2XvtR9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589226; c=relaxed/simple;
	bh=JwkNXiiyeL0GILlN6/zJyqASJ9uJVGwIUbScIhv5OxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=skM3+P4syNLjrexmybWmq1gxXSATG8WNXN7iosD/gYUA5wBX3P2EVpETwhxv33A+dLoY0p/sY8BQjrYSx8x8ob1mgmHwFBvCWRmVTECo3DT7QpUIMHA/82q7AjdKoUbuHVjdZ/XeoA3K2CVjXAVVxQNTb0nnS2uYq7OQrrWQZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCN97v0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885B2C4CEF0;
	Tue, 23 Sep 2025 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758589225;
	bh=JwkNXiiyeL0GILlN6/zJyqASJ9uJVGwIUbScIhv5OxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XCN97v0gYZvlKbnLpRrDidg94YMRI/ckg+QDNhvPYHAXqXnrEeh0596QhByTfkM9M
	 XJyBi0SHSqdtVWu5qnjtaOodeX1I5QV01WlYlN2BXlaARGmmpkaUsmT5epo8iCzDOB
	 KdBMizA4sMxTdudavao/CDAP1pKCKD6p42xkdG89L+DDGhu9cKveidTYsCi8xUXR14
	 CaPvAh9vKePODRi/ATDEqYh/6zSW7OfQuIZclEwMWR+kk/4N4VT8BB6oYP1xtSh0l3
	 CIAzCjOc/FIQWN1ilywwzuWhS0xxn8R7Kb05xtnhIUMXTyUNyaFLZ81Qe+2c4u/s+G
	 4RYAyMjwuI+dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3639D0C20;
	Tue, 23 Sep 2025 01:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v8, net-next 00/10] Add more functionality to BNGE 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858922300.1212827.9814840600067944527.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 01:00:23 +0000
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 23:17:31 +0530 you wrote:
> Hi,
> 
> This patch series adds the infrastructure to make the netdevice
> functional. It allocates data structures for core resources,
> followed by their initialisation and registration with the firmware.
> The core resources include the RX, TX, AGG, CMPL, and NQ rings,
> as well as the VNIC. RX/TX functionality will be introduced in the
> next patch series to keep this one at a reviewable size.
> 
> [...]

Here is the summary with links:
  - [v8,net-next,01/10] bng_en: make bnge_alloc_ring() self-unwind on failure
    https://git.kernel.org/netdev/net-next/c/9ee5994418bb
  - [v8,net-next,02/10] bng_en: Add initial support for RX and TX rings
    https://git.kernel.org/netdev/net-next/c/0259379037ca
  - [v8,net-next,03/10] bng_en: Add initial support for CP and NQ rings
    https://git.kernel.org/netdev/net-next/c/bd06d729722e
  - [v8,net-next,04/10] bng_en: Introduce VNIC
    https://git.kernel.org/netdev/net-next/c/490e145c3aac
  - [v8,net-next,05/10] bng_en: Initialise core resources
    https://git.kernel.org/netdev/net-next/c/d85b5a207143
  - [v8,net-next,06/10] bng_en: Allocate packet buffers
    https://git.kernel.org/netdev/net-next/c/2fe6e77c9f8f
  - [v8,net-next,07/10] bng_en: Allocate stat contexts
    https://git.kernel.org/netdev/net-next/c/23df6aebf803
  - [v8,net-next,08/10] bng_en: Register rings with the firmware
    https://git.kernel.org/netdev/net-next/c/c757ef35078b
  - [v8,net-next,09/10] bng_en: Register default VNIC
    https://git.kernel.org/netdev/net-next/c/58930c035d5b
  - [v8,net-next,10/10] bng_en: Configure default VNIC
    https://git.kernel.org/netdev/net-next/c/9afad4a17174

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



