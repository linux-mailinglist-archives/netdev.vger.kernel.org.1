Return-Path: <netdev+bounces-228849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61392BD51D0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9EFF351288
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2412E7F1C;
	Mon, 13 Oct 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K0hgfPoV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cAjsYdcy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580402C11E5
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373522; cv=fail; b=I8ixK1BhAb+oQRp2M6hOTicz86rT+FsBc2D/jAObb2ir+cidA+wMLFsv+T3Qf6FGVOhE/m0geUMxb7ugObJrZb7gYpzxtLDH9JUwZM4LcgD20vraUXjpL2IxWsQkHxxhBP36Bliro+r3Bt189hbWZbLhP1ZcEK6GFOSWhphsN8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373522; c=relaxed/simple;
	bh=cOUxmgSY1FUMiY7VeUAaesVr4xctpACHB59aIwKIsJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCx0RAA2bzB1ykaiB2/hjhkEHjz+Wz9/BmH7g40m219XVYj0T0hA4uO+8v2PE93I5bZryfalKs+mKYihLSbXXGcUZO5ARwocWEG58igNJrtaC/ykVP4QhUXTxiGhQw9akqYst3/klth/+4UXPPcNOE/dxwybaHIKbLjWl76QpTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K0hgfPoV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cAjsYdcy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFu4fZ002311;
	Mon, 13 Oct 2025 16:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=A9uHDlH/X51pTNwQvMqu7i55jog5KM5nM6tXp6tA5Hk=; b=
	K0hgfPoVygDhidWqaiScUECY7392lwTgfR/kpjBtCXPR+8HcUmMt2FE+YSN9ZChL
	sP9qy/Kq+SNzYflXwEBjDWMH9mmC8BvU4hEk+IfC3EhA+3pHb5wZs5xq/kuDEvjv
	cUHr7mot1goPegl/QlqlmqpgytvHjJRlKQpefrFcMXzpWvjF1PsjYXFspXekd25l
	fJ66r9/NNxDKlppYtDKMZSCaatokLyY23Ue1uezXgpRHgkGE2bHturp33zggwBpn
	BCQLNxr4uOjRAB+aYEF2wFKSikEOBNBDE0cJNJY/9yKSyho9O6h/PdQxTwbKv8oD
	nKHs7UKJRUWxngfnkB9QlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1q9rjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:38:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DF5daV017189;
	Mon, 13 Oct 2025 16:38:17 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7s1mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsoqQkvcvGHTNBvqr4fqVyriBr+JQzX4vroespC7ug0CtkvtL1xmeyNxjp7qSpmVHBKWbIQ1wr+3saGJZeJqwMFfs0fxlt8BAP3l0PwAx1vDziOoq0oFUf+kWXyBASm1UH/rJuhJSm4kC91b5TX+BmVxqZ9i14Qi8TakZ0obpNXqfVn5Ii3k2hXe+77yibtYpwVqMECSJGvr83NIVqEFrIaqWI+gcGCaH507sQbdoIR7figNg/9sh9JG1BHDs09wY+iNue2YbVE0rxy3UygkFhsjhYI9s2VS81rRFVOyhkM375Q0fIohTk2i/vGEmUJgQZEe537fet+jqcFCgHntaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9uHDlH/X51pTNwQvMqu7i55jog5KM5nM6tXp6tA5Hk=;
 b=uJY4QxjeLPu0ZAXcYsn1O5zIpUzr/mZnk0mWekaob9EgYYNcRBAjufr5N1ypJA1Qtm8WMXd17gXmgD0z9QxwDAwHxtIJHpIlIlCnEB2CL10OQLRR74iEOsy+pMGtgg0xkgMp3ixbeYIk4d9BpcCzsU0sw14Ph9QY38pEDUJHjcgcaVZNQxUDaIRJcnHf/35YZaVrNDPkH3b02NM3IAh42xXWp6/AvsXlvKY2dvW5NbF0veXy6gOs2vZP+0npLfBCgalnGshT9HYR/mdLOj1c1AG+F0Cvi7j85sZD7tX9JMXVRoIzYB+mud4c0fxbuccWtmFT01pH4eLcb6Jce9gq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9uHDlH/X51pTNwQvMqu7i55jog5KM5nM6tXp6tA5Hk=;
 b=cAjsYdcyvAFvJOAN4iRuhN9c5sYA24crkqa9wXWVhXwJEDbC2KtoxnBl6/ROXZe7BoJzqgMkfcLGcl8BKbw01P2S4H8JM3ZrTrowXtU/yIbhhK1JkkxhDbFGj9Ov8cY2iyBqQAMWYqMvMPsd8/F3ZTKWSQZ/mZqjfKUPuAONA2s=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:38:12 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 16:38:11 +0000
