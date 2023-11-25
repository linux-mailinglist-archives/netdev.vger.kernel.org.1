Return-Path: <netdev+bounces-51006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3D17F8829
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 04:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F041C20B77
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E148F17D3;
	Sat, 25 Nov 2023 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/5GoifK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F7A50
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 03:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EB48C433C9;
	Sat, 25 Nov 2023 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700883026;
	bh=lY6sBXiYG4cE/+ICfKFltmSOGZryOxK/ha8O52YXMOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y/5GoifKHbu6UQgI2m7EAm/tXHQLXt3HDrv4s8lMlgB2e9PCqfIQc78Gghmvx4mp/
	 QVYquq6yiOj+FB4XeRrJaYRpNVCKkB/86WiH19LzOTIa4aE7ANoigY8GdjcrSpv1HD
	 K+o9f6bJuGRsvYfT9S2rokH1KNvCsUROfYkghMhhC2AJFyUaurH1d+pAq0g3XKnC6y
	 Jy/81pO3wCUg3bHroSfO/6FZq/4RlePGCBLdH0NDGk+37OXemg9K4GqmPwv0HUqqXu
	 i1tPAp5LlmqOM/kkjPtPaIbZvqvQUa8bm4fr3Vl2AojwUVxLPXIBqZDV0ZFRFJwsTT
	 3YAGzR9cBOjjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03259E00086;
	Sat, 25 Nov 2023 03:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload error
 codes with firmware invalid error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170088302600.4689.10780084312021094522.git-patchwork-notify@kernel.org>
Date: Sat, 25 Nov 2023 03:30:26 +0000
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
In-Reply-To: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
To: =?utf-8?q?K=C3=B6ry_Maincent_=3Ckory=2Emaincent=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: kuba@kernel.org, mcgrof@kernel.org, russ.weight@linux.dev,
 gregkh@linuxfoundation.org, rafael@kernel.org, thomas.petazzoni@bootlin.com,
 linux-kernel@vger.kernel.org, conor@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 14:52:43 +0100 you wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
> 
> [...]

Here is the summary with links:
  - [net-next,v3] firmware_loader: Expand Firmware upload error codes with firmware invalid error
    https://git.kernel.org/netdev/net-next/c/a066f906ba39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



