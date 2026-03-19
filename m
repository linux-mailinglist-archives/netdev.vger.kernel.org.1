Return-Path: <netdev+bounces-269488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAbWLe8SvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:14:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5A2CD860
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84957307410C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C8938F249;
	Thu, 19 Mar 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="X27n+2TN"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149083E1D03;
	Thu, 19 Mar 2026 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933183; cv=none; b=nyBREf7ENhLrjs7veh1dPLOa+A+WwaYyrF1O9wkZUSYXYQK6pvLSRwdHOakKggU1AiK867JT6cNIHPzxL6O8PTwbcAHYsdtYn+gNMW8LhtagU7PImR8TOZtL+9zH+f/dcmMPwd6vcC0u6rkxdSQ/xf9jdomsOLXRupGyshoBLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933183; c=relaxed/simple;
	bh=l3knlpXWig35oAEjhacW8DPpo0HSc2FU1ReBB6WhSqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SO3eumcRUP5E/lTe2xuT7UhS8MJyOV7nZote5y4bKxFROTeSwbfFWVDHi662dbXwCwwDfTwN/ohGjP5SqsL7KEoz1Hb08sxuO7WezHeAsNSK+lwpWbfx2MaHuUpxs2Ny3y12LxZQuHpm1CLdq8mILM0x1F6oCNerYoZ+kSLpFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=X27n+2TN; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4fc8MN2Kj8zDvHQ;
	Thu, 19 Mar 2026 16:12:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LSYHq0fS9dsvJLw2Y1zqdx1x9YhuaA0toFBYHS+LrHs=;
	b=X27n+2TNlYpbPCA7V99KlvOsk8M+oDdn4fPK9ogUwlsMm+L47QRDlZpzykTVJAsnqVgwpY
	x34qX7oKLbqHDsDq1DXoh+77ShsPyv7md/D8uNhpJFpj8QCphRX6UfBX+cMC1CGKGqUJ3Y
	5UwyIVMCgO8AaTrKZ3j58DPAo774aT4DWtwhBqjekAsSrtrVkOVrsu8V4el6ElLa8qg7Ro
	wXqV3GFTcvTtS3J3WWP0amxTKNqsRyTzF8C1OBDO8baLgrmNaMVI8HlUw84GBCzFoIr7TW
	OLauzLdMp9zL0iS4AaVFAPLj1PN02KEaOcvf+jefhyuFuQsM6DoPYoYgzWiJag==
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Antonio Quartulli <antonio@mandelbit.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC net-next 00/15] Introducing ipxlat: a stateless IPv4/IPv6 translation device
Date: Thu, 19 Mar 2026 16:12:09 +0100
Message-ID: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269488-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18C5A2CD860
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

this RFC series introduces ipxlat, a virtual netdevice for stateless
packet translation between IPv6 and IPv4.

This stateless IP/ICMP translation (SIIT, RFC 7915) device is a building
block ultimately allowing suitably configured Linux systems to cover all
IPv6<>IPv4 connectivity scenarios outlined in RFC 6144, "Framework for
IPv4/IPv6 Translation".

While the packet translation function implemented in ipxlat itself is
stateless, building stateful NAT64 translators is easy in combination
with a sandwich of simple nft SNAT and MASQUERADE rules. Even SIIT-DC
(RFC 7755 / 7756) ER/BR functions including EAMT (RFC 7757) are thought
to be possible with suitable nft/iptables configuration, but this needs
further testing.

The series contains patches covering driver core, translation paths,
netlink API, selftests and documentation.

See Documentation/networking/ipxlat.rst for more details.


== Architecture ==

ipxlat sits at a boundary between two kernel models. It is exposed as a
netdevice, so it has device semantics such as MTU and netdev statistics.
However, most of its processing falls within protocol translation logic.
The implementation therefore uses netdevice hooks for integration and
lifecycle, while translation behavior follows RFC rules and reuses
existing IP stack helpers for routing, fragmentation and checksum
handling.

Feedback on the netdevice integration model is welcome, yet this series
intentionally keeps scope limited to a self-contained module to make
review and validation tractable.

