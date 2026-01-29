Return-Path: <netdev+bounces-254870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAvUFZiXe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8470EB2CBD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79822300E704
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E759A2C15BA;
	Thu, 29 Jan 2026 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="B0pyn9BN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA51B4138;
	Thu, 29 Jan 2026 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707286; cv=fail; b=chfq8IuoshOti+S0h+nxmkhUIJo++SHnn0hTLV+jd6JAGDSTDEUQjpe9sZ7FCarRu8RIpWZrKwtBIg3IajF13RlP45r1EbVWqiTEskon1G8E9O+j3+Rx1qHU0CIl1VmudXHuPP2ti4Kt2dFvl+1NK7wSvmuP+PSERyFFSpmrK1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707286; c=relaxed/simple;
	bh=YGaJIO6CrAEst3vDRxRz4CZK4bEW3F50t/YbhOvsr04=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMDZXJI6iKwmONObQsMK5oKyk3pDsFmAAdC75hPbBzN48DwbVoSTro2xlnI0ook1GUbN141/SK7Cv1wWkrBYc1BXj+Gorn+WZSF406KO+SQOSCfmuCJy5zWWZSyEGGYp3XiLtO/Bpt85TskQ+Bx6oAde7SdRbsuzbYagIBzPReo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=B0pyn9BN; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TFrpFo153981;
	Thu, 29 Jan 2026 09:21:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PgZAkBxbMmRSI60rg3Ev8/u0OJ1hW4XC+P5QylU0UKw=; b=B0pyn9BNEykC
	f1HEZjo//8JlMeCGrFctO97Nm8cJ72eLkPzykI4ddJO5R8snz/JAYN95w2pHhYgf
	et/JKG/LkQ55IL6wv/Njknb8NhWxYPAhz1uscj2qzCGVkKyzKEnlnTKF6AOvuuCd
	RvQoA7JOseV9ms2biABe2/ymrk/zdb0jVpzAj/eTUEb8rjcOzGJ/A7qx23GjdTk5
	nzzqE14zrU5ImacfcVeALb02mB+46CXh0ACEzHDmbcLI/kyLN8Vre1+VHu8UsucP
	K/kD76HSaEbRAUuE+jLlyapLsk7MB99PGL2dciDRWvVqlEPtzQOYmnxwoRVWSnFx
	92+lwmJkDQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c02kxd25r-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 09:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnZY+4BK96e3PGqVZJxAtJ6mq06GToF6wXQQOriGmyldYmweX9Vfb2SfB4+lNO/h6d36Dwyv3cMx/k9fshO8DSN6G7Psu0AfFiVS/ry+cXdYyopwp1MJE29FtZjgaRD3ii1GsrF1zpplyzkOMgfOORaLdegFskrwHbPZKejzPS1UVz+PoIHaEwja9mC8Jseh9bJNerJ1veau3tIQ18y80QGU4HMdAzbG9qfEa4qrZKvrnfNSBlaG0ojQ1OQ62EibzOfxPq8P5HbuowX/il/O0IKHF97XG41WuLL8cUe0PzHTMno5JSj6EGiZqrYCavSexzdt1WC4JTjeoEFR+jDbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgZAkBxbMmRSI60rg3Ev8/u0OJ1hW4XC+P5QylU0UKw=;
 b=QCe/e0AERduMRGlZZmNsBjDs8uSj3vjSBGtwM//Rl08Wb+R2PbDAJH1fyf3dZU/UqZ8ziZvixuOxjEvlKviu7CyEwrZCxtkQN+AwHny8w4YgXTYBk1fX6Gr4jKVKR55ZtdkWwS9oEDZDtggSe+Z+aE9XQXTBklHMSQULP6XvgK6MFHlTlEcsmUPrTfRzhicrEjA2tL2RG5Bca2T+LsvJKuymFMQQC7yWVWbjBZ2/afdiljyWgknP920cNCJ583fFt1OdnqfH32fEKX25umZ0rrcmlzQsNG0LvScYsWB6qSAlPaLoq3AFdiPUZu/c0qEsdKCMheIaWuT2p7HIBJClfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by DS0PR15MB5573.namprd15.prod.outlook.com (2603:10b6:8:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 17:21:00 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 17:21:00 +0000
