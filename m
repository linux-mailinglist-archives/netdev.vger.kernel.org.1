Return-Path: <netdev+bounces-120181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97C958813
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0241C20C18
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549FD18FC80;
	Tue, 20 Aug 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNNcAVVB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069E1AACB
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161235; cv=none; b=Ym8EakseIa02wk6M2IBjFeMToz3S6CdXtYjy+l9mkqBegJM8ntsrM0orMmY0OqlCwuYnAhAcbTqCgppb0W6Otc7tqakZcMbcyNEXqYm7zDJREDUfUR2cq4JFQQlsuPsEJA28Iun8jrf78/IJTOQCOLMUhCSdfEgMlR8KoZ7LLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161235; c=relaxed/simple;
	bh=0MgIG8SrgetwxakMOnTUop7i726OUCw3MImWE910ul0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bZ9GQo5OGwjNlMs7l4/GZqrAphMM+2xMJUbL+L6b+RDc9eI4dex9cJiviWWRPKNq9DuDhAJzg0YnFtKdysknWbA4vV8AyLb+/WTFQUMCX+aBNNQ1B7NvmaMwx/PMFnof5x40DesrkTJHxtsoH3NTwFqUEL8ju75axlfOOikpXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNNcAVVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3A3C4AF0B;
	Tue, 20 Aug 2024 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724161234;
	bh=0MgIG8SrgetwxakMOnTUop7i726OUCw3MImWE910ul0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gNNcAVVBoS32rPCotmazbhi483CzAlvYZlrIjC0B/+QTfjuRnUsddFfyYFld1XTtf
	 bbPMJnLAKZika2FIEpl8pNJKNKBeASdopXRHO8Bg++hBDhrsOIs7Rd7wIJbn8piuU6
	 tVbaQVm7Cer7qyMiVuZ8a5WeTZ714KQ9ssS05K/sLGicVSmuZN2dN6CbOudedjflHK
	 ijhKZVQ1NRkpAJo2VQaPx3fKxNdH9lGSvzf40SVlF/n8J9w3mmaEPnZL3cFx3isJUP
	 F4O1Le8lJ0+fc4QWNCR4RSQD4EsEpnFpfs2wBbgy/m6JMi0go012aqY6x/JRY9BDxp
	 qsKVYva2+QpqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5D3804CA6;
	Tue, 20 Aug 2024 13:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] bonding: fix xfrm offload bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172416123426.1143013.18023670009748670619.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 13:40:34 +0000
References: <20240816114813.326645-1-razor@blackwall.org>
In-Reply-To: <20240816114813.326645-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, ap420073@gmail.com, davem@davemloft.net,
 jv@jvosburgh.net, andy@greyhouse.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jarod@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Aug 2024 14:48:09 +0300 you wrote:
> Hi,
> I noticed these problems while reviewing a bond xfrm patch recently.
> The fixes are straight-forward, please review carefully the last one
> because it has side-effects. This set has passed bond's selftests
> and my custom bond stress tests which crash without these fixes.
> 
> Note the first patch is not critical, but it simplifies the next fix.
> 
> [...]

Here is the summary with links:
  - [net,1/4] bonding: fix bond_ipsec_offload_ok return type
    https://git.kernel.org/netdev/net/c/fc59b9a5f720
  - [net,2/4] bonding: fix null pointer deref in bond_ipsec_offload_ok
    https://git.kernel.org/netdev/net/c/95c90e4ad89d
  - [net,3/4] bonding: fix xfrm real_dev null pointer dereference
    https://git.kernel.org/netdev/net/c/f8cde9805981
  - [net,4/4] bonding: fix xfrm state handling when clearing active slave
    https://git.kernel.org/netdev/net/c/c4c5c5d2ef40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



