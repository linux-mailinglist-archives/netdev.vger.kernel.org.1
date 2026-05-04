Return-Path: <netdev+bounces-283874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIHnHPav+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBD44BFDF0
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E66E3042986
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FA3E022E;
	Mon,  4 May 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nfjSuRxY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D013DE455;
	Mon,  4 May 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904686; cv=none; b=LMWtYuEffnN8EkSNsqUJ5scZdAIPPtf2hfARmDk0WtjXzNWjj0BPofqtV+EX1t0xDB0BumaDA2WTq9qql6z5vMYfGTgSLmbgyF2vkJHFS9vBYzmHPz5GapHK9P8zJZ4TvU450GJzzmCUU20YGdd8ufFtDEXJX2XsfcwHpKvy7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904686; c=relaxed/simple;
	bh=71Xurdx5vJpihuHuZwJGTYt1cBFho/ZdMoBdcPlU5wk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=t17llM0gkbkK6ty4saFln0hHnug8bEE/vUm00s9BZ83xQ4ZyOQp4F2KKmuhq1YWc8E7JdaSvMDNTyPq80GLaM0e/AJJgcxnbZ0yyBNWp6tGjhjdK37zmYCMOsdRkCJyR0dHc5uZmguiNIwET3JJmNATlRxCOzpLGsL/6ChN0BOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nfjSuRxY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777904685; x=1809440685;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=71Xurdx5vJpihuHuZwJGTYt1cBFho/ZdMoBdcPlU5wk=;
  b=nfjSuRxYNB51gYAFHH+TJsFDFTyQpcOZJNUIuDDwVwwJMuO80BqHRPmj
   1Wvu9DY0zN6OT30ZGfCHJoVXGOiwnS96ya4v0WStd+oqj9hu6Y6ZCVIr9
   c8+zXW3Dq/dbsv+UAECzg17BCAEa+K9jXdfAwjoXNIP147KJjE0UPsQC0
   TS5qop57jQUF4sQJIque5+43PxU0ESZHiObKsfHIO355N6pwOBE3+LFmp
   Ol5Kqr2zPN6MLh3Y7SzhUi2KBlmTB0BWkJmZ2KqpCG62n/KJJMLsfalYD
   cU/bgqnWTS902hcX3Givog/jkpTp4lEpmBS+lY8OLdx3wp3k5jju6IjTg
   w==;
X-CSE-ConnectionGUID: wzRnnTf3QRmZCQDuK+CT3A==
X-CSE-MsgGUID: EbI6GhoXR4a3VIlKBuhfkw==
X-IronPort-AV: E=Sophos;i="6.23,215,1770620400"; 
   d="scan'208";a="56221181"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:23:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 4 May 2026 07:23:35 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 4 May 2026 07:23:31 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v3 00/13] net: lan966x: add support for PCIe FDMA
Date: Mon, 4 May 2026 16:23:13 +0200
Message-ID: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANKr+GkC/23NQQ7CIBAF0KsY1mIoUNK68h7GBYXBTmKhgYbUN
 L27BBcm6vLnz3+zkQQRIZHzYSMRMiYMvgRxPBAzan8HirZkwhlXTDSCPrTvlVrpbJA6O2naS7C
 yay0XTpMymyM4XCt5JR4W6mFdyK00I6YlxGf9lZvav1nOftncUEbBtdIM/cCMHC4TmhjMiPPJh
 KmCmX8Qybs/CC+IFWCUAqbK3Tey7/sL+ipiywMBAAA=
X-Change-ID: 20260313-lan966x-pci-fdma-94ed485d23fa
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: DBBD44BFDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283874-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When lan966x operates as a PCIe endpoint, the driver currently uses
register-based I/O for frame injection and extraction. This approach is
functional but slow, topping out at around 33 Mbps on an Intel x86 host
with a lan966x PCIe card.

This series adds FDMA (Frame DMA) support for the PCIe path. When
operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
directly access host memory, so DMA buffers are allocated as contiguous
coherent memory and mapped through the PCIe Address Translation Unit
(ATU). The ATU provides outbound windows that translate internal FDMA
addresses to PCIe bus addresses, allowing the FDMA engine to read and
write host memory. Because the ATU requires contiguous address regions,
page_pool and normal per-page DMA mappings cannot be used. Instead,
frames are transferred using memcpy between the ATU-mapped buffers and
the network stack. With this, throughput increases from ~33 Mbps to
~620 Mbps for default MTU.

Patch 1 adds the shared drivers/net/ethernet/microchip/fdma/ directory
to the Sparx5 SoC MAINTAINERS entry.

Patches 2-3 prepare the shared FDMA library: patch 2 renames the
contiguous dataptr helpers for clarity, and patch 3 adds PCIe ATU
region management and coherent DMA allocation with ATU mapping.

Patches 4-6 refactor the lan966x FDMA code to support both platform
and PCIe paths: extracting the LLP register write into a helper,
exporting shared functions, and introducing an ops dispatch table
selected at probe time.

Patches 7-8 harden the existing FDMA path for the PCIe endpoint
lifecycle: patch 7 clears latched FDMA error/interrupt stickies after
the switch reset so they don't assert as soon as interrupts are
enabled, and patch 8 adds a shutdown() callback that quiesces the
FDMA engine on host warm reboot (on the PCIe card the FDMA survives
host reset and would otherwise keep the shared INTx asserted into
the next probe).

