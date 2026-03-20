Return-Path: <netdev+bounces-269950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PFAFupivWlh9gIAu9opvQ
	(envelope-from <netdev+bounces-269950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:08:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A79122DC56C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27D23181919
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D253C9443;
	Fri, 20 Mar 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pmb4yejz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC233C873A;
	Fri, 20 Mar 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018909; cv=none; b=Lsl7MJhY7V2R53/Yz1puWaz1maPW2uF4wSpN27RnuBWsNu8Zj+U73VZixacstUU+IvIspfiDcm4RiNFNQpSX8bYttQ67TOVpVvWC/itP+r7KPAkQEibFABrc2qp1Id5kCu87iaVoaPhlGC71d1prGRvk2Mfjx7jxpV1O+joBbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018909; c=relaxed/simple;
	bh=jbnrcWLoBn3dGdV/EgPjDBdGByhNdGn4Lcus/kv5WsU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IUPNA64pIx4VUbWjAm2vhkh2VV/HIrXJ1fx4Dec/MEa7lmjngp7ZQdMNzEvz22tov7aSs7ORQ8mJ3t3AXVDYWByve4m+DwAtbGy94jDUnbgYcD10GFzhBDSiqxLbo5DUkuc1TfLr27McZHzpSR86cnMAT7Dw8v+mO3aUSA7//+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pmb4yejz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774018908; x=1805554908;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=jbnrcWLoBn3dGdV/EgPjDBdGByhNdGn4Lcus/kv5WsU=;
  b=Pmb4yejzlclhOgqFYpOFCd1OuUYvv3ImHq7WuLZkXT/re1XFcW2HtpT1
   CJ82n5AoMbSoYQK0P0ELXAne8l9VNAR4bAMhv6+BD71++PMqbiZJH+dk3
   r2YSLkergkAQZuywxf+/8e/DAscux10LjJ7mbuuOR88lLFzXsRj5LVzVC
   aXTOTAsSP8+AQ4GlW3HJdgIH8+l3FKYrdcCVNHDzuYvF0D9peaOcEuUAg
   mdshzdH0D/wPPfyEKxoDU10xG+C98Zz93Bz+j8viyIkzRPCUWYTu8yetU
   9JL5KO+zphE80pNc1wPj4RjyQJZ/Q69v8P2ZoqbaqDxpwmhDG1JY9xCI+
   g==;
X-CSE-ConnectionGUID: uoQg81OiQ1aIAKaIXuNqaA==
X-CSE-MsgGUID: qsVcPzyQSBmHUJUdcLsjWw==
X-IronPort-AV: E=Sophos;i="6.23,130,1770620400"; 
   d="scan'208";a="54967825"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2026 08:01:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 20 Mar 2026 08:01:16 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 20 Mar 2026 08:01:13 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Date: Fri, 20 Mar 2026 16:00:56 +0100
Message-ID: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChhvWkC/x3MQQqAIBBA0avErBsoLamuEi0kxxqoKTRCiO6et
 HyL/x+IFJgiDMUDgW6OfEhGXRYwr1YWQnbZoCplKl1r3Kz0xiQ8Z0bvdot9Q67pWqe0t5CzM5D
 n9C9HELpQKF0wve8HPKHrymwAAAA=
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
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A79122DC56C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
the network stack. With this, throughput increases from ~33 Mbps to ~620
Mbps for default MTU.

Patches 1-2 prepare the shared FDMA library: patch 1 renames the
contiguous dataptr helpers for clarity, and patch 2 adds PCIe ATU region
management and coherent DMA allocation with ATU mapping.

Patches 3-5 refactor the lan966x FDMA code to support both platform and
PCIe paths: extracting the LLP register write into a helper, exporting
shared functions, and introducing an ops dispatch table selected at
probe time.

Patch 6 adds the core PCIe FDMA implementation with RX/TX using
contiguous ATU-mapped buffers. Patches 7 and 8 extend it with MTU
change and XDP support respectively.

Patches 9-10 update the lan966x PCI device tree overlay to extend the
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
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (10):
      net: microchip: fdma: rename contiguous dataptr helpers
      net: microchip: fdma: add PCIe ATU support
      net: lan966x: add FDMA LLP register write helper
      net: lan966x: export FDMA helpers for reuse
      net: lan966x: add FDMA ops dispatch for PCIe support
      net: lan966x: add PCIe FDMA support
      net: lan966x: add PCIe FDMA MTU change support
      net: lan966x: add PCIe FDMA XDP support
      misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space
      misc: lan966x-pci: dts: add fdma interrupt to overlay

 drivers/misc/lan966x_pci.dtso                      |   5 +-
 drivers/net/ethernet/microchip/fdma/Makefile       |   4 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c     |  33 ++
 drivers/net/ethernet/microchip/fdma/fdma_api.h     |  25 +-
 drivers/net/ethernet/microchip/fdma/fdma_pci.c     | 177 +++++++
 drivers/net/ethernet/microchip/fdma/fdma_pci.h     |  41 ++
 drivers/net/ethernet/microchip/lan966x/Makefile    |   4 +
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  51 +-
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 551 +++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  47 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  46 ++
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |   1 +
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |   6 +
 13 files changed, 949 insertions(+), 42 deletions(-)
---
base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
change-id: 20260313-lan966x-pci-fdma-94ed485d23fa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


