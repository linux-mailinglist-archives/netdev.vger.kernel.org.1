Return-Path: <netdev+bounces-18812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C5758B8C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9214281629
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4AE17FA;
	Wed, 19 Jul 2023 02:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8118E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECA81C433C7;
	Wed, 19 Jul 2023 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689735022;
	bh=MU2H0nLRw+9Y2mDegD6YHP/+GM/stj6hIzwuzR+Mo0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mf0K/sCS/o5nupPbQGuPGRI/eb63WNHYKa7VryxIt0sqknOjqidO+2nc6LgXcPb2y
	 5JQV/jIZ8gnPIPYZp359Nwd2vSOxp8EfVi8R09x1O+p8EjrHiIN7/UUkm5VH0DfmJb
	 wXAytvsskQuaP+5XohoWrQ4cNCs2BdlsSWQz900sCPdP2tnVa75BJhvv8xIGRYgA/G
	 7e7jp3PwMKG2/GWmxvH4y4hIopEP+rjA5USIhBbQiXwsiYxl+2M45v6gNjb/bh7upn
	 eaipulnIf0bSTA5qfqxQ3OYUxRrF2HIj02VDt0hk3sLmtF0x8gzqykkXxNl+vSu78U
	 tR5hqBGONOV8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C87E1E22AE6;
	Wed, 19 Jul 2023 02:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-pf: mcs: Generate hash key using ecb(aes)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973502181.11704.3601716273746740478.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 02:50:21 +0000
References: <1689574603-28093-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1689574603-28093-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 11:46:43 +0530 you wrote:
> Hardware generated encryption and ICV tags are found to
> be wrong when tested with IEEE MACSEC test vectors.
> This is because as per the HRM, the hash key (derived by
> AES-ECB block encryption of an all 0s block with the SAK)
> has to be programmed by the software in
> MCSX_RS_MCS_CPM_TX_SLAVE_SA_PLCY_MEM_4X register.
> Hence fix this by generating hash key in software and
> configuring in hardware.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: mcs: Generate hash key using ecb(aes)
    https://git.kernel.org/netdev/net/c/e7002b3b20c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



