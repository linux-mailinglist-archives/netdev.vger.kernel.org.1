Return-Path: <netdev+bounces-280547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKuHKdkx6WndVgIAu9opvQ
	(envelope-from <netdev+bounces-280547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:38:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A344AA91
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C51F302E91F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C93101A6;
	Wed, 22 Apr 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjlGHBL8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6F1C84BB;
	Wed, 22 Apr 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890200; cv=none; b=ODZrwd5dpDdB0/WTZqaH8NF98ikYv5nurpJRjFcWcQbdRQbjE3TfA+4YXDIBpDyKXgiPAwznVLbuorZVcpQTsV3vXqbTS8gKniMYi/Bz5Wq9pYOpu2lNe68U5uUFDJocj7w9I6Gu+l0eakSEFFszK/192SuDEODLU3CbCSGc8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890200; c=relaxed/simple;
	bh=DMxcSOr1q24bEmW5xW5hdezltUyBymhToVZCJJiCPxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fpTBE5W8Lw5LsRWopCTkSbEpOBpnwb+LOhZf59xBZkA3UxK+J/u+vlkJAcLNE2xR7EHcxztMSfuaMdHT7ZYp+OexTXP3fDhSS9I0noajgOnqIJy7QH2mb8ek0lJs0MSxuodCgbDiSUwPdvqDX43r2XJvtB8Pfzcua4+YFd9Qts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjlGHBL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFB3C19425;
	Wed, 22 Apr 2026 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776890200;
	bh=DMxcSOr1q24bEmW5xW5hdezltUyBymhToVZCJJiCPxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fjlGHBL8ycjs4hehHUMx3hmIOVBd9hQmD7w14hLTeGKK77IwGDQOBMSOcvquejD6E
	 v+NP3kbLBz4yQVRit4zkjXKVy8/fGCGtNd2ySY26MQkkdPoY7cpnm8CI0niRs3fP1d
	 m6bCquDwUgl75PFJW4jBDGllSsRhpRGw8oPBhOk9RzbdMuXUF37vFHtdhOTt+gxHxc
	 ShlDQFQnwKkghBs6/y5aVrP5DExMbRpT8OIdF6TKTkirBQdjnl4LOJ+ThiuQDa26a6
	 yv6lQvKbj2EaMUW+BWT/CBZNW/PkOmiBtaNFZmxCf7oP2o9894smdcxgLgx7k+QX3m
	 VeqWyDzhnd2wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF323809A84;
	Wed, 22 Apr 2026 20:36:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Reject TCP_NODELAY in TCP header
 option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177689016229.3912188.193023049316270576.git-patchwork-notify@kernel.org>
Date: Wed, 22 Apr 2026 20:36:02 +0000
References: <20260421155804.135786-1-kafai.wan@linux.dev>
In-Reply-To: <20260421155804.135786-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org, shuah@kernel.org,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, hoyeon.lee@suse.com,
 ameryhung@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280547-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,google.com,redhat.com,suse.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 374A344AA91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 21 Apr 2026 23:58:00 +0800 you wrote:
> This small patchset is about avoid infinite recursion in TCP header option callbacks
> and bpf-tcp-cc callbacks via TCP_NODELAY setsockopt.
> 
> v4:
>  - Fix the test case for TCP header option callbacks (Martin and Jiayuan)
>  - Reject TCP_NODELAY in bpf-tcp-cc callbacks (AI and Martin)
>  - Add a test case for bpf-tcp-cc
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] bpf: Reject TCP_NODELAY in TCP header option callbacks
    https://git.kernel.org/bpf/bpf/c/846c76ecc029
  - [bpf-next,v4,2/4] bpf: Reject TCP_NODELAY in bpf-tcp-cc
    https://git.kernel.org/bpf/bpf/c/54377fcab51f
  - [bpf-next,v4,3/4] selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks
    https://git.kernel.org/bpf/bpf/c/52b6b5334924
  - [bpf-next,v4,4/4] selftests/bpf: Verify bpf-tcp-cc rejects TCP_NODELAY
    https://git.kernel.org/bpf/bpf/c/2c7e33f1fc2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



