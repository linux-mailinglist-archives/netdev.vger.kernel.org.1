Return-Path: <netdev+bounces-274498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULp7C35Zzml2nAYAu9opvQ
	(envelope-from <netdev+bounces-274498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4119388AA2
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9DB530378AF
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D73B47DD;
	Thu,  2 Apr 2026 11:32:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912253C4542;
	Thu,  2 Apr 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129564; cv=fail; b=FNtJrFaMLFPr/pfw1RQ9cHYQjRnpce/+Mcz1+nzNm70D87ohsodct45UCuGE32B7Bbqi0xmc2CZSc7FNXidHeCiSc9XRFqEHN1PTOdmV/WcE27KdDPqfgDUhBAZDiHHCVJhQ9KSAka4bRwXbk1ALp02rCMYAMs9RzeF6h5UT1UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129564; c=relaxed/simple;
	bh=NHqFS/AD+4k7VAq2lyr7gcRetERkE2/HQvkhgNtnZuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1dyupzWMjNX45YJCSiVlW/3R1jK6E79LoKw1BhvL7Z8VE/2sk6j2En0We6xmx79ewzRV9sI8FslTDDotahAZ8xQp7POKLkDPycQfRXzPny/zrYPEP4DaahkQ3gJiXrxECPbgyxWrZ+Cznc3Taso+8NQk46r0Cf+e0sW35q2X5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpsowHkNTL74T7rcNAW4LkwglDCmx/sLzfBt9xM/pglu0pKJA1VEfVdPxGrHRk1dBmF18s2D0dsPmWG8bc2o+Nn6k6ZIuJXftRp6iuiaew1YxnlJ7+/ZBGAg4VJtCOryu7pG9DdDPaUIVO2IH0OWzjgTEMBt+vstUopiKypvQ0KlOIHeja5UT44m+tlhRej0r0o4W7IsHktbOBUuWKrXJ0rPdcGBaVl/9MQ8e+EILnBSmxbx4VGR9YojluHOMXuBN7p3A9nIvja4MjPKA6iclIscvD3+gvd2Gqy+unPfGcLXBVQgSbKk494hw8Ml4aCKMQUgJoCk39DB2W48Qb9j/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHTooOOo2E9ELn8TwN0YULYn0ep6YgofaAW8ImZbCgs=;
 b=lT1W4RROOGdhLRzMRN7DUnS9Q1nXRCubDbCNFnn7K1pZ2beszQtdl2x9un1YFyIN5gOZPgSdB3oy64HZzADZGFyb/98blB2IktNBbABMpH8Kl3fRZdpnbgfRRTEa5pzwvtsnZysmdtqaisH3xosh3zQzGq8ceeeQyFJw1v4BMPI++6omhFksycwRacIi5I1Gd5HmYQ92tBHbKXIIqy7Vx8BLOKGWcQIjT3XtTJ2TBCcDmSAHjc+gCh5ff2xuBQmqesMYBQXfNHlB0xwS7Kf+Rgzs6L9hqDWbg7+0CY4IB9AKbdS1mvRlbKO5zTqL93+g1a4XmoG1l7UG+wvRYXO5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:23 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:23 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 22/22] riscv: dts: starfive: jhb100: Add clocks and resets nodes
