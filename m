Return-Path: <netdev+bounces-289243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMeHIxa+C2rBLwUAu9opvQ
	(envelope-from <netdev+bounces-289243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:34:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1C5761B4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A82E3014B14
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF872E6CB8;
	Tue, 19 May 2026 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="sQim9IdP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9F2D7DF8
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154446; cv=none; b=n9HVpEHQt70y+4f9b+cgRj5sYd1LS/NvQdI7YYqHA8I0ABB9/NnLtN6qB28ctD3WgFovCol3qaqe7ftoPw97ICmx+rGMxGCq+1/rqPQPLSF8JkV1T8POcuJTlpDXVYhAX9OfmXWQV7a3ImNlXlpR9bC2rkCnu9ctbLVMgm33H5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154446; c=relaxed/simple;
	bh=AmBQrv7bGhZxxnssPV19XZEMDfMCZYZwefyDBqlF0sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUjoygQnT/H9hWQxC28zyzWQaYWpEinrxrO/y4errMyFO68OtCxaab4obsv/WoIN9KQV1hVF3rEvCcQZGslDbcPVsz90GKExEOMiUeYMPnhH6XOESSk+QxXQGbZaeVN1uBAYYHYQxaDbo0uxOMqX7FI4S80EfX3cyCYleHdTTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=sQim9IdP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b95a78a11dso5970255ad.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1779154445; x=1779759245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pINLyxS4eQ1pTpZaDnr3VCbQL4QP6sJ4Z3GfPCiP49I=;
        b=sQim9IdP4eU8JOE+36nC+mN1SrXuEnqwVWg3Rs4hlXDk5ZVHhqGq5XquuEWASYZ96v
         ui6uzmu6PTAXqqQ9r6ujjJRCUNymtPTkPfLB8Xi2x+UoDUmzGvUyNQHgbLV59Psm1A63
         f2GQ9+AnNiXcAOpXDbd+8Z+3Fw7F0mh6+/S7K8zN8bhvv3hraeL8cwqZkMkwBKVIIHYq
         5JDYWu9QH6m6CRqXi2zn9x/tzP9psNNixq2aUx+pIDF5KlDmnVrdE2S3YI/sAibyin0p
         OiMQpINIztfikrxvaAKylZSP1QQdvB+rNiQQpaDMVqqtliqYTlpJKHA3iy9MJSLLixLZ
         tkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154445; x=1779759245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pINLyxS4eQ1pTpZaDnr3VCbQL4QP6sJ4Z3GfPCiP49I=;
        b=TVZiqHTeRqmWG8yrouRCD/VPSNRZve7fVRcY3euyFD4sg5YFaF3qlDFadKnBLDcTOu
         6Z9tQMknK2daSjVouY+PfM2d327oG4n90ZjmQJPaomthDuV7CzVJmgT0Z3xU163QwuiH
         zEb3M4PuJMULe1oIfF7uuOSc/qwa33jM2p+bwra1nFROFZiXghfgEvqhz+bzJH57n9ah
         osipWrsokgP6Vs80tH5bTp6x78A6vQKWFETCEtMRqV7jz51myLoT/0qBRaYK6ITlwvNo
         N451U284vFkosudU38mE2Stzcy/CHVybNfNVhya4R2vwa/hIoweCHRNpA6vKyWEsW/1z
         o3SQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pc/00BZHBV9MCFUIFcalouy7qg1DagkPJX6wEOIMjAShnQjNDnFaCxrQtKRQm6gj3d83sHlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5azKy3NmuW94nFMEsO4a2+yorOz7Rirk8DemNaAb07iZuliAs
	UM9Z7EfaCgY8hczwBhKUzl9+dAju9rhPHPs2VUgLRge8APeIIU9bjCneCWz9sQEiEzk=
X-Gm-Gg: Acq92OHGowIb609QGBqfVvhMnBa+QyRxdxINB37SgI1JRGYzNmshSGz8p+8xNxVxaZo
	6w//awQk1UrBhQ1RZ0NZD0kBpVII8GwjtMdziOGHVAajyEDbdKfuaNR5f2yyyb14tiI1eeqv0MM
	vZ9oflE5FOWylL0spRlLpyCO3wUj2HWt97vvRD4fuWaEshbAbD+5+Fn+U+Tur9bmj0YyTvKcYdS
	Q5NlMADa7FMfC9EwuS65bBBvTHBswqPrJFb8hRdZndduODricJZj1YvnLpkQusQodMK/dN6KqMO
	4dktEv/ygKJggpWDtGA2NHRGyOaRr6LAP3Mc9SFhjGquvvzsBrVVFzEiEJ+Ngf/ZlMte6T+M2sk
	NEM0f5nrp2HxXW/locT8BRKtXUZm9T0NjORFxTQ2O+2TFDGACNYu+EYJwBs1IB95MuJVxUYYx/+
	UVXFX+W8k0PE1G6Hb6kLlF2K1e
X-Received: by 2002:a17:903:1b45:b0:2ba:3376:2354 with SMTP id d9443c01a7336-2bd7e8b9c41mr97941405ad.5.1779154444744;
        Mon, 18 May 2026 18:34:04 -0700 (PDT)
Received: from m2 ([83.171.251.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fc4a9sm165471195ad.61.2026.05.18.18.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:34:04 -0700 (PDT)
Date: Mon, 18 May 2026 18:34:02 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v6 4/6] selftests/bpf: add bpf_icmp_send kfunc
 tests
Message-ID: <q46w47cqezttz2otf76tncxu7sovhywy2dqwcbajigp64uhbtz@eimvxfeeexuz>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
 <20260518122842.218522-5-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518122842.218522-5-mahe.tardy@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jrife.io];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289243-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,google.com,redhat.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jrife-io.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8FF1C5761B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 12:28:40PM +0000, Mahe Tardy wrote:
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
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 152 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/icmp_send.c |  38 +++++
>  2 files changed, 190 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> new file mode 100644
> index 000000000000..4f0aed8152d3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -0,0 +1,152 @@
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
> +	socklen_t len = sizeof(addr);
> +	int fd, err;
> +
> +	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
> +		return -1;
> +
> +	fd = socket(addr.ss_family, SOCK_STREAM | SOCK_NONBLOCK, 0);

Is the only customization here SOCK_NONBLOCK? Would it be possible to
simply extend network_helper_opts to make it possible via the existing
connect_to_fd_opts? Alternatively, is it possible to test with
SOCK_DGRAM to avoid the handshake timeout issue?

> +	if (fd < 0)
> +		return -1;
> +
> +	err = connect(fd, (struct sockaddr *)&addr, len);
> +	if (err < 0 && errno != EINPROGRESS) {
> +		close(fd);
> +		return -1;
> +	}
> +
> +	return fd;
> +}
> +
> +static void read_icmp_errqueue(int sockfd, int expected_code)
> +{
> +	ssize_t n;

very small nit: Other functions follow reverse xmas tree order but this
one doesn't which looks kind of weird.

> +	struct sock_extended_err *sock_err;
> +	struct cmsghdr *cm;
> +	char ctrl_buf[512];
> +	struct msghdr msg = {
> +		.msg_control = ctrl_buf,
> +		.msg_controllen = sizeof(ctrl_buf),
> +	};
> +	struct pollfd pfd = {
> +		.fd = sockfd,
> +		.events = POLLERR,
> +	};
> +
> +	if (!ASSERT_GE(poll(&pfd, 1, TIMEOUT_MS), 1, "poll_errqueue"))
> +		return;
> +
> +	n = recvmsg(sockfd, &msg, MSG_ERRQUEUE);
> +	if (!ASSERT_GE(n, 0, "recvmsg_errqueue"))
> +		return;
> +
> +	cm = CMSG_FIRSTHDR(&msg);
> +	if (!ASSERT_NEQ(cm, NULL, "cm_firsthdr_null"))
> +		return;
> +
> +	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
> +		if (cm->cmsg_level != IPPROTO_IP ||
> +		    cm->cmsg_type != IP_RECVERR)
> +			continue;
> +
> +		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);
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
> +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
> +					    int code)
> +{
> +	int srv_fd = -1, client_fd = -1;
> +	struct sockaddr_in addr;
> +	socklen_t len = sizeof(addr);
> +
> +	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
> +			      TIMEOUT_MS);
> +	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> +		return;

