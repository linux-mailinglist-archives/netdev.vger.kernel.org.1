Return-Path: <netdev+bounces-77873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09E873482
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4491C2438E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920460DCF;
	Wed,  6 Mar 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN53r9f8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C9605BF
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721629; cv=none; b=Ka2DlxceJFUveXY62v+m8Og1mW8+otSAYC2HcWFGPJHziBqEGS6aooqpiBWfhOyuA31BhaVNyXHOXJENNqTuHJiXayuGMP2l0L3LIQsafx6ztP+ATEbWq6diOmOsEHVBNzNEmNe1JMEGbfUL7HeBLt35HXvIwNaGrh7sHG8REnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721629; c=relaxed/simple;
	bh=zSddH8RVkJ8ppYTJy79F1SyEBzYA+EDKvNfuw87H80Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ojgDcn2GwuHKtm2jgmkXd88GeRR8BGX72SEIukA5xwxkjnXKbtBwjp1Knly7om2N6flk7Rh9P/EUEl+24VMLkHTs9ltLA+wW5gnD4iAxnOLn3Wj0M0Pf8wWuHurGB4/MrlttirzDg+mItVowRPu9CTaeMfARfywwGaeCl/uxGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN53r9f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCD7FC43394;
	Wed,  6 Mar 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709721628;
	bh=zSddH8RVkJ8ppYTJy79F1SyEBzYA+EDKvNfuw87H80Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jN53r9f8upNhvpXRSNkyLE7PXXYH43YM/Yzw3LG9fyA8cXuN+45WZ7IGCttOQwuU6
	 PXILQeFUI9NGTrFLTWTusGZQz69iWk9Bz87OF2lEC0GnMhcHpzNG4Zy/M4b+OIZQP9
	 9rkPpiCeZvX4MIF7PFBrPqp3mOsz38gU+Uu7ZQ4wyyQN4kDz4HgBQYnZ65MEueHSN+
	 UQtrKpvQzEO7YgHJXWH6s12KyFyUx1g/CbKkWUeuBCwlO9ecVDBAH7wld4ljzoc8KP
	 ADW0RpNNZyxacBqnOK4zt77yjk9eiTAl3DMY9R6XjUSSZXSFByd4p4OWCSMnRKS9HH
	 hW5Mx0xokSPQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2E78D84BDB;
	Wed,  6 Mar 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11][pull request] idpf: refactor virtchnl messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170972162879.24493.15817194316412787114.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 10:40:28 +0000
References: <20240304210514.3412298-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240304210514.3412298-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, alan.brady@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  4 Mar 2024 13:05:00 -0800 you wrote:
> Alan Brady says:
> 
> The motivation for this series has two primary goals. We want to enable
> support of multiple simultaneous messages and make the channel more
> robust. The way it works right now, the driver can only send and receive
> a single message at a time and if something goes really wrong, it can
> lead to data corruption and strange bugs.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] idpf: add idpf_virtchnl.h
    https://git.kernel.org/netdev/net-next/c/5dc283fa5cf7
  - [net-next,02/11] idpf: implement virtchnl transaction manager
    https://git.kernel.org/netdev/net-next/c/34c21fa894a1
  - [net-next,03/11] idpf: refactor vport virtchnl messages
    https://git.kernel.org/netdev/net-next/c/8c49e68f542f
  - [net-next,04/11] idpf: refactor queue related virtchnl messages
    https://git.kernel.org/netdev/net-next/c/52361a06d3f2
  - [net-next,05/11] idpf: refactor remaining virtchnl messages
    https://git.kernel.org/netdev/net-next/c/43b67308df98
  - [net-next,06/11] idpf: add async_handler for MAC filter messages
    https://git.kernel.org/netdev/net-next/c/41252855df77
  - [net-next,07/11] idpf: refactor idpf_recv_mb_msg
    https://git.kernel.org/netdev/net-next/c/e54232da1238
  - [net-next,08/11] idpf: cleanup virtchnl cruft
    https://git.kernel.org/netdev/net-next/c/bcbedf253e91
  - [net-next,09/11] idpf: prevent deinit uninitialized virtchnl core
    https://git.kernel.org/netdev/net-next/c/14696ed173af
  - [net-next,10/11] idpf: fix minor controlq issues
    https://git.kernel.org/netdev/net-next/c/4f5126a075c4
  - [net-next,11/11] idpf: remove dealloc vector msg err in idpf_intr_rel
    https://git.kernel.org/netdev/net-next/c/6009e63c57c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



