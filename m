Return-Path: <netdev+bounces-280341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOX4NYV96GmsKwIAu9opvQ
	(envelope-from <netdev+bounces-280341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EE44321A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0BF33003827
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C219372EEF;
	Wed, 22 Apr 2026 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="rAZxY2Vm"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4E361DBE;
	Wed, 22 Apr 2026 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844073; cv=none; b=kC3B4mc6lyNtS9HNCENY29n+3sEBGzDmBEEzjrQNFIveEQaYZBnKmAvKr9lwjfTl9dE+0nDOmg0HL7Zxgl9lE9cnMvzjDtgtU+XqVOWuZh2na+CHm0iklB6hUUfiv45sHG7ImZ+L3HKA9iquahxW+iiiwSgtJk0jjHdf9HFo3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844073; c=relaxed/simple;
	bh=/Nh/MS+wEIDr2DvWGb6lKLWZxjOYXdFwaPZ6PbMV4sA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nYbOQTqAMLKi8EGzXGaGlC4OYaPBPXDYYt/zO4RdHH2oFp6L+N8cl8hdGfFdM4+Cshj2EK8SE5mtZ69Nb6mjnAnc2MjiBT8uoZOKMJ+f6K1+uvX869CqCGsVxRCeHoztoJR3gyrtU524t2IYmI1d9L71LWXsYhQA1SXaKpY152I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=rAZxY2Vm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63M7lAfW5418774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776844031;
	bh=M2klJkDqOGbfHo8HgAJa24xwtx0JTtNc6U2xFoEwfDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rAZxY2VmbgxwYOt9/O1/c9SNWazkBv8cMW78ggLuXNw+rERbxOeMJXUE/rsSYgRPy
	 2T/HYQ+cJbMvL5mK0RfmzceYB/q0rgpvbx4NjjPgZRULTWpzNHXmNTVt6y5/Z0rHkC
	 h17iAWxFlRU85ymSUJw/V+vUf40Oy8AP8B7ZBvYHlH/soL64pRaIfZC5cHiAnsfwQX
	 xaGr1raU11JLcC0eQJlzNL7Sohr5IXuePMvlHCdkxP5pUoMM+j4NwybEYkFMzNPQdg
	 lYXCkob+hD/YtyWvF8BSGWP0dJed+0bHfcRTBliNbHurFgNJT4EfnygnllwIHvYfu2
	 q9+TqWHiHZQBQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63M7lAfW5418774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Apr 2026 15:47:10 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Apr 2026 15:47:10 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 22 Apr 2026 15:47:10 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch net-next v1 9/9] r8169: add support for ethtool
Thread-Topic: [RFC Patch net-next v1 9/9] r8169: add support for ethtool
Thread-Index: AQHc0Gw5eixkY5b8f0iWI9ytCWf1u7XnZ0SAgANM7xA=
Date: Wed, 22 Apr 2026 07:47:09 +0000
Message-ID: <f7dfe0357c04466895080f2b9aae1b56@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-10-javen_xu@realsil.com.cn>
 <c94f23f6-e353-4e88-af91-9e73d70d009d@lunn.ch>
