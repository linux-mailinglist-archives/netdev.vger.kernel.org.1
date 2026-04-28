Return-Path: <netdev+bounces-281867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BCwFDy08GnsXQEAu9opvQ
	(envelope-from <netdev+bounces-281867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC9485BA6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77D37305E9D9
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280142EEDF;
	Tue, 28 Apr 2026 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E9ByCauK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05413F788E;
	Tue, 28 Apr 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381691; cv=none; b=dwteSB2MjsWa2ipfH1oKjt2liBz7Wqz+l5TDd4K2f+YQ6UWR0G+I329wPjXovavuc8Zv0LX+Jvgj1uyJFy/SujH+tJtfc5R4XL635cdAlzcQ5G6QOcNej20428imZ8LHaksTSWK3zhf0zN7MfrqRnljgndTs71SXLpI7l2e7zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381691; c=relaxed/simple;
	bh=79+vPV9e+OqWLz3onwlm7PbN+48buNA31r4Z7PIHFhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EBlT9SJLBZEOC7yKWpeQYZ1elINK7rJlznQwbUk0i30mjL5GGWjM9NvBVWmaemU8hlTHBxLH5ruM/idojoYscWqbJqnf1XSHMD8RBMrvqzlegGGDOZhGvlxwiNlSDhsEJRhUA10y78bFEgoyN4RB0/9Wb1NoohSgSy9hmXFHWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E9ByCauK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777381689; x=1808917689;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=79+vPV9e+OqWLz3onwlm7PbN+48buNA31r4Z7PIHFhY=;
  b=E9ByCauK/OOi18ub8wTC92zUxRyAQh113QlAtgOIgqp0BStwc++/6v0Z
   /Y6UW9nCTL94kSfCn9gV9W194Rs1YTm9AgOrjgkRIKs/icUTx000sj2JW
   GhY3sMIvgw0WbOjuZf3K90tFHwdFkPFU46rXlkmcHH9NvMVOPYSrg1Kwj
   eeviVCplSo4L6418T/rJdo9YaNWSjefVoRJVWLXnBUYpjX/PQrZIpBaPk
   M4CTkZ5nbeFrUINRvSjeqNsL7rxozxhrFLa//02+fP2eB6G5AL1dUaTiD
   19BJQZDfqqlNeb0TcuQrDix3m5YzLmvo/pPbaM1hbECb6BIXzwOUWru5h
   Q==;
X-CSE-ConnectionGUID: Xk5TDH0sSuaDI0KUN2gCiw==
X-CSE-MsgGUID: J5ZdwNHPQta8dKqahhr4Mg==
X-IronPort-AV: E=Sophos;i="6.23,204,1770620400"; 
   d="scan'208";a="223971771"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2026 06:08:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Apr 2026 06:07:57 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Apr 2026 06:07:54 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 28 Apr 2026 15:07:02 +0200
Subject: [PATCH net-next v2 13/13] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-lan966x-pci-fdma-v2-13-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
In-Reply-To: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
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
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B7FC9485BA6
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:dkim,microchip.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,e0000000:email]

Add the fdma interrupt (OIC interrupt 14) to the lan966x PCI device
tree overlay, enabling FDMA-based frame injection/extraction when
the switch is connected over PCIe.

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


