Return-Path: <netdev+bounces-307297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bTFbE6BoVWr3nwAAu9opvQ
	(envelope-from <netdev+bounces-307297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9507874F8CF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=eIdslzuv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307297-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B988303744E
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F84395ACB;
	Mon, 13 Jul 2026 22:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0331C33469C
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 22:37:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982233; cv=fail; b=Q7YNyferZt8Vv8IxOjPyWRiLg8cy49mH7wZX0OyP7/SpRt1uvToB/fVwM64m8asO6NVeH+STQQILnG1bqykH8eJztpd8WdwI2GNG9K6jkRymJB0MxPQPrGz48ZhchrUIQ2is2+2njy2jZ9A0LfXhQmzuOgG3nzdxwuQ2yk5L634=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982233; c=relaxed/simple;
	bh=9LfpDRI/zU7S8thkmguMEGvLX26rU9ORQ40wQGmB+q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Juu9MuhASw4UkXnUamOener4JiCtRNbQbFDdcX9LuN9Pi+01Bhyl52oSdxeyCkjur/RK6RWvm2ABoVffIdOlkS4m8FroDjfEi54L2FJFbVeyxpl6l1K+ChXS3Bt9gAKsKVaB8Y+36Ch/Q4rdG8PtnsV1I7J/wPBLjDTEEe4gb/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eIdslzuv; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id68gxi1II+/ls6MOoQobMiVqvsSk3oMT7V8YBNucLdqxlsaxTKuMK3/mOK026OExe+ZWzKEFHUXBq/YxZmESSXcUjwx3MTcKeHk2is+JvnoALqEjF5vXeyGgePjNA19ijiz9r+TSDRp74YF+WZpllUXp7ELmipXUDyAEjWMbTZW7gK8h7HH6O4pB+/rzxjhSXl+4W2sA4EErtnZQqmX9vIolHeCruTRCzEbg8HEh5yJVc2J/CvogalqLvgdUfQ6BYAIeHEfH2+wf0eVHgmQdexOmWPpZvrEzKKqqcgJVG51NHxy6js9ZNe4RJnbsmPdjQ/sOJ00A6S1vxyxgg3KOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtQAJDxxKX+WvuRIQCVEFzUsB9QCE3G9JYDp9qe12qw=;
 b=ji4GbDEqVOFUbONK2MOGdmD5NlLEMnsE34vOTgcY92e0KZr5KgJ5sx1iQv/ZO1eL7N0a5qn8J1NNX8FyhC6i1Y080N5jbielzRWrWhOcAZMUZ9GBJYdv3yBuv0RgL6mY/jp1Y+z39O/Kvn5WB2wTD/9VRyd7Pfddv2SaTNRt8ow7VQYMtUvFTuAy+liVvBxcHWUX3VrvMnn687tK44WVlnXO/k2beMxAoTk1PUOchmJ6aAIHESNV0ch/l9z5N1cvdhD4t9/X8fIMC1ogFmLkCxnMhctG2Iw+1csUzjFh6Stu0qjfW/hYi1S5plZoFFmrYNi5oogHbejaYxIvpYaMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtQAJDxxKX+WvuRIQCVEFzUsB9QCE3G9JYDp9qe12qw=;
 b=eIdslzuvsSCjlXacOQHfk01EsUZk57d8m4iYA1H4XstmXO3+E+FBRW4O8yOczdfc1s/maIEC0UxvBePkLEScEnEma7AAvCP85Mi79I+1KEXcHeI7p4vkJn9nGUWDs+HIFEATz8VgQbb3clj9iR8zgjjdvh77NzIFANuW+azmShc=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 22:37:08 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 22:37:08 +0000
Message-ID: <303a0166-efd5-48b1-8a52-39780095b7a1@amd.com>
Date: Mon, 13 Jul 2026 15:37:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: Embed FEC hist ranges as buffer in struct
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brett Creeley <brett.creeley@amd.com>, Breno Leitao <leitao@debian.org>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260710230026.47721-1-eric.joyner@amd.com>
 <45d2be78-4e58-445e-81b2-75dbcd15402f@linux.dev>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <45d2be78-4e58-445e-81b2-75dbcd15402f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:610:32::28) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d61689-386c-44f9-fbdf-08dee12f45f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KW7ypeiKhB3a6IG3KeLp/fu8oiqR9Q20EqeJgz/tTH7dtHl94/9BmBrJlS6m+qNN/HDv8iBCCl8CVBXRqMiLvayjvSElkyCAf4ZRoWne9gtUq+lWq+NC/EpnVc3KGgXFfDo+c0xZmm9Eo3aVHIcq+lyJZkahaXIvCerDtM2Z9OBXBzHRs1KgiP1c+H4xMbe9te8dQ7r7Cvb5cJb2tCxsPtNd20LYB+9WSil3VkK8ovgNqU5JoTKsKpZ3V7eprild/9UZ86Hp4lB5PXOMztGySpRWvP5jOzCX2XgBgJEULaBJTbj6tdpVmKaT1M4kl23y5GB8h6uxnJfVdFHb4wPYD8tIlYeNq40TzaSeHD8z7EN8UqsOHlOJBc6nxWoWsreSPNx/rfKtFenMjp5qre+NYTFIRRxK3yBVB2OKQ4gsexxLqi6FxBPGXiDQMVzHe6RQ8Gcelp1HvkEipMtj5t8a/FGyfmGje8nYGHEUgSvnX94svry3Bsr1dNKo3s+lpAyKbsAK42eTi+uj0DUBoYprod4njkxYtLxTkFd7dHTsN/++uWnuE+KqggUyyPnux42mBvHpaPuPfH7DelIFKHLpjMDEMt2giz+VoFC/o+AO0mCxvLN6dM+bNDpxKNieNefrVOlf4K+WaNzWcznRxVTrad6RwzNZPwEq97XfktVzZjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WldmWXU0MEhBRzV2SU1ubzloVGRjWXh5aWNEN09FNGFHZEdnTnNlY2dabmRu?=
 =?utf-8?B?R29BMmgxcytxTW5sRGhrSktHNlBXTXBLYXJoVGFuejg0MzJIRlFuaVIzelVp?=
 =?utf-8?B?OXhxZEZ5UFRtWVh6cTZVZnhtczBVcW52c3J3aGdBZjJEeU1QNDhBblpxOHJt?=
 =?utf-8?B?TXVBb3lYU2hlbGJsVGcwZ3VOaUlQSnZ5am1NY3VrOVg2YmdiemlwQVlJa2JF?=
 =?utf-8?B?aldRcldmSVc1NkswMlFESlh0aWNsSGJDOTVQWDJNYTd3RENlbUJKRFVTOTNZ?=
 =?utf-8?B?ZWNMZkY5dERqSGFKSjBUMk16WmRwcFB3QmhSeTVEanhHSk93dXJPRnY1bzJ4?=
 =?utf-8?B?N0ZId3JFOW1WdVlCR0F1ajN6cUF1Z3MrZy9YWHR1ZFZrYXpGSlExbk5JZmhZ?=
 =?utf-8?B?YXdOVnlEZ3dSRFl0bzBmZzBRdFNBbFVzL3hrUlBmLzhZaElQRXBiSVk5Y3Fi?=
 =?utf-8?B?elRVM2dxbFBNandNRDlRVjA0MWJna3ZtUktNaEl1c1k2eXl2c1NydjJ6QWVx?=
 =?utf-8?B?N1ZaYXF0QzJ6UVVMWXFDY2dCaktUWmUvMloveU81a0x1Qkl3SEU4T2ZEYVB1?=
 =?utf-8?B?OVFVUXlnRDI4WE8vdUNiandlVVg3dkdzSExUUFZYSlRFWjltQnB1MW9qSXRi?=
 =?utf-8?B?bmdwaThoS2c3RDIwTHNqUnpyVkJXbm1MSDJ5eS9qR25GdzNnellidFNPdWRY?=
 =?utf-8?B?d0pEQ3Y1RStlbVl2MCtoQUZjSisyWUl4dVFaZk1nSzkxcUVjN0dENkQ4R0Rl?=
 =?utf-8?B?N3hYM3RzM0tTSmZyc0tlN25LdXpiQTRWWVpHdy9yR3l3ZkxINndDcUN3TlNL?=
 =?utf-8?B?NVFidFZJdjVFbnNYZVRvUjNXNXh6WVRKMXRpRTg5T0xpNllCdG01cVJrVVRR?=
 =?utf-8?B?VlhoYW9uWFRBbjNRQnhHVm9ZZjVEbE5McUx0OUlqUmdSYnNJT21iczFKRVFD?=
 =?utf-8?B?dUI0ODlYVTREWU5ZZk5zZ2xEdWVaU3pLRW5ZQlo1S2xIMnpPaCszbjVMK2dC?=
 =?utf-8?B?bHJIdGdDUkpzK25Cd3BSVTc1YU9RM1N1Sy9Fb01MUitjc1RwZ3R4K1gzblpu?=
 =?utf-8?B?cnU5N29qaFZ1bDZkamdCSzJ1ekhEd3NVd3VHdjIvWjhTTEM0Ulk4clpZckJB?=
 =?utf-8?B?a3g4VjluS3RmalNvbDdFcTI4MzZJblhqWkk3VlVIVXEvTTZzUER3MnZPOG5a?=
 =?utf-8?B?ZzdZcmhyMHdhY3VwU084akt4TWhCSktudi9zc3hkWGNnL1pwTzQ5VGJuakJo?=
 =?utf-8?B?cVRoNEErbWpYcDIzTFkrbEFVdWtPcWx3SG14b2E2T05QK0tEcXErUC8xTVBY?=
 =?utf-8?B?aWxLU1pTdEdTZVg2aUxYcFpXUjFxM0xsU1VLWldIQks2RTMrMFc5enMvSFBy?=
 =?utf-8?B?OXl2RnJkZmJ0K2xlVmFvQldzczN0aWNZYkFZcmNseW0vYTBwNGVxQjlmVVVM?=
 =?utf-8?B?NXp1eC9aNzM2bmhEOGRKOTIwQkpabW1FSU1HZnlJU1lSajVqQ2ZtRzBXbXVj?=
 =?utf-8?B?SExBNVNzTlN5NXMxU1pyL3lQRVNJOWNBNkVtZEh6SUs3TEFkL1FZa1QzeUw2?=
 =?utf-8?B?ckpkTkgxL2FyUGlMbFQ5TFl0NEp0ZlpUeDB0SzB2Ny9jeFNMU0duTW1zQ2tZ?=
 =?utf-8?B?V3JUeGx4eXJ1Q3IwRUdYYlJFUEFYWStqdHhrQU1BeUY4L2drbDlUZEdoWmdC?=
 =?utf-8?B?SlNXaithd1VzSWVDQVpSOHhhNGQ0K0FHaFBVMkJhZkcrbk1ZdndhcTZxT2JF?=
 =?utf-8?B?dm9ISy9rWVVnYURaY3AzaUpqWWVJTk9UVHphcjJxZDkzdklPMk0ramREM0tl?=
 =?utf-8?B?N2c2RHJPV21FOUN0QlJLS2Y5c0FtSVViSXFGOU9ZSk9qOHcyenN2MmhDSWhF?=
 =?utf-8?B?MVc2VlVJcVBubHU5eCswMUFmRnNzMG42VWJxamZJTXMyODZyRk9YSE93ODdJ?=
 =?utf-8?B?OXZlTXRqU0tvY1lqNGNac2RWbHU4MGlsWE9YcVRkREdqYWhEZDhCVnE1OXpz?=
 =?utf-8?B?V3pOWE9ob0NURHMwMlU2SmRMaVZ6NVJvUXNoemxoQ2dLNjlTd1E3cG4yN05Q?=
 =?utf-8?B?S2RJRVBmWUg1KzRzbk9tSDY3V1lPdGlwUzYwbHJxZGluVXJTMmNxc0NPWTBy?=
 =?utf-8?B?QXduS0M3b0hoWlAwWEFVbjRCS0JnUERFcXpDSWVIeldSb1BOSUZpbk9BYWpQ?=
 =?utf-8?B?QzA3RHRqS0M4UzczQXpGRUxPU1ltQnRxcEVsaGFRZlpneHMvTXFjOGhBWXBF?=
 =?utf-8?B?dU00VEMwdkZPdlkxRURsZVV4cE40cmduTndtTGZvM2F2N1dFdmdkYlFIbklu?=
 =?utf-8?Q?Obbq+b/F0kKDnivWf/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d61689-386c-44f9-fbdf-08dee12f45f6
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 22:37:08.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMHYI6tRvZo8Ho99QA7DkUfdVoSh47BDpM/N4dpL8+DkNOa9hLjcZ69OSI18Im7/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-307297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:brett.creeley@amd.com,m:leitao@debian.org,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:from_mime,amd.com:mid,amd.com:email,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9507874F8CF

