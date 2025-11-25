Return-Path: <netdev+bounces-241606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D6C86C2A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176D33A5407
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8028D8D0;
	Tue, 25 Nov 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="piSsr1LS";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZMw2rmBw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58BB26059B;
	Tue, 25 Nov 2025 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098326; cv=fail; b=twvKEscoM7HTOH1hj37LT7O7HiHrBRJSrze92sxkv69Xg00LGRWrKDsiXDL3BlreuQpwMXy14TkBiyXfz6cGVZDmCJh3U1CjxozkXpT5q8d5W2AtYAH/HeQujf7R3xnn6+oqSYOSMWCldF5E34tx0tqyNYZmaCW3eSWtxYIOYYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098326; c=relaxed/simple;
	bh=9KUS/WSQboAU5BXco0DnxzmnV3JadHZzFUfqcmjPIrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mwva2+s0yF7HjNqL+TjV4IMgfbVNRdrhxytS+hKt2oI0xCu2WQ1ezRZfZgAI5CLqe1yXu9p4BtQ0lCxfDuhxVdRRVjMenSLANVIaX8ueBu66x4zx0NrlSnWBK5Efb+EOQ41YDnboD099M4puBwyyLPsONnumiwMCv6qyuWXm7P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=piSsr1LS; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZMw2rmBw; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKdIE2184064;
	Tue, 25 Nov 2025 11:18:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=tRFBJ+tjWmhMsfOj8PS1Q4yYnJ3vZ3THk54vCAEPV
	CI=; b=piSsr1LSMUV6b1AsxJKddH6cDqD3kIm/n9+2NhAkMHI/DiR33qzwvvhfx
	DHtPWI94UzrODHmihmPI9S2yc/RnN1bt/+ItKZfI2j4gMzTKrvxkFUkB/iSY8lA/
	h+qEyBIXMKYDF296sAhjYCdWNvi+0qafxMc6w96OEivz2kew2kM4Gb+30bfhpQSQ
	jFNt7rvSaD532Ledl/fUVoCefd3cEm4GIDXLEXqHlqixKUjnCRXaHXtqh16LGtov
	N09bCLMI9CH2zXaeykUtED6WazVebX98jZTKm0iAMwTk72i2qoCtfH7hFiHKpIbl
	LPZg9/Z0iMNLu1JXWWbFbxPzSdRcQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022083.outbound.protection.outlook.com [40.107.200.83])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40cv1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC0WlWqObkp/0fmr3vq4+KBDK8yLhztspTA1utw8C2xOE9YQtAUxQWQBhOdGPuOppx2+z5Z8NGsYKQ5IVxcKCadZ+HhE9eLmOIxSMny/m0jvIKGEjFk86UYT6qwfrJPDFDrUwcMt242RCkfZL9EL1gLmK+BKqSed2uex34U2C52Zhfny6ZZzT7xxgcvCtNMauPP5gck+RTYCLvefq6HESMnLTf9+s4+lLqF7TqS/kR1ldJSsQEN5QraZ5j3Pl5Aq2JalT8LnkATsY8TAaxDTdIfFzgfmKCDTX4waxMaSbizIWpeBG4XOypHGCyl0MFU8oaGoRD0cKVLzxZxDiT0Xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRFBJ+tjWmhMsfOj8PS1Q4yYnJ3vZ3THk54vCAEPVCI=;
 b=iqWtnCKaQgNIO94pSe+Pj81moUw7m4yUk3G9CUaXNWf/8/1Mb345Q61OS3bgu9tpef6bGg8tePy+LAPCXCWDhjkZ5lLj9gVmXX53jFs1cWXDScRfW1Q9eSLQglgB5LtJq8nXejRKkW9ANv6vrdR2V6DMMztlWUBML4VDMQPKvaGoTY4NrHMuwxFtbnZOvBzmvYoHt7c0F2sOAjc6zONnaeVzOjm04pABb9lGEy5vXP35eRVyAaQJOrKbcWK90CUuZLFTp+RrCP9Ix7e3bJ8EVfcfFVp9l2I+IyaH7YbkjIpk/hIKtXQC+zmBwlFr3pukSvvAmwQjmKZMlqHSaLNPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRFBJ+tjWmhMsfOj8PS1Q4yYnJ3vZ3THk54vCAEPVCI=;
 b=ZMw2rmBw9e6/KR7O3byeI6CoBgezSjY6VO69+R9TKcTmKS91N1KG5DKA85GqNHQ5iNghJCjoo6oNtg1f2rMQHcMDap1y8k8uMvrEJOSIdDV/Jro0CQ2iKM45BD7+NOCHMjIFKsRZ4dJzltEgfUwepE2hf84Gyz+akfg6qLv3NV/zKF+rNeCuhQTisLfMxuROJhYv7m9nGGGy3l4TgqQGDnGfcCTF/Qt5FzErF1CbN3s8DYO+DMrIIWLoXcBGT5xzpNNuktrixaDJidkcUUdqAZ/JVFUbV67s66z6BMFujk0J3lDGqcxN2JIm6lHt2d8P11uaRwlGIPtPDz7wibv//Q==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:29 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:29 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 3/9] tun: correct drop statistics in tun_put_user
