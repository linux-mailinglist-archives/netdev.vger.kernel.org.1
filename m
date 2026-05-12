Return-Path: <netdev+bounces-287239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPjiIvBcA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:01:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D67525534
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82C883061E9B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3003CDBDB;
	Tue, 12 May 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="fMtGmMav";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONO7192j"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE523C416B
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605077; cv=none; b=W/ql16mrfAKD0LYFOgbhW8sds+RYYVPCnh/7tGluEVvWtDdcWcKY+PVcfCtpkdcqUrXlr1vjel2757/W5YwE1a2zmHIF8a0QjUVWwU+NjeXFWdXpXaRKXOQ5hmL0wN6v39nEcso/pfHXfIZMXE4Kbw/nO7j8/q/JiDgk7NnMcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605077; c=relaxed/simple;
	bh=y3/J5IiYgtXjDj2kJmMop3V1kZxt0TxttP+HBcvK1us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIwa4pOSGgjY1m/YY1bTcC+ELZ48niVzMv26bEOnXMg9/euszQIeI3qSx0/eNFD/85d2AcSWmi9w+8fGLu+c65xQ7CAgtjHtcSFMbmw4RgHMbQxmofz7jXuRi6XP3Y3aipitZItgD2TLQVnD4FBTPhj3E+MgD60ayJmr6dGW5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=fMtGmMav; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONO7192j; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C7E02EC023D;
	Tue, 12 May 2026 12:57:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 12 May 2026 12:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1778605073; x=1778691473; bh=J+VkuR2izqlV3beZqVw7+
	qkVprYDnLIVVxZa1jQwSrE=; b=fMtGmMavp5hnOcZtAYp/j4KuS2SEJZNGxeOYX
	pvExl4o4sRcwI2MaZxUkdDFtqfLJV5da2HQDZkwaRjkYhW0fZwPeSIm2EGiIx1HJ
	ZR6R59W0UFosqQzoWkHYUfP+eZ66Ki/azgEfInKzYqphj1HKBD5NcnSu7bfiIkpz
	gfWFyNRw/Q7/aAIr3UxwEiEpZ/UVXkiQ3CKwJI+O4MYHrQI/c9NGwTbU/v26RQ7c
	mpymRgkhFLe77eGkw9RcIPPY+W12FBLAdKBUecqad+UgB3p5lpZ67Jq+A/A4rjx0
	fo4/q6J5N9Q4LbZ/E2+v63hzYuW5M+EsocCYK+wYUKOsJ5D9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778605073; x=1778691473; bh=J+VkuR2izqlV3beZqVw7+qkVprYDnLIVVxZ
	a1jQwSrE=; b=ONO7192jHOJH1wNXM5GLOSzmg+gNOzrcnwSo/FgsADU/v1PR83V
	XaNk1Oos4k8z2Xl5j/F7MKOQoCBIF84QMo/2V88U33Dl9b2LVkY8z/81j+wx5CV7
	9j2hQNvg8IkwswSRIsGdYGaE24PSqSjohFpSiS6S2z5vIafxWoEMnYm61sszkHcC
	EWCkNER83BSB33VFi/Jz8nPEUEQqnkemxQA1Yqul+wX8lu0pSZwhAeRtwMhe0BZT
	E3gnD38KjNTuF3I5MSwqcfsFpbcMjbwMtUpTCB0+B9Al9cn1D+ZKInP/i9WOEe8g
	Ytu7N5DCX+OHdkoWWjHf2USEmq8vx7k6pIA==
X-ME-Sender: <xms:EVwDaq0kSTuXbzGWlsrLP3Pce3mAv1hanTMyv-O5kNmtoCHeT44r1w>
    <xme:EVwDarlJGqro2KsEOd1EJKfgJfphMhnF276xjJkAHjrgexa3uJwovknERoUsTvXSg
    hidHnXodNsNylCNouhL3Q1xfnpbeYz28c_kuc5mLbzZUiTkxUyd>
