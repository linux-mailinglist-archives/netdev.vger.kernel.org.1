Return-Path: <netdev+bounces-281857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEtKHAO68GmFXwEAu9opvQ
	(envelope-from <netdev+bounces-281857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:45:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12114862C4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC3353060A3D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D3F425CDB;
	Tue, 28 Apr 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jE/VRvb3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546113EB7F0;
	Tue, 28 Apr 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381647; cv=none; b=ctdIPSH0SIFzNLywVP7PGwp6lv+0jmShiCebX15DCVzpxKa+z0T9xscoy79DnJMpoUDmDHQnrZ0dIwqqr4GPWfKK6mdHFJk3IpmkMGBo46sp0HgD4grqmVC2FTOK8fgHdYwLZiJr28nnlRMbWT5hdo7geGRIkOL1Hh8yHJhDBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381647; c=relaxed/simple;
	bh=oUwDA3FVh/O+XkO9AlTr0IOVgeQfsUFFMQIBIanPYGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kcvly4Y3bk2mXjppbcICiK3Uuqc+DMKATH9cNXGQ+bCtuex7vst4ty+sHBY4ORpq5QHV2T6fZVcuRigUR/GCDYLTp+PK6gZ8uMJHzTnEwfxbHTP9Vq5nMoYeKT+rPcFkjAVAch/bEkANO84THBDmLyn3nb/ebag2c3xHtNBOtNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jE/VRvb3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777381646; x=1808917646;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oUwDA3FVh/O+XkO9AlTr0IOVgeQfsUFFMQIBIanPYGA=;
  b=jE/VRvb3ai/3fS417iRNMNp90Q69HU4/c1idfTCCbogN3rbERoSgnid7
   oYHdz6FOO97HMwSW/1Xy0a0tjEmaZDudbNgRL/pyLTrxdhQJwQlxIOepR
   9Ua+yKPrxmJonrna1HS3FsOa+qkwZSSqeELa9FFNvMwHVQq2al63sF2Pm
   ueM8UOMlk5XDHFgPo0Dfm22MshjjBXX4Zd8vzleAfDavgmL/wNoQTT4ev
   ujT17u1STDpFt6t/N4BQPhtFp4r9O2GKB4BOfeKXTGRxlSuPsQmH++797
   07be8024W+JlDpjNMaCBfw559hiBv3l7bAvfn3gfbYtE6uTo4KE3sGwkL
   Q==;
X-CSE-ConnectionGUID: Jf23p+KtQ3qI8aY4yf3eVg==
X-CSE-MsgGUID: jVWv1olVRyOIbdj+w9IT5A==
X-IronPort-AV: E=Sophos;i="6.23,204,1770620400"; 
   d="scan'208";a="56719851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 06:07:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 28 Apr 2026 06:07:16 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Apr 2026 06:07:13 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 28 Apr 2026 15:06:51 +0200
Subject: [PATCH net-next v2 02/13] net: microchip: fdma: rename contiguous
 dataptr helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-lan966x-pci-fdma-v2-2-d3ec66e06202@microchip.com>
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
X-Rspamd-Queue-Id: E12114862C4
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
	TAGGED_FROM(0.00)[bounces-281857-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:dkim,microchip.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When the FDMA library was introduced [1], two helpers to get the DMA and
virtual address of a DCB, in contiguous memory, were added. These
helpers have had no callers until this series. I found the naming I
initially used confusing and inconsistent.

Rename fdma_dataptr_get_contiguous() and
fdma_dataptr_virt_get_contiguous() to fdma_dataptr_dma_addr_contiguous()
and fdma_dataptr_virt_addr_contiguous(). This makes the pair symmetric
and clarifies what type of address each returns.

[1]: commit 30e48a75df9c ("net: microchip: add FDMA library")

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/fdma/fdma_api.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.h b/drivers/net/ethernet/microchip/fdma/fdma_api.h
index d91affe8bd98..94f1a6596097 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.h
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.h
@@ -197,8 +197,9 @@ static inline int fdma_nextptr_cb(struct fdma *fdma, int dcb_idx, u64 *nextptr)
  * if the dataptr addresses and DCB's are in contiguous memory and the driver
  * supports XDP.
  */
-static inline u64 fdma_dataptr_get_contiguous(struct fdma *fdma, int dcb_idx,
-					      int db_idx)
+static inline u64 fdma_dataptr_dma_addr_contiguous(struct fdma *fdma,
+						   int dcb_idx,
+						   int db_idx)
 {
 	return fdma->dma + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
 	       (dcb_idx * fdma->n_dbs + db_idx) * fdma->db_size +
@@ -209,8 +210,8 @@ static inline u64 fdma_dataptr_get_contiguous(struct fdma *fdma, int dcb_idx,
  * applicable if the dataptr addresses and DCB's are in contiguous memory and
  * the driver supports XDP.
  */
-static inline void *fdma_dataptr_virt_get_contiguous(struct fdma *fdma,
-						     int dcb_idx, int db_idx)
+static inline void *fdma_dataptr_virt_addr_contiguous(struct fdma *fdma,
+						      int dcb_idx, int db_idx)
 {
 	return (u8 *)fdma->dcbs + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
 	       (dcb_idx * fdma->n_dbs + db_idx) * fdma->db_size +

-- 
2.34.1


