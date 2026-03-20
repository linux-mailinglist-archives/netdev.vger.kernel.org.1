Return-Path: <netdev+bounces-269954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KZIHwJlvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:17:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5CD2DC7F7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC70C31D6FCF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936173CD8D1;
	Fri, 20 Mar 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CvvavWaB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3C3CBE77;
	Fri, 20 Mar 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018913; cv=none; b=NgEyeGIqW+xOED1pVHdCWmdl/gZu8Z2P3OTqdyc07n0t4WeQtk8nGSjxbiFcIoUPXXRpgBE/lo/Z0Fy0ZKox50e9HvC5XXpoIGmzdlXFDAxTaAWWeM7zAalY7SmAJf9HgbxQnB+PJBwSfKOCsRX5d5lZeuDmIcM/p3v9yLpi8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018913; c=relaxed/simple;
	bh=oUwDA3FVh/O+XkO9AlTr0IOVgeQfsUFFMQIBIanPYGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b4jr04chg4gBSEyEQ8DooBofjSBqZq9nPvAA89qWhByVNJO0zTiK4QIE+XFdtCzXotYRWKhd00VK6zdmo7o5w8u/OTbFlt2anjLo45MowXWyOH9QjnO7HExbq5rOvdDNmu8DkgOPwgIuv8R7aqcaCnEyVykb1KhiKc6a58Z038g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CvvavWaB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774018912; x=1805554912;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oUwDA3FVh/O+XkO9AlTr0IOVgeQfsUFFMQIBIanPYGA=;
  b=CvvavWaBRGQSrx3Qt7qViiBY/Ps83AteB/dbq1iaThkq0SwtUsUE6fAj
   4mbUFd7uFqynYNYoHQjaxIAU8+nwZ8fcakR6++H/hj+OqetZDVRvEY1Vs
   8/Hpy5JtesIh0ftQs/3kB3TYl5qs79SVEIceAWCq2NokShzhZ7Zzd4mp/
   GZnIu15saJvX8XopYCSed9w0BUHb8Y+/xVLRC5q0J5EsOc9XLAd2mxJbx
   wziG0oPSIlf2q9jmb5HDgfLS9aleYaCHIjuYc+HNo3vnRxge9+1/Ny61u
   rQD1jonvXJ9yXYfBl61YPsAk5NaajIA+iFi50e9bptBVgv4eZRldb6XXt
   g==;
X-CSE-ConnectionGUID: pJu2WHvLRcaRsqolGjnVWA==
X-CSE-MsgGUID: 0dhdXO6aR/Ox/2EkOG4QPw==
X-IronPort-AV: E=Sophos;i="6.23,130,1770620400"; 
   d="scan'208";a="55385884"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:01:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 20 Mar 2026 08:01:19 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 20 Mar 2026 08:01:16 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Mar 2026 16:00:57 +0100
Subject: [PATCH net-next 01/10] net: microchip: fdma: rename contiguous
 dataptr helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-lan966x-pci-fdma-v1-1-ef54cb9b0c4b@microchip.com>
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
	TAGGED_FROM(0.00)[bounces-269954-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: 3C5CD2DC7F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


