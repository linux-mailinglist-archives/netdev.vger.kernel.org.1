Return-Path: <netdev+bounces-302187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /PNTF6mEPmqrHQkAu9opvQ
	(envelope-from <netdev+bounces-302187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:54:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF866CDBCF
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:54:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uclouvain.be header.s=selector1 header.b=P0x2RlVX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302187-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302187-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=uclouvain.be;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B39930099B1
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF463F8235;
	Fri, 26 Jun 2026 13:54:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022087.outbound.protection.outlook.com [52.101.66.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168626F2BE
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 13:54:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482085; cv=fail; b=sxfq+kQhOnreD1sMWGibtI4yrLXCYb3HiFRDl6uc8CitTn7BCWnNmYmU9+zDSPZXJeSwKQj72Ca+WKzxhaSNjqzKlS0sF23lhJaMmM/2NNH+kYm/R5oKwq5S6bIDJFesJGmMeQt6L+3si5FrrJLH3QPe6csKdTx6JPqCrQziq8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482085; c=relaxed/simple;
	bh=prwnH1dWEYLyMUFqNsnCn6nYinpAWDO6n2qG+cP3mO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FI1jPBQo/Xqlg5CvaJJZnIeuZyVTx7UiJburktDD7tGi96Kfg1Gh4HNYtzNvufIGx+RAddfdBLJeFjl0U+XEcnvDHfQAbZRRFndyUPBHzJqLIbqX4bGukdHLvNgNDUy3InsgLofln6LbO+ooFQgqKQq881yKoD4mAnPfH/pQobg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=P0x2RlVX; arc=fail smtp.client-ip=52.101.66.87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpq8jFtXx+SXMC1ix4CXyHRIE6zsewDcN15hd/eD+Qh2GODaiiyK7STdd+ABfjdlQoA5dt2FbiZaDEleIwOUP53Pbs5W+k2LnoHvo/IOQm7dc0BC2ygflSL8lZGls8IuRkTnxn5+owk6w9dgsa1/+RaSHMQ282fIBgius2vu76tjjkF/QqVqA8x6uGS6L65aZfCx1JxEPQdreL11LemBFRl5LcYgwo3evFDu6xCEvZRTfeqlHh4W/ybBGAgCA6XlVx7TVGNPfUUNKJBo0XGBPNXEeaP8QKTHTjaxYTZt4b3vvlwOFeBD4BFfmBULnXEjEjQhD/cQyTy0NcqJmnVtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeTXeI/tPkw4gL53JKRMsce/q48QUPIA5XrnWil55bo=;
 b=lPWUidQf6r23nZT2a9j+fJuPy8teBjlOneMY8C4dkljPncrIVT7nP4R3AeqB+/+12Tz0NdK+ER/JJNQzE6hITYZPD2ONM+RhDd/ArXqwf1DQWTy36pFGW618Wt0gbiLN2BMITIB4Xe5e+n3nKaDThpdoUbecE0i0hRWEWvf9C/UvNdbze67Bmg0HLScZsLz4Pvc9ArcRjtBnUub4xfmnwRZjH/EyJogY1jjbzkheO7rD12Rdnstg9dfeTwgdCgTtaCjwfULtYoS2bYVZ4a7uAn+Wi20J2LPWRoIMKxDU9ipmonHeVFM6dBmw7drf/7HM9DKXPj8ETH97N6o8rWNvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeTXeI/tPkw4gL53JKRMsce/q48QUPIA5XrnWil55bo=;
 b=P0x2RlVXGp0Lsa0W8phpXozS85VoQsbQ5d1L9hvqlN+O//Kr9Kdj/Ooo5/M/ehzFZI7QyD8Xyjmpg46Il3jA5VY0LSAVpqYZNVR9EjrVF4ZIBKo5ktdO65eqiT8K4/RB3TsqCmeaPALO3014AJxazWQrM9B9EbE0Sp8+AKZL6BUGI5OFU3k0piY8zIJw3MboJPcEc32U/03I8x7d9571UJb0ueP6Xa6iyk0tzQC1/5E1V87GCLJYnokHeu2Xi1hukgR0dLPdQpX9ojF3LkhGh0PuiNa00eAuRONKUZNOQFUIvp61wjzpz/l2BO+m+vjsBu+nPQ0Eb4+c2slHUrewXA==
Received: from DU7PR03MB10969.eurprd03.prod.outlook.com (2603:10a6:10:5b2::20)
 by DB9PR03MB7627.eurprd03.prod.outlook.com (2603:10a6:10:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 13:54:38 +0000
Received: from DU7PR03MB10969.eurprd03.prod.outlook.com
 ([fe80::75fe:525a:1f14:22cc]) by DU7PR03MB10969.eurprd03.prod.outlook.com
 ([fe80::75fe:525a:1f14:22cc%7]) with mapi id 15.21.0139.009; Fri, 26 Jun 2026
 13:54:36 +0000
Message-ID: <ab600acc-df7e-49dc-ad63-6457b485c048@uclouvain.be>
Date: Fri, 26 Jun 2026 15:54:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug ?] Packet with End.X segment not correctly forwarded to
 nexthop
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 stefano.salsano@uniroma2.it, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
References: <3fe17ca9-25fa-4fb1-ba06-4463e0409a8b@uclouvain.be>
 <20260624191850.55dd7be54ccc935743f5bc8a@uniroma2.it>
Content-Language: en-US
From: Anthony Doeraene <anthony.doeraene@uclouvain.be>
In-Reply-To: <20260624191850.55dd7be54ccc935743f5bc8a@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To DU7PR03MB10969.eurprd03.prod.outlook.com
 (2603:10a6:10:5b2::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR03MB10969:EE_|DB9PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f710504-cc4f-4973-16c1-08ded38a759e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|786006|366016|3023799007|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	5Q2pfQ4rgvKN0RqXsiD9cHK7Zbt8nniVZSkhhvRV49IC3RBAij+76i71V6o6evhHcF1Qhz5Vui0V3RhtUfvZmn5DNn6r++pygnRKNdzpCfa/Nj2Bq5b2oYPSf2Gr+eLu1rqDhInX+DiNsbRGrpjCK7IJ4NOR5Av3X8JhBbDjLY7aj4OY0ihcThD4wkWAbpGDlkkWMAAFPMyf/HdstzWp83DGKpDfwDU7mMgr814x/82SUie2aHzE9vhalQH3aqEsVXKDB3FWqjOvoyDsNHNBK5Se7aD5eSkLwD1aWLEFjkamJpkVCDOfKLF1l0CZMXXxU05sS8QXmCr0amXBqm1HwvNfrOZ5SYPJCuJeInGYj+b3UNKtOKiEVB9gESIdvACLsYkYs/HrA27FCc5TG8Qsl5Y0u14OB8psKq+G15EmvDYmIvKdjeaAtFCrrSRaD84xIu3Gax6HAZ1DZZyN/fs80admUYyOnfyFzSBY8vcIDuBsllz7FFUYZIKoAds/rZIvcz/P4FD8e+BaYgt3aSo4tT0/4UnJmCS6mfW/Aeacggvw91UYn7NnyKuUW0ddd0Koksxyltf5vuu1mgVnY45At2K7A9d7TamDNsVXRXxe+ysfP+ze0jrq8DSpVvOU29WlKIUpEYQ7BpAhEKTpS+XJzWqox7K/1tHttK1tE97w7Dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR03MB10969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(786006)(366016)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHVzaURrOTBFeE11M0ZtQkMrYmhpUGUrR2JQZWNQNXBEVXhtYWFUZlR5RVJT?=
 =?utf-8?B?eVF3OGRDUm1wWU9rVE0wZ3ZObWJOanVibldjSll6Wi9NbHVhNWJYQTUyT01n?=
 =?utf-8?B?cHhnc2daQ3BrazhMWlNXc2svUktCTG45TThNUTExdis0YkpMenR0bmY2UGtt?=
 =?utf-8?B?VVZPTVVnMkJlak5JYWppeFgvSUVSYWlEZ3JKaysybEJlMHRNTzdjZU9oOC91?=
 =?utf-8?B?NUU4UHhjazcrSXV5U0paWVF3Ym9xOXJlVW5pL3F5OVdiNDREamZvelc0NlBs?=
 =?utf-8?B?eURlRHBDTFlpSVp4S3BCNDBBZFk0clE3RGU2eXJZOG5UWjdidk5WbFZmWER2?=
 =?utf-8?B?MXJpbmQraTVaYmphUStIdlZDWTZpZEhGd2JjSGJpQzcxdkZLcWZGNzFzMU16?=
 =?utf-8?B?Sk1jRGdJbGFYSFpUMzRSTStucGE0dy9FMkt5Z2JyVWNWZ0VwUXhvdlRjNk1w?=
 =?utf-8?B?NHM4OUNiWmZxa29SYVFYM1RPeUp2dDJLbFo2WGdpSGlvanN6dnlYVFB0NTRV?=
 =?utf-8?B?YnJhcDEyQ2lGSU1EVWF6MGlMemovWEVHZEJJY0NBZGRFVHZ3UWtlVzI2NDNB?=
 =?utf-8?B?K1VGa2VGYUQ0Um5wVkUvT2FadVJOWElnaHFDQjBtdjlVUjNlWVY3dEUvQ3Nz?=
 =?utf-8?B?MW10Wm9pWlk4MUswMFdqVE9wT1c0SmtBV3hJOTZjR2JwZjF0TVZUYkhGWkcv?=
 =?utf-8?B?emdGWVAxUisyL3d2NmtnTGFlUUN4eVZVU21QQkFyZXBUTjU2VFV4RkpqMElP?=
 =?utf-8?B?QWMwblVNdU40VWJUVm8vRmlDVXlSb2hWMCt6cWk1UE1RRFYvMDlpbVd5Q2ls?=
 =?utf-8?B?R00yL0JLREQxK2N0M2dUOE5aODFhVzZQcnQ0WGRuTytvZVBUaGN6K3RqMHRF?=
 =?utf-8?B?U3NMd3hkSFo5ek1zTVJxcWhjYTRCNmZKcGVFaDhDVHF2Z0NZVzFzN3lnRnlG?=
 =?utf-8?B?NnN5L08vSnBsTk4xRDhOQnB6QkJ6RjZjYXhGcXE5S1pOcnUzbmpLOXhBRDJK?=
 =?utf-8?B?cDJoWjhhMXpOYitjMytRREQvMC81OGFHWVA4VWptRXpoTVpVNjZvOXczc3dx?=
 =?utf-8?B?ZHFlaXBGZThVdldQeXRnOTQ4UEd2bG56K0g1THg5R1NVV2taSllueFo1cWZN?=
 =?utf-8?B?M0diRTRkK0k5SCt0YTdTYkNQc0lMY25aYVg1elE5TTlPUTlMcUVZaFR0Smwv?=
 =?utf-8?B?SUp6STd6RkZudXZQY2lad1ZEUWZvcTlxeGhheHg4WUFaSm1STVVSUHozL2lk?=
 =?utf-8?B?MjBrVHNwV3hKRDZBWlpQWjIrWmN3Rjd1Q0lzVkkxSWttOTFpM1VBa0FrNnFM?=
 =?utf-8?B?ZWN6NXVRVTIyaXFicnJRZnZOQTIwc1dwaVh1K1BuY2psZEh6MDdMbi9WTllJ?=
 =?utf-8?B?Wmp5czlOQXhOcFZ5RFh6djdxVkdob3dkUVRaT05SeXB6QzJiVGVScDdwN3Nt?=
 =?utf-8?B?bnFWQlcwZVhUbk56TmNwdlVBa3RtV3FaNlhjTG5ySlJLdFJ6UzNueGJiSWZD?=
 =?utf-8?B?b0JuK2RDVnRqMTRUTUpPbzJMUDkxS2NUZHB4VTBpajczNFUycU9CQXJ1MjRw?=
 =?utf-8?B?T2U4UzRsZmZkWmVUVmhNN2t3NE9VNGh5NDM5OFlvb3hsQjVEYVZtdnJqdEhz?=
 =?utf-8?B?cWxMbk9TcjBwL2VnUERHbUtXQk11aWZSaEkrcC9oMjV4bjhlS2lHRWwwUzdF?=
 =?utf-8?B?dGkyNldPVU1mSmZUT01hWFhpU0hoanlKaUhBVmpWd2ljcllobzJ1ZFRJelY4?=
 =?utf-8?B?b3hoTFFJTmV2VG05MnZ1ZjhwZlBMOFVEUTNmTFdhc3pLZzRwZE9XL2U2eHBa?=
 =?utf-8?B?OXltVmNGOGNVN2cxL2c0VUQ5aS9ZNlhTVnppYnBzdGlObnpCRXMrUndOR2xK?=
 =?utf-8?B?Ris5UEppTW1aaHBWK1BrOHlLMlVmZUJOUjhDK0ZLekc5S0FDMUxMcDJCUjBp?=
 =?utf-8?B?UDh2ejBqbE1tLzlZemI4LzQvZ2lsL0RTQW5hSDZML1ppRnRYUWorbUgvWjd5?=
 =?utf-8?B?SmY1Y3dMZkpRN3NmYUtlV3A3YStPbHhFcE5sZmh6aDFiRlh1K2NlZjkzck8v?=
 =?utf-8?B?cnFIMUFUZzZlTGgzYmhaV0JZQVVReko1amNhdTZ4WHQzZ25hcXcxV0NuVits?=
 =?utf-8?B?OEE0dEVvNkM1eXBhZ2hoT1Q5disrSDZtZDJnQk9KeFVrbm5yYlhFeFNJNkdk?=
 =?utf-8?B?dWJ1SXZiYTZiOTlPQmFVYVhRSUtWcHN6QXkveHVEdlNFQktUQ0dzK3ZZY1M5?=
 =?utf-8?B?YTNnTnlvTVhJMEc4OWJvWHZXckthSWVLUkIwVUZWTmQxM3ltSFlKV2k5K2xQ?=
 =?utf-8?B?MDZBRFJubVU5bVZ3RkQ0emlDMDZ6UkxhaGxnb2c5dDNoMHdtMjlpczBNQTlm?=
 =?utf-8?Q?H/NYA9bS23ztZHqzSzHkCeOklxo5c/1d7ijGS?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f710504-cc4f-4973-16c1-08ded38a759e
X-MS-Exchange-CrossTenant-AuthSource: DU7PR03MB10969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 13:54:36.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2xYJIsP/k9GFiXqtldqIHk+vQvtfVWD911V0SGfD/2TR8+eZiEP3pCBNZQSI4VCvj1MDIlsq2T67iqCG+tHfVSkhWxo//oCTZxAzZvP5EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7627
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uclouvain.be,quarantine];
	R_DKIM_ALLOW(-0.20)[uclouvain.be:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302187-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uclouvain.be:dkim,uclouvain.be:email,uclouvain.be:mid,uclouvain.be:from_mime];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stefano.salsano@uniroma2.it,m:paolo.lungaroni@uniroma2.it,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[anthony.doeraene@uclouvain.be,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[uclouvain.be:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.doeraene@uclouvain.be,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECF866CDBCF

On 24/06/2026 19:18, Andrea Mayer wrote:

> On Fri, 19 Jun 2026 15:25:09 +0200
> Anthony Doeraene <anthony.doeraene@uclouvain.be> wrote:
>
>> Hello,
> Hi Anthony,
> thanks for the description and the reproducer.
Hello Andrea, thank you for the reply.
>
>> I am currently experimenting with SRv6 and VRFs, and I found some weird
>> interactions between the two.
>>
>> For the context, I need routers to have multiple VRFs, with each VRF
>> having different routes to reach destinations.
>> Our routers not only send packets to a specific nexthop, but also
>> specify the VRF that the nexthop
>> should use to forward these packets.
>> To achieve this goal, routes in these VRFs push two segments: a local
>> End.X segment, and a End.DT46 segment.
>> Due to some implementation constraints, I want to have a single End.DT46
>> segment shared by
>> all routers in the network.
>>
>> Once packets are encapsulated by the VRF, the packet is sent in the main
>> table to do a lookup for the nexthop.
>> As the End.DT46 segment is shared between routers and can not be used to
>> learn the nexthop, I decided to
>> use an End.X segment to specify it.
>>
>> However, what I observe in this scenario is that End.X segment
>> processing function is never called, resulting
>> in the packet not being sent to the correct nexthop.
> As I understand it, you are encapsulating a packet on r1 and you want to
> decapsulate it on r2.
>
> The first segment you want to apply on r1 is a local adjacency SID, bound to
> the End.X behavior. When applied, it would force the encapsulated packet
> onto the r1-r2 link toward your neighbour r2, and advance the segment list to
> your next segment, the shared SID bound to End.DT46.
>
> Anyway, as you have noticed, this is not what happens. The reason is that
> the packet is generated locally on r1, so it is on the transmit path. An
> SRv6 endpoint behavior is triggered by a SID in a packet the node receives,
> not in one it originates and transmits. So the End.X behavior is never
> triggered: the packet is just encapsulated and routed using the first
> segment as its destination address, and not steered.
>
> To steer the packet, you need to control the table in which the post-encap
> lookup resolves the first segment. This need already came up for another
> use case, originally introduced by Nicolas Dichtel. We referred to it as
> 'route leaking': the lookup must be done in the underlay table, so the
> encapsulated traffic 'leaks' from the VRF to the underlay.
>
> We worked on a patch for the seg6 encap that lets you choose the FIB table
> for the post-encap lookup. I will post it when net-next reopens. You then
> push only the shared SID and, in a table of your choice, add a route for it
> via your next hop. The post-encap lookup resolves it there, and your next
> hop receives that SID as the active SID and handles it:
>
>    # next hop for the shared decap SID, in the table you pick
>    ip -6 route add fc00:ffff:: via fc00::1:2 dev r1-r2 table 100
>
>    # encap route: segment list is only the shared SID, resolved in table 100
>    ip -6 route add fc00::2 encap seg6 mode encap segs fc00:ffff:: \
>        lookup 100 table 10 dev X
>
> - X is used just to determine the IPv6 SA of the encapsulated packet;
> - table 10 is the encap route's table; if a VRF is bound to it, you can pass
>    vrf <name> instead.
>
> The lookup table can also be your VRF table, so the next-hop route sits next
> to the encap route.

This seems like a very nice approach to solve my problem ! I'm looking 
forward to
seeing it being merged in the kernel !

Thank you also for the detailed description about how the kernel treats SRv6
segments, it seems much clearer to me.

>
>> I am wondering if this is an expected behavior (i.e. a node should never
>> push a local segment), or if it is a real bug ?
> It is expected, not a bug. A node may push a local segment. The point is
> that an SRv6 endpoint behavior is not triggered on traffic the node
> originates, as these behaviors run on the receive path.
>
>> I am not well versed into the implementation details of SRv6 in the
>> kernel, but I'm suspecting that this "bug" comes
>> from the fact that seg6_output_core calls dst_output, which does not
>> allow an SRv6 segment function to be called.
> You understood the mechanism correctly. As explained above, seg6_output_core
> ends with dst_output on the output path, so the seg6_local endpoint function
> is not called there and this is by design.
>
>> A minimal example is given below, which creates two namespaces (r1, r2)
>> and allows to reproduce this behavior.
>> (tested on a kernel compiled on virtme-ng from commit
>> e771677c937da5808f7b6c1f0e4a97ec1a84f8a8)
>>
>> Thank you in advance for the help and thanks for the SRv6 support on Linux,
>> Doeraene Anthony
>>
>> File setup.sh
>> ```
>> # Topology under test:
>> #
>> #                    fc00::1:1       fc00::1:2
>> # fc00::1 [ r1 ] ------------------------- [ r2 ] fc00::2
>> #
>> # Description:
>> # ============
>> #
>> # Each node has an additional VRF, which it can use to provide different
>> # routing decisions based on arbitrary rules (e.g. QoS aware forwarding)
>> # Routes in this VRF will encapsulate the packets and push segments to
>> # specify the nexthop (End.X) and the VRF the nexthop should use
>> # (End.DT46). The same End.DT46 segment is shared by all nodes
>> #
>> # Problem:
>> # ========
>> #
>> # Once segments are pushed, the End.X segment is never applied. As a
>> # result, the segment is not popped from the SL, and the packet is sent
>> # on an incorrect interface.
>> #
>> # Forwarding steps:
>> # =================
>> #
>> # - R1 sends the packet to fc00::2 in its VRF `myvrf`
>> # - This VRF encapsulates the packet and add two segments:
>> #   1) End.X segment to force the transmission of the packet on r1-r2
>> #   2) End.DT46 segment allowing r2 to know which VRF it should use
>> #      to forward the packet.
>> # - After encapsulation, r1 does a lookup in its main table for the
>> #   End.X segment, but does not pop the segment. The packet is thus
>> #   sent incorrectly on the dummy interface
>> #
>> [snip]
>>
>> ```
>>
> Ciao,
> Andrea

Best Regards,
Doeraene Anthony