X-ME-Received: <xmr:EVwDapu19eX36ab0z-ignGSq3zFk_cmEjT67Cgrs-it8M5R2mFRzMtzYXClsxEfJjQAyzWIKcI9-XCrhiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlihgtvgcuofhi
    khhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimh
    eqnecuggftrfgrthhtvghrnheptdeluefhhfehkefgkeehjeehhfeludeujefhkeegtefg
    leffveekvdefgefguddunecuffhomhgrihhnpehsrghshhhikhhordguvghvpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgspghrtghpth
    htohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhesihho
    ghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrd
    hnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrghilhdrtgho
    mhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepfihilhhlvghmsgesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EVwDar3gEVFKNtnZUwr2hXCC9RZXoMDdeJOQagqJCnRgXWgvYDRUYg>
    <xmx:EVwDalS8wXjuwvhYe_xnq3hrjsRgpf9YUJwGa_lzw5W3uFmTXjSapg>
    <xmx:EVwDavslWSvlzyfmrYKuYV_B1HogXvm0yGxo-Ipa0BVQgxEE3Zk_TA>
    <xmx:EVwDarKzJRm80P7URgItnhdvm_qd1PimQDFxqdN0n6ZLq4bBqlNJyg>
    <xmx:EVwDarBPrvFttEBwgvQOKFZvaEwDBidFGCf4jwY0KBpf5cNhPt701nK->
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:57:52 -0400 (EDT)
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
Subject: [PATCH net-next v4 00/12] BIG TCP for UDP tunnels
Date: Tue, 12 May 2026 18:56:36 +0200
Message-ID: <20260512165648.386518-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2D67525534
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-287239-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.934];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim,isovalent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
IPv6 BIG TCP doesn't require stripping the HBH in all various
combinations in tunneled traffic, adding BIG TCP becomes feasible.

Patches 01-03 are small fixups to some related code that I'm changing in
the series.

Patch 04 adds accessors for the length field in the UDP header, as
suggested by Paolo in review. The usage of udp_set_len is then added in
the following patches that start using length=0 in BIG TCP UDP packets.

Patches 05-07 close the gaps that prevent BIG TCP packets from going
through UDP tunnel code.

Patch 08 re-adds proper validation of malformed packets that arrive with
length=0 from the wire.

Patch 09 is for proper formatting in tcpdump (set UDP len to 0 rather
than a trimmed value on overflow).

Patches 10-11 bump up tso_max_size for VXLAN and GENEVE.

Patch 12 adds selftests.

Thanks all!

v4 changes: Rebased, addressed Sashiko AI review [1] and Willem's
comment about netperf flags.

My comments on Sashiko AI review per patch:

01: I'd prefer to keep the cases that I haven't tested outside of the
scope of this series, which is for VXLAN/GENEVE tunnels, not for ESP.

02: The patch doesn't have behavioral changes other than fixing the
checksum. The final uh->len assignment assigns the actual length, not
64k.

03: The check can't be loosened, because total_len is also assigned to
UDP length. BIG TCP works in the mode without GRO hint option.

04: Fixed the fallback value for udplen. BIG TCP is fine, it's the
uh->len = 0 case, uh->len can't exceed 64k.

05: In the BIG TCP case, partial GSO splits the SKB in two. If full
segmentation is needed, the SKB is split in many MSS-sized SKBs without
fragments.

06: Invalid packets from the wire are addressed in 08.

07: __udp_gso_segment only handles UDP GSO packets, which can't be
bigger than 64k. Kept udp_set_len_short in nf_nat_mangle_udp_packet, as
the function doesn't support BIG TCP packets anyway (see
mangle_contents).

08: udp_gro_receive handles packets before aggregation, there are no BIG
TCP packets at this point. RFC 768 doesn't say that padded UDP packets
are valid. Real jumbograms don't seem to be supported in this path
anyway.

09: The packet goes to skb_udp_tunnel_segment, not __udp_gso_segment.
__skb_udp_tunnel_segment handles this case.

