Return-Path: <netdev+bounces-18072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D575482B
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 12:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21C71C20A25
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92906184F;
	Sat, 15 Jul 2023 10:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E715CD
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 10:19:15 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107F30CB
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:19:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso24928205e9.0
        for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689416351; x=1692008351;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eBxcn27jU0dKuvE7ec+IctqyFfZQ4Yo4kxFRshmdeE=;
        b=rnr5HZ8/JtODklLwz64pCO59LrIPYB/ePZLxwpi9yT4Nky4hhcyw8FheuIxq/iKqoJ
         /gb102sMBV2/89yzyDLHJ4SnlEg5gV+7udMmrz+W3jGfdjTJp9EfjFuZ/urRibkFbFO6
         DJM3nxXhW7TXKhnr0awi+l1eXHBnMRpHX+GL0vmjme59G7eIomWwOTHlt1hiMFT2Vi9h
         7xlk4Sho0DH5lFlvRjJoKBT9aKDcYiJp6azPEt5mqOx9uCkfCnvGNlSjhN3+H+AdcXHE
         cmqbFFW/oqQ+c+pe9CJSrYFSizemOGyTp+v+ZsPZSI7nZlXMflQphdxyMpa5r14QuhFV
         9Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689416351; x=1692008351;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eBxcn27jU0dKuvE7ec+IctqyFfZQ4Yo4kxFRshmdeE=;
        b=bJTAlpPrZ7ytFJCDfMOppmMvtclT0v69jsePzMOfTDlhWyiIWt+t1OZ3jH+CgFrqV0
         SP/e/O4qSJGjj6YFD2t2SLXIM63gfgNbdyL3+nEjezIF/QtM3opceQC1/NNPQ1hZDXdf
         UIhkiFDNMxKwzlVG+HMt1LvVdZBR9Jtnlg7VPV+rATT4ip8BHKMeOpcMFKPwfUntDC8I
         4Itfv1uEALCJqukp2fYPTkfcbhOGvkoKsebGxtZWQTPgLi+762RuEYmBFyPA72leKhLo
         OblmzSldhB9H75dVW4/LrGG2/Gl+Pu6qmo+/SsRiMOzA4MeQ6WqHt337NGvCmQi0O62V
         C3mQ==
X-Gm-Message-State: ABy/qLYby99P1Ft8f/2sB2iyPZnLjk87DhW7SImgnxJGgTTTeG7e7CwX
	Sr4aXLVW//eSWInkaQKgZw==
X-Google-Smtp-Source: APBJJlEQRyh+4D+seGmPPYqTNBcuLPc0EsQebyzIM5c0+NBt8EpMpmG+XXaPPCIZVkobGTcLUoFlEQ==
X-Received: by 2002:a5d:6452:0:b0:314:ac1:d12a with SMTP id d18-20020a5d6452000000b003140ac1d12amr6381697wrw.26.1689416351188;
        Sat, 15 Jul 2023 03:19:11 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b003062b2c5255sm13361604wrx.40.2023.07.15.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 03:19:10 -0700 (PDT)
Date: Sat, 15 Jul 2023 13:19:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH] net: delete "<< 1U" cargo-culting
Message-ID: <7b6fdc07-fd7c-48eb-ad17-cc5e436c065b@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

6.5.7 §3 "Bitwise shift operators" clearly states that

        The type of the result is that of the promoted left operand

All those integer constant suffixes in the right operand are pointless,
delete them.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 28444e5924f9..febfae05b8a4 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -520,7 +520,7 @@ static inline int ksz_write64(struct ksz_device *dev, u32 reg, u64 value)
 	/* Ick! ToDo: Add 64bit R/W to regmap on 32bit systems */
 	value = swab64(value);
 	val[0] = swab32(value & 0xffffffffULL);
