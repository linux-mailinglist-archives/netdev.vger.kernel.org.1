Return-Path: <netdev+bounces-293884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FJ9JHjOHWpeewkAu9opvQ
	(envelope-from <netdev+bounces-293884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:24:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A601623E82
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A56413016B48
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FDA3E1D08;
	Mon,  1 Jun 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="dskOif/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AD3112BC
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338290; cv=none; b=Mb2yZGji5XkGkletZ0PAxHPjFAZhZwlTXMFydnf/Fzg3aSZLgZUZPsrlZIt/USZodcHGJNsYaqlIFy452qa6QYYXnm3n/WdqB0rrOYI52Vozkbsu3o+5De+1McOV8Qb7G/fD/6qZX1yTYJaB2ncfqBSn58zgVRRGEwySx3QCQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338290; c=relaxed/simple;
	bh=hOILsP+0Eqs3JFb8e2Vfwd5JMTuh4PUjSveLorarlHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fTaYrSTqtEU98r2ZdjY9U7QSgVMcb7nnPQHWpujkyH5rz1xGbHo7dG+NhyjfsqxD7f7dgxuo7wyqgJoBVLiHKiB762ORBHsiwwKHVYkfKz1VauM6L4AMBB4oZoioTqWooYmgHX8N8IuS5aLqKUDuApzBFP95dLFaeTx0yH8kWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=dskOif/v; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304e83724bfso4567150eec.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780338287; x=1780943087; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7IE3lrCAU2wICe64aFr6+14ggCx1eMiEJoUvGWrTOI=;
        b=dskOif/vbVhzLyxoAG0RkeUJBgqZtAPxs2itYNLaCC05/o7EM9Yb5bH5CP729PhnKP
         SY/1eIZxPsgdfsyEnQbNDIvXG8n3NO7K+JeND2KCtU7Fa4G/LP6REpwRXn4ILAOwAr+q
         RXbktZfiAEeXofvjtV57VM/Lgb+CBZ3aLJIjxedvWI0g1lSVcO7o2YV2gOKAzhqSR6D4
         SJlT+F1e/Sz+P0pS2FueLUVZxjO0uionQJ7oa000G2PFM7k/WHGCdBW/mrNPsBYlDgS+
         BbHyzkDceIPPkHyPimb0UshvyLsaOWuA/wloGJKNppF+rHgS6mngzgoGN9Z6VKFgkoMU
         W13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338287; x=1780943087;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7IE3lrCAU2wICe64aFr6+14ggCx1eMiEJoUvGWrTOI=;
        b=hju+wst/7mgv1VwT39a/fV8HxwRKbDvYEz6gfYaSj6/lEcIKHhPoNUkRpSQ3V2ktqx
         I65NzYlE7XxDn/OhuQjd3huvqFC9NfBKnXPbJD+/wlwlJBUlAwK2IlhKFbWrvb7DJMQL
         b4wA4oQqj/Q8M14Z4eQFqs41O1QEWKyFmtwDYJwOkdBRgyMuNpqHbQ+UcZTOPZwUnRsZ
         0ILFu+kFTurGSZkGl/SPNqRmxBG/denAg4NI+Vvqtvki2hBN+DeF7YEoFx8QloMQhwq8
         wuiyYHJzy/YhPyQkSIW6DAizDUjO9Tavl9KAGqwuxzYj+++FgaC1Ab0mdb3XFfUyjgna
         6enw==
X-Forwarded-Encrypted: i=1; AFNElJ/VF/1lc+kR/fSrbS+NgMXa3Elux+rHC9lh/BUZk9Dtj5gMy+3XgNRa4kA7uFMWEEe/fGLlrY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8+DWMKpvZvW8c4QpmD8F+2EEV0WcfLzrrkNppVXS01BzJR2J
	YFOnf/Agnb0GmaFmy6lMWnf/WvYYypvL4mLDoJE214Waf79mNKn4hg9eYZQaULOjkcM=
X-Gm-Gg: Acq92OFDeYOtLkLJo0cCpr+ZQd3afYw6S/tIGYjr/X5I21j2dPfUsrw1KeK1Ac+XcpF
	x96FwxYy16JYvfJujT0RVQK4Bldj7N+QtqY2AVIscFLhfro6+sGSXmiURdrq4YjmMB5QrcB7d96
	CI6/DpfUfpBq2gku+5fqSBx0DBm1Hexi9ifJ5Iv6Yf/26JbKJ6vsJT7ED+DeF5wsNOA2iVZ1khr
	wRMuHC+XMZf6r9pDmAiT/1jLzl8OMFef91DEHxKcVFZUAacpv3TX+nkwSQfxYDNVu66wtRFPDXJ
	jRyspyswrOVPCYlkdpfiE4YgeTOHbAuZb4TSOSQAcCFSoI2rtGP4XO52mSW14ft9zDm7ITPlBN5
	AcM4tfNcxOeBD+wOx0Y7HBbRctaT3WqNO+dZ2mc3aiRwL+6bcaUX6L+GvWHB/RMzndNfAkN3QVe
	rbRWgVq+YNfPU+PPo=
X-Received: by 2002:a05:7300:c87:b0:304:2e9b:8f57 with SMTP id 5a478bee46e88-304fa6ef8a1mr5591798eec.34.1780338286453;
        Mon, 01 Jun 2026 11:24:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::a996])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm12846684eec.21.2026.06.01.11.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 11:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 14:24:43 -0400