12: Improved process cleanup by killing everything inside netns before
deleting them, and by avoiding killing netserver outside of netns.
netperf with -r in TCP_STREAM mode works, and the option has the
intended effect, but I replaced it with -m. Added dependency check for
tcpdump.

[1]: https://sashiko.dev/#/patchset/20260410150943.993350-1-alice.kernel%40fastmail.im

v3: https://lore.kernel.org/netdev/20260410150943.993350-1-alice.kernel@fastmail.im/

v3 changes: Fixed the redirect in the selftest, rebased over my L2TP fix
[2] for the syzbot report [3].

[2]: https://lore.kernel.org/netdev/20260403174949.843941-1-alice.kernel@fastmail.im/
[3]: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/

v2: https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/

v2 changes: Addressed the review comments: added UDP len helpers,
consolidated UDP len sanity checks in patch 08 into one, added
selftests. Added fixups to related code (patch 01-03).

v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/

Alice Mikityanska (11):
  net/sched: act_csum: don't mangle UDP tunnel GSO packets
  udp: gso: Simplify handling length in GSO_PARTIAL
  geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
  net: Use helpers to get/set UDP len tree-wide
  net: Enable BIG TCP with partial GSO
  udp: Support gro_ipv4_max_size > 65536
  udp: Support BIG TCP GSO packets where they can occur
  udp: Validate UDP length in udp_gro_receive
  udp: Set length in UDP header to 0 for big GSO packets
  vxlan: Enable BIG TCP packets
  selftests: net: Add a test for BIG TCP in UDP tunnels

Daniel Borkmann (1):
  geneve: Enable BIG TCP packets

 drivers/infiniband/core/lag.c                 |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |   4 +-
 drivers/net/amt.c                             |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   2 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
 drivers/net/ethernet/sfc/falcon/selftest.c    |   4 +-
 drivers/net/ethernet/sfc/selftest.c           |   4 +-
 drivers/net/ethernet/sfc/siena/selftest.c     |   4 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |   2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |   4 +-
 drivers/net/geneve.c                          |   6 +-
 drivers/net/netdevsim/dev.c                   |   2 +-
 drivers/net/netdevsim/psample.c               |   2 +-
 drivers/net/netdevsim/psp.c                   |   8 +-
 drivers/net/vxlan/vxlan_core.c                |   2 +
 drivers/net/wireguard/receive.c               |   2 +-
 include/linux/udp.h                           |  16 ++
 include/trace/events/icmp.h                   |   2 +-
 lib/tests/blackhole_dev_kunit.c               |   2 +-
 net/6lowpan/nhc_udp.c                         |  10 +-
 net/core/netpoll.c                            |   2 +-
 net/core/pktgen.c                             |   4 +-
 net/core/selftests.c                          |   4 +-
 net/core/skbuff.c                             |  10 +-
 net/core/tso.c                                |   3 +-
 net/ipv4/esp4.c                               |   2 +-
 net/ipv4/fou_core.c                           |   2 +-
 net/ipv4/ipconfig.c                           |   6 +-
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c   |   4 +-
 net/ipv4/route.c                              |   2 +-
 net/ipv4/udp.c                                |   8 +-
 net/ipv4/udp_offload.c                        |  58 +++----
 net/ipv4/udp_tunnel_core.c                    |   2 +-
 net/ipv6/esp6.c                               |   5 +-
 net/ipv6/fou6.c                               |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |   2 +-
 net/ipv6/udp.c                                |   3 +-
 net/ipv6/udp_offload.c                        |   2 +-
 net/l2tp/l2tp_core.c                          |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |   2 +-
 net/netfilter/nf_conntrack_proto_udp.c        |  17 +-
 net/netfilter/nf_log_syslog.c                 |   2 +-
 net/netfilter/nf_nat_helper.c                 |   2 +-
 net/psp/psp_main.c                            |   2 +-
 net/sched/act_csum.c                          |  12 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 151 ++++++++++++++++++
 53 files changed, 301 insertions(+), 111 deletions(-)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

-- 
2.54.0


