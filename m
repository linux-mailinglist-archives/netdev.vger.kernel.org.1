Return-Path: <netdev+bounces-287616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ds0Mu6DBGqILAIAu9opvQ
	(envelope-from <netdev+bounces-287616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C479B5348DE
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647D4346A3CB
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7462D97B9;
	Wed, 13 May 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K4yzozgu"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B23F413A;
	Wed, 13 May 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679455; cv=fail; b=fc3PWnU9RdMqJ8ZmpVC9OP6IKUGS/QPQV9TxWKY3ojxhsrxrAceUrMuTPdcftp32qXuVM0IQ1vnfDR6/Up++hkkKbejVFnH6BdD+Wfcpb2pdP5WT4QlWAGgKzT72wNdEDwdTi+Mfw6yjNVWoXKjZAkDZIH82habEFC6aYmpiZmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679455; c=relaxed/simple;
	bh=aXEz7xpxPaxeBKv1XfmaxHGfpHUjKFQHN6Bs0giufLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ubAMAKCNieRQVh80Hs3mDAuUcSkceyV83PDIcnwWyNNS9KDeMbLvMmX+VKX2a8jOgtFuKyfOtws3pVEFTr7d7LJxi/nBYMsGq1hHCxjix8yNBUspkDPZTzTY/W06L5hTR9qkI8mVwXEAzeR2nP2YD5Fik/MbuW/0QlpFgftkfQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K4yzozgu reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8JjAbuKFVo8n+jS345e+QB48s52oGRegDbarhOW+t33MCTULbCKbmMZ8hWq/cuTXbhyzaK7OzAyz0K9J4cVobtNdSD4E5VrH3lDDvnlqhQr8In8jS0XbaiIFyB9unZKfFxo6J/Tgz3buqNC89NWAFI0iC4v/5fqwJav8qIjQQrIXa4Qr8VW0lyJtg9bjC0joh+/RE6U+Sujvn2LsmarAlh0AhtijigHiB3EDpZ+yyN07joqgfhMZD1IBNfoMjWsa/T+P+e1F6lXQPoys9467BdJ+J8NKKym9LYER+UZPdkTnyMYrCkJo7GepzKsc5fkARLW0PLqgJyvOyLFcmZQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze+dPCY7yqJUlKgPDKUn8mo8+ZapXhOH5rg7CJ+GFVI=;
 b=QxZd3vmY1SHlMIvvX+03wZ5dD2YTCnnFYJ5yp5fuP0GfPZ/OXtkTwSeIKfxMvsFhDeFidoAcT+sBPXX1vUgOhm7ddxuUI8FaJ+oX5BrZkRkcjqT/dYQOsiCAM4vJxLQREjElpi2KuL6IGK2LJNOZRGuaMUBMe29m+L5zY8NbO6nR12bvZkURltcyjOGhvixy7MkwdG2aMZz93hOBjH0I0aNFSoM8+w5Tt2wR51ytYXJh0mkqGs53lHBBpijMtHM6m76ni/rHTc1FUI/zXh6ZUN2YJgjqaH+XFz6u5OEbLkgzRwhXJtC0f8+aSFqZ558vZUrTfc9qrlHOJmHjlYzrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze+dPCY7yqJUlKgPDKUn8mo8+ZapXhOH5rg7CJ+GFVI=;
 b=K4yzozgupMiX+LxyX5HmPswkDSLuJCLeWdIEWmEChv0ydPXFyvxQyASoaE4CPSBsiRsZYphjICl88H7blqrT9KNcqLGNkh5Oc1fYpGsnmASRXxzX3kfX0J+lBHogNXIoDl/VaGgo30PGiy1DuPZgG7/8EP7EwxRREaFMbfrBKi3rWGpqnmHlgxQIoxpXRmcEbnD2pf+5/SvtecC6IrN/YsbCpXwlalfp3uIsZxR/Z1+vv/JQ4O8tCDhxMkdcEbFpsEIn3IuCoQjzFo+7ntgerSXo0+R5QOYRBo5eceMjBnlOfbICxvJvFh8V6boX7ypYRdPwUffP51omJ42AbMzmJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:37:24 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 13:37:24 +0000
Date: Wed, 13 May 2026 16:37:21 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Message-ID: <20260513133721.huu4j3wksxykizz4@skbuf>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
 <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
X-ClientProxiedBy: VI4PEPF0000011F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8a8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0390eb-2b60-4e78-89bd-08deb0f4c410
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|19092799006|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 PePmkvwhDlNkkOnGV1Fx4rdL6b1BEaBYBBxR/0kw3f4fa1RDsBRfxcOJtL/3pxxe5iIa0CStEJQsoqVOlbkMnIpjLG7CKvrto/HyFyXeki34sGgW7Mm4iooiTZYXgWNq+pc2+k4z8+qJGqSkExEIUiIjQVYYO48XMwRGCFgJeju3MGzsYGmoezwvmH4z4MEBJU0dzc3OZFmomm5YRYFcflyk0/PlZfEJ4Rg1yQmY0OVItVv7/3PydHwp9F6INj/nMycoScoMfOI7eQlLzHajK6Bx8AtRzESCYXgygHtwRIYTa4Yo2xrkoHXO5j/J5XlK36hG0rPtmtEC47S4KTNCUYysei6YNxWQZMFv7GzD2CeeQ8rLZJABU7mhZ1STxDaidfPUyB2jnWNyx3LymKyzI25mMFyqQcJhflj7BPuecRrLwhug/h2em584mJgwn6Qb/vT5JiscmOydWgLDtV6N3BNjBFL4voksbSTikWPIP7dlaY/kXmRdGCVXN40XQ+VOCalHdWiXds4T3nt+38zWJX4YuatFSo4K5Df9wRD9lj32AQBIIxnTLhhPtc6Yi6qDGL0mZPrkZtdMum7ihLlgax8WNI5e7/dYuyU1VuMQ6TOwntwawYmjbSnxc67BP4piFqeaW/1h/qvGJyn51xxBO5cCvp3uyaDZm5plGdHNYvY6nXj23tdXEUYl6R1/FSqj
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?Iyjdl0H7fpu4/bnVtGj3itgM2z0i3+/526H3QU4t0UluqOGzjhA1JUK2FB?=
 =?iso-8859-1?Q?mGDJphCP2rT29mSzUB1Gd1q2/CU+//Dgdt2JxoqxDqI86ssLkrRs9wabHE?=
 =?iso-8859-1?Q?t+6YsW2zyjruBm3OPo2DTe+wgDJwYe7GFacd7o4WyF8pnOGp9nX6LCgHkl?=
 =?iso-8859-1?Q?h8gWXEXnUAMJwlvXabt/T7t3NRSjYh5TPEMBxENpCGQoVNjn64uit++Ec8?=
 =?iso-8859-1?Q?d63h7+DtfhB9A/pBNAXWi2cs83X11nilIfRjj3YKc0ZqSJG9GG3NtI0nhi?=
 =?iso-8859-1?Q?iudGL1+/O0d991Aqs34Stq0PQLhUPhsJL5L7LkPC+Md0/ZBKQBGt5dcIwA?=
 =?iso-8859-1?Q?7ReC9uPFivDgo0b0oKGz6lvkRcNXidoH1BuvbKycb7DC+U7U2hcIMygq3W?=
 =?iso-8859-1?Q?LvVIR8Zjfd4H2lZTOCfCAJsNxoT1yz+T64lbHZ1zhNGgTFFZrFXhquxsZ4?=
 =?iso-8859-1?Q?D6nRy4MJDCIXjR3hx8WkXJf22WEQIz8l8kaVuWJm1LKwWlcO6Rl4tucb4Q?=
 =?iso-8859-1?Q?xyeypEn1r7lBO+1xjfxZyOZhJhx35vvFWQErhLBPkAzvGvYl6oSph3Cg8d?=
 =?iso-8859-1?Q?V7Vru1GIux+WP3OJSW6IwYyuysVeYZQDT65OMQsYBIn5r4w5/WJMCzw/jZ?=
 =?iso-8859-1?Q?vKPZPUubDpfWz2+GuAd5WI3f3YonJfo5wlLZeDkefdFm+lTs5M+rPF2Ni3?=
 =?iso-8859-1?Q?WA1PtqlwOoxBsbzqJlpDoV8DQaGMZEmUKLfibONxkcXOilH23SjbIbKNCN?=
 =?iso-8859-1?Q?OlYy04bFWDRZ5GGS5s4bcHLu/AInmvML1D2O51xlaOhmGjKgn0QIKP9You?=
 =?iso-8859-1?Q?bJo+eflU+Cshk5lYCxaJZzyoYyXkYH/XqE7JUC64/ezQlXgffjIbQBU38J?=
 =?iso-8859-1?Q?f4VaYt6fY6mp43/X9fx1p5I79kPluTBDzyh2jyn/9hgJELgSJiI//2SrjU?=
 =?iso-8859-1?Q?7VI582Vsi0aZyiEU6f4Citn9MRkyIwaFpYZpDVkIE2xaiNUngW5JvB7VdL?=
 =?iso-8859-1?Q?tE4KXDQnnld2CqV5+gz/DReWDosg0GIc3ZYN1DF7DgtD95VnJdmGHnYlet?=
 =?iso-8859-1?Q?sIrlFuC85rIsxm1RUsMt1kOaAWn9D12B/CKYFu73PuHz4FJonmi8yRNThU?=
 =?iso-8859-1?Q?Cwr2JFZ83CywbAjsuVOCgxqZDlm/ytCoN5usea7db2EbwztEnpTbk/OEwj?=
 =?iso-8859-1?Q?oeB2/VKsScGcCo94tOxqYHeL0m/0Tr4RTcT/ibTho4Op5/neTgkGY17Sjg?=
 =?iso-8859-1?Q?Kz8ZtPty9Dz3J3Hpglv5kOcTeZP0QJISnhW9XzFqjC7NZpH6ENebP4ziy7?=
 =?iso-8859-1?Q?Wh2Tqy4wKjfaoPJjDi6TIgnYpgTHRM/BmO73anZ1K9syoGuT/t+MmRijNp?=
 =?iso-8859-1?Q?u6kXY1cnffxox7gH1CgyoSjgj6u8i6abhOQOX3g1Y25hI6Vf/0YXRMqit0?=
 =?iso-8859-1?Q?5gRcWlSctb9ZmY4UygJq2SqauZ3tBXT1JbWjMixG6tY1S4o2OeUtKMlD8A?=
 =?iso-8859-1?Q?xUb712q8q8Mb530HpuY10/wxy6NizBcEKDLVSsea50Adbs+oTiQ0FuNnGp?=
 =?iso-8859-1?Q?FVyyNmofcYMe6zVXseK4fZHZYhpfo/71/PZEtafozIHwAZb+CvKn6zP1ky?=
 =?iso-8859-1?Q?r0xhBQE5GB44/xvCWK3SSK8Kqc7hHTw0fTw4v+VxK5BxTde38GcWjDYjgP?=
 =?iso-8859-1?Q?FWV6FkOgBzsMcpVyoZee5a/yEPsCWr/DiXlCij++yGZr02Bs/NEEzpV1/A?=
 =?iso-8859-1?Q?KrQfw3h+YNhz/4tjUhBnbZR6BLy7xsVGKc49aR7MXwyvqMrQGqI3t/KIsx?=
 =?iso-8859-1?Q?3e+vi/d8jFRmp64qHfKNBIWXN2lxYRm7xaYJzDm/pgx3d24rtCHVTs3b9C?=
 =?iso-8859-1?Q?ff?=
X-MS-Exchange-AntiSpam-MessageData-1: jDXHmyTAMNX4aA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0390eb-2b60-4e78-89bd-08deb0f4c410
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:37:24.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXdtbo37jW7Myo7iFLGFlOrwcUR6ntFhqf8ecMSjL3x4pvAyhey513cMqJ9bP+A1OlPXNEB7v4/fDIi94dVI8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683
X-Rspamd-Queue-Id: C479B5348DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287616-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.051];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:37:14AM +0000, Josua Mayer wrote:
> In order to test this patch with 25Gbps link, additional changes on other drivers are needed.
> This is not a short-coming of this patch.
> 
> 1. I tested this patch-set alone on LX2162 Clearfog with SD1 Protocl 18 (i.e. 2x 10G SFP, 2x 25G SFP):
> 
> 10Gbps ports are working fine!
> 
> 25Gbps fail to probe (but this is partly expected):
> 
> [    8.373048] fsl_dpaa2_eth dpni.9 (unnamed net_device) (uninitialized): MAC returned PCS which does not support 25gbase-r
> [    8.373065] fsl_dpaa2_eth dpni.9 (unnamed net_device) (uninitialized): MAC returned PCS which does not support 25gbase-r
> [    8.373074] fsl_dpaa2_eth dpni.9 (unnamed net_device) (uninitialized): failed to validate link configuration for in-band status
> [    8.373078] fsl_dpaa2_eth dpni.9 (unnamed net_device) (uninitialized): Error connecting to the MAC endpoint: -EINVAL
> [    8.725004] fsl_dpaa2_eth dpni.9: probe with driver fsl_dpaa2_eth failed with error -22
> [    8.920766] fsl_dpaa2_eth dpni.8 (unnamed net_device) (uninitialized): MAC returned PCS which does not support 25gbase-r
> [    8.920783] fsl_dpaa2_eth dpni.8 (unnamed net_device) (uninitialized): MAC returned PCS which does not support 25gbase-r
> [    8.920791] fsl_dpaa2_eth dpni.8 (unnamed net_device) (uninitialized): failed to validate link configuration for in-band status
> [    8.920795] fsl_dpaa2_eth dpni.8 (unnamed net_device) (uninitialized): Error connecting to the MAC endpoint: -EINVAL
> [    9.290005] fsl_dpaa2_eth dpni.8: probe with driver fsl_dpaa2_eth failed with error -22
> 
> Perhaps driver could switch to 10G instead? However not important in my opinion.
> 
> 2. Tested with additional out of tree patches:
> 
> net: phylink: extend phylink_mii_c45_pcs_get_state also for PHY_INTERFACE_MODE_25GBASER
> net: pcs: lynx: extend support to also handle PHY_INTERFACE_MODE_25GBASER
> 
> Then insert 10Gbps SFP module and link-up + TX/RX working fine!
> I.e. driver switched successfully from 25Gbps configuration to 10Gbps.
> 
> Then insert 25Gbps SFP module. Errors start occuring:
> 
> [  357.043894] fsl_dpaa2_eth dpni.9 eth2: Link is Down
> [  357.941036] sfp sfp-bt: module removed
> [  364.269580] sfp sfp-bt: module FS               SFP-25GSL-85     rev 1A   sn C2501330127      dc 250203  
> [  364.269625] fsl_dpaa2_eth dpni.9 eth2: switched to inband/25gbase-r link mode
> [  364.271674] fsl_dpaa2_eth dpni.9 eth2: phy_set_mode_ext() = -95

-95 is -EOPNOTSUPP. Is it coming from lynx_28g_set_mode()? If it is,
I suppose it is from lynx_28g_supports_lane_mode() returning false.

Assuming your list of additional patches is exhaustive, I think you
missed from patch 4/5:

 For old device trees with just "fsl,lynx-28g", the only things that
 change are:
 (...)

 - the feature set is frozen in time (e.g. no 25GbE). Since we cannot
   guarantee that this protocol will work on a lane, just err on the safe
   side and don't offer it (and require a device tree update to get it).

You can look at my branch
https://github.com/vladimiroltean/linux/commits/net-phy-upstreaming,
specifically commit "arm64: dts: lx2160a: transition to device-specific
SerDes compatible strings".

