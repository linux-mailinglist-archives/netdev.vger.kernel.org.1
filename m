Return-Path: <netdev+bounces-40203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA397C61B9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DF51C21004
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0667EF;
	Thu, 12 Oct 2023 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCU2LKzf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DAA32;
	Thu, 12 Oct 2023 00:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E336CC433BB;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697070625;
	bh=AzVrrHVklFUccuLIjTp5qmMV/tSS4X6XU+ztCS5Do7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SCU2LKzfYUSgKighWFhEI8EFMOhzeHhGI7MUtiSvFrPf4FZ3vgu291CZT04n7HRWf
	 e+hzAo6lyKGJvCxJ91TrxamOwVzkWfe4TlyUjZUcdwX41jCWhRoQtrkIcyeiilNGkI
	 MtDs8jTRiJrOlsT5zD1+9uj/ACeKj38eeqTZMnpR1R98Gmmexc/BALUThqylxgbNcp
	 HCL24Ts2N5Jl0V67fwoi+kxHJ3Fx6qC/9GcjhmQLOjq0uBdU6pecbrq/V6YrtWP3WN
	 BmipSjiMzzvR7dWVeCQfzqHhbNZw2CQP28oC30oZBCL1lrtjCGKz/JIw4yjzK2yvKr
	 xyRNHUp7YRZ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE2D4C595C4;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bna: replace deprecated strncpy with strscpy_pad
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707062583.15864.12964276250565001495.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:30:25 +0000
References: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: rmody@marvell.com, skalluru@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 17:45:33 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
> `manufacturer`.
> 
> [...]

Here is the summary with links:
  - [v2] bna: replace deprecated strncpy with strscpy_pad
    https://git.kernel.org/netdev/net-next/c/460c81da66f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



