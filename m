Return-Path: <netdev+bounces-270423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H4VHTT9wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74002EE690
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F00D304BCDD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7837FF68;
	Mon, 23 Mar 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Tz1Q3rfH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178C368263
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254978; cv=none; b=O8R5ITLAnCPfjcqmxDy4EycYz4GZUVudekH7PiYXUVQCYs4Jsrp0yjeTBdW/30DfV9peNeseChI7j4M/WlGPmOEZbDZvUP8gkWIqGmUj4SAAWh2xizDiqeVSPgRNwEOEuqEMkLcfJw16rRHEEGbcpUP0H9vC5WRvG4G+MU1q/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254978; c=relaxed/simple;
	bh=flp1DmKjXi1G1sX8otmhns+s+Jeav5aZn+vZb3pm3Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcRjSdjSNLa6dYQPgFUOSqSy1jExEQkuPPss8Bk9KqOyghst2/4UcYsDyV4/ty3sVpKKuE1Pzm0vsPd4PYQEkbDR4AFMiXF8VVGApgmMivSEGfeZNeLmtUJSwDtBD8P74QsdPVVB0O67CwpNfXBJu0TKwd62Bf+HmuMjEqaw02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Tz1Q3rfH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 180B0207BE;
	Mon, 23 Mar 2026 09:36:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OlUxa07AT_LY; Mon, 23 Mar 2026 09:36:15 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1BE80205DD;
	Mon, 23 Mar 2026 09:36:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1BE80205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254975;
	bh=C1dy2ddeiMpDaUmUMN5y4JjeuZk/ahIsErTNR+VX4J0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Tz1Q3rfHGaUn3vQf36msgeA5V+RxKaF42jaomtsC9rLclPCPJkgXnAfMIjxwT9s3w
	 41KZ7lR4HVvT8rRfIc/DgeNsatqedOpWkDTu6Fx5Rgzyjs0/A2az7CMpYPv+I4iAlc
	 mWpUyXSiObk4pfyH2i2gAHNA8UGrxsrqM8Dpl3BTCoyQMUsM0Edk2m9CjYVtySHbdJ
	 iAuoUU4br4LoLY/cO0AQploU2vRllqVwm5pgC1t8u5Ia4dP6sJZGl6ZNTUCnjQPsAY
	 9G58z3r+OXpMiM/LGphUOgrGjAIRtVh6ai6u60SavkQogKReDd4C1kjZapjo2TgNLt
	 PZlvyR1VwYFeQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:36:14 +0100
Received: (nullmailer pid 2741815 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/20] xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly
Date: Mon, 23 Mar 2026 09:33:47 +0100
Message-ID: <20260323083440.2741292-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:email,secunet.com:mid,imlonghao.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C74002EE690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Fernando Fernandez Mancera <fmancera@suse.de>

In iptfs_reassem_cont(), IP-TFS attempts to append data to the new inner
packet 'newskb' that is being reassembled. First a zero-copy approach is
tried if it succeeds then newskb becomes non-linear.

When a subsequent fragment in the same datagram does not meet the
fast-path conditions, a memory copy is performed. It calls skb_put() to
append the data and as newskb is non-linear it triggers
SKB_LINEAR_ASSERT check.

 Oops: invalid opcode: 0000 [#1] SMP NOPTI
 [...]
 RIP: 0010:skb_put+0x3c/0x40
 [...]
 Call Trace:
  <IRQ>
  iptfs_reassem_cont+0x1ab/0x5e0 [xfrm_iptfs]
  iptfs_input_ordered+0x2af/0x380 [xfrm_iptfs]
  iptfs_input+0x122/0x3e0 [xfrm_iptfs]
  xfrm_input+0x91e/0x1a50
  xfrm4_esp_rcv+0x3a/0x110
  ip_protocol_deliver_rcu+0x1d7/0x1f0
  ip_local_deliver_finish+0xbe/0x1e0
  __netif_receive_skb_core.constprop.0+0xb56/0x1120
  __netif_receive_skb_list_core+0x133/0x2b0
  netif_receive_skb_list_internal+0x1ff/0x3f0
  napi_complete_done+0x81/0x220
  virtnet_poll+0x9d6/0x116e [virtio_net]
  __napi_poll.constprop.0+0x2b/0x270
  net_rx_action+0x162/0x360
  handle_softirqs+0xdc/0x510
  __irq_exit_rcu+0xe7/0x110
  irq_exit_rcu+0xe/0x20
  common_interrupt+0x85/0xa0
  </IRQ>
  <TASK>

Fix this by checking if the skb is non-linear. If it is, linearize it by
calling skb_linearize(). As the initial allocation of newskb originally
reserved enough tailroom for the entire reassembled packet we do not
need to check if we have enough tailroom or extend it.

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Reported-by: Hao Long <me@imlonghao.com>
Closes: https://lore.kernel.org/netdev/DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 0747d1cfa333..2c87290fe06c 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -901,6 +901,12 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
 		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
 	} else {
+		if (skb_linearize(newskb)) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
+				       LINUX_MIB_XFRMINBUFFERERROR);
+			goto abandon;
+		}
+
 		/* copy fragment data into newskb */
 		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
 				      copylen)) {
-- 
2.43.0


