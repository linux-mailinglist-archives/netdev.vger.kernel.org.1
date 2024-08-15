Return-Path: <netdev+bounces-118893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948809536F9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F06028CEB5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B601AD9D9;
	Thu, 15 Aug 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obf0EL9X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AA1AD419
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735231; cv=none; b=m95h8e8h7LAMQgPmh3ltaF5m/HETa4JlaO0cim9CMKFvWxP2vdsBfHw5hW7Yuj+8wC4eKazxCCFxvFxG1rAPE0Xx8de6khU+8x5woqz6hhLcODT1BiZrmQF2lVM/D8qq7JuVJf+nc1ZyHTCaHx8fnQx8iYQqR625HY8nxpQU8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735231; c=relaxed/simple;
	bh=aWuDathSx8rudxqFmnyq6KZzHJbK9uKO3gw1DboVC20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fHZ56qMqR0ZCHz1e2KI6iUAE7l2n64VVLvkfjIWzFxfR4eYjRlyoWF09mvMPsCFuk4Ata8kbmQHo+F3VqkB8Nw9YlwI+j/DGtYbbFWdUd7ezv7nbqlVjCkmWDGV8ExjvREwiCTR5CrAC/VZE4fSVaggkVlOhpceZN4/8+3y8pPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obf0EL9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ACCC4AF0F;
	Thu, 15 Aug 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735231;
	bh=aWuDathSx8rudxqFmnyq6KZzHJbK9uKO3gw1DboVC20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=obf0EL9XonntTxGTpuSPTnEmKntT6AKteQEudTmBVWY03uhYhMkf/RihKgqKzY6Pe
	 IkLh4U+6Syd6q8PdAub68t3zSdbr8fLzei5ieYEns8T2SKXT92M0uP5Rd9tZyiDZRs
	 mc8GJisUT9enoDPDQawYy8XLQCvpagb7c+aQAASI0Y+6EMydpxeJZ315pDCX+PEHFQ
	 PIRJc321CSRMd3jMGQ22GoG1kpOE6Zl72/R3DovyWm2taXy2w+/GfAMGIDTyU40iDU
	 LbE0D1n3Pc93PUwfRll1HmgIbwUD2qvq6CT6ugMFqtEWAAchlWkztvAkNvF2gEdDde
	 n/ZtSue363fuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71079382327A;
	Thu, 15 Aug 2024 15:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2 1/2] tc-cake: document 'ingress'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172373523027.2884618.11645911496457223084.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 15:20:30 +0000
References: <20240812044234.3570-1-tcm4095@gmail.com>
In-Reply-To: <20240812044234.3570-1-tcm4095@gmail.com>
To: =?utf-8?b?TMawxqFuZyBWaeG7h3QgSG/DoG5nIDx0Y200MDk1QGdtYWlsLmNvbT4=?=@codeaurora.org
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 12 Aug 2024 11:41:37 +0700 you wrote:
> Linux kernel commit 7298de9cd7255a783ba ("sch_cake: Add ingress mode") added
> an ingress mode for CAKE, which can be enabled with the 'ingress' parameter.
> Document the changes in CAKE's behavior when ingress mode is enabled.
> 
> Signed-off-by: Lương Việt Hoàng <tcm4095@gmail.com>
> ---
>  man/man8/tc-cake.8 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Here is the summary with links:
  - [iproute2,v2,1/2] tc-cake: document 'ingress'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f7c215305877
  - [iproute2,v2,2/2] tc-cake: reformat
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=72c13bc5d48c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



