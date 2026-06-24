Return-Path: <netdev+bounces-301561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ikYaEdWHO2o8ZQgAu9opvQ
	(envelope-from <netdev+bounces-301561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:31:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A44F96BC2DD
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:31:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=HM58Dxy8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301561-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301561-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E3F301BA7D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988429CB24;
	Wed, 24 Jun 2026 07:31:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FE1B78F3
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:31:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286289; cv=none; b=VGDDLz5AxQEqvLeJCAqjituq7kSfIEL9Ff3eKV3phg30kszfWJqX7WAhgViSwT/IxFt77c0prZg7dfvIGxwGCAQTYHTD7w4JErDrDKe5d/kTR3FW1+//0YBjzL/x0yRslMe5MJhdHnmAXnUFUayHeBBpaMUV993K3F1DEepKzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286289; c=relaxed/simple;
	bh=Zp0NmGUu3v2qQp+kbHyfOeFP8Tnp5EOY/oK5Sas0i4w=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=n2PfdmsSfDBHPKEBHfok/6sNfgs3fy4ekXzOQlz+VYXf6sfF4+VLi3fVZop5MH8nP2i4JUtuF6mINHs4pboUnKvXyyDE1E0wp53qSQZ5ATtMHSGtbaOjemrXiGOsQ4TEBZvfuehx1RD9dDzTTmNDMWMnGmlq6tx7NHYUNvNM0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HM58Dxy8; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8ce8f2e235so420025a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782286287; x=1782891087; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAJJH/ybZpPMvXsT28V1SA6Kd2qO7VgQ4QZr4Jxcy2Q=;
        b=HM58Dxy8Fm1ptL0+efcnmO+YEUUoFKTCcUxvIbNOQ3XQ5QdMr3jvQMIoFZCl6CF4Hc
         QabDUdENY4WFbkwYLY861Yk2a7F6Hj1TcUlidT444AnLEicjsVmlmjrHrBYBFTzPiI0H
         pMAo9GOAFplDgrNg8KwA3pTAKSwB/Ej4cBOwFWscMbH6QPuwvvGqjxxklrPfIme4GjEs
         IEB4+T98NG1cQmm50803zx6gAS8q7w5fl3GJlVYQRTsqjtbD+OklKA1llrYzA+5cL9aN
         Dj71cuXOrv7kfpmo+V3h1kXD/544QvfemMlTW73aLuhjVvdapw7wyVOsX33bgg5aIRzP
         87GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286287; x=1782891087;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAJJH/ybZpPMvXsT28V1SA6Kd2qO7VgQ4QZr4Jxcy2Q=;
        b=dNhltq6awRvOvNPgbbe1DzHEUugNpInERO8nd4dupxG526LuvXHPoBcQOnJIou6VpV
         J5Bj88RYwmhQn6mRE+kJNN2jfsM1TpWbL6hyeBaR/7x7s7ajBnQXZP+fwArs6WKgivif
         Btrj9AseAX4AJ9IUUS3Yk9WUEQXpwnes7324R2zzKC3qNJTxGnYrpdsR9zQ1O8Jkk4yy
         JE9tWxapGAEBlI2HS7nOv2LeHabhSe+9bBb86gVobSy0L9m4Pkmn4C+cxaZPu4Hd0HUj
         EZMmHapQv4eh4Pc5Z66FsTamfRiOSfEtF7X+NJmsRHzTPMyT/pDnkgWkgJ/UwQ68pYwB
         jSqw==
X-Forwarded-Encrypted: i=1; AFNElJ+tgGeTkDWnxnYmV9z022Ve9dtUrqoxbe5xip3cgfjHkdmRUfLN9VrETFKj+SUHyfcJ6U6/30M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGa51J5gHJj3UciDdaZxjMM6w2w8vVeDMXTjII3HpQlg/AKe6
	f89TihsxodxSFAmfJbGY/h2xuQXRdTUvnuxyqQ5Ttj+IVIXKK6G5+Q4xQz3hwAGpey4=
X-Gm-Gg: AfdE7cmY6NnP5jfFs3s6/Hc4dma1pToUUnoNITtAR7eY0uHoZDVGX3TQSk++WTDnwNb
	z09VIHPph6+HqiQ5O7GvhiJ/MiMPEXY5rJWsPXvP1SkhS1DGcmC6QzeJWrLI/N1s0ahyqA+lWBL
	3Uq93fCZQkhFaj4OombogZQmBVqbEZosHUa0aTuAXl88MmkXQrYicA9AZmC2X3TcHYAjnuCtnmd
	HbKZQm0n9lEP/AVpFk/JZ26+PgzOjiG9T4+LEOTTbE76GcYFTwlBr4C2QjaF/AQqXTBHgZSA/Ns
	QB5T49KOgEXkQjRnPIfrK91BI9ohkBLoClijGcaUpNbjQtuOYx3TeGA3A1h+GQxx2pNiS2SPt+4
	zVixt9ldcXBLhOw5K/KXXVnV/+MkDRTt6U9vZX1xR/955dZGVMGFOsJdpFXXRm6zGDw0G43ubT2
	8YUBP5gBrtX3gySQ==
X-Received: by 2002:a05:6a21:3399:b0:3bb:2200:f680 with SMTP id adf61e73a8af0-3bd2d21fac8mr2742500637.25.1782286286990;
        Wed, 24 Jun 2026 00:31:26 -0700 (PDT)
Received: from localhost ([2605:8d80:5c40:7b14:89ba:fd93:9852:c9eb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc2c8d8a9sm12022117a12.5.2026.06.24.00.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 03:31:25 -0400
Message-Id: <DJH3RC5R8W8E.2T8JRUAQDPT23@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <jordan@jrife.io>,
 <kuba@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 7/7] selftests/bpf: add bpf_icmp_send
 recursion test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-8-mahe.tardy@gmail.com>
In-Reply-To: <20260622120515.137082-8-mahe.tardy@gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301561-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A44F96BC2DD

On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> This test is similar to test_icmp_send_unreach_cgroup but checks that,
> in case of recursion, meaning that the BPF program calling the kfunc was
> re-triggered by the icmp_send done by the kfunc, the kfunc will stop
> early and return -EBUSY.
>
> The test attaches to the root cgroup to ensure the ICMP packet generated
> by the kfunc re-triggers the BPF program. Since it's attached only for
> this recursion test, it should not disrupt the whole network.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 45 +++++++++++++++
>  tools/testing/selftests/bpf/progs/icmp_send.c | 56 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index 66447681f72d..fd4b8fa78a01 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  #include <network_helpers.h>
> +#include <cgroup_helpers.h>
>  #include <linux/errqueue.h>
>  #include <poll.h>
> +#include <unistd.h>
>  #include "icmp_send.skel.h"
>
>  #define TIMEOUT_MS 1000
> @@ -10,6 +12,7 @@
>  #define ICMP_DEST_UNREACH 3
>  #define ICMPV6_DEST_UNREACH 1
>
> +#define ICMP_HOST_UNREACH 1
>  #define ICMP_FRAG_NEEDED 4
>  #define NR_ICMP_UNREACH 15
>  #define ICMPV6_REJECT_ROUTE 6
> @@ -203,3 +206,45 @@ void test_icmp_send_unreach_tc(void)
>  	bpf_link__destroy(link);
>  	icmp_send__destroy(skel);
>  }
> +
> +void test_icmp_send_unreach_recursion(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd =3D -1;
> +
> +	skel =3D icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	if (setup_cgroup_environment()) {
> +		fprintf(stderr, "Failed to setup cgroup environment\n");
> +		goto cleanup;
> +	}
> +
> +	cgroup_fd =3D get_root_cgroup();
> +	if (!ASSERT_OK_FD(cgroup_fd, "get_root_cgroup"))
> +		goto cleanup;
> +
> +	skel->data->target_pid =3D getpid();
> +	skel->links.recursion =3D
> +		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
> +					"127.0.0.1");
> +
> +	/*
> +	 * Because there's recursion involved, the first call will return at
> +	 * index 1 since it will return the second, and the second call will
> +	 * return at index 0 since it will return the first.
> +	 */
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
> +
> +cleanup:
> +	cleanup_cgroup_environment();
> +	icmp_send__destroy(skel);
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testin=
g/selftests/bpf/progs/icmp_send.c
> index 5fa5467bdb70..fd9c7684797b 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> @@ -13,6 +13,10 @@ __u16 server_port =3D 0;
>  int unreach_type =3D 0;
>  int unreach_code =3D 0;
>  int kfunc_ret =3D -1;
> +int target_pid =3D -1;
> +
> +unsigned int rec_count =3D 0;
> +int rec_kfunc_rets[] =3D { -1, -1 };
>
>  SEC("cgroup_skb/egress")
>  int egress(struct __sk_buff *skb)
> @@ -125,4 +129,56 @@ int tc_egress(struct __sk_buff *skb)
>  	return TCX_DROP;
>  }
>
> +SEC("cgroup_skb/egress")
> +int recursion(struct __sk_buff *skb)
> +{
> +	void *data =3D (void *)(long)skb->data;
> +	void *data_end =3D (void *)(long)skb->data_end;
> +	struct icmphdr *icmph;
> +	struct tcphdr *tcph;
> +	struct iphdr *iph;
> +	int ret;
> +
> +	if ((bpf_get_current_pid_tgid() >> 32) !=3D target_pid)
> +		return SK_PASS;
> +
> +	iph =3D data;
> +	if ((void *)(iph + 1) > data_end || iph->version !=3D 4)
> +		return SK_PASS;
> +
> +	if (iph->daddr !=3D bpf_htonl(SERVER_IP))
> +		return SK_PASS;
> +
> +	if (iph->protocol =3D=3D IPPROTO_TCP) {
> +		tcph =3D (void *)iph + iph->ihl * 4;
> +		if ((void *)(tcph + 1) > data_end ||
> +		    tcph->dest !=3D bpf_htons(server_port))
> +			return SK_PASS;
> +	} else if (iph->protocol =3D=3D IPPROTO_ICMP) {
> +		icmph =3D (void *)iph + iph->ihl * 4;
> +		if ((void *)(icmph + 1) > data_end ||
> +		    icmph->type !=3D unreach_type ||
> +		    icmph->code !=3D unreach_code)
> +			return SK_PASS;
> +	} else {
> +		return SK_PASS;
> +	}
> +
> +	/*
> +	 * This call will provoke a recursion: the ICMP packet generated by the
> +	 * kfunc will re-trigger this program since we are in the root cgroup i=
n
> +	 * which the kernel ICMP socket belongs. However when re-entering the
> +	 * kfunc, it should return EBUSY.
> +	 */
> +	ret =3D bpf_icmp_send(skb, unreach_type, unreach_code);
> +	rec_kfunc_rets[rec_count & 1] =3D ret;
> +	__sync_fetch_and_add(&rec_count, 1);
> +
> +	/* Let the first ICMP error message pass */
> +	if (iph->protocol =3D=3D IPPROTO_ICMP)
> +		return SK_PASS;
> +
> +	return SK_DROP;
> +}
> +
>  char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> --
> 2.34.1


