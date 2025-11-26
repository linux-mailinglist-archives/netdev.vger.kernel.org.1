Return-Path: <netdev+bounces-241945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2EDC8AF08
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C3A035A0B9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B533E34E;
	Wed, 26 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="T14ZmSvm";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xTto+sX0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5D225779;
	Wed, 26 Nov 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174111; cv=fail; b=tmALNiubom4HM+vihkSrXsdGUB/tgk4a67Ky5EENCCye0D3bKnqy4cx22t2ENLX7g+icngipRGVW+/3wVbe5joo5AD6f0RUarfRXbp/ntWNptUFuErh0q3DmkRribkYgsLjylhNTo30LMYt23WMBLIJ/p9k/Igff6SRB3RxYdp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174111; c=relaxed/simple;
	bh=pYJSbkjj/6bqNDSWO8LJ/Wo6RuNDFqSXkQ7JYjMJ5Is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=piXNz9xUGdOfZMIYcQGHrsMR082//CITQm6myQJOmK6ETQqazAJZjaRZQpsVsiy/11wGlZ5S70qghK2HlHbCTrOKmmJpYgvRgyOOHdKMXwFovenAS7V2hYEQx+RsNkYmhIgDZhp1e0tET+JT036MHvtS2EVH69hBMjPW7P/FP3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=T14ZmSvm; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=xTto+sX0; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQEWDeT1874994;
	Wed, 26 Nov 2025 08:21:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=pYJSbkjj/6bqNDSWO8LJ/Wo6RuNDFqSXkQ7JYjMJ5
	Is=; b=T14ZmSvmBrw/I/9k9tR+g9ZEEqPbP9d1fM/1x6baz4C5iPzc11k3yp0gl
	AEVOduE1/ChPoNEyCXFEA/BRtH1lGukvS2ST+O7w/x4BAafBMoa3ac3xjbK8uvnn
	WikzxubvwzeE1b2zKGm+dyQrV8hvSjr7v0+FTYQRxf9qOEAwXv0iUEdcUDAPXNDu
	nHPD9hFxvDTwAlvE+Xk/STiGBLc0QtURhma1FOxnOC4pEXQPD3fW3Bl9VLl1A4D+
	Ifx1xyE3TTQ5ASfzRg91//T3tmQW+Nli3vGu/J7Hq7QXCj/vfJGrEaowLBd+9dkf
	po/O7LtTKdd/TeAhoag0YC1FxpwQg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021110.outbound.protection.outlook.com [40.93.194.110])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap3d907rn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 08:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb6OuD7XRf1LrCAV8yD1bJQC+Irp/orww8dKqcgiSo4oUhrXnNaLAFjDfch6CYrci20Ub9PXvlorqacBDQjP88ZTuguJMyu758Ue3VK9was50LRIZdqStTsxbf6jhFQwDfe64bsimWe40c1/v/8g/zyUhnG9wHs8Pr6i29qE2g410V8Q6YwroDpMw5aDcQ/TlRiSVyaL6+/KUOQz/bq5HhEtwayqTrd2EYlBKHoFAb37i5AxhR2m0CnjPZerpID3ReqnB47fdCcVT/aQIwBFJx88/ZL58WpNvl9tuS6hbPdY9a1OyW6SLWgl5XdRRurMx69tZ1rwf0+BzhhLiu+RhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYJSbkjj/6bqNDSWO8LJ/Wo6RuNDFqSXkQ7JYjMJ5Is=;
 b=mm+xhq+hATrsqS4ZAw7vg9YZt5OWjWjZDxH/PCN9DaCs5CpqNAKOVYa3eZAu6DdiUdWi3GTBppBnycN/l7V4pagiGczG4TMmTc+/Cz6HXehNFCMz3pL6Mnu4LHHEMo2YpWm8WhrOBN5oSjPjrxN7ZS8iY9lgE7C/dG2SL6GsvfmcZwV9davrvIqJAxurBuWVC11E3mQbYI3eZ85kikh99O7gOo1Eo/bcEVmacHW5NmLGuu/unUJ/0zelp3QmcJfALhOQsJet3WIhsLNhEG1usQGeTzsQZCfZWY9rImJTgvpQTj4EdtMCDZ4cAGf8O9+IoCdECI6UeiRt9gV2dlP+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYJSbkjj/6bqNDSWO8LJ/Wo6RuNDFqSXkQ7JYjMJ5Is=;
 b=xTto+sX08w9YoVgtWn6u4+obQaKG3kx2ZDe1CBviac+sutzm+tHsJeW9/lzm7C8pQFQPa4Ur+38naaer+GvTlzCkcr3XUrNn8di0GkjsAkRcdpfm8xOixwKsAo+0Chaio4QpGz1eAO5D9ElebZgXFOUvKJXPkKZlouBlpsPV6hcFiRPsAgntRAcVvBiKpsguu7VDpg2OXCQF2mqKr/pV3ovOj1sT8+Ghk8wNu3ddkzcSjOmCBVujHtnwbFznfM/9Qlam0cczp+N116HpfLtPv6I7tc8eMOsKUPxVOX37B5ydud77YajJ9kvlSzE4SeEi7eu5OMNtbuoBbfwPBT+GhA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BY1PR02MB10338.namprd02.prod.outlook.com
 (2603:10b6:a03:5a9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 16:21:33 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 16:21:33 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Cong Wang
	<xiyou.wangcong@gmail.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Wang <jasowang@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] flow_dissector: save computed hash in
 __skb_get_hash_symmetric_net()
