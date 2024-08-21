Return-Path: <netdev+bounces-120680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC895A322
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F1B1C21920
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CC1898E1;
	Wed, 21 Aug 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DVeM18SM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="heoTqaru"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6351494AD
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258865; cv=fail; b=Ni53oUDxK1/opgcmTO+xCFrrqhr4Ft5azE4kHk4Pf2/EkFbhpPC2jU9CK4IMR9YzptTF9aynhbPRYY6IE+0y11oSa1J3SKWp8wlKDlPh55BD/FUqXgbgyQSsxepP8baugfZiYmNAvMx10bX5gnkzoCcbI8iokHsArHcB7jJg504=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258865; c=relaxed/simple;
	bh=XpJmaPtsJBfNwa7acFFJTnmgHcCgq4o6Q+JUrrwnWVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=gex+ydQ9Hb9edynYvzPeaaMUpkntjrsaibnPTB1XtH9NagAVib/bViNs8g4v5Z+zlNMnQos/RDdrcoVDK5sFYNy4wPD8QGv1sFZL4dFn0ZFmxlzw1aBgSUr63LMsgmD9tzBnVRqyLtyHdCL+q4KOvWzqHPHEgWtnnoZp5x7n+mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DVeM18SM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=heoTqaru; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIXNZ031845;
	Wed, 21 Aug 2024 16:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=jxwO5hpTtGHeFQ
	zmUFlb3mEFyimhTPgTlKXFrti4aZU=; b=DVeM18SMMkMWw5QQRcb0W3O5uh7tSs
	HAlIEPDUupkf/Z5i8hRxQe0DQEV6mlKW6F9YSTB1Ko2wqSMMCM/E66dx166hcoXN
	LMnD7SLih1g6Vliftdbx4KBpYXrHdvsE3e77Xdpt1WpfZmcXTHsqWa+PYU+jbtAY
	S4KQgT2G1NrQ1WAbBgZejc0AwCx0oSNfIHKJDUxrsK+R4gOwJhc+vjOfrpGiMmzk
	n4sz26qpwh8bwwIggISAznjt4hTnj9AbUth0E9n0ZHiz48ghhvCKwpy4LbF6uvs7
	LY+DNtbNnyLJByHffgZZVTX8SEl8kIzDPHg5M6jQ42HwiKDuzvyxn55A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dr8un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 16:47:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LGgWI0019216;
	Wed, 21 Aug 2024 16:47:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415m0b84sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 16:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgHVbCMC8pMS2/OwaNW4yCv21Gk7A4Q0G9Ke3U94Soofutngyyb/kzsKp1ilkZfHddogeM3yD+T6V7PgcrJxoQ2ZV8nRt7RkWuk4PQxDmQY23YXSHq7PKGH3qte9Wn3SEl96UQDs6gk8KIhB8/4QSq2jyK5YBYVaHpbHVDcXF8enkk9Ph5rbW9NRmC9YDFE0UvW/6C/TPgl+Tt5pWlmiJ/2ldvzEFKOCLPw1/p6FXB1GyDkgOUBGfAw96yimvlU2ObVz6dFJoEo2xJPcefjSBcMgzBjqKFwxkxR8Dv+7nu0eKWVoE7qstphLWPeeHr13kYr9j70lvf9bebyyGTYqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxwO5hpTtGHeFQzmUFlb3mEFyimhTPgTlKXFrti4aZU=;
 b=Xo9DeohQmnKdyI6SzKe4BoX1sm7JUpXZz2ICUMGOcHokMUdFAy09i5lq6eAL56u46+dQtChZBBf11oXqaiLrcyDdHCVrYJ7gK1TLVoecDqkVGrJuo8FYFN+1InpP/mitVsiKq3fOOmeegIt6lHkpY/+ox/3OiBK9q4E08eDDp3PVmd9xMkCKWB2JykRvmRCVZgAwRbAEbyu+7tw+Y5s2AIgvkhZhSVVjiW9jfkh3yUjV5VLhGkf6qAbhDSKUOXESD0c5s4Tt/vH25zqYmHGoWl/hDSGOh96DybWZV3LuA3Z8htaZmsvQJWV5z+uS3vbKPg3xVZxT7nzqSO5BQncIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxwO5hpTtGHeFQzmUFlb3mEFyimhTPgTlKXFrti4aZU=;
 b=heoTqarus0jvn9Cp/bql3zw1m4ZgjpGHQdKcIsyBLHGKteTRXqd5EVk3fBWOF+Z8JLt2589b/G79jtDCiuJRQkakTa2qclRo2K0MUSq4UTuy4N1dWWZ6SRoxSkMrekls8uZiFiRgPDO7B6wxS03D/XDzOdrkM8po+2V5Kj4bTB0=
