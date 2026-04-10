Return-Path: <netdev+bounces-277442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NQnMeUS2Wl+lggAu9opvQ
	(envelope-from <netdev+bounces-277442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:10:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912543D8FE4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E880C30157E1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D03D6CBD;
	Fri, 10 Apr 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="HO8YGnIU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tD1XBIVZ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204634B410
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833804; cv=none; b=paIboFFnfgq00HmztxWocIACGMwhhFyIsP2laXlICeMIEC5wiKBy6FEGs/DjJmVL5tCm60yi8dDhCWyejWCJS6iTnyzECTnXJWACg6RzXHNQtGNrRBzShUvr8wCvJFdKx69Buop/ElOBSkDjcYedTcK5Fr2w+vur3CtepAvtnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833804; c=relaxed/simple;
	bh=51HjXdtzuGGf0zsJVC5SryR7v9BB7+/xmWCLvR6NhcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPZUUlib4FGzbwsgIERcZjiKnDp0i06iwspWWx7l74U57RtdlVYv8RQo+MeFUqi87UBBcZVFZxPKW+VT0y6RjVFBVTtglEvxDudydwaeZ8Js2rasSf7jJjq0mDZrIEwpH4TRELXx9PhZKQ/ojznlVvxRoqk16SVyJ3kJ5oP/AGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=HO8YGnIU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tD1XBIVZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 66015EC042C;
	Fri, 10 Apr 2026 11:10:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 11:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1775833801; x=1775920201; bh=khxbtJl3UOgB7yrC3pJFr
	N2wpLv6ngOkDoy15QIehKI=; b=HO8YGnIU5nh7Pu/DLAQKOPTPSwb5gLzt5OE+e
	S/nRRMMdge7dKOTa/ktF2wAuxF3aUW8sEAiSUBj29oZ5r9mc3yraejK1NUVtmQZh
	rITvon/vA/J5j3VJFiSrN19KDlSuWj5ZtpG0mYyBk/Yztqa4z8J2HKX/YOyA3M7z
	T8n72wdAgjpBSa33tAKpS81B9Fk4/caEkIsOHr/Xfc0EI+Dm9qFGKRC6r1Txy0fw
	zXGcVyJ3v9RJPm8FlYr8enn7XY/cUDINPndeVH8D16ouAEuTJJ5IWQwngd/o/b/r
	r/QaFcav1Da52BizsZksX4isd806MW00/ay9EZS2b54qnypXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775833801; x=1775920201; bh=khxbtJl3UOgB7yrC3pJFrN2wpLv6ngOkDoy
	15QIehKI=; b=tD1XBIVZKKbUYVBjoC/izYEyfiitoekefQo3g22eC6ftdrXbUNf
	zNw7IEYSbpLsOamGfElAK/f1u/MqfWmNJUZ3Xph3aw4VhP605wbZD52d3vcblVMi
	TLieQYobpFw51edrcYTLXqJoc2WP6AcFKEBdM0JGM9ol8jS14Bjs//+5MVAGtVQ/
	5UnSAukwHL6ynZOicOdd2ky9cmbZ6/PEUJmUPKsI5BYu2VA6Wb9ALdfCMHbXsHRl
	Nmxa83cBXl+6hcPzxQ7JikGd+NEYf1+jUDIW8WIILhIrDTkbGdbX0xbn0VrxWiyk
	VUP7+z08y44v1gGnZ1QJQ6s5ryXE6Lb5hkg==
X-ME-Sender: <xms:yBLZaenjr30g7dvkoeGpW0Sn_g0khYauRE7THFiCeaYF2pAFKTklDg>
    <xme:yBLZaWTTHedLU6jmDfaeQVSuEqd6aytHGiNBzr4eLsxZXKUU2bw8ioqO4XIjIrvXl
    TUNMuJXpl37m6YvWkVUo8-FguYX4HFYd7Ym2zM9DkkrB6Iccmaiuw>
X-ME-Received: <xmr:yBLZacZJsizwlDdQIKkDzj98S6K-L5Hs-9zJuSaIuG0ujcxpAYKANgQLQtqYgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfoihhk
    ihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmqe
    enucggtffrrghtthgvrhhnpeehudeivdeifeffudeuleegheeuhfelkeeuffefieehuefh
    teejtdevffefgfefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgdrkhgvrhhn
    vghlsehfrghsthhmrghilhdrihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpth
    htoheplhhutghivghnrdigihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhl
    vghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhope
    gushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgr
    tghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:yBLZae8cS0PDYf3hLDXX2hesPhfrEpw6W41ayTNuX3d3fbqpGcGQOA>
    <xmx:yBLZaWkW-Ss-BcmmwZFavoGPDlMO-C8ygpHdbVwRhwsxB-n-LmT73A>
    <xmx:yBLZaTZAsO0GlGrMsvEmmx47tgnxyC8EJtSvIgB9hZ79XeeZE3PHGQ>
    <xmx:yBLZaeNi1advZmMaGPgPBEPnyV6nLGO7EmKk9fCW9Y8FkfAF78KEMA>
    <xmx:yRLZacSyToe9mQ5bMnoSoOM9i-gctk8xfzsSIN1aTqSlsO1DgF7dDTlv>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:09:59 -0400 (EDT)
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
Subject: [PATCH net-next v3 00/12] BIG TCP for UDP tunnels
Date: Fri, 10 Apr 2026 18:09:31 +0300
Message-ID: <20260410150943.993350-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277442-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Queue-Id: 912543D8FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v3 changes: Fixed the redirect in the selftest, rebased over my L2TP fix
[1] for the syzbot report [2].

[1]: https://lore.kernel.org/netdev/20260403174949.843941-1-alice.kernel@fastmail.im/
[2]: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/

v2: https://lore.kernel.org/all/20260226201600.222044-1-alice.kernel@fastmail.im/

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
 net/netfilter/nf_conntrack_proto_udp.c        |  19 ++-
 net/netfilter/nf_log_syslog.c                 |   2 +-
 net/netfilter/nf_nat_helper.c                 |   2 +-
 net/psp/psp_main.c                            |   2 +-
 net/sched/act_csum.c                          |  12 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 145 ++++++++++++++++++
 53 files changed, 296 insertions(+), 112 deletions(-)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

-- 
2.53.0