Thread-Topic: [PATCH net-next] flow_dissector: save computed hash in
 __skb_get_hash_symmetric_net()
Thread-Index: AQHcXjIiRA+HhBm9skOMcjqSLJ9e2LUElNMAgACQMoA=
Date: Wed, 26 Nov 2025 16:21:33 +0000
Message-ID: <8EA496BE-669B-44C1-A3D7-AF7BD7E866ED@nutanix.com>
References: <20251125181930.1192165-1-jon@nutanix.com>
 <aSawDrVIMM4eHlAw@shredder>
In-Reply-To: <aSawDrVIMM4eHlAw@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|BY1PR02MB10338:EE_
x-ms-office365-filtering-correlation-id: 608ed5b1-57e0-4e98-d225-08de2d07dd76
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1FBamtjb2xnTzkydUpSU0FYYXR3MnZFbFZKTThYYVlPRFQzL1RZNXZ2QlE2?=
 =?utf-8?B?MG5vYUZYRWxqbCtEQklVZXB2VzZER0dQSFhEdnJseFNwUUx4d3Q2dzB3WGto?=
 =?utf-8?B?TWUwSTBZUkR6ZWlqNmplajgvRnNIbG9ubWhHMjZnOGtJaUFGVGtTUE1wd2RE?=
 =?utf-8?B?MHI3LzZhSlhvU0IrRGRvQ0VaQ1lMbGY2WURKT09RUkFZd1UyYkhMakx2NVU2?=
 =?utf-8?B?SHdPV2g0S3FEUGhWazM0V1Z6ektYcmU4a1hFamhlSzNBZzRQdDJIelYxNVJZ?=
 =?utf-8?B?YVpISWVtY3lucW5VY0x6cEYxNXkwQUpxbEI2OFl6UURHTTNkU1gwTEg2Zjhn?=
 =?utf-8?B?aURRV1FYWkFpRXo1QS9hVDEvR0tBMjkzc1ovT2pydVBxeEc5V3hZaFBwYkdM?=
 =?utf-8?B?VXV0aS80aW12eTRROFFGUlRCM2x6alc5OWtPdDlOWUhiYmM2elhzZytkNTRw?=
 =?utf-8?B?dVpCL2NVTzFHd2MvMTNnQ3ZoZ2ljcmRqc0tLZnJjS0ZYeWRHK1BqVlAyTFA4?=
 =?utf-8?B?NldtVXdOTVRDVCsxMngyemFHOU5FNU5IYWNyUVp3bzl1Wm5odEhmMnhUeUNZ?=
 =?utf-8?B?ZDJmWEl1WGc0MHh2SmZ4M012THRxYlRuUEZqb0I5VDlYLzlKTXplYTRpVVBw?=
 =?utf-8?B?U01WaDFNWmkzaHR5alArNERYT2tHOWVZVVZ4dy94Uy8wVVZmRmpSdUxWaVdw?=
 =?utf-8?B?WE9pcHlvU1NVVEMyajhReXZxdS9FTDRBeFpVUmVibnRtTUdHN0hndFViMnlS?=
 =?utf-8?B?djMwY01pSEhUQjZzS0FqS2tLOHo1VVA1QTIxODRGakIrOFpJUWJDeDJHT0Nl?=
 =?utf-8?B?a0toSzhwZ2RHbnQ3ZTV3ZktSUXpLb1c0aHRHaWdJM1VjT3cySU5ObCtnN0V2?=
 =?utf-8?B?cVdyczVZYzF6Mk5jY3dyc1BteEFtTjRJRXQzdVNZL2ZZaFdnMTMyOGhJMTR5?=
 =?utf-8?B?Z3Z0a0tiUTNDb21sVEMyMkpuSW1TdEIxd2NrL0oxTGx5bUVoSFBiWFBBbDlq?=
 =?utf-8?B?L0t4OFkvWGZ1TFFISE9EcEd4YjV4cmY2U0QvSFJhWlovbmtnLytDb3c4NWZ6?=
 =?utf-8?B?VFlhQThNdFJZRjYxYjZwRnV0elY1NVNwZ25qT24zb0VKL0tPc2NMTU5qbUUy?=
 =?utf-8?B?RytPSHBLZkFPN3h2aUdZSnVLZEpHa3RhZm85OGdGVENFS1EvWmNhRTg2OVJU?=
 =?utf-8?B?VFg5VExaazNpUk4rOUtwTDRZRmNoenNoVjBjSUc2eW1ISzRLblNBS2RmREll?=
 =?utf-8?B?Q0hWL3FPMys1S2p6SW52WFlFR0V5YjQ4WC94Wkt2d1pNTXFDUCtPSGtkS3ZZ?=
 =?utf-8?B?R0xPOEVwTHVRRVk1TXh1dTRickg4REVyQUpoNnRzM0RwRlBib1Fjdy9ZV2M2?=
 =?utf-8?B?cTBNNVBkaDlUdXAwT3NwMGlORkU5ajRVZG5oRmZhMXc3Q2NjNzV4V0lHT2pj?=
 =?utf-8?B?eEhoM3JOYTFhYmFRa3FKVFFldDBwMk41OFpvOXJDWFQyeG5pTUtObGp4TnUx?=
 =?utf-8?B?QUhBYU1QaEtaaWlxRGxiT2ZmamYvSXMvUWZYZ0xBNWFpMVFHSnNpS1lyRXlK?=
 =?utf-8?B?Nys1OFdxUnVIWXZ5WXhCWG1jdENqN0FWVlFUMG41d0p6VHplZURVcGEvWkt6?=
 =?utf-8?B?SXNTNFZXZjhyUDJaNVk5VjRIRXRBM0JoeGVPVTRNd1AySmN1eGVsdnF3Q1p3?=
 =?utf-8?B?MVlaV2NUK2dnVzBJOFp2Rk8vbDhMWWdSQ2szUGxXR2tBUE5VTncweTFieGdB?=
 =?utf-8?B?ZjBvSUEzZHBJN3FQRjhuRFBSZng4NFRPUTBRL2hWV0lPSHA2N0dCZVdDTDZQ?=
 =?utf-8?B?NVJWS0l4M1orbnRyQVhhRk5uTHhuMUFsRFdlM2VkTkFnMXN2V0lrRWptaUFQ?=
 =?utf-8?B?eDYxOWdMeVFJMnV4Qm04azY0RWNWdXdUOEhVUUNVcUdiMTBxKzIzQ20xWU5B?=
 =?utf-8?B?KysrWWxuTFJockV4bkNzQzBRUldPZFE5SDlSU053WmRRZ2RWaytOVWNxcmtt?=
 =?utf-8?B?QlhUWjBLcVJyUWpCQnNOc0kyUVdCajN5bXFNOVYxc3gwVWNPczlFRnFSU0tH?=
 =?utf-8?Q?klAp/f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0puTnd1akpjZkdVcno5VjBjclI0NlhzelV0ek9leHlFenBKS05yKzU3TW9z?=
 =?utf-8?B?NnJhVklmaU5GV3dwRlRtdUtXSEp6dlZyTUlsa3JCZ1lScVV5a1FwS3RQcU5v?=
 =?utf-8?B?M2Q5SjhPSHEzaWg4WW84TkRmWE1MZ0V4MHFOMTFoeGpiZ05POGxBTmxjRVJo?=
 =?utf-8?B?aW1FZEFBS2FQRkZDclJVLzhGZFNJV2RuY2dkKzhoaDFYTUY3SkY4L3MyWWpj?=
 =?utf-8?B?YTk0OTQ1ZXlZN05yRmJ2MTAwY2Z1QUdKWEFmSm5QaWNVR2dQcDFuQ3RveDJo?=
 =?utf-8?B?WHQ2OVdnTzBPWDJHNkRhWnY1RlJCcUF5aEk3ZU5kOHVoSHFpd0xIOFNkdy84?=
 =?utf-8?B?RHFQb2JaMUdnR3dCNmw3VW40bzdOMEVYRTltS3lNVG55SFhVZFRNL1JJRUFJ?=
 =?utf-8?B?bmxVU3p3OGZBQkF5ckdyK3c0RnpndVN0M0Z0Q2RGWkZTcG53Sng1WXZiRVRG?=
 =?utf-8?B?ZXl2YzQzNm5FVHk1Z2N4WWx2Uk80ampPZlB1bGJLcWpHUnc2NUd0YU5HUlNp?=
 =?utf-8?B?d292MGdmWm9tSHZFNjZJbEtvODJxYUFja09lWVhaQWpyZzNoSXZoS0pZRW8y?=
 =?utf-8?B?OEgzQzJkQnhESVhmVHlrUzJ5VWp4NDFVYXpmSklaZzdYcWxNSHc3M05pWXpW?=
 =?utf-8?B?Zk9iNExpa1lBMWw3RWVHZ1FrUHhDc0s4YmhMUGx0WmZnY3JWcVk4OHB6QjdJ?=
 =?utf-8?B?NXRNcFIzQkI5eWtWaDhsdFFyeWl5c0U5TTNVaWJxK25PSy9vM3M4YlNkWHFw?=
 =?utf-8?B?eFZtNWpiOEw2TWVEY3Zyb3lhRTdmMkUrSDU1MCtjcmZhVG1WQTR1MnhCdXdJ?=
 =?utf-8?B?VG5yNWtxTGtNZERkdTRJUUdYeDJ2b1I2anRmMUhtKzdLMW52MjZrakpDRkxS?=
 =?utf-8?B?c25TeitJSUNMSy9iNDIyOHkrdUx2TVc5RFdyS3UrQUc0dStvL24zVlVRMDZE?=
 =?utf-8?B?Y0lIQ0lFWDdzTFh2UE5mR0k1UzVRTXAvVWNxWVBsZkNyWURtWEN2ejgvTVV3?=
 =?utf-8?B?bk8zWlQwQTUvaSt4aVViZU1sTDhEYkkzZCtZNWZmVzhrRlZqd3ZDd2xnWmVa?=
 =?utf-8?B?Qm54VjZKbnhXdmtwWFZsUlAyQk5DQ1JYVEVOTzY0Zm5vSC9PUUtUaXZYTHhn?=
 =?utf-8?B?Mm1VQ08zM3VOSUZHYXRYaTY0NE1VcEJiMFpiUEFrWWZNbkpmOHcrYVcreDdM?=
 =?utf-8?B?Y2VqR3lZUkZ2cjlrWnRpaW85RGNqUnNiQU52RjU0TGt1aGZ2TUFlYlVuaXZO?=
 =?utf-8?B?VmIxcGdCTGZqQzBnREVheCtvRFBWb1ZkQWxGTEFmaGpoN1VJN09PSndrcVhL?=
 =?utf-8?B?Y3pIMzFpb05DVHhzTGNSMnJVTWtYM1pKVmxuc05DRHNic092VE9SeDV6dk42?=
 =?utf-8?B?ZUdJbExaNnorQm9wSytXajhzSUxMQ2RYMUpyOFRmdWI2QmI1c0lmTGgwNVp1?=
 =?utf-8?B?QmNSaVVNeXkyZXBtWk5hWktvYk4wNnBCd1hEcHRNQ2JUVWxiNkpLQTN4elRt?=
 =?utf-8?B?T1hEdUMyZmxlU1ZLTDBqLzFJdnBDRjMyWHgvbVArTktWQW5PVk1rN2dtaDVq?=
 =?utf-8?B?NkpRdUtZcWdHT0hxUjRhUjJ4bW1NWGZVaHdGcEg4eUZsVGJ1V3oxWE5FeHVn?=
 =?utf-8?B?THl4akJqQi9qbjluZ2dCaXh6QkRIOVZnemxLWHNZTTdRemNUcmVVTjVwVWxN?=
 =?utf-8?B?OStKcVVLVFpJY2Q4NFFTQmJ0MEFuV3FDdDNYeWtVNno3V1VoK0tDYWM0ZzBp?=
 =?utf-8?B?czFSK2c5UlU4VTZzMkxGUG9DdGxFTW5RQzI0ZUh1VThLdWVQajlUOXRvdDkz?=
 =?utf-8?B?cWVTdzg1dWpnbnhGMGVKblhHaG5aSW8wcEMyWTNhdUNiZGRZWk9WRDFRZktZ?=
 =?utf-8?B?VmduNXFoc0hnQThCZi9YTlBXZ3FVNSt0aXBqZEFBY0RoeDd3aFJJYXZiVVlG?=
 =?utf-8?B?WFNKd3gvNnBTV01NcTAxZTRTRmZycDNSUGFpZ3UyaGQzLzJCSlk1eDRwU25R?=
 =?utf-8?B?ZmVxeFJaS2REVG1nNnpxUFdYNmpGbCtnSUJQWUZhMWN5Y2JzN000dzhLL21L?=
 =?utf-8?B?N3VJdGpsQ3d2TUxsYUlTeGFTWS81QkNEWWY2YnovVHJYTmpoazNOVjF0Z0cw?=
 =?utf-8?B?NCtvSmV5RFFkN21ESkhIZUovK0l5TjIxQnZiZnRPb25hZ1JOb0dNSHljUCtR?=
 =?utf-8?B?d3RRS3N5OXAwMGIwakg4cU9Dci9vWFN2SW1uT1NEU1BuQU9ldlBjR20wYkI4?=
 =?utf-8?B?b1VFVTVkMzcrcmJWWWpycFFlc3JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A81599DAB6C5540A6A4C0AFF67E8CCB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608ed5b1-57e0-4e98-d225-08de2d07dd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 16:21:33.6543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjZRdUlhbe3JLyObPR8dNxVlIP2rMj6+kwO6qWo6NM7oe+LH11YhUkkEFZhutmmPWkl7oFe9KnBRRtP/uZyyeQZYIl2bSOkspsfW5BkcxWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10338