-	val[1] = swab32(value >> 32ULL);
+	val[1] = swab32(value >> 32);
 
 	return regmap_bulk_write(ksz_regmap_32(dev), reg, val, 2);
 }
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_phyp.c b/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
index e63716e139f5..0fb54e5c3b4b 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
@@ -442,7 +442,7 @@ u64 ehea_h_register_smr(const u64 adapter_handle, const u64 orig_mr_handle,
 				 adapter_handle	      ,		 /* R4 */
 				 orig_mr_handle,		 /* R5 */
 				 vaddr_in,			 /* R6 */
-				 (((u64)access_ctrl) << 32ULL),	 /* R7 */
+				 (((u64)access_ctrl) << 32),	 /* R7 */
 				 pd,				 /* R8 */
 				 0, 0, 0, 0);			 /* R9-R12 */
 
@@ -487,7 +487,7 @@ u64 ehea_h_alloc_resource_mr(const u64 adapter_handle, const u64 vaddr,
 				 5,				   /* R5 */
 				 vaddr,				   /* R6 */
 				 length,			   /* R7 */
-				 (((u64) access_ctrl) << 32ULL),   /* R8 */
+				 (((u64) access_ctrl) << 32),	   /* R8 */
 				 pd,				   /* R9 */
 				 0, 0, 0);			   /* R10-R12 */
 
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index a187582d2299..b60e8f1e656d 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -389,7 +389,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
  */
 #define E1000_SYSTIM_OVERFLOW_PERIOD	(HZ * 60 * 60 * 4)
 #define E1000_MAX_82574_SYSTIM_REREADS	50
-#define E1000_82574_SYSTIM_EPSILON	(1ULL << 35ULL)
+#define E1000_82574_SYSTIM_EPSILON	(1ULL << 35)
 
 /* hardware capability, feature, and workaround flags */
 #define FLAG_HAS_AMT                      BIT(0)
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
index 4b8bc46f55c2..0494eebe2aca 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -35,7 +35,7 @@ struct qlcnic_ms_reg_ctrl {
 #ifndef readq
 static inline u64 readq(void __iomem *addr)
 {
-	return readl(addr) | (((u64) readl(addr + 4)) << 32LL);
+	return readl(addr) | (((u64) readl(addr + 4)) << 32);
 }
 #endif
 
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index bb9ed971a97c..11e133e936b7 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -868,14 +868,14 @@ enum DIE_DT {
 #define INFO1_TXC		BIT(3)
 
 /* For transmission */
-#define INFO1_TSUN(val)		((u64)(val) << 8ULL)
-#define INFO1_IPV(prio)		((u64)(prio) << 28ULL)
-#define INFO1_CSD0(index)	((u64)(index) << 32ULL)
-#define INFO1_CSD1(index)	((u64)(index) << 40ULL)
-#define INFO1_DV(port_vector)	((u64)(port_vector) << 48ULL)
+#define INFO1_TSUN(val)		((u64)(val) << 8)
+#define INFO1_IPV(prio)		((u64)(prio) << 28)
+#define INFO1_CSD0(index)	((u64)(index) << 32)
+#define INFO1_CSD1(index)	((u64)(index) << 40)
+#define INFO1_DV(port_vector)	((u64)(port_vector) << 48)
 
 /* For reception */
-#define INFO1_SPN(port)		((u64)(port) << 36ULL)
+#define INFO1_SPN(port)		((u64)(port) << 36)
 
 /* For timestamp descriptor in dptrl (Byte 4 to 7) */
 #define TS_DESC_TSUN(dptrl)	((dptrl) & GENMASK(7, 0))
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 8c019f382a7f..0a657ab2f8c0 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -2279,7 +2279,7 @@ int efx_ef10_tx_tso_desc(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
 	 */
 	ip_tot_len = 0x10000 - EFX_TSO2_MAX_HDRLEN;
 	EFX_WARN_ON_ONCE_PARANOID(mss + EFX_TSO2_MAX_HDRLEN +
-				  (tcp->doff << 2u) > ip_tot_len);
+				  (tcp->doff << 2) > ip_tot_len);
 
 	if (ip->version == 4) {
 		ip->tot_len = htons(ip_tot_len);
diff --git a/drivers/net/ethernet/sfc/siena/tx_common.c b/drivers/net/ethernet/sfc/siena/tx_common.c
index a7a9ab304e13..da2f539ab249 100644
--- a/drivers/net/ethernet/sfc/siena/tx_common.c
+++ b/drivers/net/ethernet/sfc/siena/tx_common.c
@@ -319,10 +319,10 @@ static int efx_tx_tso_header_length(struct sk_buff *skb)
 	if (skb->encapsulation)
 		header_len = skb_inner_transport_header(skb) -
 				skb->data +
-				(inner_tcp_hdr(skb)->doff << 2u);
+				(inner_tcp_hdr(skb)->doff << 2);
 	else
 		header_len = skb_transport_header(skb) - skb->data +
-				(tcp_hdr(skb)->doff << 2u);
+				(tcp_hdr(skb)->doff << 2);
 	return header_len;
 }
 
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 9f2393d34371..275c3b1a60f6 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -338,10 +338,10 @@ int efx_tx_tso_header_length(struct sk_buff *skb)
 	if (skb->encapsulation)
 		header_len = skb_inner_transport_header(skb) -
 				skb->data +
-				(inner_tcp_hdr(skb)->doff << 2u);
+				(inner_tcp_hdr(skb)->doff << 2);
 	else
 		header_len = skb_transport_header(skb) - skb->data +
-				(tcp_hdr(skb)->doff << 2u);
+				(tcp_hdr(skb)->doff << 2);
 	return header_len;
 }
 
diff --git a/drivers/net/ethernet/sfc/tx_tso.c b/drivers/net/ethernet/sfc/tx_tso.c
index d381d8164f07..6f308a96f7b1 100644
--- a/drivers/net/ethernet/sfc/tx_tso.c
+++ b/drivers/net/ethernet/sfc/tx_tso.c
@@ -159,7 +159,7 @@ static __be16 efx_tso_check_protocol(struct sk_buff *skb)
 		EFX_WARN_ON_ONCE_PARANOID(ipv6_hdr(skb)->nexthdr != NEXTHDR_TCP);
 	}
 	EFX_WARN_ON_ONCE_PARANOID((PTR_DIFF(tcp_hdr(skb), skb->data) +
-				   (tcp_hdr(skb)->doff << 2u)) >
+				   (tcp_hdr(skb)->doff << 2)) >
 				  skb_headlen(skb));
 
 	return protocol;
