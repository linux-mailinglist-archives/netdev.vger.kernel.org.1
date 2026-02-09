Return-Path: <netdev+bounces-257983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA1sHw43immhIQAAu9opvQ
	(envelope-from <netdev+bounces-257983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:35:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C019114280
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9668B301F32A
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2619E423A6A;
	Mon,  9 Feb 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WWjhSG86"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850F38759B;
	Mon,  9 Feb 2026 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665701; cv=fail; b=e1rycA2uCX6pSKL3E+xfuKbG5jJRZFp2iNbXW7r7lZKUNCLiL2IqAbpMiWNR9udcbJ4cHXxfX70EahOR7/vUa7uPW+SyVcytuj8lJgaR1Ovs1HiNi4BMkxzmUL8+iAJdvv+Hmg8U31ZZoArUUEj61XmbDxeBM2Cwvbe9wVQPV90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665701; c=relaxed/simple;
	bh=sKyS8nHM1OT8dS0JzD4wDioeuMwKwTS8+QmI4DBxIIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmNcyDS2sbTZJL5+wq17obtlDB/Ba0vy15FfTlIWRq54FBHmCLe59/sRgiPy2XIKrQ7S+ktVhl+5cc0jx2agM4b6pp5dblIp2TnkP7et76LaHudwccOYJ2L9mjT0v9h6ytiKW0DHEbU/5m7N01EFhyc1RGhVPwdHNWFHWzr93n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WWjhSG86; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619HBKwU951902;
	Mon, 9 Feb 2026 11:34:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7y1L4lqsdLqVJbPLeNbsKw6myJHYvEW8uij1QMei5wc=; b=WWjhSG86sc5G
	caEVvAvBxgNFC4quxYNKvDCDqNGfwlUwzrYWtm9HY1iusfyIyxRMAWqdBXx708Yn
	kmr8flXEnpLDCHCscSzYPreMTZ70sgivtc9uVKEUHt+PztJyWVA15MmgbRp5Hc4P
	yTDpOryRZEw06VXBtO07diCOQ3skY559CzKQB0UNaRl/EIFPjGYnTOoDMEoJAzYx
	KBs97ar8QrSJIA/NC0RpPs0IyluPbuVduA28aycZrwTPw6bCsGm/Ok7akljLh3Zk
	vVSj91b1eWJNtddAomwe9YG/x5g2oRsyF0Ll1DddvHhMRjTBccWxphqz5eNk5L6R
	JAOdWJb80g==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c7f1wngew-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 11:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7xy87jqsKed6CUbne+QSdyzXGzstTp3Xr55YInPFhkjyngSGrrzrQ6+sjihev26KpRQ109XVmRxAWNqX0RiAeVboVudf5IYHeyUTNuqcvwNsWluqvds+W4tE5+QZId5/vPjoIrsrBo/9SWyrWUkHxcc5DV/QWeuSV0SDeGVaS0FDAsHFZur1NGRnWY2xJKSdJ0UWNIk9l7m5tnlGPj2KzqUJJgcdfDsPHpnJ9mpQ6+p+0keIBb40UPn693noRpKNh5Y0DMr0T+pTxabEDJWv/lQFTzfmgoKPSD4FnAUe1Ts3Om12UcJPzvRxafKzil9hnPRbURnJJkDlqEXL2yfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y1L4lqsdLqVJbPLeNbsKw6myJHYvEW8uij1QMei5wc=;
 b=PKD0j9I407HDwWA3RG9blnVRLMzbcsC8EW648X8jeNuJkgAVSoCHDy+iL44JML6fSs1I8JHOn+VKHIVZIWSr1bmOd300dvrNOqaCzUDsIsjrCGDZNkr0MDWg/uivMEUg2NkDX8/oAhZpAZDRr20pJbk3sxr7zsTksutIENcGVnyzem4gK0C3H2QVGmyiYahwPPFNis/jBa8aedJ0od2J9sl9FdcDH/aUwOsZixOoEug5SzLkThI5yYC3Vavyi0Z0RAwLJfWyOjmiRakhsRaKUW3xKGfacNgxsLFodW5quKuCKqdsYeV/YzRWmpgJ2US8KDy6AeedK0R2nzb/UZ9g+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by BL3PR15MB5483.namprd15.prod.outlook.com (2603:10b6:208:3bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Mon, 9 Feb
 2026 19:34:42 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 19:34:42 +0000
Message-ID: <5184bd60-2a96-451e-8b0a-bc1132b1498d@meta.com>
Date: Mon, 9 Feb 2026 11:34:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] virtio_net: add page_pool support for buffer
 allocation
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
References: <20260208175410.1910001-1-vishs@meta.com>
 <1770602432.6451533-1-xuanzhuo@linux.alibaba.com>
 <b97cd16c-e35c-4e74-b258-056ae491aa1b@meta.com>
 <1770621144.341019-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <1770621144.341019-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|BL3PR15MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3f364b-a25f-4978-b2bb-08de68124575
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Tko2bDdvaU9FK1NsN240V1ZTY3hmRU5nckk3RnNwcElUTEpoZjkxL3BkM0xJ?=
 =?utf-8?B?R0x3UHMzUjlWQ2VXT1V0S0VSc3pFZlNCdHNQcGNzZ2FKaXFpNzBxR2lEYTlV?=
 =?utf-8?B?SWl4U1R1MnF4L1JKQllxb2lRVWRYMVFMeUZJelNrd3NMa0dvdUJldURMbzdy?=
 =?utf-8?B?ZkhkTzhHZ2g0akp5ajRrUjNVMWNDQjdDbVFETHN1ZTEyNk5JbTFWRnlSd1Jr?=
 =?utf-8?B?WnozNmJTRllxU1ZSbWJuc3J4UXNKclZKUnhuRlJFTHdwbmxXc1V2QURDVnRW?=
 =?utf-8?B?M1BENUtnVVFQZEc0Y1FVbVpJOGlqeE9DVkM0YjVHdTFJRjYrc3hTUTVsbDVa?=
 =?utf-8?B?VHE3MUgxVTlKa1JQRG12S2ExWGRDYzUrbjRQZmcwYW55RnpSZ050SWFwZmc5?=
 =?utf-8?B?TTNvN3dtM0c0Y1JqZWdJVVliNU1Uc3JocUR5aUsvQWNQTmUwNFd3bDBxVWpV?=
 =?utf-8?B?b0JLKzdOSTFGcjg2R0Zha3QzbitEZ2NjaldtTmpWZlFtTDN1UEZrUUJmUWc2?=
 =?utf-8?B?eVZPSENzWFNwN1A3T2hFMmF1dlhicHNSdFVuYnNXUmpLRzJyejlZeFRSSFNJ?=
 =?utf-8?B?ekJVKy94L3RRaVhJcno5YmN0cjFOUzh1alZaOFVRUHA0ZGZMSW54OWN2ZWtl?=
 =?utf-8?B?dmhWUFByMWZudjA0aWtKQVQ2eGRmNTdHbm9Yd1BzdWZSSFpBV29KMHVwN0FB?=
 =?utf-8?B?VGZWNXE5MFdQTlU1bE1OOG5tcGdpaEZNKzdYRUFmR0NXUjM2ZlN6cHBubEpi?=
 =?utf-8?B?b2M5eDhzT3lXTzluYXgvRTFIRHVxSjNNeUFwYmEyM2FaOFNxc2tqdW9BMVYv?=
 =?utf-8?B?R0o2K0srTG44WFRGOExPWWJlSGNoZ09JM0hXd0Q1YSs2QWRnaFdnMG91L2Rh?=
 =?utf-8?B?dHB0WU9abyt0SFlWeTJka2JnWVhPaTdNRVMxRk5yWDZucWxJZldGRzcwUkph?=
 =?utf-8?B?bkZUUDh2eXYvWncveEl3K0N0ZVN1cHR5ejRleHRWcTdSOWpkMTA0MUNQQ2tU?=
 =?utf-8?B?clBGSXNJQlZRR0EzbURUcGVMajlHd1k0UENLM0lleE5xVG5QRG5iTWxsbnF3?=
 =?utf-8?B?UjR3a2VPT0IzeG41RFNQR2pDcHRPeTF1UjBrQ2puWU9ZbmtFN3pPVDdHS0pl?=
 =?utf-8?B?QWNRL01sbW5mbWR5ZEtUVStUSW9pdm1jNVk3ajR6bWJxY0hxMVRsNDNMakVI?=
 =?utf-8?B?TSs4c0JqR2RPRFNCdlNKZW1aZk1OZEJGQkU3MmtENjRFR2x2TWFvZHI4anBz?=
 =?utf-8?B?VWNuRkxEaGk1MWw3M053cTZlWFNWbXV6WjNNRVNqZjFzQ0pUNFcxbEJCMEph?=
 =?utf-8?B?bkxlM0VjRDVaQXlITndBNW9LMGh1Z3g4K0RyalR0VFg1aHV4QlZiZXNYNVpk?=
 =?utf-8?B?WFNpdEduek9yQ1k2dEVxcE1sQy9UUnlIZUs2WXhBc3dsUDQvNGFuUnF2YXdZ?=
 =?utf-8?B?K0oxVno5TWozeEVxanlHOEkrRXU1b1lqVklzbXJqQWZ6SG0zcUR0cFZJSTNk?=
 =?utf-8?B?K0VVZVFsV1hiNEhLK2pnWnBIbk1jMHZ2bDVrSUhiNHN1WlY4aW9QUHZnMWdE?=
 =?utf-8?B?eWcyZ3JHNExRWjFkK29adVl1WndkU0VDZi8yN2UvV2Z0MXY3OTUvZFJtYUxj?=
 =?utf-8?B?NmkzRmxzWDBrZ0NiNE5xTDJIcUdkWDQ3UXVPQytjSzJzMkpjUVoyM2JURGJQ?=
 =?utf-8?B?RmUzTE9jT2ZUSW9jQ0hvVzJ4UUlQQzdqVzYxQkJaUHlQQ0hyQms3L1JXOVhF?=
 =?utf-8?B?M0c0QVUwZE5SZ25XUmQrWk9OVWdYWFE2MjN0cU9wbEx1dGNqN2ExMndaRWZv?=
 =?utf-8?B?bk1WZERNeS9qVVZSaktyWlVrL3F3WHNxV0c3WVJpMmFPTWQwQTVpdytsVUM3?=
 =?utf-8?B?bnAvSDNBQnA2cEpkTEVxcjNMSmJtQXNYWU1XUmpUMFdsSHE2NEVzeitUNGtj?=
 =?utf-8?B?VnRmeG5vOFdSOUNNRFllRENJMlhtUVRFYU5lMWdOMzNjWWRmWS9oSnVZejU5?=
 =?utf-8?B?ZVc2bmJhRHBpMWFvRG9iK0RmRHpaN3hUb3dpM0lZYzJJalREcDlsVy9tSEhq?=
 =?utf-8?B?TEVYbE5XT0VlMkdJd1NjaFc1dVBXcjZjMVgyQURjYTFabk8vMkwxWnRHSTAz?=
 =?utf-8?Q?yW+k=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d041WGtWZ1hIb1pXYmZpMjRhWEhsbFBUZUlFRzVvSytYTnZhUTk5L2RNMHp1?=
 =?utf-8?B?UjMvZ0JuTGZhKzE0QzR6MFhhalBiK1A4cE9hRGd5RXIzSGZuVXZqZHpGU3Bo?=
 =?utf-8?B?WCtLV05CU3RiVnR4QUdqYWV2WXRwbDFyMjNiSmwreGliZ3FEbUlzQ25sc09r?=
 =?utf-8?B?dnkyV0M3WFJpVDY1R3pZbWNHNWM0L0YxbStRR2ZucWZVblhxd1pNQzg4aHgy?=
 =?utf-8?B?Rklja0ZYVlVDSFR6V3NiL1Z4U1krT1lnVXEwT2RiZU1UYnc3QkNNZXpCZWM4?=
 =?utf-8?B?SXk1NW5GRHZsRWJWekVPVWFUdWhZcGxsVFRjVVNpSmVSRkVTKzZRNEovbjll?=
 =?utf-8?B?dTBBNk1nN2NkOHhlR0o3Q3Z2S2F2UEI2N3lETWgwOE9TZ2JENnhzOWkzVjZI?=
 =?utf-8?B?anhIWjhLZlVGMUxheVVZT0ZPODlqY3ZOVVQwV0RiV3NwNmJSck14VHFDT1Zy?=
 =?utf-8?B?WVZoa2lMWTFENnQyQWoySGh1dWsyVGNram8xMFJnU1dRejNzY2p6UWRHVk9T?=
 =?utf-8?B?bmoxRWRaMDJ3UU1aMkk1SXNYQ0xCNzdmVUs2bW10QXd0VXRQejlPallIWDVG?=
 =?utf-8?B?NXBjMzFXTS9BUnlFdGlKS1A5N1llSm1GY0NNRURqRm9TR1UrNXZkcVVNQ0dK?=
 =?utf-8?B?OS9wVU9SWERGM2xpREZ5am1oWWRSaGtxOW5pVzhjb0hJcFUyQWxBaVpDR0FG?=
 =?utf-8?B?cDI3RUpWTHk5UjZISFBaK0tBdENjQ0FvQzdIcis1SkMyenJxelVES0VldjZu?=
 =?utf-8?B?OWFKejZlc2VWSmlzT1E5TG4rbzJRRUYzWWJka09uUmNrMG9xTkwyMjNwRUVt?=
 =?utf-8?B?MVZPZ1BLTloxQnpYemJvaW40Q3BmRUNoOXZmYml5N3VxRGxnaG16K0ZnK3pz?=
 =?utf-8?B?c3hBRlN6ekMxR3BLMTJHSGFkYjN4cGs5UWRSNll4RWNUSTlFMDJMQ2NjbHVJ?=
 =?utf-8?B?Q1BmV1BHUWNzZUJlcWhnY1Jia0gyTXBURkt1NjZhTVhaeklZSmdyaDRhUFF2?=
 =?utf-8?B?Yy9sRHlTSUErM3ZjcUZFVGVrSG5KVkplSGd2bUZsbmJDTDEwbjZjSmNiVXcx?=
 =?utf-8?B?TWRwL0tuZ1Rta3RMdXRpVUtORk1mN3JJTEJtRG5XYkxTOHJjRUUwNUFxRHlW?=
 =?utf-8?B?RVFFM1VuMXRmVHF1N2V5WFRkeVNFM3djRFByY2tYR3hOeVdqb3V2K0xTUDQ5?=
 =?utf-8?B?RTczY3FORGlhWDJzYUpESUo0YWpsSDVSMkk4Yk8zMmZIVngwMi9SbmFkcHNO?=
 =?utf-8?B?YXVSZ1dzK2ErcHhWd20vUkl2Wm5IWWUvZDBtdEE0ajFRanVwVGZWdHEwckVI?=
 =?utf-8?B?eDdlbTllYTBUem5HQncxL0lKMDUyN3d3a3hISFZySDNXK2VaZWlwdFM5VG9M?=
 =?utf-8?B?aWhudEtKdHdoUk94MFFRTVNITy9DcUN3clBSOTlobUxNNnhyTU4wNkppaHNh?=
 =?utf-8?B?NjhjbjMrempTRUZxeDkzSnVKYWU2Q2ljaDltQ2EzMXczTHlxaHRrOEhNTjNX?=
 =?utf-8?B?c3c1OTFJUTJ4aTRWZVF6YXpNSVVKRTFtNm5ncTFSMXROVnpZQi9TZzd6aGJR?=
 =?utf-8?B?dWw2MitrNlJtS2xGK01MRlNnQXZIVjN3RGRPNm5KY0kxUG5mUUdLc1lpbmgz?=
 =?utf-8?B?NGkrTXh6c0lNaEx2eG5WRG9iMDQ0Z0RBdWQ2dFc5TEQ1amQxRVUyNGd3V3Zw?=
 =?utf-8?B?Qi9yRGdUMjlHVTRrUmp4N0V2Z0Z2bnBqc1E4eTRqOWNSYW5vN1c1K0hsNUxL?=
 =?utf-8?B?cVQyNE5raDRZN1JDZGJTZHU2TzBSOUhocHhSVWlTNUZOdWtoY3hia3QzNkxN?=
 =?utf-8?B?YW9HbDNFOGc2dWJvZEZNdmFiaG8rdmlwbE1zWmEvSmlDY3cxZ05OTHRXSi93?=
 =?utf-8?B?Znl5M3hKVENVeDBDWENQK0VsZjRBRG5Bb3BNbTRYZXhaYVNmcjVnOXFLTGww?=
 =?utf-8?B?OGZxSEJFVDVoU3VoTjBhWnZ0TU5BQzdqanhHcVFFWWkweEEydmdMeDRmU3E1?=
 =?utf-8?B?SDhJNklHNXl2cUl3dk40UlBmbjhlU2hyK2hTWWlhWFpZdFE3eU03ZTVQS1oy?=
 =?utf-8?B?ZmxRU2tPcEh6ZGp1UlVWR1pxMXh2bTJ0eGtwZWhvZnNBYjNpWFU2cUdPNVNz?=
 =?utf-8?B?SmNxbG9OdjFCWkxPUmpsTnAxaWNxSUN1NlM1anh0ZkxKTFVYSElkWjNBa2JD?=
 =?utf-8?B?QkhuZTJnc1hoR1ZkOEpEM2pnblFhNUtWSUZ6cVlJb011bXF5eWxGWFlrSFpP?=
 =?utf-8?B?RUtMb3kxWk9TZHRkbDJ0cHJoVFdOSERjUy9sQUNLd3FISFZWMERkVnFQNkc0?=
 =?utf-8?B?VE8rWVNnc1RCSnlCRTREWUlzNzJ4TnUxcUhtZ3AzZjhvL3BiOEUwN0wycEFw?=
 =?utf-8?Q?HSWd+UNRw5zQnrx4=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3f364b-a25f-4978-b2bb-08de68124575
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:34:42.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNEA2vpghat5Mo/1oEuiFYLgZ45BKiI4+Icjuld45Xp8W2nwIimgqShYSQUFxsEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5483
X-Authority-Analysis: v=2.4 cv=OMcqHCaB c=1 sm=1 tr=0 ts=698a36d5 cx=c_pps
 a=wUQTFLLo3/oASVCpA6ZfNQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=70PAHqNgdiRv26S4SD0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wZWO2Ka4tpbY4AiyppB03EaGB0McYl6a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2NCBTYWx0ZWRfX+KSaW2I22w2J
 eY30ph7rhSGdMl+IwIO7/y19Ylfrp+yS4x4G+xVD5H0SZDiRRs9X/OjyD2FESujUZNOFe+Xgjjr
 20DoI5Dyk7ledtIFywSQfE22rlHsFoTH1VPNGtrpnOPk7i5/D82gBsIEuyhdgdLc5AoInzcLblQ
 OyPeve3j0W6DGoGiDGfqBJ8RMv8I6lMDPBXBQovRaJ/1upA6+g1FtafP6COVcyIuszfyXRVyKjQ
 0BXsqC+wTIHeJ+ikZMQxUkK1oBqfoL2ZyAc93N5D96d2uBXwqs/JQzFqVOH+MLq/F0XfKHOFlsQ
 pciMBD0NTfU+QwAEu11nvypk/sJmflUhsuaekrA6ZMhCdHYSs4swSF4qy9LYGt+VGOiQkGMJTfT
 iJSgHENfTvdFB49p6NiTl6tAWgFzIwmtN7s7K186GgkRAhlZXrLwrny1Mb0SahzCPGg1soT8lar
 5d28hE6cmMt2kmANSzw==
X-Proofpoint-GUID: wZWO2Ka4tpbY4AiyppB03EaGB0McYl6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-257983-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pp_params.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0C019114280
X-Rspamd-Action: no action



On 2/8/26 11:12 PM, Xuan Zhuo wrote:
>>>>
>>>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>>>> +			     bool allow_direct)
>>>> +{
>>>> +	if (page_pool_page_is_pp(page))
>>>> +		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>>>> +	else
>>>> +		put_page(page);
>>>> +}
>>>
>>> Why we need this?
>>> For the caller, we should know which one should be used?
>>>
>>
>> This was after some feedback to unify the alloc/free path checks in v4.
>> But you raise a valid point - callers already know the mode via
>> virtnet_no_page_pool(). I can simplify this to just call
>> page_pool_put_page() directly, since virtnet_put_page() is only called
>> from paths that already checked we're using page_pool. Would you prefer
>> that?
> 
> 
> Based on my understanding, the big mode should directly call the Page API, while
> all other modes should directly call the PP API. Therefore, I believe it's
> better for each mode to directly invoke its respective API.

