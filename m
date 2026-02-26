Return-Path: <netdev+bounces-261579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA72AleqoGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC11AEFE8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 847D43016895
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE5A372B3A;
	Thu, 26 Feb 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="acrOvih2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAtgt576"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6F44DB92
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137033; cv=none; b=TxbBRn77uenAhfsXweI68H8LyqJ19w6l1sckE7g8ylRA8EGmOBeIVgIUzWTGV1A5WApn34wwVFem4ZN2g6606nHmNATqaoXvHs842s/VJ8xo68VpXgTsuBLsZ16NCyPKUhPMQcTszNaMjxr3sH122zgeWdCw63CutsOfw5YGIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137033; c=relaxed/simple;
	bh=fM7l+MO8amB0EefJlkmVqdOmzn8IczjISZ5XTq8/EdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU8po6Zs+Gf0i+70M+5IE+TRHBy4HGCArvDNaoVQaynhPVCAcRNl0ytmkh2+v0hhPMOp2lzdyjB8bBq9X8fR4X2t7Km3yst9nd9X6mWwYTVglfs6ty8tevcNZQgnyIP++Hw6GIRzOZmmpg1QpAxqANWX5RWUWa96AxXKZxlL9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=acrOvih2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAtgt576; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FF951D000C0;
	Thu, 26 Feb 2026 15:17:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 26 Feb 2026 15:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137030; x=
	1772223430; bh=Ze4FBmVKitJ5jmo6cETE9SUFxeicm46wavScECT9NbM=; b=a
	crOvih2MKcIyF4Pg0YIVg1lG2/mHwamf0lSepknO/mJkihhUUPmo9gnhYY7OpWuH
	8p+fRjDc+O42zh8H9EbVz5342b4IMQ8YNezmiUo8GEkyv9FjTb1nvaGnH7/nP1v6
	4HS26wqjH+CsSp6MDJXvVXo8M9N8+0pmjoOXCIusOo9tM63/UdGsPwiryoE/LhoD
	P0WiAg5DG5WeHogdkHVluCvJglzeHOutzIBmVv3o1DtHqkdmss6QWWf/+8Uno28Q
	qYKtvCnny5Km7RPPDJKoqQNPRNQj+td/Tsucmgf4DcqE3qc5q43CM3eu8tixq8d1
	8HrfYwrGkhNpfvp4KV9Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137030; x=1772223430; bh=Z
	e4FBmVKitJ5jmo6cETE9SUFxeicm46wavScECT9NbM=; b=PAtgt576bexKekMaf
	7Y34Mbtr/GqQDOzi2DXslIbri+T/QABQD1F5uKsAgni8sSHLh7sdfPYTURpdxvgF
	ZEIryzINpnsdH+gHk05y0dzr3/HvBa2ZSmNTFVJMAB2RTckmmtLYrlo8B9E5DTJC
	F4aMlNkR1Pcw+ReI71LvFk8pfYicV7yOlgQ4N9TJHEzYZa60ykwvE3sjPMxy2RP7
	o7iJqRhDjsswZ0WeOOLASTZoJBZUd0LnncDj2cWtgoJdsfTsaOORmXQxtodlYhGx
	yShe7SIsP/qDdwbrVf7utstOvcV3q+wYutCN40NC/b0VdBKLxibqUWIqhS+6hiLw
	zGEQA==
X-ME-Sender: <xms:RqqgaZA3mmFgwk2_MyTxCcS6marUK3FJotjg-jhJSK4yB4eb9SjFPg>
    <xme:RqqgaX97_2hhXryu2SAAoooZwetdyfVEF5IyCRLo-soplyw7HLehnReIWp7LOK78n
    rxuzR2DttMaKv3wR5AtvpYeLIMK1-7bIX3tJ9Qw5GF_zzKjcNYsVtBS>
