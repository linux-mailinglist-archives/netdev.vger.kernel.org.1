Return-Path: <netdev+bounces-304969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3iIBAuES2oSSwEAu9opvQ
	(envelope-from <netdev+bounces-304969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:31:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C77870F359
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:31:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bQ9GFhCg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304969-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304969-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F102F3034E61
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EECE3542D4;
	Mon,  6 Jul 2026 10:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365539E180;
	Mon,  6 Jul 2026 10:30:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333806; cv=none; b=byoiPL6vqnExldU7z7JfHzBXwXRFUdMKhHLOVsbNT4X7NY/gzrQd55O3kADM73ST9DfsojgV3pXes9d64WTQojM60CjlkC8Yu/1AItzyNn7RRyugtHpoXE0gAgeV3VOGa0J8PgHGh9hdpS5D8BwixMlBJ1Ea61Uaa+1mxpIESKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333806; c=relaxed/simple;
	bh=PovVaJBXvo7F/DUG48lk7lmeZfxT0THrfNcq6WaEWFk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bSAZzw3SXKVkx9ale/nzmOaPJYgVtaXQEx4xFC+rJ0qpx8G6fuhMNxMciJPv2RGKPRTuO7vKYnUPNEOG+5HwYaIDRhyGQbAsm67ANXHNzu7Y227EleaozrXi36J8uM0EPOIvcMJCf5d8VzLtOqaGga9fOiSvCDRfU9LaPruV9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ9GFhCg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3968D1F000E9;
	Mon,  6 Jul 2026 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333804;
	bh=yoJQf2tgVUOUDC5N1ZsAsLWamfYSyyoGOSY+e/G8j/E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bQ9GFhCgVWU9ttyRiXSe5Fe2cno3o0nY1D1fY4Jbuu/FgKIr3fIg++MUox0S7ZuaJ
	 EyjQIV7XXstnoabVcKQyaF5BX5PNJaY5iC4n7GM52vcOWwA8IrH/rD6oLPBaUtPLFe
	 NunomBi7oLr+UH24p24t23fh3LwF2cu3+o29Ack9Y0b7ZtLNoKvxHJtzvSYXsgzZlB
	 sUU74oBeyWvCkQRF0OY+LQDngszJNo0L/0XQkJjTsw1/eB1SU9npmYP7kHTmKaDBJF
	 8QDaHt81spoNrH0FDkb1HR/mZIWzQr1eKmh7MkmGncK/kISd8p9bFY2052FgaCxeoM
	 vtamxKxrF1tAw==
Content-Type: multipart/mixed; boundary="===============7512621012704370823=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <268078861c26e02c25e9e882bccc607bedf580ae3c1d7e06562c48b85450f1a7@mail.kernel.org>
In-Reply-To: <20260706093525.13030-3-mahe.tardy@gmail.com>
References: <20260706093525.13030-3-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 10:30:04 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-304969-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:martin.lau@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:mahetardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C77870F359

--===============7512621012704370823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> new file mode 100644
> index 000000000000..8bde734bc917
> --- /dev/null
> +++ b/net/core/bpf_ksock.c

[ ... ]

> @@ -0,0 +1,516 @@

[ ... ]

> +static int __init bpf_ksock_kfunc_init(void)
> +{
> +	int ret;
> +	const struct btf_id_dtor_kfunc bpf_ksock_dtors[] = {
> +		{
> +			.btf_id = bpf_ksock_dtor_ids[0],
> +			.kfunc_btf_id = bpf_ksock_dtor_ids[1],
> +		},
> +	};
> +
> +	ret = register_pernet_subsys(&bpf_ksock_net_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&ksock_init_kfunc_set);
> +	if (ret) {
> +		unregister_pernet_subsys(&bpf_ksock_net_ops);
> +		return ret;
> +	}
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&ksock_kfunc_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +					       &ksock_kfunc_set);
> +	return ret = ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
> +						 ARRAY_SIZE(bpf_ksock_dtors),
> +						 THIS_MODULE);
                                ^^^^

This isn't a bug, but in the final return statement the assignment
to ret looks like a dead store since the value is returned right
away. Could this just be:

    return ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
                                              ARRAY_SIZE(bpf_ksock_dtors),
                                              THIS_MODULE);

> +}
> +
> +late_initcall(bpf_ksock_kfunc_init);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28783010022
--===============7512621012704370823==--

