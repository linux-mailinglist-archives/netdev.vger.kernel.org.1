Return-Path: <netdev+bounces-272065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMAqFHk1xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:32:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7AD336006
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD064305E373
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0ED386C0A;
	Thu, 26 Mar 2026 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFc8/ToL"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34882D8379;
	Thu, 26 Mar 2026 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531730; cv=fail; b=T1NW0j30VwzpgKRYWtj6+rbQigMe3NKzzokjapEZ7v4UXJQ34MLgKF11qK3kK261I/tS77NFCbbklPGdOfK0A7tp8htKVc3UUZTHz2TSUQjm91t4+ZUKIq/JbJBjm527ijvk8ceKRaOiXhSa/3RGjQeiBH+M37C6ahpNKC3hDOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531730; c=relaxed/simple;
	bh=+UO7DZH0bs/ZfvgbiHUptVJzUI52pXM1zsBFtcI+DCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9JiwE8UAPGd1JcidZoLqF7OYtE1z0LUmrKwjGwtjBhQQaGMiO0ejaDYUYWmuSioinO8TxJivKY+fGfJhnQYCBYg9olK1pB2WyGzD36nUU0kYEVFFAdG0N60SB1ZAohbChQf486loTLUB1U2GWnFX8iOZskfqlvKtD3hwc0EsfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JFc8/ToL; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+sHoLqoz8AAshf/rmK28QQOaWpH42LCeC+VFJIkEUDIWsM8NnbqxSjCIxISW0VKYMF+77/UpV/+ivO283tdJOexRQ8FuOjK6w8GH2zrMApnqY8LkIEXkQ7WD1wsv+wtkohz1+hgbfA6QtXYbUZ7YdK0UewCerBy8zQ23R4fRHXJhFKaWZhsYlrGeDef3iCTIExBz/SBP4Gufdn28EMkGpQAY2hqjAnwZ86AE+41nge66zPNzqL0ofl1rUOyf0eCeFFYOlzIJYxpnhF1L7oMel7FEW/VRX5ZEG9ykG14lxC/O3NIOnatY1G8L4wdfsmliFuUSBbr1ojMy/pxY0UnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8S8E8JwbuECkRPplODiyz4gHYoYz3IYZz8bKz5nvxI=;
 b=tlIPmca2h5iPmyF4YKgPGIxzEZcYhMx8M5BR8X3+oKVzKTy3acRUIoK1peZUNdDjQ4MBq/Ck3uyoOeiW9Z9OGo1d6MSlzDqdZWVaXeRsbU+5qujjDZ/VPlpXe49eOKQzt2DG+bOu8vaVcgGGwvkP+a1dKfXmK+sQox5BPBwmD8g7K6/jP6C/913krILLtcajCgwsugYfEZBS7SkxBzWsHMJkn14caIrp+yevzFDoqNi1/J2nz7aQ8igCr/mWXeotErsc0GUD+7yxKc/AK6CzogMb8FVxmlGDN4GFtnwOOJY+z3h+uY1EUWz1CCOri9Tv8XeZk20eqSkkHRNXdeeo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8S8E8JwbuECkRPplODiyz4gHYoYz3IYZz8bKz5nvxI=;
 b=JFc8/ToLObc0/CeIcLldXHKe1vYkp9ZCKJSnvIcQ438DCLRpADlFIT1uLRYbX0t31Q+KPVev3iu7qiM6S6GDjuwGqa5lEMsGUS4VXwwvfdx8dbt8qyjOwf3Fa6j+pFlv+zFdhK6VsfFoZXalLj0bfM+kohLazvVthWqmx5tAcNGYlpIjFjpdjbLia7qn36VWDWcSNM/Dh1DwYOYHyjpL5FByHEFBYHEoQL5yr+rrOjyZ3UUA1m95ODGPoUbJuDgk4xkSEw7BKsg4xKjADtuf75rdN8RcEI5uoavK6r25ERH8luwUsvaflw9I3gaFxp02Yt/xNu2ZxfyD2TYPuze5og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:28:46 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:46 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 02/10] selftests: net: add helpers for running a command on other targets
