Return-Path: <netdev+bounces-27239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A277B218
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D7B1C2095C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D98484;
	Mon, 14 Aug 2023 07:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AC5237
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F20DC433C9;
	Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691997023;
	bh=T6Sp4k2R0BcAtgRVjsQ2j86+hy0KPi/kTTCsEwrfhY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HGBmuXKbDO9GsbGEQmeMbTDT8W7gK0ctGV2L6O5IanVRDLgVSjsKKAfwgbgPcnkg7
	 LDAOeXz3nZmV4sviGMyVjBz7RScYXINTa8boRJeOCgbP5IETYMOUfaRTQ8sudEYb2f
	 aOZwFVWVInTMdnYJiAN07oAcbIrYJLPESB8iW0AXebnWTs+90hFn5wnRnxpBAueN1f
	 ke2KAjwQDIIuOUvTVm/3C7C7Z3N/kMqIiHqdRcIMwXjEy57L3VGUqknEBMm4wJn0nP
	 QeB7rqFXpV3kpOu4BV1Obi6pPAr8/qtWnb8QxVomomGuaeZDuatpb0iiWEiUjzGrXH
	 Q8xc+4UqW7QNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38EE7C395C5;
	Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v5 0/7] openvswitch: add drop reasons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169199702323.11756.5682207077093972748.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 07:10:23 +0000
References: <20230811141255.4103827-1-amorenoz@redhat.com>
In-Reply-To: <20230811141255.4103827-1-amorenoz@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, i.maximets@ovn.org,
 eric@garver.life, dev@openvswitch.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 16:12:47 +0200 you wrote:
> There is currently a gap in drop visibility in the openvswitch module.
> This series tries to improve this by adding a new drop reason subsystem
> for OVS.
> 
> Apart from adding a new drop reasson subsystem and some common drop
> reasons, this series takes Eric's preliminary work [1] on adding an
> explicit drop action and integrates it into the same subsystem.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] net: openvswitch: add last-action drop reason
    https://git.kernel.org/netdev/net-next/c/9d802da40b7c
  - [net-next,v5,2/7] net: openvswitch: add action error drop reason
    https://git.kernel.org/netdev/net-next/c/ec7bfb5e5a05
  - [net-next,v5,3/7] net: openvswitch: add explicit drop action
    https://git.kernel.org/netdev/net-next/c/e7bc7db9ba46
  - [net-next,v5,4/7] net: openvswitch: add meter drop reason
    https://git.kernel.org/netdev/net-next/c/f329d1bc1a45
  - [net-next,v5,5/7] net: openvswitch: add misc error drop reasons
    https://git.kernel.org/netdev/net-next/c/43d95b30cf57
  - [net-next,v5,6/7] selftests: openvswitch: add drop reason testcase
    https://git.kernel.org/netdev/net-next/c/aab1272f5dac
  - [net-next,v5,7/7] selftests: openvswitch: add explicit drop testcase
    https://git.kernel.org/netdev/net-next/c/4242029164d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



