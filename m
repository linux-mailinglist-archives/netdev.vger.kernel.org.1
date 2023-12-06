Return-Path: <netdev+bounces-54365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10927806CA3
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999441F214BB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848E3033D;
	Wed,  6 Dec 2023 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL9Vj2z/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666413AEA;
	Wed,  6 Dec 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63784C433C7;
	Wed,  6 Dec 2023 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859824;
	bh=K2zT6kkUnhgLv0QLn9Ttq5VH+zsoNyXUhXhB1JpYuoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GL9Vj2z/o3o42r+Ywefuu/07JnPXtEUZFGBCFUyEmuLasnP8og2hpfsRf6vnZqpzk
	 ZDcaXad8NrMlT6J6jHF/JdRQZcTIF75NXjoOsq0FCcW/qNVmkkXbfqX+IVUZYNcKHe
	 lJnvBT1eDgMfnjNkmCrHuiX++SDF+Zgycw1xWS4NBX3s1wTsD5TGNSCY3pNN9wzksY
	 wGYgKp4U+nXDlT0WPYe/VgOkVAFsrHABckRI4PYBkSE895cgkZK1tuhNf2uvC9iQRT
	 6Jel6vQASniOqMdIpqEpQSlPtgjOW+YtlsRgYt8mar/xLwU1B7LinxtNXpsG1dqMNe
	 yW5anwbw2kVRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D9C6C395DC;
	Wed,  6 Dec 2023 10:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atlantic: Fix NULL dereference of skb pointer in
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170185982424.14845.6146405240665086065.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 10:50:24 +0000
References: <20231204085810.1681386-1-daniil31415it@gmail.com>
In-Reply-To: <20231204085810.1681386-1-daniil31415it@gmail.com>
To: =?utf-8?b?0JTQsNC90LjQuNC7INCc0LDQutGB0LjQvNC+0LIgPGRhbmlpbDMxNDE1aXRAZ21h?=@codeaurora.org,
	=?utf-8?b?aWwuY29tPg==?=@codeaurora.org
Cc: epomozov@marvell.com, irusskikh@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 khoroshilov@ispras.ru, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Dec 2023 11:58:10 +0300 you wrote:
> If is_ptp_ring == true in the loop of __aq_ring_xdp_clean function,
> then a timestamp is stored from a packet in a field of skb object,
> which is not allocated at the moment of the call (skb == NULL).
> 
> Generalize aq_ptp_extract_ts and other affected functions so they don't
> work with struct sk_buff*, but with struct skb_shared_hwtstamps*.
> 
> [...]

Here is the summary with links:
  - net: atlantic: Fix NULL dereference of skb pointer in
    https://git.kernel.org/netdev/net/c/cbe860be3609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



