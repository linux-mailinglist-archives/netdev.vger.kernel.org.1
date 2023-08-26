Return-Path: <netdev+bounces-30839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578F78931F
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A19C1C2107C
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13062E;
	Sat, 26 Aug 2023 01:40:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF637F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 01:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84F8FC433C7;
	Sat, 26 Aug 2023 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693014038;
	bh=2j3P+TA8tkmXSr1KmRkRIyjL6HkmIgt6Wch8RsHB7OY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R4Ruz/os+Tfg+EwnSLkmOK9S8sr+sVPQDQV1z25TKnaHIxTnfrYuviY+H8z7wsLbx
	 AdAqMIKtwLciC9xiu5K7FSyejPmIJEndEIDFwg9X11yEonxSLuEwU49uLnSg+nt6I7
	 M5B3CshsjoWyPS3U68jPl9JRf492YG3T1RDg6w1e5BVzaWf4untjxXnZhp86vfAysJ
	 ZZXk50DAAWPvBerl43WHCG2oSj0kbQsFnGRmP7u43H9vCvG/msyuBAfngkvkc9czHl
	 dp1XrCTnGgiWtQsvseXEdtEL3cvrzo85z5PcJu1LAyGtCznwYQFj8f/UUTHckmbJJ2
	 D8I4bqfR8jI2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65022C595C5;
	Sat, 26 Aug 2023 01:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-08-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301403841.445.5608322427600137990.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 01:40:38 +0000
References: <20230825132230.A0833C433C8@smtp.kernel.org>
In-Reply-To: <20230825132230.A0833C433C8@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Aug 2023 13:22:30 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-08-25
    https://git.kernel.org/netdev/net-next/c/1fa6ffad1275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