ack. I will move this into each callsite.

>>>>
>>>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>>>> +{
>>>> +	int i, err;
>>>> +
>>>> +	if (!vi->mergeable_rx_bufs && vi->big_packets)
>>>> +		return 0;
>>>> +
>>>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>>>> +		struct receive_queue *rq = &vi->rq[i];
>>>> +		struct page_pool_params pp_params = { 0 };
>>>> +		struct device *dma_dev;
>>>> +
>>>> +		if (rq->page_pool)
>>>> +			continue;
>>>> +
>>>> +		if (rq->xsk_pool)
>>>> +			continue;
>>>> +
>>>> +		pp_params.order = 0;
>>>> +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>>>> +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>>>> +		pp_params.netdev = vi->dev;
>>>> +		pp_params.napi = &rq->napi;
>>>> +
>>>> +		/* Check if backend supports DMA API (e.g., vhost, virtio-pci).
>>>> +		 * If so, use page_pool's DMA mapping for premapped buffers.
>>>> +		 * Otherwise (e.g., VDUSE), page_pool only handles allocation.
>>>> +		 */
>>>> +		dma_dev = virtqueue_dma_dev(rq->vq);
>>>> +		if (dma_dev) {
>>>> +			pp_params.dev = dma_dev;
>>>> +			pp_params.flags = PP_FLAG_DMA_MAP;
>>>> +			pp_params.dma_dir = DMA_FROM_DEVICE;
>>>> +			rq->use_page_pool_dma = true;
>>>> +		} else {
>>>> +			pp_params.dev = vi->vdev->dev.parent;
>>>> +			pp_params.flags = 0;
>>>> +			rq->use_page_pool_dma = false;
>>>
>>> Can the page pool handles dma with vi->vdev->dev.parent?
>>
>> No, we cannot use the page_pool DMA with vi->vdev->dev.parent in VDUSE
>> case because VDUSE uses its own address translation. virtqueue_dma_dev()
>> returns NULL, virtio doesn't use standard DMA API at all. Now that I
>> think about it, setting pp_params.dev in this branch is unnecessary
>> since it is never accessed. I can remove it, if you prefer.
> 
> If that's the case, then it is indeed a bit troublesome. I don't know if VDUSE
> has a better solution. What I don't like is use_page_pool_dma -- it
> introduces many branches into the code, making it more chaotic. We may need to
> look for a better unified solution.
> 
> Thanks.

VDUSE does not have a DMA device. virtqueue_dma_dev() returns NULL and
virtqueue_map_single_attrs() just returns virt_to_phys(). There's
nothing to map or sync. These branches exist because page_pool's DMA
APIs require a configured DMA device. I can remove the use_page_pool_dma
and check pool->dma_map directly to reduce state. However, some amount
of branching is unavoidable unless page_pool adds a no-op variant of its
DMA functions.

To bring parity with vhost/virtio-pci, VDUSE would need to implement the
standard DMA API, which conflicts with VDUSE's fundamental architecture
since it uses its own IOVA translation for userpsace access. I don't see
a way to avoid these branches without dropping page_pool for VDUSE,
which I'd prefer not to do. Open to suggestions if I have missed
something.

> 
>>
>>
>>>
>>> Thanks.
>>>