ipxlat devices are created and destroyed via rtnl link operations.
Per-device translation parameters are configured through a generic
netlink family named ipxlat.

No generic networking core behavior is changed.


== RFCs ==

The ipxlat packet translation code considers:

- RFC 7915 - Stateless IP/ICMP translation (SIIT) behavior

- RFC 6052 - Address mapping for xlat-prefix sizes between /32 and /96

- RFC 6791 - Although we use standard ICMP source-address selection

- RFC 4884 - Translation painstakingly handles ICMP extensions

- RFC 5837 - Interface Information Objects from RFC 6791 are not
  implemented in this series and are planned as follow-up work


== Implementation ==

We enforce a strict processing contract: packet validation is done once,
then translation runs on that validated layout. When translation cannot
continue, the packet is either dropped or we switch to the ICMP error
emission path.

Control-plane updates are serialized, while the data path reads
configuration locklessly to keep per-packet overhead low.

During live reconfiguration, readers may transiently observe mixed old
and new values; this may cause a small number of packet drops while
configuration is being changed.

This tradeoff is intentional to keep the fast path simple and
lightweight.


== Selftests ==

Selftests are added under tools/testing/selftests/net/ipxlat and cover
ICMP, TCP and UDP translation in both directions, large-packet and
fragmentation-sensitive paths, ICMP error translation and PMTUD-related
emission paths.


== Points of Discussion ==

 - Tighter stack integration?


== Work Planned for v1 ==

 - icmp: Simplify FRAG_NEEDED / PKT_TOOBIG MTU calculation.

 - translation: Prevent skb loops without TTL/HLIM decrement?

 - netdevice: Decide on hardcoding MTU = 0xffff - $xlat_overhead

 - UDPv4 defrag and csum recalc for NAT64 (RFC 6146 Sec 3.4.) "For
   incoming IPv4 packets carrying UDP packets with a zero checksum ...
   MUST calculate the checksum"


== Acknowledgements ==

The ipxlat translation code is based on the Jool project in order to
benefit from years of accumulated experience and its golden-packet
test-suite.

Thanks to Jool's Principal Author, Alberto Leiva Popper, for developing
and maintaining Jool since IPv6 translation was last in-vogue and
writing the initial "joolif" netdevice prototype our work was able to
start from.

Thanks to NLnet's NGI0 Core Fund for supporting development of the
ipxlat driver.


Thanks for your review,

Ralf Lici
Mandelbit SRL

---

Daniel Gröber (1):
  Documentation: networking: add ipxlat translator guide

