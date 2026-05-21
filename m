Return-Path: <netdev+bounces-290215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO78N4BtDmqN+gUAu9opvQ
	(envelope-from <netdev+bounces-290215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:27:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E659E107
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18B6A311DC36
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EF03655FD;
	Thu, 21 May 2026 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="II0KPAqA"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023100.outbound.protection.outlook.com [40.107.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349932B128;
	Thu, 21 May 2026 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330137; cv=fail; b=rEntLRgU2UNXqGhkjQVXqcYJoTkQLekJsis1BCey4rlNTn2HaxM4wihYhcvs782cW61aX6mNgsNrHBkIipUeJ+EY8dMbJfTYl9HJzh4YKydiyL2fvc//s6mXxiESU2VWDeBEqsItLgjAFuLd88AcqPXRSYOwYSWwfc9xWP1l+kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330137; c=relaxed/simple;
	bh=/t8NsCIRV7/Fl6Vs0fvZ3xKwxi6FwoO3zXyk6Un96Rw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CDnjX8gHNod1ppxBXiXSpotr8seI3ZIJCNLpeLVP/2Bpi0haiPBVX5ZwmkEBmapjfqbSPWpHbvfDyUdEZWZZL4fEQDCx4q0XqLWvT6ZmqCW7zHiVy4tMIWwtjJ84OQ0qxUvBsB9yUZ/d4tO9QFDLXNqgVXcUKfJHiIN36PoCeNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=II0KPAqA reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3yPEugWpqWKGiFlzpp/6+GJYPP5Dqdy8+JJyNGPrCXnyWvnDPHg7LASkMIefsiMOGytW8wSSJq/NZpQz97emKBOlpYrjNhZZQVTdwFhbkEmSjRJHk3I7ZIww5KPyAYWOSEVPg0/P+yYXkIs49rjSdBzUEh/yDgA4rT1goZcwRz/aYba+KzoP4XLW6xoFYkddtlXm6p/VcDWH0x1t6Ix9dNH7TeuyDBpmqj185q0w1iQDPLcWFzK4N94Bvb4C5vozus8GQqtw/8lykfZ40h4G8Pr+SrOf36S0u2O6QrK+WLwgtxRPGcTJ4YpRxhQrcJpBWZckPZgKq73Am0Df3mLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvywOpxlh2/r9r3pwri6wRQZ845JA/UT8NZoOG7HdIc=;
 b=d+EChCWTJar1hjeeqdwN06S5sPfgH/Xy63quqKvd7m1lv+9WZ5Ko1V5BvV+WXH2F5vFPy5sq8d2UHlqyjhJ9gWKkrOzIv/ZDs305sYs6xtH+Wfk5y+xElqs/njfzIxsE5F58OIEHCnh6/Qj/myYtAjxtWjphPe7HEIvmfA/Y+J1Js3D7NHKUhvsvu1TKyJy8prbdjSQ0oP1gqNqYtSDp9YJALalNsUnLa44apvwpWDJAbsAC6h4J4/bUpvdbAQnILeSL9NVv+xnwwBLwHhzR+B3CtA1w7Rl6XloQKnXC/jhxvYCGEcq5kDNmYWXEQsKVeBI6+MrOyYopms7ZhTbh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvywOpxlh2/r9r3pwri6wRQZ845JA/UT8NZoOG7HdIc=;
 b=II0KPAqAXU9oJB2sRgqXlqmZdvCls6n12xnWGuPBi5s/vvst+d901tT4sUnTHmBUm24GflH5XnI7xV0iYv3yUw/8xuaNWNGjhsN0++m3SGrz8aysh8M9k7967DYx3wCJQqB4T2o+6pgWnlcJBjvBQ4BbAoguQzqsHAfS2tZR/dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from CY3PR01MB9194.prod.exchangelabs.com (2603:10b6:930:109::7) by
 BL3PR01MB6948.prod.exchangelabs.com (2603:10b6:208:35b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.19; Thu, 21 May 2026 02:22:06 +0000
Received: from CY3PR01MB9194.prod.exchangelabs.com
 ([fe80::4005:a1db:71b8:dc8c]) by CY3PR01MB9194.prod.exchangelabs.com
 ([fe80::4005:a1db:71b8:dc8c%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 02:22:05 +0000
Message-ID: <8160e242-9e6b-49c9-93fd-88429378ceae@amperemail.onmicrosoft.com>
Date: Wed, 20 May 2026 22:22:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v42] mctp pcc: Implement MCTP over PCC Transport
To: Adam Young <admiyo@os.amperecomputing.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0213.namprd15.prod.outlook.com
 (2603:10b6:930:88::7) To CY3PR01MB9194.prod.exchangelabs.com
 (2603:10b6:930:109::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR01MB9194:EE_|BL3PR01MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a70e036-1d24-49f3-6cf2-08deb6dfc032
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|1800799024|376014|56012099003|18002099003|22082099003|921020|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	sIrflI8odqZFYdP/Y5KczT1oqDjSPhgaku5uA4lC8WrMoKyzfV3CQRYEG+FSKZGQXwiZsaJR5xuEvQLamnPY3QdstAAKGsRxi5xH82j4J7IN7ofWy8yF2fY08cd1lulA0D+h5HfmwiCACzdLKPIxnqBlf0hFyHACx7wWO/FjH1ev1ePZE4u5/+vwCRL1FQZVIcFn0/mce5d4XskVUoLVdSKYC8kvH1qcAQkUIF7+N8dUT/mmRjMsS1Mo+xp5Z2AP2Mj1aRdGHfqJYC+gRdneuTOd33N1Yt5JGdhFlHx9PkzvArZLvOCM01qdSandZcStq+atuOFN2i7/HETyaYxSL0KhATmh20HdSeWtdCHZR3xD2tflcPH8Ry8MyuJiC87RVX/xrfa5J86QR0SrFOkKYSHr1T9bY4t1PMuaUiP9ovJ6wNq3yLv38P3D5FFkYdW1XQgy/pkF99f+BDvxwiL01G1PHs08NobdRpZ6DPmHwTQOEY4zBVClIXvRaVK7XTKRSmuKfeef3CMqd8RODZC6z42ha+wqK/oA4Mlqi939GGZrtxK0vZ1yqm4KKgGEsoBNx7+sXQVst+FruOvjwKaqheev5IKAXdh5SBkhcm4dmVAsEfj8xkA9+vLO5oHZyhc0Q3dRpY5UeFELvHdgmvYIjOTP12j5zfioj49lsWkcLJYZeMMC89Jc/6XDcRtKFne5OLP6v3uXvA1B/9gRFSnGv5JqxFNbKPomsF6M/L1PbwiWRgWE8zxZsQY7zNaqq7Sb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR01MB9194.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(921020)(55112099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDVPZ0RhWUxHTnlQQThLbGpQaG0rSi81VkZ2K1NJdXBkMDZGbVYxOERiVStS?=
 =?utf-8?B?QTVqQTVyY2NkUUxwNzZyZWRMbkc3dmVyNndlaW1leVdiSmRobmJ5cXdnVTE3?=
 =?utf-8?B?M3dZYzlYOTUwL3pBRTRWZkZHUFZDOFFUanNYTHp5K2dKK0k2cnlsOUlqTG1Q?=
 =?utf-8?B?V08yS2xjRktGakhFUGIxL3p2RFBncFBha1ZtVG1YVG1QcHpPZWsydUtnQ2p5?=
 =?utf-8?B?UmxNUmFyWm9XMTF0Z0FVZzMraXpvZ1U4di96ZmN0QytXcERCVktYRVdzekp2?=
 =?utf-8?B?K3o1TDBYOUhkZXNKR1dSWmszcnhpeC9TVHZic2xsc2ZEUzJFaVFxVFN2TzBz?=
 =?utf-8?B?UGZrZDdyRVVqYVpCczN4enRudGxZcW9RVmRqV1ZYbm1yNWJsWHpKQlVacC9H?=
 =?utf-8?B?Y2ZBZU51ODlxVmc0RjgxMElwSUtsNEFTS0w2NnBXdFFaY214NTh6ZFBDbS8v?=
 =?utf-8?B?SXY0UE53QVRmckNpYjh6eEczV3NSRzVtNzY4MThUY01pekZpUlJMbTR2SVFv?=
 =?utf-8?B?cVdvaXFNclA2bDZlZWJHMldsU3pqUG52bTY5UjFpaTV4c2t6ejlUdWt4WGZ1?=
 =?utf-8?B?WjdFZEtMUWg1b2NrUmpMM1RMeUVVYnppUEltVWdFRGV3dVkzN0NyTXNkdlNQ?=
 =?utf-8?B?bkkrYk5vRFVXNHFFemVmUzczc2UvUk9ZUEhSRGhZOTFSSHhDUEJVVFB6ZnlQ?=
 =?utf-8?B?V1pQVU1XSUxZaXBmMVk3NlZPQ3oyNXFLQ3g5OHAySXcxSVJwK1ppM2owSjlq?=
 =?utf-8?B?NkhINUFwZmNYWTJkVnprNjE1TWxzMzB6NjFJWnp5ZjAzVW8rMWxnZkI5cHl6?=
 =?utf-8?B?Sk1ycFR5TmJMU0gwQkN4SmRKOUFaRWJRNmVValczN3RuNEE5aDNqd05VOVVG?=
 =?utf-8?B?UkxaKzlWNFdvdFZ2U1NWdXRuY1lWekQwZnBxaldLUWRDUG9MMWNldkoyL1BJ?=
 =?utf-8?B?S0dnUUVvZUNnNGR1bkRoeGY4OXB5VmdxaE9ocEFBenBuVXdCL2JwaEUwZDBx?=
 =?utf-8?B?eWV1VkNORWJkajZPcGNzNm5tRTBqaHIwK2RBbWJ4K1VreDdlOTNxWUsvYjVU?=
 =?utf-8?B?bnJ1dURUZlRMZ0R4cUN6YnRHYm95R3YyWHJYdE55LzRYRUJxSzNMejBmZXIr?=
 =?utf-8?B?ZkxjZEg1QWlBbXA5cUVRNDJmNXpHblhhdU1aRkJURE1DWFJPNEZWc0VxUExM?=
 =?utf-8?B?Q0lLU3RWZVNkREZvUlFSQzJOQjZJakZtMURyakFmWXd2WGhUL2E0ZDlZaXI1?=
 =?utf-8?B?ZVlMK0FUdHpmNy9GTTVlK1hHUHdoajhybmZBdEwxU054R09EclA3OXlWRXJs?=
 =?utf-8?B?czlBdUdSL0E1ODBzckNJRlVGNkIrNWRFNnBQTDlXS1NsNmptdmxTdXliRHpo?=
 =?utf-8?B?L2cvSEJhdjMyUmFDaDc0bXJLQ1JFa29JNjhNUmhSc1RyQXVldGpJYlZuUzRy?=
 =?utf-8?B?RWwrY2poRW03ZXYrbzBDRmowUnZSOGlLM2ROK0NQYy94RXdmUDdWYXZFanNq?=
 =?utf-8?B?SC9PWlhZK0wvM0syWGhXTjAyNWhUV25nbEJXdFJ4UDRuZm5uTi9YMDMwRVRu?=
 =?utf-8?B?Z1RaanBIQUJWTjRYamFTQm9XdU5LVEJ5d1ZSVnUwZDBiMDFvaGlhTytvM0pB?=
 =?utf-8?B?K081VlJKem01SVBhc0toYUtETWhBSHV5S24wak12Wm5XYXZnbFM3UnVJRHdH?=
 =?utf-8?B?Uy82cHBtSWw5eVhxdEIvcHFUMm5hV1ZnWWxiRTU1S3Bvb0tEdGxDcFhxZVMx?=
 =?utf-8?B?ZzRxYjZSVWcra25LVytqMVpvMHZNd3ZHTzhKaW1XcWFjbGZnRXNqL0djNXNB?=
 =?utf-8?B?cms0b1licmFFTSs3RGgzQ1FwVDJyNXkrR1JhZFhSNitPOGx0czlLWWNlS0w5?=
 =?utf-8?B?TEQ0T1d0RTdTY2VJdVdzRGxpNkVyQU5wL3BaZURvWjVBK2RZU2FUV1orc2h4?=
 =?utf-8?B?bzd4Z2xEMEpySXA4cG1iZXM0LzJXMDhjUHRPd3BTQ25JLzhNazltb1l6WHVm?=
 =?utf-8?B?ZEowUmVxUkp0RllaTlIvcmhXeGtRbGJXMldsV0ZMb2ExK0EvSDJMUlpNMVFN?=
 =?utf-8?B?VkpXckV1RXhjcVZJclMyVlo2RmZSOVhkaEdkN3NYMGV1Y1ZGWVczSDY0aGJI?=
 =?utf-8?B?TzJZVUxDT0hUUzVHZTMyTTZsbGpWdW5XMmFiNWlUNVpWSW9xSldYbVhXUGlN?=
 =?utf-8?B?Q0JTYVlVbzVrbm1OWUYxMXZYaWR0T0lMMkp2RWJSQzNiZ2xZSVVzL3lkTHBs?=
 =?utf-8?B?QWxGRVQwbU11OGxnYUd6VTBVWUhYd0RJVzhETmVsT0FEbm95OE1qaDFrdkVl?=
 =?utf-8?B?b2dRNFU5d1FBTlVqNG5jZUV4RlZPSUJYZVVuYW1iN24za3Q2RVI1WThRN1dH?=
 =?utf-8?Q?AICwMEzUnyi5Ru2vVQWEK+kwd6+3fYKuQLfwBTVprI027?=
X-MS-Exchange-AntiSpam-MessageData-1: cJw3HNZnoqdN4g==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a70e036-1d24-49f3-6cf2-08deb6dfc032
X-MS-Exchange-CrossTenant-AuthSource: CY3PR01MB9194.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:22:05.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8mgvbJwR/7TeIBHZZUSNiRehuWJyq6e1ObEzlCG+SzKi80bYsdE/r/83i6e6DnmyKgzIKAnvjQCtNcqbjEu5gd07KNU5PRg5kxmmnIE0p38r0o4iFpnNTUwcnxb0080
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6948
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290215-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.201];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amperemail.onmicrosoft.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B4E659E107
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/18/26 16:38, Adam Young wrote:
> +		skb = chan->active_req;
> +		chan->active_req = NULL;
> +		if (skb) {
> +			dev_dstats_tx_dropped(ndev);
> +			dev_consume_skb_any(skb);
> +		}
It is worth noting also that this section is now wrong, as there is a 
change to mailbox that uses a constant for no-active-req instead of NULL.

