Return-Path: <netdev+bounces-235586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFFBC33052
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 22:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 469544E133A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD02DAFA9;
	Tue,  4 Nov 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WlcpvUjc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zQk1GzoK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15C1A9F90
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291437; cv=fail; b=Wp/dTn7tXfOEW013O9OS1D7BvMzOjGboZqXDV/08J4UW8Zj/hpddhkWIIoS+7ngodPvk9NTULL1DMKDa17MTcsvroZHPTS+d1KFwhohn6cLUUEZ/pwYT0mH1VnzIzwDwqGRKfeQCtWyK7jpO3FMvYGMea43HPJVsn+pCNv+YoTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291437; c=relaxed/simple;
	bh=hEywtKuipInBRxOx2LVLDEOfYaxMV3cXQzSmXwPOmsg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/dQf5zdNTWH0rmbxciTIiOgl9xtsbwsXG7jb4tZw+XppJOSeRoun2KT3o6bfGaqjIuxjLA4bilOYf2cB3XVxRMc3YVmEiZqw4AfveNYyD5JtndWD0nUHFaQLQ2gx7ty/zxuGhod3IM5IhhcM2QxcGigj5dgGxB39SCtKWcsUVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WlcpvUjc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zQk1GzoK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4LJIwJ004184;
	Tue, 4 Nov 2025 21:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hEywtKuipInBRxOx2LVLDEOfYaxMV3cXQzSmXwPOmsg=; b=
	WlcpvUjcWE74x1P7hfUFUwbBCl4F1ofTtARcj2V3XTsIvv1myNyZyQr/h7E2EHZG
	dMq8BK2in6vl1FeFGZf6HS2RJcJP6sQgtGyKUS7x9ppZVH74Y8T1FztuHkCjO69N
	j9tzFLJy8Kbv9zGmmenkAAun4XJl+3RPlgPWaFchU4rDRROcTyjkI6Fd17qBKQ2/
	wcnczJIqL7UFnqZ40YQ/iiC1P+NqfSBXX+Mi17q5NbrALsMu9m666aRPQxKIAB4B
	ecaESZG2tfGdcfg+phZsnCiW7G7Wb5k5k4IMUSAcDZfMNIE09hB+5Fwlngv0yQwi
	6cFMFHGCkWh4RhCMydsJ2A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7sa300hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 21:23:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KMhFx019459;
	Tue, 4 Nov 2025 21:23:49 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nkxtpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 21:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuuDFYEYHvOnJ7yUXKFhMNe5grqPCQckaX+M03peCQ54HEv/nt5ZVBGpswyEfwJJtKq2+P9u/0r/RQbQkgUOrDJU671PUT3iXcIgwwCK+aIXZIyc7kaYymfECcfa0ZyEYaIOG8AUMk6MCs+YNkP031o/MgHzo4XDPHXKzm/PlDziCCwi7648PAWo3e3whg0ylegKemB1JT6q34GpR2dXLio3UGTj4z8qFw7lNCGpg+5mYIdsWQXQGJOrCA6Ivzhucjt5PMrk5fywdx77Zj4OtXo9LirSjlzMi/4ObrHGdSMH2H1fr818IwX9HsZYmN0LSGf+Q6iCn2qWhiX7Wp8mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEywtKuipInBRxOx2LVLDEOfYaxMV3cXQzSmXwPOmsg=;
 b=EUlwqMXiOqNLbrYypWuDrgypXNuJS7dQfaF+iq8XDGRIzW0yiuDSgzAu1cPc2r13wMjwyuDrzrLVwMshuV+AZSk5Cezst0QLe/Od0GI1Z/Fxr5eRfjte0rIMFC5BDtlHfxcoTMbKwpuOgi9mF7mnPbzANlAq8WpK6KIOh3oY1/2MDOc1s1MUKhqZ12kiv651wg4VSgifvPpGeycjWytdOYDhG1RcmEToy6ZosOV98dgAeeSEMuPtDAlQ9EosCWPWps1qrGn76TCa0WFWXtPvKQmP0W5VsKx8E+UmdeCIW9nkS5qxY5cwbadSgZJPD4YZswfyceFP3VGMilMztN3dtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEywtKuipInBRxOx2LVLDEOfYaxMV3cXQzSmXwPOmsg=;
 b=zQk1GzoK5Z9VuYGdMlc67y47B9V7icgrBnpuSFxv9DEl1kK8xWE5oKSpDJcUarMfuHi1/FEQHl8SUbrH4CU7CUWXidNCCtP5aNJRNcyL0HTbx9JtCsfbOlQxYOFb53Ru/E4zkjTA7ofUhZwtm0yijqSuKSxkNqFGCLOTjglzSHY=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 21:23:42 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 21:23:42 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "achender@kernel.org" <achender@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net/rds: Give each connection its own
 workqueue