On 7/11/2026 2:03 PM, Vadim Fedorenko wrote:
> Caution: This message originated from an External Source. Use proper caution
> when opening attachments, clicking links, or responding.
> 
> 
> On 11/07/2026 00:00, Eric Joyner wrote:
>> When a driver's .get_fec_stats() handler is called and the driver
>> supports FEC histogram stats, the driver supplies the histogram bin
>> ranges via a pointer.  This pointer is assigned while under the netdev
>> ops lock in fec_prepare_data(), but the actual data is only read after
>> the lock is released; so this allows the driver to change the ranges
>> (e.g. from another .get_fec_stats() call) while the current call chain
>> is reading them in fec_fill_reply().
>>
>> Fix this by embedding a buffer for the driver-supplied ranges in struct
>> ethtool_fec_hist instead of using a pointer; this ensures there's an
>> ethtool core-owned consistent copy that can be used after the netdev ops
>> lock is dropped and later in fec_fill_reply(). While some drivers like
>> bnxt use a constant struct for their ranges and won't be affected by
>> this issue, others like mlx5 (and eventually ionic) will use a
>> dynamically constructed range struct and could potentially run into an
>> issue.
> 
> I didn't like the idea of dynamic range, FEC is not changing while the
> link is UP, I don't see a reason to dynamically reconstruct histogram
> bins every single call. And the histogram itself is stable per HW per
> FEC, can be constant pre-defined struct in a driver, like in bnxt.
> 
> But if dynamic allocation is the only option, then yes, we have to
> change this ABI.

We can discuss this more.

I think overall drivers aren't going to need to dynamically allocate a range; I
mention ionic but at the moment I think there's only going to be two possible
FEC ranges; the sixteen bin one for RS(544,514) and I think what should be a
reduced size eight bin one for low latency RS-FEC RS(272,258) (unlike the 802.3
spec the Ethernet Consortium Spec for LL RS-FEC doesn't talk about a histogram,
but FEC math says those parameters can only correct up to 7-bit errors).

So one option could be to have the pointer be required to point to static
memory; or possibly a pre-defined histogram range entry in the kernel? I don't
see any other drivers currently combining multiple bit-error counts into one bin
and I wasn't sure if that's something the mlx5 driver actually uses, too.

OTOH, doing this dynamic range calculation should be computationally pretty
cheap overall, and provides flexibility without keeping or adding new
concurrency problems (which is an important concern!), so I don't mind the
current approach even if it does look wasteful.

- Eric

> 
>> Since the kernel API changed here, change the in-tree drivers that
>> report FEC histogram stats to copy their ranges instead of just
>> supplying a pointer.
>>
>> Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
>> Signed-off-by: Eric Joyner <eric.joyner@amd.com>


