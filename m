Return-Path: <netdev+bounces-188211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A46AAB967
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79083A6862
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98DB290D9B;
	Tue,  6 May 2025 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XciCIkvg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F8290D9D
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494398; cv=none; b=Bqd9KIK5Uc8gUEe0XDa/f/MQ2MwueK8HuRqM0jPyBkJb5vpQ+onDH5PZXxgyTSsnQpHg/bRxon4fuH8X/KxG995c8eO5aJze2rtLPxqGBEm7xHGNInFbC/EeZNEl5G0z2HydKwXHwesPN4zhzxhTC5bACP96ppJShL5OjbQVwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494398; c=relaxed/simple;
	bh=xj4Os+WdiExkpD8Zgxlvke07JByqhTWf/PLeXJ2HIPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FnYn3weTfO0EydakenAG10Zoclw4PAXjEKu4G5mZusGqERCIUih5p6+QFiwXzV3o2KMdUFem0ptD2zS6Etr8GTXsa8cGDomVksr3cseMtAcV/pfGSASphOZq1A+fstdR5VWdq1gBc3S/XXvrX/95P7nqi9cbdEFQtqF5xfAX7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XciCIkvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1632C4CEE4;
	Tue,  6 May 2025 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746494398;
	bh=xj4Os+WdiExkpD8Zgxlvke07JByqhTWf/PLeXJ2HIPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XciCIkvg8te71lsOJtbBg8bGJuOslb39HIm3HLIqA1VKN8YRSymvd4hwuYTgS0bQo
	 S7NatZOm2kN7016qTkVRv5C0Ingx1/gfzEnZQPCpSaQx/TyOu+Th5MazNFfNEy3mns
	 ShbdiRxmw91gGRpioLnX6iopPQZC3BOQQRQhEnWlODTpNWVOUkjnURdNkyQH1r13dB
	 bIlP1XoaqVM74TnGXI70jAmUP2Ct1FM0yACAr8uufW8PjyDA6CU3QYGwJmx6xyPw9d
	 +9hB9YeZxZ6isRS3TP88zatQQawaDSMxkrlgjkiLfm4Vk430j0rbYJSdZGyrnc0A7N
	 6wCsr8JF/fi4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C18380CFD9;
	Tue,  6 May 2025 01:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools: ynl-gen: validate 0 len strings from
 kernel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174649443724.1003512.5539017727353269660.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 01:20:37 +0000
References: <20250503043050.861238-1-dw@davidwei.uk>
In-Reply-To: <20250503043050.861238-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 May 2025 21:30:50 -0700 you wrote:
> Strings from the kernel are guaranteed to be null terminated and
> ynl_attr_validate() checks for this. But it doesn't check if the string
> has a len of 0, which would cause problems when trying to access
> data[len - 1]. Fix this by checking that len is positive.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tools: ynl-gen: validate 0 len strings from kernel
    https://git.kernel.org/netdev/net/c/4720f9707c78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