Message-Id: <DIXX90BMJRXM.1XKUMNSDY9OO@etsalapatis.com>
Cc: "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Guillaume Nault" <gnault@redhat.com>, "Ido Schimmel"
 <idosch@nvidia.com>, "Fernando Fernandez Mancera" <fmancera@suse.de>,
 "Peter Oskolkov" <posk@google.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>, "Leon Hwang" <leon.huangfu@shopee.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add tests to verify the fix
 of encapsulating VxLAN in lwt
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601150203.20352-1-leon.hwang@linux.dev>
 <20260601150203.20352-3-leon.hwang@linux.dev>
In-Reply-To: <20260601150203.20352-3-leon.hwang@linux.dev>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:mid,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A601623E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Jun 1, 2026 at 11:02 AM EDT, Leon Hwang wrote:
> Add two tests to verify the transport header of skb has been set when
> encapsulate VxLAN using bpf_lwt_push_encap() helper.
>
> 1. VxLAN over IPv4.
> 2. VxLAN over IPv6.
>
> Without the fix, the tests would fail:
>
>  lwt_ip_encap_vxlan:FAIL:transport_hdr offset unexpected transport_hdr of=
fset: actual 70 !=3D expected 20
>  #208     lwt_ip_encap_vxlan_ipv4:FAIL
>  lwt_ip_encap_vxlan:FAIL:transport_hdr offset unexpected transport_hdr of=
fset: actual 110 !=3D expected 40
>  #209     lwt_ip_encap_vxlan_ipv6:FAIL
>
> Assisted-by: Claude:claude-sonnet-4-6
> Cc: Leon Hwang <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 164 ++++++++++++++++++
>  .../selftests/bpf/progs/test_lwt_ip_encap.c   | 112 ++++++++++++
>  .../bpf/progs/test_lwt_ip_encap_fix.c         |  44 +++++
>  3 files changed, 320 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_ip_encap_f=
ix.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tool=
s/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> index b6391af5f6f9..50104d847fde 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> @@ -1,8 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
>  #include <netinet/in.h>
> =20
>  #include "network_helpers.h"
>  #include "test_progs.h"
> +#include "test_lwt_ip_encap_fix.skel.h"
> =20
>  #define BPF_FILE "test_lwt_ip_encap.bpf.o"
> =20
> @@ -35,6 +38,10 @@
>  #define IP6_ADDR_SRC IP6_ADDR_1
>  #define IP6_ADDR_DST IP6_ADDR_4
> =20
> +/* VxLAN tunnel endpoints, reachable via the bottom route (veth5/6/7/8).=
 */
> +#define IP4_ADDR_VXLAN  "172.16.17.100"
> +#define IP6_ADDR_VXLAN  "fb20::1"

There's a whole series of existing IP definitions at the top of the file, w=
e
should put those new ones right below them. And fb20 -> fb11 to keep
with the pattern imo.