Thread-Topic: [PATCH net-next v1 2/2] net/rds: Give each connection its own
 workqueue
Thread-Index: AQHcSPvuwmtUpoPbYkKh0q6G3DbkeLTipLGAgABr7IA=
Date: Tue, 4 Nov 2025 21:23:42 +0000
Message-ID: <68454b958581aa1d085678b3b6926318ee5754dc.camel@oracle.com>
References: <20251029174609.33778-1-achender@kernel.org>
	 <20251029174609.33778-3-achender@kernel.org>
	 <0bee7457-eddc-493f-bdb9-a438347958f9@redhat.com>
In-Reply-To: <0bee7457-eddc-493f-bdb9-a438347958f9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|MW4PR10MB6324:EE_
x-ms-office365-filtering-correlation-id: c24aac5c-1931-4624-b074-08de1be86e1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VithOTl0ckIwRzZDZXl4aEJCMUgvVk90NHcwUjZDV3ZxdWNUdmpveVpOV292?=
 =?utf-8?B?aVNnOEZ2UGxJQ1lIVXo0L0hneVhZUzYyRllzQjhyZ2x6WFRicktLZmw4bnFP?=
 =?utf-8?B?a091b0VtR3B6VFRDL0cvSFdLcjViQ3F3TEI1TDl6ZmZob3ZJNHF4Q1FMR3Q3?=
 =?utf-8?B?Sk9BeTh1Y1VVUklyalRNS3pubEovdnJWTVQ5SXJHVkpKT2hobk50SW9QUVZZ?=
 =?utf-8?B?RnQ3QTUwKzNQQnEwYjdBVGk2OEpvSWEzNkY4Wnl4cndKalN1dGJuTWliZ05a?=
 =?utf-8?B?cFRuZHlyRGpsUEJIUmJrcWducWhQVEpPNld2NnR3c0xXNnlFQVVneVF0OG9N?=
 =?utf-8?B?dHhldGhPT0lwM0t2WE5jSnJ2M2lWT1E2ZWVkZnFGa0RHQXk5WVNDY2RaajZ5?=
 =?utf-8?B?NEpvMWZjeGtHaWJKMlJRdER1b3VBbkhpR0ZkdTQzSXA4VDJrcVozQ0c3WWRL?=
 =?utf-8?B?dUJneWwxdTA2WXpSZzgzQ0haWmVZSklHWUtoMmFDcUlSRWdXS1R5UEtwTzNo?=
 =?utf-8?B?VHIwa3J6VU1PTHd5UjFsNWhCSEVhTlBsZXd5cDNJUEpsN1p3ODhjWEoxWFVM?=
 =?utf-8?B?b05IaldUSmd3L3JhODdEdUtRM0tVUEhPSHVjTnNQWk1DdEtKeWkvWUdTL0ll?=
 =?utf-8?B?Qy9kVlZsam5TbkExb0F1dWNoTkFRTGtvenc2RmZUZ05lK2s5cXdJZVBPNUJI?=
 =?utf-8?B?MjdGcTdXbWpZbUtDcGNacUkzVzZsNGx2WWhIMjYwNmZPc1JYV0RwcGwzdHd5?=
 =?utf-8?B?NWdxcUIxMHJNQ2V5c3lNZFlnYU5mUi9xdC9HallYRElmcklVbHpvTm1NNEN0?=
 =?utf-8?B?WHhmNjVMN2pqdm9ROWNsMUdNUjU0Yjg0ZGlYSkl5cDFRbm91WHVjZGZjZVJn?=
 =?utf-8?B?WDZNL1A0Z1p3QzZzWU96UUN3ckZLdkMzTVdmZ1dGS3YyM2pqM2FVdHlmNWZa?=
 =?utf-8?B?M0k0Tk40OW1aSFVhMDl1RnJZZTV5OUJhU3RFKzRXYm5HeE9PaFBMQ1RZOCt0?=
 =?utf-8?B?QStuQVFmc2t0aEFyaGNSbUJ3ZWFyVGlqWUZPT1pNMzNMMFY4ajlBOHRRM2hU?=
 =?utf-8?B?MWlHRzJPYitvUVB3RmFkd3JzUnNiekpYbjY2czdMdWR1QThCaW4rS01EM1Nu?=
 =?utf-8?B?SHcySVZSYldOZHROK05QZ2d3cE1GQkIwb3hSazNOWERGOFI2ZFdsZFdaRnFm?=
 =?utf-8?B?ZTdtaXVmSDVpWjVTMUN3WEhrN0s3M3ZHSkVDTE5vc3VOSVJRbnRqcnJleWwx?=
 =?utf-8?B?NzRCUkRKTldZbDdjc0Z4czA3Y2ZOcmpiVG1qYU05WnFvTUNCMWZ6d0VTMEU1?=
 =?utf-8?B?TUVQTkY5bXRoTjVqZGV0RGtKdFE3QWRPaVorT21SV3RDN1V6d05lTGtQbWlj?=
 =?utf-8?B?clNOeTUvWEI2TUxpUlJjS1UzcGYyekREeWFQUnVVZjRZSHdQMXBMakpZRmto?=
 =?utf-8?B?bFJjZStsZGZjc0o3SVFrdVZ4ckpZR29LWGF5ZjdBRUMvMXVsSDhjMEl2N2Fj?=
 =?utf-8?B?MEtHbXM1OFVNbEQ2RFNYNFNwTFd1aXlXc1BHbitoMlZvaGN5dUJLMmVBb0FT?=
 =?utf-8?B?UmNIREg0SkdPanZuU3FRbURWTzU2dDQxZTZmclhaeG45T2tZWXBtOFMvekZn?=
 =?utf-8?B?ZEQvMEFxRXU5Q1dXZW90Si9wT0c3bkVXdDNMZTNZT1NvazkxRVBxWmtpQ1hZ?=
 =?utf-8?B?ZVlIYjkwSXViS2VmM2pCS0g1ZDlLVFNWT2JzTmFDbUhaSTlDaFAzNUxtTWpy?=
 =?utf-8?B?TjRmTk1Pcm1zQUM5VFgzbHZyVmlUTEhIRjBob2pQWmFjWVR0OGw5V3lIcE01?=
 =?utf-8?B?MGFxUzVHKy9aTUdOWCtUSHg1VTNWUUUxc2tYTE9ObUFsODJ3NHFlcyswU3hu?=
 =?utf-8?B?aFZjMVZvMURkVHJ6TE5uVnR3NnV1eDRVbkhpZ3NBdVNrVVVLZStReHBqYWIy?=
 =?utf-8?B?d2RTbHdGdS9YOUxDQmZINVlkTmhEaDFvZjYyNFJlSzZlZjM4U2JZTmR3Q081?=
 =?utf-8?B?NEdSdFFnYi9FQ3hadHBTeGdOcWtnTktsdDdBTnYvczduQ1BQVElPSThuZ2o3?=
 =?utf-8?Q?XmbeAe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDlaVHlYSjAxbXN1alVvZEpDZ3lRMWNEWnJYdzlXSXdoNEJVNHl5TmI2dTdX?=
 =?utf-8?B?VG9yU01iSTBDNzArdVVKcXBrMmhhNEFtNnUrT2VpUTV6NGZER1lFQVdRMVdX?=
 =?utf-8?B?MmlBNDBuZy81VWUzNGRSd0N1a1JOQnloVG9vSDVsRHlEZFMwakJnQWVlSlJ4?=
 =?utf-8?B?NXo1Vkl4V2t4aW1qUFVQOEJVb3JDSjlDd2U4QXZVSUlrNTJsRDRzRmVLdHlJ?=
 =?utf-8?B?R3dqTHU2NXRxM1ViMHRXNWEyNjVpNm5sQzZQRkFNdUtrbGpBWWFUaUNkZzJT?=
 =?utf-8?B?by96b3Y3bFV5Zm9EQ3RQaU9iVjdBMFArNVpWd3kxWWlEelVIWktwQVYzWS9x?=
 =?utf-8?B?MzExL3ArZFVZdDN6U1E3ekZZMmpFRTkzMnZsRkRpbzQ1cXVLTTdmL2wrd3ov?=
 =?utf-8?B?V0lLVHFnNUlZS0lzd09KZ1JXcTc4dk83dkNvNlUxQkp4YTVlR0p1aXRZYS9k?=
 =?utf-8?B?YlFZZi9FZ3JqajV4ODlVejdRbWdMaDZHQzJ2dkFWbXRobTRCY1pqZjdkVjhz?=
 =?utf-8?B?YkxuQjk4WGxhR2RvNkpBNExHN0hUVFgwRTVZZDdSenBXb0dFK2E0TDh3Mmg1?=
 =?utf-8?B?RmZTN2N0NHVaalpzLzZtSE9CQ3VQd0lvOW5ST3N5WXZiUXhweTRxK3JnNGJ3?=
 =?utf-8?B?TGttK3B5NUlpSWtDMjQxSW92Z0hnNktHTWVjQ1hpOTRrRDRxWlJPa1Q0ZUgv?=
 =?utf-8?B?RU1NcHYvOFNvRG5iOWVPZVc3S2ZpWC9TMDZBeVFHaXhId0dIc041eEErV3l5?=
 =?utf-8?B?N0dEd093WnljYjFGM3pGZjVSWnowTzh4YzhBRXluSjJqRVZZcFJkeEZLZ1Jz?=
 =?utf-8?B?bURpRUNjMjROb3lrWmIvRStOS1RuQ3pXTnhDQmNGcWNIM0tQVmRRUlZDVzhY?=
 =?utf-8?B?UTN4SnpEWDZGaTNmSVlSYUYxUzBjN3VhbHo5ektEd0RVRytGdGE5QTgxNnVC?=
 =?utf-8?B?ZThPOUtXQzA0K09KeS9Ca3ZNNUVNU3dVcmtCVkNTd2pjbTliTXNEcmtMS1pi?=
 =?utf-8?B?NkhDeVRjK1c3MFhxYmhrcWM0M1BRR2pETGcrWmpPZkRPbnpsUjBWaU44L1dk?=
 =?utf-8?B?aHptc3BTNVFhQlc3R01yZFZ2aHprZEZ4bThLSFBtKzFVaHg5WW5aS1BRTlVt?=
 =?utf-8?B?K000Lzh5aWxkL3g3MXphdU0vcW5NdU5XNzg4Vnp5aG9hcDJ3V28rSjVvUktt?=
 =?utf-8?B?aHJKd1dzUU5RbjYxQUxQWmkwT0tjd2hVdWo3QVZLVERYUENyNGRHeXl6Qmk3?=
 =?utf-8?B?ZzNLTFJYNjJiYS9pQnpRUlcxT1l3NkJnOXZzK0t3TXdhK3JOZkxwQXdMRGJz?=
 =?utf-8?B?OGNTQU9SRHV6dUhSbVdjZ3Jkejg3ZThhQ2R2SlhlVStzVHRPL2Yvd2RNNUFK?=
 =?utf-8?B?ZXR5dllJVjVzQTVjSjVGRzFpeVd2S1Y1cFpHR2w5dGpKbEQ0U3J3dmVtTEdp?=
 =?utf-8?B?U3JzWVI1d2IvVU9vbHlsSC9yYzRuY0c2M2FWRVJoaGJOb3RyRVR1MmtCNUw5?=
 =?utf-8?B?SE92QlhkaEtDZm83ZnJQZ2pWZnVjZWh0c1I1RVo3NEwrZmQ4OFl0THAzWFBq?=
 =?utf-8?B?MEVMaDJUdU5WYlljRUE4S1ZvS3dOZEo2RlRpb243TFF4M2hmYzAxcE1PM3k3?=
 =?utf-8?B?UUNzR3F6L0ZFZ0RSYTlueW5Rc1BuQW4xQVViTk9PWnpOckZJc1hRL0V5Z2tn?=
 =?utf-8?B?UG1mdFZHLzdrQlJnSWFBUDgrckZzb2pBeEdzc2gxV3ZjcEFTOHYvZFMvU3Y2?=
 =?utf-8?B?NDlIVFpaOVpBR05JNHZURFkvSFJLQlBFeFlsKzNpcHdIQ0dzYWZ0d2RNaVlE?=
 =?utf-8?B?VElEOSs0dnM1aHhoaVFLWkM4Y3poSy9GbTZUdXFCUkFSZEU1amIzZTFnb2s1?=
 =?utf-8?B?elpOMFBuRFhjc3FEYWc0ZGI5c0hoVUtON3ZMREp6cmJYQlNjck4rUW50OXJo?=
 =?utf-8?B?QzVZZ2JBekpGMkVDOVZRblp6ZExVMnh3SGdzWm9JRDJGUEtpVVpabkNyc2Ns?=
 =?utf-8?B?MDdlOWcvNkZSd1ZueEtTRU1QR0huYndodjVyY0paSDBEU2htRzJPY1Z1MWha?=
 =?utf-8?B?NFJpTmM1Z1FTekFZS001VXZ2TDdiMXJxajBKOEVicTVBWXdjY3dDdGZTQklj?=
 =?utf-8?B?a0phKzcySDFKaCtDOWFZcjZQZFowZFJsMytHeE1lUkFVVEN4aDhUR1JaNlRq?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8151A91A45ACB541BA951247C80849CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OHTBtGHwUaUVHk2zBrMAYcz/tG/o1RVMo5jeoWhqJYwePY74v8VFaR+/Ttv5q66Cu5AyUK2lp8vIisdDNJmDCSvCpJdxqZsHCZbH/yUi57rgmaRRM6LvXdVV7ppqhNo/KZP/DE/Z7DjJBqBznkRY/xCNKP82C4rqz7cRbmy/QqdKH+E7vDZ3lq2Bigo3LipOeJU3xWFjDXo3OzGYdQniFLCpo1/OQjhdNmJADJajGqlzZdwvSimY8HGGCUP1T7VYzumiTzQUIDOFfbqc0OobHdzjMnSC3r+ift/Wsptz7w3exGf7XXqfnhrx6LiEmqzS0UmUhdp5iHFOj4aBVxK3iQYpOM00hKwjPG8EmjWOC+kUaeL25cnZtz5fYlkltYSpy0rVxMp0LtrHsFd4hFJyqYzM3aU4CTnOMS3wbCBO/BYWqoi08CtmQ8KLNFPQsXn6v7XV+By3M1ZiIetwh3rrrlGFV5UnjMHOkvw3Kr8ygLL39qA0wh+2Nz+9PSXyrI4QdRzhE49qjd0PaL9zu94n8GeK42qrFE75VEhORcsXzEAyzlftOUsC3Blkr/5aXSw/mb6AVm0nWMlPM29JZP1CF5QqlBPDlt02/mZGBtWPCMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24aac5c-1931-4624-b074-08de1be86e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 21:23:42.6681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOS0N5FORuDGVGYAS6iad0bUnRs3qqSzBtLUDXcFrST+BSC9VvGzSdiAda9zuopHberW9R+vlrTJzVSLGgeGqtTbpcQqjBvKa81d4yTFbpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040180