Message-ID: <30b7a2a4-43cf-4c31-84ab-4e64d733a93c@meta.com>
Date: Thu, 29 Jan 2026 09:20:50 -0800
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH v2 net-next 1/2] virtio_net: add page_pool support for
 buffer allocation
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260128212031.1431746-1-vishs@meta.com>
 <20260128212031.1431746-2-vishs@meta.com>
 <CACGkMEtdEQzTfbAM23acZ1VJtuGb37oTDqyNctfRLMYDWMb-Tw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACGkMEtdEQzTfbAM23acZ1VJtuGb37oTDqyNctfRLMYDWMb-Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|DS0PR15MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ad6748-80e6-4c75-e6ac-08de5f5ac52b
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bGFSTUhXKzNPNjhXK01KUEpVdDVDTFEvSFV3dGdRQVhvOFpkYjk1WEVWTWdr?=
 =?utf-8?B?VFQyNmZVWTFKS1IzSnhJeTdQZ3pwY3lDZWFscERINitVT3BFbGVjLzgweUVC?=
 =?utf-8?B?YXhqdFhrTGVudHJXREdVQmE3WHFYL2lrNll6aS9Na0QycWdDZlY4N0ZqTG9K?=
 =?utf-8?B?ckFRZHprK1ExZjZCeUJaM2pZYkZxU01iYkFuYlBEczUvbDJURWRJNFFZSDVE?=
 =?utf-8?B?cS8ySHR3Vzd2QmhzOWk4RjZyRCtQbTU1a2pUN3ZTenZjcUZGWGREaGRxcWlH?=
 =?utf-8?B?TG1ucU44WUJPK1pNVVlTWUtKb2VLZVRKOWJkbXB0YlZ4Nm9INEdya1p2US84?=
 =?utf-8?B?MTkxVHhTTndCL1FCVmpCSUcySWcyWjFjRjk5V0d5bHprOW0ySzJlRGkvSktG?=
 =?utf-8?B?S2dnb3BwSVd1WE1vdDBKaDZMUDdjbHdnM0o5bGtidWJKSGh6eW1uQUpIQURj?=
 =?utf-8?B?N2RCLzRIRSs0Z0RZcHovdnljTWZqVEZCZUI5NjlJRU8yNHJ0czArL3ppVHV5?=
 =?utf-8?B?TGordWRJc1QxekluL2huNXJoVHpneE1MWnFxcFdHQ0QvN1kzdVBnbEFLMmFw?=
 =?utf-8?B?YVIrWGJlb2VycWRsVDZiUDdlWXdJeVlsdC9lSGo1TG51NDcyaHpnbk55WFc1?=
 =?utf-8?B?QnR1eHJYM3lieWZTYlk5ZlFlZEZlaG9lNUlSN08wNE1rNWV6UVhUL1Y4Z1lT?=
 =?utf-8?B?bENjbUNZMHUvcEVBSERPN1hjZlllTkVyRUR4VFNBcVRNTHlpdmMxdG1LZ1o3?=
 =?utf-8?B?ay8xWTRkcU1peUgzWk96R0I0Tmp5QWZMMjMrVUZhMmdCZ2tZUnREQWxMRmQ5?=
 =?utf-8?B?R1RwZUk4eVNxSzdieGVIYXpxMU9jTmFTSnNvTlNZQ2hxVC9ZSE5WOVkyaHJy?=
 =?utf-8?B?aHlUZVJKL2NLdlBFd051ek4wYmRnK01PUUNjZFhLamU2VVI0OGlqUVdmaFRE?=
 =?utf-8?B?WUJtcCtqZitSb2hCYU1oaU1yZFlnRGoxdjBsSjZCdGtWQWtYRW91dExjcHY5?=
 =?utf-8?B?dEozc3NJdW81eDg0YmRYOUxmV2U0WWZpRU9QTlhNbGF5UGYxcEZmL0Nub0pV?=
 =?utf-8?B?cWRoY2psODBVWWxBUnUxYlhEQVRwMVBaYnVtZElieUZuUDNRRVhwQ3c3Rjho?=
 =?utf-8?B?am5UOTlobHNINitrL2VHOUM1VW1MaHE1NXhVWVdFdVNURllvZzh2NUNrVHVD?=
 =?utf-8?B?b3NuRFFzRVI5dDE4dTcveEZGM3dBUkpmaVVqQ0ZRR1RBeHk3RU9BTzZTcUtC?=
 =?utf-8?B?dUdRS0h5cDNvZm96QmVLWnB5Y2Ftb1dQYi9VKzhqdGluVHBaVlBadkFTQTIv?=
 =?utf-8?B?b1l3Z1pYYWhtU2N4VUpQYWU5ekxGUEtYZ3hWVW4yTVROMlkzc05VTkJsdnFh?=
 =?utf-8?B?T2tmUTFqVE5jY3RWODFxaC9NbGNtQ1B1ZHNzbjRtbzZSOFJOMWZtSmlOUUo5?=
 =?utf-8?B?bTA4WERVaU5OZmJtL1RMU2ZlS0QySGhTR3BwWk4yZHRqelFxNmFDeDVqWm5j?=
 =?utf-8?B?N0xCY29QdjgzaU1OdHNJRHNBOGN2Wk01M0JzTkc3SFpjSUMzaVVKT2F5aXc5?=
 =?utf-8?B?YkdBM1ZZUzd6ajc1d2NndzhwbUMzOEVSWEdHZDE1QWhhMUtPQXBkai9XNHJH?=
 =?utf-8?B?MlMxM1RXcXU3MzNHQ2YwMHVGU1Z3T2VteisvTllHUENCQ1pidVlscHE3QTlx?=
 =?utf-8?B?MFVpOHIwVTVkZlFWMStwcE9LcWRXdStjZGNrRzlOdEM3Z3NXc2diY2UzY2FX?=
 =?utf-8?B?NHZjS05yajN4VityeCtmUEpSWHVoall4Wjg0YTY1ak1Cd2NUQy9sdmgzZDJp?=
 =?utf-8?B?Ry8veTNNNVh1clhOa050Mko4U0hnVEJRb2JMajJhZndMdDRWWksyR2hsenpD?=
 =?utf-8?B?d2ZvbENTR2d5S3lFSHdLd3h0NE1rSEZqOFVwdWsrRlVnM08vSUhVYzI2a29U?=
 =?utf-8?B?VllFeHZvbmZwZFpJYzFoK1RZNHdPT3NXS2pabGdRdHFvZW5jUStIZ25SOHNk?=
 =?utf-8?B?Y3l3S00vN3huRzQ5d0FlVndDdnp0NWlwR1FrNHNJYlhyQjZNN3djd2tMTVRp?=
 =?utf-8?B?VGlxb3g0ZzNKUmRJdFc1dWNWME9aWGphYXkyR2w4UHppd2FVS3doMTJZdFlx?=
 =?utf-8?Q?322s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L2I3elRXYzBxT1FLZVlPNGthYkRJREJvaVAyYWZIV1d4eFBsMjRVYVVMVFB3?=
 =?utf-8?B?UC9kc20rajJUclNtNGl3RHJhSmNzcGFLNmdJMW94TlNkT1loM0JOT2xzT0Rq?=
 =?utf-8?B?YmV5aVlJditKREdFZ2RET2dxdnJXYkc1VS9uREFuUG85M013UHA0QjlST0ZX?=
 =?utf-8?B?RXVMWmx4THdtdmplaUp3R00wb3Y0Z2hJYjJsQXRUY2hYOHBQU2xiMWc2V1dr?=
 =?utf-8?B?WE8xZXo1QUJzaDBCNUxNZlhWTndCbTVyYzFvaS9lVERZczRDRUdnRDBSanFm?=
 =?utf-8?B?cWxKcEM0UmlRbHN1bDdSQW9kQVRITnZFNHFZbVBCR3pUWkVFK1hHMGFBVmtP?=
 =?utf-8?B?dUU5QkhGWUZ5dFhtMU91Nnpoc3AxMVNVWDVEWmtqME1WaDRQdHRCNzVTdlpx?=
 =?utf-8?B?Unc0b1Y1RmNGbVNXT2YwQkFZeTk3Qm5aT0NsR29oT0RyK1dpOWJhWEpUMWJs?=
 =?utf-8?B?VVhleXpiUy9ydHVnRC9XS3RvOUF4SEdzT1hpakg0QU93K3ptTHR0a0NUM1I2?=
 =?utf-8?B?bndtMlltMW5iUEdGSms1dEpIK3RLck5VNld4YlhINVBFRVYvY0dkcytXMnZG?=
 =?utf-8?B?dzEzLy9Xc290TTN1T20vTmJ1WnQ0dnhSVUp2SjRaSmZkSEttbzYrYWt2Nm1l?=
 =?utf-8?B?a1RvOHBvaUhuMUhLdTZRNkNDTnozWGp0RDc4N3NKdkNMZExldWJWVXJpVW9H?=
 =?utf-8?B?TXNXNWZKZE4rTWdIcFFJbEV3T0U2d2FwcUMwRml6bW8rbFR5QU15Ry8vSlJU?=
 =?utf-8?B?Y1ZpaDJWb0ZsdXZGa1JsVG1yb2pEbWZHVjAzdHdjUUVjdEVLdVNyanRDTXB0?=
 =?utf-8?B?UEdMeUYvR2d0TFlHZkZ3eHdGNkRQWXBmNXdPSW1qNzQwR21IV1NJanZCb2tx?=
 =?utf-8?B?dE9YRklnenNwZXIzaTFrVERQZEx1ZnhwUTJQVEpRMEI5ZTkySlRteDlWbytD?=
 =?utf-8?B?djFScUNCakNkYlphT0V5QXhZaDVDY3h2dExRb1lUb1RmeldUTnY0U2loSDhn?=
 =?utf-8?B?L3FNZjNLaVcxVEprYnhxYTA4ZnZxUUFIYlJRdzZ2SUc5OGVJeXNlM3d3cFU2?=
 =?utf-8?B?ZTJIQ3ExRUNuZHkrYi9VOEVKcjIyaDlydDcrUDd1WWYxSEsrYzVIdkNCSm9l?=
 =?utf-8?B?UDNLR1NOcWlHTWd2NFNFZkwvMG13M2RWekVUUHhsTlN3RXhZRmNvSDFreXBl?=
 =?utf-8?B?bkQ4Q2lrN1lOVVQxTklqQlRLZnRvay9KVThKMFpJdW1ZTEt4UkpyNzVTY3Z5?=
 =?utf-8?B?TXBCblNLdldPSE9ONk43Rmc2c1YydS85MDVDa2hrT1RqOFNRS2lTWjUrK21s?=
 =?utf-8?B?OWdLREdwVjVrazdwdUU3SFVQeTZhWEtmUVRQTllEUXJvY1JoeVZOcFM5ZU1v?=
 =?utf-8?B?VkVTZnc0dnN5UTkvZDYwdnRCMW9aV1l4UThPUHB2WGF1akZQWkV6WlhOempB?=
 =?utf-8?B?Zzc1VDdLOWJhWTBJZ3ZsWklKYlVmWGw5Q2M4MmlhdWpjeDlNTXcrYWxROU1M?=
 =?utf-8?B?bklBTXdaeXp3VHZPdVM0M1lRYVF3LzZteVB1TWt3OUF3cTJncklhbkFQR2E2?=
 =?utf-8?B?aGZOeUVsdE1CTHI0bjh3aDBGbEY5ZDB4OEgyY0RxYkdyaG13aUcyYTBHUWZZ?=
 =?utf-8?B?eE9kUVNkWjQzdUgyTXFkS0hBbjNtT0UvWjN0RlpPT2I2RmVzOFAvUmM0ZVFJ?=
 =?utf-8?B?WkZRdmVGM1JLVk1kQWtHK3hPRDc1MHZYc2QzRjhkZVFBZVVvSjZQWDdsbVRB?=
 =?utf-8?B?N3lxSE5WazUxaEdpQjg0Z1hiRDYzMzVrbnBaTXJIcVRPSVhWRUdmVzc0THBv?=
 =?utf-8?B?Y094Q2JHZXA3SWxSTGF2ckhYZmJqRkJtWUhHTlI1SzdKQjRNb1NhVk12SStD?=
 =?utf-8?B?MS9yems2NVVLZzVkanZrbWxPK3c0UUMwdXpjZVRpZUJzaU1YQjRZOTJjMm82?=
 =?utf-8?B?eENwSVk5aFh6ZVlUSk01RFA3OTdZMDhBRVI1WWVoL2kvUFZuQm5TWUkyN3VW?=
 =?utf-8?B?WWhyNTh4VU00TEtSNW5qcTlNOXNWTXl1UWUzY2xobVd1R2JTMG5HcXVFeTdF?=
 =?utf-8?B?ZkJDMFB1b2ZyaWFiRGV4L1JvekplNEVUMG5qc3hhaU5xMlBENGtnSHladVh2?=
 =?utf-8?B?bWlWTjNoT0gzL2V4ZG9XQnRuNng0N1h1OGxDMjhOR29Tc2ZCR2NnMTV0ajl6?=
 =?utf-8?B?M0FsSHdkdFM0UitMZ3ZidlcrbVA1VnBVYkF0Vlo1ZGZIbU9MN2ltamROcmJE?=
 =?utf-8?B?aEg1RHMrSWNuNTMvTUNWZ0VxNEVlWEx0M3ZNT2ZPd014Uks5djdwWkZTZ2pC?=
 =?utf-8?B?UkJlSmlZR0V4NnNORHV5MEg2MnZRS2h4QlNSYUxxeG1pcC9hQmRucytiL3Zq?=
 =?utf-8?Q?Z9S8ih7JPKfgaxYmwGWm5e39JR/hHbkuQnoJl?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ad6748-80e6-4c75-e6ac-08de5f5ac52b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:21:00.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4fOCadCCf2I8cxBUu0qnQi3Ks4npDhW1SaAn18QFI9hfx3ce+R27br1E6556WD1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5573
