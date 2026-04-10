Return-Path: <netdev+bounces-277350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJtRKXrg2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:35:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 060063D63F7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3DCE300B47F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BECB388E40;
	Fri, 10 Apr 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="RObgzcj0"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020119.outbound.protection.outlook.com [52.101.84.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC636EAAB;
	Fri, 10 Apr 2026 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820586; cv=fail; b=X8Yt2rCGacFSTk/WrlmIhZl6Ujya4GkApSvWGpbcKjQnKBERS74ssMiQLG+dtE81cAW6Dq/o43f6OQU/NkhwfNuae7Z6CPq0ZHHfHwrHpHFiBXH/ioTdH2jxwlSDdIUrs5XoSVIYHaFG7HuHXjCMPzocoqPbpKEydiX8rP1/odk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820586; c=relaxed/simple;
	bh=VlfPmyW/rvHJYI5H5P7sv6F3apAkG4eBRztezwmmcyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfTm0lEKXbUtxITamZPjcuOjnXGoB7jI2O+2qzEnfQ7H3CNJpTrtD+RaJ6fyYAGL/h7vutd2BJyjy1PyzyI4zAX0KXJosrAPnOaL4t0EeRPeNZiuDfCxBINQjLUOY0/L629knso9/hsdm71F//RMngfZtfZeMTdTBlsE8vl2AxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=RObgzcj0; arc=fail smtp.client-ip=52.101.84.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oImK0vDzsT16hDc5UqP8zzg6RgQrlYZt2B6xXDz7fXkCPwDjhKPl12DzskIRlTjLrd3+7LqLhURaqOJi/QVdQGCcIWBa6wzgVVnoqB7DTVWcT8Sm9WsjI+Lmte3P1PSEdg31FM7wK4m3FtlTkssDzmkTA8QBV+NalVA+LGgMQMS55gONVr3Y3uRW7Id3rcFp7hIfj8kxZ/TbLQGOgOQSDtWZykteJxYGnR0kD9wrvpKILJ3fK84LiVF/DZaSDFaY5XevyG+/qW7eV2NTB1Uhv6dOYTPPe1hSvBAyldtnWuagMIzpwrb6sYQGRmEopSQaSPafLV3mFkS/Bzp58WbOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT/+rXZTuacqov1mq7SF0lV8RvQ3HiZKImY7BxOQLMs=;
 b=Y6hEf3Nvw3n9TSNqV2h+OiwXld2d1W+4sPkJQ+h+0NEFw7bIGMinuWnSTrz84yUyykfE21YFtN76BfZCDEEgkmcRhcEkq2capDTCNbdYbmzBT17Rp16pNAQfvbp2Bx32mJ+kcz3CNykHcfPjaa0dunghvIQ9OFjDusMJedZsmDTPZ046XPKkH0OtEXoUrjNQT/Vu25TUFDFpZpc2rO4KMaEsCk4noAMs+kabKUjirIXWvT8rYX0ZY/+TcbbMAFHXm8mYLQmUH1SA+IPML/FnyKn7Fo6Zw0/TwYHyL8+fMjWbD6F9dPRk8uWmHbviIN2gDg779BSlNWYS6bvWqOIgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT/+rXZTuacqov1mq7SF0lV8RvQ3HiZKImY7BxOQLMs=;
 b=RObgzcj0V5QnTtQa81n6pzQzPCi5jPQ/X7KE1+IMvNLKLp9wZ0+I8vyfAcyNAxKLk7p4HX5XaScoruQwfyoqhsFMNcEBCeE86o1YdKxB08AyyJs/DZ5TEypT5quZJipe0+zHu5oMuq5dq9uCl+ThtNvBLFgdO9K3A96FGaQj0aqiMieHGiDN2XDUaMlcgmmnmNlxGnB5KXFMDkfuZgOuH0miKrCsj8FVx4rFjBTLiQcm7vHQVfJy+kdj11GW0W3bUwp3w0p+EtsPUiEIsQHokXwHKTd2XqGLuHsY2tAzTGiBtKPEpCnvHUOIjyKN40tQyS5bpLku4MVTfkFdzrMFKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by AM8PR08MB6498.eurprd08.prod.outlook.com (2603:10a6:20b:364::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 10 Apr
 2026 11:29:40 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%7]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 11:29:40 +0000
Message-ID: <bd486b55-a8d7-4811-965a-aa1f3dc98e30@genexis.eu>
Date: Fri, 10 Apr 2026 13:29:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/12] net: airoha: Rely on net_device pointer
 in HTB callbacks
