Return-Path: <netdev+bounces-220651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08833B47897
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D57203CB7
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD67A148832;
	Sun,  7 Sep 2025 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TBF1UHn6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C2VnW56F"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8918EAB
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209370; cv=fail; b=nPyRQJPewqev9WmB0/RENTrpxFAog7bFWqGLJVfkjdPJgVQkxg/Te7cevDE5rN2rLWVC5YfOGNeDUiiX90i5X3E4lxv5yYedKNdPy09gUB8p/5FFksBt01oKclKfQrJe9lkECcfNP7+bXPs0F2UVsuXeR9xBFlS2Q6FQvQbhscg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209370; c=relaxed/simple;
	bh=UT6fPPJBbUoeXrIc+fMR1iCF7JSSuwMtzEenOWCUpLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b0u73P7cAXbkEj0Q3XJZFvdlfCInBIGOG7jnBS238lOBR+3FcSwDhRhiAgGJE8SaltwCSwj7S8K3VwBWMbb936JEo8EJF+c9J0qXAseACdUgHZXvTuHUgSPNp4VWk/J7nlrPiOEPbNtXNSknwMDaYQpm47WRCtlk1gd2L/BWUzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TBF1UHn6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C2VnW56F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5871JwLv011974;
	Sun, 7 Sep 2025 01:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UT6fPPJBbUoeXrIc+fMR1iCF7JSSuwMtzEenOWCUpLA=; b=
	TBF1UHn6b1DLZ5XKGIP6/TKKdzSz82BnviHHTlmuDtWpUGER7McQ6I6Y04bCs0vj
	ggzI8W5tOs+cMBEgfsPYzWFxCfPdiX6CF53Jh9rnROJP2/sz+81ZIBopDmM9utBL
	ImJYbedIQZRqF1PgawLI3gs1tjz5TPlYc3OvkK8vZJZ6g8YtCuujyt8jNSU9RkYj
	7FJbjtJYC/1TBp75w5EXlIAbO7hbHnGYq9UYkZLECtw3bVXx3zL/7OGgESZsmj0T
	1dbXv7OBZfDkxzGyi/FXqmOcZEwbhW5hQfBoH8K6zTAf579xq5hK5fy7yw5MMbKB
	g7KZSdM24kegws3JJ4sWHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49105000bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 01:42:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 586KS0dG026015;
	Sun, 7 Sep 2025 01:42:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd6wg1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 01:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4wWIYk+w3K7OTcma0vUX6J1FxdcaE918+zoU9Pe3pcn/kaBxH94y2ejwMGxjS3dQYX0q7Romf3DDxsLJIEQOuLdl3p1GCW08hKvEflqSnu7SaQJ6kr5mBEAZc7Y/3h8t/SuKX4HlRr+Qi2Nz3jNEoIwlKqqI3TpnMvauAU54LFlIi2lkhZ0pLsuIfjH7hFvuv3Ysi8qx9M4yDQ7xnTpE8pqm/IGEk34zM1/nIj0Xzj+PRCu8J32NsH1hdoPfOgvI81tojMk/YZe9rNxoekzvqxZKI5rY0/rm8koENBwDeL+suA0uINT+kKJyMFgmhubhnZlGuCMkH3l7EOhVn16wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT6fPPJBbUoeXrIc+fMR1iCF7JSSuwMtzEenOWCUpLA=;
 b=GwhZJioa9xreKIoPZAAKiF2Y81DGG4AcDtzNqyGRJ847HGWwI2EAKlgRIu3yS9fr6LgbqVHsIcqYGXpurnaoR0Gs7TkwdOUiDOcf95XcyEQ5VhUkOh+vIwl1Dvg7L2QJMshkacTWPAYnNOMIJhagt60mFxH9tysYHkIoZV261pu/JLP+nXMyxvZFeMX/bBfA8frJMd4Yxtre7V68TjSgjirrL13VzEN6T5wtYqALM+Gax5MNCRhaLJ3CtQL9AoqJpbrNq+sBEkgVNHSbrk4cWra9pOCbAANZdhTS97+/1EpQBMxFr/TkoMnoIaoPJdhz6cfV1oB29trONZNiW4xubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT6fPPJBbUoeXrIc+fMR1iCF7JSSuwMtzEenOWCUpLA=;
 b=C2VnW56FegrVvK9CYKd4ysICGBUEOrMEsgSa5s77f4epG/n1SbZ+Me8kw2fHvWuccyzt4sulCqonLHkfTdiv6xECSF+W4uet4uQx3XtV02fXqR9pgEk1SkpNVSBuzCljJAf2uEBUnyTY7b7u1Uz62HRXmM+YKP+LTq+MwTyvq2c=