X-Authority-Analysis: v=2.4 cv=RojI7SmK c=1 sm=1 tr=0 ts=690a6ee6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=Mzw2MGceJXLnGWwcAtUA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: rNHdy69b4xqw00Xnxr2KwYdJ6qV3KZbP
X-Proofpoint-GUID: rNHdy69b4xqw00Xnxr2KwYdJ6qV3KZbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE3OSBTYWx0ZWRfX04+sCQoDa0ja
 WtIjQY8cAoPA+e8desZYq7E1lkz+IQQ/LGt8kZn7xDA1eVpLAyhBB7RMsxh3MEnEFdQdml4bF3P
 6UtN26GWyLJTOmr/TTl/3yQYZGPgaakozEdniVnmgtJWUIYAgwJsbUnqo8EXguSy6yKsd4NYigW
 onisUv27FUnwKv9sE1GQCI/5PtzE3+9oqTXVX+7HeqKWtleLChTsN3PU9jzTFij/T2nN2EnPp4T
 Wd+e2sosvP8hk798sHGW3kBe3MvzIcyLfBToEMuqEq/drhsN9b67lWZVkyxmwPb+sGUfyAc7PYM
 zkdqij2ao64mSg7oqI3mZ+Qu+s4QgQf3Tr9K8ls9xwRaGUB+zWPM5OAqH46YrbY8VBsSpziDMUw
 HR26cZJc2AyaGxp/UIa0OKDHoQjOd4wwwjmJNC8DCxKOuQ2pqBc=