X-Authority-Analysis: v=2.4 cv=V45wEOni c=1 sm=1 tr=0 ts=69272911 cx=c_pps
 a=is1TPszdXRKtgCc8Qn4wPQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=64Cc0HZtAAAA:8 a=91kcuIyFBSRkkriKMrwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEzMyBTYWx0ZWRfX6v+sVaM3Z+sI
 32YXEZpcr+KMhrDUMb4lP0T4s6qPBSV4OFLAoEmCr2JaRKT0muV8ppr8fssTJg2ggM0rOImnkgS
 WkReQ2h5NQKhUrgS3PxyXy8sor07YnMWx+faozPJipdRlWfiOlKGLJLZleVeF2N+K3jqMgjQzyP
 Q5l687sxS466EfSNVn0enkesFFMujAy0+4oRmlSrLwndvawIpkZl+WwCz+T4aklF4UcKJpbhpB9
 EejhnTja1TWJ3vJ3FSlzuYdMXi3MVMyCpyZ6bKsJ6apUWavOd3/4TZFgojqX9Uv/onYnjcoaqTd
 Lg6Uky4BxF188EFRcKPKvtQA/p5dQlg5b77y4lFrcZou1/67wrirR1960TjV8zB42nbCxtKmWZ+
 zIuCHnsd+R9AAQMXwvAG1aCP2REKcw==
