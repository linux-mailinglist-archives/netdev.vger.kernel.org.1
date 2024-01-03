Return-Path: <netdev+bounces-61066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A828225F4
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901AD1C21BD8
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AE7657;
	Wed,  3 Jan 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0O8AF9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB020F7
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37058C433C7;
	Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241830;
	bh=a26mjFWcBVd8Y1x7eUIOfj1K/Xwzz1KNoBLT8we7Tvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B0O8AF9y+kkuin7WiaiBv6uFNiN51QW5ws+AC5+z4+5xRX+aAEY89MpX0owJGv9u3
	 PYguaNbC8Psl04o7JxdACCNIB16WOe6Q7Te0opgqEMJJ0SLlXPI1HunS9SmknVWabA
	 xzd6eIIbUPT7tl0Qzd562yCHb9Lp1CrLphhBmsAQQX4khxh/vtmyihkBOdFz5N3I59
	 oTyaSkLhssdYFESLQ2C+YT35yIo7usgpVzUbvQw+aXfCC1GuLioB/Q1o5IXEo7amvo
	 yCC11W2qeq+FOGxiauy3dK+alNp2By7X+9ntAytBRSm9EXA1gtGJ0Lh6+cnLjg31Jg
	 aI2qj/vLPFQzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 170A6C395F8;
	Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: bcmgenet: Fix FCS generation for fragmented skbuffs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170424183009.18204.1660291506405733870.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 00:30:30 +0000
References: <20231228135638.1339245-1-adriancinal1@gmail.com>
In-Reply-To: <20231228135638.1339245-1-adriancinal1@gmail.com>
To: Adrian Cinal <adriancinal1@gmail.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, adriancinal@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Dec 2023 14:56:38 +0100 you wrote:
> From: Adrian Cinal <adriancinal@gmail.com>
> 
> The flag DMA_TX_APPEND_CRC was only written to the first DMA descriptor
> in the TX path, where each descriptor corresponds to a single skbuff
> fragment (or the skbuff head). This led to packets with no FCS appearing
> on the wire if the kernel allocated the packet in fragments, which would
> always happen when using PACKET_MMAP/TPACKET (cf. tpacket_fill_skb() in
> net/af_packet.c).
> 
> [...]

Here is the summary with links:
  - [v3] net: bcmgenet: Fix FCS generation for fragmented skbuffs
    https://git.kernel.org/netdev/net/c/e584f2ff1e6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