T24gVHVlLCAyMDI1LTExLTA0IGF0IDE1OjU3ICswMTAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
T24gMTAvMjkvMjUgNjo0NiBQTSwgQWxsaXNvbiBIZW5kZXJzb24gd3JvdGU6DQo+ID4gRnJvbTog
QWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+ID4gDQo+
ID4gUkRTIHdhcyB3cml0dGVuIHRvIHJlcXVpcmUgb3JkZXJlZCB3b3JrcXVldWVzIGZvciAiY3At
PmNwX3dxIjoNCj4gPiBXb3JrIGlzIGV4ZWN1dGVkIGluIHRoZSBvcmRlciBzY2hlZHVsZWQsIG9u
ZSBpdGVtIGF0IGEgdGltZS4NCj4gPiANCj4gPiBJZiB0aGVzZSB3b3JrcXVldWVzIGFyZSBzaGFy
ZWQgYWNyb3NzIGNvbm5lY3Rpb25zLA0KPiA+IHRoZW4gd29yayBleGVjdXRlZCBvbiBiZWhhbGYg
b2Ygb25lIGNvbm5lY3Rpb24gYmxvY2tzIHdvcmsNCj4gPiBzY2hlZHVsZWQgZm9yIGEgZGlmZmVy
ZW50IGFuZCB1bnJlbGF0ZWQgY29ubmVjdGlvbi4NCj4gPiANCj4gPiBMdWNraWx5IHdlIGRvbid0
IG5lZWQgdG8gc2hhcmUgdGhlc2Ugd29ya3F1ZXVlcy4NCj4gPiBXaGlsZSBpdCBvYnZpb3VzbHkg
bWFrZXMgc2Vuc2UgdG8gbGltaXQgdGhlIG51bWJlciBvZg0KPiA+IHdvcmtlcnMgKHByb2Nlc3Nl
cykgdGhhdCBvdWdodCB0byBiZSBhbGxvY2F0ZWQgb24gYSBzeXN0ZW0sDQo+ID4gYSB3b3JrcXVl
dWUgdGhhdCBkb2Vzbid0IGhhdmUgYSByZXNjdWUgd29ya2VyIGF0dGFjaGVkLA0KPiA+IGhhcyBh
IHRpbnkgZm9vdHByaW50IGNvbXBhcmVkIHRvIHRoZSBjb25uZWN0aW9uIGFzIGEgd2hvbGU6DQo+
ID4gQSB3b3JrcXVldWUgY29zdHMgfjgwMCBieXRlcywgd2hpbGUgYW4gUkRTL0lCIGNvbm5lY3Rp
b24NCj4gPiB0b3RhbHMgfjUgTUJ5dGVzLg0KPiANCj4gU3RpbGwgYSB3b3JrcXVldWUgcGVyIGNv
bm5lY3Rpb24gZmVlbHMgb3ZlcmtpbGwuIEhhdmUgeW91IGNvbnNpZGVyZWQNCj4gbW92aW5nIHRv
IFdRX1BFUkNQVSBmb3IgcmRzX3dxPyBXaHkgZG9lcyBub3QgZml0Pw0KPiANCj4gVGhhbmtzLA0K
PiANCj4gUGFvbG8NCj4gDQpIaSBQYW9sbw0KDQpJIGhhZG50IHRob3VnaHQgb2YgV1FfUEVSQ1BV
IGJlZm9yZSwgc28gSSBkaWQgc29tZSBkaWdnaW5nIG9uIGl0LiAgSW4gb3VyIGNhc2UgdGhvdWdo
LCB3ZSBuZWVkIEZJRk8gYmVoYXZpb3IgcGVyLQ0KY29ubmVjdGlvbiwgc28gaWYgd2Ugc3dpdGNo
ZWQgdG8gcXVldWVzIHBlciBjcHUsIHdlJ2QgaGF2ZSB0byBwaW4gYSBDUFUgdG8gYSBjb25uZWN0
aW9uIHRvIGdldCB0aGUgcmlnaHQgYmVoYXZpb3IuICBBbmQNCnRoZW4gdGhhdCBicmluZ3MgYmFj
ayBoZWFkIG9mIHRoZSBsaW5lIGJsb2NraW5nIHNpbmNlIG5vdyBhbGwgdGhlIGl0ZW1zIG9uIHRo
YXQgcXVldWUgaGF2ZSB0byBzaGFyZSB0aGF0IENQVSBldmVuIGlmIHRoZQ0Kb3RoZXIgQ1BVcyBh
cmUgaWRsZS4gIFNvIGl0IHdvdWxkbid0IHF1aXRlIGJlIGEgc3lub255bW91cyBzb2x1dGlvbiBm
b3Igd2hhdCB3ZSdyZSB0cnlpbmcgdG8gZG8gaW4gdGhpcyBjYXNlLiAgSSBob3BlDQp0aGF0IG1h
ZGUgc2Vuc2U/ICBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4NCg0KVGhhbmsgeW91LA0KQWxs
aXNvbg0K