X-Proofpoint-GUID: fYhUMkl-WI7__SZt4Z_4zCYgE3OPoQHp
X-Proofpoint-ORIG-GUID: fYhUMkl-WI7__SZt4Z_4zCYgE3OPoQHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI2LCAyMDI1LCBhdCAyOjQ14oCvQU0sIElkbyBTY2hpbW1lbCA8aWRvc2No
QG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBOb3YgMjUsIDIwMjUgYXQgMTE6MTk6
MjdBTSAtMDcwMCwgSm9uIEtvaGxlciB3cm90ZToNCj4+IHR1bi5jIGNoYW5nZWQgZnJvbSBza2Jf
Z2V0X2hhc2goKSB0byBfX3NrYl9nZXRfaGFzaF9zeW1tZXRyaWMoKSBvbg0KPj4gY29tbWl0IGZl
ZWMwODRhN2NmNCAoInR1bjogdXNlIHN5bW1ldHJpYyBoYXNoIiksIHdoaWNoIGV4cG9zZXMgYW4N
Cj4+IG92ZXJoZWFkIGZvciBPVlMgZGF0YXBhdGgsIHdoZXJlIG92c19kcF9wcm9jZXNzX3BhY2tl
dCgpIGhhcyB0bw0KPj4gY2FsY3VsYXRlIHRoZSBoYXNoIGFnYWluIGJlY2F1c2UgX19za2JfZ2V0
X2hhc2hfc3ltbWV0cmljKCkgZG9lcyBub3QNCj4+IHJldGFpbiB0aGUgaGFzaCB0aGF0IGl0IGNh
bGN1bGF0ZXMuDQo+IA0KPiBUaGlzIHNlZW1zIHRvIGJlIGludGVudGlvbmFsIGFjY29yZGluZyB0
byBjb21taXQgZWI3MGRiODc1NjcxICgicGFja2V0Og0KPiBVc2Ugc3ltbWV0cmljIGhhc2ggZm9y
IFBBQ0tFVF9GQU5PVVRfSEFTSC4iKTogIlRoaXMgaGFzaCBkb2VzIG5vdCBnZXQNCj4gaW5zdGFs
bGVkIGludG8gYW5kIG92ZXJyaWRlIHRoZSBub3JtYWwgc2tiIGhhc2gsIHNvIHRoaXMgY2hhbmdl
IGhhcyBubw0KPiBlZmZlY3Qgd2hhdHNvZXZlciBvbiB0aGUgcmVzdCBvZiB0aGUgc3RhY2suIg0K
DQpBaCEgR29vZCBleWUNCg0KV2hhdCBhYm91dCBhIHZhcmlhbnQgb2YgdGhpcyBwYXRjaCB0aGF0
IGhhZCBhbiBhcmcgbGlrZToNCl9fc2tiX2dldF9oYXNoX3N5bW1ldHJpYyhzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLCBib29sIHNhdmVfaGFzaCkNCg0KVGhlbiB3ZSBqdXN0IG1ha2UgY2FsbHMgKGxpa2Ug
dHVuKSBvcHQgaW4/DQoNCj4gDQo+PiANCj4+IFNhdmUgdGhlIGNvbXB1dGVkIGhhc2ggaW4gX19z
a2JfZ2V0X2hhc2hfc3ltbWV0cmljX25ldCgpIHNvIHRoYXQgdGhlDQo+PiBjYWxjdWF0aW9uIHdv
cmsgZG9lcyBub3QgZ28gdG8gd2FzdGUuDQo+PiANCj4+IEZpeGVzOiBmZWVjMDg0YTdjZjQgKCJ0
dW46IHVzZSBzeW1tZXRyaWMgaGFzaCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxq
b25AbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+IGluY2x1ZGUvbGludXgvc2tidWZmLmggICAgfCA0
ICsrLS0NCj4+IG5ldC9jb3JlL2Zsb3dfZGlzc2VjdG9yLmMgfCA3ICsrKysrLS0NCj4+IDIgZmls
ZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9za2J1ZmYuaCBiL2luY2x1ZGUvbGludXgvc2tidWZmLmgN
Cj4+IGluZGV4IGZmOTAyODFkZGY5MC4uZjU4YWZhNDlhNTBlIDEwMDY0NA0KPj4gLS0tIGEvaW5j
bHVkZS9saW51eC9za2J1ZmYuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0KPj4g
QEAgLTE1NjgsOSArMTU2OCw5IEBAIF9fc2tiX3NldF9zd19oYXNoKHN0cnVjdCBza19idWZmICpz
a2IsIF9fdTMyIGhhc2gsIGJvb2wgaXNfbDQpDQo+PiBfX3NrYl9zZXRfaGFzaChza2IsIGhhc2gs
IHRydWUsIGlzX2w0KTsNCj4+IH0NCj4+IA0KPj4gLXUzMiBfX3NrYl9nZXRfaGFzaF9zeW1tZXRy
aWNfbmV0KGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwgY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYik7
DQo+PiArdTMyIF9fc2tiX2dldF9oYXNoX3N5bW1ldHJpY19uZXQoY29uc3Qgc3RydWN0IG5ldCAq
bmV0LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsNCj4+IA0KPj4gLXN0YXRpYyBpbmxpbmUgdTMyIF9f
c2tiX2dldF9oYXNoX3N5bW1ldHJpYyhjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPj4gK3N0
YXRpYyBpbmxpbmUgdTMyIF9fc2tiX2dldF9oYXNoX3N5bW1ldHJpYyhzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKQ0KPj4gew0KPj4gcmV0dXJuIF9fc2tiX2dldF9oYXNoX3N5bW1ldHJpY19uZXQoTlVMTCwg
c2tiKTsNCj4+IH0NCj4+IGRpZmYgLS1naXQgYS9uZXQvY29yZS9mbG93X2Rpc3NlY3Rvci5jIGIv
bmV0L2NvcmUvZmxvd19kaXNzZWN0b3IuYw0KPj4gaW5kZXggMWI2MWJiMjViYTBlLi40YTc0ZGNj
NDc5OWMgMTAwNjQ0DQo+PiAtLS0gYS9uZXQvY29yZS9mbG93X2Rpc3NlY3Rvci5jDQo+PiArKysg
Yi9uZXQvY29yZS9mbG93X2Rpc3NlY3Rvci5jDQo+PiBAQCAtMTg2NCw5ICsxODY0LDEwIEBAIEVY
UE9SVF9TWU1CT0wobWFrZV9mbG93X2tleXNfZGlnZXN0KTsNCj4+IA0KPj4gc3RhdGljIHN0cnVj
dCBmbG93X2Rpc3NlY3RvciBmbG93X2tleXNfZGlzc2VjdG9yX3N5bW1ldHJpYyBfX3JlYWRfbW9z
dGx5Ow0KPj4gDQo+PiAtdTMyIF9fc2tiX2dldF9oYXNoX3N5bW1ldHJpY19uZXQoY29uc3Qgc3Ry
dWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPj4gK3UzMiBfX3NrYl9n
ZXRfaGFzaF9zeW1tZXRyaWNfbmV0KGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IHNrX2J1
ZmYgKnNrYikNCj4+IHsNCj4+IHN0cnVjdCBmbG93X2tleXMga2V5czsNCj4+ICsgdTMyIGZsb3df
aGFzaDsNCj4+IA0KPj4gX19mbG93X2hhc2hfc2VjcmV0X2luaXQoKTsNCj4+IA0KPj4gQEAgLTE4
NzQsNyArMTg3NSw5IEBAIHUzMiBfX3NrYl9nZXRfaGFzaF9zeW1tZXRyaWNfbmV0KGNvbnN0IHN0
cnVjdCBuZXQgKm5ldCwgY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrDQo+PiBfX3NrYl9mbG93X2Rp
c3NlY3QobmV0LCBza2IsICZmbG93X2tleXNfZGlzc2VjdG9yX3N5bW1ldHJpYywNCj4+ICAgJmtl
eXMsIE5VTEwsIDAsIDAsIDAsIDApOw0KPj4gDQo+PiAtIHJldHVybiBfX2Zsb3dfaGFzaF9mcm9t
X2tleXMoJmtleXMsICZoYXNocm5kKTsNCj4+ICsgZmxvd19oYXNoID0gX19mbG93X2hhc2hfZnJv
bV9rZXlzKCZrZXlzLCAmaGFzaHJuZCk7DQo+PiArIF9fc2tiX3NldF9zd19oYXNoKHNrYiwgZmxv
d19oYXNoLCBmbG93X2tleXNfaGF2ZV9sNCgma2V5cykpOw0KPj4gKyByZXR1cm4gZmxvd19oYXNo
Ow0KPj4gfQ0KPj4gRVhQT1JUX1NZTUJPTF9HUEwoX19za2JfZ2V0X2hhc2hfc3ltbWV0cmljX25l
dCk7DQo+PiANCj4+IC0tIA0KPj4gMi40My4wDQo+PiANCg0K

