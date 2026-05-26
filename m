Return-Path: <netdev+bounces-291814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILxGFEHIFWpNbQcAu9opvQ
	(envelope-from <netdev+bounces-291814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:20:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B2D5D98FB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71C6B305635E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802D33B19B4;
	Tue, 26 May 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="VpE4wYZ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acAJ8ljW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1253AF64E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812016; cv=none; b=ByqNglOJ0HsBZ6zvBZDPu7xUocRvaVKu5XrqFyOWJ+9Shw33DV0+ReaiF5YhyDanMz/RANd7Vu6b2CA9PG8171m8QHopPC+FIOUo2bMyqDKnEkEKy5ckQnr8E3FOFdrgVkAZduYbVEjIH9Rf1bsaMsk9TLAyQlRQVt+8SoODqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812016; c=relaxed/simple;
	bh=IfRYUJ18K2JWvWKPVyPCjqsUXSSeCwSomAYBVGX4QFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr9MrV2kZnbe69Vc59nEBPD5D9OhlZoc3k0KUWiuPK0T722e8e7u5CwdR4Xb3WCR4kEgsBHM4Poejz9HYMmKDynWtgEpc9Q1a/UiVSWmagm0Tc+DoZjBqVOYxEKNC0HLijGX56lv4X9JjCj72qLVOtL+3M30Z8aF5ZolBo0/OE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=VpE4wYZ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acAJ8ljW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B9BD81D0005F;
	Tue, 26 May 2026 12:13:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 12:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779812013; x=
	1779898413; bh=jIIw7H3cIMDLSjqqyEb3M20xd6S/UgYIzZFlG/gVhj8=; b=V
	pE4wYZ41y0f9mCGp9DQXD2VzuC7EBDwwfai9j7S1vwKE6wjggaSBHNPgfoKk/qr4
	POlOMqzMa2SaCGkUT/j8oakiMJjrMKQyJqRjahXxHE/NMP8+0jzJABiSPjWEdpn0
	fDrgqbLWLPERmrQVRxNjCJg2hoWazM7VZUb0w4W384ZFNG1ROBnN7113OvDgEr3i
	nNsWOCPen5iPrnYfbk8jxpc4ag032jqwBxwjS2ZUFTdyw3poeuMZ5/LaT0pMTLLG
	YvC7SP8hd4nI3rmJs3e/KKJ6q9k8qJcV+0H1f/q9bbYIzsm+MogtAPcE7DSqVaeb
	r5BuNYG/b9hBIQpsrL9ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779812013; x=1779898413; bh=j
	IIw7H3cIMDLSjqqyEb3M20xd6S/UgYIzZFlG/gVhj8=; b=acAJ8ljWiaCwPaPMS
	gGPpvekZp4c589QK/55hkB4DVoGXqf1Ton51rNCZBrn2j9ShmoiBMB/Fq3SelO3S
	NH0+3b9AVsfj6ShPEYaQL7NIYRe6eXt+UCwdme9rdMjE/zD1YZZQwwkky2tMiSG4
	uKk8PQPKozwAdVRSY+FRU6FIZk6FJNdzE18yYEa9uZIwYMRlH+9S2+/K4+NbaCHW
	MAz5g4a/C2RrElyzD8b8xj3XxuUSnQXNu+gxyf/67z+qBOn6oiSQ0jf8Aa2PNBLU
	1ewBeOE6fXA9VOz6/emeJ+Uo0PNOIQQdqtr+VeH5qz7L40kMjVa3gYgSYNSFgQtq
	0dB3Q==
X-ME-Sender: <xms:rcYVaqYCmyFVYHCxdt-ETPoC8BM4WKhVkgxmNHhptRiCePWYEHeXVg>
    <xme:rcYVar6C79dPMTb8VFWPlGMa8qSwC9h748A93M-m8vSCxBcy_skb0SK83Jb_1Hj0g
    1QsrxfOY5wXq5bX0Ny18LZLUl4NLIaqKCAT24VtYyWURBlIV17S8cw>
X-ME-Received: <xmr:rcYVarx6leHyB1Rb4FWivQB55TviUtPQ8GSlV3idB1fVESe1whsWaQ4jjjqs6u4Y86zXk-F-VjuHctlInJ0v4pDP4AunUelxeKacgw>
X-ME-Proxy-Cause: dmFkZTE0RH9cXiMG1pYHOC2SB7Qybi5kX0FjzJz1NQfQy6q9Z0kW6E8qPZ8kCFWS0hduKX
    zad+S0K8q3yH0gSx8PXisJi7bkUqdKa8iSmdk+9Lttew7IB89CLkqQlPhprK3j//SJmQr3
    l6EsvqS9FZOzDRT0P94Ty/mef4xat2IDgtsdPKlGkJ/rl2o/cIF+t4oABxuccLKKHk3i8u
    c0Otcy65yk4mT7vuJFH+b5jM33WGMCgR5kPZv7hFQ1HX+Rj3GKtkHXxc8VmhKFYB+votkS
    0F7a5ENSLflCVcpVPvnHd1k4X1IrhbETOHnz9wRv8V5Y14hYgPZaZetjAkyRfoPAkElgfh
    5OxhbJwzYZzPqGXzIa/gErN3ScE/3cCCu+oFl3KH3rXQRcx5hoEnHXD0OBQkI5uDErU8fi
    UqeSO1H3+oN+7nob1wzJbs9MA7pkEiIVhJ1yxdE44VL7eUGUG+om3s9qaGY8s5GOT161Tr
    3jQGwZvusVM0MWfE6rqeh3haWOa7BB8KYzZtpOuE6xyksQO/pw51vmdEWXRJutSvcCT6Bu
    4aAmSaiaCICc3LCkyE/HTzK0YlZEhzGNhGS/Yke9uuhDMm+q5IVd8ech+jIAoCQS7yEhkp
    IIDZXUZOWCew5ikzHSTmLaCqhg6ImIH56vyU3qLWaIyQNVTxwZkczjXaSnRg
X-ME-Proxy: <xmx:rcYVasp1oFd6iBNInYyPS1Kch4-hevd7VLKo3vxl4bzcRP4yA4u7oA>
    <xmx:rcYVat3gXAsehkJ9dLcftt5LTbe7ucq1By0w0jtNJZBvQ9yykoNDMw>
    <xmx:rcYValDKhnZMFDxFLafgOGwTp9ue1DPoNFzgufIz3hp0k1oq4_zKbg>
    <xmx:rcYVauMJlVECAug4fJqYzTaKNqbwzXaav6vHo0Epb2v5j7Vbge2F4w>
    <xmx:rcYVah3DLB--sqW_SLk4UlYACagyE7k7Ia0Enxw6nxXIwRhLAOe7UWj2>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:32 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 09/11] vxlan: Enable BIG TCP packets