Date: Thu, 26 Mar 2026 15:28:20 +0200
Message-Id: <20260326132828.805703-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: d7122a3f-c4e4-4e44-cbb8-08de8b3b9bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eRJu0bcW0i9ac8FErVzZ1c8fEqUTh/r63UGW2NgOP9jIiFwyrB3vxrrfIaQhWGSW0SHs+DkQwSNkqFk3BUoh8xXMkdco+3rdGSzSzmIgp3VtFZc8sxFwGmTdHMb/dNACN4H7NZ6xWcIcMm9qfLFuvnbdGCluB20NHarqJd8HC7z5JMS3XrfjpMIx51ht6MyJblQOVXZxfqs/no+Y6a2vhmTdeEwv5ElhwcIWNTLeURaMEOl9jANkfCJ3ppLvoVU7hxcBEGD3EDbKUTv4ZuZuubHHUMKGtsZXoBmfytvFFWKTfcTqMpeIxWxZ5ZWo7z9nI/wZKtOrvKp1jF2K0M0H1ga9HrC5QkHib7ruF2CuNpjK/6BUrcKvrGnLRonDsLpCABVCUwfM2jIKiXMpnsyThr0KhIrA5MXBIJbropDcHQBrZED+UV0No4oVfBuhrCas/E61trM4l9LVzhG4qqdgRY5OYDdAMvfwasLRHXWZOlVNwdM908nqB5T3Ww0kdGqKMZCyX6t0Zw8MbcwOYUPzaDSYMJDH8biQug1HiA5HCqE2GaFhp6M6lHl8j9vOosskMRPehmZy6EsEG2H83EPooejWPZEUZ7icBV6rgTF3Vu1/BhY3P8oMch0JkvSClr3p+viB6JDrRhlkwl1Y/a7AvmhYGtfxfEKIntY5jQ3G5pMi5g4zI13fBh6Qe0rray50PWMIWS9gDlmK+FDTTrNCB2689WnCE4ASB/WDgjDHHvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T8BV9/k3WQdVRZTZW5dTnNFvIw45PJ4umTkb3QZLKTzMJP5/gcUrwlU8FX6Z?=
 =?us-ascii?Q?zAgR7YoG71S0rQ2+YmaUkTcY9TiH0IiwP1bqttQByaAfti6zkMqOurc2W6Q+?=
 =?us-ascii?Q?ESMzshk0nl+F2nAqnWsKLyTbIODGYuDmb/bUF1/az0yMCMs8i8B4zEDZO1JE?=
 =?us-ascii?Q?0hDG9/o5RlhVpoWhrH/0KBYZD1wmKCl4pKHaHofSIPxjVlZnWizzf3CcoLXe?=
 =?us-ascii?Q?WV1hlvUeqjnYcf8GW1oWdWzfSgZBcjBHU72WKt74i6FT+TNJPM1G8BMWJv+X?=
 =?us-ascii?Q?Olktv4BK/zXDDj8Yn5WeMdC6aLKCdH+mPGiwEdMfyLcUquw1mfdLf0/q0rOw?=
 =?us-ascii?Q?vNw0eUwz6eurTfavQjkv8yZRu7tCHxy6udMFvGQcIFxXd7172MSX4CbhyBcD?=
 =?us-ascii?Q?pambMdx+4EUPZnO5ISQdToHQT6oZk8tD17e3OaDOuirek0zOA1Nl0/N8Q80Q?=
 =?us-ascii?Q?JyLsuK2k0E3XE+lZyf7e0dJQ8woivsPZDEoEFwAWVPmfbk31HAdzTcTTAJZS?=
 =?us-ascii?Q?fj/WjPraeVgysbaD1QAxpYvcJ+seJwecBdiuceKlLDM3cKe64Rc3y6YAeteE?=
 =?us-ascii?Q?PkVRrup1my02ZAGUIhA6W3r5F6A/SnSmj2ZDXI2+pya7NVoaBXD28zLMb8W3?=
 =?us-ascii?Q?+Alm80fQ9/QfyTalSwB9WUvHj1Y0ZJkbznh3BTIYDZYQi7kamAjUkJlP7rwR?=
 =?us-ascii?Q?pGuAQlg+guYsbPT83iYT7jmDH+LgismJAJwtPMFSjMZ41maYC5QbTZcuncCK?=
 =?us-ascii?Q?6NQ8l1YjoczU9gYtCX+80sHpCUIM9iWOOIdQex370OkW6CJ561bFPTBffpJ1?=
 =?us-ascii?Q?Gx6MJRgKXMe8R3w523LzvGKSQUZ7F9dsmZxOW6t45DI+W/rc9v+QZZpj3YWA?=
 =?us-ascii?Q?G+9Zb+mwe5SZDVv9ZqjYcLOEFNJQv19yy/Qk9yVN3HiYXjYfTZfy1RLYUurD?=
 =?us-ascii?Q?Lrir7B7T3p7oKtGPguyuGG3ty1iOEm5tSNwsE7+k7MXiCYXITUPs/cHeJ2ac?=
 =?us-ascii?Q?DfJbTPdX76Z1xZnV29dXZFU0OiECtmodpfzORjcCuMZ6jSku646fpbSNKtXa?=
 =?us-ascii?Q?RtmTSIvT9ZDxbZ20y/btGcPkLquVZWpb1+AgunL1wkRb63a0K0zwD5WDQSjy?=
 =?us-ascii?Q?6TRHlKAPc3ylkHcWYfD/rV4q57MvZii6sUxjgk0e52iy0+noqhcRCY8C2hyT?=
 =?us-ascii?Q?kgYtv3sPtBGsgc8+JLZ6glAzdBwHxA4FiViJTbvGKW2HfrlVd083dxyT7Gme?=
 =?us-ascii?Q?KsRCT8+vDhTaoo4authmjeD9uQEFqPBtRw7yeRSb8mv0UeBIRUXRLDeAiJXI?=
 =?us-ascii?Q?P8mNeJ3bbOlYbgqf7gNfPcysvVdXzj3v7MyiM+ICF1dUjWIIkPGKFT/SoVAl?=
 =?us-ascii?Q?tTAi+2dNc4/zNp4muQR+QbqcMO0vH933TYTXx8/CkRtnMZhkrckmc7tKhK3D?=
 =?us-ascii?Q?iqaBDPfZ+d2CiD61/qZwB7FA4gNI54C/1/RaQnhMpaJvmH2DhmIquMAvVWLG?=
 =?us-ascii?Q?Hd+TE964C/T6JwY7R/+bvtoYpkNTLabCvIXUOHc3QcjT7DVW0eXOORcjGhSs?=
 =?us-ascii?Q?k8Z+bxLHnhxl0ot8rtPXBF9DzYl3pNA6HLTFuPAcjMAyIZRFRxfsKYMBloec?=
 =?us-ascii?Q?Qnm7Fc7Ew05X0f+1zN82k2GUuMX0W+ays/BVf7b+XVrwCj/sPWYsgQvNfTr+?=
 =?us-ascii?Q?wpcK38jf35uRK/OJpBJU/c8z6Tph7rGJOwPxHagr53Oz01uEXJQZfeGXuOzI?=
 =?us-ascii?Q?JRtlWD+AwA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7122a3f-c4e4-4e44-cbb8-08de8b3b9bca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:46.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezDq5FKJIY5WOh/aanbJbnq2kF0cYZ/aL1p4qQnETB6tR61hg/O0D3u9/a1+616bD4YlI97hYZw5HD+JaKCz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272065-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,host:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: EA7AD336006
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a couple of helpers which can be used by tests which need to run a
specific bash command on a different target than the local system, be it
either another netns or a remote system accessible through ssh.