Date: Thu,  2 Apr 2026 03:55:23 -0700
Message-Id: <20260402105523.447523-23-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn (10.2.0.210)
 To ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn (10.2.3.165)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1048:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1a9fc7-28fe-4c47-d1b3-08de90a67abb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RgmDTWw2VlPJyw1pbYhhvWRwzZ94cyrodQ7FC/ev/r1j3JoYFGf51VxpgRTL31r7i/KvgRW3dsAd7lf2movkApljnS8WYD062mTptSw7Luy9JYanvQJsqIDRsIDy1rPGJeIwJfmaj4aB0zH8x+9mgtkcCeWFbBfuNP/wp4nAEbBcEcLrquwJNnM9FHzp2KYLv/YNCMXzZ43UKICvdqx8sXv2TyVumOazAWsBoaquPtjhgSfr4pkhuVCx9Aq/TSnu3CP3Z+z0yhq/lRjgD2wUu40gktrZxbDoixQxwg19K54v4PH8e8rf9tFAMJSagBcO81TafVdGBokTQHoeWqCx1VieEwf3qnPdR6ypiNLblZxdUtkOtbqCB+ohUh6YiQFeM2TZp5WX+D37DxrWyJq2rTin/bbra9QndCdqvTKGK0H+sntKL7NVFiCMlQWMnJ1a0lt51LZvUAT1iA1maAOy9vLO4aEqTLE5z69SvxoJu4FAt9iPMWXzR1/IREvtsLsP/JBxhlMs55rPhrWp8sBEbOF99JiFg1tw1VXOdgvoqPwz4T87QmSvPpKB/uYHHjKbI5D7g08OvD0+LooSdjSlz0yBvFWoVMG/XB8V8oVNoxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQz6y7F9g3x8OQZp80eoaR7svk/ojalOz5J+7Usf2wMC7VAOtbMqb+5IYFUa?=
 =?us-ascii?Q?LChC82Xip1KvF3c/YOcwK8HmvlGCLU6ulRKSILhHiEnkY/L10HlQypUOE+lz?=
 =?us-ascii?Q?+dA1tYa3K0avBe8mvkZvQLFgE5P4LwXmvu/PkFBsnUSGznXeQKJozkNPWVpM?=
 =?us-ascii?Q?oIPGf2lvFQrY1xFHya+1JmqHLuU7zVtRqs86SeHKOiGe2KOxHBoApsasfDkR?=
 =?us-ascii?Q?kyshU2nRwwBLP7Cirdx27CG4Qpyn1Eu5Y3TT+JcGYzQjlqRFdbijHLxk/7Go?=
 =?us-ascii?Q?2cr51Ncc/I/deqXmYf37O/a4/YN/djByE8BNYCIWnzm2PCvzvpWYR1Z9mAsf?=
 =?us-ascii?Q?HDj2m0Et8Bea30mAHviMHRiH6QEY/GpP5cQvkQ3WoK++v85W1d/S9yvapcOX?=
 =?us-ascii?Q?Yy0SHhV/7t2AKpKaUJ1m+2JdOeGL1N0gFFmPvfTF7kmlDynDM1+H8RgKxydV?=
 =?us-ascii?Q?lkAiIUlHo9kJ6zAjQ6iQXRpJcPhbLORU0D5CBHAINub+Tj2HLo59X4lusQ+3?=
 =?us-ascii?Q?A2Y7zx7ZddayMahRHHqfOju4la7N8+VleGwUB9tCsMIg3WBsi22fdTOiQ1VU?=
 =?us-ascii?Q?fCnlZvX7hnN2rVrQLzf55Wb4u7ie86iWWVL/+9tvPSuj8S9Cj1Xau1k63fxv?=
 =?us-ascii?Q?yAKNhPRiRHSCpFLzQPSa48e4JxldDQIkothsmi4/3mvCPH19UwsexcIU7XdG?=
 =?us-ascii?Q?HznqyxA+qI2O2S+5ZZTRYuQexkaxjtxgEdq4eZ+na+sxVgTNTgH2KetmqzV9?=
 =?us-ascii?Q?pE2BACeXAMHpFg6FuA7syQgcEzojLnde0Jq/hJ9Uc2Gp0DLBlrf0hmY5zLEX?=
 =?us-ascii?Q?NWeIhajhyRY3J/KdsdJOnPWQOmEFKTuA4+ADSTEM+I8tCxSm4/ANYiNTc2Wy?=
 =?us-ascii?Q?sI3Q0d1OkE0PZkTnwdlMYFmAnu+LSneY4lKePbpWhhodw3bfMVFiXzaXizXH?=
 =?us-ascii?Q?cj4jcudJK0FKP+h8c3dK9oLeLrgi3s9cG3yIde3ImRQ9L4kucY84QruDhBjJ?=
 =?us-ascii?Q?jeMzppKaTatYlLiBcawLl46COVEfZ+TJhzNEMZUGtXu7I6e1V3yteFSKwmP2?=
 =?us-ascii?Q?3Fkr8qRkOlzhi7vrQ+byJ17J51yvCXxXLXb4x7V1VCc82YfcNYMd+/zGYzHi?=
 =?us-ascii?Q?QjPwLdIi5J5J5pl7sziJLYhkfIDvUfH19KfkCBZK5nY6UsT16ueGBFjmsZ2P?=
 =?us-ascii?Q?oD2RPKS6mDjn1rCW56zMFGK3U1BAackhQwvXjkj+MPmHaDzbocM6D25aIpdz?=
 =?us-ascii?Q?VvUcRfyJFRA721y7kWHoy0aX34RZzIA/D2SUBew4nM1Ix34vGgLrE88O4xlM?=
 =?us-ascii?Q?JCoFwMc9qKSQjFEx7uTA92tU3GtFN1NS2SHSGUSxgodX3u9EIARy2iiJljvN?=
 =?us-ascii?Q?lHzBS7sMKhPMomFcsJC4hPztaQ2JCxJxl2Mj8Ip4sI/cmi+HS5qZn2xO5fQ2?=
 =?us-ascii?Q?djQrpJHUMUoXwstuRNj0cGWkoxr6TXM/yY8/xqd1MVrRrEMjRQ6fsDxUZxRS?=
 =?us-ascii?Q?FLXsGcH3DTQDtydapMxMCPJNmBtTv279i8+E7E+wuDbHc9seY5Y8v1rHBg6I?=
 =?us-ascii?Q?ftb0MlUvaUTKfSOxCPm1njCVHYEu63RPymLtOWpznTUfP8hz5t6rIauP8z32?=
 =?us-ascii?Q?wDF5kXOzPxr+KvY8AOoU0xBxP8OsnbvhC1rMT3GmktUEK+39Ivpo5WhAITsC?=
 =?us-ascii?Q?9Vhpq0AMIWVYIvf+gkbo06kJk7pwX/AZ+Kfx2sIB+0mNA7Jhgk/HGcqdmdQu?=
 =?us-ascii?Q?9xl7W6eCvtNNzd2JSZLS3smTqtYHe381J8Pol0P34BDyql8vlDib?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1a9fc7-28fe-4c47-d1b3-08de90a67abb
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:23.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPv84z/8eiJHwOe7bibvubXkwt5RhJP8WFPAF21LTyD/jfJTcndxsU7ROouNOBAXa3ouKZ6+vRWOlL+LHFS1++YMqF0Gv+a7VZJOmp5cvrYEsHg0VLRt95e5k+aUFmn5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274498-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.927];
	DBL_PROHIBIT(0.00)[0.198.108.224:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.182.212.176:email,11b40000:email,starfivetech.com:email,starfivetech.com:mid,0.198.124.128:email,11c40000:email,11a08000:email,0.198.93.64:email]