X-Authority-Analysis: v=2.4 cv=EJcLElZC c=1 sm=1 tr=0 ts=697b9701 cx=c_pps
 a=/qs4bcqls8FpsUBDM29/qQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=VAAlsHd_36uqA2dA3H8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfX8RNUs/Y/GwGD
 RVzxAwiH7QJ58z7XufCjtlYyXIh/w97vbGEN3kxeeVHPXrmC3PkYXGf0CpBwi+TBCxVazFDWAXi
 dPI12U5HKXUFhu892xQjZfCCpKVr+CZrf/NI6lPtZdgpF6GHgx0utwu03XaotGXyyAu0LgU9QqM
 s94R7NQcbpafo/dkOALGdHDuZokT5SOQHRvbGlq4HxrN4UMqRbL5GJ9Vp4a5QeV2TfBBEzskrSr
 0zjx97XO0shhHvFBncL/YZgrGs8CPEcO6w8m+6iPzAj2udiaWbZNnDeQ5Ieykkm5BG0bFAmaKtt
 IWnpOMl+NwgPQm3ana/0leAIPNtc/bhda+/OjrHUDe3YmfWzqNpWUlwd+nW9FqjdLGRv3RqNVft
 qI4dRMDTeiyqX0bVZeLPrrhBOpVzDEoo1KAm8z1BidgqrE9hdzBH0+v1DkLMPXmzxBIvYMZD/OL
 Lb7XzYOpXiMLGD6tC9A==
