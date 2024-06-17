Return-Path: <netdev+bounces-104097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59B90B332
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701951F23460
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE513C3FE;
	Mon, 17 Jun 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeUml2zM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D513C3F2;
	Mon, 17 Jun 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633431; cv=none; b=BZgaa3e/0KbzYDcuy7meQeoRolyvY1yxp9wa/kjNcl9rHFJ9pGaDEluxlsEJq95GkfUQ4KBrTPM06ScXT7NHdSvId3PCVGDf2yRWJFo0yonbrgzJ8AtWYdL/Ap/eocZTfpqJXDkUHqPR0WseBNepcOBYhXBM+EIAThP7Wh3HkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633431; c=relaxed/simple;
	bh=ZY0frUm/l/ELazp3keFtHSZU2+jYmNK9nHk3XE/5PDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MLgMl43w/KHY0NmMchjyXIBpKy8BaCt8krxr1AnxpFF4pSDkoq9KyWzOcv/M3Fm7uK/4qgWul0FCmTo+2aUhyrDNkVtBq510H/C34AhVPy4r2jasx38JECuUv6Nk1YrVKXNtONnwM5dlNlVwlxIcYj3CNL1OYPsVGEeddJKKUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeUml2zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD6EC4DDF3;
	Mon, 17 Jun 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718633431;
	bh=ZY0frUm/l/ELazp3keFtHSZU2+jYmNK9nHk3XE/5PDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eeUml2zMnU9Tr5usyo/xu22P0H0SOSWbGapAD48Ecn7eOpCgavdMidKMLs0eJS9DY
	 mL9Uart+1OAdxwAb6t5nIgWaaIGP0z8KEJDhtsm58N6FJiN3tYjHnRREycPY1u1ZE2
	 qZOleREEQumGu+73JOertCtKUPMelURDh5/yciWo54NHp7yBMPUxKGYWVRD3a6Pc+x
	 Chd041nW/rl82cKPyZ6gEu82jrx+EjXVvWml44LO8c1sxdVEgmBoUJyc2p1wzJAzwF
	 ZSt0ODjkQ8Xr7aQhr5M6AT16PCK3VuClD8wQy3TYnxiDsLGnTqk+hDYTJYlL7VS3N3
	 oCJn4IgFdTHbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF192C4361B;
	Mon, 17 Jun 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Ignore too large handle values in BIG
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171863343097.8850.935824555783496146.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 14:10:30 +0000
References: <tencent_E43E1B2F25E4BA5EBBEC33229E5E1BEB4B08@qq.com>
In-Reply-To: <tencent_E43E1B2F25E4BA5EBBEC33229E5E1BEB4B08@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: pmenzel@molgen.mpg.de, davem@davemloft.net, edumazet@google.com,
 johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Jun 2024 19:09:37 +0800 you wrote:
> hci_le_big_sync_established_evt is necessary to filter out cases where the
> handle value is belonging to ida id range, otherwise ida will be erroneously
> released in hci_conn_cleanup.
> 
> Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
> Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Ignore too large handle values in BIG
    https://git.kernel.org/bluetooth/bluetooth-next/c/401ad9b792e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



