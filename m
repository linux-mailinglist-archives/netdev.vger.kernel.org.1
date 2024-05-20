Return-Path: <netdev+bounces-97230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD48CA2E5
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 21:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3135A1F22627
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B11386D5;
	Mon, 20 May 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPXoQfBk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A013848E;
	Mon, 20 May 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234631; cv=none; b=Ud1BLPKQNdrFSdNIaYY8k0L+jQSMnJmGG2GiT2kb48OVIk1X4UcX3Tk+3BWzp+QiYmLXLpg+WQUpLuAL3vs3gseMZMJkBPr7j+CcrvlthGtIo8C9YSMSd8CkrKstSr8igYpMXBeJjiOs50aO6/4vUsFou6vpPRs4raMx9S8602Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234631; c=relaxed/simple;
	bh=gdwAVyaodZNRThupNqcD8h3RkYeQMv0OHJyhCnlecfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=feT7xyjXYxFeXQ7yFr5SerhrwgAOcwi4IeM8IHVo0CnFGu4YDXFxZ4P7MpJWq9k1X1jxdj22J9JqXSF/bBlwen9TxDm1shaNoy3phVbrMJ7PQHwLUWh/1bGEgwXPRXqceixofVEb703GDAihshN2IMspxqXjgOW1FMYBlfGlICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPXoQfBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A8F9C32789;
	Mon, 20 May 2024 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234630;
	bh=gdwAVyaodZNRThupNqcD8h3RkYeQMv0OHJyhCnlecfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aPXoQfBkUf+JZIXI+TwvmMi0B3TAdxFK6qWSiYfIOCIen6h0Pk0BHaE1rN7iPVFp8
	 7SJvYwjn+zIK62K5/EZwQz1JdUNNk13fEg7taCoy/2AJ4+iIC6QivuVROKnO8tjL4E
	 Jcb5XUG8Wf9GN/BvHD/SE1cHGyprXott2tAF66yJicwuDp1ZPO8MVzw3mZ2Zua4PB1
	 a4Q50ekuN3n2CmZ7vaLNMGO7zPKcEpULZ3aLwNqZmDHygKHcl2J3//p/OtM33osDv0
	 9n3gi+hkiIlIhHfq+0Idf+GUlG1CkerPrRuO6ucnSZeA8T1Fj0+5DfMnPj6jLdffe5
	 R4aOEZNPLSDSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84CF2CF21D8;
	Mon, 20 May 2024 19:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] tty: rfcomm: refactor rfcomm_get_dev_list() function
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171623463053.16907.1385568021076575698.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 19:50:30 +0000
References: <AS8PR02MB7237393A039AC1EFA204831F8BEE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB7237393A039AC1EFA204831F8BEE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 keescook@chromium.org, gustavoars@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 jirislaby@kernel.org, gregkh@linuxfoundation.org, geert@linux-m68k.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 May 2024 19:21:48 +0200 you wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
> this structure ends in a flexible array:
> 
> struct rfcomm_dev_list_req {
> 	[...]
> 	struct   rfcomm_dev_info dev_info[];
> };
> 
> [...]

Here is the summary with links:
  - [v3,1/2] tty: rfcomm: prefer struct_size over open coded arithmetic
    https://git.kernel.org/bluetooth/bluetooth-next/c/b7a6ed60e5e6
  - [v3,2/2] tty: rfcomm: prefer array indexing over pointer arithmetic
    https://git.kernel.org/bluetooth/bluetooth-next/c/7b13a745870c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



