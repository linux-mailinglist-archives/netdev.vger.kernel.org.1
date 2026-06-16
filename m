Return-Path: <netdev+bounces-299977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cFDQF3TPMWoAqgUAu9opvQ
	(envelope-from <netdev+bounces-299977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:34:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A364769595A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:34:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b="R/2h6asC";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299977-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299977-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E581300187C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58AF3A8722;
	Tue, 16 Jun 2026 22:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D6C349CDD
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:34:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649265; cv=none; b=CVF56GXZ92yOeJfGcLIyJvLZHtEmOKms0npqgAKmJgCRGZKJLaAXKjrwCn3AgmOxDi5+f49rggPofi1Lfava0WbFxIAQ2JYYhcPnOcYnTnkaxyfjuz43rOa3908FjeM9NR0d8WlsFf8S1LzoeVZMoM8Fg8/d93r+uPd5gWHgXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649265; c=relaxed/simple;
	bh=+k+Z5QT8jwp2bFgq5LnQarAVCm6xtVohhvDgImufK9I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ht1d8vc9mqTz/8CeJHeiOxKOzh1mCTvzlJ7+iklK0gjSA3rVEykVTN1vOh6jilUcxkhJWtw4ak1SZemfBWaXhIoi6ADLlmmBlW++dep/RmNkFjP+CnykA5tauw3x7ictQssUcmMxufLEALhaKgqvVCHT2jE91Bq4UnbkmUY3x9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=R/2h6asC; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13810b63a1aso11370831c88.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781649263; x=1782254063; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD5iZFuM9ZopY66WGxBJxUk9sqbEsapLkycXT2EpEGQ=;
        b=R/2h6asC6iYJaz6+jj9LMjgxjwPi7mM3ZZNfOAyFvCMwbWcpodwzbzijY/iuEYIkNO
         DtRMmQABUM7IfbI8wXTbMR/T/2k3LrLICoaDzIAhuDL+H2pcW3zULb3WemuHb6CVMyOy
         NBh+k6WLXtC62G1Z3tJFnozyasl3X/9AInT+PM7wLqUkKlOsm1BFVWMazQHyD93E9FQ9
         h417s2SK4yERe10W2FDqPiPwyuXnAdSz4RKgqytBhuNkR2n/Rf92fFVxKyiSMbadc1gu
         GGbf18sZYrJGsTcdiGK96jZnPonSYEGUjFWUBW0uY2iYmhX9RwRlfQ/jLHaVPm/CKszG
         HWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649263; x=1782254063;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MD5iZFuM9ZopY66WGxBJxUk9sqbEsapLkycXT2EpEGQ=;
        b=ho7PvI+rk98FuRumzGcEqhkAHw0wN2mskKcWndWt4Gi96MX0llHSZZxNhG6VFhAGYB
         fZkqr+bbkJSA4jGV+1lSNnfAh09XA3AkKFLjaycd+AQZ+thyhH1TZLsH7sX9PPgfrTcr
         mCexjZJOISndoAx20Oe5XMZe0vrnhRsVRuusrGSTG+uw+1aOZyPLlRwe5MDVrIxqMc1M
         1Yqg+ZUZAmAFuq+ykoeoch5x6sUQsmpcJTzNbUai4N8fv4hjSrtmjlKgB/Va6SW8FnBo
         SwZe2JnG/cgqSWXdiGCq1QVlP98lC/xdOx2dVmgw3IoYnflJqthw1Ct9epskjqqDKF2K
         Ls9A==
X-Forwarded-Encrypted: i=1; AFNElJ8hvIUrG6elGMrKJ7RC4u2oVUZrRpuvI1X9nZ1skipsEcfbfzK889jaSmIomUinpc2YPXkjrAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGtaFa1RUOn5THW7UHn5o1AR0HAki30ZwBttK0OoxvekWkKl0
	ensoaIa2BDJm/GmdjEXohAJGJczpKLDEPw8E2hUCQloxVXxSxKvOk35veMzq9lbdIigJ2Zn3YNB
	oLmvN6bh5uw==
X-Gm-Gg: Acq92OGrhFvXcfEh0KwMSuFU5TF4e3Qh0JGNhdmvbsNHn5P6+v0kuokaaMxFOosTyh8
	yKEJGIo7AeS2SgV7smaj2CINaWfV3OnZrSubOrihV4EeWnEFAayymzXjk8oSc+6exU9WHKTSyZq
	1d6pjePkaLuSer28IAU4z1ZTN1ybAoeMl/qUKgRZK5m2QFXjCv9SiEpzZCn7Jz75QDNiu+qbW1U
	Xj3LV2BPQybjYP3wPHSSMh6Df0ChKDQHeIPp+LCTR55nEmvvkO/zBBP2LojGw4roXVGVK+XgyK+
	Dodcxi2bfrtnrlGu1TX/kx2jODCYrWtAC89VeDrZiJ2hStypaFpi7KXbfqpDUMY/Xg6OnVYpKBU
	ouDXWMmH1h/Bn4jwMFYMdp45qVq9SmyGl6Mojy6z2BuzF7Jbb+line8WSmIGCZrkaX1n4rGxI61
	pC1nmx
X-Received: by 2002:a05:7022:6b82:b0:12f:c7c3:f5ab with SMTP id a92af1059eb24-1398f66bbd2mr534919c88.2.1781649263283;
        Tue, 16 Jun 2026 15:34:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97570asm14146633c88.12.2026.06.16.15.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 15:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 18:34:19 -0400
Message-Id: <DJATYAJ7LUNT.NHNYXVW1RTGV@etsalapatis.com>
Cc: <pablo@netfilter.org>, <fw@strlen.de>, <phil@nwl.cc>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <shuah@kernel.org>, <kartikey406@gmail.com>, <coreteam@netfilter.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover small conntrack opts
 error writes
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, <bpf@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
 <c4c898dd23181b676ebf6b6b4d9c54f51bb69c75.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <c4c898dd23181b676ebf6b6b4d9c54f51bb69c75.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:kartikey406@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:chenyy23@mails.tsinghua.edu.cn,m:bpf@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-299977-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,etsalapatis.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A364769595A

On Tue Jun 16, 2026 at 1:42 AM EDT, Yiyang Chen wrote:
> Add a conntrack kfunc regression check for opts__sz values that do not
> cover opts->error. The BPF program initializes opts->error with a guard
> value, calls the lookup and allocation kfuncs with opts__sz set to
> sizeof(opts->netns_id), and verifies that the guard is still intact
> after the kfunc returns NULL.
>
> Without the conntrack wrapper guard, the kfunc error path overwrites
> that guard with -EINVAL even though the verifier checked only the first
> four bytes of the options object.
>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../testing/selftests/bpf/prog_tests/bpf_nf.c |  6 +++++
>  .../testing/selftests/bpf/progs/test_bpf_nf.c | 26 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/test=
ing/selftests/bpf/prog_tests/bpf_nf.c
> index b33dba4b126e2..14d4c1793aed5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> @@ -5,6 +5,8 @@
>  #include "test_bpf_nf.skel.h"
>  #include "test_bpf_nf_fail.skel.h"
> =20
> +#define CT_OPTS_ERROR_GUARD 0x12345678
> +
>  static char log_buf[1024 * 1024];
> =20
>  struct {
> @@ -119,6 +121,10 @@ static void test_bpf_nf_ct(int mode)
>  	ASSERT_EQ(skel->bss->test_einval_reserved_new, -EINVAL, "Test EINVAL fo=
r reserved in new struct not set to 0");
>  	ASSERT_EQ(skel->bss->test_einval_netns_id, -EINVAL, "Test EINVAL for ne=
tns_id < -1");
>  	ASSERT_EQ(skel->bss->test_einval_len_opts, -EINVAL, "Test EINVAL for le=
n__opts !=3D NF_BPF_CT_OPTS_SZ");
> +	ASSERT_EQ(skel->bss->test_einval_len_opts_small_lookup, CT_OPTS_ERROR_G=
UARD,
> +		  "Test no error write for lookup opts__sz before error field");
> +	ASSERT_EQ(skel->bss->test_einval_len_opts_small_alloc, CT_OPTS_ERROR_GU=
ARD,
> +		  "Test no error write for alloc opts__sz before error field");
>  	ASSERT_EQ(skel->bss->test_eproto_l4proto, -EPROTO, "Test EPROTO for l4p=
roto !=3D TCP or UDP");
>  	ASSERT_EQ(skel->bss->test_enonet_netns_id, -ENONET, "Test ENONET for ba=
d but valid netns_id");
>  	ASSERT_EQ(skel->bss->test_enoent_lookup, -ENOENT, "Test ENOENT for fail=
ed lookup");
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/test=
ing/selftests/bpf/progs/test_bpf_nf.c
> index 076fbf03a1268..df43649ecb785 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -10,6 +10,8 @@
>  #define EINVAL 22
>  #define ENOENT 2
> =20
> +#define CT_OPTS_ERROR_GUARD 0x12345678
> +
>  #define NF_CT_ZONE_DIR_ORIG (1 << IP_CT_DIR_ORIGINAL)
>  #define NF_CT_ZONE_DIR_REPL (1 << IP_CT_DIR_REPLY)
> =20
> @@ -19,6 +21,8 @@ int test_einval_reserved =3D 0;
>  int test_einval_reserved_new =3D 0;
>  int test_einval_netns_id =3D 0;
>  int test_einval_len_opts =3D 0;
> +int test_einval_len_opts_small_lookup =3D 0;
> +int test_einval_len_opts_small_alloc =3D 0;
>  int test_eproto_l4proto =3D 0;
>  int test_enonet_netns_id =3D 0;
>  int test_enoent_lookup =3D 0;
> @@ -124,6 +128,28 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, stru=
ct bpf_sock_tuple *, u32,
>  	else
>  		test_einval_len_opts =3D opts_def.error;
> =20
> +	opts_def.error =3D CT_OPTS_ERROR_GUARD;
> +	ct =3D lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> +		       sizeof(opts_def.netns_id));
> +	if (ct) {
> +		bpf_ct_release(ct);
> +		test_einval_len_opts_small_lookup =3D -EINVAL;
> +	} else {
> +		test_einval_len_opts_small_lookup =3D opts_def.error;
> +	}
> +
> +	opts_def.error =3D CT_OPTS_ERROR_GUARD;
> +	ct =3D alloc_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> +		      sizeof(opts_def.netns_id));
> +	if (ct) {
> +		ct =3D bpf_ct_insert_entry(ct);
> +		if (ct)
> +			bpf_ct_release(ct);
> +		test_einval_len_opts_small_alloc =3D -EINVAL;
> +	} else {
> +		test_einval_len_opts_small_alloc =3D opts_def.error;
> +	}
> +
>  	opts_def.l4proto =3D IPPROTO_ICMP;
>  	ct =3D lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
>  		       sizeof(opts_def));