Received: from PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5)
 by DM4PR10MB7425.namprd10.prod.outlook.com (2603:10b6:8:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 16:47:09 +0000
Received: from PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990]) by PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990%6]) with mapi id 15.20.7897.010; Wed, 21 Aug 2024
 16:47:09 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Eugenio
 =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
        Si-Wei Liu
 <si-wei.liu@oracle.com>,
        "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
In-Reply-To: <20240820125006-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240820125006-mutt-send-email-mst@kernel.org>
Date: Wed, 21 Aug 2024 17:47:06 +0100
Message-ID: <m2o75l2585.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DUZP191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::21) To PH8PR10MB6622.namprd10.prod.outlook.com
 (2603:10b6:510:222::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6622:EE_|DM4PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d624f24-4198-416a-9404-08dcc200e586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x8R9VaSR04p5IdyJXGnCP/+DTYtKsquGMDlTK9gJHY7+bu+V4+3sEECAHiai?=
 =?us-ascii?Q?Lwp4C1r4DxUq352Jrv7whFJFFoZ0kXTuyIG0DYel154W/a7v3SBGVrraaIKX?=
 =?us-ascii?Q?S3E/Vn1tqKAH7av79cnfbkviENZqcP1Z0cZ75EiAmb1nCaQhHfxFZyD9HkQR?=
 =?us-ascii?Q?xEpMmumAM0+1PQs9T7Zakavvz+iXg6DYhnoKg66d+naMwbxebPrVZ9qV1kru?=
 =?us-ascii?Q?7EZK0SBKQPL4z5BUJVYrAGwYzaJaPFk9KBlS6PmKNBVR+E7mxptRDeLVJzqw?=
 =?us-ascii?Q?Fg66RvpMpk+0rM/OCDSDz2BrYAfb2jfsmcYxYpqNJzSqSRbFra52AVlOa5K2?=
 =?us-ascii?Q?8uO8Qzp5kSzctByfEXSGpOAbiSGBZ6iSam2UGNQiXSGFYCoRut6/2zSrFKzE?=
 =?us-ascii?Q?cUosCLb5LHHZPIgqUnODz8//eBDgKL+whg+mKLPzKJSdDbl8sI/Z5K1XpFtr?=
 =?us-ascii?Q?OKgJK4KRyvGLXuZHX/oFOWsg+XAgwQDiVf5VXIZuVtzXanN4tLUHefiTmkTE?=
 =?us-ascii?Q?EprvKpSi+qq6wZE9QpuAUtNMT3V93Z05IE/l2KOYKdcflyobdCUtKZL3zQYF?=
 =?us-ascii?Q?5L/izKQ30k/3VdsBdsQtC2F0rJh6H/U/IgL6ImbXs8OBfXf9Gl0JaFcO2cWd?=
 =?us-ascii?Q?26pk+BocSEp6/IdhLEQfuA70QKE+zXa1qxJheA+fTjl5NzgZsLLsSUTfq0yR?=
 =?us-ascii?Q?D2hAXUwBZMAX3XzJ8YYAqmhxWKQuFMcbEjZjPSDjN1neBtmUWwP/8sSgWXzA?=
 =?us-ascii?Q?3dvLAyZItGeHErw/0P2X26w3O+ewoC0EgiXyjr+EwxLy/Gx2EUT/Np4HtVzb?=
 =?us-ascii?Q?Y+VlxtKojAsYume1vauPX77thnMM2BpKOEAmmVg4E08HMAvhE1FE6mgWXpA7?=
 =?us-ascii?Q?8aoG+o65IHvXr9VpjQuR1UKdRaISEIIn3Z6uY2CqdHxtSQRf9dEMTas05gcd?=
 =?us-ascii?Q?AslJwCyNBLb0DGQzmo2Rs/XhUpawWyrT7vPKzfEX9rXhhDKwAB8OPO/fTG20?=
 =?us-ascii?Q?tYrY4JTa6pHWXIeykT9jGJFKWTafUTAvl+yQuSEPJbfcYpkXPn1WQK4n3ow4?=
 =?us-ascii?Q?eyruuyp7D7SUpC9zwp1KUFQ51dglAngV1BaWXUpB/X1l8u+txtoZdbwtgEtf?=
 =?us-ascii?Q?0TdBQ+7F4k2y4wPKEYu3JYNxg85jvMEmzEHJ7kWN2D2vp5F/vKaN8BpFpQ9P?=
 =?us-ascii?Q?WfldBzDfIDObvYiU4NwXCdDDQsktsVRTVFuQJeaVQ3VslcUR5rvWCfFzcP6x?=
 =?us-ascii?Q?OsR7Qh70CWn6u45YtBa5rGftrj7LvcIe6/eVCED38cCSUdCD9NHsVgYlfRkd?=
 =?us-ascii?Q?qnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMCdvbSC/ewELYXgHlYBJ08QbqwqfYy1DRh1wFMt83V2d/jbJ5NMA+UoADOe?=
 =?us-ascii?Q?oA8wnx95RaUOLvoXEuJCWFCiVg6sg8YT9KlHsbRCcJQVC9YWdcDBFsgwVyMk?=
 =?us-ascii?Q?bfvuR3A4hqCu8whcAbglAMfcM+ED2zPhWwTHhpCXh1Uw8GIQfVOnd0jlJ1Cl?=
 =?us-ascii?Q?hO0fWd2igK1/NugZ/vwxdACvQRt2A0S+hUbhmmir5d6tS4fax2D19z5eTAKa?=
 =?us-ascii?Q?0SplobYvVv2gsp2Ijtxtz1vMelKELgzURfpekJUsLz3c7yacVRm7DGeWXc80?=
 =?us-ascii?Q?wlR4hzCHvSIsYi9yBBSKaGtMSexIhmk//ou9m42ti1TcU16eJppb7luiMRV+?=
 =?us-ascii?Q?1GEIUX8NTKAU6zbNQImRyG7jqPcq84THWJPbnYR4721rtDv5SMc72bTnpjg4?=
 =?us-ascii?Q?n/BrFVobBOaAmoPr49s7HkzcD2ulXrGIc70P9GHbGLvOt1E+YKEr8PuV56vS?=
 =?us-ascii?Q?zv+jcYOPG74csb3jacLa4dF82BrK9ch5bZlQ3ltBF+5d6PwlBWcHE7RePIL4?=
 =?us-ascii?Q?uF08DpOWpnuVmrI26LKG4d9qGpAwz1De6ZymV2l5OAPTrQaOMqh2XDLl7dDC?=
 =?us-ascii?Q?i6f1L6Wt9w7nixZWHkyEKwtEOYgZlnafvRvyHmAFdnHKqQ3PRP21xrkNoe5p?=
 =?us-ascii?Q?Uml4q9LgHNOQXmbgZxqJQVB9xB8r5FNcgmmH48uQ6bRrMrplzQeeW7Ky6arF?=
 =?us-ascii?Q?iKi5XsmsfMHhf3opdLJMKla3ekreQJCbMobLeRizna/bLepuK+ywAP43kxwk?=
 =?us-ascii?Q?0G3A1oqiiZyBxiQ1EKS4JBfoqILeNH+VY82ty84wDMWXvRVDQz+U+Ih0P5Qr?=
 =?us-ascii?Q?UKp7x6odjbG54HJ+YkJzYL9PSiU9hxpgLHEpfzbJAHvcVb9UBh6h2YI36m2k?=
 =?us-ascii?Q?gueYSJrjNo6WDCUBV+PTXACHS1zL1pJhJikyQ/QFR2zfmm5p26WFMRvmKJye?=
 =?us-ascii?Q?PsIdCSnY4UXkDb3Gbd+p2Vj3cEIeYea1jMRXbh1GTW9Fm/y5ELDcMjfDPv7b?=
 =?us-ascii?Q?LWPzXFnNYiTqc+B/YZoMLqmkCbdB4dj5EMGhTQFPMCTLctxUVJkQ8UCFFQ/R?=
 =?us-ascii?Q?pXV0wZqyt9/0VgCij/oeGDY3bj20h/ydTPpgTrWWSZdO6IKmQrrkoGLNu+QH?=
 =?us-ascii?Q?YJaYeyDxBH5fVZTGF+1XBAyPL9+cd5wfLxfETScECzmFMniw5/wKuyZ58X+S?=
 =?us-ascii?Q?UW3K+vGaf+T1+PeCtkUKngVcOCB6yh+iMa/3fy/IrEboDiiEZopPbXgHUD6z?=
 =?us-ascii?Q?FheeauWAcV+hwVQmXcy2BYJowI1/eBbisjkknaQG/TJswyxzqzj/ShYdZow6?=
 =?us-ascii?Q?chLyVYbFv80hEsq7RcSMJB7viQG6bVnL+Y+ZMg0NfnPKsXBNffO5R7iq1sLm?=
 =?us-ascii?Q?SEnqacN4Z0ZRC4UnIO1LGYAP35LouEtVguvISUGa9p4oGbOATkM50yi09hcM?=
 =?us-ascii?Q?CAgcmCvFRM26ZaUbNwGQ5tgAXuPTK/mJA+IT99jtKQBiWh322MVhQHqMtCGw?=
 =?us-ascii?Q?wT2X76A1bFVeZVOnkcMCqRPjMZIkaUW+ubBl31hrmJug1DBN5nHjowFu9X76?=
 =?us-ascii?Q?/jjFF6xlrbWvLQT0VysUTVovausr6XCkQiyJRTKlrFAMr5NM+jzlLHkHfMSV?=
 =?us-ascii?Q?FVdYDk/ReFWlH6Jdu6lXw1L3wCyKI2XWUqygr7E40q7arjNhNnA60lsFx4z6?=
 =?us-ascii?Q?vLWulg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HHm6oTI5+r7AIc6htUhz+EpkGyIt8gd0RjGjPbLcnvSQQV2oVVqXy6BwN/0NJmEbM7I5zs60eYujFzcF+1I0PD/pD8YbmiG8S7BXlvPGYISqYCvecIWrdQ+uLror7k4gHErk3f+mIOG6KZw/kX4JGipDF3W2xUSeF0lOy6IJdQbS1C3qOn8Ah6e9SGXkoWDACibt+5nApKdGCAVmVaCFWzKVkc3oBwpEAaAW+xuckonY0CAovuAvTbo95A/+UAj0/myBRph5mLGyIi11980PlBvIqFClwKn6ZrId7bCmMN3kcX7TeuqscI25IEeJG6tBwHnTEelV92r3lWYS1FDZqlmNXA5oNFNftXhDl/Lq2eW8lLZSNFrnTAjGRA2cL1G81vwMIaBWSVmTjQ5sfiNnj55aWR254ruPhJTqAW+90IQeIC471ZWLja9Euu3161ILGaCZfvYqbeiB7AG0PGItwAzra1S4ntencYfIhsEsGREerRhA+E/+bHHQVW1aMMUDxLaFEE1dk0kxjYuE2plaZMZ2qlgGXVg/wPfuqUV06PX9zPB3c+d89327pwUc38PbzrJXnLAJTEg6fO6tkGZphNc0b1oz5hRzIVU26EzPVo0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d624f24-4198-416a-9404-08dcc200e586
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:47:08.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db5D+GvCwWY0EhXzQstJmIrwhGeLubSez0Bu/GNw7Tr+OurOsuXt9iVO3JwX0Deo7wv7XyznmFIgIOFxJ3LqMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210123
X-Proofpoint-ORIG-GUID: Vc4Ni80IqmTMpzw09faJbhH4eVaree4b
X-Proofpoint-GUID: Vc4Ni80IqmTMpzw09faJbhH4eVaree4b


Hi Michael,

On Tuesday, 2024-08-20 at 12:50:39 -04, Michael S. Tsirkin wrote:
> On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
>> leads to regression on VM with the sysctl value of:
>> 
>> - net.core.high_order_alloc_disable=1
>
>
>
>
>> which could see reliable crashes or scp failure (scp a file 100M in size
>> to VM):
>> 
>> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
>> of a new frag. When the frag size is larger than PAGE_SIZE,
>> everything is fine. However, if the frag is only one page and the
>> total size of the buffer and virtnet_rq_dma is larger than one page, an
>> overflow may occur. In this case, if an overflow is possible, I adjust
>> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
>> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
>> the first buffer of the frag is affected.
>> 
>> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
>> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
>> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> Darren, could you pls test and confirm?

Unfortunately with this change I seem to still get a panic as soon as I start a
download using wget:

[  144.055630] Kernel panic - not syncing: corrupted stack end detected inside scheduler
[  144.056249] CPU: 8 PID: 37894 Comm: sleep Kdump: loaded Not tainted 6.10.0-1.el8uek.x86_64 #2
[  144.056850] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
[  144.057585] Call Trace:
[  144.057791]  <TASK>
[  144.057973]  panic+0x347/0x370
[  144.058223]  schedule_debug.isra.0+0xfb/0x100
[  144.058565]  __schedule+0x58/0x6a0
[  144.058838]  ? refill_stock+0x26/0x50
[  144.059120]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.059473]  do_task_dead+0x42/0x50
[  144.059752]  do_exit+0x31e/0x4b0
[  144.060011]  ? __audit_syscall_entry+0xee/0x150
[  144.060352]  do_group_exit+0x30/0x80
[  144.060633]  __x64_sys_exit_group+0x18/0x20
[  144.060946]  do_syscall_64+0x8c/0x1c0
[  144.061228]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.061570]  ? __audit_filter_op+0xbe/0x140
[  144.061873]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.062204]  ? audit_reset_context+0x232/0x310
[  144.062514]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.062851]  ? syscall_exit_work+0x103/0x130
[  144.063148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.063473]  ? syscall_exit_to_user_mode+0x77/0x220
[  144.063813]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.064142]  ? do_syscall_64+0xb9/0x1c0
[  144.064411]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.064747]  ? do_syscall_64+0xb9/0x1c0
[  144.065018]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.065345]  ? do_read_fault+0x109/0x1b0
[  144.065628]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.065961]  ? do_fault+0x1aa/0x2f0
[  144.066212]  ? handle_pte_fault+0x102/0x1a0
[  144.066503]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.066836]  ? __handle_mm_fault+0x5ed/0x710
[  144.067137]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.067464]  ? __count_memcg_events+0x72/0x110
[  144.067779]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.068106]  ? count_memcg_events.constprop.0+0x26/0x50
[  144.068457]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.068788]  ? handle_mm_fault+0xae/0x320
[  144.069068]  ? srso_alias_return_thunk+0x5/0xfbef5
[  144.069395]  ? do_user_addr_fault+0x34a/0x6b0
[  144.069708]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  144.070049] RIP: 0033:0x7fc5524f9c66
[  144.070307] Code: Unable to access opcode bytes at 0x7fc5524f9c3c.
[  144.070720] RSP: 002b:00007ffee052beb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[  144.071214] RAX: ffffffffffffffda RBX: 00007fc5527bb860 RCX: 00007fc5524f9c66
[  144.071684] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[  144.072146] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff78
[  144.072608] R10: 00007ffee052bdef R11: 0000000000000246 R12: 00007fc5527bb860
[  144.073076] R13: 0000000000000002 R14: 00007fc5527c4528 R15: 0000000000000000
[  144.073543]  </TASK>
[  144.074780] Kernel Offset: 0x37c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Thanks,

Darren.

>> ---
>>  drivers/net/virtio_net.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index c6af18948092..e5286a6da863 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>>  	void *buf, *head;
>>  	dma_addr_t addr;
>>  
>> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
>> -		return NULL;
>> -
>>  	head = page_address(alloc_frag->page);
>>  
>>  	dma = head;
>> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>  	len = SKB_DATA_ALIGN(len) +
>>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>  
>> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>> +		return -ENOMEM;
>> +
>>  	buf = virtnet_rq_alloc(rq, len, gfp);
>>  	if (unlikely(!buf))
>>  		return -ENOMEM;
>> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>  	 */
>>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>  
>> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>> +		return -ENOMEM;
>> +
>> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
>> +		len -= sizeof(struct virtnet_rq_dma);
>> +
>>  	buf = virtnet_rq_alloc(rq, len + room, gfp);
>>  	if (unlikely(!buf))
>>  		return -ENOMEM;
>> -- 
>> 2.32.0.3.g01195cf9f

