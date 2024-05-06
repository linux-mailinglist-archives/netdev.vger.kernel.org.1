Return-Path: <netdev+bounces-93724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CE78BCF98
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522D1B22BA8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BC8120A;
	Mon,  6 May 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzAJoJXi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fa3cJIsH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E215A5;
	Mon,  6 May 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004183; cv=fail; b=seMG7pTmNDz97IUilrRPUQQ5sTHOQ7rf0em++AKukUg9ibt19AVewlX9jhVD9AAzHIcgsioJ82PXBXiqWPHEDy2gxqiZ+y6P93Lzzk9yQcjU+l+WlVz+9J98+zX7PJ+Rc6XmnfZoreKROqJu8IKb/Okq+1oVjezthvXOFAsd/m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004183; c=relaxed/simple;
	bh=0YdicbE0KWe/IUQqU8aJJ1Uh9foREvEgTvwJpJhFNkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DH0dvGZXw1AnESmyMB3WCeyNfPOkQ0RAsRHfltXMW8ejoweV3ySdpR6y+XgWTp9X72NwgNNx1j19xE7nLm5SiIck9q9eDq3qFLj5EqNaMVQZKNidj/O8XZMliMPNoUtpZCg6XzvBo+8VYR+nds5AY/ZdfR0TdMkqER1UQxZGNUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzAJoJXi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fa3cJIsH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446Apc09018813;
	Mon, 6 May 2024 14:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=d3uqPGxtmVk+ZO4AAvI1Ah5sm+GFE85I2BQr6AlaKnU=;
 b=PzAJoJXidUZeO7S+d0COOkSgXkmOW07YigoAouftfO1KrnoxQ0G5IspNF+aU4XGDHLto
 4KYyynlL97hgwg+WwrmvnQcN18lvrePn6q5k+T6SgbMbpX/OuMsL1b0NMmrIpPe7k/nO
 AMG+9ntXMm6Xwx/gxTkAEQ2dDGbDHykIK0Kh6UqQvkUDKCMgRi4ZIMe1eOZcPAuVAXYQ
 v6Dyakml3vn/DSsh0Jau1lUQpWjeWSi7PC8WrxEUNly6jmPzJ5/Oarw2VcUp5znxrP4G
 C69Nss4lVL+Q4E/H0WE+Fmr+OX9AF8xsXGlC4G59Cxtdr4eGRyxyQuam1lYEIlliR5DB QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5jpj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:02:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446CsDTV040813;
	Mon, 6 May 2024 14:02:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5we3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUTSN802VLyd4TFlsH4ZfXviK2XfsH1qdu9u8EeVuMRYgBg1ZXGLT1BCxpnNNSkPrBquJBb4FD9FDGJGdColHYEuwGCqff1Dl+5k1BNR9dUgS+dhfnAAeOTICUcXMbPHPq/0nZhGnUYMARK0nKFuSDAgF4Wj/jFs24v9/ChLU0JDQ4IY28f7hmPAie9zEVz0PLVsKWdLvUg+8gwulmQefpPg8GQTtQp8q8MBkjNWNkj4y9En0j4jeJxNqJyq7L4ZHdqyM6oR4EGzFNt5j4ze2OJco4VkE8i6dzxkbHWXlIsgDU7lfB66s48eL5SAMA1CTImMDAilEXSuH9jE7PmmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3uqPGxtmVk+ZO4AAvI1Ah5sm+GFE85I2BQr6AlaKnU=;
 b=lSvsrYgHZITIG+mS8HvU2mYx94G9fbVAeyBX8rdnEUIUl8ltnZ6Ok8mq+tSDznytvCVu2A4MLT8WKTsexs8TaVK+C86+kjaKuut7M5ZiyOydjcMNJQwHMHPFDJYcZImFTf+tV8qcoaACtxJ7wTyE9sBPRN2dspKPew93QAL7tiTvP+JMHWQblvwSoulUYUdotQxLnYURPzJ7oCcKSVDz7n1GYb3SQt6GjyvHtc6eLT0TKIBZN3LZvzsLD/iud8I3+tBzk8tDHPg/6llciUpdeVyJ7WNHHiVYDrTo9WPptYIFGvP1cgowWaxd/JQwjGGQ9iBlvUwFSFUsgr4w64GY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3uqPGxtmVk+ZO4AAvI1Ah5sm+GFE85I2BQr6AlaKnU=;
 b=Fa3cJIsH4uxH6r66Z0dpQiU2+MAgxv/oL8odFOiCkdidpra/MtImACUjedG3rsa9K639CSA6Lb+9AEw5qRhJwl0QmSzNnJdD0hf4NBECb8f//qOeBnHww9ihy+Z3HrjVeeYZmJFDn8sRK+H2z1CBb4hShXXZ2aPxCfMZiDpHFPE=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:02:43 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::91e2:2c9d:3f30:39ab]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::91e2:2c9d:3f30:39ab%7]) with mapi id 15.20.7544.036; Mon, 6 May 2024
 14:02:43 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "jhs@mojatatu.com" <jhs@mojatatu.com>,
        "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu
	<rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH RFC] net/sched: adjust device watchdog timer to detect
 stopped queue at right time
