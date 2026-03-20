Return-Path: <netdev+bounces-269956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGIUKodjvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:11:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509A2DC617
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5EF30AAE72
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C73CF67B;
	Fri, 20 Mar 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JMMqnpJU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02123C7DE0;
	Fri, 20 Mar 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018931; cv=none; b=QM4aDPSmvyz7QuG+xYjvxdYkBDFNphZXTyQCFOjrx9ISxda/s9xrrYr7aFd0H5m/cpTPOW6b5kK/CkhkO+3Tnuiahh1arpYJGIHgThyQiD2PJtt5hRyatQ7k0mIHuAYj4tdG9Y8HpQMMUNgJ1s5ecC6myGs+qebk7dqf8CnoXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018931; c=relaxed/simple;
	bh=ngwNGPEpnChc8hiUqz809IVYoAZ+8Dv1ZWheWlcjMDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GaIUa/1t5v5OLVQKBb4WR4dPvAlrHnBLMh9LqTLpxrIFFk81l+qTAmLxUGnOv/UQ9aQUPESlLBmErqw5V5z3u4o4aIJufXhjEJrv3pZituPxdipi8diSt+Jfde+8ORQwIjDzm04edt6PeVRSi0avmilKA9t9OOxGbyOy6Rcbbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JMMqnpJU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774018929; x=1805554929;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ngwNGPEpnChc8hiUqz809IVYoAZ+8Dv1ZWheWlcjMDs=;
  b=JMMqnpJU1wLU+wBLoWd1tQVvpSknIAX221Qhc3jQpRlh2FyUY0pvFnDx
   wuUabs7Jk+Ik+HyIoNndRs0h2q0COO22Lk3P1SQpBbWYZWvOyv2M/TkfD
   CKUSumQBMUAbH2A6L/JI1j2fu84AFSgNFTAVzx7u4ra30NiKNRYQ71P8M
   TxgDGtJZf2mQqgWfIPpc4hmVSctE3eq3y6gLo48zDtl2QLbUh/D2WS5kp
   X+4YDgfOHoDbp+NooYWn2YkJhcJyDi9PTIBxK/LIpwl+4zhwDzRuoi92R
   5ZRn/hahomDycMhed9aOvTCa6yWkldwz0ab0wUNm1MD7BKoFJ+uhz6KVr
   A==;
X-CSE-ConnectionGUID: PI7UURBMS4qqPJi2jv9mYA==
X-CSE-MsgGUID: f15L8uv1RiOlJaWyJJ/1Dw==
X-IronPort-AV: E=Sophos;i="6.23,130,1770620400"; 
   d="scan'208";a="62637214"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:02:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 20 Mar 2026 08:01:47 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 20 Mar 2026 08:01:44 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Mar 2026 16:01:05 +0100
Subject: [PATCH net-next 09/10] misc: lan966x-pci: dts: extend cpu reg to
 cover PCIE DBI space
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-lan966x-pci-fdma-v1-9-ef54cb9b0c4b@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,e0000000:email,0.0.0.2:email]
X-Rspamd-Queue-Id: 0509A2DC617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ATU outbound windows used by the FDMA engine are programmed through
registers at offset 0x400000+, which falls outside the current cpu reg
mapping. Extend the cpu reg size from 0x100000 (1MB) to 0x800000 (8MB)
to cover the full PCIE DBI and iATU register space.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/misc/lan966x_pci.dtso | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
index 7b196b0a0eb6..7bb726550caf 100644
--- a/drivers/misc/lan966x_pci.dtso
+++ b/drivers/misc/lan966x_pci.dtso
@@ -135,7 +135,7 @@ lan966x_phy1: ethernet-lan966x_phy@2 {
 
 				switch: switch@e0000000 {
 					compatible = "microchip,lan966x-switch";
-					reg = <0xe0000000 0x0100000>,
+					reg = <0xe0000000 0x0800000>,
 					      <0xe2000000 0x0800000>;
 					reg-names = "cpu", "gcb";
 

-- 
2.34.1


