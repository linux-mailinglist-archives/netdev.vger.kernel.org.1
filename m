Return-Path: <netdev+bounces-301560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PnlPItKGO2oGZQgAu9opvQ
	(envelope-from <netdev+bounces-301560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 409636BC27E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:27:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=avn9lc4X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301560-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96A843023067
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92283921E9;
	Wed, 24 Jun 2026 07:27:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBB3812FB
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:27:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286027; cv=none; b=aSVMP1fWCtCm8Jruoz3nrzJ0+P5YPxvvqMoR6w5xPPZJCEV7RTF0EF4oHNovsgWa5PaAAYta21VixBNSKNRNYJCQvdoldAvEEmQP9W6zxHR9k2prQyA00tkFVJoiNXR82vavpTnowEJGN2kOl6T9mHYkfvC1L78djQ0mvszqeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286027; c=relaxed/simple;
	bh=bnoyGYJMDBVFbDfUSkAtARl3V5hhLS9NnQHYiRCxY6U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SV02WGvsoCvmgjleiiDTQpQIfvylwEv2ZaVB/UPRHfSf2WQxCveBH2k9alvvzIzOce4IobP3KQTdJ5QWgY8jwcPji3SQ1Qg/7iHYCrRnmRcB5nT1Y3UGvDN1xVHhwFmVo/9IZ9lK9FA7L39QnFVyZk7u4ph2vpMpWiHtSAj05lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=avn9lc4X; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37c6cd1ac98so664788a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782286022; x=1782890822; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPgaXsZyiXshNUs2vS4qI9K7MIRRsE6MqEYsD1oXwCE=;
        b=avn9lc4XDP9i0zPicksbmmA09BKMBAV/cnBFbb6V7V0hMk+eho1WNYKWP4afu0EFMO
         /RiQxc+Smas8T/zLBJsAkF/GwhFPEKn1/ShMV+qLMEwTOavBKS72Nx6IGeFte7K0Mp56
         3pnNz3X9UhD/CaDH2+OG94LQnqTzUWeL+MQS55rMNvQxVpZcBw/WIGai0dqKcVuOSFHo
         +tJLuOXZRkV5bAbo7NPvMbqeK6lFzdkoK9iyCe2KnwDaPkjIgfxi6jshy94Cgv2uaQ77
         C9dHjgVx3vGiDN9IccOwH/DZVfJXXg+BM2CIScCJF2ax5cIt2/J/avKIaykRlB8I/+7B
         CmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286022; x=1782890822;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPgaXsZyiXshNUs2vS4qI9K7MIRRsE6MqEYsD1oXwCE=;
        b=Tond66o3srJIUkrE1+d4ZtjMh69sOIWo1TbeU6lpI6sllVJCQlOV66FdzIvbMnWChK
         LF88yvnBDNtshvoGzmjFXqHGHVetbuRIe7Eu5GwoZrfRU1j+JoVwJM8EVrkct8gQAzvc
         2nqiz0La3v3aH68Xa7zgtsAjNvdV4bJFoawlJRo3a96zA3lwQN1bYl2tNO2QXoYDEVbg
         3ffenyyfBauTTztjiiYF+5K/EDTF5GabnTuyxyebmRih5le0MpHec3ACYgBQLMzPuKIi
         CVJ9vFa8CsfCeZQYiJ6D4Cg+XSVY6Bj0b00D3h5ZQwcy0YnGng81QRpda3Vx/3HlTHMR
         ydOA==
X-Forwarded-Encrypted: i=1; AHgh+RrwP4YB8wmzU+7JejpqoLG0X+x5uUbnqYuMZpHZ9ekcwYaAFAbwJwWgNpoeWA/eLt/i9uquEus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh52v3ALm1PmzmAbeyIWgkj3Bo+n/muw2/AlQNiF79LZElKS9I
	wXnneO/83WMUNU1mVDBo6Hsoivp3r5rR1BwbugGaGtJgnlPo4i/+VsNeVPRkLIdWmZk=
X-Gm-Gg: AfdE7ckcNVyLy2R/EPWxUY9mkiHPqWm9PZzNbPJnzyLxa0MfHveNqu8ghC+NiF9weQu
	6qt8+uLLGP4BpkYZ9HDLj2/ZqqpLsV3YGz+HAJx/NDt3pvT/S1GnZZbQpV+SPWx0k2v6fCwEIMl
	OMMZlnn7emxutmlMssqNeqDilZhAWdlXohzPTAbh/a7Y9JzraIvvsh2GSwO3wdPSvaI8ClOArVh
	sFjyH6+AV7BjnkYBqc8EjOmOj8g0Tn6SQNQgpBeQ5vxpO2T2koIBth+V0trUZBRByM00DX6kgGH
	Q5yVMJeUkRAwHXkVzx0A7nO/1j8B2Qytey0JMCjmpd8d6uoRCke3axR3uVI9HI9rNvcCVVfygaE
	QZ+9DaZwEUnjzEXpqEEsC0I9N7HgdZm4xeEbENXmab8zJrCrbMPqpcnmS/5MGCwQuswRJLyoC3F
	QdaF+QSXHlaCqH/5yhgIKe/Be0
X-Received: by 2002:a17:90b:3f08:b0:377:23bb:9b88 with SMTP id 98e67ed59e1d1-37dd0db3e05mr6817189a91.12.1782286022013;
        Wed, 24 Jun 2026 00:27:02 -0700 (PDT)
Received: from localhost ([2605:8d80:5c40:7b14:89ba:fd93:9852:c9eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3b8396fsm1719932a91.12.2026.06.24.00.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 03:26:59 -0400
Message-Id: <DJH3NYA1TIXA.MM8QYB5HQOXJ@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <jordan@jrife.io>,
 <kuba@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 4/7] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb tests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-5-mahe.tardy@gmail.com>
In-Reply-To: <20260622120515.137082-5-mahe.tardy@gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301560-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 409636BC27E

On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> This test opens a server and client, enters a new cgroup, attach a
> cgroup_skb program on egress and calls the bpf_icmp_send function from
> the client egress so that an ICMP unreach control message is sent back
> to the client. It then fetches the message from the error queue to
> confirm the correct ICMP unreach code has been sent.
>
> Note that, for the client, we have to connect in non-blocking mode to
> let the test execute faster. Otherwise, we need to wait for the TCP
> three-way handshake to timeout in the kernel before reading the errno.
>
> Also note that we don't set IP_RECVERR on the socket in
> connect_to_fd_nonblock since the error will be transferred anyway in our
> test because the connection is rejected at the beginning of the TCP
> handshake. See in net/ipv4/tcp_ipv4.c:tcp_v4_err for more details.
>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 151 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/icmp_send.c |  38 +++++
>  2 files changed, 189 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfun=
c.c
>  create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> new file mode 100644
> index 000000000000..f4e5b883d4c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include <linux/errqueue.h>
> +#include <poll.h>
> +#include "icmp_send.skel.h"
> +
> +#define TIMEOUT_MS 1000
> +
> +#define ICMP_DEST_UNREACH 3
> +
> +#define ICMP_FRAG_NEEDED 4
> +#define NR_ICMP_UNREACH 15
> +
> +static int connect_to_fd_nonblock(int server_fd)
> +{
> +	struct sockaddr_storage addr;
> +	socklen_t len =3D sizeof(addr);
> +	int fd, err;
> +
> +	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
> +		return -1;
> +
> +	fd =3D socket(addr.ss_family, SOCK_STREAM | SOCK_NONBLOCK, 0);
> +	if (fd < 0)
> +		return -1;
> +
> +	err =3D connect(fd, (struct sockaddr *)&addr, len);
> +	if (err < 0 && errno !=3D EINPROGRESS) {
> +		close(fd);
> +		return -1;
> +	}
> +
> +	return fd;
> +}
> +
> +static void read_icmp_errqueue(int sockfd, int expected_code)
> +{
> +	struct sock_extended_err *sock_err;
> +	char ctrl_buf[512];
> +	struct msghdr msg =3D {
> +		.msg_control =3D ctrl_buf,
> +		.msg_controllen =3D sizeof(ctrl_buf),
> +	};
> +	struct pollfd pfd =3D {
> +		.fd =3D sockfd,
> +		.events =3D POLLERR,
> +	};
> +	struct cmsghdr *cm;
> +	ssize_t n;
> +
> +	if (!ASSERT_GE(poll(&pfd, 1, TIMEOUT_MS), 1, "poll_errqueue"))
> +		return;
> +
> +	n =3D recvmsg(sockfd, &msg, MSG_ERRQUEUE);
> +	if (!ASSERT_GE(n, 0, "recvmsg_errqueue"))
> +		return;
> +
> +	cm =3D CMSG_FIRSTHDR(&msg);
> +	if (!ASSERT_NEQ(cm, NULL, "cm_firsthdr_null"))
> +		return;
> +
> +	for (; cm; cm =3D CMSG_NXTHDR(&msg, cm)) {
> +		if (cm->cmsg_level !=3D IPPROTO_IP || cm->cmsg_type !=3D IP_RECVERR)
> +			continue;
> +
> +		sock_err =3D (struct sock_extended_err *)CMSG_DATA(cm);
> +
> +		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
> +			       "sock_err_origin_icmp"))
> +			return;
> +		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
> +			       "sock_err_type_dest_unreach"))
> +			return;
> +		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
> +		return;
> +	}
> +
> +	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");
> +}
> +
> +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int =
code)
> +{
> +	int srv_fd =3D -1, client_fd =3D -1;
> +	struct sockaddr_in addr;
> +	socklen_t len =3D sizeof(addr);
> +
> +	srv_fd =3D start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_M=
S);
> +	if (!ASSERT_OK_FD(srv_fd, "start_server"))
> +		return;
> +
> +	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
> +		close(srv_fd);
> +		return;
> +	}
> +	skel->bss->server_port =3D ntohs(addr.sin_port);
> +	skel->bss->unreach_code =3D code;
> +
> +	client_fd =3D connect_to_fd_nonblock(srv_fd);
> +	if (!ASSERT_OK_FD(client_fd, "client_connect_nonblock")) {
> +		close(srv_fd);
> +		return;
> +	}
> +
> +	/* Skip reading ICMP error queue if code is invalid */
> +	if (code >=3D 0 && code <=3D NR_ICMP_UNREACH)
> +		read_icmp_errqueue(client_fd, code);
> +
> +	close(client_fd);
> +	close(srv_fd);
> +}
> +
> +void test_icmp_send_unreach_cgroup(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd =3D -1;
> +
> +	skel =3D icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	cgroup_fd =3D test__join_cgroup("/icmp_send_unreach_cgroup");
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
> +		goto cleanup;
> +
> +	skel->links.egress =3D
> +		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	for (int code =3D 0; code <=3D NR_ICMP_UNREACH; code++) {
> +		/*
> +		 * The TCP stack reacts differently when asking for
> +		 * fragmentation, let's ignore it for now.
> +		 */
> +		if (code =3D=3D ICMP_FRAG_NEEDED)
> +			continue;
> +
> +		trigger_prog_read_icmp_errqueue(skel, code);
> +		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
> +	}
> +
> +	/* Test an invalid code */
> +	trigger_prog_read_icmp_errqueue(skel, -1);
> +	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> +
> +cleanup:
> +	icmp_send__destroy(skel);
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testin=
g/selftests/bpf/progs/icmp_send.c
> new file mode 100644
> index 000000000000..6d0be0a9afe1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +/* 127.0.0.1 in host byte order */
> +#define SERVER_IP 0x7F000001
> +
> +#define ICMP_DEST_UNREACH 3
> +
> +__u16 server_port =3D 0;
> +int unreach_code =3D 0;
> +int kfunc_ret =3D -1;
> +
> +SEC("cgroup_skb/egress")
> +int egress(struct __sk_buff *skb)
> +{
> +	void *data =3D (void *)(long)skb->data;
> +	void *data_end =3D (void *)(long)skb->data_end;
> +	struct iphdr *iph;
> +	struct tcphdr *tcph;
> +
> +	iph =3D data;
> +	if ((void *)(iph + 1) > data_end || iph->version !=3D 4 ||
> +	    iph->protocol !=3D IPPROTO_TCP || iph->daddr !=3D bpf_htonl(SERVER_=
IP))
> +		return SK_PASS;
> +
> +	tcph =3D (void *)iph + iph->ihl * 4;
> +	if ((void *)(tcph + 1) > data_end ||
> +	    tcph->dest !=3D bpf_htons(server_port))
> +		return SK_PASS;
> +
> +	kfunc_ret =3D bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
> +
> +	return SK_DROP;
> +}
> +
> +char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> --
> 2.34.1


