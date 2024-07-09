Return-Path: <netdev+bounces-110228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C392B819
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D721F217BB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEF8155333;
	Tue,  9 Jul 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE/cKM/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC71527B1
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524630; cv=none; b=bMQBNfwtdTMpVmzk7VdCoHAMqMheJ3BopO0x+qe3vZtob7KQ3TThft+jf1DVhnVvJrU0MgT509p/muDe9plzN+a4X6opLq0ap0UL8ATJwJQnTsEZBAHfgHEMsGokoEzoMXOcgynF1f+wkQX5vy8oulxM+rbj2xMCoxE6+2auxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524630; c=relaxed/simple;
	bh=q73bcWJUsSYgYX8NXvIknmbYr3nRLLG0Q7EEgnYLba4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LYC+9sSAifj7SG0wyNVauPv84eqkpIkYO14YGUcVFjw5NcTKOB3+az9nRR5q62BjYnZlgYRdrwS60A5giT8cONQ73nOZxCa6+46TXsiNiK0RTscpsxfIdHMk3OApL5A03vzFN1OZxtzR7TbmjNMDJOZaDgxNidwXtrUNEADZeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE/cKM/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88830C4AF0B;
	Tue,  9 Jul 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720524630;
	bh=q73bcWJUsSYgYX8NXvIknmbYr3nRLLG0Q7EEgnYLba4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GE/cKM/FW8rS2GULe/gxo/8pYGz9mrsjGpHHEAJrldhqAGvIAPxzZYf1C/T1tG5iI
	 lqZVe4c5BSQdHuabiN0PA2DDUcrrDG8DTzO+eh2sf4K5oxko8g2j/wq9XLQFAVch3v
	 +ewuBEU9UMTi8j0Yl3zIBW0MSEIYy36FRkTi1hxuolHZU8630pV1DFac27btLio9uR
	 0kxuxyXPb8qqQyrIyBnuerUPUMthNAnkaEQ7t1+crKZKNw07QU5pG5G/FnOcIULbUH
	 N9CFfJUwGoAMhxc6uNJ58tVCgPqzx0CBt4yFtbGQneUn/t9Xac2CD3gXcx5JYGmHnA
	 CA0BDhnDMdB/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 793A0DF370E;
	Tue,  9 Jul 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: tn40xx: add per queue netdev-genl stats support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172052463049.17165.8509707015341244235.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 11:30:30 +0000
References: <20240706064324.137574-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240706064324.137574-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jdamato@fastly.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  6 Jul 2024 15:43:24 +0900 you wrote:
> Add support for the netdev-genl per queue stats API.
> 
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> --dump qstats-get --json '{"scope":"queue"}'
> [{'ifindex': 4,
>   'queue-id': 0,
>   'queue-type': 'rx',
>   'rx-alloc-fail': 0,
>   'rx-bytes': 266613,
>   'rx-packets': 3325},
>  {'ifindex': 4,
>   'queue-id': 0,
>   'queue-type': 'tx',
>   'tx-bytes': 142823367,
>   'tx-packets': 2387}]
> 
> [...]

Here is the summary with links:
  - [net-next] net: tn40xx: add per queue netdev-genl stats support
    https://git.kernel.org/netdev/net-next/c/6c2a4c2f70e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