Date: Tue, 25 Nov 2025 13:00:30 -0700
Message-ID: <20251125200041.1565663-4-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 07477e0f-30c4-4533-f394-08de2c576a36
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kH+4lz4hUyXcq/nfJObv5PgpztaT7IqpywyLnHY6VK9LWqkz6eGomD4yicxV?=
 =?us-ascii?Q?aORUDXSd8Xuomr/SpdDDOzvgglqFFJJacIwSfSsWM7NuKEli1U38d15S6sii?=
 =?us-ascii?Q?S5OVXPZqRZxgebBXGupOWEbSKlJlDRILZcWkkKwUku85w/aGk6OHuYzdy7o3?=
 =?us-ascii?Q?21Y7VzLruaMHIlrWxnjfrZdRAxjqHg1c3Ym82R46JQYd497LdhmggqkyqCV4?=
 =?us-ascii?Q?iWfBnVxFI0Z8Q/60IH17IetMksYpC2jhxx3F5CizrcHol+nCKuwMZzVLv304?=
 =?us-ascii?Q?V64nxiWDAEy3zU0xwtd/xbTalbR0FJCtarm7mJeoiowTekO5yvCPCmcuBos2?=
 =?us-ascii?Q?wa0gDkXGs3pSgbb4j9BZnzPCh8lwlqSujW40aK2M/54EpnRBfNa5E36W3ApU?=
 =?us-ascii?Q?g7Epsf+6IBDY3/eiYIL9W9hgIsldFdfFjRHKJidM/n8kdNzVrLBt5kXKIQGd?=
 =?us-ascii?Q?mnUYW2T1PkGj8ahI/Kfx2KFCXPA2CPN7j8FGxu+JlWZrkQcYcTmuAo6dWYbB?=
 =?us-ascii?Q?8+RbNtBHXLd30bIvLzuo6orZUdgI4BtmNaI40Re2wNc3kUsiJbV62uzabl3p?=
 =?us-ascii?Q?vSxPHRb3HR7tLeBlQKro7LDsYp6EEW4u1jKYYVqGufjYjlG3yLpMlm6Rx5xp?=
 =?us-ascii?Q?IlmkZziC5WdpNc0GaawHofznbtcDEqBlghHowgeTbNOwDJpn1sAKZDWZtV73?=
 =?us-ascii?Q?Roni8wKfmQajydArcyrRiK48iAQGV7yi/fUvZ6/oL5vyB37wdySBVOfw00/U?=
 =?us-ascii?Q?/s1wfifzoLNoZTEvfE0aRcuS7QXpgzWS4/nYuxI2te2GoHcYWpUdd7gkI+x2?=
 =?us-ascii?Q?ERJ1sarNMF2ZeRnq8hXZXRMgizOGH4a2r0T1jiCBLyFSPqntNksnPi+g8QRk?=
 =?us-ascii?Q?kfilXSdSjOulZS602FC9RfuYDj4yJcxoo1/rdU62PpDnykY+R6V0iUWCpnro?=
 =?us-ascii?Q?UCHwSeviyhjFOYiH741De8WcPt0qfG01BvVBdopNw8jvnllZ+kML/CutHkxz?=
 =?us-ascii?Q?t2/NIhY5nhndOVA6LEqJOM1aP1G+6CF096IZ1dSPKEzVRaoo+fprncnnh5SJ?=
 =?us-ascii?Q?O2mHd7q46SjdiRvNjwkT/ZLsB9JULEsHvDeUeclFui5MI0kd1iNuQhUW7+6K?=
 =?us-ascii?Q?B/en0sBVdZ55PXdB3ld7jpKQbbmvUnjNkj7+9VVaB1q0zb8UX8rA83FmnaiE?=
 =?us-ascii?Q?e9uj82RlHbQk/Q26Kdvr4zDEJVWsbEv8VHOt1zC0GZ5tkzPXWCR419KTPF8P?=
 =?us-ascii?Q?Hw+oUCCG7wY4qQba99nLwAMJC0EJ91D8GJnIPsQP0zfj+sndjMFy81r0uylf?=
 =?us-ascii?Q?Bzhcu5H9ayLXn8+bFWNWwDgIRe/KomVAQaj33FFeLTKeWhfoTsqhINQriAln?=
 =?us-ascii?Q?4u7JTPiD6L/l3cl6RITCcUwb7ml2UV3rTtF6oUIJo6guze0HLOxiXK4neNLV?=
 =?us-ascii?Q?LhudExLvsJ97NDiSFz1xzmNGQEFsrKrBR96k2bequH+s8oe4glujLFFB3tDl?=
 =?us-ascii?Q?hX4Bt5dDqGDfjlYk3EZ+mvFvda2EsWk2vFIJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCqBVqvGhLwE84uy3/8TUN2VUOcxQukZiUQrubo1uK2Q+x+ZBRV1vYRsLNhx?=
 =?us-ascii?Q?mm4Md1pffjx4vKeGv5xO/Qpvynu/DRha1+J/l0EixXtafvnfedF3oOcvzT+v?=
 =?us-ascii?Q?9ZAs0kr+XVBbZ1tRwKJJFHq2p4bg+eRVT2tkReaQUjiHml0skfzvGvDenCv6?=
 =?us-ascii?Q?J1+/IJjbG8Mp+Bveo1jsFquYEeqsiNtoiMFnL+G55oRA7TpIaVgdb+vPGHrV?=
 =?us-ascii?Q?j5Ytry6D2ErCbNOW+44ntdMrjZXxyfJalc7G7QRITzavKZ8Zh2QJUlK9h6GW?=
 =?us-ascii?Q?vGeEJFYP/nZ4hRuS038RZgIB43br+5HENkj45QAMMNx4RTkX2nW3ucBKPmKj?=
 =?us-ascii?Q?DAenpUM65BH0Vbt4J3Ne+3BY+WriCNSptHOE/FhdwK1MO9oN928pimQuqh1R?=
 =?us-ascii?Q?SfrGN7CthUTVwEQU1ndl87R+q1EgwPedoINvgNjXgE6AlxIIHvLh766zUyFy?=
 =?us-ascii?Q?1usJrNMxZ4ZnXDlVLptiOfjaOiHN7BXd1nmi6/4xgPnlOu8k9+jL3GfyDtv6?=
 =?us-ascii?Q?zzfI5D1MeQmzG3FGypYkuNRzQV1FryYXSA60Om3lu/E7X25oWQBpqC4RWZoh?=
 =?us-ascii?Q?miyWjvo8SsPLW4rvlQFmVwlPEZepUB8SJlU4+/Nx37w75CrO8VrcQBqWcNu5?=
 =?us-ascii?Q?NjtEmZkC4//IotYbvjbYvNmLCoBZQUphxzgUQmKdw4CwE716nGwqOmPAGVE4?=
 =?us-ascii?Q?9hua7juX8qmBcs4g8L45sB5r4VtSPgJg19eSJBIbVT5ALIuF2D4/Wya4hig2?=
 =?us-ascii?Q?o7jH9NXTKBu13BJHjok780uX7rBj7ulPW6zP9aoIg2oHuHZx0xdKmtApoEya?=
 =?us-ascii?Q?mG8DZ4mGhufpqN1QACiIRcalBf7yTzTUdF7F2an6cngk+0ka17eyZt/HebBX?=
 =?us-ascii?Q?A5KKyE7mUJJlkKTc4Bd7PwK06XkE5UJ9rfMsB93/mvhcpwYuZTkASW+hzMju?=
 =?us-ascii?Q?TyQhNzTBNnX9XEWU9my3HfhkT71HMvDOrxnN5KVX6198AALd6ryEtd2tYZd7?=
 =?us-ascii?Q?0OvJelPyPlSGOGI2gM4f+Yv7C8SlG5aU1hTG0cJ94ZYIWO//5ilJBBLY3gzm?=
 =?us-ascii?Q?4WVJDrHRFoOVHazzzK/J9resEWVMbsFdGbv5hZgLxLesllOQIpo42IbrA2zM?=
 =?us-ascii?Q?kVQy31rSLstUxNZ/8PHRsPahgpf+pIaIchL2+PckQWNvk/fRcfJgApGPQwPP?=
 =?us-ascii?Q?gI0hKJPeC6h0zeo+N5cipyu4VEXU8mJAwh35adyf5e8BvSvOc53P50lG9Fb5?=
 =?us-ascii?Q?mADwh7rsVCd6lC1ml9WfNrjiaFfOF63jFvkSg1q65QdNuMLMemuvEaeVxjzi?=
 =?us-ascii?Q?hJLURezU4OaKxidd4bkoCk5Oe7d45zSgROnbFa4Zd3/oyaLLHsO4rdVNT7Ji?=
 =?us-ascii?Q?xymSPrCZJ7HvLW81dvb3MAXjEpFHohip5eywdFzE1Hzo2lkglJl73GCwzABU?=
 =?us-ascii?Q?xBEMfybzpOoUy6f3m9uBsHh6NLWJUPL+56GobF0+coWrTnkwIvhtbkwJyzOI?=
 =?us-ascii?Q?9BjJB0OOCtyigMqcwnkYRj+AMXbs8/TWBvTek6GmJ48WDgFMjfdO5mtlnOKY?=
 =?us-ascii?Q?Ugf+lP5ZMU2pLqJJtp2MHEtEvL03xXAG7CdKS8DERhYfSIonecmwrz8wZBD6?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07477e0f-30c4-4533-f394-08de2c576a36
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:29.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MG0SbquRqj/UDp2XHd6CLzDrwKcmf9ivU+xl/tPAyDse9WMafLxVtYaNRjUEG6x/BA3dxCa90lhdX1BNdGzOzJLuZg1qigOkx4VhXeqRbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: yzMwZ2tMMi16TzIBCB8pJ6semHETfRWd
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=69260107 cx=c_pps
 a=ZzZLShWY4Ra8+E12r48fxg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=SxyIRvtkA3-codSjkzAA:9