X-ME-Received: <xmr:RqqgaUUfs5lZZZ7OaSnLcuTl9pi3sg29kOxdT1Sqr8TTxtYd5pdaa4UN1zlWEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:RqqgaQIeil_MDA3QwOtfSafhd3i3Ox0uHSMTR2d0SYQExZqfAeyuaw>
    <xmx:RqqgaYCdR0UGv9_y53Il6hnrywHfIbLvJiwaQvHcBkWir_bffaLO0g>
    <xmx:RqqgaQFvsryNVX4uO7dThM2j5rAwWLX9fraT-CwZGYpD0R5BxDE55A>
    <xmx:RqqgaVKx8e41DQOu_8HxSgEqROKOfRzIENxZAoN11jhNmULMq2PMDQ>
    <xmx:RqqgaXcRe7tZmRgX_XmfzyWyxwGEwWp19KVLLuJafcpanmyUvhJpHYqJ>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:17:09 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v2 11/12] geneve: Enable BIG TCP packets
Date: Thu, 26 Feb 2026 22:15:59 +0200
Message-ID: <20260226201600.222044-12-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226201600.222044-1-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261579-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: C6CC11AEFE8
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

From: Daniel Borkmann <daniel@iogearbox.net>

In Cilium we do support BIG TCP, but so far the latter has only been
enabled for direct routing use-cases. A lot of users rely on Cilium
with vxlan/geneve tunneling though. The underlying kernel infra for
tunneling has not been supporting BIG TCP up to this point.

Given we do now, bump tso_max_size for geneve netdevs up to GSO_MAX_SIZE
to allow the admin to use BIG TCP with geneve tunnels.

BIG TCP on geneve disabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    37391.34

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    60.00    58030.19

BIG TCP on geneve enabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    40891.57

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    60.00    61458.39

Example receive side:

  swapper       0 [008]  3682.509996: net:netif_receive_skb: dev=geneve0 skbaddr=0xffff8f3b0a781800 len=129492
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe47dd __netif_receive_skb_list_core+0xed ([kernel.kallsyms])
        ffffffff8cfe4e52 netif_receive_skb_list_internal+0x1d2 ([kernel.kallsyms])
        ffffffff8cfe573c napi_complete_done+0x7c ([kernel.kallsyms])
        ffffffff8d046c23 gro_cell_poll+0x83 ([kernel.kallsyms])
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

  swapper       0 [002]  3403.688687: net:net_dev_xmit: dev=enp10s0f0np0 skbaddr=0xffff8af31d104ae8 len=129556 rc=0
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
        ffffffffc179d3e0 geneve_xmit+0x920 ([kernel.kallsyms])
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
        ffffffffa76ca3b9 __tcp_push_pending_frames+0x39 ([kernel.kallsyms])
        ffffffffa76c1fb6 tcp_rcv_established+0x276 ([kernel.kallsyms])
        ffffffffa76d3957 tcp_v4_do_rcv+0x157 ([kernel.kallsyms])
        ffffffffa76d6053 tcp_v4_rcv+0x1243 ([kernel.kallsyms])
        ffffffffa769b8ea ip_protocol_deliver_rcu+0x2a ([kernel.kallsyms])
        ffffffffa769bab7 ip_local_deliver_finish+0x77 ([kernel.kallsyms])
        ffffffffa769bb4d ip_local_deliver+0x6d ([kernel.kallsyms])
        ffffffffa769abe7 ip_sublist_rcv_finish+0x37 ([kernel.kallsyms])
        ffffffffa769b713 ip_sublist_rcv+0x173 ([kernel.kallsyms])
        ffffffffa769bde2 ip_list_rcv+0x102 ([kernel.kallsyms])
        ffffffffa75e4868 __netif_receive_skb_list_core+0x178 ([kernel.kallsyms])
        ffffffffa75e4e52 netif_receive_skb_list_internal+0x1d2 ([kernel.kallsyms])
        ffffffffa75e573c napi_complete_done+0x7c ([kernel.kallsyms])
        ffffffffa7646c23 gro_cell_poll+0x83 ([kernel.kallsyms])
        ffffffffa75e586d __napi_poll+0x2d ([kernel.kallsyms])
        ffffffffa75e5f8d net_rx_action+0x20d ([kernel.kallsyms])
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

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: Alice Mikityanska <alice@isovalent.com>
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/geneve.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 5aa5c0e81b12..c92af9b6171f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1700,6 +1700,8 @@ static void geneve_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - GENEVE_BASE_HLEN - dev->hard_header_len;
 
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	dev->lltx = true;
-- 
2.52.0


