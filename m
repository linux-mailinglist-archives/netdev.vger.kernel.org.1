Return-Path: <netdev+bounces-305641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wNc0LxLVTWpG+wEAu9opvQ
	(envelope-from <netdev+bounces-305641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:41:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEF7219F4
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j8jv2xkK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305641-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305641-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B5A030095C1
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 04:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241938423D;
	Wed,  8 Jul 2026 04:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22A3002B3
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 04:41:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485709; cv=none; b=UgJZsgL+zo5z7rlzVyBNEKMic8v5RwiWRjkX6AQ2k521ax7h4htYLVTKkO7BX7rEHTA9A4GfCxFab2Gqqif/+YzJVlwASrSs6WG/wcD085DgwSrhZrZywpELqECdBi5Tpu+31FmuHZ0sWWhX1hAYrfSrcY4Qd82Gg5N+8xxCvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485709; c=relaxed/simple;
	bh=dFWF4mbM7fec3CKjtLHwa3ijZn4lRngduD1c5Ag3pIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KDfeHHpF/5sMLD6nnYtsg6mAuBRqiGGlc14Nk2gvXclfKialO8JnuyITkt1Z2+X8iouQ5EftEjlFy9fGb4f27a52w7fr8gb4YGdutdv+C0rXeJvpFAu9jwaM/fciIXVX2HhQmZMBuB1+pF/KlfHHAySfVoHbaliqfOc+IsM7kO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8jv2xkK; arc=none smtp.client-ip=74.125.225.64
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so82831f8f.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 21:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783485705; x=1784090505; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ieK6Nyjgx80dc31yGSF9T1zWne7nTxPTT4G9KM0zXSM=;
        b=j8jv2xkKJRLwwjJuh8evMPjITmI838I7rrdvfHg6m6fVSv1iBozM4gSGTfKwZH1+Qh
         Dvs2buYxhYkYxXrZsKfB2SCOalp2M0GEBumbErINPW0Xy9AX6W3MN3Mno2v75sQdzGfD
         by/b/Kuu6Hf30aRmpCAZNVyk/ufcxh5g2gt24zCipwx3OahJVoyGg+/JES714R7z4K/b
         cE3jtHgPmi3jV2hFrzBH160K8cxrIui/Prjy6cylay9HiY1efg2qgKd5/sRcjTIeRUI/
         CK8EK0pQurvphQ0GxEMG5BQ3nZcKLpAvcHQiSYmIWum6kYlmkL8GXxyeJ+hjoHZEWkmH
         ajzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783485705; x=1784090505;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieK6Nyjgx80dc31yGSF9T1zWne7nTxPTT4G9KM0zXSM=;
        b=n5yQ55c9QgaLKltlY/Gk4Hgsaufu89oX0EIAke8sOsbkLW3TDHA+l0xIT/SuUfmtW9
         Dg2meFpVcLYSi76BNj1h6AE1oN4ojsL0e1YoQ9tZCwd4GuzTyHKRJPg8oRvVMJqudo4Q
         r1EwRoqfwIwzxTFtbmvKz0UvlbSNTm3TUTJ/abf1PxkTWEktAYMggFRVN3dSqnDAMtYE
         G8IA11YdQG8kEe940WJv0IoGW9FwPNm653f+rtzTTRm8nH3WMuPByJWuE6FPVVOzoljl
         tRfSN0NIlg2LCUa3tCoY+Vt4Kf0raMNmmSLzIe5Cc+UeGgzBypt1Tjh7Mk2v5rtFf9tm
         8a8Q==
X-Gm-Message-State: AOJu0YwH/H/So4CccPNV95DOJGTeTh0yJ6kA9/fqo4YAzoAq156XW9Lo
	U+PgSMhE4YEE/ku9/tVm+nPZDmMla+6SasYRFVPkZVQgGMCp7clx9KUz
X-Gm-Gg: AfdE7ckB6RyerKil3xMMlOJarwtwuirmhoiW87zUah58GuXjXjpOYlGDa5msUAvQaIR
	uQgUzccxV2kImWh1XJE+i+jCnETM3swRd9jv1VEPjOjHQBNwtQFGav8Uw/OSrhNSBA1Ox6R6b3E
	QnjIa3Yo7XsxhPSWicCvBJgAbdn1e0BWEVhQsfHP3yvz3JdK6PgYCct4u7QWhL9TzTbag7Nxgx3
	GyJvba8qHair/dRfmXphxKjEZnSAVZApG2Z3INjl5T/yQfWnzbhf0sHnZFE6AZ70c4DDV2eECZn
	UYkMm+pqhLEBNOt94RdwPiP78QR9b6TBTXFjXnB+P2fEehK9CaMDA0XheBb4nQu9z1CTkt9l0nz
	T3gk35Qt1KOwWzB2ATokyE9O1Pq2B5D4nA+ozbUZwQNUQ+++ualOUQeg5je4P14D0St8x4xLvC6
	hDQevxbou8fG/N6ZjdOEfqI8p/Rmx/JVMXVjncb/jW5Y4PvFSG6BjbE2v/7ss92bgpyyOK0cmw+
	q09pGy+t3dZfM0pMxKooQnwScJx/nhRWgYiFo4yOZenI5E1rhiC4Q4=
X-Received: by 2002:a05:6000:2484:b0:478:1564:f756 with SMTP id ffacd0b85a97d-47df0735a3dmr536168f8f.27.1783485705373;
        Tue, 07 Jul 2026 21:41:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm39108953f8f.27.2026.07.07.21.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 06:41:44 +0200
Message-Id: <DJSWX1VY6XXI.1XRGI8HMHT6JT@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>,
 <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
 <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>
In-Reply-To: <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305641-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:emil@etsalapatis.com,m:mattia.meleleo@coralogix.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[etsalapatis.com,coralogix.com,gmail.com,cloudflare.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2AEF7219F4

On Tue Jul 7, 2026 at 7:19 PM CEST, Emil Tsalapatis wrote:
> On Tue Jul 7, 2026 at 12:15 PM EDT, Mattia Meleleo via B4 Relay wrote:
>> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>>
>> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
>> counts bytes in ingress_msg. Without a stream/skb verdict program
>> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
>> returns 0 even though read() returns data.
>>
>> Add tcp_inq() to the reported value when the psock has no verdict
>> program. The two queues are disjoint, so bytes redirected into
>> ingress_msg from other sockets stay correctly accounted through
>> msg_tot_len.
>>
>> Add a selftest covering FIONREAD without a verdict program.
>>
>> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
>> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> I don't think the Sashiko READ_ONCE() recommendation is that important,
> we're just checking for the pointers' existence and I don't see how the
> reads can be moved/optimized out/merged in a way that breaks this code.
>

It would be necessary if the xchg() can happen even when the lock is held, =
at
the very least, to suppress potential KCSAN warnings, I think. Even for the
theoretical load tearing that causes false positive, it would be benign due=
 to
wrong accounting.

>> ---
>>  net/ipv4/tcp_bpf.c                                 | 16 ++++++++-
>>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 +++++++++++++++=
+++++++
>>  2 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index cc0bd73f3..a001b1fff 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>>
>>  static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>>  {
>> +	struct sk_psock *psock;
>>  	bool slow;
>>
>>  	if (cmd !=3D SIOCINQ)
>> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, =
int *karg)
>>  		return -EINVAL;
>>
>>  	slow =3D lock_sock_fast(sk);
>> -	*karg =3D sk_psock_msg_inq(sk);
>> +	psock =3D sk_psock_get(sk);
>> +	if (unlikely(!psock)) {
>> +		unlock_sock_fast(sk, slow);
>> +		return tcp_ioctl(sk, cmd, karg);
>> +	}
>> +	*karg =3D sk_psock_get_msg_len_nolock(psock);
>> +	/* Without a verdict program, ingress data is never diverted to
>> +	 * ingress_msg: it stays in sk_receive_queue and is read through
>> +	 * the fallback to tcp_recvmsg(), so account for it like
>> +	 * tcp_ioctl() does.
>> +	 */
>> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)
>> +		*karg +=3D tcp_inq(sk);
>> +	sk_psock_put(sk, psock);
>>  	unlock_sock_fast(sk, slow);
>>
>>  	return 0;
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> index cb3229711..f0f368201 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotyp=
e)
>>  	test_sockmap_pass_prog__destroy(skel);
>>  }
>>
>> +/* A socket in a sockmap without a verdict program keeps its ingress da=
ta
>> + * in sk_receive_queue: FIONREAD must account for it.
>> + */
>> +static void test_sockmap_no_verdict_fionread(void)
>> +{
>> +	int err, map, zero =3D 0, sent, avail;
>> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
>> +	struct test_sockmap_pass_prog *skel;
>> +	char buf[256] =3D "0123456789";
>> +
>> +	skel =3D test_sockmap_pass_prog__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +		return;
>> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
>> +
>> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
>> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
>> +		goto out;
>> +
>> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
>> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
>> +		goto out_close;
>> +
>> +	sent =3D xsend(p1, &buf, sizeof(buf), 0);
>> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
>> +	avail =3D wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
>> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
>> +
>> +out_close:
>> +	close(c0);
>> +	close(p0);
>> +	close(c1);
>> +	close(p1);
>> +out:
>> +	test_sockmap_pass_prog__destroy(skel);
>> +}
>> +
>>  void test_sockmap_basic(void)
>>  {
>>  	if (test__start_subtest("sockmap create_update_free"))
>> @@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
>>  		test_sockmap_skb_verdict_shutdown();
>>  	if (test__start_subtest("sockmap skb_verdict fionread"))
>>  		test_sockmap_skb_verdict_fionread(true);
>> +	if (test__start_subtest("sockmap no_verdict fionread"))
>> +		test_sockmap_no_verdict_fionread();
>>  	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>>  		test_sockmap_skb_verdict_fionread(false);
>>  	if (test__start_subtest("sockmap skb_verdict change tail"))
>>
>> ---
>> base-commit: d2c9a99135da931377240942d44f3dea104cedb8
>> change-id: 20260707-fionread-no-verdict-a4f8697ac9f9
>>
>> Best regards,
>> --
>> Mattia Meleleo <mattia.meleleo@coralogix.com>


