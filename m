Return-Path: <netdev+bounces-212832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785EFB22366
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FBA3AD8A4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536F2E92C6;
	Tue, 12 Aug 2025 09:39:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18512E88B7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991555; cv=none; b=WEBF5a8+kp6/zT/nlwxb4GLR2+5vO3vEjvSrHbFUnnh6VeiX2d1lJjN16v74DuyGDk/J7/Cwkfzv5+yeawj+lGbwCWHXELEWGRY2gPrFDHdmNn4aPqmMZOGwgG8at4htvuUgZpjORBt91Q/93MCkUVONnUvPPxrTur/bTL0CfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991555; c=relaxed/simple;
	bh=8KXrIixzJItRVf4s4Bxjj7iCOo+Vc+kTkiqsKAcPOWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRbgEEbXsmdTJnmTc19bxIrj/Rr6LUcPdKIGUGePnTu/G5O32xoMin8QPCjtFrcCPI+i28prn6Mn+3VuI3GI2jqsQPOqSZhDBR3La3fxKt87pDtLoPjB7OBjxz/xFS6o+z3b720SffM6LBolfCPkk52i+WNoAAdthI2BUWpx3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz7t1754991480tf32bda96
X-QQ-Originating-IP: olEu+ZTQQ9T+3zy5s32qZqTraug2M5sQP/jNKHBeJnk=
Received: from w-MS-7E16.trustnetic.com ( [125.120.182.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 17:37:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13738346805225385979
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] net: libwx: cleanup VF register macros
Date: Tue, 12 Aug 2025 17:37:25 +0800
Message-ID: <778899EE1D862EC2+20250812093725.58821-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NbxLaS4t14pp8jyZdohfUjVaUsNfq2Eqq0mmFXe/WT+lX22a0oym8/eM
	xHOeJJaJNrlmXHzsOIdZIXBJFcsT7UIhiCyT85eHr2XJbMgec5EoK0Mr+DqVEfsvKSqRzxI
	Tcu5yHo96CRqZd0Cj3fF3Zg7UkU3pC8DAMRSAuOui/v74CeTF32VSzx1YYWkefYEX/U8Thl
	NnA5o8TwDUYEiQq5Tjoy4FlWALfj2Ye4g9saNI0vpKxrESTdC1JWJxv3WNywgVUl8kj7Lex
	etu15CuosAaLX2MrLRGBCYbzR6ijUzvKTGFkHse+4TKH7cdaRuJHF6ADaYkOjQEM2GCxE6z
	Y0EikrM4sxrtVzUIqqrOt2HtPLZV3CPNc9I6Z0fcQC+kAJznsxigqbkD0iiYI1OhO8hOt02
	waQl9TNaQ/mB6dNAHJmXK3nesRanI/Up+XYD9uxQ3WxGWydPRxfTS5H1K876AwtPMJUifaB
	hxp0+O6ZSElbnFDtT1lRF35CWeCQXcOeKbzgu0XJvvmwG2as/KUoRE5C2Qcx+GAWy1KN3ed
	qLc3Nt9MLzBmt7FO1TkRPicEy6k9lBdQMaSLVK8FM41x+99DO7gk2Ey+B4/mM9QW/hSbKyZ
	CAJ5nOKXYHz7ZPr0hin6YtlHmpfWu3FOqivAEztsa158LG92u++Br4hKMJVCAJfSswzhS+z
	Ut4TnedlUUpkJDzi5DPdftMIl5eDPOJszvIWUh4p/SqegNT3rs3gkZY4Kk8IHq1CStr+bKu
	Zt3mPuc1s6oZhc4jaAcL5r6bEhIFm1/6SLwJQfWkb1WF7DkzllbDWho1SpL6A1wekolYBd8
	MdaFI0uf8CLSsPO8wxFoWz0WA0ZOXrM0GoQA4Ha8b/mZvO+tOd4WatKkLKTHsfVNlJ/d6YS
	p904zRWj/9PqTjdWIE4U/XiLzwq5/c3PVj7fgr0P4uEy89o2SliMI/hbFrvB7aydoANSV5L
	+8PFoAmu0ClGMM/7DHz8V3mtwVhixQ14XFuRjSPzAaCs3WA5RZACdyBqdZ3V8sDG9Mi4T01
	3OUAFMhRwc8fV5sAVSbKEzuAM4kLBk1ShKikoTqy+cYnzuVXJ+
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Adjust the order of VF regitser macros, make it elegant.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_vf.h | 72 +++++++++++-----------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index fec1126703e3..3f16de0fa427 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -4,6 +4,7 @@
 #ifndef _WX_VF_H_
 #define _WX_VF_H_
 
+/* Control registers */
 #define WX_VF_MAX_RING_NUMS      8
 #define WX_VX_PF_BME             0x4B8
 #define WX_VF_BME_ENABLE         BIT(0)
@@ -12,16 +13,32 @@
 #define WX_VXCTRL_RST            BIT(0)
 
 #define WX_VXMRQC                0x78
+#define WX_VXMRQC_PSR_L4HDR      BIT(0)
+#define WX_VXMRQC_PSR_L3HDR      BIT(1)
+#define WX_VXMRQC_PSR_L2HDR      BIT(2)
+#define WX_VXMRQC_PSR_TUNHDR     BIT(3)
+#define WX_VXMRQC_PSR_TUNMAC     BIT(4)
+#define WX_VXMRQC_PSR_MASK       GENMASK(5, 1)
+#define WX_VXMRQC_PSR(f)         FIELD_PREP(GENMASK(5, 1), f)
+#define WX_VXMRQC_RSS_HASH(f)    FIELD_PREP(GENMASK(15, 13), f)
+#define WX_VXMRQC_RSS_MASK       GENMASK(31, 16)
+#define WX_VXMRQC_RSS(f)         FIELD_PREP(GENMASK(31, 16), f)
+#define WX_VXMRQC_RSS_ALG_IPV4_TCP   BIT(0)
+#define WX_VXMRQC_RSS_ALG_IPV4       BIT(1)
+#define WX_VXMRQC_RSS_ALG_IPV6       BIT(4)
+#define WX_VXMRQC_RSS_ALG_IPV6_TCP   BIT(5)
+#define WX_VXMRQC_RSS_EN             BIT(8)
+
+#define WX_VXRSSRK(i)            (0x80 + ((i) * 4)) /* i=[0,9] */
+#define WX_VXRETA(i)             (0xC0 + ((i) * 4)) /* i=[0,15] */
+
+/* Interrupt registers */
 #define WX_VXICR                 0x100
 #define WX_VXIMS                 0x108
 #define WX_VXIMC                 0x10C
 #define WX_VF_IRQ_CLEAR_MASK     7
 #define WX_VF_MAX_TX_QUEUES      4
 #define WX_VF_MAX_RX_QUEUES      4
-#define WX_VXTXDCTL(r)           (0x3010 + (0x40 * (r)))
-#define WX_VXRXDCTL(r)           (0x1010 + (0x40 * (r)))
-#define WX_VXRXDCTL_ENABLE       BIT(0)
-#define WX_VXTXDCTL_FLUSH        BIT(26)
 
 #define WX_VXITR(i)              (0x200 + (4 * (i))) /* i=[0,1] */
 #define WX_VXITR_MASK            GENMASK(8, 0)
@@ -29,16 +46,6 @@
 #define WX_VXIVAR_MISC           0x260
 #define WX_VXIVAR(i)             (0x240 + (4 * (i))) /* i=[0,3] */
 
-#define WX_VXRXDCTL_RSCMAX(f)    FIELD_PREP(GENMASK(24, 23), f)
-#define WX_VXRXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
-#define WX_VXRXDCTL_BUFSZ(f)     FIELD_PREP(GENMASK(11, 8), f)
-#define WX_VXRXDCTL_HDRSZ(f)     FIELD_PREP(GENMASK(15, 12), f)
-
-#define WX_VXRXDCTL_RSCMAX_MASK  GENMASK(24, 23)
-#define WX_VXRXDCTL_BUFLEN_MASK  GENMASK(6, 1)
-#define WX_VXRXDCTL_BUFSZ_MASK   GENMASK(11, 8)
-#define WX_VXRXDCTL_HDRSZ_MASK   GENMASK(15, 12)
-
 #define wx_conf_size(v, mwidth, uwidth) ({ \
 	typeof(v) _v = (v); \
 	(_v == 2 << (mwidth) ? 0 : _v >> (uwidth)); \
@@ -59,44 +66,35 @@
 #define WX_VXRDBAH(r)            (0x1004 + (0x40 * (r)))
 #define WX_VXRDT(r)              (0x1008 + (0x40 * (r)))
 #define WX_VXRDH(r)              (0x100C + (0x40 * (r)))
-
+#define WX_VXRXDCTL(r)           (0x1010 + (0x40 * (r)))
+#define WX_VXRXDCTL_ENABLE       BIT(0)
+#define WX_VXRXDCTL_BUFLEN_MASK  GENMASK(6, 1)
+#define WX_VXRXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
+#define WX_VXRXDCTL_BUFSZ_MASK   GENMASK(11, 8)
+#define WX_VXRXDCTL_BUFSZ(f)     FIELD_PREP(GENMASK(11, 8), f)
+#define WX_VXRXDCTL_HDRSZ_MASK   GENMASK(15, 12)
+#define WX_VXRXDCTL_HDRSZ(f)     FIELD_PREP(GENMASK(15, 12), f)
+#define WX_VXRXDCTL_RSCMAX_MASK  GENMASK(24, 23)
+#define WX_VXRXDCTL_RSCMAX(f)    FIELD_PREP(GENMASK(24, 23), f)
 #define WX_VXRXDCTL_RSCEN        BIT(29)
 #define WX_VXRXDCTL_DROP         BIT(30)
 #define WX_VXRXDCTL_VLAN         BIT(31)
 
+/* Transimit Path */
 #define WX_VXTDBAL(r)            (0x3000 + (0x40 * (r)))
 #define WX_VXTDBAH(r)            (0x3004 + (0x40 * (r)))
 #define WX_VXTDT(r)              (0x3008 + (0x40 * (r)))
 #define WX_VXTDH(r)              (0x300C + (0x40 * (r)))
-
+#define WX_VXTXDCTL(r)           (0x3010 + (0x40 * (r)))
 #define WX_VXTXDCTL_ENABLE       BIT(0)
 #define WX_VXTXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
 #define WX_VXTXDCTL_PTHRESH(f)   FIELD_PREP(GENMASK(11, 8), f)
 #define WX_VXTXDCTL_WTHRESH(f)   FIELD_PREP(GENMASK(22, 16), f)
-
-#define WX_VXMRQC_PSR(f)         FIELD_PREP(GENMASK(5, 1), f)
-#define WX_VXMRQC_PSR_MASK       GENMASK(5, 1)
-#define WX_VXMRQC_PSR_L4HDR      BIT(0)
-#define WX_VXMRQC_PSR_L3HDR      BIT(1)
-#define WX_VXMRQC_PSR_L2HDR      BIT(2)
-#define WX_VXMRQC_PSR_TUNHDR     BIT(3)
-#define WX_VXMRQC_PSR_TUNMAC     BIT(4)
-
-#define WX_VXRSSRK(i)            (0x80 + ((i) * 4)) /* i=[0,9] */
-#define WX_VXRETA(i)             (0xC0 + ((i) * 4)) /* i=[0,15] */
-
-#define WX_VXMRQC_RSS(f)         FIELD_PREP(GENMASK(31, 16), f)
-#define WX_VXMRQC_RSS_MASK       GENMASK(31, 16)
-#define WX_VXMRQC_RSS_ALG_IPV4_TCP   BIT(0)
-#define WX_VXMRQC_RSS_ALG_IPV4       BIT(1)
-#define WX_VXMRQC_RSS_ALG_IPV6       BIT(4)
-#define WX_VXMRQC_RSS_ALG_IPV6_TCP   BIT(5)
-#define WX_VXMRQC_RSS_EN             BIT(8)
-#define WX_VXMRQC_RSS_HASH(f)    FIELD_PREP(GENMASK(15, 13), f)
+#define WX_VXTXDCTL_FLUSH        BIT(26)
 
 #define WX_PFLINK_STATUS(g)      FIELD_GET(BIT(0), g)
 #define WX_PFLINK_SPEED(g)       FIELD_GET(GENMASK(31, 1), g)
-#define WX_VXSTATUS_SPEED(g)      FIELD_GET(GENMASK(4, 1), g)
+#define WX_VXSTATUS_SPEED(g)     FIELD_GET(GENMASK(4, 1), g)
 
 struct wx_link_reg_fields {
 	u32 mac_type;
-- 
2.48.1