X-Proofpoint-ORIG-GUID: M8QKhESvz5OI07hMpqjdu0gUBQpQ4B04
X-Proofpoint-GUID: M8QKhESvz5OI07hMpqjdu0gUBQpQ4B04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254870-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pp_params.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8470EB2CBD
X-Rspamd-Action: no action

On 1/28/26 6:54 PM, Jason Wang wrote:
> On Thu, Jan 29, 2026 at 5:20 AM Vishwanath Seshagiri <vishs@meta.com> wrote:
>>
>> Use page_pool for RX buffer allocation in mergeable and small buffer
>> modes to enable page recycling and avoid repeated page allocator calls.
>> skb_mark_for_recycle() enables page reuse in the network stack.
>>
>> Big packets mode is unchanged because it uses page->private for linked
>> list chaining of multiple pages per buffer, which conflicts with
>> page_pool's internal use of page->private.
>>
>> Implement conditional DMA premapping using virtqueue_dma_dev():
>> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>>    handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
>> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>>    submit via virtqueue_add_inbuf_ctx()
>>
>> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
>> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
>> support as a prerequisite for future zero-copy features (devmem TCP,
>> io_uring ZCRX).
>>
>> Page pools are created in probe and destroyed in remove (not open/close),
>> following existing driver behavior where RX buffers remain in virtqueues
>> across interface state changes.
>>
>> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
>> sending control virtqueue commands while ndo_close is tearing down
>> device state, avoiding virtqueue corruption during concurrent operations.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>>   drivers/net/Kconfig      |   1 +
>>   drivers/net/virtio_net.c | 353 ++++++++++++++++++++++-----------------
>>   2 files changed, 203 insertions(+), 151 deletions(-)
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index ac12eaf11755..f1e6b6b0a86f 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -450,6 +450,7 @@ config VIRTIO_NET
>>          depends on VIRTIO
>>          select NET_FAILOVER
>>          select DIMLIB
>> +       select PAGE_POOL
>>          help
>>            This is the virtual network driver for virtio.  It can be used with
>>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..df2a5fc5187e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -26,6 +26,7 @@
>>   #include <net/netdev_rx_queue.h>
>>   #include <net/netdev_queues.h>
>>   #include <net/xdp_sock_drv.h>
>> +#include <net/page_pool/helpers.h>
>>
>>   static int napi_weight = NAPI_POLL_WEIGHT;
>>   module_param(napi_weight, int, 0444);
>> @@ -359,6 +360,11 @@ struct receive_queue {
>>          /* Page frag for packet buffer allocation. */
>>          struct page_frag alloc_frag;
>>
>> +       struct page_pool *page_pool;
>> +
>> +       /* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
>> +       bool use_page_pool_dma;
>> +
>>          /* RX: fragments + linear part + virtio header */
>>          struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>
>> @@ -521,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>                                 struct virtnet_rq_stats *stats);
>>   static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>                                   struct sk_buff *skb, u8 flags);
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +                                              struct sk_buff *head_skb,
>>                                                 struct sk_buff *curr_skb,
>>                                                 struct page *page, void *buf,
>>                                                 int len, int truesize);
>>   static void virtnet_xsk_completed(struct send_queue *sq, int num);
>> +static void free_unused_bufs(struct virtnet_info *vi);
>>
>>   enum virtnet_xmit_type {
>>          VIRTNET_XMIT_TYPE_SKB,
>> @@ -706,15 +714,21 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>          return p;
>>   }
>>
>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>> +                            bool allow_direct)
>> +{
>> +       page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>> +}
>> +
>>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>                                  struct receive_queue *rq, void *buf)
>>   {
>>          if (vi->mergeable_rx_bufs)
>> -               put_page(virt_to_head_page(buf));
>> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>>          else if (vi->big_packets)
>>                  give_pages(rq, buf);
>>          else
>> -               put_page(virt_to_head_page(buf));
>> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>>   }
>>
>>   static void enable_rx_mode_work(struct virtnet_info *vi)
>> @@ -877,9 +891,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                  if (unlikely(!skb))
>>                          return NULL;
>>
>> -               page = (struct page *)page->private;
>> -               if (page)
>> -                       give_pages(rq, page);
> 
> Note that the page_to_skb() will be used by the big mode. So this
> change may break big mode.

