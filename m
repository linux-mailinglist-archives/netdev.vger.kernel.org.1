Return-Path: <netdev+bounces-274597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJuAA7+KzmlMoQYAu9opvQ
	(envelope-from <netdev+bounces-274597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:26:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1038B3C7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B901301B908
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAF34403F;
	Thu,  2 Apr 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="hGfsPlap"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023131.outbound.protection.outlook.com [40.107.201.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650723090F5;
	Thu,  2 Apr 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143611; cv=fail; b=WreuBT8US3ickA+TdgYp8qWxmTWKL4Du1x4t34h0o70UPn61pSG/VkrkTd1mGsTPWXy6QrfW02mpZIo0xNiETEeGDiDnfL2ASS8/npYzHMOlpHjmkii1vtHFt88oMQ6cyxZhW/v1GFKwT1RIk1bi15Embf+KVIKdOaVdh6IfY4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143611; c=relaxed/simple;
	bh=iMkz4IRNNUfJ7LwDY0BvAeHr+vSVEl1G7aoRJ7d+bgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IMQGRakVgU/Ike7T6JAKuaF1u9Pjkyr/HU4o9FZuoxMJHXEJ1HWuvVZ5J1HZ3ATnSDdLg7HeSnvYAEH+5Xzyz8kSkYw4mSvMO4pqGkzYrclnXS/HbRRDeZC3NEqx1DxwBvdWUeqDk0XAfRt/Lod1ZKwjcakPiyH3rnkU0vfNJfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=hGfsPlap reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqzA3B4gfAQ9ODQvLL+mVA4rRnUi6MTnRKuKUrmeCtvywhAVvip91Oxwl7RMBKJTfTlMbbioFYFfFlcJFpUkTnlzICdqmfBxnq8tpm1XQOoHkFZnEng+0ydmau4TrWAo6AkDlw7KQtZ8JxQnAkl1FS5P5Ib2/sh34R7Una5NkANpJNbRwDj9iekOqedrB3qFC1/47Vqk4IzUX/fDuRpMW4qI+Cy17yfIJqn0110XRvqcXYQEq2SovY/4jjmYD1UTYQr0xXt8PnPxiNZgCzSm93yo15lMMFpT9UbxtbF+QJzfNaNpyYnU1U7m+sqOZUDWmKmNNB4Rh1CiAx3LV3NB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbNxADo1swAqWlQIcIG1fMUBj3+O3/gnFvvjyNCm6sM=;
 b=vauVZZjcRbPXD9DSvSR8Kw4v3ao0U5G3hOrvrhefaN1sJI87WPOjCklLdhK3k2iyj8DPZ3KWREDrmENhR6+ztw+JejIUkj5m/tEhX4ialDu2E5NpO987viUuMWEFi2IKanxUqR+FipdAi3jYa6d8kZHRBbtX7QjH2XSsJEmjOX/7zYnyd+M4qN4yAMhnxbYXvyh8dvqd7rBsmrx3xVi5cmu5gVq29z6bnGAvLmeGO9hQqgQcqw9crKiz5DNGhPf5lxRvG0F3K+/L4JKifJia+BlJheEFgu5Qk9ujjLtxs9sT8My9njJkjba0U8PAwaE9WJbXF7/SThM99PHaFmhUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbNxADo1swAqWlQIcIG1fMUBj3+O3/gnFvvjyNCm6sM=;
 b=hGfsPlapX4X2gIb0F7DuG/cymxNIw6b0sU7FSB6WK6dDYhIBMrnC5ZYMquSMnFCzjC56qwS97THJ8ldY/Uu3pCcFuQgSanYnUN8k42bh4rRYjUcw26ZiGMiUisQ4RNiCjwJdGu7SWUmjXal1Lp3SBUksn+S4vDtjl3ACcC4vl5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DM4PR01MB7860.prod.exchangelabs.com (2603:10b6:8:6e::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 15:26:45 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 15:26:44 +0000
Message-ID: <0eb9a307-78fb-4a4c-9e63-fb53295b6f4b@amperemail.onmicrosoft.com>
Date: Thu, 2 Apr 2026 11:26:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v36] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260330175455.1189845-1-admiyo@os.amperecomputing.com>
 <4349e9f1668e443f49f193e1ab69cef669941c61.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <4349e9f1668e443f49f193e1ab69cef669941c61.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0032.prod.exchangelabs.com
 (2603:10b6:207:18::45) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DM4PR01MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: fb549149-8c9e-4f4f-5d6f-08de90cc3f85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/6Dfi/ykjSZoAgFAWarQ9bKTyb3LMo62Osf4MGImeBL/xEIWSBgRmxqk+cYPpvFmTVKQq86S/m5bBMh5oe6hQy3hcFWWXcjpIeLyKSOUkKAS0bkDyP+MsZYWSfRvDGgn7YD/FBRWxCMJ+9zBD25A5NnJwOGYcjW6ougXBiHiSVkff8JN2Nhxn5BW78JnrlUXlyIZ3+c+p7kdWMDyAIDEkv5ohvZysbo/K12hahZRcYwspWotAq53B3tWU+OvowPpxkRwJ7YMVBt2tQXkBVtsdGL84z7J2qxrvbMSNOZj7OQQWd7fNtU6lGdhNfOsCk4ECdZgr+WcB73xIetNpzV0nmyNUvhbI1ee7odRC2afbQZlF6y5cmoIkmvkb80XjHbILxZMrtAqcWmQytgSyGTptcfL0PF8AYG3eE87mMgAN2piuSHU+OqAv6hmZw5v1PLnkeKRjvOF39JnQ6vzFqNO13FnWpua1ToTgF4GWXH69Hex7kfCOR5H2PCLRqQXeq2T9NtsQmbXyzWrlC7Ww7teQvAj411AcScgad0xLts3MxT3MG4lJoGjbXwwG5vcCyVv9QNZInLHkD4IPvQwLRrLpMwx8hc0bDBAC7gfo1OYwkTCekGJsxjqFZP+jqzzo7O2iERUHxC3mOtIvXggJDnkW9S1/ShzdGQW93N8s3vzLRvyJzHE4dreJcusdtPUT2n4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QThzOEtBazZ1YStsUTVnVkJ1VW5xcXQ3aHZKQ1liOVRiQ1psZ3RiWEQxemU3?=
 =?utf-8?B?emdRallJTm9ZdkZHQWwzQ1UwWHhPdWFFejNCOGk2WHJFeFRrTnpKYUxjY2pw?=
 =?utf-8?B?Mk1GcDNyZWNFZFVsTjk0d1Q5RU13dENNOU82dTNsTlpkWmlWZmE4VGJ0ZU5S?=
 =?utf-8?B?dC91QjZndnN1RzI5SU9aVnV3MVFnckRlenVvVXduSktKOU9zNEM2TC9sQ1p4?=
 =?utf-8?B?dUxNOVBaU1pZYllpb0xBOVFITk0wZGNjSHMxdS8zaXpqWFp1ZlhOSUdHaGh2?=
 =?utf-8?B?Yys0K1BIWUtDeEt0Lzh6MDFRR0FSZGVwaHZPMlB0d1hqOTZRc285VTFKTHpv?=
 =?utf-8?B?Nmo3L0Q3Z2NIS05QVHdyWjQ3QkhzM2lmZGpzTUdkMlFreEpTOVBPQkVPVzFl?=
 =?utf-8?B?K3cweFVpMVk3VlcyTzQ3ZktCdy8wNnBTa0p0UDA5MzgvTnF5WUY3cko5Witp?=
 =?utf-8?B?R1IvbTloUE9oTHNTMy9GRmRNUDhPc0YyRmIyVjNic1hMdjFoK1RydzQ4VHF5?=
 =?utf-8?B?VmU3RFRkc3F0RENPeFFhYXJieHRZK1VDMXduaDdDWHR0SEQ2U2pNc01zN2pt?=
 =?utf-8?B?YkZZUTdLci9IZlBORDJuZ2dsVHpLNmQ1alpwYjVvTzlkaldxcmlRN3RuSGtK?=
 =?utf-8?B?aFZaWERmcXpTbXR2ZkdQbFQ2bUNtU1NLdnRNdDMyY2VJalkzUjVyeEIzU3FT?=
 =?utf-8?B?VDN6bVBJRTA2amFicTFUWHJxT0o2VDU0OFFCKzBzUTR3VHVLVFVzaFhBMVlk?=
 =?utf-8?B?U3FQYVdkSlFZcHNEMWZEYm9HLzZabmZCN0g2OVZvWExwQWpRcnhjS055UjlG?=
 =?utf-8?B?R3IrRTdja1VkSUhiVHFRQStUcnFrNTFFclpqYmFINjZFQ1E0M0dSTi9neThD?=
 =?utf-8?B?MVJvRDFha2NrQm8ra216cStjZmI3OGhqU1pROGJSVllaNkc1NWNLa3BHbkN5?=
 =?utf-8?B?UzlEK1BReE1vVFUxV2dNQTRIbjNVZ0dFcDQ5Z2NTZkVvekd5cURLSjZJQ1py?=
 =?utf-8?B?TFJndmJnQUtaL0Z2Q1h3MDNzekVUOTZWZFBSKzRuYzJmbE05aUtiV1BSLy9D?=
 =?utf-8?B?a202aHBHNUU1Rm1QUzBWWklJU0ZZSEl1TzFLTTNObDN6S21xUWNQY04vV2ww?=
 =?utf-8?B?ZG83Nis2Rk56NDFBdjh3U2x5SG9MMnZic2hZakdKM0ZXdDEwQUxlNkN5cmpl?=
 =?utf-8?B?OEVJeDRRa1ViOVc3K3c2cm4yb2M2M3QzYTUxOGNEOWhXempPcnZHTnMwZVd6?=
 =?utf-8?B?Nmd0a3F4Ylk4TUpheSt2WXc1amRrQ1F4S3F6VDFwMHBnYStrbUpwRFEwbVh1?=
 =?utf-8?B?L1FwOUc5RjlXZWlZUzZBTEVQOTJMUUZVcnhRRC9sZERjOGtNdkYwN3E3amJ4?=
 =?utf-8?B?Z2hWYXNqZStURi9oeVB3L05MWkNvZW1RKzlablp6aG5uSUc0OVZjWHZwVjUx?=
 =?utf-8?B?Q3FTdFBWUDV2MkErK1VNd1VHc1hxc3RjYmNzNTRGdEM4Ny9wMXl3OUhrbnU1?=
 =?utf-8?B?ZEh3eXlJYTNXVHNIanBjcVpSNDhkcUNzOTNhZ0MvYnk3aHZidHhzZGZ4TkNu?=
 =?utf-8?B?NjFGK2JnU00yd0RmY0MwZmEwNHlURVc4WUFLSzI0WkFGbWNSZmxYMklFdGUr?=
 =?utf-8?B?SnBRY0kvSE9HOWlJc3lnTlJFckN2OW4wWWExY3FnY2RSZEI4OVhBeUh6MkdB?=
 =?utf-8?B?aVZ1TFpWZDNuM0l3THh3a3RlOFYvQmtlNHF6YTl6SVBCTVV6dnFCMXlZQ2xx?=
 =?utf-8?B?aHpVWDIwY3JhU3hDZU5PcXcyNVlCd1NMTk95ZE4xWEZ5cFQ3RDErWTFKYzhz?=
 =?utf-8?B?d0lVZ2p0T1dBb0Y1MEhPc0h4YjBMV1h0SXB3d1NtVkcwUkJTaGxWTjhqZklW?=
 =?utf-8?B?Znc4c3NXb2Mvd3poSGdEeVgzb1FjZTdmR3hNb0lhakRIemJxcTlyM2UrbjJz?=
 =?utf-8?B?VHdZYVpTQTI2dGxoUGhKVjJBbXB1a3hVUzdpSWlpa2szbTRJNUxtUGlkU1p2?=
 =?utf-8?B?ZEFtdDVpUFVFK256cUVqMmFIRkluS2lxQyt4Vm1LZXZrbUd6VjJmK3NDRFhU?=
 =?utf-8?B?Q3pkb0tSWG95a0gxdDBDeElhbXovOERCQWlmSXl0L1JCWWxxN21XTlAxcE5j?=
 =?utf-8?B?WmRKc2JHSXFSM0JQUlpvZi9IZzJmUGJmSHBnejNCMU9vSVlLbUtDZi9Gem9o?=
 =?utf-8?B?eDFMQU5wVGV2cXphYXlxOUNRMUZsZWNpV2YvNFYrakRrcmcxSWhwekFUb0dX?=
 =?utf-8?B?TFFxOVdMbmhiNGZweDY3RGhISzZLb00zZmsyeEJTTXkza0tUbHB6eTYxTnZ0?=
 =?utf-8?B?NGNoUkkrVmJKNkxESkM2Z1VLSFZMRDFRaWxiQ3BiVmhrZkI5ZFhaZll3ZER4?=
 =?utf-8?Q?cozlYgFfvRZFE2TiaqLX/aV+y7tU+5vi3bV7J04W+VTDv?=
X-MS-Exchange-AntiSpam-MessageData-1:
	QjclWhWvBsCUMo/snbHc6mGhZWxueCH98NqfdL2SvC/rm7ewdNqQ9MZZ
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb549149-8c9e-4f4f-5d6f-08de90cc3f85
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 15:26:44.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Egjqsd877wBVv01F35v9adBKG0YCF2J0GZh9uau9WiFlIKm+qixpNaoS7o446dRGdDnQzVOHtakV+rd/V8J2msA/qBiWoTplq8YYVFY4nFQln5+lwvOX6zcq7hH6QylH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7860
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274597-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.997];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dmtf.org:url,amperecomputing.com:email]
X-Rspamd-Queue-Id: 17A1038B3C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/1/26 22:16, Jeremy Kerr wrote:
> Hi Adam,
>
>> Implementation of network driver for
>> Management Component Transport Protocol(MCTP)
>> over Platform Communication Channel(PCC)
>>
>> DMTF DSP:0292
>> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>>
>> The transport mechanism is called Platform Communication Channels (PCC)
>> is part of the ACPI spec:
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
>>
>> The PCC mechanism is managed via a mailbox implemented at
>> drivers/mailbox/pcc.c
>>
>> MCTP devices are specified via ACPI by entries in DSDT/SSDT and
>> reference channels specified in the PCCT. Messages are sent on a type
>> 3 and received on a type 4 channel.  Communication with other devices
>> use the PCC based doorbell mechanism; a shared memory segment with a
>> corresponding interrupt and a memory register used to trigger remote
>> interrupts.
>>
>> The shared buffer must be at least 68 bytes long as that is the minimum
>> MTU as defined by the MCTP specification.
>>
>> Unlike the existing PCC Type 2 based drivers, the mssg parameter to
>> mbox_send_msg is actively used. The data section of the struct sk_buff
>> that contains the outgoing packet is sent to the mailbox, already
>> properly formatted as a PCC exctended message.
>>
>> If the mailbox ring buffer is full, the driver stops the incoming
>> packet queues until a message has been sent, freeing space in the
>> ring buffer.
>>
>> When the Type 3 channel outbox receives a txdone response interrupt,
>> it consumes the outgoing sk_buff, allowing it to be freed.
>>
>> Bringing up an interface creates the channel between the network driver
>> and the mailbox driver. This enables communication with the remote
>> endpoint, to include the receipt of new messages. Bringing down an
>> interface removes the channel, and no new messages can be delivered.
>> Stopping the interface will leave any packets that are cached in the
>> mailbox ringbuffer. They cannot safely be freed until the PCC mailbox
>> attempts to deliver them and has removed them from the ring buffer.
>>
>> PCC is based on a shared buffer and a set of I/O mapped memory locations
>> that the Spec calls registers.  This mechanism exists regardless of the
>> existence of the driver. If the user has the ability to map these
>> physical location to virtual locations, they have the ability to drive the
>> hardware.  Thus, there is a security aspect to this mechanism that extends
>> beyond the responsibilities of the operating system.
>>
>> If the hardware does not expose the PCC in the ACPI table, this device
>> will never be enabled. Thus it is only an issue on hardware that does
>> support PCC. In that case, it is up to the remote controller to sanitize
>> communication; MCTP will be exposed as a socket interface, and userland
>> can send any crafted packet it wants. It would also be incumbent on
>> the hardware manufacturer to allow the end user to disable MCTP over PCC
>> communication if they did not want to expose it.
>>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> No changelogs anymore? This makes things more difficult to review. Just
> to be clear, when I mentioned changing to a single-patch series, that
> did not mean to throw out the changelog - it's still a key part of
> review.

