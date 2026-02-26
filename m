Return-Path: <netdev+bounces-261525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK4hCOCNoGkokwQAu9opvQ
	(envelope-from <netdev+bounces-261525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E11AD6EC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BD00303E698
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CC36492F;
	Thu, 26 Feb 2026 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KVMafZrJ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E873290A6;
	Thu, 26 Feb 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129326; cv=fail; b=Y/AljbkgYPgGZH/Fq/JIVXsg9nCzGlFdpUfM35VJC0Bo3dbk3DATQf60n+m0rdq8qQkHGonXm6X9OullqVr3vOt2uGV5PW++wWdUFQxMvn4iBii1Qr9BPR7Z9xk3giP8D/qD7P9S4EKtvTg8hhZeOr6U7/4hqNRKcLtlsUNqkyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129326; c=relaxed/simple;
	bh=FSJYnQrNThD/+TR3Pz8eRUJPH26ero+jPofLYc7DnZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOBSgwG+dhn1Bh9G8N2Qilv0v+ex9dOSYY9e1L8jTgrtmkvXpeOjAu7mgy/UAvGSdM0DXkp9Ze2oEqq9EnLojztfMkqSlU1O27wKnJp/gsP9jjSjhHrEx+loy6XBJLcWE3KruIBqX0y44FPeweW+qg5PrJlT1ZocOaiZa7WgY8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KVMafZrJ; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRD/qsL7JhXjnQSjGp8rkHxYc1TQCs4rroo7l9FeVQxhWbzu0JoDGKTPV6ehsjuYJdDZfe8OZkxFpa2lBzcXB1efeDmPt3uP6tPYkatOc7Q6SlLUPHB1EH3B8rTlCb77tgguRZfUcK1NF84aqSoky8yGicXPvGCy6kiza9x4dgNQMHUrK2slnmJt2IJY9D6XeyGviv73ZKQAyY5Mwf/6ocNZWe2OPYMM8AhpK/mcfrPWUUQWAo55SEZY5F+Q3kFVRYnCGBuyjBaUo+HG1pvkquNwvMaS8bF4yTZ1OU8AJ6OOd0cfopcJWA/zfW+pYCf2+C1J2tAfPnqML+0f/XzsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3o3LEkLV+O33pIc+Y0C9D9XD7DZVLPXTZ3GvgVtrXA=;
 b=v5apxPk3pykp+Ocpo4tM+PfZbih34x7GrZ1PfWp7VAT5JAxzzINNouiYUCZ5lRIJm20GK0mNqEB1hRQzBme3qrRlzniIZLe6PMWF3HUEN7knUa3qrTci+3TpyUMv4nulQkhwFDxINnNG81ajT7tfb9mRS16pZo866Iaty4qCwwrFMkqC/onmmY0OGVIk6tKUcZTtw48HR9ceLN/E7AvgVD66COIhtvD/mwB7YkTJXq3HHWl0Kru5vHqn9ljQMXBmHsdsJm6QuiX3CDTkIFwlgDtvk/XqQZdXVmi1kQxyftD4D/gwy0WppJiYRpm4nNHt6pirZKmMnmNFPxogllUaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3o3LEkLV+O33pIc+Y0C9D9XD7DZVLPXTZ3GvgVtrXA=;
 b=KVMafZrJyTeq+vS1992JcC50uN8LI4QbcMnQMt1/E9KUreMHv4clsI8IDO88ACadFHN/s8tiJk8rQD/MKkf6LiWiNi6Rye5072m8XCO/X7nVRPla2jH5YW/MToLerk5bNIaUBECFAsDWWSbIodNzDk5prLKz2pIB3Emf7aMbeis+3VtFBk46as/Bf6Ghjp5B/Zh459MgqniFOIOZ0Z2QyY0Qqgkj4lhCSoOd/0SKj3yEuI65wcxSzUcS37tdYB9aeEd+GLE0jrS5fZfWNMincKePv3mja67Tficcgbtu1d8ZFTVSz70aZfywMh3skamlbqv0DVzG3KxH0uwkLI6T7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7749.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 18:08:42 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 18:08:41 +0000
Date: Thu, 26 Feb 2026 20:08:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: haokexin@gmail.com, vadim.fedorenko@linux.dev, jacob.e.keller@intel.com,
	horms@kernel.org, basharath@couthit.com, parvathi@couthit.com,
	afd@ti.com, rogerq@kernel.org, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v4 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
Message-ID: <20260226180837.2oszjdyh65hrxkzk@skbuf>
References: <20260224124803.3634808-1-m-malladi@ti.com>
 <20260224124803.3634808-1-m-malladi@ti.com>
 <20260224124803.3634808-3-m-malladi@ti.com>
 <20260224124803.3634808-3-m-malladi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224124803.3634808-3-m-malladi@ti.com>
 <20260224124803.3634808-3-m-malladi@ti.com>
X-ClientProxiedBy: VI1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:802:1::15) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f58f4d-a3a1-49c2-be9e-08de756212c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	tEzJf/33ssEE2/KF7th4N0YpHoB0GJFLlvThaDUvXeTST1vl/6jCduxXqzg8QXDn9atTPShGS7+iDZKdO9JrDQ4SU4hA8bXHiVMn7DLaau1xxHsNLl8UMnXFWERLDV9RTSR4IyiC8pESY9rjAk20eI8MBWq/c+ZUwMUfWfu39T+2CRjHMUx/uk8ImWPh1M3wZhhLxz9TTJCegMrklR4tjFUCj2S1csKgxxN/jH65s99VbvsIVB49D9I2JLe9YS3bkWoV0WbgZJGRZ/S0eJGk0I9I5Q5Cgqh2mQv613IcRlFTTOMoPX0HwI0RcVgEsoDZzK5RUGpwd7e+BrLmk+I00FkkWFBhlHE5H1ryloraWRXgOaBe3JOr11hQSoCQu+Qf/OPgzFD8ImihgXNu0rsq4R4JCm9vxDpGu6ZpUpvgwSrsqY8tBFw5140Z2iWNrwibZ2siF+mPYbASynje/BYg8SS6rrWsHTNgbrMqH/6n+PtZ7KMKj8U1a0sU1Ulpml61GbGNRWFvy/3xDqVYaPPB/ofNsoS4HMfu8nXDTDH4bjVhQKsCwNn532xM9EWRXHxzXe85m0ugo7VImUJ1Fqs0IBn7oMfDT4y3u/aRHSiQZIBtbfRfmrJN4umePC0gr7DAzazSG5nFU9RALBB2v51CV67G6PXzO/sni2YWSh+MpcWDsvOlUbaSOSN0WqgW07JXrPFL/4W8IuiyP5FwoSpsFujQea6eRK9Kp+z7R9Z+Z1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1AtxCPFDEwpUmaOz3mHmaPSy7NBjBSppv5M43Y55Fv3yO6e1KVVVFaeSi7V?=
 =?us-ascii?Q?5ke3sLCVDeDDIO3vT80p1fsHcAG20AbUv2YD/PCCorzvo2fWSaIkFS6yBaAN?=
 =?us-ascii?Q?GiaoSi5tga9v85IEVnBKiytzD23KZc9sbIX2WjtJr7Jf54XSQNIgB3TrnaeR?=
 =?us-ascii?Q?e51PQ72f+2yzFS4wYgugQvOQKGw/Bd5AnMbH3wJeJlNRWjE1FfzXKH1E6fLl?=
 =?us-ascii?Q?0/69daVyNK1R2lOQFgklu57ZvgmSHTc0rBiq5qB8rCx4d4jISFtlbBwobsnC?=
 =?us-ascii?Q?zZ+OEj8QZJzqqe/aUAjIb92wvbCiyL5u+stWh+qxe1blBlnC304Tt6Bya9xW?=
 =?us-ascii?Q?cT4pnRgws0OIiAoLvPGqOZ3ftA9j46rEs7KPOP7PhFrl1u5mNyx9i442lgMv?=
 =?us-ascii?Q?FGvn/XpkpawASj8WBlRI7hV4G42gQ1i3XyZe/CFqxap0m+PESdXbHC8o0ADb?=
 =?us-ascii?Q?HMlNEMMpUcTpCqp2LEob3L+Ea8n//KFzsJ6T4oggEeh39rX5t2sSRHrykcDh?=
 =?us-ascii?Q?YCVkViu6qJEwMogqwi6QCcb1rQuI8cDo6SxPFgQK6Ncb96ENP29SmqmkEo/d?=
 =?us-ascii?Q?vj/CSTgPRQ+Wsh3LT2ELfoefWkGJfee4HxVIRVKrbOzZI3s9AuCk5/icTYyu?=
 =?us-ascii?Q?zVhd8gGjDG1c1gkeeHxe0pffjqmF/ORPFPP6mr81bzRDlZRgS8GOXlQn1SOp?=
 =?us-ascii?Q?O0hsiS4OpRowKrIgEWQphFPBm4G5r75eKYVsFhPjznHjZBK76xYFae6EIYNu?=
 =?us-ascii?Q?L1HMHuBR+UuvzRg8qpQQxtBJaArJkx+oMXBY9RZLaCJaoww+6bjxOb0Ds9Yi?=
 =?us-ascii?Q?lWdKRuDFZgw0wR4Yqb0Z22F0fRpYZ9udADJmjKQAirJObYWG9nNzuNF36Kxw?=
 =?us-ascii?Q?pCn4tasYV2X06XAO5/3Z3jha/QsBSrHOIFcYuqiGn1oFBRa3HIBsN/buIJ1K?=
 =?us-ascii?Q?Ubo5t8n0jMybIW73udCuDoyy8J1T8/OlPjkgGHW36G9W3GZaM+dxG9ACwT63?=
 =?us-ascii?Q?SwrI/+36cUTSgD2HWYjyNa/UUTeoKPwebatshPiCRXuw4AYgqaHHrt0rxf8X?=
 =?us-ascii?Q?eSiTC4DOKBGxjnEzHyt4ByNN2M+yC9/CUbmiMfqtEWAVUV/yoabWQvCdqV6I?=
 =?us-ascii?Q?N076uFZBGw6lmcsMWxbUiw24KGRtTdv9OLGHKgRWC9GzFERYiAMpOXp0B/C7?=
 =?us-ascii?Q?wcrZTLEnokxKDKjDt7pUmKe9y+RIjjyHttUQY3vz0CJAZFdjEydY3Kmy8Rz4?=
 =?us-ascii?Q?kwyN/ZL/5uenjHGfPWRiRQ/tJulSgQVEG3Rz98zXimas196RsN7AtxHI4qkV?=
 =?us-ascii?Q?wgqKwycRO+ATtuGZgch2akW9Cg1km0xbnRRRNg8Y0HVV0/FqCzL3JMEqpgKc?=
 =?us-ascii?Q?niTNA1M/GLEsCjNM7OnfD91huqp8oOpURgNLlmKYE1wiNClvyECoHh3geSUx?=
 =?us-ascii?Q?4QEr6befM0HtKACPDfI8dcfEduQrs4JtgVoeEQG7fBeen8M3WqrexbD8BrrX?=
 =?us-ascii?Q?cMbqVb1udlN3tPKJtt3Ou+4MF2qLQ7D9W+kz1/UISsp5uWo2koOheeALKExR?=
 =?us-ascii?Q?/Fqb7BzmxSaQ6tLIZ96AM9GjO+Pf4x2I7Ds3K8Csdex0vXLf7ciTm7ifX3bd?=
 =?us-ascii?Q?LuFYcrl7Wxi9h9RwXxZQqMqHJdGtp8qT3iNratzipL4S4O1BUimO6X0h3zKN?=
 =?us-ascii?Q?x9j7g6LOALMht+VFyB59NXwLQIdyDqB2A00bfRmuL4jylKPnJz5oN6Tpg0rG?=
 =?us-ascii?Q?rEWSrQCs2r9Ef1227E0D1LcYm/cF+AbZ8c+OIB+S5V9LC2PBPX8aU5SfKXIr?=
