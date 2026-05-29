Return-Path: <netdev+bounces-293090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH1iC390GWogwwgAu9opvQ
	(envelope-from <netdev+bounces-293090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C675601604
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C663034547
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0AA24677F;
	Fri, 29 May 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TRn+3zl4"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B23375C5
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052831; cv=fail; b=isD33TbhUoxKAnLqxJz0Vn5ln3AY1jfiI9YQi/pWYZpXQIgqqgZg6NExmnJv0duv3Ff49klqBhTfq9HS2ae394XjsqSgQimHYG2YP3wztK7ANvN2u4fOIAqlyENLdPmSWLpfyUKQbxKrcY830ViXYA/oF+wvzuJqs+dgyaIOF9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052831; c=relaxed/simple;
	bh=vvz9BK9tlqlCNQoHyKTbIHemJaTwXNGPnOu3/7U/yQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxQM8ovAOfR7rxXuo3i1xfCd5hoC/Yx/oU5j9njoY49eTYRSqoC0WHQCvNONdk38Tdh84U7gmhFJs0sqGoEb5oxzlwOagr/QCruqgsw64eb3aN1BW2Od/gmjDrMT855QbG5x3vyFmueNR+hlRI0ftmIkMakLj1e73SY7nnUT4H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TRn+3zl4; arc=fail smtp.client-ip=52.101.56.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elcGZSuW9DO846CEl95Za+U3lLL9uPdwQR0bCeRThWedm8dJHqnY0Xp0JEn8rdnoqrI1OzjUxp0ggEh8PGj3LXnjNQIAHbit0gN6qMKKWHeWa7qDlH9WpP6cOPAV7qndbFjXfNm4JDPfHdDJxsVI/RTv80ypsam8zd1wL9LRxAcu/Gfo9v08KcWLYAciShhLEKHUFqSG46W3XvO7YezsrvVq/ZDMlCgAo/yeKOJpAnt+AaXOndGmy/GwnIiwBrOsT9PQoLv79MdDU6BmbcvWFWaIV+3h0xZnZZbUB2AykjQt31IYZyfemwpYq3Rjw7GW9GjSsp2LAuSApsecaOepCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvz9BK9tlqlCNQoHyKTbIHemJaTwXNGPnOu3/7U/yQ4=;
 b=Zvb3CJCa2mvVb84Pm2nRwck5MhlH6d0JJVTPH/SXkkNDgHqhH85EKeR9nKClcbFiz2sX7cGT4Q+4XXEd44gK0RB0KLuJyK5c24bKIF2xP/uqyTyteR+ouBOcghSvNWxA5wyehiwAlMnRNpYnzv0C7epSaIy++ii/NnDVZTLFN8wLaFT1Xpot+Q5DlidnI9RZls0hKxP96vVDMJ96pSupBva97u83kohGdISO5+rhpLuL9ulP0qIsnYDw4SPt2IdVUUsb8qalnu3CKHnMwx2WI1i0mmbuQZJIHqrbWDt5OlBWp3i8I7IZnNiPJoOoF43se0j1NQyomqbzhlYq2zH1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvz9BK9tlqlCNQoHyKTbIHemJaTwXNGPnOu3/7U/yQ4=;
 b=TRn+3zl4/dg7gQ5+QTAf9A6m/KsLic2c6jJI+e1XSudeYvimR8flKVJcf0dlLzYxGAqaz7GlgIAM8S3jC0/BfdRN4AvRKZw4trS8e++MJD9arbAEofa6yTwVt5Qj1oYpwmM1L0OVPmDNOuC4eV7qZLHVEo4+lXZZ55vgHirYqoI2TvvuE35LCrBfDCcYKhxwoEPo6xLX34dt/cv6h69X1yiF4fiKVmorB6LL+SoNTEZkKY3zqH2U/vJBoSi0pViCqXrv0pdAmsYBVCDt4i3e3pytfcnOeoAltXPg6XJD7LWgWqHCQE9/8ww3vutWHzJoxEotO5wJbRuAbw1bER3bNg==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 11:07:05 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 11:07:05 +0000
From: <Thangaraj.S@microchip.com>
To: <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<richardcochran@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<Raju.Lakkaraju@microchip.com>
Subject: RE: [PATCH net 0/2] net: lan743x: ptp: Fix simultaneous PEROUT on
 PCI11x1x
Thread-Topic: [PATCH net 0/2] net: lan743x: ptp: Fix simultaneous PEROUT on
 PCI11x1x
Thread-Index: AQHc7CvQjUtyAPJf7E+N/JhiPfZVkrYjM24AgAGqeBA=
Date: Fri, 29 May 2026 11:07:05 +0000
Message-ID:
 <DSWPR11MB9715A5F8F111BF6940F271D4EC162@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260525094931.10371-1-thangaraj.s@microchip.com>
 <00d370e4-b697-492a-85d6-04bd6203327f@redhat.com>
In-Reply-To: <00d370e4-b697-492a-85d6-04bd6203327f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 42d7295b-cdee-431d-f35b-08debd726b19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|3023799007|22082099003|18002099003|11063799006|5023799004|56012099006|4143699003;
x-microsoft-antispam-message-info:
 2NLnszqn14lOfr/dvpIABzkinPLVBqz9ckR/LjJLEYHP+lyUXeyk+D6WfjLmzw0sY7tqr2UR5KLlf+B2scmX0yK/tZaEt9wY3v46xgxdC5dxZ1JGrIEXva4c8mvm1FdDMVC7O6RqgKr8KrsMmAXJsmfm2PgES9vfNnYk7C1BWdwNhv+PmIu8Sdot39M3/p3wPYxZ1Ubuuz7qdogx4NIdwliSAo56rfHJB1jkHoLcaDrztg3MgJ1YOpKzjkTCbB9pufdCrY/IR0TnbqAdBXgL29VnAdfL6655lZAN4GlUih1TTBcqhcJuiuOWTP5Br54eTewYO+g6CrHxU7kmYgYrQSH/WAYmf51AVF5D3F1MO1AzoE2judo4UN5k8EiNzAIOfMgWVH51S9QrBA7N8YuqxKImoF0640k+zMyYAruiVdxnvFfsEE6dpjV2qgKL57f29tJAS1enf/nwsr5BbptSkK18lxqgh0mev4HTB7P1jDOTpB5LFmhrDYTXSFcHln10RnC4Wf51BVhdHkD+FwwnAOTnbdFuAu1pbGTiNlAeOCF8YkPwqQsyhmNKtmWM/wRM8ekeOUUYjMybKwaL2MzZ+QXJInJGdG6cASu+NF9K2UT064zIG3HFaQUsV54FZEOSi6Fy7bpDo6CQgTQEfvFa1IaUQEQUs4500MWmLMc3juaEmugCIXWNkvmEyTlz7LMbd/BvS4AvqzixG/Uk/QqnGGf22sMz1wdnMR9Zwp3FuYAfJNcPK0Mx0dx/UKuuZyrt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(3023799007)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjFSSllFS2dERjl6MTdHa2Z0NFp4RWlCVGZSOFNSSGFDZEdjVDdiK0dnaXVt?=
 =?utf-8?B?ei9ZVTE1RFhhQ0xZWnZjekN4OFNmbHZ0WWlIK2JTTE9VdVFWdWE2a0dJMHVk?=
 =?utf-8?B?ZjBDN0t3cHd4U3ppTFlMT2lQWDFHb0pnQTNtV25LNm0wNHBjV0x1ODM5WFVC?=
 =?utf-8?B?d1N5dXIvS0N2TFJSQ1pVS2M5a3RlM2gxak82WGtLRjFia3NlVzBJSGFaMEZl?=
 =?utf-8?B?WUtmWVZVS1VZdDJvTnNiMlFmZmEwVWM0U1dEVm9sOFpDcEtDRlNidmp5QzRO?=
 =?utf-8?B?SkprVy81Vkt3YTJBQzFHR0RHajdEa2hmaEFJM3hMNUJldUx4UjB6Sy9WTFk2?=
 =?utf-8?B?cmN3bWttQXRqZFlYTFBOSVdOYndRcFBtTTVxaVdDYXVOanJOc3RSLy9PMEdP?=
 =?utf-8?B?b1c5Z0Q5TmF2Y2R2R3poZTZBMjJqY2V6MUR1ZWJ2M3hNOFBJM2NlTFg2NFh4?=
 =?utf-8?B?N3lWZm00ZGZla2w3TG1aQXROVTFnS3BPUGFPRmdaeTJDckhFaEtoTXBjN2RC?=
 =?utf-8?B?RmY0TE44T2ljWXhrbVE3bEp5STBQOFJxelhxMjkrV00xdVF2ZERRSGdmVXhx?=
 =?utf-8?B?VzVoZERjV0NlQitCN2FNc3JFajdEdXRkNVJLK1NhQmFnYjZDMjRPeDhxU2dq?=
 =?utf-8?B?NmlnZ0J3N21zc2VQR2JIV3lGN242RnNndml6UmswN0xkNUh2dU5wZTZUaWls?=
 =?utf-8?B?SWZXQmFiVlUyYS8zd0JvMjU2WVB1QS9QSHNWMCs1VUM1YzA2KzkwbWZuc0tF?=
 =?utf-8?B?NzFOUnlDZHBKZnovOTEydXBOVzVNMWVsZkZRZHk1ZHFCNUczSFVic2gxVmNz?=
 =?utf-8?B?RVpzSWpMdk8vNW1kOGtQZWZXTGtzR0ZMY1VRclE5Q1ZQQU5RYnFwWDhTYkxG?=
 =?utf-8?B?Uy81dHprUjhCRTBBNEJSNTJ5WktsWVZvQmRKa0daTjg5VVRwLzdBMGRDYnNt?=
 =?utf-8?B?R0JJQXdYUEZTUVBzSzBhZDB6WVd3K3d3ZTM5eUdLa2Q0SWU2b3A1YjJFOExm?=
 =?utf-8?B?WWRsT3ZGaWJ3amlLbFhNTUhWZHlYdDc0UTl3cHkrR3NEaFRqYXdDL2Q0Yk1u?=
 =?utf-8?B?ekYvNldmLzhrYzY5ZEFZakw4UzdURlJhb0RibngyQTE4QkpISjNFcXVWdFJn?=
 =?utf-8?B?RjNhZkVtYU5FNkNyVU93b1RlR1BGbDJsZmt2cUp5UGtycGZwOUNsMzhEVnQx?=
 =?utf-8?B?eWZHbDc0RnY3bVlkTVBWa2tNcm1TSHdiMlEvK3FMMmtic05Jenp3MHBmRW9h?=
 =?utf-8?B?NUZQc0kwclI1MlRuS3lpVjJxQWJIekJsT0lSMTJLRGFScEJxaTJWbTBXTWZl?=
 =?utf-8?B?ZVhpOFdMWk5sMlEvWGNZbUhEdlBQQWZGZC9FNnFJVVh2cEZTRWhHMG9DV09l?=
 =?utf-8?B?V3ZyUHAwT2RZWkJYVUZDSjhDako5WWpLaDdqdGFxYVJLc0NqL2FzS0NnWVFD?=
 =?utf-8?B?YVJKNXpHRnlBZSs2TG1EM09zU1Uvc1Z0d3ppR3VRTXhjdDdrZVZkZHdiK2Ra?=
 =?utf-8?B?UVJ0UnVjaWtnUjZueHZ0dTEwWmpyVko1RnFUQXdMcVFHMzNtbm9lTDVqbFZw?=
 =?utf-8?B?aUQ3emJ0K0hmU05PS25yQXhwVENPeDVmalBzQkpyNmFzYTdVbmVSL3Nva2VI?=
 =?utf-8?B?S3VCYTg2T3BmWjZvSmwwTFl3TUowQ05Nc3BlUTErdDZvZVRyVHRhK3JTMzJn?=
 =?utf-8?B?TCtBY0hIU1dIdGtzZ3RrNUpoWXpha1pYb0J0djQwUmRBZ1ZkSzFlVEZneEl3?=
 =?utf-8?B?RWxoYSt5dEk3WTJ4cXVWVHBpck1LWncvbllTT01OUmhjbGFLbzhhdnBEU0J2?=
 =?utf-8?B?TnpOZWgwRFoweHMrbERIakpybVIwaVFYZnEwK3hiMlZYU2k1V2hJc1p4Wisx?=
 =?utf-8?B?MW1pOCtSdXU3a0ExcjNFS2tMZDEzQ1h3TEs2VVBnUWNILzdqWVJJQWV1Z0Q1?=
 =?utf-8?B?aXlvWE15VG4xR0xVRWZaTm1IbnVvd3ZLeWNiVG40YUoxMFVZYnVKQ0Jkais0?=
 =?utf-8?B?cU9HYUVtQzEyOWNaZmdFTkUxa0l3cHEyUEFxVUFRQmhCK2ZjZ1pFd0xyWW95?=
 =?utf-8?B?SHNTWEVzbWxWaWlMdWEvd2l1S3doek5jNHB6TG80QUY5QTY4V2J2WTBaM2o2?=
 =?utf-8?B?Y2NxOGlNNnFzajd6S01xSFN2NDFBbm1Ldnl5QnhFSEROajlTYmJ4VmZ0U2xm?=
 =?utf-8?B?R0pHQlY4K3h6WHpzTll5YUZNZkRrZElMT25JRm9jWTJ5YXc0UDNFNWwxTE1Z?=
 =?utf-8?B?QVJKd2J2bVNnTnVqWkFCK3VFd0ZwMmNQRlByc0s0UFppL2FsYmRucm9pTy9w?=
 =?utf-8?B?ZEdmSTdnVXZXV2prWjVRdHdNSDJRS2c5eG9oUGpRQ2ltdFpDV25jdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d7295b-cdee-431d-f35b-08debd726b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 11:07:05.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2N5duP5b4xINAO42IryOVj3XAfC388cXeyOAvDEjcAq8bcUCPCCSTDHvc7do8hqs3Q6aKcpHUA93PmdI94pxm0I8/mletS4goqIFnWrS/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,kernel.org,google.com,lunn.ch];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293090-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DSWPR11MB9715.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,microchip.com:email,microchip.com:dkim]