Ralf Lici (14):
  drivers/net: add ipxlat netdevice skeleton and build plumbing
  ipxlat: add RFC 6052 address conversion helpers
  ipxlat: add packet metadata control block helpers
  ipxlat: add IPv4 packet validation path
  ipxlat: add IPv6 packet validation path
  ipxlat: add transport checksum and offload helpers
  ipxlat: add 4to6 and 6to4 TCP/UDP translation helpers
  ipxlat: add translation engine and dispatch core
  ipxlat: emit translator-generated ICMP errors on drop
  ipxlat: add 4to6 pre-fragmentation path
  ipxlat: add ICMP informational translation paths
  ipxlat: add ICMP error translation and quoted-inner handling
  ipxlat: add netlink control plane and uapi
  selftests: net: add ipxlat coverage

 Documentation/netlink/specs/ipxlat.yaml       |  97 +++
 Documentation/networking/ipxlat.rst           | 190 +++++
 drivers/net/Kconfig                           |  13 +
 drivers/net/Makefile                          |   1 +
 drivers/net/ipxlat/Makefile                   |  17 +
 drivers/net/ipxlat/address.c                  | 132 ++++
 drivers/net/ipxlat/address.h                  |  59 ++
 drivers/net/ipxlat/dispatch.c                 | 263 ++++++
 drivers/net/ipxlat/dispatch.h                 |  78 ++
 drivers/net/ipxlat/icmp.h                     |  45 ++
 drivers/net/ipxlat/icmp_46.c                  | 552 +++++++++++++
 drivers/net/ipxlat/icmp_64.c                  | 531 +++++++++++++
 drivers/net/ipxlat/ipxlpriv.h                 |  53 ++
 drivers/net/ipxlat/main.c                     | 148 ++++
 drivers/net/ipxlat/main.h                     |  27 +
 drivers/net/ipxlat/netlink-gen.c              |  71 ++
 drivers/net/ipxlat/netlink-gen.h              |  31 +
 drivers/net/ipxlat/netlink.c                  | 348 ++++++++
 drivers/net/ipxlat/netlink.h                  |  27 +
 drivers/net/ipxlat/packet.c                   | 747 ++++++++++++++++++
 drivers/net/ipxlat/packet.h                   | 166 ++++
 drivers/net/ipxlat/translate_46.c             | 256 ++++++
 drivers/net/ipxlat/translate_46.h             |  84 ++
 drivers/net/ipxlat/translate_64.c             | 206 +++++
 drivers/net/ipxlat/translate_64.h             |  56 ++
 drivers/net/ipxlat/transport.c                | 401 ++++++++++
 drivers/net/ipxlat/transport.h                | 122 +++
 include/uapi/linux/ipxlat.h                   |  48 ++
 tools/testing/selftests/net/ipxlat/.gitignore |   1 +
 tools/testing/selftests/net/ipxlat/Makefile   |  25 +
 .../selftests/net/ipxlat/ipxlat_data.sh       |  70 ++
 .../selftests/net/ipxlat/ipxlat_frag.sh       |  70 ++
 .../selftests/net/ipxlat/ipxlat_icmp_err.sh   |  54 ++
 .../selftests/net/ipxlat/ipxlat_lib.sh        | 273 +++++++
 .../net/ipxlat/ipxlat_udp4_zero_csum_send.c   | 119 +++
 35 files changed, 5381 insertions(+)
 create mode 100644 Documentation/netlink/specs/ipxlat.yaml
 create mode 100644 Documentation/networking/ipxlat.rst
 create mode 100644 drivers/net/ipxlat/Makefile
 create mode 100644 drivers/net/ipxlat/address.c
 create mode 100644 drivers/net/ipxlat/address.h
 create mode 100644 drivers/net/ipxlat/dispatch.c
 create mode 100644 drivers/net/ipxlat/dispatch.h
 create mode 100644 drivers/net/ipxlat/icmp.h
 create mode 100644 drivers/net/ipxlat/icmp_46.c
 create mode 100644 drivers/net/ipxlat/icmp_64.c
 create mode 100644 drivers/net/ipxlat/ipxlpriv.h
 create mode 100644 drivers/net/ipxlat/main.c
 create mode 100644 drivers/net/ipxlat/main.h
 create mode 100644 drivers/net/ipxlat/netlink-gen.c
 create mode 100644 drivers/net/ipxlat/netlink-gen.h
 create mode 100644 drivers/net/ipxlat/netlink.c
 create mode 100644 drivers/net/ipxlat/netlink.h
 create mode 100644 drivers/net/ipxlat/packet.c
 create mode 100644 drivers/net/ipxlat/packet.h
 create mode 100644 drivers/net/ipxlat/translate_46.c
 create mode 100644 drivers/net/ipxlat/translate_46.h
 create mode 100644 drivers/net/ipxlat/translate_64.c
 create mode 100644 drivers/net/ipxlat/translate_64.h
 create mode 100644 drivers/net/ipxlat/transport.c
 create mode 100644 drivers/net/ipxlat/transport.h
 create mode 100644 include/uapi/linux/ipxlat.h
 create mode 100644 tools/testing/selftests/net/ipxlat/.gitignore
 create mode 100644 tools/testing/selftests/net/ipxlat/Makefile
 create mode 100755 tools/testing/selftests/net/ipxlat/ipxlat_data.sh
 create mode 100755 tools/testing/selftests/net/ipxlat/ipxlat_frag.sh
 create mode 100755 tools/testing/selftests/net/ipxlat/ipxlat_icmp_err.sh
 create mode 100644 tools/testing/selftests/net/ipxlat/ipxlat_lib.sh
 create mode 100644 tools/testing/selftests/net/ipxlat/ipxlat_udp4_zero_csum_send.c

-- 
2.53.0


