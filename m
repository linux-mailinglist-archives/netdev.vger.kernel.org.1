Return-Path: <netdev+bounces-272942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIJ4BudYyWkuxgUAu9opvQ
	(envelope-from <netdev+bounces-272942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 652943532D0
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3615301E3ED
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B83815FD;
	Sun, 29 Mar 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7da53Az"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E037F75A;
	Sun, 29 Mar 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803134; cv=none; b=SF83lYY26XyeEdQ6A5Gfg4CDQ+HQ/wWH7aiHmmabtFSigEH4A2dvzb74lKS/HddAiF/U0oyFvs73DqdL2DWQjVKww3KqcXuwyEQRIM3KdV1Hm40ZKuurmEErtW/ybVLOMwT9jeVb1wMwnm/JhTS/qHT64XHk6lQUS8cnvjRRUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803134; c=relaxed/simple;
	bh=GTBfHE7Bklx/PyUYcF7LxNvdUIG7eNZg2Z02CvWB8ks=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cHHj9lVLq4LPECtdRP3K7FKHWuX8OJhEb28SsChGgmQlPqYSk38u++3yHtjZUfROVFMmjFJrk9OhZgMChQEG+7wMyQXK9nGn+gOCYUYMfNWGE+NOEgKJw2WO458qCcGAWaHoEjvWrC7TcIWF02nhhR9BsrsKSlL3VzyB4cy2BlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7da53Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44872C116C6;
	Sun, 29 Mar 2026 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774803133;
	bh=GTBfHE7Bklx/PyUYcF7LxNvdUIG7eNZg2Z02CvWB8ks=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=h7da53AztCCCZukjTXcMVWODw7EIkYfWjxf51AITRcKPlrFYePYOi0wS5lZSAEKGE
	 U6BUW1Cw0agIzFp/0yPkAMWKhRH6Xp3ioFq6bPcYdKptRTW9CKn8GhAN1hO+9QLGEz
	 iOvoUw8n/pDdfUJVVfRfd0VcOQ3bvzZSfbrv17/dk41hLICwn0d2RmBZyrcnVbTTZa
	 tU+kZo7mYox/Uw5oiOC0ejKsHJVajerRzFYEEI0kBJuYFrt3UTBePGCAf18+jxQ4+L
	 TEmUWhWpQ23nRiqbfkRVakNq91bJ3XFSMP7TRdDseBNtw+6EccIxzhN7tM8q+mVGvj
	 qwQqzAlZNHgsw==
Content-Type: multipart/mixed; boundary="===============4295225971625095632=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c4068e683ba4befef2bb16f5f80756a1cff4a2a2a2adaca3cdeb4e466dd27cc@mail.kernel.org>
In-Reply-To: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,sun.jian.kdev@gmail.com,syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 29 Mar 2026 16:52:13 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272942-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	NEURAL_HAM(-0.00)[-0.547];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 652943532D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============4295225971625095632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

This patch fixes a bug that has existed since bpf_prog_test_run_skb()
was first introduced. Should it carry a Fixes: tag pointing at the
original commit?

Fixes: 1cf1cae963c2 ("bpf: introduce BPF_PROG_TEST_RUN command")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23713682616
--===============4295225971625095632==--

