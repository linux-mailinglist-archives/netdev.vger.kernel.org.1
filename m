Return-Path: <netdev+bounces-253067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GBIDGejdGkH8QAAu9opvQ
	(envelope-from <netdev+bounces-253067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:48:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D77D4B6
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0A23009535
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D3AD24;
	Sat, 24 Jan 2026 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oe4i6iQF"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166E136672
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251684; cv=none; b=U5sQ3hBkUnr8JIx4+RLXxS2N4u7bvEnGn1h/OJsPv4nqDtyQrYXFyzdVLpdqYnu0+ulgtoDL0UuoARqM579nw3FH0+jKJ0JlXaWuzOVHRYOX5MBRo0ZbDYcZn/mCfedFpUjNu8Xop6xbYTFqyh5xoInVm+90/yo2zhoqmY1P8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251684; c=relaxed/simple;
	bh=47VAx5ZacdJ8aWPizoNgKSZ2gS6fvZEIp/N80TMPtLM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=lfCXnE3tia0nv8fe2w3dmgQ0RyiPlgJq2QTSdVjsxZJlq5DmA8BBAGKay3Q9geZyvKVyvOWiFiFZIsgQlp5GW7ozbRsn/g7Zm8eUjXP0Mt37nzpwdEw9THgskr1iPjzqZPAYMjPEl1DMFSJN89ah30Wy1bABGCmYmy1KZmKk7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oe4i6iQF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769251679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X157f6edi9qZZ/l+AyW1kCRowa/qQVlZyK7G3GoioL0=;
	b=oe4i6iQFz0xWIvjzlHY4GRoEJjM+4sH2hXTZlqQJUolKB//bI+M7qulvXc2ajJjha8jqJa
	BFiHUL2sIGNUH7lH2AlcI3HFAaTorof1dhO7nk92me3D3rCyqJ9ORvWW+UvVO5A1vcC0/e
	TiUbGSAEvFTUgcUghnwT8y0HwdoG314=
Date: Sat, 24 Jan 2026 10:47:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <56db5e4bb54678e0615501693a5eee0b88e2bf3e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v8 3/3] bpf, selftest: Add tests for FIONREAD
 and copied_seq
To: bpf@vger.kernel.org
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "David Ahern" <dsahern@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Stefano Garzarella" <sgarzare@redhat.com>, "Michal
 Luczaj" <mhal@rbox.co>, "Cong Wang" <cong.wang@bytedance.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <20260124061502.24350-4-jiayuan.chen@linux.dev>
References: <20260124061502.24350-1-jiayuan.chen@linux.dev>
 <20260124061502.24350-4-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253067-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 161D77D4B6
X-Rspamd-Action: no action

January 24, 2026 at 14:14, "Jiayuan Chen" <jiayuan.chen@linux.dev mailto:=
jiayuan.chen@linux.dev?to=3D%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linu=
x.dev%3E > wrote:


[...]
> +
> +/* it is used to send data to via native stack and BPF redirecting */
> +static void test_sockmap_multi_channels(int sotype)
> +{
> + int map, err, sent, recvd, zero =3D 0, one =3D 1, avail =3D 0;
> + struct test_sockmap_pass_prog *skel =3D NULL;
> + int c0 =3D -1, p0 =3D -1, c1 =3D -1, p1 =3D -1;
> + char buf[10] =3D "0123456789", rcv[11];
> + struct bpf_program *prog;
> +
> + skel =3D test_sockmap_pass_prog__open_and_load();
> + if (!ASSERT_OK_PTR(skel, "open_and_load"))
> + return;
> +
> + err =3D create_socket_pairs(AF_INET, sotype, &c0, &c1, &p0, &p1);
> + if (err)
> + goto end;
> +
> + prog =3D skel->progs.prog_skb_verdict_ingress;
> + map =3D bpf_map__fd(skel->maps.sock_map_rx);
> +
> + err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM=
_VERDICT, 0);
> + if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> + goto end;
> +
> + err =3D bpf_map_update_elem(map, &zero, &p0, BPF_ANY);
> + if (!ASSERT_OK(err, "bpf_map_update_elem(p0)"))
> + goto end;
> +
> + err =3D bpf_map_update_elem(map, &one, &p1, BPF_ANY);
> + if (!ASSERT_OK(err, "bpf_map_update_elem"))
> + goto end;
> +
> + /* send data to p1 via native stack */
> + sent =3D xsend(c1, buf, 2, 0);
> + if (!ASSERT_EQ(sent, 2, "xsend(2)"))
> + goto end;
> +
> + poll_read(p1, IO_TIMEOUT_SEC);
> + err =3D ioctl(p1, FIONREAD, &avail);
> + ASSERT_OK(err, "ioctl(FIONREAD) partial call");
> + ASSERT_EQ(avail, 2, "ioctl(FIONREAD) partial return");
> +
> + /* send data to p1 via bpf redirecting */
> + sent =3D xsend(c0, buf + 2, sizeof(buf) - 2, 0);
> + if (!ASSERT_EQ(sent, sizeof(buf) - 2, "xsend(remain-data)"))
> + goto end;
> +
> + poll_read(p1, IO_TIMEOUT_SEC);


It's a race in the test - poll_read() returns early because the first 2 b=
ytes are
already in the queue, but the second send hasn't been processed yet.
Will fix with a polling wait for FIONREAD.

pw-bot: cr

> + err =3D ioctl(p1, FIONREAD, &avail);
> + ASSERT_OK(err, "ioctl(FIONREAD) full call");
> + ASSERT_EQ(avail, sotype =3D=3D SOCK_DGRAM ? 2 : sizeof(buf), "ioctl(F=
IONREAD) full return");
> +
> + recvd =3D recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
> + if (!ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(p1)") ||
> + !ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch"))
> + goto end;
> +end:
> + if (c0 >=3D 0)
> + close(c0);
> + if (p0 >=3D 0)
> + close(p0);
> + if (c1 >=3D 0)
> + close(c1);
> + if (p1 >=3D 0)
> + close(p1);
> + test_sockmap_pass_prog__destroy(skel);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  if (test__start_subtest("sockmap create_update_free"))
> @@ -1108,4 +1363,14 @@ void test_sockmap_basic(void)
>  test_sockmap_skb_verdict_vsock_poll();
>  if (test__start_subtest("sockmap vsock unconnected"))
>  test_sockmap_vsock_unconnected();
> + if (test__start_subtest("sockmap with zc"))
> + test_sockmap_zc();
> + if (test__start_subtest("sockmap recover"))
> + test_sockmap_copied_seq(false);
> + if (test__start_subtest("sockmap recover with strp"))
> + test_sockmap_copied_seq(true);
> + if (test__start_subtest("sockmap tcp multi channels"))
> + test_sockmap_multi_channels(SOCK_STREAM);
> + if (test__start_subtest("sockmap udp multi channels"))
> + test_sockmap_multi_channels(SOCK_DGRAM);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c=
 b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
> index 69aacc96db36..ef9edca184ea 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
> @@ -44,4 +44,18 @@ int prog_skb_parser(struct __sk_buff *skb)
>  return SK_PASS;
>  }
>=20=20
>=20+SEC("sk_skb/stream_verdict")
> +int prog_skb_verdict_ingress(struct __sk_buff *skb)
> +{
> + int one =3D 1;
> +
> + return bpf_sk_redirect_map(skb, &sock_map_rx, one, BPF_F_INGRESS);
> +}
> +
> +SEC("sk_skb/stream_parser")
> +int prog_skb_verdict_ingress_strp(struct __sk_buff *skb)
> +{
> + return skb->len;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --=20
>=202.43.0
>