@@ -176,7 +176,7 @@ static int tso_start(struct tso_state *st, struct efx_nic *efx,
 
 	st->ip_off = skb_network_header(skb) - skb->data;
 	st->tcp_off = skb_transport_header(skb) - skb->data;
-	header_len = st->tcp_off + (tcp_hdr(skb)->doff << 2u);
+	header_len = st->tcp_off + (tcp_hdr(skb)->doff << 2);
 	in_len = skb_headlen(skb) - header_len;
 	st->header_len = header_len;
 	st->in_len = in_len;
diff --git a/drivers/net/fddi/skfp/fplustm.c b/drivers/net/fddi/skfp/fplustm.c
index 036062376c06..d94dedddc851 100644
--- a/drivers/net/fddi/skfp/fplustm.c
+++ b/drivers/net/fddi/skfp/fplustm.c
@@ -444,7 +444,7 @@ static void directed_beacon(struct s_smc *smc)
 	 * enable FORMAC to send endless queue of directed beacon
 	 * important: the UNA starts at byte 1 (not at byte 0)
 	 */
-	* (char *) a = (char) ((long)DBEACON_INFO<<24L) ;
+	* (char *) a = (char) ((long)DBEACON_INFO<<24) ;
 	a[1] = 0 ;
 	memcpy((char *)a+1, (char *) &smc->mib.m[MAC0].fddiMACUpstreamNbr, ETH_ALEN);
 
diff --git a/drivers/net/fddi/skfp/h/cmtdef.h b/drivers/net/fddi/skfp/h/cmtdef.h
index 4dd590d65d76..8559a29bcf9b 100644
--- a/drivers/net/fddi/skfp/h/cmtdef.h
+++ b/drivers/net/fddi/skfp/h/cmtdef.h
@@ -176,7 +176,7 @@
  * are used !
  */
 
-#define EV_TOKEN(class,event)	(((u_long)(class)<<16L)|((u_long)(event)))
+#define EV_TOKEN(class,event)	(((u_long)(class)<<16)|((u_long)(event)))
 #define EV_T_CLASS(token)	((int)((token)>>16)&0xffff)
 #define EV_T_EVENT(token)	((int)(token)&0xffff)
 
diff --git a/drivers/net/fddi/skfp/h/fplustm.h b/drivers/net/fddi/skfp/h/fplustm.h
index 6065b0799537..03ada2c8e9c8 100644
--- a/drivers/net/fddi/skfp/h/fplustm.h
+++ b/drivers/net/fddi/skfp/h/fplustm.h
@@ -246,10 +246,10 @@ struct s_smt_fp {
  */
 #ifdef	AIX
 #define MDR_REV
-#define	AIX_REVERSE(x)		((((x)<<24L)&0xff000000L)	+	\
-				 (((x)<< 8L)&0x00ff0000L)	+	\
-				 (((x)>> 8L)&0x0000ff00L)	+	\
-				 (((x)>>24L)&0x000000ffL))
+#define	AIX_REVERSE(x)		((((x)<<24)&0xff000000L)	+	\
+				 (((x)<< 8)&0x00ff0000L)	+	\
+				 (((x)>> 8)&0x0000ff00L)	+	\
+				 (((x)>>24)&0x000000ffL))
 #else
 #ifndef AIX_REVERSE
 #define	AIX_REVERSE(x)	(x)