ASSERT_OK_FD

> +
> +	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
> +		close(srv_fd);
> +		return;
> +	}
> +	skel->bss->server_port = ntohs(addr.sin_port);
> +	skel->bss->unreach_code = code;
> +
> +	client_fd = connect_to_fd_nonblock(srv_fd);
> +	if (!ASSERT_GE(client_fd, 0, "client_connect_nonblock")) {

ASSERT_OK_FD

> +		close(srv_fd);
> +		return;
> +	}
> +
> +	/* Skip reading ICMP error queue if code is invalid */
> +	if (code >= 0 && code <= NR_ICMP_UNREACH)
> +		read_icmp_errqueue(client_fd, code);
> +

Consider doing all cleanup here and just adding a goto label like
cleanup in test_icmp_send_unreach?

> +	close(client_fd);
> +	close(srv_fd);
> +}
> +
> +void test_icmp_send_unreach(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd = -1;
> +
> +	skel = icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		goto cleanup;

ASSERT_OK_FD

> +
> +	skel->links.egress =
> +		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
> +		/* The TCP stack reacts differently when asking for
> +		 * fragmentation, let's ignore it for now.
> +		 */
> +		if (code == ICMP_FRAG_NEEDED)
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
> +	close(cgroup_fd);

if (cgroup_fd != -1)
	close(cgroup_fd);

> +}
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
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
> +__u16 server_port = 0;
> +int unreach_code = 0;
> +int kfunc_ret = -1;
> +
> +SEC("cgroup_skb/egress")

No test for TC?

> +int egress(struct __sk_buff *skb)
> +{
> +	void *data = (void *)(long)skb->data;
> +	void *data_end = (void *)(long)skb->data_end;
> +	struct iphdr *iph;
> +	struct tcphdr *tcph;
> +
> +	iph = data;
> +	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
> +	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
> +		return SK_PASS;
> +
> +	tcph = (void *)iph + iph->ihl * 4;
> +	if ((void *)(tcph + 1) > data_end ||
> +	    tcph->dest != bpf_htons(server_port))
> +		return SK_PASS;
> +
> +	kfunc_ret = bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
> +
> +	return SK_DROP;
> +}
> +
> +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> --
> 2.34.1
>

Jordan