> +
>  /* Setup/topology:
>   *
>   *    NS1             NS2             NS3
> @@ -538,3 +545,160 @@ void test_lwt_ip_encap_ipv4(void)
>  	if (test__start_subtest("ingress"))
>  		lwt_ip_encap(IPV4_ENCAP, INGRESS, "");
>  }
> +
> +/*
> + * VxLAN Setup/topology:
> + *
> + * NS1 (IP*_ADDR_1)                NS2                  NS3 (IP*_ADDR_4)
> + *       [ping src]
> + *           |                          top route
> + *         veth1 (LWT encap)  <<-- veth2        veth3  <<-- veth4 (ping =
dst)
> + *           |                                                ^
> + *       (bottom route)                                       | (inner p=
kt)
> + *           v                        bottom route            |
> + *         veth5              -->> veth6        veth7  -->> veth8 (vxlan=
 decap)
> + *                                                          (IP*_ADDR_VX=
LAN)
> + *
Not sure if this is rendering weird for me but NS2 could be tabbed over
once more for clarity.

> + * Add the VxLAN endpoint addresses to NS3's veth8, create standard
> + * VxLAN decap devices bound to those addresses, and install routes so
> + * NS1/NS2 can reach the endpoints via the bottom route.
> + */
> +static int setup_vxlan_routes(const char *ns3, const char *ns1, const ch=
ar *ns2)
> +{
> +	struct nstoken *nstoken;
> +
> +	nstoken =3D open_netns(ns3);
> +	if (!ASSERT_OK_PTR(nstoken, "open ns3 for vxlan"))
> +		return -1;
> +
> +	SYS(fail_close, "ip    a add %s/32  dev veth8", IP4_ADDR_VXLAN);
> +	SYS(fail_close, "ip -6 a add %s/128 dev veth8", IP6_ADDR_VXLAN);
> +	/*
> +	 * Standard VxLAN devices to decap the encapsulated packets.  The inner
> +	 * Ethernet frame uses a broadcast dst MAC so the IP stack accepts it
> +	 * without ARP or FDB configuration.
> +	 */
> +	SYS(fail_close, "ip link add vxlan4 type vxlan id 1 dstport 4789 local =
%s dev veth8 nolearning noudpcsum",
> +	    IP4_ADDR_VXLAN);
> +	SYS(fail_close, "ip link set vxlan4 up");
> +	SYS(fail_close, "ip link add vxlan6 type vxlan id 1 dstport 4789 local =
%s dev veth8 nolearning udp6zerocsumrx",
> +	    IP6_ADDR_VXLAN);
> +	SYS(fail_close, "ip link set vxlan6 up");
> +	close_netns(nstoken);
> +
> +	SYS(fail, "ip -n %s    route add %s/32  dev veth5 via %s",
> +	    ns1, IP4_ADDR_VXLAN, IP4_ADDR_6);
> +	SYS(fail, "ip -n %s    route add %s/32  dev veth7 via %s",
> +	    ns2, IP4_ADDR_VXLAN, IP4_ADDR_8);
> +	SYS(fail, "ip -n %s -6 route add %s/128 dev veth5 via %s",
> +	    ns1, IP6_ADDR_VXLAN, IP6_ADDR_6);
> +	SYS(fail, "ip -n %s -6 route add %s/128 dev veth7 via %s",
> +	    ns2, IP6_ADDR_VXLAN, IP6_ADDR_8);
> +	return 0;
> +
> +fail_close:
> +	close_netns(nstoken);
> +fail:
> +	return -1;
> +}
> +
> +/*
> + * VxLAN encap tests (IPv4-outer and IPv6-outer variants).
> + *
> + * Test 1 - functional: the BPF LWT xmit program encapsulates the packet
> + *   (protocol=3DUDP, port=3D4789) and re-routes it without dropping it.
> + *   Verified by ping success.
> + *
> + * Test 2 - fix verification: after bpf_lwt_push_ip_encap() the
> + *   skb->transport_header must point at the outer UDP header, i.e.
> + *   transport_header - network_header =3D=3D sizeof(outer IP header).
> + *   Without the fix the transport_header still points at the inner
> + *   transport layer, giving a wrong (larger) offset.
> + */

The Test 2 bullet regurgitates the AI's context, can you rephrase it so
that it's not framed as a fix but as a test?