The __run_on() function is passed through $1 the target on which the
command should be executed while run_on() is passed the name of the
interface that is then used to retrieve the target from the TARGETS
array.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- reworked the helpers so that no global variable is used and
  information is passed only through parameters
Changes in v3:
- s/TARGET/CUR_TARGET
- always fallback on running a command locally when either TARGETS is
  not declared or there is no entry for a specific interface
Changes in v2:
- patch is new

 tools/testing/selftests/net/lib.sh | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b40694573f4c..6c0d613a4de5 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -670,3 +670,41 @@ cmd_jq()
 	# return success only in case of non-empty output
 	[ ! -z "$output" ]
 }
+
+__run_on()
+{
+	local target=$1; shift
+	local type args
+
+	IFS=':' read -r type args <<< "$target"
+
+	case "$type" in
+	netns)
+		# Execute command in network namespace
+		# args contains the namespace name
+		ip netns exec "$args" "$@"
+		;;
+	ssh)
+		# Execute command via SSH args contains user@host
+		ssh -n "$args" "$@"
+		;;
+	local|*)
+		# Execute command locally. This is also the fallback
+		# case for when the interface's target is not found in
+		# the TARGETS array.
+		"$@"
+		;;
+	esac
+}
+
+run_on()
+{
+	local iface=$1; shift
+	local target="local:"
+
+	if declare -p TARGETS &>/dev/null; then
+		target="${TARGETS[$iface]}"
+	fi
+
+	__run_on "$target" "$@"
+}
-- 
2.25.1


