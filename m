Return-Path: <netdev+bounces-257743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIDBFvnMhmnpQwQAu9opvQ
	(envelope-from <netdev+bounces-257743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:26:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D2105042
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717D8301B71B
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 05:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD132EC54D;
	Sat,  7 Feb 2026 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iaVolPT1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933742D7DF8;
	Sat,  7 Feb 2026 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441973; cv=fail; b=fpE2sF91NC1gMgKOWh4l3HtFScNv4lrAC/Z1unAt9oMYB7l9x/59BokeAFm1CNo6Vt3Yo8mOZVD6MM0qE71651B9N7vSG4GOM7YKKKbz2E5ACqDHKhXsvdE2o3+chzQaSqIPnFmFxZxWBm97Q8eb8wqWFNC2UAROIGG2XaU5xSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441973; c=relaxed/simple;
	bh=K+NNZq5j7YsHiAPBro+e6Zt9wYXf9lPjbg8EWN7O8pI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXrJMTbb1P3aLgqKsbBkH+qS5ZnCyga21vIArdZsUf3oe2sskoy0MkgF3zcCkcMQcjlwEmtVF0ctHnDRLrKdGu8gRmwDcyweVHeTIW1+4CMVlbvgJanSYfEl4cakfOSCrGFZguTmk3WhxUvq6GWdxC8nVAEcGRqQhhVi+INpsNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iaVolPT1; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6174kgWr2735027;
	Fri, 6 Feb 2026 21:25:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hwZuhR2YflQCiPkueFM36cR/ybid/7eFRPIF4WhdWAE=; b=iaVolPT1Tynx
	AF6ey52hH1c+72chIAwfs2Gl/ErdccbFY6NIk5KPR1v5FFcgB4+0jcGQNJs5ZWgn
	xyP6SmGFc/H3mF6aCFZBbUv4ml1xT+9Kmv9i9gE6Wg4UrDrnhuifwq0q2G2y+/vm
	f2Lt/cU1Y0HxHYCOw4ThbWqqf/sFEwjNs64AuGqjyBd069uJy3NJG6SiD8iQqBC0
	riHrzlbSPkUFXImmkL7uJQ/FKmiAYST1YTM1OX+Mm2XHo6RDCPdZYrkowPO91Yww
	KO4h2C4ve/1hlvKMzWgQ7UgmeuzY9Es2Lcq4+n5fIBILb2u/5uVHQDSNDRl8XLmx
	SRFNpisx1Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c5xnm05mk-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 21:25:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rns/2HuKdSw4Oz+TYlHh1G4vcgXSgh9ijEABIm0s9CutE4STlFKAqbb0X7VzaZSWwNwdjMRkZdGDGgu8C73tp31EoEJvFrsLYMm53nfwfbZyu76JzECQVKl7cxZjhzpbNeWg52Uqu+ke1115a8VVcQ2v6O8Zso4+PX/PLZJjB8b4JlyUAzRFYd1jYhsdKMPj5Ks5T8+N8EnHHLlaS3DdBEl6F3Y/8IPJPNXdVI9YMIujzXflvwQP4ez9qUaUV1mpub0FSPQuiYuGmjqTxX7xTSUhYB/bmOMwAtfKAC8BJ5sU2+eCkrdDWyIRHKrQpSNDJBgZJG7kaW27beK4Rl0ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwZuhR2YflQCiPkueFM36cR/ybid/7eFRPIF4WhdWAE=;
 b=F6bCayuYkPztuKIXxnNiKlvtk9EbO+5LvSyvfbx7IOJ8y8XVIXv61UnuxpOUrfktM6yTOuv/BEiNdkXd5vALmz/Ma6dZeVLe57YvLMjuHNuVG06Px9XnLe9kdrDPbODM/8UEnjnq3tzUDfkawHwJgMG1VtXShhC/Dwv0mWKu45E0mJFhjbxSToeC7abTuVfe8uAkjcZeRgdpsHtG1nzg7bQW1TZrIrkbNTBSFQjtEXVepP2pkqh6b0Ak7KgKZwYgbLK7goqhc5z988qSBIXMywQHFysMrAXFaJWnLGMRwRHKv41JrLmuEqLlSSpj1t1i5mwZyIhjAjMebHlb+CF6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA0PR15MB3904.namprd15.prod.outlook.com (2603:10b6:806:85::8)
 by MW3PR15MB4076.namprd15.prod.outlook.com (2603:10b6:303:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sat, 7 Feb
 2026 05:25:43 +0000
Received: from SA0PR15MB3904.namprd15.prod.outlook.com
 ([fe80::b685:dec4:1306:276d]) by SA0PR15MB3904.namprd15.prod.outlook.com
 ([fe80::b685:dec4:1306:276d%4]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 05:25:42 +0000
Message-ID: <e4a76ce5-9675-488f-a8f4-0f0541024d00@meta.com>
Date: Fri, 6 Feb 2026 21:25:25 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH net-next v5 2/2] virtio_net: add page_pool support for
 buffer allocation
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260206002715.1885869-1-vishs@meta.com>
 <20260206002715.1885869-3-vishs@meta.com>
 <20260206204140.56d85273@kernel.org>
Content-Language: en-US
In-Reply-To: <20260206204140.56d85273@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To SA0PR15MB3904.namprd15.prod.outlook.com
 (2603:10b6:806:85::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR15MB3904:EE_|MW3PR15MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 664252d1-94d7-4f85-a1eb-08de66095690
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TlNJVnFuanBYZFpOSXpQaFRJaEU2L0daUWZOK29PSG1MQWlnT1FkZGwxTEZK?=
 =?utf-8?B?SjRnbzBlbHFieGVhdEZhWEdHWCtWRkp5UnprajV3UXQzbVhkbGhIMlFJTnhw?=
 =?utf-8?B?VGltczc3cVJiY2ZRNUVVSU5aYXpHcFVDd2k5SG1leGpQYWZ6UXFkdXJISmNm?=
 =?utf-8?B?S0lBUytBYzdYaFFyVjNMK3o3OVJlbWJOTVpwTExvU1JMMjFpUVhzUzdJVHFT?=
 =?utf-8?B?aWx3bU40cVMydmxUNmtsQ3lWMmhWOG81MFhaWW92Ykt6eVowZWh2Y3VWSWVx?=
 =?utf-8?B?cWMrS1R4cCtVQmR4NTF1eWNpM1JETDFqd0tJUkhOUXNZNWo2RDVlYjNUb1lj?=
 =?utf-8?B?REhKc2dtdXR2c3lKMkRwUHdJcmxHaVcyTmxFWGpBRm04ZTB1UmZtZ1JGYVZs?=
 =?utf-8?B?ejBoZWNLVFVxUEpIYjY3ZjhaS1NLZmxDQ0JVMGd2Y3VMSUE3T0NGMWRGdVlD?=
 =?utf-8?B?RzZwNjZvQWV5b3B1Qnc1VDA4MEU1b1BLWTFHMTAvbjRmT2Z4UDVPK1pxZWlH?=
 =?utf-8?B?RDg4ejEvS1dZTXl6UGwzL09EVnNhYzdpdlYxV2hTWWoxbm1nKzNGbmxRVkVO?=
 =?utf-8?B?U0xvcUhlTEJEWGpvajVGalV1YUpZeDZQQmcxWVdUMEFKWGNkOXZMTWpxdFF3?=
 =?utf-8?B?QjIwRVdYRzE0WFAxSVE0KzZ3M3NBdEFXaXJQOXIxdDdoNWY1S09tUFFaWUp0?=
 =?utf-8?B?aWFQOXQzZUdNT2ZKYnltMUliVEV1bHdiQlVGdXNISGdNZllLU1hXQjVndmhk?=
 =?utf-8?B?VGM2OHBNTWVicDR2NUlReUt1dzhSbHd2OEhoUmd4eFkyQ2hISHpxUCtjbmt4?=
 =?utf-8?B?YzVsZVVuMHhERDI1STlsUHdENGlaRWVSdmJzZlRKVkhBVUo0TmFyMjRnSkp6?=
 =?utf-8?B?ZGZneWd5a2dadjM1VUxWczRieDBZZ2t5TUx5dWRlOTBxaEFIelNmUnZsZGlZ?=
 =?utf-8?B?OC9NbGhxWFlWODQ3VTBmQTByc1M2YVhYbjYvVzBoZllvNTlGNThtaXpIVmNj?=
 =?utf-8?B?VXpuZ0tGaXlyQjNYVEFKbnlYdk5Nci90ZlZhQ2cwWUFNS0hLb1dLSjFHWmVN?=
 =?utf-8?B?c29YR2IrcFpuVG1Wc0VKOER5Sk1raXpkS0ZpdmY2YUNNaVlRS25SRG9VVjZJ?=
 =?utf-8?B?U0ZHZkhPRG0ydmxIdTY0NDgwWUVXaVRGdW8rQTZNVysxZy9HdHM3SVpPQmRO?=
 =?utf-8?B?YS82VlBWMm9XMWZ4RTBqNE1MOHdLT2EyNDJPZjJXUmZJVm91OEczT01QZWZU?=
 =?utf-8?B?Q3d1cVlVdWlubXJ3V21SUm1DcDRDa0FzY294dHJtRkFSc0pkMTdmTnptUEcx?=
 =?utf-8?B?MFArdFpzbDdpbkpWOUQ5QktHc1JWZ2VWOGVsZUhBU3BDcTRZdnRsdlZSZ2FE?=
 =?utf-8?B?WHZ2UUJPR0FTcHRUdnJYbjRWSWxUd2s0dGNSR2hTUTZ2YTVlUjR4TW9ZUGtL?=
 =?utf-8?B?cXpPakhQWnNOSFNqWXlrVGFDaEtrWEg0bjdYQm1zRm4wc0MzbDBNejVHaks4?=
 =?utf-8?B?enZ1N3NkRytidUdwbHVNSHYxb2ovdXF5aTkyR3oyMGhXR21pekFTNk5yU3ZO?=
 =?utf-8?B?bHNzZVh0TzVkT1lVV3ZSdHI3aVArK1drdE9QbSs4NHExdll2ZTBGNHdXd2l0?=
 =?utf-8?B?aGdEZ3JpYUpsbkZaUWlmOWs4OWJDWjdvblpjQXNZc24yeW9TVjBZYWd3V3Z0?=
 =?utf-8?B?TjdzNXZBbFJ0UENTRkFCZEpYZU5pZmNsLy9ENzV2YTNDb29MUkpuUFNEU0JC?=
 =?utf-8?B?bXFCTGNnbmlOTFZCZzBwck01TlovQk5GWGVvMFV3RHBpWmxYUVVwSW1yRXlZ?=
 =?utf-8?B?MzdvUU1nd0t3TTY5UTd4bS8xOFFwSEhJbExUUTdlRWY1T3FocEVONjljU3Bv?=
 =?utf-8?B?bnRVZnNNK3ZPOVNmcmFZQjF2dUZaMmRrcFVJVUdWYTFQU3RTQTZyYTdHcHV2?=
 =?utf-8?B?bWc2OHhYRGwydXVkcFVFY1YveDY0dzZObm9xRXN2c1FxczN0Zk90UUVnb0NO?=
 =?utf-8?B?SktaN0J5bllGTjhGeW95c1h2VVBhWXdZNjdrV1p5M0d3L1h4WmNKWC95WmRa?=
 =?utf-8?B?dmZQZXdxNTVrVFRGQW5MVlAzSnliN1BrOHJnTlRyS2J2dkZqU3RFMCtURXBr?=
 =?utf-8?Q?JE7s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3904.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z3ZBQXRKYlRXUDVuZzVHSnJ6VUY3OW9JT0xHZWw3QmhKYTZZb1RsNittTVov?=
 =?utf-8?B?ZGQ0VGVnUURmZWlrbnM3eXBrZjRRd0ptb0ZVR0c5OXE1SFR3dkRaNXVseks4?=
 =?utf-8?B?RjZpSlZzcktoUCtnTktrL1pMa3ZOeFNDS3RTWEFYZ1YwUGhKdFk4MXBZOGdj?=
 =?utf-8?B?UXdKbVlvR3EvUkl2dVVmTVBzQVFjTjg4MkFBTTlUeWZCYUtlcS80NVh0K3lk?=
 =?utf-8?B?d3NIckhIbVVJMmwzTHM0eW5ad0UySkxQNHYxUVZhUWNsekZPNElpUWFWaU15?=
 =?utf-8?B?M05kaXo5bkdNWXlLb1J3TVZpQkhPbER2T2hzQW9jMG1zVVQzaHNkcHRIV2Nj?=
 =?utf-8?B?WTRwVnJmVGg1Y2ZKVGNZYkxxOUdhc2NKeXU0L2dDdkRxbWd5UXY3WkJKTVc4?=
 =?utf-8?B?WVBnQzlVdXM0UWdvUnVXb0wxcTVvcE16Ylc4NGlqQWFES1RWMWNCUFV4R0dN?=
 =?utf-8?B?T1hmWVNOd1dGem9HYm1NMzk5M3kyK0Q4ZjZkSFZZUTd4djRQTDJxdytuMXF4?=
 =?utf-8?B?akpHL05Ba2NSSUxZYXZwWFp2elNhWDJqcVZJMmM5ellVMjNpb2pUNkJlZGJ0?=
 =?utf-8?B?SkhQaUFFZHhMVWdsS0ZSb1J5ZEJjSXJ6ems4R0J0RDFoM1d5V04zemhVc1VZ?=
 =?utf-8?B?eTN1WmpWb21RM3U5VkVuYy8xMW8rY3o4NlBCamdXbkpWNkgxWjk3a0RVV3Ft?=
 =?utf-8?B?eG1qdXNaaS94MG9lYWZkZVZmS2NtSjN3YXBHOEI4TjZ0ald6SWJIaUFiRmRa?=
 =?utf-8?B?UWNVVURycGtSSDJXSzNnUldabTNmMW9yU3FLa2JpdzVIcU96YnZYWnhpN095?=
 =?utf-8?B?VUZSU3FGaVZiU3VvY0toWUdweXRidWtQZ2RtMmVGam5mWDJGeW0vajRsakJH?=
 =?utf-8?B?WjNMa1pNTEt6QzkrUXQ1UThUQi9ob1pEUExCVHNNdFZUODVDTFFIMHJIcjNF?=
 =?utf-8?B?clB4NFhlTlVJS25oQmVBV21xMzdhWTk5QmwycW81alJUWTRsZFI0ZG12VnFm?=
 =?utf-8?B?bTFPSEdIc1FkOHp0d2VqUDR2dnhzVnMyYnVWb1hKOHUwcWtlRjMzNG9qYXdR?=
 =?utf-8?B?UWFJSFRlTmhhSnZGc2w1VlVBQU5sUysxbnhUeDhvV2h2ZkFWVnFlMENtenNW?=
 =?utf-8?B?L0ZZYUJldzRob3dzbmpCajRWU2JVT3luT2d1bk8xRFYyYlZTTkYvOElENStr?=
 =?utf-8?B?dXp6ckpxS3ZyQk45RVgyRXFXdWkrSWxZdVFmdDdVQ0tnd2xXSTByWWxuSC8w?=
 =?utf-8?B?YnVZNnZIaVZwMTcwOHdwcDlRUmJ4WVl6bjRKNm1xVnJCbitWSDFUSEYyK3ZX?=
 =?utf-8?B?ZWR1UVhJci9uZVN2bVBodURQOS85aDZFZmE5aExkYzFESFFYdFlaMFFrcG1P?=
 =?utf-8?B?dE5VT2IrNklxN1hadG02SDBJRW1vZGlxSzRGUXF1MHVIeHhPaGJDaTFWaWpi?=
 =?utf-8?B?SHFOWDJQaWEvNitZVXgvYXpTMSs3WHJxcTRJU3hWUlgwOWorQW1wOUE5eXZ1?=
 =?utf-8?B?cytESmIraElhLzd3UjlCS3lpN0JXOEVyQzl6ai9UcWhmYjZyeEhVbXB2bCsy?=
 =?utf-8?B?MTR2N3N1SElWT3ZuWmVDN0p1cFYzd1hqQmhoeUFKU05Hd0xrbnJ2a3F6WmJC?=
 =?utf-8?B?WW5nWWY3SldiQU1YYUxaWitrdkp4TVovRVpPK2lDQ3Qrc0lYMWFKeGJBN2lk?=
 =?utf-8?B?R2dvcHFUR0I1WmFOemRYMmxLNW5CVHIveEUrbGU0dXNBem9Xc2FsU0tHZWpE?=
 =?utf-8?B?K2FZN2FkWlFjQUs1T0VqMngwSEZoN1J4aDVJUXBuNDNLankvU1RNWEFaQXVy?=
 =?utf-8?B?bnNJMmVTVTlJKzJXNFEyaWh0WUV0ZHlLZ2VBbFpOWGh4TllIT3NlMWl5aEc1?=
 =?utf-8?B?R0c4UCt2dndocGtTZFZZVS9NZ1plWXJtWnEvMkcxNFR4aGdxdzdSM2pRVVU3?=
 =?utf-8?B?THgxMVQ1ajFQM1Fqb3BYTEtTckRvRC9xM2VGdXlOc3BGTWhkTDd5NkZ6S1ox?=
 =?utf-8?B?WVJJaUp2NVZSQUhualJwZXVxRlVJd0ZCRExQazJFY3d6UVpWTExPMUhIdVlq?=
 =?utf-8?B?MjFrb1lLVHpkVWFlMVZVNFpLTVkyaE1QbVo5Y0dhelVkaFFjSWhOR1RYSStY?=
 =?utf-8?B?MEFWWEtqc3pER0haS3ljZy9sOXpWWFBjdjlvU2EwQW5MMFB5NFE0QllQZ3ZV?=
 =?utf-8?B?d1hzMndwckE2TTkwK2xZNjNsVWlhWlNDb09PUFdKYmhwT0dILzJrR1JoKzhH?=
 =?utf-8?B?QWR2UUFNOHo5NmZtZ2JQMWlZUVl4b3VzME04dkVTemxVRmF1TktoMzVXSkZj?=
 =?utf-8?B?OWw2dkExY3FGbDhkVGlVbGlxMEVwNk1aSG4rRG55VFVuRkJoNmZiSWFhQkNa?=
 =?utf-8?Q?UBt5b4lDe3QyIXlTET5G7vs5eF0NvCCCzbCJl?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664252d1-94d7-4f85-a1eb-08de66095690
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3904.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 05:25:42.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1cSmKo00LQvW8zz2i24tuBMC8mbSfqQHNLJZ8OqdClNpqmH8KRPbDKta+Auc8wL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4076
X-Proofpoint-GUID: 41r28RuF_aGW8fbdjMvXsIcddyQvMD7M
X-Proofpoint-ORIG-GUID: 41r28RuF_aGW8fbdjMvXsIcddyQvMD7M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDAzOSBTYWx0ZWRfXzaUo1toa21NL
 4NNhkfxa6JudA5X6J9Q3XYAwxGa1nJOvvHL0WrZ2EHg8c8fIhg9yjEMMBVelkx2BB/I6/fjLX5P
 yLtt3ffClpvIQKZkJyFGoMJMam1/hyrZT7ATxj5zXUj4fwtmsyZP+wZ13e3Ae9IMXnNeCzYvyOn
 84Xxa9ib7vls0gEPfKa/bUrn2DEY6sgSdUJYHQveYK0b0nRS7rB3FyZpLm3uSss2nG7vcSs+C6u
 nsbnTSFWTAhHTIQQgLxWFlLYarMCfRuPUyfCmJ2hKbrjX8+8BgJy6vDrg1NA73WMElBtrC2dbMJ
 pKhVPkvld0ceM13j3yK4KhxjCoh8b01XFVOEwv72Z4dnp4X7jh7P3rgZsfaNKygDvXGTrAMjdHb
 MLQ/CE1xlPJgGCkdYIzpNkbTVS1dLoZEIfdnO/u54UGjRN3yVIu53pl6lj5VocfMMobl/MVNtk+
 XBYNS+QIiazWcwBQORw==
X-Authority-Analysis: v=2.4 cv=feigCkQF c=1 sm=1 tr=0 ts=6986ccda cx=c_pps
 a=aSTqfDprWv2neSIyXEkWYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=TevTGxxnZQ7duhaOEKgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257743-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D43D2105042
X-Rspamd-Action: no action



On 2/6/26 8:41 PM, Jakub Kicinski wrote:
> On Thu, 5 Feb 2026 16:27:15 -0800 Vishwanath Seshagiri wrote:
>> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len + room, gfp);
>> +	if (unlikely(!page))
>>   		return -ENOMEM;
>>   
>> +	buf = page_address(page) + offset;
> 
> Please take a look at page_pool_alloc_va()
> 
> I mean all the way down until you reach page_pool_alloc_netmem()
> and realize the helper you're adding in patch 1 is a solved problem

I apologize for adding patch 1. I will use page_pool_alloc_va and send
v6 with only patch 2.