> +static void lwt_ip_encap_vxlan(bool ipv4_encap)
> +{
> +	char ns1[NETNS_NAME_SIZE] =3D NETNS_BASE "-1-";
> +	char ns2[NETNS_NAME_SIZE] =3D NETNS_BASE "-2-";
> +	char ns3[NETNS_NAME_SIZE] =3D NETNS_BASE "-3-";
> +	const char *sec =3D ipv4_encap ? "encap_vxlan" : "encap_vxlan6";
> +	int expected_offset =3D ipv4_encap ? (int)sizeof(struct iphdr)
> +					 : (int)sizeof(struct ipv6hdr);
> +	struct test_lwt_ip_encap_fix *skel =3D NULL;
> +	int thdr_offset, err;
> +
> +	if (!ASSERT_OK(create_ns(ns1, NETNS_NAME_SIZE), "create ns1"))
> +		goto out;
> +	if (!ASSERT_OK(create_ns(ns2, NETNS_NAME_SIZE), "create ns2"))
> +		goto out;
> +	if (!ASSERT_OK(create_ns(ns3, NETNS_NAME_SIZE), "create ns3"))
> +		goto out;
> +
> +	if (!ASSERT_OK(setup_network(ns1, ns2, ns3, ""), "setup network"))
> +		goto out;
> +
> +	if (!ASSERT_OK(setup_vxlan_routes(ns3, ns1, ns2), "setup vxlan routes")=
)
> +		goto out;
> +
> +	/*
> +	 * Attach fexit to bpf_lwt_push_ip_encap() before installing the
> +	 * LWT route so we don't miss the first encap call.
> +	 */
> +	skel =3D test_lwt_ip_encap_fix__open();
> +	if (!ASSERT_OK_PTR(skel, "test_lwt_ip_encap_fix__open"))
> +		goto out;
> +
> +	skel->rodata->tgt_ip_version =3D ipv4_encap ? 4 : 6;
> +
> +	err =3D test_lwt_ip_encap_fix__load(skel);
> +	if (!ASSERT_OK(err, "test_lwt_ip_encap_fix__load"))
> +		goto out;
> +
> +	err =3D test_lwt_ip_encap_fix__attach(skel);
> +	if (!ASSERT_OK(err, "test_lwt_ip_encap_fix__attach"))
> +		goto out;
> +
> +	/* Remove the direct NS2->DST route so packets must go via LWT encap. *=
/
> +	SYS(out, "ip -n %s    route del %s/32  dev veth3", ns2, IP4_ADDR_DST);
> +	SYS(out, "ip -n %s -6 route del %s/128 dev veth3", ns2, IP6_ADDR_DST);
> +
> +	/* Install the VxLAN BPF LWT xmit route. */
> +	if (ipv4_encap)
> +		SYS(out, "ip -n %s route add %s encap bpf xmit obj %s sec %s dev veth1=
",
> +		    ns1, IP4_ADDR_DST, BPF_FILE, sec);
> +	else
> +		SYS(out, "ip -n %s -6 route add %s encap bpf xmit obj %s sec %s dev ve=
th1",
> +		    ns1, IP6_ADDR_DST, BPF_FILE, sec);
> +
> +	skel->bss->fexit_triggered =3D false;
> +	if (ipv4_encap)
> +		SYS(out, "ip netns exec %s ping  -c 1 -W1 %s", ns1, IP4_ADDR_DST);
> +	else
> +		SYS(out, "ip netns exec %s ping6 -c 1 -W1 %s", ns1, IP6_ADDR_DST);
> +
> +	/* Test 1: fexit triggered means bpf_lwt_push_ip_encap() succeeded. */
> +	if (!ASSERT_TRUE(skel->bss->fexit_triggered, "fexit_triggered"))
> +		goto out;
> +
> +	/*
> +	 * Test 2: transport_header must sit immediately after the outer IP
> +	 * header, pointing at the UDP header of the VxLAN encap.
> +	 */
> +	thdr_offset =3D (int)skel->bss->transport_hdr - (int)skel->bss->network=
_hdr;
> +	ASSERT_EQ(thdr_offset, expected_offset, "transport_hdr offset");
> +
> +out:
> +	test_lwt_ip_encap_fix__destroy(skel);
> +	SYS_NOFAIL("ip netns del %s", ns1);
> +	SYS_NOFAIL("ip netns del %s", ns2);
> +	SYS_NOFAIL("ip netns del %s", ns3);
> +}
> +
> +void test_lwt_ip_encap_vxlan_ipv4(void)
> +{
> +	lwt_ip_encap_vxlan(IPV4_ENCAP);
> +}
> +
> +void test_lwt_ip_encap_vxlan_ipv6(void)
> +{
> +	lwt_ip_encap_vxlan(IPV6_ENCAP);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c b/tool=
s/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> index d6cb986e7533..36f0fc682ffb 100644
> --- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> @@ -2,8 +2,10 @@
>  #include <stddef.h>
>  #include <string.h>
>  #include <linux/bpf.h>
> +#include <linux/if_ether.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/udp.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
> =20
> @@ -82,4 +84,114 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
>  	return BPF_LWT_REROUTE;
>  }
> =20
> +struct vxlanhdr {
> +	__be32 vx_flags;  /* I flag =3D 0x08000000 (valid VNI) */
> +	__be32 vx_vni;    /* VNI in top 24 bits */
> +};
> +
> +#define VXLAN_PORT  4789
> +#define VXLAN_FLAGS 0x08000000
> +#define VXLAN_VNI   1
> +
> +static const __u8 bcast[ETH_ALEN] =3D {
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +};
> +
q +static const __u8 srcmac[ETH_ALEN] =3D {
> +	0x02, 0x00, 0x00, 0x00, 0x00, 0x01,
> +};
> +
> +SEC("encap_vxlan")
> +int bpf_lwt_encap_vxlan(struct __sk_buff *skb)
> +{
> +	struct encap_hdr {
> +		struct iphdr    iph;
> +		struct udphdr   udph;
> +		struct vxlanhdr vxh;
> +		struct ethhdr   eth;
> +	} __attribute__((__packed__)) /* packed is required to avoid padding */=
 hdr;

Comment is unnecessary here.

> +	int err;
> +
> +	memset(&hdr, 0, sizeof(hdr));
> +
> +	hdr.iph.ihl      =3D 5;
> +	hdr.iph.version  =3D 4;
> +	hdr.iph.ttl      =3D 0x40;
> +	hdr.iph.protocol =3D 17; /* IPPROTO_UDP */
> +	hdr.iph.tot_len  =3D bpf_htons(skb->len + sizeof(hdr));
> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +	hdr.iph.saddr =3D 0x640510ac;  /* 172.16.5.100  */
> +	hdr.iph.daddr =3D 0x641110ac;  /* 172.16.17.100 */

Ideally want to keep the addresses we are hardcoding here and the
the addresses we're declaring in the userspace part in sync. Here
we've hardcoded the addresses three multiple ways (be, le, and string
in the userspace part).

