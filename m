Return-Path: <netdev+bounces-126756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603B97262F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2DD1C22BF0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B422625;
	Tue, 10 Sep 2024 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gf2rFc9P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nFDQAk71"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB020DE8
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928184; cv=fail; b=rQQWhgzqFEOz3YMLMw8kpV7aACyPEUPRPnv4VNZppVK9vX23kiFqSrwNRmbP9yv2WpWVOPSAN6ncDCmBNZC/Iuge7Xq1Cc11YzhqEG2mnj3eIl8v+HkIoqCaZYaNATdgn4Ff6RHJsUrJf/kSV9wlHXmaApnsP9rjj6Dfd3evWFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928184; c=relaxed/simple;
	bh=K/taM4lCYstZKQU4tBzbgpGN/vyr0wjeHUAqLDYyd8o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VJe4NoWYLydDI5Y1UYCZvHH3KrWA5RzMse8TPxk/Js7fiSP/K7mfdLInFH7EguEVkz+vsHwixutas4GuX6hG8aoU6LbMJtrLOC2a4SncbeTUAZThsWLcLNxRc5jTTpzJyTAfSYYrOwSQI4NoT8DHEl8NU7Krow5PKsPbASfZQNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gf2rFc9P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nFDQAk71; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A0MW9f024340;
	Tue, 10 Sep 2024 00:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=WV66LeNIq4CQnm
	oTHnfuRKlQ0sIeVU5y6DXYhCVTuqU=; b=gf2rFc9PYSSHOCIE025d9ZJeX9TOs7
	H/fr/dd2g/g5/r4xVXGYGrX/rj63Yh4q9ldRcn58A7E+y5GL11ZUGmDbFdaPQij9
	5d8h8vQ5IsPA++GoYNi1+WgZP6Hg3VG/nTg9zaLWtEi/eMGe10t0lBcFfQ61xkvD
	SoI7NYV4uD4wPfM7fYwv12pCQh+vaFoH4eYSvyYz4mmkEP+qufSklgo9UlFwwaI4
	URxyDZAad57Suoj7rO3UXqTzCOurtiDs4kzjanZqQn1BqVLKOPE62B/UyIdlFbP4
	5PgShoMvvbrZ62AVTKbVDQpFF2eidmyqOkeIc/xDolllrAnAv5MZ7mqA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9m9ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 00:29:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489NfQaw006205;
	Tue, 10 Sep 2024 00:29:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd97w890-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 00:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP8LuKocEA7IsgCY6lvFTyXuIiK42G1/iVOMvRaTtPBlBN2jMX1WVJcXmHMPbB8+BU+n1BaumHehq/jVrffkJr5UOh5kt27NGTsho6f/1CpI06NYbw6652PEVvEshxSmojlNbrG/fr+yH01kc/mdvYpXbbHowpwuIEgRhP95tQD5shg3s0+3OqM8LjbU9IONTOkN9esUvPx5wM7VdOM7+dUYqBsYrcJBBp70d7JcC9qTBew+yU2WsvcjOeuv8FuRJx4/dpTbqEDoyz7VSnUVaMpXWpkvIVro44rRFwb3svaJdfpiOW3811Dl3V69xulGSe31kmy47T+MpvXMK2DiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV66LeNIq4CQnmoTHnfuRKlQ0sIeVU5y6DXYhCVTuqU=;
 b=g5T5xlTIpodhdpPvRrakh3MuOKGQJIbvz4PJ/zurivSTdWp87SAWm50ltHT9tBq7PSBby9j19Uo9oEq6joi2sAtWVuD1oXhiCWyjBku7AiIoOmuBq3yJIrMO6PeOB+h5hqLb5/m6C6Lcg1lT1ryFnSV3wn9zLOLCmTFAkRdeLQar+bg7pL8yjSeTC0vTaVLjylXQN0X9BAuP0FzyiJ2ANo+IE1Iwdcf6kyUC3hsDaoVSdS8Kiw3t7L7AZ1psem1vWGmEs33hjBMab/Wx7lRSGcKRculd7w2pfdzvwFCX7DWpecdQRvXsoG/orpDw5qQ8wmCEYktTGFDyxJV9xmud6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV66LeNIq4CQnmoTHnfuRKlQ0sIeVU5y6DXYhCVTuqU=;
 b=nFDQAk71QXqQdNVMfRm+StYzg7imiVKyq7ypJfwLQNx/RVj3xmQ+zRCdZPtGaW03kALkhApadsGRserflX0pLcHrGP+z6DwowAIGOxzVOt3cv2iclwlCgtcvtpfa54skpFTjSBMiRPOD3oZ8S0rjBNui1kqG9iUAyZ1mz7icT0s=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 00:29:25 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 00:29:25 +0000