To: Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ansuelsmth@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260406-airoha-eth-multi-serdes-v3-4-ab6ea49d59ff@kernel.org>
 <20260410025722.1809973-1-kuba@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260410025722.1809973-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::13) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|AM8PR08MB6498:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dda6686-9857-41ae-3fb6-08de96f47446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LfaL61M9qCbNeNyy2ynzZaoyJ3QM3suxd3YyTeNuYJFGuN/7+KUY95ly9jDCAou6N3y1fOdD5hH+GcKxH2PXkrPO71Qol3cMwjQ4IEiLHvrG1Rl8v7/SWuG55wvlkpqzMf6Yskk8ULjFEA+Bps9x1LndONw8e7laTpaymvHiOtyJDYEGMeeQj/b6uh4pyJr3Txo8zHLxpuO6UBCxzfJdciuoOv42jZVsqG2sKw+E1CCiF/cktlpwx37J2cGVTOHZVc2IXPxUVLFQsBfZ/uuGRgOasIbLRCIOfu2EDY3AFfCU/rz5zDCOS0VIZ7gtFkVwOkyDTzteBCpCZAmjUwiz1VkyWAWZxvL8yu+hmJPs8rsLtfsiEyfa7CKmLDEIXBnAKXC4i68OYnF4rej99xhd+ZdjxP5OuPb1vcFuERcN/lVm507VxfrGoRD6oWd9tmCyz5bJk52GJVzGSVp+OCTL6ltSA58xT6fr3lylUUQHNvwYm4GXsEAicxC1JojXNYcmeMX6vc/MgQUD3+NAT66mUe1dbPt6JA2VuXdqOigib/QeoiVC2FTJmToN9a17QY7HgejzF4pe0+FaJokHirw2jukyIYY1ug6ipCoFn3WXR200zJyC414dPhApr+KcoHKZGUeCl9shLlAZ1dvz6O9Fl6h3xTRXsn8hNq4QtcgkJjoDX+5EB0dy+Jjj/BvNqlHeR3lPCaf2cinJ+cdGUlFm5kZHQrbu/Fcrx/YUoGXIvrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFczaXFUanU0ZTVqRVEyNjdJUy9PWVMxY0RQQnVMbzVZcEg1VEVHNjF3RUxJ?=
 =?utf-8?B?K09xaUxsQTI5dnlPeUF2bys4MXlnQ0ZaS3JMNmc3SUNCck04TW4rNTNvM0RH?=
 =?utf-8?B?dVV6bncwU25qYjlOdkZYU2l4MjQ0R1pXdUZTQlhLS0o4NWVTdVJja2d2QWI1?=
 =?utf-8?B?b2gxTzZCZXkxUXNSaExtaUw4NjRZRzMycnlUVnZLVjc1SU1yQlZ3M0prMitv?=
 =?utf-8?B?UmpPVXp4TmxHbGlHQ0R3REFRbmhONVoySFFZaVBXWXhNU0lXRnlxQWF1YlYy?=
 =?utf-8?B?TUVvbGN2eU5Qd2N6WXd3bmxsbmpFYnRRQVJCWWNVMEF1MURyYS9vaFNDUlJn?=
 =?utf-8?B?Wit6M25qakxrdTdyL1hFcFcvVGJzUVVKYXU1QUI1OG5IaUJESWt3K1NGWTZ1?=
 =?utf-8?B?c25NSng1NVFVWGhGVE5naWpHMnNucktSUEFsTFRmRit2d0pmSmtDc1RYeEhO?=
 =?utf-8?B?azFkNXlnTW9IMlRNeUxsSG44YTJWZUF2d1p1Z1FMcUpseVUvRmhhVEVEcXpU?=
 =?utf-8?B?YWdiQXFkaUhqT2Y4NmVYU1c3Tzh0bkZIbXRLL1NCRHdrem0vN281L3paZFJq?=
 =?utf-8?B?dGQ0VzFIT3J6VFlFWjdaL2dkU1RXNmlnWG1oNGRMT3VRRy9ZV0hLMW9JTUg2?=
 =?utf-8?B?SU9jc09GRm1HUmJNQ1FkY1Z4UnZ4WS94WUlPNWk4OVIyWG1hSll6QlNOMUlF?=
 =?utf-8?B?UlpuTkJsVVhmN2hGYWt5eEp5bjZiWmE5MnVjeExBOENpNE1zSUtQSHdpemU2?=
 =?utf-8?B?UysxZG11M1JMbnV3NUpIazFRVVkzRGVkZmEzMXd3Tk1YS3hSdG43VE12L2xT?=
 =?utf-8?B?U1MvallmREI2SmdrQmd4bzF4dW9iVVVDbVF0d3BsdmNFOFRINnhESmo4VkVr?=
 =?utf-8?B?NjJLSzhvb2NWbTRrWm5yMzNiM3dVVjVmQjVVeGJpY1lCUElnbmpVanRTYWh0?=
 =?utf-8?B?QkpZSkNQaDJ6aHBOaDAwQjM5OGFQRHBKd2pMNUVUNGp4RDNTMko0eCtQTTMw?=
 =?utf-8?B?R2ZPMDhmTncrK2ZEL0w0b0dKamF4NGgzemRPczJHUXdkL003RzlxaDNwUS9y?=
 =?utf-8?B?Y1RDamFLWXdmODNsU0JzSWtsbmdTaDRmb25PZU1iQ29kajhScTRFa2FiWHJr?=
 =?utf-8?B?NWl2bEN2djRhYmc2OFNUQlRLSkFQaUNoYzRkL1JUZHVrWlhHOEtudXpRM3ZP?=
 =?utf-8?B?dHdONm9KRHNjOVRWMmIxSGZJVWt5aWs4WWdCeWt6OE5qS0g0MFF2VUh6MDFF?=
 =?utf-8?B?NkFjeG4zbEJXSlVyWFNwc050UTRCN2FySnRPYktJZ3hNK2drT0NTNGpLZWhx?=
 =?utf-8?B?Y1I4Q2hNY1dNcW8xeDZzRmFucE50aEQzbmJYenZVQzRFNE5SL1RvMVh5QmR1?=
 =?utf-8?B?cmxYL2xubkdmenNzOFlXNkhtWGh1NkI4Ky9mVEwvMzBlOE5ocU5SZ01VWTBo?=
 =?utf-8?B?dWQ2S2pkdjNjRGNUT2orMGh6VC91QmZibmpsb1RkQjRzK0VVL09odkxrd3h1?=
 =?utf-8?B?R0owMlBrU1VVTEZkcEFNaHF5RGFPc3pyd1lkTnNUTG1ENWJNcVJHTXV5YSs0?=
 =?utf-8?B?RUtOWGh5VzhtQVFPbkZpZVMrSS9PT3pLdmJjWVVSTHpyUDMzYnlFNjR3L1l4?=
 =?utf-8?B?UGd5Ym1zNEJCWU5QWG91alJkeVlCckcxTlpSYW1MczZmdFBqZWVNdjZHSzFD?=
 =?utf-8?B?blNYejkzVUpZV3hrQWlZM2hSTWJDUmlsU29kdllGcWdyenpJTE9INU1XTSth?=
 =?utf-8?B?c2JZMnY3TFczQ2FmTXBiaUdkOE9raE1PMlU0R3ZzMy9FRlVmS09aUjZYQlVT?=
 =?utf-8?B?NkUvZmJGZE0vWGI3T2taM0JGOC95SDRhQjM3KzdLb0VkNWlBSkIxUnh4WDRW?=
 =?utf-8?B?NVg5VkptMitEeXhhSGVJTkNtMHgzZTdFT2dsVzJuQzZiWlpwYUlsR05tS0tJ?=
 =?utf-8?B?YmFqdUczcXBvelhBOHZNcUFoNytUZlM5RmlySi8rbWFMVjFkaVlFVUVyYmVp?=
 =?utf-8?B?dE5wOGxQUk9udktBdjh2NTRRM0lsZDJXY0pBOVQvUDR4NkVwSnV0UG44MDFT?=
 =?utf-8?B?QXY2bTJWcXo3akFxbThaUzk0UElTc1ZGdFdCZGNQN0NkbDU1dnA2bGUybGZR?=
 =?utf-8?B?akxHUGQ2RHNxSUxPNElUTFg3RWFmNldVZmNRdFFSdjU5Wmo3ZWhtYlpwbTFK?=
 =?utf-8?B?a1h1UHQzR2F2S0crdnBPVDBLWUVzQ0NFc3FIb2hLVGYvY0tQb05SZXNLWHEy?=
 =?utf-8?B?RlNNZit1bXMwdXd6Q2pNNFVob2VwdlNnZ2o3Y0REL1FSZFd4TE91NHcvT3pa?=
 =?utf-8?B?dWEwT09zM3FJODlGYnR5VHgybk9IdnRpeGxrUlNqYWpIbTVraUVBeXpqby9s?=
 =?utf-8?Q?Dn2uvTu2yo6uJxME=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dda6686-9857-41ae-3fb6-08de96f47446
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:29:40.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ck+g9IIzMQzrNLNrXd29nsoZ6/NjDnBVaW8yvT+fISAJctfJZVRioZqEi4RFj/kUXMst9NArbyxNL1KFzEQ7AmIvVfQg4Qp0oW7jMEFGbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6498
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genexis.eu,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[genexis.eu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277350-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[genexis.eu:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 060063D63F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/04/2026 04:57, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "For your consideration."
> ---
> net: airoha: Introduce WAN device flag
> 
> This commit introduces a WAN flag to specify whether a device is used to
> transmit or receive WAN or LAN traffic. It enables specifying multiple LAN
> devices but limits the configuration to a single WAN device.
> 

[...]

>> +		fallthrough;
>> +	}
>> +	case AIROHA_GDM2_IDX:
>> +		/* GDM2 is always used as wan */
>> +		dev->flags |= PRIV_FLAG_WAN;
>>   		break;
>>   	default:
>>   		break;
>>   	}
>>   
>> -	for (i = 0; i < eth->soc->num_ppe; i++)
>> -		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
>> +	airoha_dev_set_qdma(dev);
>> +	airoha_set_macaddr(dev, netdev->dev_addr);
> 
> Since the commit message notes it is possible to specify multiple LAN
> devices, does unconditionally calling airoha_set_macaddr() for each
> device overwrite the single shared hardware LAN MAC register?
> 
> If so, could this cause only the last initialized LAN device to have its MAC
> correctly programmed into the hardware, leading to dropped unicast
> packets for the other LAN interfaces?
> 
>> +
>> +	if (!airoha_is_lan_gdm_dev(dev) &&
>> +	    (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)) {
>> +		int err;
> 
> [ ... ]

Hi, the frame engine can be configured with a range of wan mac addresses 
and a range of lan mac addresses via registers that set the top 24 bits 
and then 2 registers that form a range of the low 24 bits.

Documentation says that packets that fall into this mac address range 
either on the lan side or the wan side are to be treated as layer 3 
packages and if a packet is not then it will be handled as a layer 2 packet.

The exact implication of this and if it actually matters is unknown. But 
traffic that comes in on an interface that is not matched by an 
acceleration flow is usually forwarded to the cpu for further processing.

MvH
Benjamin Larsson