X-Rspamd-Queue-Id: A4119388AA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add clocks and resets nodes for JHB100 RISC-V BMC SoC. They contain
sys0crg/sys1crg/sys2crg/per0crg/per1crg/per2crg/per3crg.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jhb100.dtsi | 198 ++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jhb100.dtsi b/arch/riscv/boot/dts/starfive/jhb100.dtsi
index 4d03470f78ab..700d00f800bc 100644
--- a/arch/riscv/boot/dts/starfive/jhb100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jhb100.dtsi
@@ -4,6 +4,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <dt-bindings/reset/starfive,jhb100-crg.h>
 
 / {
 	compatible = "starfive,jhb100";
@@ -268,12 +270,96 @@ pmu {
 			<0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;	/* Event ID 34 */
 	};
 
-	clk_uart: clk-uart {
-		compatible = "fixed-clock"; /* Initial clock handler for UART */
+	osc: osc {
+		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
+	pll0: pll0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2400000000>;
+	};
+
+	pll1: pll1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000000>;
+	};
+
+	pll2: pll2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <903168000>;
+	};
+
+	pll4: pll4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100700000>;
+	};
+
+	pll5: pll5 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100700000>;
+	};
+
+	pll6: pll6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2400000000>;
+	};
+
+	pll7: pll7 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1950000000>;
+	};
+
+	per2_gmac2_rgmii_rx: per2-gmac2-rgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per2_gmac2_rmii_ref: per2-gmac2-rmii-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	per2_gmac3_sgmii_tx: per2-gmac3-sgmii-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per2_gmac3_sgmii_rx: per2-gmac3-sgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per3_gmac0_rmii_rclki: per3-gmac0-rmii-rclki {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	per3_gmac1_sgmii_tx: per3-gmac1-sgmii-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per3_gmac1_sgmii_rx: per3-gmac1-sgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -315,12 +401,118 @@ bus_nioc: bus_nioc {
 			uart6: serial@11982000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x0 0x11982000 0x0 0x400>;
-				clocks = <&clk_uart>, <&clk_uart>;
+				clocks = <&per0crg JHB100_PER0CLK_SCLK_UART6>,
+					 <&per0crg JHB100_PER0CLK_APB_UART6>;
 				clock-names = "baudclk", "apb_pclk";
+				resets = <&per0crg JHB100_PER0RST_MAIN_RSTN_UART6>;
 				reg-io-width = <4>;
 				reg-shift = <2>;
 				status = "disabled";
 			};
+
+			per0crg: clock-controller@11a08000 {
+				compatible = "starfive,jhb100-per0crg";
+				reg = <0x0 0x11a08000 0x0 0x1000>;
+				clocks = <&osc>, <&pll6>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_400>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_800>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_600>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER0_200>;
+				clock-names = "osc", "pll6", "per0_400",
+					      "per0_800", "per0_600",
+					      "per0_200_init";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per1crg: clock-controller@11b40000 {
+				compatible = "starfive,jhb100-per1crg";
+				reg = <0x0 0x11b40000 0x0 0x1000>;
+				clocks = <&pll7>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER1_600>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER1_800>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER1_200>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER1_143>;
+				clock-names = "pll7", "per1_600",
+					      "per1_800", "per1_200",
+					      "per1_143";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per2crg: clock-controller@11bc0000 {
+				compatible = "starfive,jhb100-per2crg";
+				reg = <0x0 0x11bc0000 0x0 0x1000>;
+				clocks = <&sys0crg JHB100_SYS0CLK_BMCPER2_600>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER2_400>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER2_125>,
+					 <&per2_gmac2_rgmii_rx>,
+					 <&per2_gmac2_rmii_ref>,
+					 <&per2_gmac3_sgmii_tx>,
+					 <&per2_gmac3_sgmii_rx>,
+					 <&osc>;
+				clock-names = "per2_600", "per2_400", "per2_125",
+					      "per2_gmac2_rgmii_rx",
+					      "per2_gmac2_rmii_ref",
+					      "per2_gmac3_sgmii_tx",
+					      "per2_gmac3_sgmii_rx",
+					      "osc";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per3crg: clock-controller@11c40000 {
+				compatible = "starfive,jhb100-per3crg";
+				reg = <0x0 0x11c40000 0x0 0x1000>;
+				clocks = <&sys0crg JHB100_SYS0CLK_BMCPER3_600>,
+					 <&sys1crg JHB100_SYS1CLK_BMCPER3_100>,
+					 <&sys1crg JHB100_SYS1CLK_BMCPER3_125>,
+					 <&per3_gmac0_rmii_rclki>,
+					 <&per3_gmac1_sgmii_tx>,
+					 <&per3_gmac1_sgmii_rx>,
+					 <&osc>;
+				clock-names = "per3_600", "per3_100", "per3_125",
+					      "per3_gmac0_rmii_rclki",
+					      "per3_gmac1_sgmii_tx",
+					      "per3_gmac1_sgmii_rx",
+					      "osc";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys0crg: clock-controller@13000000 {
+				compatible = "starfive,jhb100-sys0crg";
+				reg = <0x0 0x13000000 0x0 0x4000>;
+				clocks = <&osc>, <&pll0>, <&pll1>,
+					 <&pll2>;
+				clock-names = "osc", "pll0", "pll1", "pll2";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys1crg: clock-controller@13004000 {
+				compatible = "starfive,jhb100-sys1crg";
+				reg = <0x0 0x13004000 0x0 0x4000>;
+				clocks = <&osc>, <&pll0>, <&pll1>,
+					 <&pll2>, <&pll4>, <&pll5>,
+					 <&sys0crg JHB100_SYS0CLK_NPU_600>;
+				clock-names = "osc", "pll0", "pll1", "pll2",
+					      "pll4", "pll5", "sys1_npu_600";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys2crg: clock-controller@13008000 {
+				compatible = "starfive,jhb100-sys2crg";
+				reg = <0x0 0x13008000 0x0 0x4000>;
+				clocks = <&osc>, <&pll1>,
+					 <&sys0crg JHB100_SYS0CLK_GPU0_600>,
+					 <&sys0crg JHB100_SYS0CLK_GPU1_600>;
+				clock-names = "osc", "pll1", "sys2_gpu0_600",
+					      "sys2_gpu1_600";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
 		};
 	};
 };
-- 
2.25.1