X-Proofpoint-ORIG-GUID: yzMwZ2tMMi16TzIBCB8pJ6semHETfRWd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfX7MDxF17KTcTJ
 bKTAezSlXhEXBTm0Dsh6KObZOOBa+xFuFtMHIi+Ltw/ASkeC20J6/glbW/pPe375m03t3l3VoPP
 IGFcAwQky96Xwl31ZOPi4aFQK7HWB0BZzRvqnvJ9kYM/u+Zd6ha1H6AN7/z6fYANiv1ltWoTWw0
 ZwSo0jPJQcm3YyonG9pIniv/usJedDx96tbX6KAz7Swpe2Jd094oqQ3vFofSmlI41CvpkZYdBlY
 NO5TY1ECJb73fR6DgBQBCYnhYXI6jACBqpx5N6A9yJmStCQxblX/5OyvXX0cGl2rTOp1BdvI3Hs
 4lc+yXJB50EdAeaUAOVm27YpQXC9AdZpWAcvQVP/5H79mjT3bRU2heAUwzTSK/i1bVfSlRqz0O1
 lqWOEyG4XQ4Bu/Ow4UCWw8X4dLkwGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Fold kfree_skb and consume_skb for tun_put_user into tun_put_user and
rework kfree_skb to take a drop reason. Add drop reason to all drop
sites and ensure that all failing paths properly increment drop
counter.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 51 +++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 68ad46ab04a4..e0f5e1fe4bd0 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2035,6 +2035,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 			    struct sk_buff *skb,
 			    struct iov_iter *iter)
 {
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct tun_pi pi = { 0, skb->protocol };
 	ssize_t total;
 	int vlan_offset = 0;
@@ -2051,8 +2052,11 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	total = skb->len + vlan_hlen + vnet_hdr_sz;
 
 	if (!(tun->flags & IFF_NO_PI)) {
-		if (iov_iter_count(iter) < sizeof(pi))
-			return -EINVAL;
+		if (iov_iter_count(iter) < sizeof(pi)) {
+			ret = -EINVAL;
+			drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
+			goto drop;
+		}
 
 		total += sizeof(pi);
 		if (iov_iter_count(iter) < total) {
@@ -2060,8 +2064,11 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 			pi.flags |= TUN_PKT_STRIP;
 		}
 
-		if (copy_to_iter(&pi, sizeof(pi), iter) != sizeof(pi))
-			return -EFAULT;
+		if (copy_to_iter(&pi, sizeof(pi), iter) != sizeof(pi)) {
+			ret = -EFAULT;
+			drop_reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
+			goto drop;
+		}
 	}
 
 	if (vnet_hdr_sz) {
@@ -2070,8 +2077,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
 						&hdr);
-		if (ret)
-			return ret;
+		if (ret) {
+			drop_reason = SKB_DROP_REASON_DEV_HDR;
+			goto drop;
+		}
 
 		/*
 		 * Drop the packet if the configured header size is too small
@@ -2080,8 +2089,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		gso = (struct virtio_net_hdr *)&hdr;
 		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
 					 iter, gso);
-		if (ret)
-			return ret;
+		if (ret) {
+			drop_reason = SKB_DROP_REASON_DEV_HDR;
+			goto drop;
+		}
 	}
 
 	if (vlan_hlen) {
@@ -2094,23 +2105,33 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		vlan_offset = offsetof(struct vlan_ethhdr, h_vlan_proto);
 
 		ret = skb_copy_datagram_iter(skb, 0, iter, vlan_offset);
-		if (ret || !iov_iter_count(iter))
-			goto done;
+		if (ret || !iov_iter_count(iter)) {
+			drop_reason = SKB_DROP_REASON_DEV_HDR;
+			goto drop;
+		}
 
 		ret = copy_to_iter(&veth, sizeof(veth), iter);
-		if (ret != sizeof(veth) || !iov_iter_count(iter))
-			goto done;
+		if (ret != sizeof(veth) || !iov_iter_count(iter)) {
+			drop_reason = SKB_DROP_REASON_DEV_HDR;
+			goto drop;
+		}
 	}
 
 	skb_copy_datagram_iter(skb, vlan_offset, iter, skb->len - vlan_offset);
 
-done:
 	/* caller is in process context, */
 	preempt_disable();
 	dev_sw_netstats_tx_add(tun->dev, 1, skb->len + vlan_hlen);
 	preempt_enable();
 
+	consume_skb(skb);
+
 	return total;
+
+drop:
+	dev_core_stats_tx_dropped_inc(tun->dev);
+	kfree_skb_reason(skb, drop_reason);
+	return ret;
 }
 
 static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
@@ -2182,10 +2203,6 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 		struct sk_buff *skb = ptr;
 
 		ret = tun_put_user(tun, tfile, skb, to);
-		if (unlikely(ret < 0))
-			kfree_skb(skb);
-		else
-			consume_skb(skb);
 	}
 
 	return ret;
-- 
2.43.0


