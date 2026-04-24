Return-Path: <netdev+bounces-281034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIZFDKO062kJQgAAu9opvQ
	(envelope-from <netdev+bounces-281034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:21:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B74625CD
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21890301A3B3
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B73F0747;
	Fri, 24 Apr 2026 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3LJa+Mc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C743EF669;
	Fri, 24 Apr 2026 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054849; cv=none; b=kHpA931SWz1JbnGWB2M5jDxPrtuavjlLLkho1KrscurP88zB381lU/MKRm6sW2oIO+8ULHkizoLYnIXUi9R1Hx94qOhPRY7UKxpfZXdc/SdGv65cNZWxNwDfMVj26z3wkDCCw5W4kdEyjdFLqFaC0OkyRVRwXNZKE3h60NyESxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054849; c=relaxed/simple;
	bh=fPAbYszOYtL10ym6d9Nwm9WB5nSR2Kqggw78z0h+UpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HdzXL8XZcheyjt5i5jULA6L3ef+ZNTOrcoxhjU5zE8xHBcUy60QdC92hZcM/Zb+RQwGvipLjfYbiwgXPSP6Qzm5+xGgZ5j+4jXnWLkh2/mdvcswwpEDCanKLQaqjEJtTHeGkj9+FxPjBLTHdDOcNMK1ukzrqiULbUn+mzhjkdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3LJa+Mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D5C19425;
	Fri, 24 Apr 2026 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777054848;
	bh=fPAbYszOYtL10ym6d9Nwm9WB5nSR2Kqggw78z0h+UpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m3LJa+McnhVi32mADpapuSEfTG9xZF/8YAWofxUOdSk8bGL1QCsaxeOx1sPkQHXeN
	 MTMgN5BxhJ6OlIzvDGvKF2cjbWO956YbzpJKwWri6dBX5rA7re9R4y6cQ1xL+HyCle
	 Cr//5iWk2yeWQwLQyjiEbqQd1XoKQHUpWROX/c8UesKumBSgNuLw5gr1WTxgdGi1pc
	 +wRv64yOYhiuSFmfct4bLbiHISDZs5m92dKOK+9w+nlrTwEcvw1KaDs6jxbvg35vJ8
	 ZpA0n2OhAlymEJHuM+AJb/3028JkXKQlDoarJHxNQsK9HrFoY7kRjOPak6KNhElviu
	 GCtq20RZxUVTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE938119C3;
	Fri, 24 Apr 2026 18:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: drop xdping tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177705480880.1650547.11751423238740714723.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 18:20:08 +0000
References: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
In-Reply-To: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, ebpf@linuxfoundation.org,
 bastien.curutchet@bootlin.com, thomas.petazzoni@bootlin.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, alan.maguire@oracle.com
X-Rspamd-Queue-Id: AB5B74625CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,fomichev.me,linuxfoundation.org,bootlin.com,vger.kernel.org,oracle.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281034-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25]

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 22 Apr 2026 18:20:23 +0200 you wrote:
> Hello,
> 
> this is the v2 of the small series dropping xdping tool. This removal is
> part of the larger effort aiming to tidy the bpf selftests directory.
> This new revision updates btf_dump test to make it use another bpf
> program rather than xdping_kern so that we can drop it as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: make btf_dump use xdp_dummy rather than xdping_kern
    https://git.kernel.org/bpf/bpf-next/c/d4a2eeb2ac78
  - [bpf-next,v2,2/2] selftests/bpf: drop xdping tool
    https://git.kernel.org/bpf/bpf-next/c/feb13b19f3fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