Message-ID: <d1720c75-3d56-4040-b7ac-97c399302257@oracle.com>
Date: Mon, 13 Oct 2025 22:08:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v4 01/12] virtio_pci: Remove
 supported_cap size build assert
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
        pabeni@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
        yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
        kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
        edumazet@google.com
References: <20251013152742.619423-1-danielj@nvidia.com>
 <20251013152742.619423-2-danielj@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251013152742.619423-2-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c796651-557f-4b32-34e8-08de0a76e625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TStpbzdhcmZpTlp2VkhySllad1J2STFSNXYwTkZTSFlwY2NtOFR1RUhWYjRq?=
 =?utf-8?B?SytGZXQ5R2NwMXF4emVST1FKc3drdk5IejYzM01BcW1DeG5MOElpYmtNYU1v?=
 =?utf-8?B?NFFhSVBXaXVseExlZVlLVUJkTFlpOThwS0UwdlJmMFUyTGZVYjFjdSs1dGhB?=
 =?utf-8?B?U1FVa1hZbVhtRkVhVTRDTTBzZlp1N05wYnp4YlBtK2o4TUwvOW9qbFBaQUtt?=
 =?utf-8?B?R1RxSlJaTEptcmtGQyt6Y2lBMVo4U3R4d0NWTW5FZlozM3FmVzVPdWxGdVdq?=
 =?utf-8?B?QzVIT3AxN0U0QUZGK1dSbWFOSHd5RFhrbGsraDRNR0t4NVk5R2J1cTEvSmkx?=
 =?utf-8?B?L0RyT2xIQkJYOGR0blpXNStMQnR6RW5pTFFqZXBUZGlGQlp5bnhXUmNsUjJJ?=
 =?utf-8?B?N0hDNUMzRmtGQzhZV2RGSHpZNjhteHNoNUs4VUZlNTF4SVUvcEVjMVZ6V2NZ?=
 =?utf-8?B?TEplSkRSQnFNNGlSN2p4bm80Sk52TldFTVM4Y2ZRRnhXY2RBZlZ4NkNRQmN1?=
 =?utf-8?B?eTV5Ujk1ZGM3MklmMnJ1Y0s4d1RqRXdJT1B4T2hWV1FhYVVmTUs0SHh4ZDVV?=
 =?utf-8?B?QmhnNXlqT3gzZWdPL0tLcmxRVEtwd0NGcVd1NkVFdFJVbzlkMWpNWDNQL2Rn?=
 =?utf-8?B?bEdxekEwSGQ5ckloVzF3S242V2l2ZzJHLzEvWHNHNlppRFJpRlFsSHFNckRG?=
 =?utf-8?B?ZzlRNjhMRDFVUi9Dc3Z0dmN4OEtFRm1Td3loNG5CVVJ4ZG94RHRUSU1CKzI3?=
 =?utf-8?B?QVNyT2pMc0duUkZlcEJydE9hbzRoSmVWRDgyTjJyN29WL3UwZTg5cmVES1BX?=
 =?utf-8?B?bmxaQkxiUjVrQTlkRmlBeXpPMTVCR2Q4cXl3Nmx1LzQ5VjdyU2FJTjJsWUJF?=
 =?utf-8?B?bUNLU3dhN0ttWnR0VEJIOFh5ZlpYTzFsZFp6eDIzYkpKT0Q1SUNMMmlpcUJY?=
 =?utf-8?B?UWxWTDdMZm9LcWM2TklZVHU1aGg3SWhGRE5FRWpJam9ZMUlrZVROOXRJem84?=
 =?utf-8?B?a1BjbzNoODFCMWM3MFBKNjd6U2dueUQ5dk1UdEdBUm5adENDRnJvcVpsWXZh?=
 =?utf-8?B?WjBEcXRISFJZdDBERzJVMFo3NnN6ZnVIMkQ1U20wYVBDL0Zvc01HdnQ2QlFk?=
 =?utf-8?B?dWtRS3dRQnRrZTUrU05lYlN2VExac0NHUDdiNG1qQkpWelM1VlBiRklvQXZO?=
 =?utf-8?B?K2hiVmQ2T2xyTmM5L1NBRUtRd2o4WDVoOG5iNEVMUzhUK2RWSlkvSFg4KzJu?=
 =?utf-8?B?dDhDa0Y1b1h0eERNdVdFWUEvVm1oQTZuL2lyYjlHbEZrWGMxSEZGd2tjbTh3?=
 =?utf-8?B?UjB0akhHT3FwcjNpaE5HWDJMd0ZBaHBma2VWNzQwWUwrbkkzVCsrdCtRWGFE?=
 =?utf-8?B?NEhYcGhaajIzSFFocHBCc1d1c1d6YmhOZ0hwRWJZR3UrdHdvclhMVFNCNGZO?=
 =?utf-8?B?cjA2QTdIcGJJcnM4N0ZYNlZNVHJKaS9BMjUvVit3ckF1enR5SDlDZVRoRHFu?=
 =?utf-8?B?YXZsZnkvRDI3THNnOGVCcW8zeU9UaXdYdkxJdWxxcFcvMEFFT2NLSnVhMkw5?=
 =?utf-8?B?dUgxRlZpL3VWTm9wM2xGOUVLOUZTckNScDRuN0tiSzZTd2hPdmM0TDc0WW5m?=
 =?utf-8?B?KzV5QTR5NEt2Mk1qUVBjUXFlVlZkM01jVU9qUkdwSkNGL1c3eTFPa3NsWXpI?=
 =?utf-8?B?Rk4zWllPelNVd1hGMXRDR3NkZmVyWGs1eTVnSE5IZExiYmc0T0l0UURhcTdF?=
 =?utf-8?B?UTN4V0hsU0p4ZngyTUVPUEtSOWo0dC9hQm9nd2JsVEhrQlFnZVRGeWRvdEk2?=
 =?utf-8?B?NlNIMGx0aTBGSUVlS1lSVkRjRzJlanRMRjlnRDE1MjVHT1MzQzBZMXNFMzRB?=
 =?utf-8?B?T0NBaDEzSmFWV3kxLzY2cVN0enlSVHRTSUhkR3dseXBLOUYrVm4wUVdtVnd6?=
 =?utf-8?Q?0WCZS+sKC4YCOB0ym46h2RTAMgmJAKlY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnhGM0tTSTRqM29BUU5CdWE3SEVzRmN0Y1pIdCs2OEFvQlNDdHpwMDg3a0d1?=
 =?utf-8?B?eTZnZE5tOXErVGFCcHZHc0s0T0pXWitTb2xFSjVLd3pjOVFMR0RsWU1PUWY0?=
 =?utf-8?B?aVVDTnI0aDloUGZQYXkzeCtuS0prcUc3amZwc0NpU05pZ3VLVHhhU3AzY0h6?=
 =?utf-8?B?UGdReHlrZVlIN05qY3NyNU96TjBNWnNpUVVWQWlvUmlBL1VKZ1dlZXZ1RFlv?=
 =?utf-8?B?Ymw0WWl3L3FxVXBYZ215aEkyNkFoSmNNOU8zSEhyWDNreDNXUDlyVE5VY205?=
 =?utf-8?B?MXNSZW9oRWZuc0J4YmRrQWpwUjJBeGRqM2pWUXpmVC9DbFRWUTRiYzdLK2tN?=
 =?utf-8?B?OXltVUV6cTV1Tmo5T1BHZTVya095ekYxWXlXRWxqR2lwOWh5M1VnNEJGNzMz?=
 =?utf-8?B?THAxWE9hZ0pZdHN5NXpORGJDbGNiK2tWaDl5anNhc2cvUitUemFTbklSVlgr?=
 =?utf-8?B?TEE1VmFsakE1NG4yUVBrZTlDKzYyQkJIMDhaOWljeTRFRlhkMTNkcUEzd3M4?=
 =?utf-8?B?UDBpV1J5bTF4ZmF4U3ErTGdpY1dxbVUvdjd0clFyRGZhSGx1OFZqZ2c1UkJu?=
 =?utf-8?B?NUhzSzFxSzhRV2xYb1NWN3VxVlJ1ZVdmcXdMZ0d6Nkg3YVBiYVZEdVFORE5F?=
 =?utf-8?B?MzBCOVIwam9vbEhDTGxqcFlMRlNlMzlDWDI2c0dPbDRMNDE3QUlGZnhSTExZ?=
 =?utf-8?B?UVpaQWxjeFA0TS9sc1d0RFErQkRBUVZ1ZGlmck1SNGN5anVybk8xZnY5Zmxn?=
 =?utf-8?B?LzRZVXpvR1pMWmtYckNRRStTV1Z1KysrWldKaEJpOWQrbFhFbVhHTkdlcEZt?=
 =?utf-8?B?YXVycDczSlRtS3NQMnB0VlFjbGtUMU8vSktpN0o4NHlUajhtSEV1UWFMOGlF?=
 =?utf-8?B?ZW9nVVJxNTdiQXBGYmV1S3NpYWxTMUQwUEIweG8vSkZUL2RDcjJZWHl0aEdC?=
 =?utf-8?B?N1Y4ZTBuS01idEhJQ3U0cmVtTXNjeEhHSjE5aHFIWkRzTkJVMmUyQW8zN3kv?=
 =?utf-8?B?ZVZLYmg5SHVBc2EvczdJNS9zeURneno1cXZRdzZKdGlOam81dC8rVndzTlB6?=
 =?utf-8?B?djArbnBhZVlKeFYzaUw0RzUramlPd0xkM0dNL2hsZU9mVjRwM2c2SHpabjVz?=
 =?utf-8?B?MHJsblFBWkpaOTV0NjVhMjU0K1RoYUpJMkxZSWpNN0h4NTV2WFZ0c0QwczZG?=
 =?utf-8?B?RW5FaCtuM0ZSai9nL3BwZlZ3NW9qUlQ3SzByOGd0aVdpNWJDU2hQZzZYSG00?=
 =?utf-8?B?UVU2aW5teVJnTVFLZU1yRGx5UzIrQzFudENaeU5tb2xFcmViakdHZmNONHda?=
 =?utf-8?B?VEM1Z2tZK3ltWCtBZ1I2M3Z2QVF1N0x6QXpLczYyVnFKU3Y5OUpOUVVzS0hP?=
 =?utf-8?B?LzRsSnIzWnpXb0FEOHhQMVNEd0s0MzhkWEpHbHNQbzNzTEovR2w0MG9LSy85?=
 =?utf-8?B?UFpValB5SlFUQ0IyS1MwWVQxbE0xTU91d1N2UGtLUkMvWVdJZkIwSldlQ1JL?=
 =?utf-8?B?WWRaVDhJR3NtMFpQWnNDa0pFbHF1eURxS05DZDhuZjlMK3BvZk5VOFVxUUUr?=
 =?utf-8?B?aXhGeWs0V29ZY1ZMTjRFbkdjaXlqZ0VhTEFZZ1J6djJkR1o4NTdQb1pDMmF0?=
 =?utf-8?B?Ym1RV0JXNjdVWVkzSkdSL1lkenpsVFQvTThUVmVKR1VYZ0Y2bGN5Yll5Zk5j?=
 =?utf-8?B?Q05qYk5pVjIxUlUrSmJvRGhFRURpVjZZeERzWWhCcm1jWWdKVkNSRk42Risr?=
 =?utf-8?B?MHNSaG1yYTgyZjBFMkVzMHAxS2pTcUFSajdaQVRVNEY1K1VocDQ3dFBVQ0pn?=
 =?utf-8?B?aEF2by9FeTlZUllya3dZTFFweDJRN2h0NnFMZTREbVVZRitwZHNuM1FWaWFr?=
 =?utf-8?B?Y1VKWEU0QTI0WlFMTnZZeFZnZmZzMnNIdFczaHRhTVphK1labVhtenZSSFRs?=
 =?utf-8?B?amVKTXN0UG5LK2VNV044U0daWnpVVmFpbExTa1ZIZWlxa1NWdVZuelc2OFcw?=
 =?utf-8?B?TTJodkRIMVNyTkFVRnZ6T3hCeVh1OExhOHo2VzArMGxoRVNKY1RndTZ0TmQw?=
 =?utf-8?B?eFNVMkFPOFRYeUp4Q0xmeStHdzNnQ09CZmxUNVhBa09yUXZ2WlNZbENMeEhC?=
 =?utf-8?B?R0RWSlJpYVdaT0ZheEp3QTMzcFhyMmpUZ0dFOHFQQlpYU1BibnFKMGpxK3FG?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E8nhtcC4gDDyzlJY95+udiovSH9Efg46/lvF4tKUTahQfT8gN+kMloqO8EgQInIvwcawSkE9wT3ONUjvoVGUKMq9XPVjauPFAXVPX1CgBHRqihyXytPCT3jWhWNI4shYqXCbrUd7ErTuFYsgaNVxpqWwhNI117XtL3Z3xwbaCdi3WjrsiNBDpP/lHNmh+BBNAhFluB8MB6NQnotw8vKRQSIg145gumW0IZonjz+Xf5O1r7L/HH3Jwesuik5ZSQCPsvAR35NxQguOJKtBrLTsnLDBKU7x1ZVwrMI6AVu3jqUekI9qxHiqwBoX/W86H8nmVqVY1RzP47FQmVhykxnS2E/jIIehxvnDX7g+GxWNkKkdk2SQ1hIn9WQ5lW/qfB4YGfhLiYGREfaZQxbG3Tt/2TmcMpcMUMsj5ervAptZYjVpehQzkhQdu4sG11E7FeQrsLkS0/zMIQDO/Whq9roU9RQLPkYrYZ5JZ3bx/bYdAzLsQXs5UoTf+cLbrw0L96gINuGbPdEsaFFt+jTkI63ce1YdSL6GG829eNMK0olJBmYcY64byFtH0MQeJd4E0L1U2I/GTzYPOStjSUvmf0ZJZveos6lFKingQVUuSR5/B/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c796651-557f-4b32-34e8-08de0a76e625
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:38:11.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Roysb6ajOow5R9u5himTXfAp5ZSvIXxnd16T2gkhZ3IyY6vDYxf8/oSIzA6QU7NiprRTuGwjomL2BY7lzbutxCmXgE7n70CMrg8xJBk0rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX+yXVRagP7HXk
 Dm9aJ7mNKemyBZkm2qHxM0/M5s5O1azDMx4zrOYnr8LYDBBMDWttMy21Noj20c18WlYfTu+GtHq
 sAKQtgkW755gjfa8gR/1AjmB2MNsVcNW5wyVOSz+M04HKlRhkLc9MDfOC1kLYUxELh7LnQubmBv
 E//SWizRpMaqW13IxGZRDfM7dJboDB6FPGwkamx4jVqEcYOJl00o014VvcUXDF6gBysb6gPMybY
 NCXa0i6bo5ALK/mbu27vW1PQ6L4nJnYT1OvhrjAEgHT8d5HRJHYRut/Q+23gN6BTVNldWU6SSdl
 ajfZ9vsyJ4R/bmVIN3cN3HPYrVlt+NesrdefxTFIFig5qkeahmCVo4w8J2zcmr3ZcquaDu93GSm
 GSBR/mhX+XcJIJ2ns/Q8iAaL/hlPZQ==