Thread-Topic: [PATCH RFC] net/sched: adjust device watchdog timer to detect
 stopped queue at right time
Thread-Index: AQHamweIx8KdUY9mQ0GzMC27Mq44X7GC81qAgAKganCAAFa5AIAEWw2Q
Date: Mon, 6 May 2024 14:02:42 +0000
Message-ID: 
 <SA1PR10MB6445252B67E90F92DC87B28A8C1C2@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240430140010.5005-1-praveen.kannoju@oracle.com>
	<20240501151251.2eccb4d0@kernel.org>
	<SA1PR10MB644567B49D44BA641CF63E828C1F2@SA1PR10MB6445.namprd10.prod.outlook.com>
 <20240503122954.58bee752@kernel.org>
In-Reply-To: <20240503122954.58bee752@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|SA1PR10MB7684:EE_
x-ms-office365-filtering-correlation-id: 0628140c-fd5d-4eb4-714e-08dc6dd532f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?sKZHBDOObBzl5mrCeCIN8vW6Qqw9/F7sOICHT4dWlXpEM4ROhyZGsYnrvZiQ?=
 =?us-ascii?Q?KMmnEr/1x40nSl/Mne3zTLf120hV67Kja4y62USdQHEqHnfOSPsvRKM9AeaP?=
 =?us-ascii?Q?tRdHZWdFl67+rb+w1bNG5RwR+Zse3SMQ+xkyRndTnjSIu0XWZ6cXVGy2Uy6x?=
 =?us-ascii?Q?NnYP2Etjju0OXQsXdA9KXc8UhMTh6q6n9VOgKHXmiIkpdaoU+vpTlQch8Kjz?=
 =?us-ascii?Q?jOMxBm0XCTVvbMdJ85T6UviHBRLCoFPniTTj3vGP2NnCNr+c8pFj+B9MuH7y?=
 =?us-ascii?Q?jWB4ji/eGyR8fZ0bECQWup8gQ+f4cldQmyLwYhTfHAi1QI1tfufmOaRP/v8K?=
 =?us-ascii?Q?6XT218XHbiMlWNlx+jWiJb7OTfDwJ419D2APhLjFOnaaj9VF3ng51h2qsZhm?=
 =?us-ascii?Q?7YAfx9e+d9p3r6B7hKj4lB74ueV7HM6y4Dp0uqIUUMvGQrYkw9a8WPukjiJp?=
 =?us-ascii?Q?xzfYBOurjFYFQmGZX+SgEsi10TTJ/UzZsiGeOb/YWT0HX1tEBRXGhYSl6YEI?=
 =?us-ascii?Q?l57HfkJYpRe+IssP9fnwe6MsmqBNzDmSJAqqBHo19EAo2UZlMHB95agQZ6hP?=
 =?us-ascii?Q?7OO78kT5SRTcarK4RfNeoAdFpFnYHLI+lWjYwzzMdHv/ZSPSyDr3tixHbVhq?=
 =?us-ascii?Q?1aeRkC2uoUhKkVApBSDwC/YWHyirvV2uVrc35hfR8onZ6NoaVhdt3TD6r7Ij?=
 =?us-ascii?Q?fL8gy0iJM3CwAKlSpujRbS71QSfhuv1MwLNIc320EhPFuxQoberjLl80A9WJ?=
 =?us-ascii?Q?UUg+kAQWnnC1qDMQGzWWUdASexr1f00J4rdHcqBBhJcdsK8M2q+Bo4zNiaFo?=
 =?us-ascii?Q?HUlrQXHW21V7GpTC9mUSOcaReTA+FwMcg155vYHQ4XK4VrOr9djv7mgC/2LM?=
 =?us-ascii?Q?iQwVy8FJsspakA9xsXvs+inWwVa+dNzPRToj8MH6xP0nqrgkn2h+G8d4Wc8j?=
 =?us-ascii?Q?j9wYOZDqteSAwd4Cbi3V9T0JHkzsVYl+Vc7x76UgbvrNl3R6oO71N4s4rDRt?=
 =?us-ascii?Q?OipmhUsokS+SkC3BauOnbfZg/yYUUtM2nKgJ2i0YnqHqJxgs6m3mXgzqd9WR?=
 =?us-ascii?Q?CcIpnOtq4F/pVlHEYv9ZXbpsJvx2j78jUDkqqszn7ZMGxEG1dYPhFgx557uu?=
 =?us-ascii?Q?4UPbcYzJH9ok5M0yJQHF75KZyZJoxZEoteGoZgsQS1/Y7CC0e/3Fg/SLqX9g?=
 =?us-ascii?Q?us4JhD/VUqNcNNGUMT/3Kms12SvMi0OmBWjZ3aWcPL5KtuDYCCLD/N+br1dx?=
 =?us-ascii?Q?FbyGcR23EJwWU6CxOkS0JJXIzMlG0KqHmoHoJQuo9PGnG7e770WkmJEZavFO?=
 =?us-ascii?Q?6kJuf+hODZmOg1PVSmDsSPTsKzaZvWufzmF8qZ+suTTO8w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?U5ukOAUUxGTMxpGgddP5eI9BNtHrHNAvb3pm5reWFz3zQU7ButFwNpjCWrL0?=
 =?us-ascii?Q?9KsvKf15db6k3sSt7Ld/PAP23xtJ3oyei40CqxJ593rgMVEA0Ximoj71SS/N?=
 =?us-ascii?Q?Ghu3iRxSF+nfa8bD4XhkuWorA5FQtZeMuCv0btmhyvux8CSBp/qPzPrvEv+A?=
 =?us-ascii?Q?5MmCGUpBQ46nqp/JiSIO9yvANtFlboR74CaXwnil/qajNqcXD7hdu1sc+FeB?=
 =?us-ascii?Q?+IsiKrbEpfx/U6fY2DYHlC6a3WNp4RRIuOJLLgpqxsuRcIQ1qn5s0jA62tIJ?=
 =?us-ascii?Q?YMXch0RflnrchfZNo0JAdiguQdtdIJOq1np3NZmQiUYwwrOXq6kY+oEqeKQ5?=
 =?us-ascii?Q?1pDkYlQO8wH5r+yDvzqxHyVGuIrBWCP7MqI7NhGDNPGqPtQZSM9vbYMClB1V?=
 =?us-ascii?Q?jMySnaCA7bLdrkbpE27yhDiqOYwPDJrqLnOnQ4WkChEhZamOpPXWlyunxgvd?=
 =?us-ascii?Q?FF+Rxx9F3ZsbxNsrvWJ+400kOSgpuLo+IDGVPWcXaLww8kkUxaj/fB1MdkAI?=
 =?us-ascii?Q?kRgNfQAxdNQndndwQNxgKKHtwpbPeE4MwJfxZvvJHWtarYHu3KM09PtZhUIK?=
 =?us-ascii?Q?g9ux7jqU7dmE1Sa0TA7cy6NtTcJVdYx4iM/0HgplFzP9QmNE/XoyZj3eX4rJ?=
 =?us-ascii?Q?dZv4Cr1NcKH3u/QY85DM3j08oc/O77Kc93qNdDm/MXt79e11GO9c2+5OVwBv?=
 =?us-ascii?Q?4BUSw5Ez9RtNe8yhVOsw/Z9qxODmbesTsIjBd5a2xbaa9MFup9y4cnMDIWus?=
 =?us-ascii?Q?L+G1ND2hzfKle7H3U6ckkkO6uA6sBJ99jCxhW/fZduKTo3jVUd5KuYM5CIzi?=
 =?us-ascii?Q?tRIiGpBB+Kl1UHDApO9ld/8zHH5a2BYgVrEau89YXcUUvo8yloj7VF7isS6U?=
 =?us-ascii?Q?gqXZzs0GhiujlIbwa+nXbvrnvWBAWPbEm62z3UuA852d9QlrqwpFlwlLE6RS?=
 =?us-ascii?Q?wGuQFABuBRQDxJsOvfU5WxwCXvgoU5KldjIOD/FDZde/Kx/SnSyj4L7WK86R?=
 =?us-ascii?Q?rU3kIqlA5eSwcwoprW4uT1BWKepsP28BT4GC7tV2JfxFYtWg/66J/2EliEL4?=
 =?us-ascii?Q?k98I0/viGNgRplJ7r/zycPbpikQDwAxwCJLPez++iKgrh57NcXufTzIhoORY?=
 =?us-ascii?Q?SdgldIFc8vqrhz8V/tP9Qph6I5AXZjpn5ObBW3nE9GtU3jae5ZHC2kjtz6fE?=
 =?us-ascii?Q?QW51HHCsBtNo+cgj6a/OiKqVyy0fBFnwv0HjQvHMjFtLVeeEp6kxtgz/uTGN?=
 =?us-ascii?Q?CdAiV2lnV85a3YLGo85Ky9WerFokxPCKaPGi4fu8dXIGBmvml4PG0lbHXzU6?=
 =?us-ascii?Q?4Kx6V6CYrjf2LB5GxWGtZ2PVvpZoPNpaMYouDHM5wFVwKMrvshGUCrfB8wOq?=
 =?us-ascii?Q?uxZ83Er+j80o8h4P+R9ar8l8KIryLxsPo3dWuu1qHMgcvqrJMyUdVFaSTa50?=
 =?us-ascii?Q?6tZRzUi3UEKmW3CX1FStd0Y1+nxlZvNd2udMefUc407uv/kMlyt+3wTHfdkL?=
 =?us-ascii?Q?wokdYV2yyNlrpKEsTyQD7wrIcNueBh7QRbCjkUUMZaEtU6byHSsAwp+WF7eA?=
 =?us-ascii?Q?MfojNI5FHMubshhDP7/3uyVF1Yz5sr8I1DCC2l/Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+/WhXFTJZJq30WduvfHobYgFARWqMaqg90mW3fKolPHWSJxpchHuhdYMoqLc3jTQ0wic3wp19rg9RUkWLJuycqn7rgX2OdNAt2A7yVUZl5fHBt7kByWh6YdFtdtwIVgAD5Y1higLg++HBlZvI8tO8sNcaUoIixa0aBalc84XnJbiK08JhSNN4fkS1Be4Otq4OZv34LkgHfEovPkZn9wcal339AeSr1Zcq+mWvXqDfmYCCTkzmaFAF63ZndF1hIaKwXG9p4R/1x0QjijtgnRmh3g4wuwqH9xr+MS9zq/6Qt/ZpBP3GzMhThoRmw9h4G6NdxDH0uOYW9OpxwVR7IkYfqdH5eNJyMkqrGIPgHKU+SbI5ZLClwtFjHdPxTOojuChBJ5BhGuuje+bxSQswOLVlvsR1rnT7CxGthz7VmARIbhEFV39I/YqGIOPdH4gAPiuDH1aKlVRDTSqcdZ3hrggwC95CqDr9w/82a2gFXwmzmMNP/JRAhw6hwz30625Tzb8/PSMRUq/BKVMq2Uo+ISHIXQ8PUYuUDs0rGHGT4ZB6ic59Ql9zqZ1FIN2tQC9RIhsXZWMbx3nUnn1JfXjwBxgce3hzQPvpB0YetVGziNjVUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0628140c-fd5d-4eb4-714e-08dc6dd532f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 14:02:43.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bBNc5vGGIktHggbg0h2Fd5qn1v2XtazRV7PlHTch+ThkX10BqN4pim6gVV4yBEHZVj5lM5V5s3glXtEWWvNM+5n1skqdREYXtHEuciioQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060096
