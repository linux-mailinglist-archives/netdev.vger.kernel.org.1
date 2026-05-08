Return-Path: <netdev+bounces-285707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL21LDWU/WmXgAAAu9opvQ
	(envelope-from <netdev+bounces-285707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C674F332C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 344013047777
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F23803EE;
	Fri,  8 May 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z3DRB6ty"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D0346AC2;
	Fri,  8 May 2026 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225794; cv=none; b=cjPTqEUndN2fs0605peLYGMoUYbJ49QFKEEdgFIkyHS16AEjYrQnJ2WMlPDF5KOw4c5aaTQv9vRQfRfqlmmv7e5U+g2nH2LPfl8gd95xDS6Vc1qoDNcPZLnja167eojTOIJgYdgvths88wY7fpZM5INwuszu9U7DPwou1+U2c4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225794; c=relaxed/simple;
	bh=wGxs+F/+5Vrhuyz2y5uEWLeuFrAw1YPbFSMnjR0PIic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Uw2nIhQKOGHTQO5fs4NOlX1R5mnFkEYosIb7PbISOGDyIiuXdMkxZxi3kiTmG6bNiIkSGt0smfKfFSVnnNTcZCM6jDbxrc52ywVm70XkzGEjDPrpxPbliWybQ64ftoZ8e+WvcrOhPN2waoDxz8Ee4kTG3Y3GKRtAofjOWczda88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z3DRB6ty; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778225792; x=1809761792;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wGxs+F/+5Vrhuyz2y5uEWLeuFrAw1YPbFSMnjR0PIic=;
  b=z3DRB6tyv8KeoZxm6uYn9DwwIS/C5DhkLctZhkSIXZQJ0bNcGR6lk8Pd
   agqWYc8nYpr78VQPVJ2MYeUnsaup2KyieMYrD+sKcfKTEEF+lyHaQud2v
   TewqVnTI3mbE/XDpTV3wSG43FQcqmon/gy/B+CW3UjL4v1ElnuoM9JK/c
   hGZa2JA7oSdSxVfAhAYCv8FvgG1AprKS4dzlXQfywn2O7eKFaF8zvzoQu
   EysLmZLxqvkLeRl9irDYpviIAoZfHinjXXpmB4hINg+DOq9RpzH9j1eOi
   jiG/gvcJb0C+ln9ycWk8rm2e4SXy5piPedtv59in8xUv6R2/jxcoiiVEA
   g==;
X-CSE-ConnectionGUID: Si8tHD4XTWCeQ24m5HJjXg==
X-CSE-MsgGUID: jKLFif6vSnGtMAwY3BSs3g==
X-IronPort-AV: E=Sophos;i="6.23,223,1770620400"; 
   d="scan'208";a="56432180"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2026 00:36:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 8 May 2026 00:36:31 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 8 May 2026 00:36:27 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 8 May 2026 09:35:37 +0200
Subject: [PATCH net-next v4 13/13] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260508-lan966x-pci-fdma-v4-13-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com>
In-Reply-To: <20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com>
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
X-Rspamd-Queue-Id: 35C674F332C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285707-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,e0000000:email,microchip.com:email,microchip.com:mid,microchip.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add the fdma interrupt (OIC interrupt 14) to the lan966x PCI device
tree overlay, enabling FDMA-based frame injection/extraction when
the switch is connected over PCIe.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/misc/lan966x_pci.dtso | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
index 7bb726550caf..5bb12dbc0843 100644
--- a/drivers/misc/lan966x_pci.dtso
+++ b/drivers/misc/lan966x_pci.dtso
@@ -141,8 +141,9 @@ switch: switch@e0000000 {
 
 					interrupt-parent = <&oic>;
 					interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+						     <14 IRQ_TYPE_LEVEL_HIGH>,
 						     <9 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "xtr", "ana";
+					interrupt-names = "xtr", "fdma", "ana";
 
 					resets = <&reset 0>;
 					reset-names = "switch";

-- 
2.34.1