From: Rao Shoaib <Rao.Shoaib@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kuniyu@amazon.com, netdev@vger.kernel.org,
        Rao Shoaib <Rao.Shoaib@oracle.com>
Subject: [PATCH v1] Remove zero length skb's when enqueuing new OOB
Date: Mon,  9 Sep 2024 17:28:54 -0700
Message-Id: <20240910002854.264192-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|SJ0PR10MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a202dc-f2fd-425f-91bc-08dcd12f9fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLOyhPTynb+758Q/BnuesyPtvQrvy1giP0Vm/+WkblPDwKEz/ICAU0eYIllG?=
 =?us-ascii?Q?FIHe8AYFnFy6YT7eAPo8l8Z0QvwAPrzoOd1EdkJYznr1JWDm0if9BFIkwaZ6?=
 =?us-ascii?Q?9jF+euzyenLmcYvOYGJgrUKgRaDCiVF9+pXz8biL+4h2ENPYrGJ3oDl9tHsm?=
 =?us-ascii?Q?Ctha6TFdRjy9fqH1O8Bv89mfoTtCr5hZU6BB2LRx9gXCeSeBbuq9Gw9uylry?=
 =?us-ascii?Q?mhhQGoOYfetVZ0RM9aWXLKdPtfHOg0lHoDZqsTvnv9tG4NsGLCaf0A34Tfsy?=
 =?us-ascii?Q?jjhZiFAWKB968NwJdXc8lIl80C41lpdCxKTffHZpwA0CPFtj1pCAWqNs2NGJ?=
 =?us-ascii?Q?tZhG3sWpO/v7/EaNL3KZ/LKcBW9Ye8+xmqiqWKWlwPaLcs9VYiUj6p20z6Re?=
 =?us-ascii?Q?kA8SDQwH9AxYKZWCSfXpMh1Ahv6etGc1ktAS3nPGGaKTvK/KXarlanYRd4XS?=
 =?us-ascii?Q?2uaorDvCtn5tLj++0lbgJ57x3HvaqQ8UxzDJqDf1+1L1+lO9Kfpqxy86f3ym?=
 =?us-ascii?Q?xyaQnDUbqFdAYmoS/QhpBtF2xolSouW4yxEg4E3kwu9nW5kBukfyyLSgj1Mp?=
 =?us-ascii?Q?TWHa9qS5IsDGvkWlk3MJsBDNXcf1/aVpDGAt4yPel0wBNVo5iehLJKFxvcbd?=
 =?us-ascii?Q?JdGplfC/gpRCrtOimUYJDt9uJb72703JxWpYy8VSBY+tsd6nubjuMWwwFVB6?=
 =?us-ascii?Q?um4f9HnfC6W1j/fYzpXnDJ7FRTwfBMnTcEtizugoUI0gmjbx+w2f0CD1wJnX?=
 =?us-ascii?Q?pKAVTtk/24Nte3sWLEOMYuL5qBnhcPO/Q8Ro+pU/zyv+X3MNV289Txxj4xGt?=
 =?us-ascii?Q?YUWFnHkxZ/fcyFg2S3D6Qd6NdDmNiSAzvb0eE/wZicjhL+Qt1UvMWZCT3k/A?=
 =?us-ascii?Q?siLcgS3Q3JstH8WFeUjz+zRLn/oipF8DrlaSOoHGwwVpdI2/cMGQ0a4W9Msy?=
 =?us-ascii?Q?qrdEri3BAZe6I/Mm/ySeHSHXpDT310kFBV5SaOSq9lmL16SYdAMQ2x+xPhtK?=
 =?us-ascii?Q?ccJIG6NCY1eeFAm3wMJLDzhzyr9n/fwDPfuHucvYelXlvQ3BvMDfFhQwhT3J?=
 =?us-ascii?Q?bZ6fiNxSU4IujbpjbtEEnAXP/9d8mi/glFRTsAaKIlgRe/H8OWoNqQm72BaR?=
 =?us-ascii?Q?nGJq13qL4fNT/pU6/kYoyVQrDDrmuR9yZl4PEDpKC+2AvegdMPFiK9//NAXT?=
 =?us-ascii?Q?DP+zLM2claYQD+4FmaloHlcBAtIVKjJ56EszC4JBaZsmeQdplrxOsUhvD+Ph?=
 =?us-ascii?Q?nPbVYxzr4rGxadsaorbjjshhmI1nYdynRNu17uT6/RKR46reKd86RoeOkrUw?=
 =?us-ascii?Q?Msw7R6TPMOLTIyBf6vlup6KHsU61q5lziiIsCjFTPfE6AA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9SlCudqcjof9eanKGv9SJP1hP+8EIl/hQCQLBWUC7BaoDoT9JDbdICRGMwW9?=
 =?us-ascii?Q?iwfjFdwlMKI1Dpyx9wxMGg59+fwV8jVLtzUBNVoZUCIOlTgEj1MTnc9cSTnE?=
 =?us-ascii?Q?6+pqHKIZIc5UMPzbNxJCyVgAyQ9Qcm4hLfgHJ4FOBgnZgbEClmAMbjrwlqan?=
 =?us-ascii?Q?ZaUNzAIFNhN0I8qTr1fn4AmUhCHBkfovXTW2bBFD0NVFo0DZML5lnKyiW5St?=
 =?us-ascii?Q?ycRoiCLd/Dy2P+MPtXF5NXSWGniWfWpgcrSzJUbt2YSyJsBe8mcoI3of6ZID?=
 =?us-ascii?Q?+VRbJQwj51toEO1hy+AE3o0XfE3KWcrrByjVzF+0KeAaa8mT54/hK997mAbA?=
 =?us-ascii?Q?krxhePERNpTHoMy+OFhdlVLqgfuFMIJDlL0Lmg3uL8i/k13qHdw4uh6X82qa?=
 =?us-ascii?Q?1oMnMbstAPAf+eliVhK+o8KuVRztM0n7/l8Z+kmEYb4gAM81XvmK1W1jVrWj?=
 =?us-ascii?Q?HHpBmbAcFxcM9uqkkwIQ4y292mp+KrK2JXSxvMcSTae5WodZCjXoMGVHAZZv?=
 =?us-ascii?Q?F4syfZSIeIqMbMEW+SLyf2r98iQZi/fZLDwALLjREB/lG/NYWA1mpaM/NZG2?=
 =?us-ascii?Q?HBdV1OOuIkMH2RdzYt0pTPK2XbhoRW3dct10DelpaIAHF1VaPPB562EMr+Q7?=
 =?us-ascii?Q?GYJonOJxmWrJzpz42QxY74iA3YkKHNzNh2y/+CmlKD0Dif9QDMrm0o0oIzn7?=
 =?us-ascii?Q?KpkmZKcWdb7upwpFUitC8v0dHoBbpQSo7zjaYdZLGgIYh/TwIh+IfbG+XJ9q?=
 =?us-ascii?Q?bB8zPUDRrccD2LrYOA7Uha7txZQdB34YqeeudOhGg0rr/MIs12B9oaF8lSgw?=
 =?us-ascii?Q?P98kc7E5sVcfkJK1RYbTwVyqx6doRqt7iBQ8oetTBQwYO7CLY/7PQuWfjZQ8?=
 =?us-ascii?Q?14B+kiF00KbA4cR69D9/+yDgFt1G7dChH4wkG+IPD7GggHhwXDM6F6r4MvfI?=
 =?us-ascii?Q?2zFXLCqi48TrdsgQy2I9v38k6tbd4vVsr4pEhPEddTMtP32vue4P+DZ+EqC2?=
 =?us-ascii?Q?q5i4yJqmsUCZ1z+LqRPamOUbpftNTEh4mM2LFCCzCub/VE5iKZi3pwLjZEZt?=
 =?us-ascii?Q?FOGyQhyEyK6xE4fhiBgfi70Pu/PO4eND+I3tM5hG+7k6f8NZ/4IgmAGJqZSb?=
 =?us-ascii?Q?BEYCiCDgZ8DckIwGdCDYUHM+PyMbMm6jpoCfGq7ajhv5SmvHV/O4WL8WNxvt?=
 =?us-ascii?Q?jNkS2xFij5Y4UJeGrtMV2QekgmGPmOqXEs5R3RSXnHalNn4JpkVAzRkmkh3L?=
 =?us-ascii?Q?ua9f7IC9YSMt3aOtYR4G7N5a7FqBWrWFapFampGzCEohM9lTzhrfsVT9h511?=
 =?us-ascii?Q?11acG8DIUJ0NuS/TOCrH4Fannw/3F0PUQTt38R4Q38WTIKgkyLGgIQHlW51O?=
 =?us-ascii?Q?x4DaxS9s67sww2ZKOup1EsM6N63JH8xlDswxzUpU5i/gieViFS1gTW2SYBlv?=
 =?us-ascii?Q?L6Mh2X5oMtOGGKqWzPqKM5xZ/g8AKy/256mtCRvqdbRyQvPuiadq4omXHt9s?=
 =?us-ascii?Q?lgilyyAsODsX+Y4XjdzHYipKfdPWiVo8D3K/0nVqQqNKJSjIKAdlYH2ZNYKO?=
 =?us-ascii?Q?mUEm38oTB/LEwqph6c3G5yvEoQwRINKeU9sBnZb8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RrTf1PTizCWrMh/aeyq1nxVQorwcb1Bn9aP6Gog85sedu+9gNk+RvVNtB2RUgcPNm79OBQB2CYcKyRtt9lJwa3vSLMmAFTmCdzMf7qUzbFyyMQV2U4HyqEX2C5RxbNh2lr9QaqHZOgQGqbEt26DErdyQEsLGMPREzwiTPavoWql3+rsP/zr0EFdrgxEy2XJluRz1qLdVDaNHCI+tpZXfK0tE5Nm6mzfsBokdbgYCRnZ+zDoOIQ1J0Lbq22YiFpG6d+28OEfZeGqVP7fXHeJ2YdSbdIDjfTjLxICo2C3I9JYXK4GXe4w8EEbx2I7A5y5Imu2xVLQE8lrWGWgxi4ZRmurirIIBZwaabECJ1xzhIzd1m0iEFKOjwDr2EwioaaQrtE9++rqwdeR23+mdlpU6gjnx4Dqlwks8KN3UHeDtn8GwTzL26xjwD4igg+iUsHLKK/jYt2Do81rNx+3nH8KRxyestrtj8LYSew3goCZAfq0pNS7tD4Z7uLyToM9jl59phv+ANdeLXzEwj7b3iBqaN7j8hEYt6iY74R7xPF7+6Ab+cZ7JM79GbDJTRPM/VoDch2UGtvOUEdQqfAuqbu1xY2SiBxHqW7PyVS/Eh8cMaV0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a202dc-f2fd-425f-91bc-08dcd12f9fe0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 00:29:25.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4YHbhcFJ6HwNbmTC3t50Q+F2ZejCM7SKg+hdeKt1dghg6IK20GSrDDyKYQnKTlwQGB+ZBGSsafd9g9QvKKNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100001