X-Proofpoint-GUID: xEI5vBblAVvRZybi5WuI9WVc8bSujCkn
X-Proofpoint-ORIG-GUID: xEI5vBblAVvRZybi5WuI9WVc8bSujCkn

Thank you, Jakub.
Your comments have been addressed in the v2 patch. We've tested it internal=
ly and the patch works as expected. Please review and let us know If any ad=
ditional changes are needed.=20

-
Praveen.

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 04 May 2024 01:00 AM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: jhs@mojatatu.com; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@d=
avemloft.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivaramasubram=
aniom@oracle.com>; Rama Nichanamatlu
> <rama.nichanamatlu@oracle.com>; Manjunath Patil <manjunath.b.patil@oracle=
.com>
> Subject: Re: [PATCH RFC] net/sched: adjust device watchdog timer to detec=
t stopped queue at right time
>=20
> On Fri, 3 May 2024 14:28:13 +0000 Praveen Kannoju wrote:
> > > >  				txq =3D netdev_get_tx_queue(dev, i);
> > > >  				trans_start =3D READ_ONCE(txq->trans_start);
> > > > -				if (netif_xmit_stopped(txq) &&
> > > > -				    time_after(jiffies, (trans_start +
> > > > -							 dev->watchdog_timeo))) {
> > > > -					timedout_ms =3D jiffies_to_msecs(jiffies - trans_start);
> > > > -					atomic_long_inc(&txq->trans_timeout);
> > > > -					break;
> > > > +				if (netif_xmit_stopped(txq)) {
> > >
> > > please use continue instead of adding another indentation level
> >
> > We need to take decision on whether to break out of loop or modify
> > "oldest_start" only when Queue is stopped. Hence one more level of
> > indentation is needed. Can you please elaborate on using "continue" in =
existing condition instead of adding a new indentation level.
>=20
> If the queue is not stopped, continue. Split the condition into multiple =
ifs.
>=20
> > > > +								   dev->watchdog_timeo))) {
> > > > +						timedout_ms =3D jiffies_to_msecs(current_jiffies -
> > > > +										trans_start);
> > > > +						atomic_long_inc(&txq->trans_timeout);
> > > > +						break;
> > > > +					}
> > > > +					next_check =3D trans_start + dev->watchdog_timeo -
> > > > +									current_jiffies;
> > >
> > > this will give us "next_check" for last queue. Let's instead find the=
 oldest trans_start in the loop. Do:
> > >
> > > 		unsigned long oldest_start =3D jiffies;
> > >
> > > then in the loop:
> > >
> > > 		oldest_start =3D min(...)
>=20
> BTW, the min() I suggested here needs to be a if (time_after(...)), we ca=
n't use bare min() to compare jiffies, because they may wrap.

