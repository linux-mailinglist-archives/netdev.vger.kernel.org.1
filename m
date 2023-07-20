Return-Path: <netdev+bounces-19330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C075A4EE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9562D1C2129E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773317F4;
	Thu, 20 Jul 2023 04:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EF10F5
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25C02C433C9;
	Thu, 20 Jul 2023 04:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689825621;
	bh=Tw0OBv55NpxR2zE58MYIjLwG3C7YjQr4VswiPcpncNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pcJJ4GoHnGr7Z6HXeq/ggk97QjAAWr5byEVjfVU8MyEUWVBCYGa5a+yYuD9THFCKc
	 UhP8rtq7dnn2V4RjZ0U3hDdCbOKnWwnjF+I49hVAi00wvRcBId4ekreLfZ7LVNM6dH
	 5NxDH1dGEsQlOHOtTtoR9NDV9RwslwpluW/vdrVtMmZdWME+p9eV61wAQyopf1jH/I
	 2SXsHd2W0qjc1ZowywxfaYTE10Ntzf2OHimdedMFkTAyIrcubBmkIl5j7vxTojjT/d
	 NYuQTDO8UdUajdMGHos7zo9ir4A7+Z9vYrnqR088+tdO4Fs1ABl4BsciSlAvX3dOA8
	 LoK8cmNr89vAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 014D7E21EFE;
	Thu, 20 Jul 2023 04:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] Revert "tcp: avoid the lookup process failing to get
 sk in ehash table"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982562100.4243.1104573583852071360.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:00:21 +0000
References: <20230717215918.15723-1-kuniyu@amazon.com>
In-Reply-To: <20230717215918.15723-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kernelxing@tencent.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 14:59:18 -0700 you wrote:
> This reverts commit 3f4ca5fafc08881d7a57daa20449d171f2887043.
> 
> Commit 3f4ca5fafc08 ("tcp: avoid the lookup process failing to get sk in
> ehash table") reversed the order in how a socket is inserted into ehash
> to fix an issue that ehash-lookup could fail when reqsk/full sk/twsk are
> swapped.  However, it introduced another lookup failure.
> 
> [...]

Here is the summary with links:
  - [v1,net] Revert "tcp: avoid the lookup process failing to get sk in ehash table"
    https://git.kernel.org/netdev/net/c/81b3ade5d2b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



