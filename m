Return-Path: <netdev+bounces-296566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JFCSJyvFJmo6kQIAu9opvQ
	(envelope-from <netdev+bounces-296566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:35:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E16656B29
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:35:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OKw72Vsk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296566-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296566-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CFB3067426
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85C337F01B;
	Mon,  8 Jun 2026 13:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E63812D3;
	Mon,  8 Jun 2026 13:31:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925512; cv=none; b=bn1gX4sToRYwzkzowLX7Z/YJw6rLykzexQ9ifaAxC/QLBMIE7UYEFuRtry9xpsMv97KU2nCVy8+BN6KWDOFwIs6+snaOhlvYLMCfmgYHUTYEfQnrhNgEdcP+ZgOFapbAu2+X0A/3iOWCq0iArwSAb1ovRdxSbmLI+CgzBtXUFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925512; c=relaxed/simple;
	bh=kuyvvj+Mp4x9S+syP+xAhNTdiJddrx2uGyukKH7Lu2Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VZ6cgHIy20ieh4KBG7EnJPek9bEYMlQ/ZGt5t8Kuc4HSZvqdCqeOJWy0jGDeyz8CKhOLYqPM4KQA2sV3664ZoAo4yya+49qmXZ2I+0IKqeao/iNQVxQx9kZOgvlSJv2uma+XrYlZZc7N/jncs9N4VGOdKKDLIEbGS8XVxP6O3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKw72Vsk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBE31F00898;
	Mon,  8 Jun 2026 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925509;
	bh=3hUCD52RQZCWYTA6/jfn4ZCEYBcs2/9ic1Q6KExOLzc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OKw72Vsk86BhNF41oeC7W6l2DuhElFkbTwQ4S2c4fTWakIrbXO1nROmNEbRKWTzy+
	 dVq28g4gweCRvHXSlpdBC6bk+ZHS2ihmEAT4Orwv5Qg36TcGP9ngJixgAHV8mF2hQX
	 g44IMaDIfx3idL8XPCtrWQP7qgWvWzf1+pDi7Jxf8ayjsBty/fW6JHdRTYU3mHShHO
	 tNIFcB/NYgMhhBJFeZDWKXi652XIUqTwiEIg4pmrQsifMTXxg6XW9BTeqDMdH9a5p6
	 bELnBpVdySMQpmMbAd8olsYrBXNHU4j8lRAtLVbypSnqTnSuyguQuz9i3HPt2wnv7s
	 hmoQZLcT9ujCg==
Content-Type: multipart/mixed; boundary="===============5164577399796536821=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <520beb0ce4f6b49c0e41862bd9bcdbc9e4fdc85581cb8c3825516a22c62b7170@mail.kernel.org>
In-Reply-To: <20260608125846.157004-3-jiayuan.chen@linux.dev>
References: <20260608125846.157004-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v8 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,willemdebruijn.kernel@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,joe@wand.net.nz,kuniyu@google.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 13:31:48 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296566-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,wand.net.nz,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8E16656B29

--===============5164577399796536821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> index eaf441dc7e79..b644acd3e903 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c

[ ... ]

> @@ -145,6 +145,85 @@ void test_tcp_custom_syncookie(void)
>
>  destroy_skel:
>  	system("tc qdisc del dev lo clsact");
> +	test_tcp_custom_syncookie__destroy(skel);
> +}
> +
> +/* TCP and UDP servers share the same port. The BPF program intercepts

The BPF subsystem style guidelines ask that the opening /* of a multi-line
comment be on its own line. Should this be:

	/*
	 * TCP and UDP servers share the same port. The BPF program intercepts
	 * the UDP packet, looks up the TCP listener via the dest port, and
	 * attempts to assign a TCP reqsk to the UDP skb.
	 ...
	 */

The same nit was raised on v8 by the automated review at:

	https://lore.kernel.org/bpf/20260608130746.218891F00898@smtp.kernel.org

> + * the UDP packet, looks up the TCP listener via the dest port, and
> + * attempts to assign a TCP reqsk to the UDP skb.
> + * Although bpf_sk_assign_tcp_reqsk() assign udp skb to tcp reqsk, the
> + * network stack should not crash.
> + */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27139886597
--===============5164577399796536821==--

