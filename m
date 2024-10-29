Return-Path: <netdev+bounces-140050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4A9B51FC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1177328542E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C62071EA;
	Tue, 29 Oct 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/VCZh1+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DF20513C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227228; cv=none; b=aqEo7Ll8cZcrNkd/oiaS6MMn9sujLcMttcBHIKx2frhckQ5nWoS9KTtAjqvA3VxagKGJ/sLBXga7G9zX52+i1lFjv5S4f7kHf2o4YQMiZitTxX0CuJ+L8acenWTJ9cPfpHxmWoUSCa5xV4Pxuc3auT8cOPZKlz2/uYEnHEdpql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227228; c=relaxed/simple;
	bh=m0lwmNQTDVvoyeWvHVowKOrqJBf+VfnAycukgGK+nQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KTYJDPyRyacagksZstKlLaSJrsGfj8OAUO3k32YRNAxNSCnCBMUwB6nNiTbmXS4kbjEHmSFnfMU8afy7FCNTSgy8lE+n7EoTjqdHHpnjzKeIzHbtrCGmMqyULs5/hhbXer++VDNjcWCguVmguIkD3ZSBUCiPuCyGicBzE5sAdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/VCZh1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2896FC4CEE4;
	Tue, 29 Oct 2024 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227227;
	bh=m0lwmNQTDVvoyeWvHVowKOrqJBf+VfnAycukgGK+nQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p/VCZh1+DORzvVZVV8HIfGQuC1Ml6y3XoSX/cibatrNHzN53YINb+hZzePM16Sqq8
	 URlhOCo8vlcOGBi5zXZrz5ow3Po5DcHGYDlKI02vNklCVU56PPu/HQkyEHr8jXKu+L
	 1Pd/JL74BHVTQ1REQEoiGbBONnVmDPdp695+rtVSrtpJCHWqm0zdKA7O+Mq8bDFi0j
	 B4GOWwdwnAMAfR+20HivIXXc0RpHc+WaPaUqBNyYEl8e1TA8BIXKBswL5WpTi6Op5l
	 ue9dirgPsVRdXmKBautBd2hNyhoeq3ue9RcbR2ls1TbOlckqF3RE/lA8AyKmes3XWO
	 ywbG5h+JwHsYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCF380AC08;
	Tue, 29 Oct 2024 18:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-n] net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022723476.784474.8433648139537058569.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:40:34 +0000
References: <20241024165547.418570-1-jhs@mojatatu.com>
In-Reply-To: <20241024165547.418570-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, markovicbudimir@gmail.com, victor@mojatatu.com,
 pctammela@mojatatu.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 12:55:47 -0400 you wrote:
> From: Pedro Tammela <pctammela@mojatatu.com>
> 
> In qdisc_tree_reduce_backlog, Qdiscs with major handle ffff: are assumed
> to be either root or ingress. This assumption is bogus since it's valid
> to create egress qdiscs with major handle ffff:
> Budimir Markovic found that for qdiscs like DRR that maintain an active
> class list, it will cause a UAF with a dangling class pointer.
> 
> [...]

Here is the summary with links:
  - [net-n] net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT
    https://git.kernel.org/netdev/net/c/2e95c4384438

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