> +#elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> +	hdr.iph.saddr =3D 0xac100564;  /* 172.16.5.100 */
> +	hdr.iph.daddr =3D 0xac101164;  /* 172.16.17.100 */
> +#else
> +#error "Fix your compiler's __BYTE_ORDER__?!"
> +#endif
> +
> +	hdr.udph.source =3D bpf_htons(VXLAN_PORT);
> +	hdr.udph.dest   =3D bpf_htons(VXLAN_PORT);
> +	hdr.udph.len    =3D bpf_htons(skb->len + sizeof(hdr.udph) + sizeof(hdr.=
vxh) +
> +				    sizeof(hdr.eth));
> +
> +	hdr.vxh.vx_flags =3D bpf_htonl(VXLAN_FLAGS);
> +	hdr.vxh.vx_vni   =3D bpf_htonl(VXLAN_VNI << 8);
> +
> +	__builtin_memcpy(hdr.eth.h_dest, bcast, ETH_ALEN);
> +	__builtin_memcpy(hdr.eth.h_source, srcmac, ETH_ALEN);
> +	hdr.eth.h_proto =3D bpf_htons(ETH_P_IP);
> +
> +	err =3D bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &hdr, sizeof(hdr));
> +	if (err)
> +		return BPF_DROP;
> +
> +	return BPF_LWT_REROUTE;
> +}
> +
> +SEC("encap_vxlan6")
> +int bpf_lwt_encap_vxlan6(struct __sk_buff *skb)
> +{
> +	struct encap_hdr {
> +		struct ipv6hdr  ip6hdr;
> +		struct udphdr   udph;
> +		struct vxlanhdr vxh;
> +		struct ethhdr   eth;
> +	} __attribute__((__packed__)) /* packed is required to avoid padding */=
 hdr;
> +	int err;
> +
> +	memset(&hdr, 0, sizeof(hdr));
> +
> +	hdr.ip6hdr.version     =3D 6;
> +	hdr.ip6hdr.nexthdr     =3D 17; /* IPPROTO_UDP */
> +	hdr.ip6hdr.hop_limit   =3D 0x40;
> +	hdr.ip6hdr.payload_len =3D bpf_htons(skb->len + sizeof(hdr.udph) + size=
of(hdr.vxh) +
> +					   sizeof(hdr.eth));
> +	/* fb05::1 */
> +	hdr.ip6hdr.saddr.s6_addr[0]  =3D 0xfb;
> +	hdr.ip6hdr.saddr.s6_addr[1]  =3D 0x05;
> +	hdr.ip6hdr.saddr.s6_addr[15] =3D 1;
> +	/* fb20::1 */
> +	hdr.ip6hdr.daddr.s6_addr[0]  =3D 0xfb;
> +	hdr.ip6hdr.daddr.s6_addr[1]  =3D 0x20;
> +	hdr.ip6hdr.daddr.s6_addr[15] =3D 1;
> +
> +	hdr.udph.source =3D bpf_htons(VXLAN_PORT);
> +	hdr.udph.dest   =3D bpf_htons(VXLAN_PORT);
> +	hdr.udph.len    =3D bpf_htons(skb->len + sizeof(hdr.udph) + sizeof(hdr.=
vxh) +
> +				    sizeof(hdr.eth));
> +
> +	hdr.vxh.vx_flags =3D bpf_htonl(VXLAN_FLAGS);
> +	hdr.vxh.vx_vni   =3D bpf_htonl(VXLAN_VNI << 8);
> +
> +	__builtin_memcpy(hdr.eth.h_dest, bcast, ETH_ALEN);
> +	__builtin_memcpy(hdr.eth.h_source, srcmac, ETH_ALEN);
> +	hdr.eth.h_proto =3D bpf_htons(ETH_P_IPV6);
> +
> +	err =3D bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &hdr, sizeof(hdr));
> +	if (err)
> +		return BPF_DROP;
> +
> +	return BPF_LWT_REROUTE;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c b/=
tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c

