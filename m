Return-Path: <netdev+bounces-214802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1FFB2B57A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490C6626317
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C33189F20;
	Tue, 19 Aug 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNg4+R90"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CB157E99
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563996; cv=none; b=a+kyD9CzDBwJZidDmxU70FCqAJn7v6W+F2MNFGunNklcyQb2zewG7BMmID/YuAgY5A1wzrboZ2SIUApeexkkIGRYSfz0Uy9zZSZLsfhxSLpd59HauS1D8A2XVWcQpxzzM4JdfmakdUtV6inQsItToq5Zp8OES/CYJEV5JVIGoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563996; c=relaxed/simple;
	bh=b5jrRZ3rAqDjH6netzK8awnO0JWC6+vKVybzDofrWgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iromx1D1gUumGo+D9zCMxqxjruGrYjjDgZJCZcs/u2ZNLL0wbkirw0bkdPFYzCZYtFKzHL6QiGgifFk/oVmxUcSlJPwU7JWKzp1b6EVzMpAaOI5JZpBYGCODBugRX4Wp0+2udzXkRwGgLgkeW7vXlC2VAw80PpqBLB2VQJ0Qa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNg4+R90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1FBC4CEEB;
	Tue, 19 Aug 2025 00:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563996;
	bh=b5jrRZ3rAqDjH6netzK8awnO0JWC6+vKVybzDofrWgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vNg4+R904mhERuDg+Av1RJ0t+saKlLViEzkjbOUH+O5ZZC1OgEyDTiAnNOX1dl8LS
	 IzVOK3nA8fjoH0NfhbeLaLY+40wyKLYdKLa4sa7NRcMQfR4otdmc1h5jCySjRehEP+
	 rWK1BtB9zK5/Hk9EMXaQfn60YB3lWfx7Ovswioyox07dfCfDpwT1dfKtjnRuRZ9wdW
	 T7OBApxDZGfTDy2fUEiLV3/bIDRc4n1Lvh+gIMUrQXG6aXA7vFSFplW8dUEVdDEUNL
	 YTEbWO5RQx1krh7QnzmHRJHbHi3ai6kw7JTEqiLda60fHuM5IRgWddILIECpqVMYjj
	 +Ln8NcTC+Tvww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD04383BF4E;
	Tue, 19 Aug 2025 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] ipv6: sr: validate HMAC algorithm ID in
 seg6_hmac_info_add
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556400650.2961995.6158508190055197863.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:40:06 +0000
References: <20250815063845.85426-1-heminhong@kylinos.cn>
In-Reply-To: <20250815063845.85426-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: idosch@idosch.org, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 14:38:45 +0800 you wrote:
> The seg6_genl_sethmac() directly uses the algorithm ID provided by the
> userspace without verifying whether it is an HMAC algorithm supported
> by the system.
> If an unsupported HMAC algorithm ID is configured, packets using SRv6 HMAC
> will be dropped during encapsulation or decapsulation.
> 
> Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structure")
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net,v4] ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add
    https://git.kernel.org/netdev/net/c/84967deee9d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