X-Proofpoint-ORIG-GUID: hQdSb9c0SIt1ywBlrW6rmw9nId2NgSCP
X-Proofpoint-GUID: hQdSb9c0SIt1ywBlrW6rmw9nId2NgSCP

13:03 Recent tests show that AF_UNIX socket code does not handle
the following sequence properly

Send OOB
Read OOB
Send OOB
Read (Without OOB flag)

The last read returns the OOB byte, which is incorrect.
A following read with OOB flag returns EFAULT, which is also incorrect.

In AF_UNIX, OOB byte is stored in a single skb, a pointer to the
skb is stored in the linux socket (oob_skb) and the skb is linked
in the socket's receive queue. Obviously, there are two refcnts on
the skb.

If the byte is read as an OOB, there will be no remaining data and
regular read frees the skb in managge_oob() and moves to the next skb.
The bug was that the next skb could be an OOB byte, but the code did
not check that which resulted in a regular read, receiving the OOB byte.

This patch adds code check the next skb obtained when a zero
length skb is freed.

The patch also adds code to check and remove an skb in front
of about to be added OOB if it is a zero length skb.

The cause of the last EFAULT was that the OOB byte had already been read
by the regular read but oob_skb was not cleared. This resulted in
__skb_datagram_iter() receiving a zero length skb to copy a byte from.
So EFAULT was returned.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
---
 net/unix/af_unix.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0be0dcb07f7b..468d37ea986a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2185,6 +2185,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+static unsigned int unix_skb_len(const struct sk_buff *skb)
