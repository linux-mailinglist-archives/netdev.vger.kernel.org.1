Return-Path: <netdev+bounces-108916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED992637A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEABF1C2340C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DEF17C223;
	Wed,  3 Jul 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aXfsMpKc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6F17C221;
	Wed,  3 Jul 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017256; cv=fail; b=Wrp48d16wO6GrenH/I1yHQXEw/lkCOCAMJV+PjezeFLjgZyhjsBjkvOYV5pgtXyC2yi3WIaFtPPYf35J9W0POyucVkV2UHzSKGw5xYAs2FyYTeGgXNqF82FgOh6SADwBIb78J9Sg2o1bGMCchAnoyHEli5VITjvobEgYs3LcCfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017256; c=relaxed/simple;
	bh=z/Iq4p1aTycMefBU1mQQ33ABGOZYkI5ipq73rFX2ocY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fki+8vw1T7cDJCx7TEeIU6z5tALn+srx/noM4hvZAoHHdNQaME8G8MzWnB8ZeiAQw+7uWrz1+CvDbetuyiiLbOEHce3WPs4UrvyrlZpa67gWcCHbN8HGyGKfBoyFRM8+lUrDJ4bCTZEsD34J1hhpl5DFGEWTcuACgHB9k/qCXSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aXfsMpKc; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638jcWm004395;
	Wed, 3 Jul 2024 07:34:06 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4053du9d9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 07:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD0EtMurzslB9xcIL3U+oL8U21k9GcGcRqnb18/4irOUJWxnUBsLXGrLxxNzy4sToyDoHmluO31aBtDcmlzFkEnYG1ZRBZUahUDndJTv29pNtnHzm7iuoTQk9ELBFTf9beqgA+VV+oEwpnTKxKqUbQoMRkWzd/gG4Pau8bgRy1u8JNgrdYwvDQAAzNJcpuoE0Mxx2xqVgrHzpgW2PN4nxcrpRCveM53ju+S8SLlAKBJy8djlGtDxMHv48OchqqLf66+KAJZIWUO+caDxoC1REwOWKv54n0u8Zuw1kWmWLu0EivV9h4zxIYcvAmXy6NI/EX4+HCfySZIVmR56dOBFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Iq4p1aTycMefBU1mQQ33ABGOZYkI5ipq73rFX2ocY=;
 b=ffUYev44OW0IZGcW1t2k1ixDkbooKKirXSpy99xmyUJE9WC9ogilOhHTZdjHFgTp/ZYTulIiwYZX8x+9sjV3z3D64Kk7xPY32F4w8E8LChanGIDM8VgXnwUxVC6fReycfZW9mVrPGQTscHNKEyB1FBTJZ/hzCawZP53aexH2mbzk4YqWg1z4NZ48JITtPbnQdmZkYsC/A+AFi1wrflVq1CblDqug8j7gEwH/moTWsj0hOGrudjPy/ZfzCf/RFSrOeKyclRFv1HGacqQkz8hlFy6vKYgPCGU70/Tz4iZCAHNcunijXjdy6vPZA+oQg0/8NU8rdkENjsfJfmz6KIfz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Iq4p1aTycMefBU1mQQ33ABGOZYkI5ipq73rFX2ocY=;
 b=aXfsMpKcVA5KSCeK9WFhZUG2A1c1S5TqFBvffE6fjTanQVOHjd2uWQPz79ACA0HT2uTbzcQCVkVnZ7gOGlyRmbzds6KIO3RR8ggREzBNo5yZzvzabW7tGX+7qImOwLAlvBFSG9cauaPN8KGIZ0VaH2xRrC9D+xjbSCDI262ODRE=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by IA2PR18MB6081.namprd18.prod.outlook.com (2603:10b6:208:4b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Wed, 3 Jul
 2024 14:34:03 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 14:34:03 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Thread-Index: AQHayWAH5wurYZD5Kk24R5BnL2IOPLHk2TOAgAA9MfA=
Date: Wed, 3 Jul 2024 14:34:03 +0000
Message-ID: 
 <CH0PR18MB4339D4A85FA97B2136BF7E1CCDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
 <ZoUri0XggubbjQvg@mev-dev.igk.intel.com>
In-Reply-To: <ZoUri0XggubbjQvg@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|IA2PR18MB6081:EE_
x-ms-office365-filtering-correlation-id: bb72bf2d-48a8-40d0-ed26-08dc9b6d2fd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OWYwMnFrYnBPV0lXTm9scDJSUWoyRExpUkNpSjl4Q2hmSVYzODY2MFVvVDl5?=
 =?utf-8?B?SjhtMjF3TEx1a3VXVlN1U2diT2g3VmVuSzZhcWNhYTV2L3ZzVkkrdEdFaHJk?=
 =?utf-8?B?Nk9mK1BPUFQrWHp4RHpDK0ZZVlJSVkRvaHY3ZE0rNVlmRUlMQ3dXVE5GU2x0?=
 =?utf-8?B?TnB5ZWhTK0JFWTMzaEdnV3NZWVZub0xadngwUWQrZHh1ZlNHUGdpSE9IMmRJ?=
 =?utf-8?B?TjUrZ01URzdQaEZ1aEplZlBWVWpMd2llZkFxa3JMcFdBakNjUWtjTktmS282?=
 =?utf-8?B?Uk1wbDNTUmM1MGVUbzJreDFFRFJyWXZTY2FocTJ3N0w5MFN3TzdqYnY0SE9C?=
 =?utf-8?B?OHhDMFp5S1BvU2tuVk5uUjkzQk1SQW92bmRrYjRBMWlOVlBKT3FpNCtYR1k4?=
 =?utf-8?B?OTVpY1Z0ejVoclhBeHlJYXlqa1AvcEZKdWRVQ3JYb256SjUzWUU0VjRyZWJL?=
 =?utf-8?B?MEg4c3dKUHFiSmtEMUh6R0g3dWJ5Zkh1YnhKZ3ptRjd1MjlDZUxiWTJxUUVV?=
 =?utf-8?B?RmFMcTIrb2pBQ2VJeGVpNUxyTlVVUGNqck0xejJjZ1VEK25zci9yK0JxT1BQ?=
 =?utf-8?B?REYrekxHdlVPQ0ZZT3VZZVkxUVQ2aVRNQTNzbXR6d3NGb0JESWFTSWp4UG1V?=
 =?utf-8?B?b0xuQ2tibHFwcmlHemViVXlBRnVYNFpyRGcyM0JpTjM0WnFWZWNyT081blRv?=
 =?utf-8?B?WHNLekFnMXQ0ZlU1a01oRElhQjBteU91bFV1enpmc3BrcWwwa3Z4UzR2bVJH?=
 =?utf-8?B?UGVHK0RpYXZlV2pZdjI4aC95VC9uN0o3NTFSVkJXanRTUUdvbCtJQzhVR2x5?=
 =?utf-8?B?NVhwMFVjdmJjWitMdmRYb0xpbWh3RWJtUzNqKzBrQlBHRWExQzdMNmMxY0Ft?=
 =?utf-8?B?WFNMSk14bWEvNFpqUDNvMmFMVkliNndRdHlhZkE3VWxpd2V3SzJTY3ZMaDhx?=
 =?utf-8?B?RXp4UWNrTlJna3NyQVJSK0d6UmMzU2k3WDIzaEhoYjI2UmhGRVlDWW1MZ3VL?=
 =?utf-8?B?M0IwU0tXcWUraDRNckJzdlpyYVdvaUNOeG43WmorUFBFeEpLNkVyYlY4NGZS?=
 =?utf-8?B?bm53L2YyNk9TMXA3amJmOUxMbE0xVHA0N0NBR2ZsVGZNOWZOd3J0ajNqZnR4?=
 =?utf-8?B?TGlncXJMcW5hdGhqaERVRi9waUxrOGEyaUY1YWtRbE4xYUo4VVZsUmhKaWl2?=
 =?utf-8?B?Nm1ldUFiN096dG5oTGJsa3hVdTlGcW1RYlVVZFRDcktqbUVTRHNLeFVLM0VG?=
 =?utf-8?B?Z25mbElrZEcvd1ZMMExoWW1EL1hhQ1dSOFhSNjlXVVAwUFZ4YnJiWGFXYnZT?=
 =?utf-8?B?S0hCaWg0eU91UVozbmFqeDFWMjRzQ0p0bkxJSEd4Vm5ZenlFUUtkbk93bGIv?=
 =?utf-8?B?QlIxWFFSR1JFUFRqVEpRYzZFRUpIemJldmFIZ0dZZnlmRnZuaWdaMkludENZ?=
 =?utf-8?B?ZmJmaGJyY3p0Vmh4NWZSK2c0aThmTCs2TUtqS1Z5bzdyNkNWRHlaUktCNnp5?=
 =?utf-8?B?T0JpS0VBWmFQcDVUN3d6N3NCRWR5OG01Q1oxRWd2M1AranJzVUZwSEZxRmdK?=
 =?utf-8?B?YlpMSTNTQ1FzdWlwaGdrbFpYOTQ5RnlyMC9sdGNJZnM3Wk1ESlJIU3RySE9H?=
 =?utf-8?B?citHZHlXOVNwS3dSNWpCUUFwZUd5OXBPY1RpZDhyZU1qMWwxdWNNUWRZSmIw?=
 =?utf-8?B?MHpBbHRBUno4T2JBMkdqeUdiNWErdk9haWZVbHlldFhCc25YcGlteG84THRV?=
 =?utf-8?B?cXdyRUtuWjlsUjNUUXY4VjhIUVhkZTF5cW16L1pKQUVRd2RaRTZSRS9DNGhR?=
 =?utf-8?B?eVp4d2U1V1BwOGdSc3RqYmtLRk5jMGtwUHdIVmFYUVpjM2o2Mm84OVkzSEY3?=
 =?utf-8?B?S2RZUlNiVjU5dzNVczU2dnF5NU4vNWdWQWlUa3o0MEVRVkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WEhpLzIzZDZNZjQxUU5qSlF3K3pKdDRYK3RpRGtHOWswY2Q0dlBhd0lPbEU5?=
 =?utf-8?B?S2lrZVdBSldQWTR5c1c0NHBrd1lJVndCaUZobmIwVWZFVlJWM1Nsak1aOTJM?=
 =?utf-8?B?ZE4xM21iRkZyWjNFZFhvaFJ5dXErZU1FYUFyOGNwRm9sUE1BeWZST3dhbjl0?=
 =?utf-8?B?NjhYR3M5SVdvWWgrZTg1bCthMmVYY1RzM05YcFlJMFV5M1VBRTdrWmFFUGNt?=
 =?utf-8?B?bHFsb1crcVh2L0JyQWZFYlJEb3lQa2FSWFFWRXE3M3hmY3cxd3krbVFYd3Z0?=
 =?utf-8?B?WTI2TFJReTgzeDdZRlUxbTAwRkhRdko3QVRrZEZYTlJ2bW1uUmpFaWpGTUdn?=
 =?utf-8?B?aFFEcTg0eEQxRDhFb0pKZHBhTXFsQ29DNGUyczBlUEl5L3F1WmQyWEU0M3RU?=
 =?utf-8?B?SnpQQVFkNGNsbkF6Z0ZnUk9tZEo2MTJBMFhPTDhOK3VOV1ZpWVRBeHMrNkxx?=
 =?utf-8?B?SnpGK0t3Tm9IRmlqblIxc3AzS0tWcW9rNUt1c2NWQUNFM1JxUHoybnFHN3JO?=
 =?utf-8?B?WmY0bU92WS9Sc2FJV1NqaW1DNnRSSHBhQ3FsT3lVYWdkeTBQOStqNlNsZUEw?=
 =?utf-8?B?NFFqWG1hRzl2N1BUSzdvaUlnNGM2cHB2U2p5VXpGV1lscXNmZWJDdGtjVUdT?=
 =?utf-8?B?NzZrWmdQRFZrS09zOEJoOXJObm1CY1B4c2s1Z0VMSkhUUGtzOUZUOFZyUDhr?=
 =?utf-8?B?bFFTbzhLM0ExNDlHR2RRYmYvRU9xUWY2QmwvVUw4ZWR5TkN1K2JBZDN4WXQ0?=
 =?utf-8?B?TTB5Zm5YL2dNNHRsdVhxQ24vanVCUndnM1ZHZlJkTEt4TWRhNXV0TVdZd3N5?=
 =?utf-8?B?QnY5TFNvNU45elBXWnU2ZEVPRThzVkoyNldVdEJUY0tOSGF2M1NFTkRDS3F2?=
 =?utf-8?B?dTZvYkovRzE4aHgxT3huVVRTcHhNNzFzTUhmOUNJTnFGRDFzcDBiWjV6dWdQ?=
 =?utf-8?B?V2k2N1hkcHZvUStvQ2tNRHpFWnJ4YXFCTjk0ZTJ2K1gzUGhHVmVoSEFiTWFO?=
 =?utf-8?B?OGx2MzdKMGthVVg5cWloai9QMnZKdWNUbklzRVJhODhkcGU5R2V1Wk1zUkt3?=
 =?utf-8?B?Yk5KRkxCNzU0cjBHaEo3MEY4WXRoaXh1NVJNVnZSWVVZVmV4ZVN2MVVHRUhw?=
 =?utf-8?B?VlFLYmFpT25naU9iZkhHT1dDemhuWkVyZm53UkxjWldvUE1JSjYrMFBoWW8x?=
 =?utf-8?B?MlVYdUt2YXFuRlBZdWsram5oMEtCbnVKcFBUeVpsNzZkcnljWUo3VE12Yjda?=
 =?utf-8?B?VFlSa3c1eTh3b0VJeUpuS0prcUc2QTFiMTRlaVJLaitQOCtYamwwdDJ3K1p3?=
 =?utf-8?B?NzA3TFdSWXNGZG9GWnVjS2V5b2ROZ1VLS0tnN2JhSVg1MTVhbzVYbWduaTJD?=
 =?utf-8?B?TmVIV2tlZWVkakIwL0tXZ1FZNFBTc3BvdlVPVEZJZDh5K0M5R2RlWTkrTzJy?=
 =?utf-8?B?VWJ0dGlHWTFjSVplQmpyOU42NjFObVBtQ01uNXVIeFNnMXFwL3pBQnl2c3FB?=
 =?utf-8?B?eGllSWEvbXVQS2lyNlloYXhFRExTZjBzUWNleVh5SG4xWHNEaFJzRmxOWVlF?=
 =?utf-8?B?S0RLRGRPRngrL2xnUWtXVEFudWxIZHZjSGRwejFNQVBxSk9idmdGTmNjZHFD?=
 =?utf-8?B?NWZqV3poNUF2OXJaQ0FSS1AyNlJnYVFGaWlrWUlsN2Ftd0tFV2FFNUREOFIy?=
 =?utf-8?B?dkwrVVREUjJLWEFqcFgwam5jM3FrZWZlQUFWeFhtVzJ2bUp4a1l4cWVGd2Zu?=
 =?utf-8?B?emhpb3NONVVEYmU4U1ozeFlvRnRMbUltTUJ5Yi9hYWZMMXJOb01UNkJaZDdM?=
 =?utf-8?B?dUQrRTRQMlBEdmZYczBiVHVyTkVwekdKRTUyTGJkVEo2MDhXOUFwQndHRjBo?=
 =?utf-8?B?ejZwWWpKTW5BWTRhM2x2d2RPNVpucTNvSmxSTEZ0Y3dxWE8wV2x5ZTBibmRj?=
 =?utf-8?B?YUZsSlVmY2hYQ2oyb1BQZ214VFRpOGJJQnBua2lhenBnYTRNaTVDcDhjS2hB?=
 =?utf-8?B?ZFdUdlZHWFJTM1VnSkxkQ2trbzVRdmg5QXprak9YM25xbEx3T0Z6VWZCc0Ny?=
 =?utf-8?B?eDFPU2ptcXM5UHJmOU5xSGVwcDZlSU81bFNyMGlLcHdqKzFWSjRMZGNwN2t2?=
 =?utf-8?Q?pm08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb72bf2d-48a8-40d0-ed26-08dc9b6d2fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 14:34:03.5426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOeQljZmqhaRSGUgReA0mMdmQo2+me1omx8+e8Enwd69hh2ZcH5niF3UafPyrwijHCwLbcPZlTRX9SEl0c8gpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB6081
X-Proofpoint-ORIG-GUID: yelbO6jc4cnQxd1YO4FWjNOXpc9lDcVc
X-Proofpoint-GUID: yelbO6jc4cnQxd1YO4FWjNOXpc9lDcVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_10,2024-07-03_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhbCBTd2lhdGtvd3Nr
aSA8bWljaGFsLnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNvbT4NCj5TZW50OiBXZWRuZXNkYXks
IEp1bHkgMywgMjAyNCA0OjE0IFBNDQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFA
bWFydmVsbC5jb20+DQo+Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBw
YWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgU3VuaWwNCj5Lb3Z2dXJpIEdv
dXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+
PHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5j
b20+DQo+U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW25ldC1uZXh0IFBBVENIIHY3IDAwLzEwXSBJ
bnRyb2R1Y2UgUlZVIHJlcHJlc2VudG9ycw0KPk9uIEZyaSwgSnVuIDI4LCAyMDI0IGF0IDA3OjA1
OjA3UE0gKzA1MzAsIEdlZXRoYSBzb3dqYW55YSB3cm90ZToNCj4+IFRoaXMgc2VyaWVzIGFkZHMg
cmVwcmVzZW50b3Igc3VwcG9ydCBmb3IgZWFjaCBydnUgZGV2aWNlcy4NCj4+IFdoZW4gc3dpdGNo
ZGV2IG1vZGUgaXMgZW5hYmxlZCwgcmVwcmVzZW50b3IgbmV0ZGV2IGlzIHJlZ2lzdGVyZWQgZm9y
DQo+PiBlYWNoIHJ2dSBkZXZpY2UuIEluIGltcGxlbWVudGF0aW9uIG9mIHJlcHJlc2VudG9yIG1v
ZGVsLCBvbmUgTklYIEhXIExGDQo+PiB3aXRoIG11bHRpcGxlIFNRIGFuZCBSUSBpcyByZXNlcnZl
ZCwgd2hlcmUgZWFjaCBSUSBhbmQgU1Egb2YgdGhlIExGDQo+PiBhcmUgbWFwcGVkIHRvIGEgcmVw
cmVzZW50b3IuIEEgbG9vcGJhY2sgY2hhbm5lbCBpcyByZXNlcnZlZCB0byBzdXBwb3J0DQo+PiBw
YWNrZXQgcGF0aCBiZXR3ZWVuIHJlcHJlc2VudG9ycyBhbmQgVkZzLg0KPj4gQ04xMEsgc2lsaWNv
biBzdXBwb3J0cyAyIHR5cGVzIG9mIE1BQ3MsIFJQTSBhbmQgU0RQLiBUaGlzIHBhdGNoIHNldA0K
Pj4gYWRkcyByZXByZXNlbnRvciBzdXBwb3J0IGZvciBib3RoIFJQTSBhbmQgU0RQIE1BQyBpbnRl
cmZhY2VzLg0KPj4NCj4+IC0gUGF0Y2ggMTogUmVmYWN0b3JzIGFuZCBleHBvcnRzIHRoZSBzaGFy
ZWQgc2VydmljZSBmdW5jdGlvbnMuDQo+PiAtIFBhdGNoIDI6IEltcGxlbWVudHMgYmFzaWMgcmVw
cmVzZW50b3IgZHJpdmVyLg0KPj4gLSBQYXRjaCAzOiBBZGQgZGV2bGluayBzdXBwb3J0IHRvIGNy
ZWF0ZSByZXByZXNlbnRvciBuZXRkZXZzIHRoYXQNCj4+ICAgY2FuIGJlIHVzZWQgdG8gbWFuYWdl
IFZGcy4NCj4+IC0gUGF0Y2ggNDogSW1wbGVtZW50cyBiYXNlYyBuZXRkZXZfbmRvX29wcy4NCj4+
IC0gUGF0Y2ggNTogSW5zdGFsbHMgdGNhbSBydWxlcyB0byByb3V0ZSBwYWNrZXRzIGJldHdlZW4g
cmVwcmVzZW50b3IgYW5kDQo+PiAJICAgVkZzLg0KPj4gLSBQYXRjaCA2OiBFbmFibGVzIGZldGNo
aW5nIFZGIHN0YXRzIHZpYSByZXByZXNlbnRvciBpbnRlcmZhY2UNCj4+IC0gUGF0Y2ggNzogQWRk
cyBzdXBwb3J0IHRvIHN5bmMgbGluayBzdGF0ZSBiZXR3ZWVuIHJlcHJlc2VudG9ycyBhbmQgVkZz
IC4NCj4+IC0gUGF0Y2ggODogRW5hYmxlcyBjb25maWd1cmluZyBWRiBNVFUgdmlhIHJlcHJlc2Vu
dG9yIG5ldGRldnMuDQo+PiAtIFBhdGNoIDk6IEFkZCByZXByZXNlbnRvcnMgZm9yIHNkcCBNQUMu
DQo+PiAtIFBhdGNoIDEwOiBBZGQgZGV2bGluayBwb3J0IHN1cHBvcnQuDQo+Pg0KPj4gQ29tbWFu
ZCB0byBjcmVhdGUgVkYgcmVwcmVzZW50b3INCj4+ICNkZXZsaW5rIGRldiBlc3dpdGNoIHNldCBw
Y2kvMDAwMjoxYzowMC4wIG1vZGUgc3dpdGNoZGV2IFZGDQo+PiByZXByZXNlbnRvcnMgYXJlIGNy
ZWF0ZWQgZm9yIGVhY2ggVkYgd2hlbiBzd2l0Y2ggbW9kZSBpcyBzZXQgc3dpdGNoZGV2DQo+PiBv
biByZXByZXNlbnRvciBQQ0kgZGV2aWNlDQo+DQo+RG9lcyBpdCBtZWFuIHRoYXQgVkZzIG5lZWRz
IHRvIGJlIGNyZWF0ZWQgYmVmb3JlIGdvaW5nIHRvIHN3aXRjaGRldiBtb2RlPyAoaW4NCj5sZWdh
Y3kgbW9kZSkuIEtlZXAgaW4gbWluZCB0aGF0IGluIGJvdGggbWVsbGFub3ggYW5kIGljZSBkcml2
ZXIgYXNzdW1lIHRoYXQNCj5WRnMgYXJlIGNyZWF0ZWQgYWZ0ZXIgY2hhbmluZyBtb2RlIHRvIHN3
aXRjaGRldiAobW9kZSBjYW4ndCBiZSBjaGFuZ2VkIGlmDQo+VkZzKS4NCk5vLiBSVlUgcmVwcmVz
ZW50b3IgZHJpdmVyIGltcGxlbWVudGF0aW9uIGlzIHNpbWlsYXIgdG8gbWVsbGFub3ggYW5kIGlj
ZSBkcml2ZXJzLiANCkl0IGFzc3VtZXMgdGhhdCBWRiBnZXRzIGNyZWF0ZWQgb25seSBhZnRlciBz
d2l0Y2hkZXYgbW9kZSBpcyBlbmFibGVkLiANClNvcnJ5LCBpZiBhYm92ZSBjb21taXQgZGVzY3Jp
cHRpb24gaXMgY29uZnVzaW5nLiBXaWxsIHJld3JpdGUgaXQuDQogIA0KPg0KPkRpZmZlcmVudCBv
cmRlciBjYW4gYmUgcHJvYmxlbWF0aWMuIEZvciBleGFtcGxlIChBRkFJSykga3ViZXJuZXRlcyBz
Y3JpcHRzIGZvcg0KPnN3aXRjaGRldiBhc3N1bWUgdGhhdCBmaXJzdCBpcyBzd2l0Y2hpbmcgdG8g
c3dpdGNoZGV2IGFuZCBWRnMgY3JlYXRpb24gaXMgZG9uZQ0KPmFmdGVyIHRoYXQuDQo+DQo+VGhh
bmtzLA0KPk1pY2hhbA0KPg0KPj4gIyBkZXZsaW5rIGRldiBlc3dpdGNoIHNldCBwY2kvMDAwMjox
YzowMC4wICBtb2RlIHN3aXRjaGRldiAjIGlwIGxpbmsNCj4+IHNob3cNCj4+IDI1OiByMHAxOiA8
QlJPQURDQVNULE1VTFRJQ0FTVD4gbXR1IDE1MDAgcWRpc2Mgbm9vcCBzdGF0ZSBET1dOIG1vZGUN
Cj5ERUZBVUxUIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQo+PiAgICAgbGluay9ldGhlciAzMjow
ZjowZjpmMDo2MDpmMSBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYNCj4+IDI2OiByMXAxOiA8QlJPQURD
QVNULE1VTFRJQ0FTVD4gbXR1IDE1MDAgcWRpc2Mgbm9vcCBzdGF0ZSBET1dOIG1vZGUNCj5ERUZB
VUxUIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQo+PiAgICAgbGluay9ldGhlciAzZTo1ZDo5YTo0
ZDplNzo3YiBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYNCj4+DQo+PiAjZGV2bGluayBkZXYNCj4+IHBj
aS8wMDAyOjAxOjAwLjANCj4+IHBjaS8wMDAyOjAyOjAwLjANCj4+IHBjaS8wMDAyOjAzOjAwLjAN
Cj4+IHBjaS8wMDAyOjA0OjAwLjANCj4+IHBjaS8wMDAyOjA1OjAwLjANCj4+IHBjaS8wMDAyOjA2
OjAwLjANCj4+IHBjaS8wMDAyOjA3OjAwLjANCj4+DQo+PiB+IyBkZXZsaW5rIHBvcnQNCj4+IHBj
aS8wMDAyOjFjOjAwLjAvMDogdHlwZSBldGggbmV0ZGV2IHIwcDF2MCBmbGF2b3VyIHBjaXBmIGNv
bnRyb2xsZXIgMA0KPj4gcGZudW0gMSB2Zm51bSAwIGV4dGVybmFsIGZhbHNlIHNwbGl0dGFibGUg
ZmFsc2UNCj4+IHBjaS8wMDAyOjFjOjAwLjAvMTogdHlwZSBldGggbmV0ZGV2IHIxcDF2MSBmbGF2
b3VyIHBjaXZmIGNvbnRyb2xsZXIgMA0KPj4gcGZudW0gMSB2Zm51bSAxIGV4dGVybmFsIGZhbHNl
IHNwbGl0dGFibGUgZmFsc2UNCj4+IHBjaS8wMDAyOjFjOjAwLjAvMjogdHlwZSBldGggbmV0ZGV2
IHIycDF2MiBmbGF2b3VyIHBjaXZmIGNvbnRyb2xsZXIgMA0KPj4gcGZudW0gMSB2Zm51bSAyIGV4
dGVybmFsIGZhbHNlIHNwbGl0dGFibGUgZmFsc2UNCj4+IHBjaS8wMDAyOjFjOjAwLjAvMzogdHlw
ZSBldGggbmV0ZGV2IHIzcDF2MyBmbGF2b3VyIHBjaXZmIGNvbnRyb2xsZXIgMA0KPj4gcGZudW0g
MSB2Zm51bSAzIGV4dGVybmFsIGZhbHNlIHNwbGl0dGFibGUgZmFsc2UNCj4+DQo+PiAtLS0tLS0t
LS0tLQ0KPj4gdjEtdjI6DQo+PiAgLUZpeGVkIGJ1aWxkIHdhcm5pbmdzLg0KPj4gIC1BZGRyZXNz
IHJldmlldyBjb21tZW50cyBwcm92aWRlZCBieSAiS2FsZXNoIEFuYWtrdXIgUHVyYXlpbCIuDQo+
Pg0KPj4gdjItdjM6DQo+PiAgLSBVc2VkIGV4dGFjayBmb3IgZXJyb3IgbWVzc2FnZXMuDQo+PiAg
LSBBcyBzdWdnZXN0ZWQgcmV3b3JrZWQgY29tbWl0IG1lc3NhZ2VzLg0KPj4gIC0gRml4ZWQgc3Bh
cnNlIHdhcm5pbmcuDQo+Pg0KPj4gdjMtdjQ6DQo+PiAgLSBQYXRjaCAyICYgMzogRml4ZWQgY29j
Y2luZWxsZSByZXBvcnRlZCB3YXJuaW5ncy4NCj4+ICAtIFBhdGNoIDEwOiBBZGRlZCBkZXZsaW5r
IHBvcnQgc3VwcG9ydC4NCj4+DQo+PiB2NC12NToNCj4+ICAgLSBQYXRjaCAzOiBSZW1vdmVkIGRl
dm1fKiB1c2FnZSBpbiBydnVfcmVwX2NyZWF0ZSgpDQo+PiAgIC0gUGF0Y2ggMzogRml4ZWQgYnVp
bGQgd2FybmluZ3MuDQo+Pg0KPj4gdjUtdjY6DQo+PiAgIC0gQWRkcmVzc2VkIHJldmlldyBjb21t
ZW50cyBwcm92aWRlZCBieSAiU2ltb24gSG9ybWFuIi4NCj4+ICAgLSBBZGRlZCByZXZpZXcgdGFn
Lg0KPj4NCj4+IHY2LXY3Og0KPj4gICAtIFJlYmFzZWQgb24gdG9wIG5ldC1uZXh0IGJyYW5jaC4N
Cj4+DQo+PiBHZWV0aGEgc293amFueWEgKDEwKToNCj4+ICAgb2N0ZW9udHgyLXBmOiBSZWZhY3Rv
cmluZyBSVlUgZHJpdmVyDQo+PiAgIG9jdGVvbnR4Mi1wZjogUlZVIHJlcHJlc2VudG9yIGRyaXZl
cg0KPj4gICBvY3Rlb250eDItcGY6IENyZWF0ZSByZXByZXNlbnRvciBuZXRkZXYNCj4+ICAgb2N0
ZW9udHgyLXBmOiBBZGQgYmFzaWMgbmV0X2RldmljZV9vcHMNCj4+ICAgb2N0ZW9udHgyLWFmOiBB
ZGQgcGFja2V0IHBhdGggYmV0d2VlbiByZXByZXNlbnRvciBhbmQgVkYNCj4+ICAgb2N0ZW9udHgy
LXBmOiBHZXQgVkYgc3RhdHMgdmlhIHJlcHJlc2VudG9yDQo+PiAgIG9jdGVvbnR4Mi1wZjogQWRk
IHN1cHBvcnQgdG8gc3luYyBsaW5rIHN0YXRlIGJldHdlZW4gcmVwcmVzZW50b3IgYW5kDQo+PiAg
ICAgVkZzDQo+PiAgIG9jdGVvbnR4Mi1wZjogQ29uZmlndXJlIFZGIG10dSB2aWEgcmVwcmVzZW50
b3INCj4+ICAgb2N0ZW9udHgyLXBmOiBBZGQgcmVwcmVzZW50b3JzIGZvciBzZHAgTUFDDQo+PiAg
IG9jdGVvbnR4Mi1wZjogQWRkIGRldmxpbmsgcG9ydCBzdXBwb3J0DQo+Pg0KPj4gIC4uLi9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvS2NvbmZpZyAgICB8ICAgOCArDQo+PiAgLi4uL2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL01ha2VmaWxlICAgIHwgICAzICstDQo+PiAgLi4u
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NvbW1vbi5oICAgIHwgICAyICsNCj4+ICAu
Li4vbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL21ib3guaCAgfCAgNzQgKysNCj4+
ICAuLi4vbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL25wYy5oICAgfCAgIDEgKw0K
Pj4gIC4uLi9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmMgICB8ICAxMSAr
DQo+PiAgLi4uL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnUuaCAgIHwgIDMw
ICstDQo+PiAgLi4uL21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9kZWJ1Z2ZzLmMgICAgICAgIHwg
IDI3IC0NCj4+ICAuLi4vbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X2RldmxpbmsuYyAgICAgICAg
fCAgIDYgKw0KPj4gIC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbml4LmMg
ICB8ICA4MSArKy0NCj4+ICAuLi4vbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25wY19mcy5jICAg
ICAgICAgfCAgIDUgKw0KPj4gIC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVf
cmVnLmggICB8ICAgNCArDQo+PiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2
dV9yZXAuYyAgIHwgNDY0ICsrKysrKysrKysrKw0KPj4gIC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9h
Zi9ydnVfc3RydWN0LmggICAgICAgICB8ICAyNiArDQo+PiAgLi4uL21hcnZlbGwvb2N0ZW9udHgy
L2FmL3J2dV9zd2l0Y2guYyAgICAgICAgIHwgIDIwICstDQo+PiAgLi4uL2V0aGVybmV0L21hcnZl
bGwvb2N0ZW9udHgyL25pYy9NYWtlZmlsZSAgIHwgICAyICsNCj4+ICAuLi4vZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvbmljL2NuMTBrLmMgICAgfCAgIDQgKy0NCj4+ICAuLi4vZXRoZXJuZXQv
bWFydmVsbC9vY3Rlb250eDIvbmljL2NuMTBrLmggICAgfCAgIDIgKy0NCj4+ICAuLi4vbWFydmVs
bC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmMgICAgICAgfCAgNTYgKy0NCj4+ICAuLi4vbWFy
dmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmggICAgICAgfCAgODQgKystDQo+PiAgLi4u
L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2RldmxpbmsuYyAgICAgIHwgIDQ5ICsrDQo+PiAg
Li4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMgIHwgMzA1ICsrKysr
LS0tDQo+PiAgLi4uL21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYyAgICAgICAgIHwg
IDM4ICstDQo+PiAgLi4uL21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguaCAgICAgICAg
IHwgICAzICstDQo+PiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3Zm
LmMgIHwgIDE5ICstDQo+PiAuLi4vbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9y
ZXAuYyAgfCA2ODQgKysrKysrKysrKysrKysrKysrDQo+PiAuLi4vbmV0L2V0aGVybmV0L21hcnZl
bGwvb2N0ZW9udHgyL25pYy9yZXAuaCAgfCAgNTMgKysNCj4+ICAyNyBmaWxlcyBjaGFuZ2VkLCAx
ODM0IGluc2VydGlvbnMoKyksIDIyNyBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+PiAxMDA2
NDQgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X3JlcC5jDQo+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
dHgyL25pYy9yZXAuYw0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVwLmgNCj4+DQo+PiAtLQ0KPj4gMi4yNS4xDQo+Pg0K