X-MS-Exchange-AntiSpam-MessageData-1: Gcsq2HVEeq1DpnxSb3phjOT/DAtATHsTz9c=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f58f4d-a3a1-49c2-be9e-08de756212c9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:08:41.7899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QqYjoe80l5jGzRDHGqfRta8IOqT5hUk+YxF9u3sZPfO8C/G5iLO1kJkWylovCK0EBhP5AOWesf4wllYus83pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7749
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,intel.com,kernel.org,couthit.com,ti.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B11E11AD6EC
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 06:18:03PM +0530, Meghana Malladi wrote:
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> index 653dbb57791d..bf84cc1b8282 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> @@ -57,4 +57,24 @@ void icssg_qos_link_up(struct net_device *ndev);
>  void icssg_qos_link_down(struct net_device *ndev);
>  int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  			   void *type_data);
> +static inline int icssg_qos_frag_size_min_to_add(u32 min_frag_size,
> +						 struct netlink_ext_ack *extack)

This function is poorly named.

It draws obvious inspiration from ethtool_mm_frag_size_min_to_add(),
which had the following meaning: "convert min_frag_size (input) to
addFragSize (output)". That's where the "min *to* add" comes from.

Your function does _not_ do that (nor is it used like that). It returns
negative failure, or 0. But that 0 is confusingly not an addFragSize
value, just "success".

> +{
> +	/* The minimum size of the non-final mPacket supported
> +	 * by the firmware is 64B and multiples of 64B.
> +	 */
> +	if (min_frag_size < 64) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "tx_min_frag_size must be at least 64 bytes");
> +		return -EINVAL;
> +	}
> +
> +	if (min_frag_size % (ETH_ZLEN + ETH_FCS_LEN)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "tx_min_frag_size must be a multiple of 64 bytes");

The min_frag_size as passed by user space represents a value that
doesn't include the FCS length (this is what the "4" in the addFragSize
formula excludes: "64 x (1 + addFragSize) - 4").

If your firmware takes a value including FCS, make the adjustment
privately to the driver, but accept values from user space that are 4
octets larger than what is programmed to the firmware. This allows the
same user space commands to have the same meaning on your hardware.

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

