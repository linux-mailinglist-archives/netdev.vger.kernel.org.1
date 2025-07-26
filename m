Return-Path: <netdev+bounces-210313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701ABB12BE7
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1333F3B0399
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4628A707;
	Sat, 26 Jul 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMleCNAy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FA28A3ED;
	Sat, 26 Jul 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555212; cv=none; b=rH/yVQiEL07mzQnPtKsMAAFxjWaAw77HeLso6vaPzwhyJfxUu/7LOX8oW6EoysR915s2vJVagf+/lxNzdRoqV/+JruaF6hEdaEle5/o2fcYmd65QZ0WwCbPgCdrERJBrJU53UzCY7MrkVP+WaoCxaM37861ktQ212A0Y2XGdCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555212; c=relaxed/simple;
	bh=nU3KVELx+Tcspgphah/8lvgUnIBNVFV8yJdibtdixCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u7bJUywsdZSfu8GWOKurEI+iUSevzV+6Gy4/ZawpnDMLHabyQQuTEdNFPUtc5yu25kXpkvppuUsTg7byMIPluZCqumscvy5WW4aXuIvD069Z/VG5AZzr5hV4V4MtzBOSwjYhJ0J3NFiiwFLNmt0ehKgk2rnU9uNs1zwQImmt/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMleCNAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A62FC4CEF1;
	Sat, 26 Jul 2025 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555212;
	bh=nU3KVELx+Tcspgphah/8lvgUnIBNVFV8yJdibtdixCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MMleCNAycjha3Sn0oTUDm/Bk1NXa6j7ZxoBE34HYriPTz0vuTtJTTgdOeSCauJ23k
	 dlIaWlhfGUsxyz9q8tTq2rd9j6n1BKehjPrgIDF1H1BhqT6CZtu/wPnQbV+Y3QgoTu
	 n2IOCHKWRl3BYsHVwsDza/r9+COhJAzn9Xeg7FyrkysxqeEaGmrXKtztoKSQ55qN+V
	 Vr79UMOUJ1yuKOFFf9USdy2qp4131R0uSb+zZyKVA9MtPBdKTl+i/8xMIXyZ/a0oor
	 QooIMbkuRT8MsIoeIxMOKyfugNRCOiy2tGs6NR9cCs6+3EiiHeel2PFqxErAXjs9tj
	 vM5ziZSaymmkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0E383BF4E;
	Sat, 26 Jul 2025 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock: remove unnecessary null check in
 vsock_getname()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355522949.3664802.5083915882799890205.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:40:29 +0000
References: <20250725013808.337924-1-wangliang74@huawei.com>
In-Reply-To: <20250725013808.337924-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 09:38:08 +0800 you wrote:
> The local variable 'vm_addr' is always not NULL, no need to check it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/vmw_vsock/af_vsock.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] vsock: remove unnecessary null check in vsock_getname()
    https://git.kernel.org/netdev/net-next/c/002f79a5f015

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



