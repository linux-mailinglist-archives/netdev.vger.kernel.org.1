Return-Path: <netdev+bounces-242137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB1C8CB90
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE43A7697
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D42BD5B9;
	Thu, 27 Nov 2025 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK0hwf7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761F224AF7;
	Thu, 27 Nov 2025 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213132; cv=none; b=E2uQgCrrn74fX0f9F+Jf5ng7ECH+Yvrb60WPTl8+g9BQ7AdV8eZWQjtakO3n+FT2rmgduEp504shwCVqeuwLjQ48xCeRHL0Tk4v44mlrvW834oY8KgLpHpVqMqSUyNkM/IuT129llYHMDf7Znc7tVZc6EISZ1MJ417JfMlW6jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213132; c=relaxed/simple;
	bh=RiG8ocl+oskfHKP1fdxflSJbEMY4ORST7J8gciT7bkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q2Icv7MuhEMnvzSuBOzKr3tNDx38Yl7p4Q6LwtwH3DQbiUliD4slMjKc80TUxQZG5I1/8JbPwgTU9m0ExisGczOHyPBFdizxxUjEQnywKXXOcLP0SIxtffm6JKpdCEWWZeo5rio17Bt8Qelw3rA9QgLQH2rC+QNTuR76GhmtGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK0hwf7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD0DC4CEF7;
	Thu, 27 Nov 2025 03:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213128;
	bh=RiG8ocl+oskfHKP1fdxflSJbEMY4ORST7J8gciT7bkA=;
	h=Date:From:To:Cc:Subject:From;
	b=mK0hwf7f8lFRIv5+es/aYemkjY0hb5VlC3ROc4uBKNtpTM7lR+DcDHn4XE9QhsbJe
	 GSDVMQC68wkZQvBgDaS+10C2YKL398zPpBwuoQnmge1O+XxAlMPxJ4HVC2Ie11odCL
	 sdMzOIcgPumd0+IZq4ec7nTU9gJTtUcyzK7l5ECYMEHhMkkUKwNxqo6kZT02OouHym
	 W4Wvah0uEbGUge/A31k1ZK/JQAdDOeHLTOqZQoXHcOPovJZ5A1APL8ZUAxSWXlZgIa
	 jQlGShAnqPXOx7gpS9Qiss+19Ad8LfAfl/jMvlkr1tK4Rs5rDHXln5sgfeCzY5MB/P
	 YhTr/d5IMwULw==
Date: Thu, 27 Nov 2025 12:12:03 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aSfBgwYhRvMe6ip7@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use DEFINE_RAW_FLEX() to avoid a -Wflex-array-member-not-at-end warning.

Remove fixed-size array struct usb_cdc_ncm_dpe16 dpe16[2]; from struct
mbim_tx_hdr, so that flex-array member struct mbim_tx_hdr::ndp16.dpe16[]
ends last in this structure.

Compensate for this by using the DEFINE_RAW_FLEX() helper to declare the
on-stack struct instance that contains struct usb_cdc_ncm_ndp16 as a
member. Adjust the rest of the code, accordingly.

So, with these changes fix the following warning:

drivers/net/wwan/mhi_wwan_mbim.c:81:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Avoid 80+ char line.
 - Add RB tag.

Changes in v2:
 - Add code comment to prevent people from adding new members after
   flex struct member `struct usb_cdc_ncm_ndp16 ndp16;`
 - Link: https://lore.kernel.org/linux-hardening/aSUwOtiDMYA8aSC3@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/aSUubvYfGJ-BIeDq@kspp/

 drivers/net/wwan/mhi_wwan_mbim.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index c814fbd756a1..daf07ef86b2b 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -78,8 +78,9 @@ struct mhi_mbim_context {
 
 struct mbim_tx_hdr {
 	struct usb_cdc_ncm_nth16 nth16;
+
+	/* Must be last as it ends in a flexible-array member. */
 	struct usb_cdc_ncm_ndp16 ndp16;
-	struct usb_cdc_ncm_dpe16 dpe16[2];
 } __packed;
 
 static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim,
@@ -107,20 +108,20 @@ static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
 				     u16 tx_seq)
 {
+	DEFINE_RAW_FLEX(struct mbim_tx_hdr, mbim_hdr, ndp16.dpe16, 2);
 	unsigned int dgram_size = skb->len;
 	struct usb_cdc_ncm_nth16 *nth16;
 	struct usb_cdc_ncm_ndp16 *ndp16;
-	struct mbim_tx_hdr *mbim_hdr;
 
 	/* Only one NDP is sent, containing the IP packet (no aggregation) */
 
 	/* Ensure we have enough headroom for crafting MBIM header */
-	if (skb_cow_head(skb, sizeof(struct mbim_tx_hdr))) {
+	if (skb_cow_head(skb, __struct_size(mbim_hdr))) {
 		dev_kfree_skb_any(skb);
 		return NULL;
 	}
 
-	mbim_hdr = skb_push(skb, sizeof(struct mbim_tx_hdr));
+	mbim_hdr = skb_push(skb, __struct_size(mbim_hdr));
 
 	/* Fill NTB header */
 	nth16 = &mbim_hdr->nth16;
@@ -133,12 +134,11 @@ static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
 	/* Fill the unique NDP */
 	ndp16 = &mbim_hdr->ndp16;
 	ndp16->dwSignature = cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN | (session << 24));
-	ndp16->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp16)
-					+ sizeof(struct usb_cdc_ncm_dpe16) * 2);
+	ndp16->wLength = cpu_to_le16(struct_size(ndp16, dpe16, 2));
 	ndp16->wNextNdpIndex = 0;
 
 	/* Datagram follows the mbim header */
-	ndp16->dpe16[0].wDatagramIndex = cpu_to_le16(sizeof(struct mbim_tx_hdr));
+	ndp16->dpe16[0].wDatagramIndex = cpu_to_le16(__struct_size(mbim_hdr));
 	ndp16->dpe16[0].wDatagramLength = cpu_to_le16(dgram_size);
 
 	/* null termination */
@@ -584,7 +584,8 @@ static void mhi_mbim_setup(struct net_device *ndev)
 {
 	ndev->header_ops = NULL;  /* No header */
 	ndev->type = ARPHRD_RAWIP;
-	ndev->needed_headroom = sizeof(struct mbim_tx_hdr);
+	ndev->needed_headroom =
+			struct_size_t(struct mbim_tx_hdr, ndp16.dpe16, 2);
 	ndev->hard_header_len = 0;
 	ndev->addr_len = 0;
 	ndev->flags = IFF_POINTOPOINT | IFF_NOARP;
-- 
2.43.0


