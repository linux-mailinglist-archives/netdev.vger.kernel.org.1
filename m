Return-Path: <netdev+bounces-39496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D07BF869
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B327B281B0C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0D179B8;
	Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSwSQWIT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2C15AEA
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 352B2C433C7;
	Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696933225;
	bh=UIzJx9EmdbrSr5WpmaFcMaGe/RDVjYRXUMS2tzKKXmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HSwSQWITufInYmmSKAke1aptuLT9IKtBaJqTbLmntC7oDswHXF4OgQPyYJtnSNrEK
	 1q4Ky4z6l6QGO3MR+NeyfrPd4r2OieTlf/lQv+urTUPeTCuX4Zo/AXYTCCTpSd06gQ
	 10Wzdgs+NoDQn8aX5NSB8w+qrWLcs1UGPRTgO0e0j3UxDCOUC+7LaSmhz9RYypKmgT
	 TZYYmZUHjHgjIcST6dpkk8ibmKx7XerZUmbxkCvmsH3xHAi5puey68vCnWXBl8+I5e
	 Cznm8AfPzV7VCPaJFpOHGX3TmnzPWw0wWiiO6sZwo52WDGs6HoNkyxSK1blpg3jmlg
	 shKpR/hB6VMEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D1FCE0009E;
	Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Fix dependency of SMC on ISM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169693322510.26630.14172040587036609321.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 10:20:25 +0000
References: <20231006125847.1517840-1-gbayer@linux.ibm.com>
In-Reply-To: <20231006125847.1517840-1-gbayer@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: rdunlap@infradead.org, wenjia@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, netdev@vger.kernel.org, raspl@linux.ibm.com,
 sfr@canb.auug.org.au, alibuda@linux.alibaba.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com, tonylu@linux.alibaba.com, jaka@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Oct 2023 14:58:47 +0200 you wrote:
> When the SMC protocol is built into the kernel proper while ISM is
> configured to be built as module, linking the kernel fails due to
> unresolved dependencies out of net/smc/smc_ism.o to
> ism_get_smcd_ops, ism_register_client, and ism_unregister_client
> as reported via the linux-next test automation (see link).
> This however is a bug introduced a while ago.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Fix dependency of SMC on ISM
    https://git.kernel.org/netdev/net/c/a72178cfe855

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



