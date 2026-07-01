Return-Path: <netdev+bounces-303867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BrJPHg2PRWqGCAsAu9opvQ
	(envelope-from <netdev+bounces-303867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:05:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5AE6F2022
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:05:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b="r/r7+50P";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303867-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303867-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF95D300D925
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8365D3C4B84;
	Wed,  1 Jul 2026 22:04:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FB3AB5AC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:04:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943497; cv=none; b=hgYo79Zndc2VT1dctNimv8J0pDfRGldQgHBmwv0NDdwq515FxAU4oJ8PkmTTRcbywK5PWndraDSN+QOR9Dr915h+Kyb9UCAksVmigH1MmjGULa/0cNjSjJWWAK986iSpJLX29+cksegtI+ZgqVvOxjmD0mlgZGyddgYwZk8W05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943497; c=relaxed/simple;
	bh=kqApQUefcoxMOyFgYsfScJmRhcYAnJyGHDiCFGYPj5s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TsvVaU4+6bwK00EVt5LuVUjkhjrto+rD08m3GB7LPteCoamJBzZSR0PkgS1tuu5l36y6arGo3XCDZ8Acgl9qB1TyKYMffVUeqt+ehmmBTX4oyaCef92t3s6vb8omgtJCHmFqCM4L1301++KJzg+OVPAeoOC1AdZx0N/X60KgIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=r/r7+50P; arc=none smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c05dcdf49so10292071cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782943495; x=1783548295; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz+w72WqMjFFoJkIcS+YO7klDKbo3zQaz3oeNDKSsls=;
        b=r/r7+50PQgX5+Dlmq+3Zj7SmqzTZzQxSCW5uGtqXgDG/DGShs8qwLrpK7h5LS1SJDv
         xzt1/mNbpP15354f3Y8OZkajBVps6sbiY8cLp68DghFpGZLMOhbeLGP7OpK+EvYS0iwO
         /v6mzqasi4EEIXNvfDDw4ofcErAoS0WKqGtOCx5kCKvd3p8wuEJFmMwG/aZsJqs2ZDDS
         HJjm3yzuhZDwxUx5TsuWvj3D3mThv5kzOR0XyhcFThlFCKMWLmpqmcES5DPREHWcZeKY
         yDE+/HI7hVdHfxI6sqnRoKcB/8AoLUDZ8AkkWmQMMdR82+56lofanvj/62x3znbiC0/S
         dJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943495; x=1783548295;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cz+w72WqMjFFoJkIcS+YO7klDKbo3zQaz3oeNDKSsls=;
        b=nY0JCCzCQXilsBza8Kp638V2ML8MMOEr2z6ZN9qb8T/xkD27bh8hqYh9+Jzb0rBlTK
         sh6IhthWhQO93iIUscYDt2skhv/O/wc6iuO08rp26NlTnrz21x3pZbjVY3Jm9OtwtXIX
         5CFAoinLg2Lqdjs44cyv9685dqxwY215TOEmOyYGyFv2w/xSOh9UVYCBipXdmcFmk6yD
         mcSQG3ysbAN16L1N7Wy50jKnXz6ySIO9M4D5UzcTirES3RjdJZ08a2xrS1KKTiWG/bCU
         gSurpC8nxDPKtC88ULk19jX2YlHZWVm59ohRCPjxU6BjZUem47C0Y6L1NIyXmxlPgwgy
         uavA==
X-Forwarded-Encrypted: i=1; AFNElJ/t7DFq/BaQrE0lOVhcU6cHFwZjf+O1/GqKlVu4hyzelOnD2GvcVUKV2zFFGNnvyyfRpsLBbU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8joF2OIQ0nROJjc1d+mQaUHtnfBxjIt7F7Hif03rLABHqyCM1
	pXJXI6x0H6I9ysJjVu7NsysPP/CC2+a8nLWcNVGYDqS/EJzj+Cdq5dP+3nRytG6CbsI=
X-Gm-Gg: AfdE7cnbnQF8PnK+T3dxDOx/iiObhKXIT2Z0L+uD2gT0xpVNEDsxJ3v8QJywwNOPI4G
	i/6lNc9uPusqC7TGLguyKLc3dmtDS+fQcWk6G3l8fZND+5bgHUNjJMCAecUw0ulGQcNVvGIeNQz
	TmAEV2UT5VhdpSKvh9+T97BCQysgW//yhtAtUCQP2Q20AZC9akdNz25DgoFpplzyxW/eT0DQFkz
	zR+ZIt57tx1psGcqtc1rtIVK42kPFf+EeL392dzkQksndO/6wpC3mRPZlXvdHjrvi7voCZFjJlW
	ggrQFhza8PNODRSXZoLxu7QLekpep3AjYwBdza/yIZrC71dVdiyoTIp87KeIOLPGfWztmkd8wwB
	XtdyRNEUmnhjluRMqgohNOCgF+TofJozKxDH5i3Q08W/cljWDEqZj16shZH59Ac4Ye8Z/cQb/mf
	gTp4tN/+jIfms=
X-Received: by 2002:a05:622a:4d8d:b0:51a:8bc9:2915 with SMTP id d75a77b69052e-51c26a3b27fmr48081291cf.8.1782943494690;
        Wed, 01 Jul 2026 15:04:54 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30b12a1bsm1973011cf.7.2026.07.01.15.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 15:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 18:04:52 -0400
Message-Id: <DJNKPX7M6V2M.3VHAH7G1VML8B@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: drop
 tc/xdp/flow_dissector/socket_filter sockmap mutation tests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Varun R
 Mallya" <varunrmallya@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
In-Reply-To: <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,etsalapatis.com,fomichev.me,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC5AE6F2022

On Tue Jun 30, 2026 at 10:54 AM EDT, Sechang Lim wrote:
> tc, xdp, socket_filter and flow_dissector programs can no longer update
> or delete a sockmap. Adjust the tests:
>
>  - verifier_sockmap_mutate: the tc, xdp, socket_filter and
>    flow_dissector cases now expect __failure with "cannot update sockmap
>    in this context".
>  - sockmap_basic: drop "sockmap update" / "sockhash update", which load
>    a SEC("tc") program that copies a sock between maps.
>  - fexit_bpf2bpf: drop "func_sockmap_update", whose freplace program
>    updates a sockmap in the tc cls_redirect context.
>
> Remove the now-unused test_sockmap_update.c and freplace_cls_redirect.c.
>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
>  .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
>  .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
>  .../bpf/progs/verifier_sockmap_mutate.c       | 12 ++---
>  5 files changed, 6 insertions(+), 153 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redire=
ct.c
>  delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index 92c20803ea76..d3a954158c33 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> @@ -336,17 +336,6 @@ static void test_fmod_ret_freplace(void)
>  }
> =20
> =20
> -static void test_func_sockmap_update(void)
> -{
> -	const char *prog_name[] =3D {
> -		"freplace/cls_redirect",
> -	};
> -	test_fexit_bpf2bpf_common("./freplace_cls_redirect.bpf.o",
> -				  "./test_cls_redirect.bpf.o",
> -				  ARRAY_SIZE(prog_name),
> -				  prog_name, false, NULL);
> -}
> -
>  static void test_func_replace_void(void)
>  {
>  	const char *prog_name[] =3D {
> @@ -599,8 +588,6 @@ void serial_test_fexit_bpf2bpf(void)
>  		test_func_replace();
>  	if (test__start_subtest("func_replace_verify"))
>  		test_func_replace_verify();
> -	if (test__start_subtest("func_sockmap_update"))
> -		test_func_sockmap_update();
>  	if (test__start_subtest("func_replace_return_code"))
>  		test_func_replace_return_code();
>  	if (test__start_subtest("func_map_prog_compatibility"))
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711f93..33f788e2786d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -7,7 +7,6 @@
> =20
>  #include "test_progs.h"
>  #include "test_skmsg_load_helpers.skel.h"
> -#include "test_sockmap_update.skel.h"
>  #include "test_sockmap_invalid_update.skel.h"
>  #include "test_sockmap_skb_verdict_attach.skel.h"
>  #include "test_sockmap_progs_query.skel.h"
> @@ -235,53 +234,6 @@ static void test_skmsg_helpers_with_link(enum bpf_ma=
p_type map_type)
>  	test_skmsg_load_helpers__destroy(skel);
>  }
> =20
> -static void test_sockmap_update(enum bpf_map_type map_type)
> -{
> -	int err, prog, src;
> -	struct test_sockmap_update *skel;
> -	struct bpf_map *dst_map;
> -	const __u32 zero =3D 0;
> -	char dummy[14] =3D {0};
> -	LIBBPF_OPTS(bpf_test_run_opts, topts,
> -		.data_in =3D dummy,
> -		.data_size_in =3D sizeof(dummy),
> -		.repeat =3D 1,
> -	);
> -	__s64 sk;
> -
> -	sk =3D connected_socket_v4();
> -	if (!ASSERT_NEQ(sk, -1, "connected_socket_v4"))
> -		return;
> -
> -	skel =3D test_sockmap_update__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> -		goto close_sk;
> -
> -	prog =3D bpf_program__fd(skel->progs.copy_sock_map);
> -	src =3D bpf_map__fd(skel->maps.src);
> -	if (map_type =3D=3D BPF_MAP_TYPE_SOCKMAP)
> -		dst_map =3D skel->maps.dst_sock_map;
> -	else
> -		dst_map =3D skel->maps.dst_sock_hash;
> -
> -	err =3D bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
> -	if (!ASSERT_OK(err, "update_elem(src)"))
> -		goto out;
> -
> -	err =3D bpf_prog_test_run_opts(prog, &topts);
> -	if (!ASSERT_OK(err, "test_run"))
> -		goto out;
> -	if (!ASSERT_NEQ(topts.retval, 0, "test_run retval"))
> -		goto out;
> -
> -	compare_cookies(skel->maps.src, dst_map);
> -
> -out:
> -	test_sockmap_update__destroy(skel);
> -close_sk:
> -	close(sk);
> -}
> -
>  static void test_sockmap_invalid_update(void)
>  {
>  	struct test_sockmap_invalid_update *skel;
> @@ -1385,10 +1337,6 @@ void test_sockmap_basic(void)
>  		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
>  	if (test__start_subtest("sockhash sk_msg load helpers"))
>  		test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
> -	if (test__start_subtest("sockmap update"))
> -		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP);
> -	if (test__start_subtest("sockhash update"))
> -		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
>  	if (test__start_subtest("sockmap update in unsafe context"))
>  		test_sockmap_invalid_update();
>  	if (test__start_subtest("sockmap copy"))
> diff --git a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c b/=
tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
> deleted file mode 100644
> index 7e94412d47a5..000000000000
> --- a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2020 Facebook
> -
> -#include <linux/stddef.h>
> -#include <linux/bpf.h>
> -#include <linux/pkt_cls.h>
> -#include <bpf/bpf_endian.h>
> -#include <bpf/bpf_helpers.h>
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> -	__type(key, int);
> -	__type(value, int);
> -	__uint(max_entries, 2);
> -} sock_map SEC(".maps");
> -
> -SEC("freplace/cls_redirect")
> -int freplace_cls_redirect_test(struct __sk_buff *skb)
> -{
> -	int ret =3D 0;
> -	const int zero =3D 0;
> -	struct bpf_sock *sk;
> -
> -	sk =3D bpf_map_lookup_elem(&sock_map, &zero);
> -	if (!sk)
> -		return TC_ACT_SHOT;
> -
> -	ret =3D bpf_map_update_elem(&sock_map, &zero, sk, 0);
> -	bpf_sk_release(sk);
> -
> -	return ret =3D=3D 0 ? TC_ACT_OK : TC_ACT_SHOT;
> -}
> -
> -char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/to=
ols/testing/selftests/bpf/progs/test_sockmap_update.c
> deleted file mode 100644
> index 6d64ea536e3d..000000000000
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2020 Cloudflare
> -#include "vmlinux.h"
> -#include <bpf/bpf_helpers.h>
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> -	__uint(max_entries, 1);
> -	__type(key, __u32);
> -	__type(value, __u64);
> -} src SEC(".maps");
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> -	__uint(max_entries, 1);
> -	__type(key, __u32);
> -	__type(value, __u64);
> -} dst_sock_map SEC(".maps");
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKHASH);
> -	__uint(max_entries, 1);
> -	__type(key, __u32);
> -	__type(value, __u64);
> -} dst_sock_hash SEC(".maps");
> -
> -SEC("tc")
> -int copy_sock_map(void *ctx)
> -{
> -	struct bpf_sock *sk;
> -	bool failed =3D false;
> -	__u32 key =3D 0;
> -
> -	sk =3D bpf_map_lookup_elem(&src, &key);
> -	if (!sk)
> -		return SK_DROP;
> -
> -	if (bpf_map_update_elem(&dst_sock_map, &key, sk, 0))
> -		failed =3D true;
> -
> -	if (bpf_map_update_elem(&dst_sock_hash, &key, sk, 0))
> -		failed =3D true;
> -
> -	bpf_sk_release(sk);
> -	return failed ? SK_DROP : SK_PASS;
> -}
> -
> -char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c =
b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> index fe4b123187b8..20332a731d4e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> @@ -74,7 +74,7 @@ static __always_inline void test_sockmap_lookup_and_mut=
ate(void)
>  }
> =20
>  SEC("action")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_sched_act(struct __sk_buff *skb)
>  {
>  	test_sockmap_mutate(skb->sk);
> @@ -82,7 +82,7 @@ int test_sched_act(struct __sk_buff *skb)
>  }
> =20
>  SEC("classifier")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_sched_cls(struct __sk_buff *skb)
>  {
>  	test_sockmap_mutate(skb->sk);
> @@ -90,7 +90,7 @@ int test_sched_cls(struct __sk_buff *skb)
>  }
> =20
>  SEC("flow_dissector")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_flow_dissector_delete(struct __sk_buff *skb __always_unused)
>  {
>  	test_sockmap_delete();
> @@ -98,7 +98,7 @@ int test_flow_dissector_delete(struct __sk_buff *skb __=
always_unused)
>  }
> =20
>  SEC("flow_dissector")
> -__failure __msg("program of this type cannot use helper bpf_sk_release")
> +__failure __msg("cannot update sockmap in this context")
>  int test_flow_dissector_update(struct __sk_buff *skb __always_unused)
>  {
>  	test_sockmap_lookup_and_update(); /* no access to skb->sk */
> @@ -146,7 +146,7 @@ int test_sk_reuseport(struct sk_reuseport_md *ctx)
>  }
> =20
>  SEC("socket")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_socket_filter(struct __sk_buff *skb)
>  {
>  	test_sockmap_mutate(skb->sk);
> @@ -179,7 +179,7 @@ int test_sockops_update_dedicated(struct bpf_sock_ops=
 *ctx)
>  }
> =20
>  SEC("xdp")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_xdp(struct xdp_md *ctx __always_unused)
>  {
>  	test_sockmap_lookup_and_mutate();


