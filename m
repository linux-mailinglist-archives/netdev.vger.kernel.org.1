Return-Path: <netdev+bounces-265857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFDuG419r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:10:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D1D2440F9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42A23300BE3F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1A3264C6;
	Tue, 10 Mar 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUpUuVvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726A3195E3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108608; cv=none; b=Zab7Q7FsKJFqPM2aebUm9NfpU7neKPlyybF3e+GfszissWjQVgBwsuPv3iaUk0hIPpf20AX3SsuTqPTbhzQdRXy8Gt17JCzdnEn0ix52O0gt8ev51oWYLgt9U0oA8qtx86ivg9YasbCvuFxWxr8w7wjv2PuozqviNkQg1FeS46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108608; c=relaxed/simple;
	bh=Mq0WQ1/QkOn44NKIq4sfj3j5VwJnPxoCMulZcwnoh7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g+B6ZJpP5LSG3bZMyCcH4WavXmZGCE14u4OHx2bhFD4xK8TSunD4kgpgVIXKHeOSMMyraAZjL7lOUHIij1O1mvG5M3S7DO4/evHlZyhtZ4p7Ph/Sx8rrx1XG0qe4sWD4nFYBdogputkrqf8DsxONLULY69+WQUCA6ITU2JYqP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUpUuVvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699E4C4CEF7;
	Tue, 10 Mar 2026 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108608;
	bh=Mq0WQ1/QkOn44NKIq4sfj3j5VwJnPxoCMulZcwnoh7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZUpUuVvz9cTZ1W4859A+ypg6KyiLluTsWNxhkdpEejMh6ULM95y8+Gy5VaJqU1yT1
	 h8Flja5qLVyb1kC80oPtxp2GKFVCsJvuwky0ou9+Zkwy+SqILONTGmaT6eOFWQmAA4
	 DayY9Ksw+tME1sct2NXzgUUQvoHIrGNPxnm9Sh41zudLnCyC5SUpIqNwLQISSdlxRU
	 C81Gs0etfrl+EL/13yfJiMQQhkJZu18KyKnolOmGPnx0+cFCUuzXuyKkAchBwETUD5
	 KVtk3Y25NKqc9OJWyX/NGM9a3e06zbT+E9qGjgO+ZPBwaKPZfxfELO1YhX+MNKVbQG
	 Ans37BdfapNeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF63808200;
	Tue, 10 Mar 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: include/net/tc_wrapper.h belongs to
 TC
 subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310860555.2026004.6573841943729666049.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:10:05 +0000
References: <20260307120607.3504191-1-edumazet@google.com>
In-Reply-To: <20260307120607.3504191-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 81D1D2440F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-265857-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 12:06:07 +0000 you wrote:
> include/net/tc_wrapper.h changes should be reviewed by TC maintainers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] MAINTAINERS: include/net/tc_wrapper.h belongs to TC subsystem
    https://git.kernel.org/netdev/net/c/7a85d370bbd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