Date: Tue, 26 May 2026 18:11:58 +0200
Message-ID: <20260526161200.1135899-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161200.1135899-1-alice.kernel@fastmail.im>
References: <20260526161200.1135899-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,isovalent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: E9B2D5D98FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

In Cilium we do support BIG TCP, but so far the latter has only been
enabled for direct routing use-cases. A lot of users rely on Cilium
with vxlan/geneve tunneling though. The underlying kernel infra for
tunneling has not been supporting BIG TCP up to this point.

Given we do now, bump tso_max_size for vxlan netdevs up to GSO_MAX_SIZE
to allow the admin to use BIG TCP with vxlan tunnels.

BIG TCP on vxlan disabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    34440.00

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    30.00    55684.26

BIG TCP on vxlan enabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    39564.78

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    30.00    61466.47

When tunnel offloads are not enabled/exposed and we fully need to rely on
SW-based segmentation on transmit (e.g. in case of Azure) then the more
aggressive batching also has a visible effect. Below example was on the
same setup as with above benchmarks but with HW support disabled:

  # ethtool -k enp10s0f0np0 | grep udp
  tx-udp_tnl-segmentation: off
  tx-udp_tnl-csum-segmentation: off
  tx-udp-segmentation: off
  rx-udp_tunnel-port-offload: off
  rx-udp-gro-forwarding: off

  Before:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    60.00    21820.82

  After:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    60.00    29390.78

Example receive side:

  swapper       0 [002]  4712.645070: net:netif_receive_skb: dev=enp10s0f0np0 skbaddr=0xffff8f3b086e0200 len=129542
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe47dd __netif_receive_skb_list_core+0xed ([kernel.kallsyms])
        ffffffff8cfe4e52 netif_receive_skb_list_internal+0x1d2 ([kernel.kallsyms])
        ffffffff8d0210d8 gro_complete.constprop.0+0x108 ([kernel.kallsyms])
        ffffffff8d021724 dev_gro_receive+0x4e4 ([kernel.kallsyms])
        ffffffff8d021a99 gro_receive_skb+0x89 ([kernel.kallsyms])
        ffffffffc06edb71 mlx5e_handle_rx_cqe_mpwrq+0x131 ([kernel.kallsyms])
        ffffffffc06ee38a mlx5e_poll_rx_cq+0x9a ([kernel.kallsyms])
        ffffffffc06ef2c7 mlx5e_napi_poll+0x107 ([kernel.kallsyms])
        ffffffff8cfe586d __napi_poll+0x2d ([kernel.kallsyms])
        ffffffff8cfe5f8d net_rx_action+0x20d ([kernel.kallsyms])
        ffffffff8c35d252 handle_softirqs+0xe2 ([kernel.kallsyms])
        ffffffff8c35d556 __irq_exit_rcu+0xd6 ([kernel.kallsyms])
        ffffffff8c35d81e irq_exit_rcu+0xe ([kernel.kallsyms])
        ffffffff8d2602b8 common_interrupt+0x98 ([kernel.kallsyms])
        ffffffff8c000da7 asm_common_interrupt+0x27 ([kernel.kallsyms])
        ffffffff8d2645c5 cpuidle_enter_state+0xd5 ([kernel.kallsyms])
        ffffffff8cf6358e cpuidle_enter+0x2e ([kernel.kallsyms])
        ffffffff8c3ba932 call_cpuidle+0x22 ([kernel.kallsyms])
        ffffffff8c3bfb5e do_idle+0x1ce ([kernel.kallsyms])
        ffffffff8c3bfd79 cpu_startup_entry+0x29 ([kernel.kallsyms])
        ffffffff8c30a6c2 start_secondary+0x112 ([kernel.kallsyms])
        ffffffff8c2c142d common_startup_64+0x13e ([kernel.kallsyms])