We definitely need to change the name here this is straight from the AI.

> new file mode 100644
> index 000000000000..6945f83b94f2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#define NEXTHDR_UDP		17	/* UDP message. */

Unnecessary, we hardcode 17 in the other test.

> +
> +volatile const int tgt_ip_version;
> +
> +__u16 transport_hdr =3D 0;
> +__u16 network_hdr =3D 0;
> +bool fexit_triggered =3D false;
> +
> +/*
> + * bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool i=
ngress)
> + *
> + * After a successful push the transport_header must point at the outer
> + * transport header (UDP for VxLAN), i.e.
> + *   transport_header - network_header =3D=3D sizeof(outer IP header)
> + */
> +SEC("fexit/bpf_lwt_push_ip_encap")
> +int BPF_PROG(fexit_lwt_push_ip_encap, struct sk_buff *skb, void *hdr, u3=
2 len, bool ingress,
> +	     int retval)
> +{
> +	struct iphdr *iph;
> +
> +	if (retval || fexit_triggered)
> +		return 0;
> +
> +	iph =3D (typeof(iph)) (skb->head + skb->network_header);
> +	if (iph->version !=3D tgt_ip_version)
> +		return 0;
> +
> +	if ((iph->version =3D=3D 4 && iph->protocol =3D=3D IPPROTO_UDP) ||
> +	    (iph->version =3D=3D 6 && ((struct ipv6hdr *)iph)->nexthdr =3D=3D N=
EXTHDR_UDP)) {
> +		fexit_triggered =3D true;
> +		transport_hdr   =3D BPF_CORE_READ(skb, transport_header);
> +		network_hdr     =3D BPF_CORE_READ(skb, network_header);
> +	}
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";


