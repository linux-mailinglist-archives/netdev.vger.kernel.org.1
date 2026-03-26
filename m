Return-Path: <netdev+bounces-272073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y+TpKbY2xWlX8QQAu9opvQ
	(envelope-from <netdev+bounces-272073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:37:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F008333619E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88872311C4A3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853533F99C7;
	Thu, 26 Mar 2026 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HUSqGy42"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6831716B;
	Thu, 26 Mar 2026 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531756; cv=fail; b=h2QEHZgF6hourFukn57PUnwxzDNt/75mNT5ZbGkWh+l3+2L++pvK40noEisFG+ONDuf8kThSZvEYRNGb3rWziqTZY94wAqwfNgExEZvnU7oA+SQMJ/rZ9pJQB/TRXXxUvlotiJu49B8Df9rOObrq1ES1VFbDzAzR/dUf2NmioWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531756; c=relaxed/simple;
	bh=WKtdoV1dNNfp/D5pGlFEH3odx1TtBPdN4GcpSaOwrJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZ7LPWkTy0lI3TGw6JB8BsW0iVRcyJzG3ymaKv+2O1Sk4uGEh5EMeLeqrCjxiHU4aYMpbAxvlFbq0tLtFBDwDBUNyyWlyLkCi1LGC2KtiLB3kAxuv3L4M5J1B1qEQUnt4APygq9vS7rMt4nw6hdHhHYujmXEN/2bYxiSar8z8Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HUSqGy42; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiXM3PADHzWrpJ7R/3gRQsKzlg4tXHctt/t2BJjcDQjoczvRs1Mq578Dw6YtgHEDR5q1MeBfTBvis7krHnRuDEPxCGpJ4joZ3jkCly0w3TXcHD00BcB0OACLdxQab6+TfUsM11tvuNn0e0EVwcqIAVb8vA+lc7+H6CbwI3NQVZwh7OS9Yojm2EDhcptuirDbElotcUYKGT/nIi8ooD6Qmdwo0ANsH7ZJUHKtYrHMIelluQDu2Ts7mrOFy0UyPQxuPAsx9aoMKC6jjh4rMCdL67w0H/RyF/gx8RylFU1J1/693D0s+QCXsdFHYuWfRFIQeh4M4F8LU0iYxNukgwmyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llCJN6dpMLCknfvoB9POLUgAcbx/j6n4hl5Adx5kXOQ=;
 b=PV7BJgEnpWD0AlaCCzoBoBrnUsuoKLyIcriV55rdBaTBCN18SaQEDJ+J1sZSwxIW97QVA7zr0wfo//s51u0IyFAlGM1HbFkJ4QaKEbo7D8aXJ6VUHhMQH/HXH0KCTXSB7cjKo4EtFo8GEAHAuG0YfiJdONC+jtb7HSDfFN8Uq/ty5IIgCY4qYo5EDqp4W7fvhYcQ2Y1cqrSQtXGRThNZ7BQ/ZX4yo/nGKK/eeh5YD+nz34biyTdxFxVyzfohUZj3RH8NUyuSSc8h2a2I5Pv4U+Wl9vyfGGJMKbhS84KHahC/eey2uHbqzPYMBcqaCaIAlR1gir3AC4jgXXT8NyRNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llCJN6dpMLCknfvoB9POLUgAcbx/j6n4hl5Adx5kXOQ=;
 b=HUSqGy42q2226NAneo5UX1vXBogEZs7/AOzvoW7E7qx31AvaKYHm6CAMryEbRu5UC/CmI0YDDaB+IM2ylK9o6jckD8ZPCcGe88kbENeXQ7yuDwSnm2xSSrsagKrnEeaec9m3NNriIIezBqnDMUT2GO8TCl+EklyweSt7D7vRPZcyE9X0RMFWRiLHdwxW1s3Y3pPW7CKVnmWKX1ZZr3IQS3aBL6uWuESlaMdcgNKaCvW0R5vyc1lxUyrjPrvHGPGcRLdSG65aV2Q1tJ1DHpUZt4mI6BwYbl6QzpRUDuqqe7xF88TidBG7HzSsYpwhz2lOfPgiP3+x4Ld4a+n7SjXC0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:29:03 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:29:03 +0000
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
Subject: [PATCH net-next v4 09/10] selftests: drivers: hw: update ethtool_rmon to work with a single local interface
Date: Thu, 26 Mar 2026 15:28:27 +0200
Message-Id: <20260326132828.805703-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aeee888-a449-4701-d448-08de8b3ba5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GISsolDPVM71/4VOohTUaaFe4pd+BI/c4v/M4Cb/8JLZ5HC+HWCmylftl+vfKxQwHU1EAtDfX6kOpuhZCQQEtAp+gKdH47Y5WT6q5Re7AjKHq34Jbvvcxbj8zUpUulHiNwCr+FHbNnuqIsDcxRd6cFz32Cb8x4etlhSirLZu1ZwdSOqHT1LOpZG87CiTUKRjSuLjZ6z10rPDQ4RoJ2E6pxJazebVI2X+YR1/C0RSjD8GiAK6N0BsmO8rNInMNMoNqzR14Kt65Rluiv8n+xtn86Y6XYBhA4mFP5praqtmoEYzEhxaSYHP5vJqnLnagnUbTqzy3Ldd1F/2NVqzZQCiGpNL+LC0hR458+HhfjUulL7mTk/0WpINJ5UiwIrxL2QvEsCmMQmxO8eziG0Ii84gCv0KBreOdXogTpanixwmRbOaihlqG4mTELi0MWG4k3UpPbRD8DYBWM1DYK9aIVR84z8DVlsippjUzc+nARYqcLRTtFVkKd5bjrMO+f8W4dpJwLpoYstWK+DVcelUt0KPl6nFAiLBbBIT7toVFl6VK1EXKch1Gbi1u7xXuX53ABqHV0T3oqZpG9nhy0PTsbAlaRhNN3QLd5w5olVk3u73AKq2doFOPXEgLGNVYhF8OCDVL3L5WHMONgmERiACyibaFT4OZleYVQ0ZRHJ/Yv38O8XOCCmxfC5pNYvEynkGB3XK+1rBg5UaCIQaft6or2nZ7DeTMvUV97RqqpBUTJHBdYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LhlOLkQZpVpAvMKvcEmKd5gFsk9safk7QE5wFpeWvXbJ1p+e9ZzHG3v49Tg?=
 =?us-ascii?Q?Q9T5Zld4ACFeQDj0ek4i7c92YdgyeBd1T0fscXeC/6yXooICbG/LiUT/F6Zg?=
 =?us-ascii?Q?jl6xjL0kNBcPOcquAc1o3X14idaGMix0nGuXj/mkiPzIqKfCViuoXr4l9j+d?=
 =?us-ascii?Q?AxxqdHa8rgWQmIzNv3MECVuwac9ytL7kKfZew2rWTMa5JbP9XVFHEe26MNYE?=
 =?us-ascii?Q?HEgesotjHpUIcMwesXBl3ffEN6Pn+K8fxbS4Cwc7wv0XMR/nyQA0N7l9UnXm?=
 =?us-ascii?Q?V+5FNir+DrPh3TBVaUfkfWRhm95v4Cvmv3rGtvWrN8cZ8n6I0igrfmz1p7+y?=
 =?us-ascii?Q?oYquN6HK76OAphm59EMNhgoNL7vtn8Au17b4mPiyoaM2MvTi2ZrmG//4jjlz?=
 =?us-ascii?Q?+qs3bf7MYjyEBkb2ZMKtxVCjc7ALAEB7LGMuzlo+SwuNR2YicWKdnAU4Ph32?=
 =?us-ascii?Q?T9LnxYW315TRVVMVhFk3BOhfWTZYn3dpVnoahS31xXt0perRV3iNBeNPUFao?=
 =?us-ascii?Q?cWjfGkPnsv8b6O2RqpXuFV05naxeqBQ3+NvFlS2t+PzuyraI75DXqxJeJUNR?=
 =?us-ascii?Q?8jrikBa06G/0k6p4oZUUnHbVm7IKrSgqV3hZUyiW430narAFSDjMGLsGi2MF?=
 =?us-ascii?Q?DN8NTyV00pLPv38naqdX0FdhwQq/F1CAqVsuPVX23W8MoycD1u7lYF83VqL2?=
 =?us-ascii?Q?c/duewjDZyEuhGcP5fq25LDc86Ons7f4YoP8iiLnm8bK94MnGaejMllict94?=
 =?us-ascii?Q?gdvQB3P3Xb15UmFBv/3vdrCxmV4nWZfTl52MzqGHxDbHsVdhUtIHBEKKKJVC?=
 =?us-ascii?Q?3gm5vQLHX+llyrXR8Sn3UE4nerK8PKAtlTmrRXd+JQGquxo8Bg+gYEcMzGkV?=
 =?us-ascii?Q?4kR871OP3Ff64V9MuGao35IKEqMTRZAGgdOWUcoj785inbNnU2Qc6zrD+tty?=
 =?us-ascii?Q?vO5PzIbWd9DAu7HudJga6DrGrA+xJ/WIBA6Ux60eREvmgbgx+jUU1VJLGQuH?=
 =?us-ascii?Q?1CM6kAWRTZIx4vS8+3zKOS/HZAeVrMeH98CFyh0kghJzXkyAr8U+EGr19oXt?=
 =?us-ascii?Q?lLNZlRIE5n7GqkZff2jdikorkBn7xEZTmKu1bk+kmAHwc7r/K/qdI4M2d8zo?=
 =?us-ascii?Q?xtt6N7Yq4lWVM0ypX6FwRuNPF+MyCJu5eno6EBQjVo62N7VCv0jye/hGOF/O?=
 =?us-ascii?Q?6PZM0OFKNKM3CD1PI/3xabXZdkrYd9WAQkWpjN6qn5n1Jcs+APiCScyrhLPg?=
 =?us-ascii?Q?etQQGrhxEogMuXl7oMDaz/siHdLdTyd6u04RIEdZhS8s+jtGxJvNKfGi1MmG?=
 =?us-ascii?Q?atSpxTPwtOymPe60yzS2y7HocrI1g2rYfh+sEthBQ6/A8uPnqfJmUj388FGr?=
 =?us-ascii?Q?iqc8UJL7ne9eKdaMgCxzvwCqEMwkn9gArtlnX3Hzv7CtcVFKUHh0g/5ZsMBR?=
 =?us-ascii?Q?9UFgnAkLcChYjJRZ4Ih0GUNj/7OF8jbyneMBtkEWkk3wL206fWMfRdWGI6pq?=
 =?us-ascii?Q?pGHLBPiEcTsom5aA5Y6NQ25oKTudbWPzZwE0obamSDFEU0GXTafPedBERlWG?=
 =?us-ascii?Q?n/VBDWia+HJRxwutNycbYzzfT71JuQBRFccusR3EQ+JqKEUW7CxItycFDBIM?=
 =?us-ascii?Q?qZvfxT2VTw/fKNaE5HrvQ76byx78u/B57F2XWqKZHOXsQbqCjOzOig5unEkN?=
 =?us-ascii?Q?gjAZegmcscbydqTH1F7++g13R2NXALPD190F0KR6hryXXMZXeZB1TItsM1Ui?=
 =?us-ascii?Q?GMoDftS0xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeee888-a449-4701-d448-08de8b3ba5d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:29:03.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyWqWZC1a2Js3WwyPHpDleSAP5zaGy4HkRbvUdbmVMWhTPT7/ex+s8N10LKQtQ81oIQNvpbXuRhVwYNw6oNIQQ==
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
	TAGGED_FROM(0.00)[bounces-272073-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: F008333619E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch finalizes the transition to work with a single local
interface for the ethtool_rmon.sh test. Each 'ip link' and 'ethtool'
command used by the test is annotated with the necessary run_on in
order to be executed on the necessary target system, be it local, in
another network namespace or through ssh.

Since we need NETIF up and running also for control traffic, we now
expect that the interfaces are up and running and do not touch bring
them up or down at the end of the test. This is also documented in the
drivers/net/README.rst.

The ethtool_rmon.sh script can still be used in the older fashion by
passing two interfaces as command line arguments, the only restriction
is that those interfaces need to be already up.

 $ DRIVER_TEST_CONFORMANT=no ./ethtool_rmon.sh eth0 eth1

As part of the kselftest infrastructure, this test can be run in the
following manner:

 $ make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw" \
 install INSTALL_PATH=/tmp/ksft-net-drv
 $ cd /tmp/ksft-net-drv/
 $ cat > ./drivers/net/net.config <<EOF
 NETIF=endpmac17
 LOCAL_V4=17.0.0.1
 REMOTE_V4=17.0.0.2
 REMOTE_TYPE=ssh
 REMOTE_ARGS=root@192.168.5.200
 EOF

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_rmon.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_rmon.sh
 # TAP version 13
 # 1..14
 # ok 1 ethtool_rmon.rx-pkts64to64
 # ok 2 ethtool_rmon.rx-pkts65to127
 # ok 3 ethtool_rmon.rx-pkts128to255
 # ok 4 ethtool_rmon.rx-pkts256to511
 # ok 5 ethtool_rmon.rx-pkts512to1023
 # ok 6 ethtool_rmon.rx-pkts1024to1518
 # ok 7 ethtool_rmon.rx-pkts1519to10240
 # ok 8 ethtool_rmon.tx-pkts64to64
 # ok 9 ethtool_rmon.tx-pkts65to127
 # ok 10 ethtool_rmon.tx-pkts128to255
 # ok 11 ethtool_rmon.tx-pkts256to511
 # ok 12 ethtool_rmon.tx-pkts512to1023
 # ok 13 ethtool_rmon.tx-pkts1024to1518
 # ok 14 ethtool_rmon.tx-pkts1519to10240
 # # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/net/hw: ethtool_rmon.sh

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v4:
- set DRIVER_TEST_CONFORMANT to yes
- update the commit message to reflect the current output
- split some more lines to 80 chars
Changes in v3:
- none
Changes in v2:
- patch is new

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index ed81bdc33536..2ec19edddfaa 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -8,6 +8,7 @@ ALL_TESTS="
 	rmon_tx_histogram
 "
 
+: "${DRIVER_TEST_CONFORMANT:=yes}"
 NUM_NETIFS=2
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
@@ -27,9 +28,11 @@ ensure_mtu()
 	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
 	local current
 
-	current=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+	current=$(run_on "$iface" \
+		ip -j link show dev "$iface" | jq -r '.[0].mtu')
 	if [ "$current" -lt "$required" ]; then
-		ip link set dev "$iface" mtu "$required" || return 1
+		run_on "$iface" ip link set dev "$iface" mtu "$required" \
+			|| return 1
 	fi
 }
 
@@ -52,15 +55,17 @@ bucket_test()
 	len=$((len - ETH_FCS_LEN))
 	len=$((len > 0 ? len : 0))
 
-	before=$(ethtool --json -S "$iface" --groups rmon | \
+	before=$(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	# Send 10k one way and 20k in the other, to detect counters
 	# mapped to the wrong direction
-	"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
-	"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
+	run_on "$neigh" \
+		"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
+	run_on "$iface" \
+		"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
 
-	after=$(ethtool --json -S "$iface" --groups rmon | \
+	after=$(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	delta=$((after - before))
@@ -95,7 +100,7 @@ rmon_histogram()
 		fi
 		ktap_test_pass "$TEST_NAME.$step"
 		nbuckets=$((nbuckets + 1))
-	done < <(ethtool --json -S "$iface" --groups rmon | \
+	done < <(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ "$nbuckets" -eq 0 ]; then
@@ -120,9 +125,8 @@ setup_prepare()
 	h2=${NETIFS[p2]}
 
 	for iface in "$h1" "$h2"; do
-		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | \
-			jq -r '.[0].mtu')
-		ip link set dev "$iface" up
+		netif_mtu["$iface"]=$(run_on "$iface" \
+			ip -j link show dev "$iface" | jq -r '.[0].mtu')
 	done
 }
 
@@ -130,10 +134,10 @@ cleanup()
 {
 	pre_cleanup
 
+	# Do not bring down the interfaces, just configure the initial MTU
 	for iface in "$h2" "$h1"; do
-		ip link set dev "$iface" \
-			mtu "${netif_mtu[$iface]}" \
-			down
+		run_on "$iface" ip link set dev "$iface" \
+			mtu "${netif_mtu[$iface]}"
 	done
 }
 
-- 
2.25.1