In-Reply-To: <c94f23f6-e353-4e88-af91-9e73d70d009d@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280341-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:dkim,realsil.com.cn:mid]
X-Rspamd-Queue-Id: CC4EE44321A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>> +static int rtl8169_set_channels(struct net_device *dev,
>> +                             struct ethtool_channels *ch) {
>> +     struct rtl8169_private *tp =3D netdev_priv(dev);
>> +     bool if_running =3D netif_running(dev);
>> +     int i;
>> +
>> +     if (!tp->rss_support && (ch->rx_count > 1 || ch->tx_count > 1)) {
>> +             netdev_warn(dev, "This chip does not support multiple
>channels/RSS.\n");
>> +             return -EOPNOTSUPP;
>> +     }
>> +
>> +     if (ch->rx_count =3D=3D 0 || ch->tx_count =3D=3D 0)
>> +             return -EINVAL;
>> +     if (ch->rx_count > tp->HwSuppNumRxQueues ||
>> +         ch->tx_count > tp->HwSuppNumTxQueues)
>> +             return -EINVAL;
>> +     if (ch->other_count || ch->combined_count)
>> +             return -EINVAL;
>> +
>> +     if (ch->rx_count =3D=3D tp->num_rx_rings &&
>> +         ch->tx_count =3D=3D tp->num_tx_rings)
>> +             return 0;
>> +
>> +     if (if_running)
>> +             rtl8169_close(dev);
>
>I assume this releases all the memory from the rings?
>
>> +
>> +     tp->num_rx_rings =3D ch->rx_count;
>> +     tp->num_tx_rings =3D ch->tx_count;
>> +
>> +     tp->rss_enable =3D (tp->num_rx_rings > 1 && tp->rss_support);
>> +
>> +     for (i =3D 0; i < tp->HwSuppIndirTblEntries; i++) {
>> +             if (tp->rss_enable)
>> +                     tp->rss_indir_tbl[i] =3D ethtool_rxfh_indir_defaul=
t(i, tp-
>>num_rx_rings);
>> +             else
>> +                     tp->rss_indir_tbl[i] =3D 0;
>> +     }
>> +
>> +     if (tp->rss_enable)
>> +             tp->InitRxDescType =3D RX_DESC_RING_TYPE_RSS;
>> +     else
>> +             tp->InitRxDescType =3D RX_DESC_RING_TYPE_DEAFULT;
>> +
>> +     if (if_running)
>> +             return rtl_open(dev);
>
>And this tries to allocate the memory needed for the rings? And if the sys=
tem
>is under memory pressure, it fails and your network is dead?
>
>Please modify the code so that is first allocated the new rings and then f=
rees
>the old rings, so you can fail gracefully.
>
>     Andrew

Thank you for your advice. I have updated the code accordingly. This patch =
is=20
based on RFC Patch net-next 9/9.

This patch fixes issues when using ethtool -L to change the number of RX ri=
ngs.=20
Specifically, if allocating memory for the new RX rings fails, it now grace=
fully rolls=20
back to the original state.
Additionally, it fixes a bug where ping or iperf would fail after manually =
setting=20
8 RX rings (when the default suggested RSS queue number is only 1 or 2). Th=
is=20
was caused by a missing call to rtl_set_irq_mask, which is now added.

---
 drivers/net/ethernet/realtek/r8169_main.c | 101 +++++++++++++++++++---
 1 file changed, 90 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index 57087abe7d88..4b2abd3deee0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6116,6 +6116,8 @@ static void rtl8169_double_check_rss_support(struct r=
tl8169_private *tp)
 	if (tp->num_rx_rings >=3D 2) {
 		tp->rss_enable =3D 1;
 		tp->InitRxDescType =3D RX_DESC_RING_TYPE_RSS;
+	} else if (tp->num_rx_rings =3D=3D 1 && tp->irq_nvecs > 1) {
+		tp->rss_enable =3D 0;
 	} else {
 		tp->rss_enable =3D 0;
 		if (tp->irq_nvecs > 1) {
@@ -6534,18 +6536,70 @@ static void rtl8169_get_channels(struct net_device =
*dev,
 	ch->combined_count =3D 0;
 }
=20
+static int rtl8169_realloc_rx(struct rtl8169_private *tp,
+			      struct rtl8169_rx_ring *new_rx,
+			      int new_count)
+{
+	int i, ret;
+
+	new_rx[0].rdsar_reg =3D RxDescAddrLow;
+	for (i =3D 1; i < new_count; i++)
+		new_rx[i].rdsar_reg =3D (u16)(RDSAR_Q1_LOW + (i - 1) * 8);
+
+	for (i =3D 0; i < new_count; i++)
+		new_rx[i].num_rx_desc =3D NUM_RX_DESC;
+
+	for (i =3D 0; i < new_count; i++) {
+		struct rtl8169_rx_ring *ring =3D &new_rx[i];
+
+		ring->RxDescAllocSize =3D (NUM_RX_DESC + 1) * sizeof(struct RxDesc);
+		ring->RxDescArray =3D dma_alloc_coherent(&tp->pci_dev->dev,
+						       ring->RxDescAllocSize,
+						       &ring->RxPhyAddr,
+						       GFP_KERNEL);
+		if (!ring->RxDescArray) {
+			ret =3D -ENOMEM;
+			goto err_free;
+		}
+
+		memset(ring->Rx_databuff, 0, sizeof(ring->Rx_databuff));
+		ret =3D rtl8169_rx_fill(tp, ring);
+		if (ret) {
+			dma_free_coherent(&tp->pci_dev->dev, ring->RxDescAllocSize,
+					  ring->RxDescArray, ring->RxPhyAddr);
+			goto err_free;
+		}
+	}
+	return 0;
+
+err_free:
+	while (--i >=3D 0) {
+		rtl8169_rx_clear(tp, &new_rx[i]);
+		dma_free_coherent(&tp->pci_dev->dev, new_rx[i].RxDescAllocSize,
+				  new_rx[i].RxDescArray, new_rx[i].RxPhyAddr);
+	}
+	return ret;
+}
+
 static int rtl8169_set_channels(struct net_device *dev,
 				struct ethtool_channels *ch)
 {
 	struct rtl8169_private *tp =3D netdev_priv(dev);
 	bool if_running =3D netif_running(dev);
-	int i;
+	struct rtl8169_rx_ring *new_rx;
+	u8 old_tx_desc_type =3D tp->InitRxDescType;
+	u8 new_desc_type;
+	bool new_rss_enable;
+	int i, ret;
=20
 	if (!tp->rss_support && (ch->rx_count > 1 || ch->tx_count > 1)) {
 		netdev_warn(dev, "This chip does not support multiple channels/RSS.\n");
 		return -EOPNOTSUPP;
 	}
=20
+	if (tp->features & RTL_FEATURE_MSI)
+		return -EINVAL;
+
 	if (ch->rx_count =3D=3D 0 || ch->tx_count =3D=3D 0)
 		return -EINVAL;
 	if (ch->rx_count > tp->HwSuppNumRxQueues ||
@@ -6558,13 +6612,39 @@ static int rtl8169_set_channels(struct net_device *=
dev,
 	    ch->tx_count =3D=3D tp->num_tx_rings)
 		return 0;
=20
-	if (if_running)
-		rtl8169_close(dev);
+	new_rss_enable =3D (ch->rx_count > 1 && tp->rss_support);
+	new_desc_type =3D new_rss_enable ? RX_DESC_RING_TYPE_RSS : RX_DESC_RING_T=
YPE_DEAFULT;
+	tp->InitRxDescType =3D new_desc_type;
+
+	if (!if_running) {
+		tp->num_rx_rings =3D ch->rx_count;
+		tp->rss_enable =3D new_rss_enable;
+		return 0;
+	}
+
+	new_rx =3D kcalloc(R8169_MAX_RX_QUEUES, sizeof(*new_rx), GFP_KERNEL);
+	if (!new_rx)
+		return -ENOMEM;
+
+	ret =3D rtl8169_realloc_rx(tp, new_rx, ch->rx_count);
+	if (ret) {
+		kfree(new_rx);
+		tp->InitRxDescType =3D old_tx_desc_type;
+		return ret;
+	}
+
+	netif_stop_queue(dev);
+	rtl8169_down(tp);
+
+	for (i =3D 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
+	rtl8169_free_rx_desc(tp);
=20
 	tp->num_rx_rings =3D ch->rx_count;
-	tp->num_tx_rings =3D ch->tx_count;
+	tp->rss_enable =3D new_rss_enable;
=20
-	tp->rss_enable =3D (tp->num_rx_rings > 1 && tp->rss_support);
+	memset(tp->rx_ring, 0, sizeof(tp->rx_ring));
+	memcpy(tp->rx_ring, new_rx, sizeof(*new_rx) * ch->rx_count);
=20
 	for (i =3D 0; i < tp->HwSuppIndirTblEntries; i++) {
 		if (tp->rss_enable)
@@ -6573,13 +6653,12 @@ static int rtl8169_set_channels(struct net_device *=
dev,
 			tp->rss_indir_tbl[i] =3D 0;
 	}
=20
-	if (tp->rss_enable)
-		tp->InitRxDescType =3D RX_DESC_RING_TYPE_RSS;
-	else
-		tp->InitRxDescType =3D RX_DESC_RING_TYPE_DEAFULT;
+	rtl_set_irq_mask(tp);
+
+	rtl8169_up(tp);
+	netif_start_queue(dev);
=20
-	if (if_running)
-		return rtl_open(dev);
+	kfree(new_rx);
=20
 	return 0;
 }
--=20
2.43.0