Sorry about that.  Your list below is accurate.


>
> So, for v36, it looks like you have
>
>   * added the CONFIG_PCC dependency
Yes.  THis was from Jakub's review
>   * altered the RX min length check to include at least the command and
>     a MCTP header

Yes.  Again, from Jakub's review as well as thinking through what the 
most minimal acceptable message would be.


>   * added a RX max-length check
Correct.  If the max-length is greater than the buffer something is 
misconfigured.
>   * added a minimum MTU check
>   * altered the commit message to reflect PCC mailbox free behaviour.
>
> On the latter, could you expand on what happens on close? Does the PCC
> channel end up calling tx_done() on each pending TX during the channel
> free? I'm not familiar with the PCC paths, but it doesn't look like it
> (or the mailbox core) has a case to deal with this on free.
>
> Maybe I am missing something, but could this leak skbs?

Yes, it could, but since they are held by another subsystem, and there 
is no way to access them, it is safer to leak than to free. The Ring 
Buffer in the Mailbox layer is not accessable from the MCTP Client.  
Additionally, there is no way to force a flush of ring buffer.  This 
should be a vanishingly rare case, I suspect where someone would have to 
deliberately send a bunch of messages and then immediately bring the 
link down.  Bringing the link back up would immediately send the 
remaining skbs and cause them to be free, so they are not frozen in 
perpetuity with no chance of being sent.

Whether the backend could handle this is a different story.

There is a potential for this kind of leak even if we were to transfer 
the data out of SKB:  the two options are to either leave it in the ring 
buffer or risk a use-after-free event.


>
> [...]
>
>> +static int initialize_MTU(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *outbox;
>> +       struct pcc_mbox_chan *pchan;
>> +       int mctp_pcc_mtu;
>> +
>> +       mctp_pcc_mtu = MCTP_MIN_MTU;
>> +       mctp_pcc_ndev = netdev_priv(ndev);
>> +       outbox = &mctp_pcc_ndev->outbox;
>> +       pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
>> +       if (IS_ERR(pchan))
>> +               return -1;
>> +       if (pchan->shmem_size < MCTP_MIN_MTU)
>> +               return -1;
> Looks like this would leak the channel? You may want to shift this check
> to after the free_channel().
True.
>
> (but also, should this check also include the size of the pcc header?)
Yes, good catch.
>
> Cheers,
>
>
> Jeremy