@@ -257,10 +257,10 @@ struct s_smt_fp {
 #endif
 
 #ifdef	MDR_REV	
-#define	MDR_REVERSE(x)		((((x)<<24L)&0xff000000L)	+	\
-				 (((x)<< 8L)&0x00ff0000L)	+	\
-				 (((x)>> 8L)&0x0000ff00L)	+	\
-				 (((x)>>24L)&0x000000ffL))
+#define	MDR_REVERSE(x)		((((x)<<24)&0xff000000L)	+	\
+				 (((x)<< 8)&0x00ff0000L)	+	\
+				 (((x)>> 8)&0x0000ff00L)	+	\
+				 (((x)>>24)&0x000000ffL))
 #else
 #ifndef MDR_REVERSE
 #define	MDR_REVERSE(x)	(x)
diff --git a/drivers/net/fddi/skfp/smt.c b/drivers/net/fddi/skfp/smt.c
index dd15af4e98c2..51d195632dd5 100644
--- a/drivers/net/fddi/skfp/smt.c
+++ b/drivers/net/fddi/skfp/smt.c
@@ -443,10 +443,10 @@ void smt_event(struct s_smc *smc, int event)
 
 static int div_ratio(u_long upper, u_long lower)
 {
-	if ((upper<<16L) < upper)
+	if ((upper<<16) < upper)
 		upper = 0xffff0000L ;
 	else
-		upper <<= 16L ;
+		upper <<= 16 ;
 	if (!lower)
 		return 0;
 	return (int)(upper/lower) ;
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 43c1fb2d2c21..50719a3b9845 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -95,7 +95,7 @@ struct udp_sock {
 	int		forward_threshold;
 };
 
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 6)
 
 #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
 
diff --git a/net/ipv4/tcp_bic.c b/net/ipv4/tcp_bic.c
index 58358bf92e1b..356c7f7608a6 100644
--- a/net/ipv4/tcp_bic.c
+++ b/net/ipv4/tcp_bic.c
@@ -173,7 +173,7 @@ static u32 bictcp_recalc_ssthresh(struct sock *sk)
 		ca->last_max_cwnd = tcp_snd_cwnd(tp);
 
 	if (tcp_snd_cwnd(tp) <= low_window)
