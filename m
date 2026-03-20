Return-Path: <netdev+bounces-269958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBCzBKpjvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:11:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F552DC653
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C36532E21C1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B883CFF6F;
	Fri, 20 Mar 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QDw7Gk2T"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1013CF67F;
	Fri, 20 Mar 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018932; cv=none; b=UhslwNSpDOWRaZmplAe9WNxeCt2Aia/VrSm/iAxZ9UFeHatjCoJZZtfaY9YIyoE41sbmRy8GxV3F48AkJw1a71Sq/TDbce+p0/Bq86GQhHGXE9HINvh7923rV8qqUWzal1uOvOCnXllnggNaUV7kCVmaQh7JVr08nAFzr7yPYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018932; c=relaxed/simple;
	bh=79+vPV9e+OqWLz3onwlm7PbN+48buNA31r4Z7PIHFhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B/NZAn7YiFVtNfmNe+ro/2doAMKrr1i7nlzqGTj7U2IJb4WHNFdg8uwu/yz2bZUF2EX6GujVzKHrPEaO1wvOaVgorok65+gmkzaeyAZQ1itClqktX7FSFlSRXSAICTMh3SGRUyk3dJ7kz8MnNkZCHfKGbhGcSBahM0TGFAS0ywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QDw7Gk2T; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774018931; x=1805554931;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=79+vPV9e+OqWLz3onwlm7PbN+48buNA31r4Z7PIHFhY=;
  b=QDw7Gk2TQNVE1G4S0U3vZ0Ip50Zdrlf83SPE+XvL95we6HtO8bn9b2KJ
   5z/XO7Wj1mGtVTepql+6rErwWENSiiZjrzzUo/PKx1IQlhooug7rKfEOT
   G/PwqGddoKE1Mvsa1icLPXXrv1xFQxwy9ovR5upvcOxPd7C//coPSc4ZI
   XH/qasj1yhFJ/4NyU4XQO4TYoKhepk7g8fM6KGOlR6wwDEkyn/3rtuEKJ
   fG5tPAavIsrj9DigmdWSrgFXI68LNIrYGnrcxUIkZ47ONGQsY3PcvnBhB
   6aJ2KpPSmEb9pTOn8MwZauMTbPZzoIWqU9bTTRdR0NEEjt+t5Qijo2stB
   Q==;
X-CSE-ConnectionGUID: PI7UURBMS4qqPJi2jv9mYA==
X-CSE-MsgGUID: 0+Gqk1r+TmiOADuDEkGwnA==
X-IronPort-AV: E=Sophos;i="6.23,130,1770620400"; 
   d="scan'208";a="62637215"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:02:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 20 Mar 2026 08:01:50 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 20 Mar 2026 08:01:47 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Mar 2026 16:01:06 +0100
Subject: [PATCH net-next 10/10] misc: lan966x-pci: dts: add fdma interrupt
 to overlay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-lan966x-pci-fdma-v1-10-ef54cb9b0c4b@microchip.com>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
In-Reply-To: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269958-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,e0000000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76F552DC653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


