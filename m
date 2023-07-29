Return-Path: <netdev+bounces-22492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD8767A82
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5832825E7
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263F7C;
	Sat, 29 Jul 2023 01:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C564F
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CEF0C433CA;
	Sat, 29 Jul 2023 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690593021;
	bh=0bXB1gjnWbl77v7JpiMO5Sd7N2sWFuDWIVG3G+aBWvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QY8pFa1mKlxRsEMydCMNm6a1yf/gtlpq5jwqUrnX5d8vapnceixgL9yj2DEaBmI1H
	 ggMtcoVg96n7szvYvlgxTDqMva2ObrJhm+El6V1iJO8nUJTiFrdgQhnjMAYemLzRKl
	 XmvFRrE84BYxrRkkhUrNwSU25kml0SBkQkbgOIfxrbFbuKK0YaMJTsVkVbORmaoKRw
	 HoJQMV8eDDEu4NyiQhVqF/5X/nS3CXfEnWr5Lk/l3h5W5F8topd/y0Id5QJTnPyucj
	 XW4OSKwe3TvCLL167ZaqA/Ipu5g3UBsy4Wof6EMsNX9CUQyoz/8b71zXh7Cj/nacoo
	 o44uYkCWt1UHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A69BE1CF31;
	Sat, 29 Jul 2023 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] r8152: reduce control transfer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169059302149.26009.9262284677356277688.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 01:10:21 +0000
References: <20230726030808.9093-417-nic_swsd@realtek.com>
In-Reply-To: <20230726030808.9093-417-nic_swsd@realtek.com>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 11:08:06 +0800 you wrote:
> v2:
> For patch #1, fix the typo of the commit message.
> 
> v1:
> The two patches are used to reduce the number of control transfer when
> access the registers in bulk.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] r8152: adjust generic_ocp_write function
    https://git.kernel.org/netdev/net-next/c/57df0fb9d511
  - [net-next,v2,2/2] r8152: set bp in bulk
    https://git.kernel.org/netdev/net-next/c/e5c266a61186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