X-Proofpoint-GUID: QWyb2LVnMOxNKzFb-GMnQFNUP9MHWem2
X-Proofpoint-ORIG-GUID: QWyb2LVnMOxNKzFb-GMnQFNUP9MHWem2
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68ed2afa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=HKRX-FWKZhdXDGs6rGkA:9
 a=QEXdDO2ut3YA:10



On 10/13/2025 8:57 PM, Daniel Jurgens wrote:
> The cap ID list can be more than 64 bits. Remove the build assert. Also
> remove caching of the supported caps, it wasn't used.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> v4: New patch for V4
> ---
>   drivers/virtio/virtio_pci_common.h | 1 -
>   drivers/virtio/virtio_pci_modern.c | 7 +------
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 8cd01de27baf..fc26e035e7a6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
>   	/* Protects virtqueue access. */
>   	spinlock_t lock;
>   	u64 supported_cmds;
> -	u64 supported_caps;
>   	u8 max_dev_parts_objects;
>   	struct ida dev_parts_ida;
>   	/* Name of the admin queue: avq.$vq_index. */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index dd0e65f71d41..810f9f636b5e 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -323,12 +323,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>   	if (ret)
>   		goto end;
>   
> -	/* Max number of caps fits into a single u64 */
> -	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
> -
> -	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
> -
> -	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
> +	if (!(le64_to_cpu(data->support_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))

typo support_caps -> supported_caps ?

>   		goto end;
>   
>   	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);

Thanks,
Alok


