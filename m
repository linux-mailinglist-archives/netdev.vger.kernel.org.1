Return-Path: <netdev+bounces-274523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LxAFOVlzmmXnQYAu9opvQ
	(envelope-from <netdev+bounces-274523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:49:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4F3893C1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1CD30B5086
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75573E51CB;
	Thu,  2 Apr 2026 12:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2123.outbound.protection.partner.outlook.cn [139.219.17.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34B1B4223;
	Thu,  2 Apr 2026 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133115; cv=fail; b=ferbFjEqx1wJBESBU47HvUEjCyXbANttgn3nXt1NihVrj76b7ZqDbXMbmqdVstuEkYxQr9GQhWPsn6fT8Ho757lGs7dr5Q/5HixcWiYliLdL4YmA4qT/Giid6ixlitBCPgDXyLvqD9UrWQ8O8+ZokALalK8VcQ55MQ+7h6AZp8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133115; c=relaxed/simple;
	bh=tsEh52wxCstECLAhPPOFXFxgNK6ZicV4gXG684ph/0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uFqAES4x7Pg84yKaXsxeN+hW7HLIfNlwO4RiiAFSj08MYOQjA4XgclhnciRCj1XrXBkjQIt+zheVG8/0i8lKrYNY/fQzgWzX+OvtruxAzbfcZ7y+DuzO2cSlTedJyIMWv23AL3YbGNv/cV7qoGGE0ufFe+VlIQ/qucjbUo7KmP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU7J47QgMjLQcoj8z1oR+GWQFp9Ski1NReKB8dx5B1mgcwM5WyCJ8iVh8glkBUwyM7D+XVANMh8Wk7o8O8HXq5DSqG/zPZ3yJK19xRtAVZT/oBFrumCYOu+ZlaN/aL6scgjeCHUY/qx6d/FoaEqE6Fs3jGEdW/R+94YnKK7kevzLsnyBRvXWzt/7Yo5KZOdijjc51fzHxUHX69CkSay10lIeyQqF/4E0ujXqTShqZfYkodavsTYtFeCsj/O/IuMeoTSFZVzOyUg1YRGRU4G7hPDOrN4hyGp+2DkwquQCZurUp350CmBMkYJCf0vA4CeQgSNTo7S6sN3x5zV+JRIpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9U4Q3PSBXSd118GFgPuPCMWWTP7x4VZPwboYdRbieo=;
 b=b67CggMqG+ndn8gA+fElDYZaY37BAjDEksITG957+sJfOz1W/fxL5jgv/9AZSnOeZsTFhF/OEXYYGH5emDquAPInCH5QvwwsxzyokaGbZkYNZpwCWgS+ycJSUcDLSqs4jeWAzTz0UFPexeF4/VS6Lu0sAgcx7mFWN6j9ITFaTaL6URk5aDNMtUXxJaBLepSE4VptygQbzoqHwCsfR0zUGGH4s//R1sUGyuqN1XralesnTTyRcjNl3zMqwiUiJJwrUCcn5bU2BlUaz6OoYUKHRB4DCaQFfcneQyUvVz4/33upjspuXpF8cXOeKqM5coP7EESHD7m8Kqedm11OpuEAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:55:52 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:52 +0000
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
Subject: [PATCH v1 05/22] dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset generator
Date: Thu,  2 Apr 2026 03:55:06 -0700
Message-Id: <20260402105523.447523-6-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2aad32-da3e-4d5e-4b1c-08de90a665bd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oZNaedrZ6JwZ3K4lp+6Vm2IvgU+yWPko+9r33jlb3PWE+3VPZNTC42i7bgCo/PJJ99iorTa3kcpAvTBDKBIx6IWh6JIlTMtW4GX4a6+l0zqvdECTtpLGO1WHDwbruQ7P4efuPeQea4LQAAvJf9w+x3bh/kU9j4LrBAsp9nTX8ssKapFNl7xa/02M55FGpbRTeMyaQwOtQ0jNRWcI0cnUL5Pg9SOB77HVDIVbhmsvyiJZGrDQTGhSJrNvR20FXLhedExReK/Om02bKTsZMB65v2OOE2jfkv97U/6U3jVwo0FdsfBYjl7tZnZMRQTO3bCv4BCfwkt9PIdXGI4FOC2lXBg0MeBUVGQqP5Gh3WmyURfKXrLFKnucIl/CAKNoeiVL5LDZc9dkQYcaQTr1cVs+qmK0L9Iujj5/BWGmcUsrERUSG3UpP81ArkmXakLpgXx7FRhuslEHxJ7Bql3NRor5FYeH9Qipy0ObUIjbE/GSKXq6qyGLA6RZF7aUun0uwCPpAEEhZPU0RtgV8DDLkkyBRawm0pW8/Zc3zZe0P2YYn5TtzxJLf8yT0LOaiuGOUDeWJu7lDi8uDmeF8N78fj1UDkQwLpT4hNRW5DTJjokpSU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FT7PwXD3zWxL5l6mNYhxDa6MsuxIM4319ns8RUKcQWT/vP+ZCbVfqb0k3KuI?=
 =?us-ascii?Q?yvaeMRU43VraLYA8nzYfc5Ewlzm9aRA4rQuoQyEOh3Wa5YzmDYdbklZ0sk0d?=
 =?us-ascii?Q?mch615b5KRyiraw/kdgBH9kJRM5YDK23mX2nf+T1rQQpjhfICANAPGH0+QEg?=
 =?us-ascii?Q?Vfwbzk/AVDzh5nLJbH5vLS+o9kaCponvoSiocPq/Oo9XTsUM4d3fy+r2MnG0?=
 =?us-ascii?Q?RaAwGu4WBvFAHTm8DT89VqEdRL9mq9Q9ln57cBqQU1SyfZDajRFgBebo98Da?=
 =?us-ascii?Q?SRRTC4CX54OdcXJQOz7+CTo1m+B2VDph6/fIs+gwuQiGGa0UH69m76GFYOWU?=
 =?us-ascii?Q?zpMVqLSPJcfpJ1kFFddwXJZgxfYtsoJXl3whOLv1CaOyYGygk2A1H6lYqgRp?=
 =?us-ascii?Q?GVFauR6PZRswcMSX30pxQOwJn4Y5JtiB49nL8c8V8Sz8LZNv93o8KseVOnUR?=
 =?us-ascii?Q?vnoqvsY2Syot1kyiJe/LOZylSaa7TkZethrsH7IkVjZDME1HPM2tVyVSVlmw?=
 =?us-ascii?Q?F8VJCX0BDhSDB7ov2aSsafqcz3inai09Y3qiGIoaz0cpdpvvS/jTsB9x6O0G?=
 =?us-ascii?Q?ikv0AvgDETMvZUVyraoEQ7h5dOfDNrkaUBvKHKJn8MIcXbVh1FlivhBpFyNI?=
 =?us-ascii?Q?yt2LLNYnwk4hZs0KUcBLvSQa0UcEuQkFNw/cazH1KOeKxt5Y0Ne/Cn6QL6Lt?=
 =?us-ascii?Q?nKI7El2PNnTolx9G0MlhIMb3gaQxf3r4qZJJ3Htrz0Ode1eunkvk+pV6wJ14?=
 =?us-ascii?Q?FWkVo0JqcjLLGyqpux9wxE3/GrNEGPT05VfH3UH0/8uiQN0x0ahJ8iQh7IyO?=
 =?us-ascii?Q?AhRo7jkfIm2fcmEEFRlHR2x4Zcr2uOeiMxCdSBWCvFf356qavrOTo8y9jId3?=
 =?us-ascii?Q?iaTRZqUJD6Inp03kmmq9t4itEXkVrSNvd7kp0EixXckA4UooJEcq5AKXYdpe?=
 =?us-ascii?Q?xpdk7GqHkCexb9w+euHZpwH6kPJNysdvY/LBI9SGcnTTsUll9AtrKSYEdQel?=
 =?us-ascii?Q?G6lxLtT08RnUvRfVCRzY0KoRhWjX+Ldwzy/P1ZjaAvPsi8cgy6XBr+KwyP/t?=
 =?us-ascii?Q?Ljpq3sdgYdKJKbrwM2rouNTApW8Ko9lsw5O7bsB5dpEx0tlyU6Cb+KdJqMnO?=
 =?us-ascii?Q?i+BPuiC3oP3/LYCOoZsj3xsilzGmQW0VphAk1gbkAv4tEhVAFWXF1jj/JO4c?=
 =?us-ascii?Q?61+prXsNJkq0z5IDz0vboC9RbbVji68uIAvHyLWtlvvWD8njiMtpcAS8Vca6?=
 =?us-ascii?Q?9fBz8A0ex36OpBc0O0LIva+qSJoUNa3lfe0n6qLGK4NEGMyOfP9iJESi6M05?=
 =?us-ascii?Q?U4rJpxCrDg8IjS7kfjOkviR0zleb/oDZ/hQWsmEC62i/1e8NKCT+EDHHQNj8?=
 =?us-ascii?Q?BSL+H6b1qrZ3pI1ZM3bgKj1bug+0hJrDnHJERujZf/E9Kf6KFlr9zQcYWvGR?=
 =?us-ascii?Q?TCVz/X25iJkYaFWU7BXEvXtyNybdgIJU8CRYJJa4XEh9+KrpmQEXa+2Chawm?=
 =?us-ascii?Q?voOa8MbAzdt4QRobXyBcsA+G8mj3ipl/u91lD2WSXlm8jpvhgngmE+D8qJYl?=
 =?us-ascii?Q?tV5A7sBm9bhLcuCdl6soy2RphkVoiJAgQxqkoZaH5Gfn78l6lD0uBdt4MB2I?=
 =?us-ascii?Q?59jzSqgegIigEW7tcp0e9jIu3/6UcccoHdQSQPqeQvHAN6VXuh3WVCIfhGMS?=
 =?us-ascii?Q?HVdwogy/DDHosnAHqa5qm5ovAsRKOkMExx/V2IIbHYjuKzqZR3g+7Ed/hkY8?=
 =?us-ascii?Q?CIRJYxeGDrzcYQki2r4s3uhIu59mZmY57SGw0XgN6xS1OjyYhob4?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2aad32-da3e-4d5e-4b1c-08de90a665bd
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:52.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itXYiEl/cMCmHxI8l5I83c7Vi0g9upqKbf5k26V+wjdNkWShsgdH/tz+veZZl5Tt0+hlrx27Pjp71n2yxUMkU7Lz6JMGpXQw7WQgxH9oIKjklYRwtBdJCD3cKD6D5bdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096
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
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274523-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.629];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,0.198.93.64:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1F4F3893C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for the System-0 clocks and reset generator (SYS0CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-sys0crg.yaml        | 63 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 56 +++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 30 +++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
new file mode 100644
index 000000000000..08016a61992c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys0crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-0 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys0crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL0
+      - description: PLL1
+      - description: PLL2
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll0
+      - const: pll1
+      - const: pll2
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jhb100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive-jhb100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@13000000 {
+      compatible = "starfive,jhb100-sys0crg";
+      reg = <0x13000000 0x4000>;
+      clocks = <&osc>, <&pll0>, <&pll1>,
+               <&syspll 0>;
+      clock-names = "osc", "pll0", "pll1", "pll2";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
new file mode 100644
index 000000000000..b257cd104a10
--- /dev/null
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__
+
+/* SYS0CRG clocks */
+#define JHB100_SYS0CLK_BMCPCIERP_600			17
+#define JHB100_SYS0CLK_BMCPCIERP_100			18
+
+#define JHB100_SYS0CLK_PCIE_REF_CML			20
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_DATA_INIT	21
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG_INIT		22
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_TARG		23
+
+#define JHB100_SYS0CLK_BMCPCIERP_PCU			26
+#define JHB100_SYS0CLK_HOSTSS0_100			27
+#define JHB100_SYS0CLK_HOSTSS0_600			28
+#define JHB100_SYS0CLK_HOSTSS0_PHY_SCAN_400		29
+#define JHB100_SYS0CLK_GPIO_ESPI0_66			30
+
+#define JHB100_SYS0CLK_BMCUSB_600			34
+#define JHB100_SYS0CLK_BMCUSB_200			35
+#define JHB100_SYS0CLK_BMCUSB_SCANCLK			36
+#define JHB100_SYS0CLK_BMCUSB_480M_SCANCLK		37
+
+#define JHB100_SYS0CLK_VCE_600				50
+#define JHB100_SYS0CLK_VCE_100				51
+#define JHB100_SYS0CLK_BMCPER2_600			52
+#define JHB100_SYS0CLK_BMCPER2_100			53
+#define JHB100_SYS0CLK_BMCPER2_400			54
+#define JHB100_SYS0CLK_BMCPER2_125			55
+
+#define JHB100_SYS0CLK_HOSTSS1_600			58
+#define JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400		59
+#define JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400_ICG_BUF	60
+#define JHB100_SYS0CLK_NPU_600				61
+#define JHB100_SYS0CLK_VOUT_600				62
+#define JHB100_SYS0CLK_VOUT_AUX				63
+
+#define JHB100_SYS0CLK_BMCPER3_600			65
+#define JHB100_SYS0CLK_HOSTUSB_600			66
+#define JHB100_SYS0CLK_HOSTUSBCMN_480			67
+#define JHB100_SYS0CLK_BMCPER1_600			68
+#define JHB100_SYS0CLK_BMCPER1_800			69
+#define JHB100_SYS0CLK_BMCPER0_600			70
+#define JHB100_SYS0CLK_BMCPER0_400			71
+#define JHB100_SYS0CLK_BMCPER0_800			72
+#define JHB100_SYS0CLK_GPU0_600				73
+#define JHB100_SYS0CLK_GPU1_600				74
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
new file mode 100644
index 000000000000..71affdcdf733
--- /dev/null
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
+
+/* SYS0CRG resets */
+#define JHB100_SYS0RST_RESOURCE_ARB					0
+
+#define JHB100_SYS0RST_SYS0_IOMUX_PRESETN				3
+#define JHB100_SYS0RST_SYS0H_IOMUX_PRESETN				4
+#define JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN				5
+
+#define JHB100_SYS0RST_BMCPCIERP_RSTN_BUS				14
+#define JHB100_SYS0RST_BMCPCIERP_RSTN_CRG				15
+#define JHB100_SYS0RST_HOSTSS0_RSTN_BUS_ESPI				16
+#define JHB100_SYS0RST_HOSTSS0_RSTN_BUS_PCIE				17
+#define JHB100_SYS0RST_HOSTSS0_RSTN_CRG					18
+#define JHB100_SYS0RST_BMCPERIPH2_RSTN_CRG				19
+#define JHB100_SYS0RST_BMCPERIPH2_RSTN_BUS				20
+#define JHB100_SYS0RST_VCE_RSTN_CRG					21
+#define JHB100_SYS0RST_VCE_RSTN_BUS					22
+#define JHB100_SYS0RST_BMCUSB_RSTN_BUS					23
+#define JHB100_SYS0RST_BMCUSB_RSTN_CRG					24
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