Example transmit side:

  swapper       0 [005]  4768.021375: net:net_dev_xmit: dev=enp10s0f0np0 skbaddr=0xffff8af32ebe1200 len=129556 rc=0
        ffffffffa75e19c3 dev_hard_start_xmit+0x173 ([kernel.kallsyms])
        ffffffffa75e19c3 dev_hard_start_xmit+0x173 ([kernel.kallsyms])
        ffffffffa7653823 sch_direct_xmit+0x143 ([kernel.kallsyms])
        ffffffffa75e2780 __dev_queue_xmit+0xc70 ([kernel.kallsyms])
        ffffffffa76a1205 ip_finish_output2+0x265 ([kernel.kallsyms])
        ffffffffa76a1577 __ip_finish_output+0x87 ([kernel.kallsyms])
        ffffffffa76a165b ip_finish_output+0x2b ([kernel.kallsyms])
        ffffffffa76a179e ip_output+0x5e ([kernel.kallsyms])
        ffffffffa76a19d5 ip_local_out+0x35 ([kernel.kallsyms])
        ffffffffa770d0e5 iptunnel_xmit+0x185 ([kernel.kallsyms])
        ffffffffc179634e nf_nat_used_tuple_new.cold+0x1129 ([kernel.kallsyms])
        ffffffffc17a7301 vxlan_xmit_one+0xc21 ([kernel.kallsyms])
        ffffffffc17a80a2 vxlan_xmit+0x4a2 ([kernel.kallsyms])
        ffffffffa75e18af dev_hard_start_xmit+0x5f ([kernel.kallsyms])
        ffffffffa75e1d3f __dev_queue_xmit+0x22f ([kernel.kallsyms])
        ffffffffa76a1205 ip_finish_output2+0x265 ([kernel.kallsyms])
        ffffffffa76a1577 __ip_finish_output+0x87 ([kernel.kallsyms])
        ffffffffa76a165b ip_finish_output+0x2b ([kernel.kallsyms])
        ffffffffa76a179e ip_output+0x5e ([kernel.kallsyms])
        ffffffffa76a1de2 __ip_queue_xmit+0x1b2 ([kernel.kallsyms])
        ffffffffa76a2135 ip_queue_xmit+0x15 ([kernel.kallsyms])
        ffffffffa76c70a2 __tcp_transmit_skb+0x522 ([kernel.kallsyms])
        ffffffffa76c931a tcp_write_xmit+0x65a ([kernel.kallsyms])
        ffffffffa76cb42e tcp_tsq_write+0x5e ([kernel.kallsyms])
        ffffffffa76cb7ef tcp_tasklet_func+0x10f ([kernel.kallsyms])
        ffffffffa695d9f7 tasklet_action_common+0x107 ([kernel.kallsyms])
        ffffffffa695db99 tasklet_action+0x29 ([kernel.kallsyms])
        ffffffffa695d252 handle_softirqs+0xe2 ([kernel.kallsyms])
        ffffffffa695d556 __irq_exit_rcu+0xd6 ([kernel.kallsyms])
        ffffffffa695d81e irq_exit_rcu+0xe ([kernel.kallsyms])
        ffffffffa78602b8 common_interrupt+0x98 ([kernel.kallsyms])
        ffffffffa6600da7 asm_common_interrupt+0x27 ([kernel.kallsyms])
        ffffffffa78645c5 cpuidle_enter_state+0xd5 ([kernel.kallsyms])
        ffffffffa756358e cpuidle_enter+0x2e ([kernel.kallsyms])
        ffffffffa69ba932 call_cpuidle+0x22 ([kernel.kallsyms])
        ffffffffa69bfb5e do_idle+0x1ce ([kernel.kallsyms])
        ffffffffa69bfd79 cpu_startup_entry+0x29 ([kernel.kallsyms])
        ffffffffa690a6c2 start_secondary+0x112 ([kernel.kallsyms])
        ffffffffa68c142d common_startup_64+0x13e ([kernel.kallsyms])

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8c3885665b58..2132838d9f96 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3370,6 +3370,8 @@ static void vxlan_setup(struct net_device *dev)
 	dev->mangleid_features = NETIF_F_GSO_PARTIAL;
 
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->change_proto_down = true;
 	dev->lltx = true;
-- 
2.54.0