Good catch. I incorrectly removed it, and will restore it for
big_packets mode in v3.

> 
>>                  goto ok;
>>          }
>>
>> @@ -914,18 +925,14 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                  skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>>                                  frag_size, truesize);
>>                  len -= frag_size;
>> -               page = (struct page *)page->private;
> 
> And this.

Same as above. will restore in v3.

> 
>>                  offset = 0;
>>          }
>>
>> -       if (page)
>> -               give_pages(rq, page);
>> -
>>   ok:
>>          hdr = skb_vnet_common_hdr(skb);
>>          memcpy(hdr, hdr_p, hdr_len);
>>          if (page_to_free)
>> -               put_page(page_to_free);
>> +               virtnet_put_page(rq, page_to_free, true);
>>
>>          return skb;
>>   }
>> @@ -965,93 +972,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>>          struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       void *buf;
>> -
>> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -       buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> -       if (buf)
>> -               virtnet_rq_unmap(rq, buf, *len);
>> -
>> -       return buf;
>> -}
>> -
>> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>> -{
>> -       struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       struct virtnet_rq_dma *dma;
>> -       dma_addr_t addr;
>> -       u32 offset;
>> -       void *head;
>> -
>> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -       head = page_address(rq->alloc_frag.page);
>> -
>> -       offset = buf - head;
>> -
>> -       dma = head;
>> -
>> -       addr = dma->addr - sizeof(*dma) + offset;
>> -
>> -       sg_init_table(rq->sg, 1);
>> -       sg_fill_dma(rq->sg, addr, len);
>> -}
>> -
>> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>> -{
>> -       struct page_frag *alloc_frag = &rq->alloc_frag;
>> -       struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       struct virtnet_rq_dma *dma;
>> -       void *buf, *head;
>> -       dma_addr_t addr;
>>
>>          BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>
>> -       head = page_address(alloc_frag->page);
>> -
>> -       dma = head;
>> -
>> -       /* new pages */
>> -       if (!alloc_frag->offset) {
>> -               if (rq->last_dma) {
>> -                       /* Now, the new page is allocated, the last dma
>> -                        * will not be used. So the dma can be unmapped
>> -                        * if the ref is 0.
>> -                        */
>> -                       virtnet_rq_unmap(rq, rq->last_dma, 0);
>> -                       rq->last_dma = NULL;
>> -               }
>> -
>> -               dma->len = alloc_frag->size - sizeof(*dma);
>> -
>> -               addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
>> -                                                 dma->len, DMA_FROM_DEVICE, 0);
>> -               if (virtqueue_map_mapping_error(rq->vq, addr))
>> -                       return NULL;
>> -
>> -               dma->addr = addr;
>> -               dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
>> -
>> -               /* Add a reference to dma to prevent the entire dma from
>> -                * being released during error handling. This reference
>> -                * will be freed after the pages are no longer used.
>> -                */
>> -               get_page(alloc_frag->page);
>> -               dma->ref = 1;
>> -               alloc_frag->offset = sizeof(*dma);
>> -
>> -               rq->last_dma = dma;
>> -       }
>> -
>> -       ++dma->ref;
>> -
>> -       buf = head + alloc_frag->offset;
>> -
>> -       get_page(alloc_frag->page);
>> -       alloc_frag->offset += size;
>> -
>> -       return buf;
>> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>   }
>>
>>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>> @@ -1067,9 +991,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>                  return;
>>          }
>>
>> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
>> -               virtnet_rq_unmap(rq, buf, 0);
>> -
>>          virtnet_rq_free_buf(vi, rq, buf);
>>   }
>>
>> @@ -1335,7 +1256,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>
>>                  truesize = len;
>>
>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +               curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>                                                      buf, len, truesize);
>>                  if (!curr_skb) {
>>                          put_page(page);
>> @@ -1771,7 +1692,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>          return ret;
>>   }
>>
>> -static void put_xdp_frags(struct xdp_buff *xdp)
>> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq)
>>   {
>>          struct skb_shared_info *shinfo;
>>          struct page *xdp_page;
>> @@ -1781,7 +1702,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>                  shinfo = xdp_get_shared_info_from_buff(xdp);
>>                  for (i = 0; i < shinfo->nr_frags; i++) {
>>                          xdp_page = skb_frag_page(&shinfo->frags[i]);
>> -                       put_page(xdp_page);
>> +                       virtnet_put_page(rq, xdp_page, true);
>>                  }
>>          }
>>   }
>> @@ -1897,7 +1818,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>                  off = buf - page_address(p);
>>
>>                  if (check_mergeable_len(dev, ctx, buflen)) {
>> -                       put_page(p);
>> +                       virtnet_put_page(rq, p, true);
>>                          goto err_buf;
>>                  }
>>
>> @@ -1905,14 +1826,14 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>                   * is sending packet larger than the MTU.
>>                   */
>>                  if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>> -                       put_page(p);
>> +                       virtnet_put_page(rq, p, true);
>>                          goto err_buf;
>>                  }
>>
>>                  memcpy(page_address(page) + page_off,
>>                         page_address(p) + off, buflen);
>>                  page_off += buflen;
>> -               put_page(p);
>> +               virtnet_put_page(rq, p, true);
>>          }
>>
>>          /* Headroom does not contribute to packet length */
>> @@ -1962,7 +1883,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>          unsigned int headroom = vi->hdr_len + header_offset;
>>          struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>>          struct page *page = virt_to_head_page(buf);
>> -       struct page *xdp_page;
>> +       struct page *xdp_page = NULL;
>>          unsigned int buflen;
>>          struct xdp_buff xdp;
>>          struct sk_buff *skb;
>> @@ -1996,7 +1917,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>                          goto err_xdp;
>>
>>                  buf = page_address(xdp_page);
>> -               put_page(page);
>> +               virtnet_put_page(rq, page, true);
>>                  page = xdp_page;
>>          }
>>
>> @@ -2028,13 +1949,19 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>          if (metasize)
>>                  skb_metadata_set(skb, metasize);
>>
>> +       if (!xdp_page)
>> +               skb_mark_for_recycle(skb);
> 
> I wonder would it better to use page pool in xdp_linearize_page() as
> well to simply the codes here?