-		return max(tcp_snd_cwnd(tp) >> 1U, 2U);
+		return max(tcp_snd_cwnd(tp) >> 1, 2U);
 	else
 		return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
 }
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 1b34050a7538..f955bdd685e2 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -518,7 +518,7 @@ __bpf_kfunc u32 tcp_reno_ssthresh(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
-	return max(tcp_snd_cwnd(tp) >> 1U, 2U);
+	return max(tcp_snd_cwnd(tp) >> 1, 2U);
 }
 EXPORT_SYMBOL_GPL(tcp_reno_ssthresh);
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index bb23bb5b387a..ec33c5d21d05 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -110,7 +110,7 @@ __bpf_kfunc static u32 dctcp_ssthresh(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	ca->loss_cwnd = tcp_snd_cwnd(tp);
-	return max(tcp_snd_cwnd(tp) - ((tcp_snd_cwnd(tp) * ca->dctcp_alpha) >> 11U), 2U);
+	return max(tcp_snd_cwnd(tp) - ((tcp_snd_cwnd(tp) * ca->dctcp_alpha) >> 11), 2U);
 }
 
 __bpf_kfunc static void dctcp_update_alpha(struct sock *sk, u32 flags)
@@ -166,7 +166,7 @@ static void dctcp_react_to_loss(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	ca->loss_cwnd = tcp_snd_cwnd(tp);
-	tp->snd_ssthresh = max(tcp_snd_cwnd(tp) >> 1U, 2U);
+	tp->snd_ssthresh = max(tcp_snd_cwnd(tp) >> 1, 2U);
 }
 
 __bpf_kfunc static void dctcp_state(struct sock *sk, u8 new_state)
diff --git a/net/ipv4/tcp_lp.c b/net/ipv4/tcp_lp.c
index ae36780977d2..af8b2a7cc25d 100644
--- a/net/ipv4/tcp_lp.c
+++ b/net/ipv4/tcp_lp.c
@@ -318,7 +318,7 @@ static void tcp_lp_pkts_acked(struct sock *sk, const struct ack_sample *sample)
 	/* happened after inference
 	 * cut snd_cwnd into half */
 	else
-		tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) >> 1U, 1U));
+		tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) >> 1, 1U));
 
 	/* record this drop time */
 	lp->last_drop = now;
diff --git a/net/ipv4/tcp_veno.c b/net/ipv4/tcp_veno.c
index 366ff6f214b2..a405a0bd794e 100644
--- a/net/ipv4/tcp_veno.c
+++ b/net/ipv4/tcp_veno.c
@@ -202,7 +202,7 @@ static u32 tcp_veno_ssthresh(struct sock *sk)
 		return max(tcp_snd_cwnd(tp) * 4 / 5, 2U);
 	else
 		/* in "congestive state", cut cwnd by 1/2 */
-		return max(tcp_snd_cwnd(tp) >> 1U, 2U);
+		return max(tcp_snd_cwnd(tp) >> 1, 2U);
 }
 
 static struct tcp_congestion_ops tcp_veno __read_mostly = {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 63f7a09335c5..0c9e10ef9095 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -45,7 +45,7 @@ static u32 sockopt_seq_reset(const struct sock *sk)
 	 * will fail.
 	 */
 
-	return (u32)sk->sk_state << 24u;
+	return (u32)sk->sk_state << 24;
 }
 
 static void sockopt_seq_inc(struct mptcp_sock *msk)
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 460682759aed..eba580ec40e5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -111,7 +111,7 @@ __u32 BPF_PROG(dctcp_ssthresh, struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	ca->loss_cwnd = tp->snd_cwnd;
-	return max(tp->snd_cwnd - ((tp->snd_cwnd * ca->dctcp_alpha) >> 11U), 2U);
+	return max(tp->snd_cwnd - ((tp->snd_cwnd * ca->dctcp_alpha) >> 11), 2U);
 }
 
 SEC("struct_ops/dctcp_update_alpha")
@@ -150,7 +150,7 @@ static __always_inline void dctcp_react_to_loss(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	ca->loss_cwnd = tp->snd_cwnd;
-	tp->snd_ssthresh = max(tp->snd_cwnd >> 1U, 2U);
+	tp->snd_ssthresh = max(tp->snd_cwnd >> 1, 2U);
 }
 
 SEC("struct_ops/dctcp_state")
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de2..2e4c9e54bb01 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -34,7 +34,7 @@
 #endif
 
 #ifndef UDP_MAX_SEGMENTS
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 6)
 #endif
 
 #define CONST_MTU_TEST	1500