X-Rspamd-Queue-Id: 7C675601604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgUGFvbG8sDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBNYXkgMjgsIDIwMjYgMzoxMCBQTQ0KPiBUbzogVGhhbmdhcmFqIFNhbXlu
YXRoYW4gLSBJNTM0OTQgPFRoYW5nYXJhai5TQG1pY3JvY2hpcC5jb20+Ow0KPiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnDQo+IENjOiBCcnlhbiBXaGl0ZWhlYWQgLSBDMjE5NTggPEJyeWFuLldoaXRl
aGVhZEBtaWNyb2NoaXAuY29tPjsNCj4gVU5HTGludXhEcml2ZXIgPFVOR0xpbnV4RHJpdmVyQG1p
Y3JvY2hpcC5jb20+Ow0KPiByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7IGt1YmFAa2VybmVsLm9yZzsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgYW5kcmV3K25l
dGRldkBsdW5uLmNoOw0KPiBSYWp1Lkxha2thcmFqdUBtaWNyb2NoaXAuY29tDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggbmV0IDAvMl0gbmV0OiBsYW43NDN4OiBwdHA6IEZpeCBzaW11bHRhbmVvdXMg
UEVST1VUIG9uDQo+IFBDSTExeDF4DQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50
IGlzIHNhZmUNCj4gDQo+IE9uIDUvMjUvMjYgMTE6NDkgQU0sIFRoYW5nYXJhaiBTYW15bmF0aGFu
IHdyb3RlOg0KPiA+IFRoZSBQQ0kxMXgxeCBoYXJkd2FyZSBzdXBwb3J0cyB1cCB0byAxMiBQVFAt
SU8gcGlucyBhcyBzaW11bHRhbmVvdXMNCj4gPiBwZXJpb2RpYyBvdXRwdXRzLCBidXQgdGhlIGRy
aXZlciB3YXMgbGltaXRlZCB0byAyIGR1ZSB0byB0d28gYnVnczoNCj4gPg0KPiA+IDEuIHB0cF9p
b19wZXJvdXRbXSB3YXMgc2l6ZWQgYnkgTEFONzQzWF9QVFBfTl9QRVJPVVQgKDIpIGFuZA0KPiBu
X3Blcl9vdXQNCj4gPiAgICB3YXMgaGFyZGNvZGVkIHRvIExBTjc0M1hfUFRQX05fRVZFTlRfQ0hB
TiAoMiksIHNvIGFueSBwZXJvdXQgaW5kZXgNCj4gPiAgICBhYm92ZSAxIHdhcyByZWplY3RlZCBp
bW1lZGlhdGVseSBieSB0aGUgUFRQIGNvcmUuDQo+ID4NCj4gPiAyLiBsYW43NDN4X3B0cF9yZXNl
cnZlX2V2ZW50X2NoKCkgcmVmdXNlZCB0byBhc3NpZ24gYSBjaGFubmVsIGFscmVhZHkNCj4gPiAg
ICBpbiB1c2UsIGFuZCBsYW43NDN4X3B0cF9yZWxlYXNlX2V2ZW50X2NoKCkgdW5jb25kaXRpb25h
bGx5IHRvcmUgZG93bg0KPiA+ICAgIHRoZSBoYXJkd2FyZSBjaGFubmVsIG9uIGZpcnN0IHJlbGVh
c2Ug4oCUIGJvdGggcHJldmVudGluZyBtdWx0aXBsZSBwaW5zDQo+ID4gICAgZnJvbSBzaGFyaW5n
IHRoZSBzYW1lIGV2ZW50IGNoYW5uZWwuDQo+ID4NCj4gPiBQYXRjaCAxIGludHJvZHVjZXMgUENJ
MTFYMVhfUFRQX0lPX01BWF9PVVRfUElOUyAoMTIpLCByZXNpemVzIHRoZQ0KPiA+IGFycmF5cywg
YW5kIHNldHMgbl9wZXJfb3V0IGNvbmRpdGlvbmFsbHkgZm9yIFBDSTExeDF4IGRldmljZXMuDQo+
ID4NCj4gPiBQYXRjaCAyIGZpeGVzIHRoZSBjaGFubmVsIGFzc2lnbm1lbnQgbG9naWM6IG1hcHMg
cGVyb3V0IGluZGljZXMgdG8NCj4gPiBjaGFubmVscyB2aWEgaW5kZXggJSAyLCBhZGRzIHJlZmNv
dW50LWJhc2VkIHNoYXJpbmcsIGFuZCBndWFyZHMNCj4gPiBoYXJkd2FyZSB0ZWFyZG93biB1bnRp
bCB0aGUgbGFzdCB1c2VyIHJlbGVhc2VzLg0KPiANCj4gSU1ITyB0aGUgYWJvdmUgYXJlIG5vdCBm
aXhlcywgYnV0IGZlYXR1cmVzIGFuZCBzaG91bGQgdGFyZ2V0IG5ldC1uZXh0Lg0KPiBBbHNvIHRo
ZSBzcGxpdCBpcyBpbmNvcnJlY3QsIGFzIGludHJvZHVjZXMgT29CIGFmdGVyIHBhdGNoIDEuIFlv
dSBoYXZlIHRvIHNwbGl0IHRoZQ0KPiBzZXJpZXMgZGlmZmVyZW50bHksIGkuZS4gaW50cm9kdWNp
bmcgc3VwcG9ydCBmb3IgbXVsdGlwbGUgcGluIHBlciBjaGFubmVsICh3aXRob3V0DQo+IHJhaXNp
bmcgdGhlIGxpbWl0cykgaW4gcGF0Y2ggMSBhbmQgcmFpc2luZyB0aGUgcGlucyBsaW1pdCBpbiBw
YXRjaCAyLCB0b2dldGhlciB3aWxsDQo+IGFsbCB0aGUgcmVxdWlyZWQgYnVmZmVycyBhZGp1c3Rt
ZW50Lg0KPiANCj4gQWxzbyBub3RlIHRoYXQgc2FzaGlrbyBnZW1pbmkgcG9pbnRlZCB0byBhIGZl
dyBwcmUtZXhpc3RpbmcgaXNzdWVzIHRoYXQgc2hvdWxkDQo+IGJlIGFkZHJlc3NlcyBpbiBhIHNl
cGFyYXRlIG5ldCBzZXJpZXMuDQpbVGhhbmdhcmFqIFNhbXluYXRoYW5dIFN1cmUsIFdpbGwgc3Vi
bWl0IGl0IHZpYSBuZXQtbmV4dC4gQW5kIHN1Ym1pdCBpc3N1ZXMgcmVwb3J0ZWQgaW4gZm9sbG93
LXVwIHBhdGNoZXMuIA0KPiANCj4gL1ANCj4gDQo+IA0KDQo=

