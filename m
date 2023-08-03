Return-Path: <netdev+bounces-24211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5264476F3DC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809231C21647
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6594263B4;
	Thu,  3 Aug 2023 20:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26325931
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F297C433CC;
	Thu,  3 Aug 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691093422;
	bh=NMlwp0kn3mRXYrPddMe1RnLa2av2JMVTr0t7PBKN17w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LGsJKJn13RZuW0AWHmzhR2HxZDdQO61ZTShgs0AJiFm6Y1KpBaexcQJ9W31lw0kbV
	 EgNcfAsqUuy1/Gh36DC0/SvCBSU79qFZJvl7KYEKfTyKii0qHcvoe0F1iIFQXZYdte
	 +/zAtVoM9TNRS2Ec+y+cxzf+XyfyTDYx+3InIRUrVgHVDVGqZcn57/Gs9U26xx7oVp
	 5Cd18DlvMQmrFSBPUDULUiqXSmMmVAUMyvO9+PVf1sbBdudL1C7bO/KBe09H+xHfWz
	 CqmTS60+IgOJTSoWNHbNOnkCKM0uI9uxkSeiBmS6aJsqGx58T3VmC/nIoE/LlzcesS
	 QGexR+uCFQgHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED5EAC3274D;
	Thu,  3 Aug 2023 20:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ss: report when the RxNoPad optimization is set
 on TLS sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169109342196.26506.1081791764366537927.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 20:10:21 +0000
References: <20230731150628.419715-1-kuba@kernel.org>
In-Reply-To: <20230731150628.419715-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dsahern@gmail.com, stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 31 Jul 2023 08:06:28 -0700 you wrote:
> Similarly to RO ZC report when RxNoPad is set.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  misc/ss.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [iproute2-next] ss: report when the RxNoPad optimization is set on TLS sockets
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=109ddfb4e525

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