Allocating the linearization page from the page_pool would eliminate the
need for the xdp_page tracking, and simplify skb_mark_for_recycle. I
will update v3 to use page_pool_alloc_pages() in xdp_linearize_page().

> 
>> +
>>          return skb;
>>
>>   err_xdp:
>>          u64_stats_inc(&stats->xdp_drops);
>>   err:
>>          u64_stats_inc(&stats->drops);
>> -       put_page(page);
>> +       if (xdp_page)
>> +               put_page(page);
>> +       else
>> +               virtnet_put_page(rq, page, true);
> 
> And here, and the similar path in mergeable XDP handling.

Same as above. Will change it in v3.

> 
>>   xdp_xmit:
>>          return NULL;
>>   }
>> @@ -2082,12 +2009,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>          }
>>
>>          skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>> -       if (likely(skb))
>> +       if (likely(skb)) {
>> +               skb_mark_for_recycle(skb);
>>                  return skb;
>> +       }
>>
>>   err:
>>          u64_stats_inc(&stats->drops);
>> -       put_page(page);
>> +       virtnet_put_page(rq, page, true);
>>          return NULL;
>>   }
>>
>> @@ -2142,7 +2071,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>                  }
>>                  u64_stats_add(&stats->bytes, len);
>>                  page = virt_to_head_page(buf);
>> -               put_page(page);
>> +               virtnet_put_page(rq, page, true);
>>          }
>>   }
>>
>> @@ -2253,7 +2182,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>                  offset = buf - page_address(page);
>>
>>                  if (check_mergeable_len(dev, ctx, len)) {
>> -                       put_page(page);
>> +                       virtnet_put_page(rq, page, true);
>>                          goto err;
>>                  }
>>
>> @@ -2272,7 +2201,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>          return 0;
>>
>>   err:
>> -       put_xdp_frags(xdp);
>> +       put_xdp_frags(xdp, rq);
>>          return -EINVAL;
>>   }
>>
>> @@ -2347,7 +2276,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>
>>          *frame_sz = PAGE_SIZE;
>>
>> -       put_page(*page);
>> +       virtnet_put_page(rq, *page, true);
>>
>>          *page = xdp_page;
>>
>> @@ -2369,6 +2298,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>          struct page *page = virt_to_head_page(buf);
>>          int offset = buf - page_address(page);
>>          unsigned int xdp_frags_truesz = 0;
>> +       struct page *org_page = page;
>>          struct sk_buff *head_skb;
>>          unsigned int frame_sz;
>>          struct xdp_buff xdp;
>> @@ -2393,6 +2323,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>                  head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>                  if (unlikely(!head_skb))
>>                          break;
>> +               if (page == org_page)
>> +                       skb_mark_for_recycle(head_skb);
>>                  return head_skb;
>>
>>          case XDP_TX:
>> @@ -2403,10 +2335,13 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>                  break;
>>          }
>>
>> -       put_xdp_frags(&xdp);
>> +       put_xdp_frags(&xdp, rq);
>>
>>   err_xdp:
>> -       put_page(page);
>> +       if (page != org_page)
>> +               put_page(page);
>> +       else
>> +               virtnet_put_page(rq, page, true);
>>          mergeable_buf_free(rq, num_buf, dev, stats);
>>
>>          u64_stats_inc(&stats->xdp_drops);
>> @@ -2414,7 +2349,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>          return NULL;
>>   }
>>
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +                                              struct sk_buff *head_skb,
>>                                                 struct sk_buff *curr_skb,
>>                                                 struct page *page, void *buf,
>>                                                 int len, int truesize)
>> @@ -2446,7 +2382,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>
>>          offset = buf - page_address(page);
>>          if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>> -               put_page(page);
>> +               virtnet_put_page(rq, page, true);
>>                  skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>                                       len, truesize);
>>          } else {
>> @@ -2495,10 +2431,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>          }
>>
>>          head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
>> +       if (unlikely(!head_skb))
>> +               goto err_skb;
>> +
>>          curr_skb = head_skb;
>>
>> -       if (unlikely(!curr_skb))
>> -               goto err_skb;
> 
> This change sees to be useless?