Received: from PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5)
 by DS7PR10MB5069.namprd10.prod.outlook.com (2603:10b6:5:3a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Sun, 7 Sep
 2025 01:42:42 +0000
Received: from PH0PR10MB4504.namprd10.prod.outlook.com
 ([fe80::d0be:f934:6ec3:7fcf]) by PH0PR10MB4504.namprd10.prod.outlook.com
 ([fe80::d0be:f934:6ec3:7fcf%6]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 01:42:42 +0000
From: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
To: netdev <netdev@vger.kernel.org>
CC: "sgoutham@marvell.com" <sgoutham@marvell.com>,
        "gakula@marvell.com"
	<gakula@marvell.com>,
        "sbhatta@marvell.com" <sbhatta@marvell.com>,
        "hkelam@marvell.com" <hkelam@marvell.com>,
        "bbhushan2@marvell.com"
	<bbhushan2@marvell.com>,
        Elijah Craig <elijah.craig@oracle.com>,
        Jeff Warren
	<jeffrey.warren@oracle.com>
Subject: Fw: octeontx2 (rvu_nicvf) NETDEV_TX_BUSY state handling
Thread-Topic: octeontx2 (rvu_nicvf) NETDEV_TX_BUSY state handling
Thread-Index: AQHcH5RmOu/c/zvqWkiWPitXjAQCF7SG8Z9w
Date: Sun, 7 Sep 2025 01:42:42 +0000
Message-ID:
 <PH0PR10MB450481C85C4829570F6352D3AC0DA@PH0PR10MB4504.namprd10.prod.outlook.com>
References:
 <PH0PR10MB4504BCA65DAAC15BB640FAFAAC0DA@PH0PR10MB4504.namprd10.prod.outlook.com>
In-Reply-To:
 <PH0PR10MB4504BCA65DAAC15BB640FAFAAC0DA@PH0PR10MB4504.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_|DS7PR10MB5069:EE_
x-ms-office365-filtering-correlation-id: b508651a-8e64-48b6-8367-08ddedafd600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?C2aikvQUV8Lut+3tSvAPMgHDqR64B3Qd05SdHfJo6QByFPUVEPt5JH57cm?=
 =?iso-8859-1?Q?gni8koBJk/YqldEotmYBWe1rm/m+a8l/sVOg3fKLIh1umGAu0g2B56FfgQ?=
 =?iso-8859-1?Q?Lt+C6avqNAIEQMkOcZ50mekFw0IV0l5Y5O/BSsGT4PNORPX5/mazzIKTYI?=
 =?iso-8859-1?Q?E5xxCqgA4Zq59YobpguM6qs30Y9TWHJzNv+40rK3eZxyzrXkO61UbRwnzR?=
 =?iso-8859-1?Q?72MfYLA5AZ/GXVtwkgOkGwr73RaNnEMrfEFjkdsSW/U7vd+eJ3pxGJs1aH?=
 =?iso-8859-1?Q?S0TbKr6TjGm2yKTaNNKaaTczaZ9f87NojuDAn9CS79/GMcJRlxrXNJBOaL?=
 =?iso-8859-1?Q?6EPNuPGWWrNefM0i+TjdxmcewKOzeqnzokgR72SHPyrncu2pJdXlLBj5+Q?=
 =?iso-8859-1?Q?0DQhzcWLW4ZweccDKHeV0BgbHd6E3nOQrO87f2/uBzAPvyE3W5ypm3ylvc?=
 =?iso-8859-1?Q?0VD0NqIFLM9zLgiXFuxam/tG/EwGnlFPrXHbVPfS/H0pFqVm3Pif8FG+Qc?=
 =?iso-8859-1?Q?gj7Q65PhQZ6sVvfZa6BPLjM8x1WfVMGsfzHDobFq/MX2pWRd8bCl5h9Bjw?=
 =?iso-8859-1?Q?NLsJ1dYHq4FjfYJRTI+zdoanoV7YHCgK/8zabG5B4W13echeSUX1qP3Zv3?=
 =?iso-8859-1?Q?eLh6sqT5GjSDKrPdivszk6LGD0Tx9S+0P47bLzeavNGkfQi0/vSUtO2b/X?=
 =?iso-8859-1?Q?WyBAu+SHpPN93hx3yvTwq6ZLjL6CVga/fjspcYqfeyN3FhDjaFW/zzj0nG?=
 =?iso-8859-1?Q?4hbUI71Ix542GmvyntMO/SOfbhnMJ6T12V5IpKwD5p71eQin9mUqdKEYcc?=
 =?iso-8859-1?Q?TSmt9PucJ4qWOecgwm/HeuCo/No9wBQCbN/5KGfKjOzOKeuTuxF7m0AMui?=
 =?iso-8859-1?Q?I3pxxfzzJlm6YtkzUBmOS7KX0h/UJF30PuN6ny3PMNsAFabCVkr5aMazJe?=
 =?iso-8859-1?Q?1UNo2Vfa2Bzq23iDiqA6oWnVXvpZ0feIWm6/sOkq0bK4VR4OTN+RKHhcNH?=
 =?iso-8859-1?Q?lEj7pwqUy1JYzGtl+YlWBBWX6XrRbvKQjY+y2ycwvQiTcrN5MT3TQoqzSs?=
 =?iso-8859-1?Q?hFh71dRFlDR39gxzQ1UQdmgYTYqB2Y+OupnKJbK2o5xuZZ1NojZsxuyUSs?=
 =?iso-8859-1?Q?ZXKYNj/uorNZlkLbIgnh8pxoYzsz9vTRdo0S6Ww/jSfRW/92FIXCjt1ueF?=
 =?iso-8859-1?Q?KnxkmKJjXHg1YDei34433otpC67jY7z/+HRrJN3uqoo3KVBHfNQirVPWlZ?=
 =?iso-8859-1?Q?UR5ofmuDbHLJ53kqlTtp4mKLIxuYSQYGCgdY7NRWyeHDMtWZMRomUvYCxM?=
 =?iso-8859-1?Q?VFtvWo0Ff+kU/imqjx8YpUSrI/ox3J2aN6AP7E/j1+oiY4OgElasSQ5hS4?=
 =?iso-8859-1?Q?tqfLjxSFPoRsf08NJrVN7Nf6YAJyZJBEwkY4meb2AEFnn04xYJh9UVlTVo?=
 =?iso-8859-1?Q?FSBjfar3qKcnxnNa0nWPBrTP8b+XyzbjhZFmZhGuv72lM0cWD+BH9IFeN3?=
 =?iso-8859-1?Q?9KYVvIXAxBJj8lOZoqJY8HiuCGJ0SUxvBc6s6+yHtnWw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4504.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?57RauDTvbYFqk1sURWhsso3cp1MjK9UhbHXaD+e2q79/QX3Z7wHG7R64Wx?=
 =?iso-8859-1?Q?R88xq9Ll91VF/3N4r251rXKKKy+f5M3hq3BlHe/cKxHdrhGrZCzpy1cI5T?=
 =?iso-8859-1?Q?9iWruJX4i/J8cDfBq1NgnStQjs9FbZSFKoW3Yo3D1YcE2ITFtQif0U7g3G?=
 =?iso-8859-1?Q?wOQGHrifT2oKUeWyRTRK6BBMM5ZfbYJmgyWIGkzjdjl8vIz3DmvyR09Asf?=
 =?iso-8859-1?Q?TIaTyBu7/LUMhTbb9X1U718QuMsATxxmzcA7SpHljyGiufxhKRGJ9qGXB6?=
 =?iso-8859-1?Q?f6Gau/Od8VMLBrkbg23kX2jkgzURxhyerwYdWdh9KWtJesx87QY1Nq5v1R?=
 =?iso-8859-1?Q?qHtkNuLQ5lay4OvOipdX/ZCIkqXqp3aLzUwJGrlOOrZI8F5JLjvlHDyE8u?=
 =?iso-8859-1?Q?MBcNixMHNYfAB1nIquSwir+QQRtQ/fFmvozxaA0gkZli7QUsZkRn+rHWdm?=
 =?iso-8859-1?Q?F0UONyNO/a4HOIxRjt/Dx6vrwamQiTprLaupDBUI84kWg2loQeOILnwr5M?=
 =?iso-8859-1?Q?Xbml+zjmyjS8P+MPCRiqkcBSw97rScGyOx8COpxxyRiN95Q3V4jiCWiDtB?=
 =?iso-8859-1?Q?NaQQsrOf6gYIUPD638uOL+gRZ5EJ0fYuT0xhqvBAIxP0qviv/nAPHhNJkg?=
 =?iso-8859-1?Q?g1mKmDVOkSotny7QewgCftHXSooFa6DMrqrt/hsm2RE9UcnxsMbB7e/+gY?=
 =?iso-8859-1?Q?qYCHUxmFxYkfZDunwIj4evgwep1InxdSbm3W2InB6Dk37HytpQJgxRNLM8?=
 =?iso-8859-1?Q?CAOq0SIakAQ9wUr6brsqTPFOBipSH5Uwi9a4U15SKL8cPpOyBqhteb/0gC?=
 =?iso-8859-1?Q?0J6qzcJ440Pu39Jy0tg/KWUVoxUIAogRdp4BzebGZCW9Pn8yiS1rjlUn/I?=
 =?iso-8859-1?Q?1oBxtER5EXVlMjSDMzcXbdNz7nT+8RQ5U1koRrEH7ixcRQcn1XYAkWDb1x?=
 =?iso-8859-1?Q?zJ2KoHvXwPh8nYWh8crHh2hpGgze0Qi4G4ASw0iM2aLDrLgjy4HdMvc5uc?=
 =?iso-8859-1?Q?Up2Zba0OZGpZJT3k8JF6EpPOZt3R+cQrmAnOycO8qLgG4xcUQSVJ7i106C?=
 =?iso-8859-1?Q?DInIR9N6Iok9iWZz8OWqvj5KUXHEys0gCpZh4ulwgY7KesKnj6f9OkwLpG?=
 =?iso-8859-1?Q?TzM8nAPu44Zdcd+xvQoN5iP0toMl087/73z7OsmW6WuslUrqvXwQugNJjL?=
 =?iso-8859-1?Q?q5E0/gEE++s6VytmW2YXbhfK8eHNrWuyUePrn8V8E+9upwBw59zzpl10Zc?=
 =?iso-8859-1?Q?FBUaphe00NkijRpuf4ngt+o6kH9j3B2MUzlC9AkIHJh5HHci4UkszzttDV?=
 =?iso-8859-1?Q?mdQAfPaiYAvOd3iwc8nwD+CagMWL6ORF+OfTuqmeCa0jwenyur7b0qBa1p?=
 =?iso-8859-1?Q?8a4CtvURTR5siXqxDhNt8FKdiUSkZjrRqzeQw66FD60ZxNMG5pS/rwA5sZ?=
 =?iso-8859-1?Q?9AKIYJNW+hLjyBjKmUVXvvaBPqIRR3hjatOqpAP2E52y1GTwDyR6frAzLB?=
 =?iso-8859-1?Q?5boZBWbjLzAoNNnMxsgcs/9VyBUl/dWkc3DL9LIgFFOy6hMLSiABIEzDsE?=
 =?iso-8859-1?Q?cDnqMpQvo2e+RwtMHIzc8wUO7aliuBzR/ZCSOBThZm8Xd1x5AG1SpOOV3W?=
 =?iso-8859-1?Q?D74pUL25fxKF8MpvIm39XMhjhV7xob0zJ8+8zLl7185EMOTxdDeisHQw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b85fd5BkSBVXdsOouOBx8eynQe1TniifYn5B46Uidf7NxHn4gglCkTihm7LZgKmI/Q3x6BvKTelTwy09h1Bo/I+QaILxlDkyxPneOkmDnoPHXTvg1gzPHPx/SpVaN8CSpHB+nyGyhFJNtXQcrr+d3rFBqvP2jELRMRfVL6+8PtKYCmU8MEOe6VIrcuzXufIdGytr9E/kHYYuTXtv1cbll6ITMWOLlKwTeNdZQfbrGVLN2iaYdAHbNou/75F9q0jXZ+1n6j7D+WKxtZsdiW50whXsrhmorTP330cIiyXLbdyWBUjoHYoAU3V5G0eLa5Erqt1SI+0G0OnhIiP0e3kX7pL0bRAPxe6T0rhgqhJ4mdOraGywrReDmq60rsPRFdjWV8HQypIeoR4JxivTK6UVX5YCirvTHGk19Paq3cCCtZuUJwNr1uSzQCWu9A/Q+fFwnJomzJYdn+5iTfYcnvBLe41R6n8Doz2k+YK7KKaRqDEHnX0Nn4qPAVb5olrZzczR0da6HU3r65yRMbw6OFxKwyqNlhQKP6/IAOohO+QKYDAGN7ea0RPJjEEVUolyd3WMYFtZ/Z/ue+Go0gS2ceI484d1fsCp71hOyHk8uETuKGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4504.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b508651a-8e64-48b6-8367-08ddedafd600
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2025 01:42:42.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmHrbFFJ3tCTnDrYQv14M8Gl24LNL4qnYOexZO0fZf1v8axEFpAH05qXpurN6+WL2E4IpcVhv3DD6l1XXTJozdaRqBh80TrTfxDSuoE7xRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_09,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509070014
X-Proofpoint-GUID: j_Or-Up-6B6I0SxK5YCI_BYutF17PgAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDAwOSBTYWx0ZWRfX93XKEiEbHi0o
 Tra9WkSrhMRgCBnC6lKEvKwoOXGcIevWyKjC+WUX+BeJEiqqPapPZOyLhnCfe//FYpcjnSaKIpA
 O+mqjcD147FfSB2qQsOEURkzoOMcxrn0e45tROZQZsXUShNATnMUsKNfBOFMOiEYTuQ8TVOg4+8
 YLfaWWzcY8CW6Jdi+qbfO8Cuds8G0dhhAdQr7LLiyiilNistJ+WK/IgRYeapu4jHzUQfgaDHFG9
 WZT3Caml/EP6ldSq5cWE2FbY3tM3/3nauaMSnpjjV5rYvAT9AMO+628+HTNe6M5usjZuZQ+nSHp
 1dQZ8NGta4ielj3nQ83Ky83hilchSA8ibdMn7PI8vfgej58R9/g5n8iJJjkOFz+hGBmeLZlA181
 G10yfKZNq87IVoIK2QX/MQc3O/Ks2A==
X-Authority-Analysis: v=2.4 cv=VeX3PEp9 c=1 sm=1 tr=0 ts=68bce316 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=6yskOKz03pqOiWeHHDkA:9 a=wPNLvfGTeEIA:10
 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: j_Or-Up-6B6I0SxK5YCI_BYutF17PgAM

3rd Try...Sorry again.=0A=
=0A=
Thanks,=0A=
Venkat=0A=
=0A=
________________________________________=0A=
From:=A0Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>=0A=
Sent:=A0Saturday, September 6, 2025 8:34 PM=0A=
To:=A0netdev <netdev@vger.kernel.org>=0A=
Cc:=A0Elijah Craig <elijah.craig@oracle.com>=0A=
Subject:=A0octeontx2 (rvu_nicvf) NETDEV_TX_BUSY state handling=0A=
=A0=0A=
Hello All,=0A=
=0A=
Would you be able to help us understand the following behavior with octeont=
x2 driver ?=0A=
=0A=
otx2_sq_append_skb():=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 /* Check if there is enough room between producer=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 * and consumer index.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
=A0=A0=A0=A0=A0=A0=A0 free_desc =3D otx2_get_free_sqe(sq);=0A=
=A0=A0=A0=A0=A0=A0=A0 if (free_desc < sq->sqe_thresh)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
=0A=
We get into a situation where free_desc goes below sq->sqe_thresh.=0A=
And remains stuck there. The reason for that is still under investigation.=
=0A=
=0A=
The help we needed was with how that state is handled below.=0A=
=0A=
otx2vf_xmit():=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 if (!otx2_sq_append_skb(vf, txq, sq, skb, qidx)) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 netif_tx_stop_queue(txq);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Check again, incase SQBs g=
ot freed up */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 smp_mb();=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (((sq->num_sqbs - *sq->aur=
a_fc_addr) * sq->sqe_per_sqb)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 > sq->sqe_thresh)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 netif=
_tx_wake_queue(txq);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NETDEV_TX_BUSY;=0A=
=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
With ((sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb) > sq->sqe_thres=
h=A0 remaining true=0A=
txq is kept awake and NETDEV_TX_BUSY returned.=0A=
qdisc resends the packet again and the same sequence repeats (forever).=0A=
=0A=
This gets us into=0A=
i)=A0=A0 high cpu usage by ksoftirqd=0A=
ii)=A0 the tx timeout watchdog timer expiry doesn't trigger=A0 a NIC reset=
=0A=
=A0=A0=A0=A0 since txq continues to remain active.=0A=
=0A=
Pasting some values we had gathered with a trace in the hung state.=0A=
=0A=
=A0otx2_sq_append_skb cons_head 0x890 head 0x6f4 sqe_cnt 0x1000 free_desc 4=
11 sqe_thresh 412=0A=
=A0otx2_sq_append_skb num_sqbs 0x85 aura_fc_addr 0x2 sqe_per_sqb 0x1f=0A=
=0A=
While you are there if you can assist us with the watchdog timer value that=
 is chosen.=0A=
=0A=
/* Time to wait before watchdog kicks off */=0A=
#define OTX2_TX_TIMEOUT=A0=A0=A0=A0=A0=A0=A0=A0 (100 * HZ)=0A=
=0A=
Why is it kept so high compared to other drivers ?=0A=
=0A=
We encountered this problem with Oracle Linux.=0A=
Looking at the latest upstream octeontx2 code it seemed to function the sam=
e way.=0A=
=0A=
We don't have a way to install the latest upstream kernel on the SmartNIC.=
=0A=
Currently we hit this problem once every 2 weeks or even less.=0A=
Pretty much random time it takes.=0A=
=0A=
Thanks for your help.=0A=
=0A=
Thanks,=0A=
Venkat=