Patch 9 adds the core PCIe FDMA implementation with RX/TX using
contiguous ATU-mapped buffers. Patches 10 and 11 extend it with MTU
change and XDP support respectively. XDP_PASS, XDP_TX, XDP_DROP and
XDP_ABORTED are supported; XDP_REDIRECT is deliberately not, because
the PCIe data path does not use page_pool.

Patches 12-13 update the lan966x PCI device tree overlay to extend the
cpu register mapping to cover the ATU register space and add the FDMA
interrupt.

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Steen Hegelund <steen.hegelund@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Herve Codina <herve.codina@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v3:

Version 3 fixes a number of issues reported by sashiko - mostly
hardening.

- Fix double use of XDP_PACKET_HEADROOM.
- Fix ERR_PTR persistence in fdma->atu_region and add missing
  NULL/ERR_PTR guard in fdma_pci_atu_region_unmap().
- Reject size <= 0 in fdma_pci_atu_region_map() and return
  -ENOSPC (was -ENOMEM) when no region is free.
- Introduce lan966x_fdma_pci_tx_size_fits() that accounts for
  XDP_PACKET_HEADROOM; use it from both xmit paths to keep
  bpf_xdp_adjust_tail from writing past the TX slot.
- Validate BLOCKL in rx_check_frame() (reject < IFH+FCS or
  > db_size) before it feeds memcpy/XDP sizes.
- READ_ONCE(port->xdp_prog) inside lan966x_xdp_pci_run() to close
  a TOCTOU on XDP detach that could deref NULL in
  bpf_prog_run_xdp().
- Strip IFH and FCS pre-XDP in rx_check_frame(). After BPF runs
  the driver cannot tell whether the tail was modified; drop the
  unconditional skb_pull/skb_trim in rx_get_frame().
- Account tx_bytes/tx_packets on XDP_TX success and tx_dropped on
  XDP_TX size reject.
- Add dma_wmb()/dma_rmb() around DCB status writes and reads in
  xmit, xmit_xdpf, and napi_poll.
- Collected Tested-by: Hervé Codina.
- Link to v2: https://lore.kernel.org/r/20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com

Changes in v2:

Version 2 primarily addresses issues with module unload/load, where
traffic would stop working (Hervé), and XDP head/tail adjust that would be
discarded (Mohsin).

Apart from that, I ran through issues reported by Sashiko, and fixed a
number of other issues.

- New patch 1: add drivers/net/ethernet/microchip/fdma/ to the Sparx5
  SoC MAINTAINERS entry.
- New patch 7: clear latched FDMA error/interrupt stickies after the
  switch reset so they don't fire as soon as interrupts are enabled.
- New patch 8: shutdown() callback, quiescing FDMA on host warm reboot.
- Replaced the depth-2 dev_is_pci(parent->parent) backend selector
  with a parent-chain walk.
- XDP: use xdp.data/xdp.data_end for the post-XDP frame length so that
  bpf_xdp_adjust_head/tail are respected (Mohsin Bashir)
- MTU change: drain in-flight xmits with netif_tx_disable() on every
  port before reallocating rings, waking them again on completion.
- MTU change: cap the PCIe DCB ring at 256 entries so a full-ring
  coherent DMA allocation fits in a single MAX_PAGE_ORDER block at
  jumbo MTU.
- PCIe ATU: disable the region before clearing its translation on
  unmap.
- PCIe FDMA: hold tx_lock in napi_poll around the free-DCB check used
  to wake stopped netdev queues.
- PCIe FDMA: return -ENOSPC (not -1) when the DCB ring is exhausted.
- Link to v1: https://lore.kernel.org/r/20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com

---
Daniel Machon (13):
      MAINTAINERS: add FDMA library to Sparx5 SoC entry
      net: microchip: fdma: rename contiguous dataptr helpers
      net: microchip: fdma: add PCIe ATU support
      net: lan966x: add FDMA LLP register write helper
      net: lan966x: export FDMA helpers for reuse
      net: lan966x: add FDMA ops dispatch for PCIe support
      net: lan966x: clear FDMA interrupt stickies after switch reset
      net: lan966x: add shutdown callback to stop FDMA on reboot
      net: lan966x: add PCIe FDMA support
      net: lan966x: add PCIe FDMA MTU change support
      net: lan966x: add PCIe FDMA XDP support
      misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space
      misc: lan966x-pci: dts: add fdma interrupt to overlay

 MAINTAINERS                                        |   1 +
 drivers/misc/lan966x_pci.dtso                      |   5 +-
 drivers/net/ethernet/microchip/fdma/Makefile       |   4 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c     |  33 ++
 drivers/net/ethernet/microchip/fdma/fdma_api.h     |  25 +-
 drivers/net/ethernet/microchip/fdma/fdma_pci.c     | 182 ++++++
 drivers/net/ethernet/microchip/fdma/fdma_pci.h     |  42 ++
 drivers/net/ethernet/microchip/lan966x/Makefile    |   4 +
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  51 +-
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 656 +++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  74 ++-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  45 ++
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |  25 +
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |  10 +
 14 files changed, 1117 insertions(+), 40 deletions(-)
---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260313-lan966x-pci-fdma-94ed485d23fa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