Moved it around when making changes. Will revert in v3.

> 
>> +       skb_mark_for_recycle(head_skb);
>>          while (--num_buf) {
>>                  buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>                  if (unlikely(!buf)) {
>> @@ -2517,7 +2455,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>                          goto err_skb;
>>
>>                  truesize = mergeable_ctx_to_truesize(ctx);
>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +               curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>                                                      buf, len, truesize);
>>                  if (!curr_skb)
>>                          goto err_skb;
>> @@ -2527,7 +2465,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>          return head_skb;
>>
>>   err_skb:
>> -       put_page(page);
>> +       virtnet_put_page(rq, page, true);
>>          mergeable_buf_free(rq, num_buf, dev, stats);
>>
>>   err_buf:
>> @@ -2666,6 +2604,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>                               gfp_t gfp)
>>   {
>> +       unsigned int offset;
>> +       struct page *page;
>>          char *buf;
>>          unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>          void *ctx = (void *)(unsigned long)xdp_headroom;
>> @@ -2675,23 +2615,30 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>          len = SKB_DATA_ALIGN(len) +
>>                SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>
>> -       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>> -               return -ENOMEM;
>> -
>> -       buf = virtnet_rq_alloc(rq, len, gfp);
>> -       if (unlikely(!buf))
>> +       page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
>> +       if (unlikely(!page))
>>                  return -ENOMEM;
>>
>> +       buf = page_address(page) + offset;
>>          buf += VIRTNET_RX_PAD + xdp_headroom;
>>
>> -       virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>> +       sg_init_table(rq->sg, 1);
>>
>> -       err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> -       if (err < 0) {
>> -               virtnet_rq_unmap(rq, buf, 0);
>> -               put_page(virt_to_head_page(buf));
>> +       if (rq->use_page_pool_dma) {
>> +               dma_addr_t addr = page_pool_get_dma_addr(page) + offset;
>> +
>> +               addr += VIRTNET_RX_PAD + xdp_headroom;
>> +               sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
>> +               err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf,
>> +                                                   ctx, gfp);
>> +       } else {
>> +               sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN);
>> +               err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>          }
>>
>> +       if (err < 0)
>> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>> +                                  -1, false);
>>          return err;
>>   }
>>
>> @@ -2764,11 +2711,12 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>   static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>                                   struct receive_queue *rq, gfp_t gfp)
>>   {
>> -       struct page_frag *alloc_frag = &rq->alloc_frag;
>>          unsigned int headroom = virtnet_get_headroom(vi);
>>          unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>          unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>          unsigned int len, hole;
>> +       unsigned int offset;
>> +       struct page *page;
>>          void *ctx;
>>          char *buf;
>>          int err;
>> @@ -2779,18 +2727,14 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>           */
>>          len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>
>> -       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>> -               return -ENOMEM;
>> -
>> -       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
>> -               len -= sizeof(struct virtnet_rq_dma);
>> -
>> -       buf = virtnet_rq_alloc(rq, len + room, gfp);
>> -       if (unlikely(!buf))
>> +       page = page_pool_alloc_frag(rq->page_pool, &offset, len + room, gfp);
>> +       if (unlikely(!page))
>>                  return -ENOMEM;
>>
>> +       buf = page_address(page) + offset;
>>          buf += headroom; /* advance address leaving hole at front of pkt */
>> -       hole = alloc_frag->size - alloc_frag->offset;
>> +
>> +       hole = PAGE_SIZE - (offset + len + room);
>>          if (hole < len + room) {
>>                  /* To avoid internal fragmentation, if there is very likely not
>>                   * enough space for another buffer, add the remaining space to
>> @@ -2800,18 +2744,27 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>                   */
>>                  if (!headroom)
>>                          len += hole;
>> -               alloc_frag->offset += hole;
>>          }
>>
>> -       virtnet_rq_init_one_sg(rq, buf, len);
>> -
>>          ctx = mergeable_len_to_ctx(len + room, headroom);
>> -       err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> -       if (err < 0) {
>> -               virtnet_rq_unmap(rq, buf, 0);
>> -               put_page(virt_to_head_page(buf));
>> +
>> +       sg_init_table(rq->sg, 1);
>> +
>> +       if (rq->use_page_pool_dma) {
>> +               dma_addr_t addr = page_pool_get_dma_addr(page) + offset;
>> +
>> +               addr += headroom;
>> +               sg_fill_dma(rq->sg, addr, len);
>> +               err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf,
>> +                                                   ctx, gfp);
>> +       } else {
>> +               sg_set_buf(&rq->sg[0], buf, len);
>> +               err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>          }
>>
>> +       if (err < 0)
>> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>> +                                  -1, false);
>>          return err;
>>   }
>>
>> @@ -3128,7 +3081,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>                  return err;
>>
>>          err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>> -                                        MEM_TYPE_PAGE_SHARED, NULL);
>> +                                        vi->rq[qp_index].page_pool ?
>> +                                               MEM_TYPE_PAGE_POOL :
>> +                                               MEM_TYPE_PAGE_SHARED,
>> +                                        vi->rq[qp_index].page_pool);
>>          if (err < 0)
>>                  goto err_xdp_reg_mem_model;
>>
>> @@ -3168,6 +3124,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>                  vi->duplex = duplex;
>>   }
>>
>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>> +{
>> +       int i, err;
>> +
>> +       for (i = 0; i < vi->curr_queue_pairs; i++) {
> 
> This should be max_queue_paris, or page pools for new enabled queue
> pairs need to be created on demand during set_queues().

Will fix it to max_queue_pairs in v3, and update my testing env since
this broke the ci as well.

> 
>> +               struct receive_queue *rq = &vi->rq[i];
>> +               struct page_pool_params pp_params = { 0 };
>> +               struct device *dma_dev;
>> +
>> +               if (rq->page_pool)
>> +                       continue;
>> +
>> +               if (rq->xsk_pool)
>> +                       continue;
>> +
>> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
>> +                       continue;
>> +
>> +               pp_params.order = 0;
>> +               pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>> +               pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>> +               pp_params.netdev = vi->dev;
>> +               pp_params.napi = &rq->napi;
>> +
>> +               /* Check if backend supports DMA API (e.g., vhost, virtio-pci).
>> +                * If so, use page_pool's DMA mapping for premapped buffers.
>> +                * Otherwise (e.g., VDUSE), page_pool only handles allocation.
>> +                */
>> +               dma_dev = virtqueue_dma_dev(rq->vq);
>> +               if (dma_dev) {
>> +                       pp_params.dev = dma_dev;
>> +                       pp_params.flags = PP_FLAG_DMA_MAP;
>> +                       pp_params.dma_dir = DMA_FROM_DEVICE;
>> +                       rq->use_page_pool_dma = true;
>> +               } else {
>> +                       pp_params.dev = vi->vdev->dev.parent;
>> +                       pp_params.flags = 0;
>> +                       rq->use_page_pool_dma = false;
>> +               }
>> +
>> +               rq->page_pool = page_pool_create(&pp_params);
>> +               if (IS_ERR(rq->page_pool)) {
>> +                       err = PTR_ERR(rq->page_pool);
>> +                       rq->page_pool = NULL;
>> +                       goto err_cleanup;
>> +               }
>> +       }
>> +       return 0;
>> +
>> +err_cleanup:
>> +       while (--i >= 0) {
>> +               struct receive_queue *rq = &vi->rq[i];
>> +
>> +               if (rq->page_pool) {
>> +                       page_pool_destroy(rq->page_pool);
>> +                       rq->page_pool = NULL;
>> +               }
>> +       }
>> +       return err;
>> +}
>> +
>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < vi->max_queue_pairs; i++) {
>> +               struct receive_queue *rq = &vi->rq[i];
>> +
>> +               if (rq->page_pool) {
>> +                       page_pool_destroy(rq->page_pool);
>> +                       rq->page_pool = NULL;
>> +               }
>> +       }
>> +}
>> +
>>   static int virtnet_open(struct net_device *dev)
>>   {
>>          struct virtnet_info *vi = netdev_priv(dev);
>> @@ -3771,6 +3802,8 @@ static int virtnet_close(struct net_device *dev)
>>           */
>>          cancel_work_sync(&vi->config_work);
>>
>> +       vi->rx_mode_work_enabled = false;
>> +
>>          for (i = 0; i < vi->max_queue_pairs; i++) {
>>                  virtnet_disable_queue_pair(vi, i);
>>                  virtnet_cancel_dim(vi, &vi->rq[i].dim);
>> @@ -3807,6 +3840,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>>
>>          rtnl_lock();
>>
>> +       if (!vi->rx_mode_work_enabled) {
>> +               rtnl_unlock();
>> +               return;
>> +       }
> 
> Is this a separated fix? I don't see the connection to the page pool.

It happened when I was trying to send traffic to the vm once the
interface went down. There are already helpers that handle this flag
with proper locking. I will remove it in v3.

> 
>> +
>>          *promisc_allmulti = !!(dev->flags & IFF_PROMISC);
>>          sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>>
>> @@ -6945,6 +6983,14 @@ static int virtnet_probe(struct virtio_device *vdev)
>>                          goto free;
>>          }
>>
>> +       /* Create page pools for receive queues.
>> +        * Page pools are created at probe time so they can be used
>> +        * with premapped DMA addresses throughout the device lifetime.
>> +        */
>> +       err = virtnet_create_page_pools(vi);
>> +       if (err)
>> +               goto free_irq_moder;
>> +
>>   #ifdef CONFIG_SYSFS
>>          if (vi->mergeable_rx_bufs)
>>                  dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
>> @@ -6958,7 +7004,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>                  vi->failover = net_failover_create(vi->dev);
>>                  if (IS_ERR(vi->failover)) {
>>                          err = PTR_ERR(vi->failover);
>> -                       goto free_vqs;
>> +                       goto free_page_pools;
>>                  }
>>          }
>>
>> @@ -7075,7 +7121,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>>          unregister_netdev(dev);
>>   free_failover:
>>          net_failover_destroy(vi->failover);
>> -free_vqs:
>> +free_page_pools:
>> +       virtnet_destroy_page_pools(vi);
>> +free_irq_moder:
>> +       virtnet_free_irq_moder(vi);
>>          virtio_reset_device(vdev);
>>          free_receive_page_frags(vi);
>>          virtnet_del_vqs(vi);
>> @@ -7104,6 +7153,8 @@ static void remove_vq_common(struct virtnet_info *vi)
>>
>>          free_receive_page_frags(vi);
>>
>> +       virtnet_destroy_page_pools(vi);
>> +
>>          virtnet_del_vqs(vi);
>>   }
>>
>> --
>> 2.47.3
>>
> 
> Thanks
> 


