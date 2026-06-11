Return-Path: <netdev+bounces-298346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HlFGNJccK2pe2wMAu9opvQ
	(envelope-from <netdev+bounces-298346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:37:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0E675376
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:37:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=VhO1C+xo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298346-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298346-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A92E83052627
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404A24A2E14;
	Thu, 11 Jun 2026 20:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA654963DF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210238; cv=none; b=HZiPzMVyoNhx02JKO15xMT6JIEgJtDpQsQQi3B1s7KOk0QnEahZVYVwuCQHRPcFQSm4j1Oi8W0OgL9WTEwNzQ7iftD/scBXtAI52r3bNVq+4DcpO2Av6zUtuYDcaSRbG+vPErFNeL9wcYZDfo3VbQocR/hfQKaJKiFDdc10kMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210238; c=relaxed/simple;
	bh=CJup5kn+//3c6lvhS7G15fADLqy2j/lGG5vzKHuwCek=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AnRyPByq5nmQpWTjxEabW6a1F9gP+ewqy9y83yvRNVtQD/R49EU30dXWGuorLpxiziSCVoa8JSTn9jbnOttOz/0BbuXRdtawoJTmr1oAOPeZgrLWS9KpmhuLiDcDzCfqeg0rWVhufeFNGmA7vtxGauiQ1SjgGLBLcaOTu3YN1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VhO1C+xo; arc=none smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13721dfd471so339197c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781210234; x=1781815034; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7mqNjhHyqtg/51iXjZww+ewEqqH7eyuOnewfNHYD/Q=;
        b=VhO1C+xoj+nNEVls7VJNrHzkh/zGw/aGdHr8WRV5eYtZ0W08R2nAcI87v4WxIHe14H
         RCouEXjRy1zb/CTX5Ly0C1qo5HYxKiu4DtYE7IDawaPjXwFG3i8kpVP1CdafALAjfSfi
         afkJkJayB+5WLQA5fNaZeeHGAu4NpmgdND/IBR+Ogn5TRH1iYKN5T1GS/jw99pqtY9vh
         Wig8wyVd4SkDGcQ7dumL8lTP5Fa9Osw/qADKEkditSvbABOLOUHpxpfop9MfRn/esoIh
         NZ4yxAH9Ddm0X7oggrC6HV1kJoWx4ZX+lZajE/asmT6eZHYcsXCg5Tgk2T2QJ+VQIHDH
         wS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210234; x=1781815034;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7mqNjhHyqtg/51iXjZww+ewEqqH7eyuOnewfNHYD/Q=;
        b=lF9JnV3PBArmHnjelUzlpuyx0HFJeSL8zqI72y+rvNxuv53qKaPmAmvy0hdsp1P5vq
         MLKtkZcjJmpQNOJ42sgIPF4VV/pqIx6DXjZFv/JJ2G3Izup1va2q1/Us0ZAw5un7LOOu
         Y2v7t2b2of2HNv7cEgYKA1kYAkAVWjAp3UcBe3aty1NofjzCxANmHZ3A2JKTWtBBqVcc
         8klgxGM6y6T8LttGJyvkom41HuatXpJqLP1DoH03lnMAe9P/oTwm+684wsJEF5R0hX9/
         ma7ZVibt1LBsHUxfzyo5WtYBewBHYSayW9To1sFKXTggWQgqghHeh5chYSo6A6hCuIrO
         IIYA==
X-Forwarded-Encrypted: i=1; AFNElJ8FLXji21OiHD6mjLfoL4o3vyx0SVqoVARBRhmTrQiKDhn4W7wuj5kG/Np4DxQNQYcHX5mFi2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2Ch7vGvbbvuL4eMhWHPi96jRvs+WJmaAncIOwfi1Z/uuJYBm
	tUjQjCy7vNiOcQO7WD2bk6U/g0LMQSlHr1zfZ/mOUIrNrJasfA5cmiDccmZW5HNkF6g=
X-Gm-Gg: Acq92OHC1xkM1X/78vFt7nEIVVsebQjvc7zUWBXGHiNSjBtSm7HJb0A4KHxTZAdFzlX
	fW83aUsdnz91Up/HG0mXjYl3ukD/6lTP90S9JIFfXNkyQFUrB6pkKvl3tZDHL7ic1VWHxqLJDQx
	ON3BpbzuSiw5q1kyUNRFr6Xb4WNPmHkfyfNDqPD+/2kagOHSYlh6ED/OGdo21Go5Cd2NlhOWr/k
	b2cNdBOow+y/FwmVuc360C44NNEQM7L3PaVfVUicuUl/uFZKa7Eto1hSZ7qyX+z1m+ZLboYTKNg
	SBLxc2Icm5qiwQEEKFBZQWCOvNJfbhHJKs7K6d0baTO5nGeaiKpTO7lIaS9a6Am3UxyySgdGU39
	dZxmBx6/ckFyciJhAEX9ol0JSSTNfABXpR0PI+Q+PvQzyLT7XPWDjstEmM+5j4/C13YXmmpir4A
	q6jHZcLIc/aRVKaLU=
X-Received: by 2002:a05:7022:f40e:b0:137:ea00:3f3a with SMTP id a92af1059eb24-13842151e39mr2739263c88.9.1781210234161;
        Thu, 11 Jun 2026 13:37:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3c95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384303a312sm3809521c88.12.2026.06.11.13.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 13:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 16:37:11 -0400
Message-Id: <DJ6IBVPSUNFM.3VJW6W39N5AKK@etsalapatis.com>
Cc: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>, "Shuah
 Khan" <shuah@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Cong Wang" <cong.wang@bytedance.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 7/7] selftests/bpf: add test for
 bpf_msg_pop_data() overflow
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-8-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-8-jiayuan.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298346-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	DMARC_NA(0.00)[etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,iogearbox.net,fomichev.me,linux.dev,kernel.org,etsalapatis.com,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADD0E675376

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Sechang Lim <rhkrqnwk98@gmail.com>
>
> Add a test in sockmap_basic.c that calls bpf_msg_pop_data() with a length
> close to U32_MAX, which overflows the start + len bounds check. The sk_ms=
g
> program records the return value over a sendmsg and the test checks that
> the call is rejected with -EINVAL.
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++++++++++++
>  .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_po=
p_data.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index d2846579285f2..cb3229711f93a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -14,6 +14,7 @@
>  #include "test_sockmap_pass_prog.skel.h"
>  #include "test_sockmap_drop_prog.skel.h"
>  #include "test_sockmap_change_tail.skel.h"
> +#include "test_sockmap_msg_pop_data.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
> =20
>  #include "sockmap_helpers.h"
> @@ -666,6 +667,51 @@ static void test_sockmap_skb_verdict_change_tail(voi=
d)
>  	test_sockmap_change_tail__destroy(skel);
>  }
> =20
> +static void test_sockmap_msg_verdict_pop_data(void)
> +{
> +	struct test_sockmap_msg_pop_data *skel;
> +	int err, map, verdict;
> +	int c1 =3D -1, p1 =3D -1, sent;
> +	int zero =3D 0;
> +	char *buf;
> +	const size_t len =3D 32 * 1024;
> +
> +	skel =3D test_sockmap_msg_pop_data__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	verdict =3D bpf_program__fd(skel->progs.prog_msg_pop_data);
> +	map =3D bpf_map__fd(skel->maps.sock_map);
> +
> +	err =3D bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach"))
> +		goto out;
> +
> +	err =3D create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
> +	if (!ASSERT_OK(err, "create_pair"))
> +		goto out;
> +
> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +		goto out_close;
> +
> +	buf =3D calloc(len, 1);
> +	if (!ASSERT_OK_PTR(buf, "calloc"))
> +		goto out_close;
> +
> +	sent =3D xsend(c1, buf, len, 0);
> +	ASSERT_EQ(sent, (ssize_t)len, "xsend");
> +	ASSERT_EQ(skel->data->pop_data_ret, -EINVAL, "pop_data_rejects overflow=
");
> +
> +	free(buf);
> +
> +out_close:
> +	close(c1);
> +	close(p1);
> +out:
> +	test_sockmap_msg_pop_data__destroy(skel);
> +}
> +
>  static void test_sockmap_skb_verdict_peek_helper(int map)
>  {
>  	int err, c1, p1, zero =3D 0, sent, recvd, avail;
> @@ -1373,6 +1419,8 @@ void test_sockmap_basic(void)
>  		test_sockmap_skb_verdict_fionread(false);
>  	if (test__start_subtest("sockmap skb_verdict change tail"))
>  		test_sockmap_skb_verdict_change_tail();
> +	if (test__start_subtest("sockmap msg_verdict pop_data overflow"))
> +		test_sockmap_msg_verdict_pop_data();
>  	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
>  		test_sockmap_skb_verdict_peek();
>  	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.=
c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
> new file mode 100644
> index 0000000000000..301e65b95256c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, int);
> +} sock_map SEC(".maps");
> +
> +#define POP_START 0x48a3
> +#define POP_LEN   0xfffffffd
> +
> +long pop_data_ret =3D 1;
> +
> +SEC("sk_msg")
> +int prog_msg_pop_data(struct sk_msg_md *msg)
> +{
> +	if (msg->size <=3D POP_START)
> +		return SK_PASS;
> +
> +	pop_data_ret =3D bpf_msg_pop_data(msg, POP_START, POP_LEN, 0);
> +	return SK_PASS;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";


