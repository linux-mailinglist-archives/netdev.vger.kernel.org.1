Return-Path: <netdev+bounces-261281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNIYHaAjoGkDfwQAu9opvQ
	(envelope-from <netdev+bounces-261281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:42:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2081A472C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8150301D310
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668A53A9017;
	Thu, 26 Feb 2026 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACEXSJS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1427472;
	Thu, 26 Feb 2026 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102506; cv=none; b=Hujx76jUKkPWEz+M3EQZP194KNgiMCZsAqgcBZ2IBBzWc39hDq5nLURn6xKSQs2FPNBMCCvW6irP3f7khkBAZ6UKKQxkfEgP1fdF82LZgkr5/SP5s5ysi3+oAlkH07ZPj1ZlzFo/6eAGuL21ex6s/bh+mSuTg+yeH6c2/0bpzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102506; c=relaxed/simple;
	bh=NMzeyOxAYXzF4sthIP3D/i7E+x8X8zh6cTJ8kUu7Pu0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gWvI8GFMqpJLYNYzy3g+ZcrdRE5wYGv3YCTa9WqVJ8l3KULoeX3tJ2HD+xKKD/5dGTahQhzT65wBFQXK1n4h+ccSiX41Sq+vHriLWXSugVL7kEusgwgvd/7rRqoI7cauZi+WvSo1Ns0vbbyvq+BnhIpFcH1I9xr3HscL32t6wq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACEXSJS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F6EC116C6;
	Thu, 26 Feb 2026 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772102505;
	bh=NMzeyOxAYXzF4sthIP3D/i7E+x8X8zh6cTJ8kUu7Pu0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ACEXSJS3B2fQEadkGEJl1zvYqazqXvxdDOIOjcbjXB34DqReGyuQ8Wp+EbHWE2Ncq
	 Jc7w5zfeuir54PgUCwibSqog7dUFxMcOvmYp+vaBoBq6FHdcBRJLUyuHWdy4ysp7iY
	 SYEqIkalGg5GK4C3XqpU023DIzxi9BGwhxw3UqE3WgGYAsnC+uVao+AIXyvQU7b+up
	 TMG6qECmP/DLCaFHL/VHztCoFzhbqKw2ui47E2MtNKe+Nw/t4tFvYzDGgEd2e84eKi
	 KP2FDbdNtPxQ7fUNQPTnR0s63oVU0sHX5xhtiMGg5CYg+ztqWhboa5qiSLfxuPScIA
	 VHqDULfc8kGKQ==
Content-Type: multipart/mixed; boundary="===============7185096252700937842=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aab481dc12d67bc2e6fa5981adc5ce250251dd41ec966bd86e227777f18adc0c@mail.kernel.org>
In-Reply-To: <20260226095156.117996-2-yangfeng59949@163.com>
References: <20260226095156.117996-2-yangfeng59949@163.com>
Subject: Re: [PATCH v7 bpf-next 1/2] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,posk@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,yangfeng59949@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 10:41:44 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261281-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: ED2081A472C
X-Rspamd-Action: no action

--===============7185096252700937842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1156,6 +1156,18 @@
>  		skb->ip_summed = CHECKSUM_COMPLETE;
>  	}
>
> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT && !skb_dst(skb)) {
> +		if (!ipv6_bpf_stub) {
> +			pr_warn_once("Please test this program with the IPv6 module enabled\n");
> +			goto out;

Should this set ret to an error code before goto out?  At this point
ret is 0 from the earlier convert___skb_to_skb() success path, so the
function returns 0 to the bpf() syscall without ever running the BPF
program.

Every other early exit in bpf_prog_test_run_skb() assigns a negative
errno before goto out, for example:

    ret = -EINVAL;
    goto out;

    ret = -ENOMEM;
    goto out;

    ret = -ENODEV;
    goto out;

Returning 0 here means userspace sees a successful test run that never
actually executed.  Something like ret = -EOPNOTSUPP would let the
caller know the test could not proceed.

> +		}

> [ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22437468613

AI-authorship-score: low
AI-authorship-explanation: Patch iterated through 7 versions over 3 weeks with detailed maintainer interaction, consistent with human development.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing error return code on early exit path causes bpf() syscall to return success without executing the BPF program when IPv6 is unavailable.

--===============7185096252700937842==--