+{
+	return skb->len - UNIXCB(skb).consumed;
+}
+
 /* We use paged skbs for stream sockets, and limit occupancy to 32768
  * bytes, and a minimum of a full page.
  */
@@ -2195,7 +2200,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 		     struct scm_cookie *scm, bool fds_sent)
 {
 	struct unix_sock *ousk = unix_sk(other);
-	struct sk_buff *skb;
+	struct sk_buff *skb, *tail_skb;
 	int err = 0;
 
 	skb = sock_alloc_send_skb(sock->sk, 1, msg->msg_flags & MSG_DONTWAIT, &err);
@@ -2231,8 +2236,17 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
+
 	if (ousk->oob_skb)
 		consume_skb(ousk->oob_skb);
+
+	tail_skb = skb_peek_tail(&other->sk_receive_queue);
+	if (tail_skb && !unix_skb_len((const struct sk_buff *)tail_skb)) {
+		/* Remove the zero length skb of the previous OOB */
+		__skb_unlink(tail_skb, &other->sk_receive_queue);
+		consume_skb(tail_skb);
+	}
+
 	WRITE_ONCE(ousk->oob_skb, skb);
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	spin_unlock(&other->sk_receive_queue.lock);
@@ -2600,11 +2614,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 	return timeo;
 }
 
-static unsigned int unix_skb_len(const struct sk_buff *skb)
-{
-	return skb->len - UNIXCB(skb).consumed;
-}
-
 struct unix_stream_read_state {
 	int (*recv_actor)(struct sk_buff *, int, int,
 			  struct unix_stream_read_state *);
@@ -2667,6 +2676,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 {
 	struct unix_sock *u = unix_sk(sk);
 
+scan_again:
 	if (!unix_skb_len(skb)) {
 		struct sk_buff *unlinked_skb = NULL;
 
@@ -2685,6 +2695,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		spin_unlock(&sk->sk_receive_queue.lock);
 
 		consume_skb(unlinked_skb);
+		if (skb)
+			goto scan_again;
 	} else {
 		struct sk_buff *unlinked_skb = NULL;
 
-- 
2.43.5


