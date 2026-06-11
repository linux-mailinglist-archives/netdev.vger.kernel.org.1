Return-Path: <netdev+bounces-298139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jBWHCzi1KmpkvgMAu9opvQ
	(envelope-from <netdev+bounces-298139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:16:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C6672464
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:16:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gbrMvpik;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C731530154A1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39363FF1D6;
	Thu, 11 Jun 2026 13:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360B403AE5;
	Thu, 11 Jun 2026 13:15:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183725; cv=none; b=jxOx0YBkWNVnOQpr9LBb9iTFfz8YjZtg+Ec5bkK2OiE1dRSQPNjnsvyLuxPhQkEi0HFttK53KNjYk8lsT86WfCxj0XSTHLxeKF9LzMQXRXIJvcePDztXIrWFHjngqbJpOYMyvDjrqGdtDArAS48Qiy64FsoxXloVjKaamLWVL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183725; c=relaxed/simple;
	bh=PdKWkdCDHflSZtNTqELwSvbkjpf+tKc5hRvfZMTzIHE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VH43PHN/lgw5sKoBqfcaqDCXfjVIwJ+WliNzmjVMbVhaYvzSW+9Z4vkoyj1oLptQ+hIOjjZTRZn9vHzZ4MkO6DgYrPZ/lixztpazYUCVqQ9M5mg0e37D0BOlTy+u6NBFKAN55uaKPYnZqWmSh+hCPoiudE2ri+A/A8fi/RPlphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbrMvpik; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B131F00898;
	Thu, 11 Jun 2026 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781183719;
	bh=3GRY++hgn/u6Bom4CtnUx66yzo2ytmPfyNCNHvCqzmw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gbrMvpikylV3ogYKQYR/GTXbviDSjLxUJI+VH0ZjQdorkMpggYnbCEIQUEZGrK32C
	 0Stsm0NkaNqr1prSn0T7IoTmHChTkCkZ+rKHUH/eS2JQUE61r9cqEmOgFd9a9swL8z
	 r2rweIqfG87aRiWFlB8uL/qjENpDxCTOcgtRb8xakzCySB5GyV1MbnD0SPRKAswd1J
	 tU7UoUOg2fnIfuxWUB90hhUz1obggLM0/zC6nCEPv/HzfTBmCWcmvXgBSh60ab/bFj
	 xYV5vUcvN/huyvMFuJo93aFAojxOIQ5xe1n/mc/kxFCddIeVAogGM0xHXzBnMjNhL2
	 Nm0vlyRYufpUw==
Content-Type: multipart/mixed; boundary="===============0228148785043914855=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd394275c89a43251cb8e94a36b7d2cc61ef4433847b1c407cc53fc6a1efc2b6@mail.kernel.org>
In-Reply-To: <20260611123538.156005-6-jiayuan.chen@linux.dev>
References: <20260611123538.156005-6-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 5/7] sockmap: Fix use-after-free in udp_bpf_recvmsg()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: kuniyu@google.com,syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com,jiayuan.chen@linux.dev,jakub@cloudflare.com,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,hawk@kernel.org,rhkrqnwk98@gmail.com,ihor.solodrai@linux.dev,cong.wang@bytedance.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Jun 2026 13:15:18 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,syzkaller.appspotmail.com,linux.dev,cloudflare.com,iogearbox.net,gmail.com,fomichev.me,kernel.org,etsalapatis.com,davemloft.net,redhat.com,bytedance.com,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-298139-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:kuniyu@google.com,m:syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com,m:jakub@cloudflare.com,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:rhkrqnwk98@gmail.com,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:syzbot@syzkaller.appspotmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9307c991a6d07ce6e6d8];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 914C6672464

--===============0228148785043914855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0]
>
> sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> but its processing is lockless.
>
> Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> multiple threads could touch the same sk_msg.
>
> For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock.
>
> Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> commit accidentally removed it.

Is "accidentally removed it" the right wording here?

The cited commit 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
removed the lock_sock()/release_sock() pair deliberately, and its own message
argues for it:

  UDP does not lock the sock during BH Rx path, it makes no sense for its
  ->recvmsg() to lock the sock.

So the removal looks like an intentional change that overlooked the lock's
role in serialising sk_msg_recvmsg() against concurrent recvmsg(), rather
than an accidental deletion. Would something like "inadvertently dropped the
serialisation" describe it more precisely?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27347782396
--===============0228148785043914855==--

