Return-Path: <netdev+bounces-227744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97146BB678C
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 12:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C301A4EBD1B
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF62EACE9;
	Fri,  3 Oct 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="HD/Vssvn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B62EAB88
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488050; cv=fail; b=a4aut7xctkkzJNgA/Co1l7ZWR3PWvLwN6RFHWf2ZFt3Go/kqXT4vocm4F8IpVZ5UGe00pvqxRjV5RlD0t5g3k++uLizqef0haT639JY7RBWeFLNww/G9ozKfyQEKmeGL1r8dGbfMH/QNtITfwttBXO3nfu7zaEieB6wGvfdYxqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488050; c=relaxed/simple;
	bh=xjgG9a/8Fe759OYou89wxYMYtAHWV+58srtUtwy3pbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MvG9lL7sFhr2wPLlXB2+6uWK/IntzWar1pbDjRz0jy8h9OaW80vmqZ5azosr/HeZbJx1LIttzon05eaD5rg7/zadkCHoqE/pdHCGp/DYidgMJoFjxb5O85NJNQuL4j42JSu8KPzh+FAvqjZxrKerJRJJ/dHSyxCf41oFH2pNQ68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HD/Vssvn; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592MDPtt031499;
	Fri, 3 Oct 2025 03:40:39 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021085.outbound.protection.outlook.com [40.107.208.85])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49j20e963e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 03:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X61t3og6So8FQ9fi+w7p/ZJssS83XxJi87oeP15usqKtsSN4QDNMmeI46ld/VPu+5KpdhOGa8g1KuzNZnxX/9RltKESZJ3ME8uHv92ayUP1VleE3MhwmXUGIlQuCPZOzErBX/7Q+hr+Lw6yp/kY24cAu9O7PXPEds5yfRTqo+sKGfRpRRekAOQYF6nuc3ICOVK8uhBH/od5DHoyTWwreskDW9Oi1wZrUiLtKsxGcO8D5XI68GFod2FjRSHpnV/nNVFoMkPXgPtOmkCnWyKEiFbkdPhQThXOgi6tzjneD88D5NYa8I433lNs4zAPaosnklkTjl7haxCK9EBjzi0qopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIdD1YgPUs1b+bfpUw3dr8QjelZ8eu1iimYc/IULBg0=;
 b=qhTZiCUVincP5rMMI1sdW5uFDN4gVYCjnGGeVbwfdgPWeAHh4tGgxVxCbTo9vI3cmmfBkBsnK9Gs1HmKslUheWnqPyYx+CcQmPnJSQ67TPFviCkmzfGxujtXDFvJAXjy+mJl8e7k1Q561Vf6EbnC58Ga0whKCUeVkqoLlqxNute3SLyj2SgrJtXRvhhWzSREa0j7tD4+AdWtpC0LcTsfo8yQcaynPdLw+YF4aA3kE/qH1kcGgQ/Tc14PaK+Z0smJCeeeILtUcNMrYs+13tuxuydbiolsF7NZjJaHSklA4pex6r15miMPxwZKfY3gzHFJlfVbkXGestGua7QpQtcrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIdD1YgPUs1b+bfpUw3dr8QjelZ8eu1iimYc/IULBg0=;
 b=HD/Vssvn2EX7mwIsbhLzcAqunTE0yEI2ipUT/wPcqOJfvUYn30l5YY0NPzoQuAd+AcfAvz5Jh7biO6EnCJKeBe3YbN0cQvdAsUu7tE83K31W3G3hY4hnXpUeSLCsWsQCyvGb6JPS5A4MNExM1xJqyur8XbA4wA2In0CykZman/M=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO6PR18MB4052.namprd18.prod.outlook.com (2603:10b6:5:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:40:31 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%6]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 10:40:31 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Sitnicki <jakub@cloudflare.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] marvell/octeontx2: XDP vs skb headroom reservation
Thread-Topic: [EXTERNAL] marvell/octeontx2: XDP vs skb headroom reservation
Thread-Index: AQHcM5InjbfbJJPlRUGSq+PpEJPSarSwOdbA
Date: Fri, 3 Oct 2025 10:40:30 +0000
Message-ID:
 <CH0PR18MB4339EC12A4676BEE41039F74CDE4A@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <87h5wh34sl.fsf@cloudflare.com>
In-Reply-To: <87h5wh34sl.fsf@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO6PR18MB4052:EE_
x-ms-office365-filtering-correlation-id: a070b5dc-d041-47ba-c5bf-08de0269466c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?57qFS4NVZH3wLwczlHs+fI6UggBwVwUHTZ1tO8R5qPEjHy3B8qNh1PZ2neVa?=
 =?us-ascii?Q?Q9MAMVoqWc+CujdwVJeviEldvJvWWDXkfEQDDN3QfYxyi34B/lYAI4DdZkd5?=
 =?us-ascii?Q?sBQgBLif7cyQrz+4NZGmYR+OgQ7MtU2kiVfRV1+XFY86BOm81OeYyiHb9PSs?=
 =?us-ascii?Q?ic47kDew5bx9o7xMnvZFieaXMdL190d50HgUQT+GaiY35Wn/d5AZdPO2Bhh3?=
 =?us-ascii?Q?ltPbd7+L2sTn5GeHRfyXo17E2QJoLYzB2tbto1SvsHa5XENhW91r6KGwbBAN?=
 =?us-ascii?Q?cINcu9omU8IEJgmNhlweFrunainfJ//JloGe/oToPvdUOZeEPU0Jur8q5tYU?=
 =?us-ascii?Q?V0Kx04xCCoqMLBBBZGKcHcFZXEcgY6RAnVLhGYricttTpaC/TpjaRqIVXOEA?=
 =?us-ascii?Q?RpJNVp+kR+aIZYxwOlD4BScE+Chng7HX2XwL4c+lm5y6KS35nMeVRY+Zr7nv?=
 =?us-ascii?Q?0eyRVv/WPPPk0WbsTxog8p/3JTfd8vDDciTifzzqMIeg+q4RKZ86IAqhwA0l?=
 =?us-ascii?Q?8rczz3BODiswI4jV7jLj/NuRCmDthGws/ynLN2hILGYa+mFaShjD+Ee4p7ax?=
 =?us-ascii?Q?SEJvJNb/J+do+cTqRv5syNZSrOIuF71jhA7Oc/saBlAxgDyg8jz7XBvRUkT7?=
 =?us-ascii?Q?H0GvDYoWMfWrZbUBVuwDfjiUxEdWcZ9X//RF838cXVIYjwi+EBiOnwWSYkti?=
 =?us-ascii?Q?anoKdYvZgfJ6EGa8366Wn3F2dFizlbQM3BuurhMyLPAgjoOsn54DEPPv+HFW?=
 =?us-ascii?Q?iFSIORnQjPZU3IvaepcjQEXnHgODqUd/0EjrRpdGQq4MdxvY1mnxuR/G52+v?=
 =?us-ascii?Q?6v8Nl6xdOr/zIllXIUfD+6U4ZF3RyPkrnbr/nwaY7lStUOlXiugqIn8vusrW?=
 =?us-ascii?Q?q47Syeal/sS0WE/Z7/ng1dW2nj6abWaKcvArj0lF4yYZ/yXSzqcVg9GtGdua?=
 =?us-ascii?Q?v3avHI4nSLDiu0sT9IcDEAvCFi+2uKhdVKAWmr8DN7Z9QGOFtHbttFHV0/Bl?=
 =?us-ascii?Q?XGiPN4dWkc/odDiV+mf2HJAsFtK3MGAsP9uLPDJ2w3mKvam7Peq+BzipWM/J?=
 =?us-ascii?Q?u/ebcvd1IozobRMI7zzH0rwLFrt1ueCbHCFQ2pqfuyX/n4IAiwNaGskTOKqh?=
 =?us-ascii?Q?r+b99iLjmUV980BTXc7mEchvAxtWO+PAgupbbg8c0qqJ/nvh8voi6O7v6gz8?=
 =?us-ascii?Q?XCPIh/Nt+zcmiMta2ANVaHXmG14jwH+xC3VDL4stlU8L8H6lnWdOBCWwdaOO?=
 =?us-ascii?Q?0LcIsXXfEK65fBRgWf8Q1pBlqIgaXnChVpgOIWYKywbf7Iuf5tLl0JtPj0wW?=
 =?us-ascii?Q?RfTcumhJH1w9I38Z56BgC1P392ealOP4EWwzYWfie8gZ73HKLwS6SXccupTO?=
 =?us-ascii?Q?h5r0Rza4Od5q1dIXvax3nOon1omSlGFZ/dIQStZj+4b13SZHHtc1AbLzIzkV?=
 =?us-ascii?Q?PoKyT8QQ1mK6urK6VsNDZZfY8Td/bsZEMia+knisdMDDCngAC7JEvJTODEId?=
 =?us-ascii?Q?vnka56v4spFiNtIoHNZPLLaaeAplTSCgxGw3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ViukI19HF7T20gz5OJKewr2Dy/+Rmb9xb6jWxHUI+QuDvoDnUaZ3GvQUXOSI?=
 =?us-ascii?Q?R+oZEBIuy1I3TgFV0yKjCU8UFFOzE0L+tieXg2B5M2OnW4ikQCp1DdsTZGgF?=
 =?us-ascii?Q?NN9VZWtdQtra3sbdRptU0nqz/Msjjx/k5ieYPdWCvRp0buVRDrZfHJSBvHfl?=
 =?us-ascii?Q?rSnN0sKPb56aNiIkuF0a4+R4j5i3/4EwWIuEK5e/xwtrXtSvu6eF3KETaKSC?=
 =?us-ascii?Q?/dDDTPDEPJWOJ2Gjb2yvBNcq78E+sAfUg0KTZi2uAGSoYfeaWhLGL7ik6NgT?=
 =?us-ascii?Q?eH9PdZeWB5Wdb0tfkw/qSP7dc9SP7TiB4q/bnsx622Baz+LJUHchbR1qj47x?=
 =?us-ascii?Q?nDLq+ubuU5F4RUNYjlPDEc+eYG+j4VjARnB4la0sgAS+iMXd7msPsV7A+soh?=
 =?us-ascii?Q?EV7W3S6j8AGMjdq6gTrXLPl+TIS6F3uz9tHja57TscgiT0XypNFeff336DiM?=
 =?us-ascii?Q?uIb8u80oqYu213YU4ZpzqCydP5d/2XDvTHUkKyn+CU0YvKI5FOie9feNSS8N?=
 =?us-ascii?Q?jfEz/G57Fm62IPU/Qh0Qw0J51H9JiN0w9BE/kU24ftSDpT6pQk/EbF7KeK2f?=
 =?us-ascii?Q?nK/gLqyKuoCqz6tl6Fiikv7uhRSKEqPluDm1m2LnsJRzB+7q0nvfIG1OUwY/?=
 =?us-ascii?Q?0lcSqqZzK42mu62ayykA/g2WE7zXHBHaH7X+YR0ECVFnuUlHKyaCkjRli6Ws?=
 =?us-ascii?Q?4s4nKN254M9WlcwEGekpHnAs55EMhJS0mxK82JiLNJRPTmbt83Rkj42L18FD?=
 =?us-ascii?Q?jd/UpoOLxyFnCU/i71JniHJKblfI62eQkd07k/qz2BBMPwQqELT2mOYa3UJ5?=
 =?us-ascii?Q?gmiFgQDYKb6oc2k0Q5n7V/Vy6UeiuJS9cgYnKQayNBZCmauMZtZmDB6spG5g?=
 =?us-ascii?Q?viI7c4bUWuRgc7GL1TPDrO6wUQ1xUgG9vmVQgmUD4zYPflIgokryjG5l+JHl?=
 =?us-ascii?Q?PuAFhTQdVRSZeJ9b6aFVRY9HSjZonuo5xbkQLMToljZYf7+8Cad1vzVmBmKy?=
 =?us-ascii?Q?dCtCiiIFTC/s6D8sfZmRbSWdd9TzjN8Ghb+Z4YIrj7CmtJC5Qn6Sxn4TV+p+?=
 =?us-ascii?Q?o3J+BXwcg6TqqGI56C8W0+fWJ1EKOE1/900FouayaSCc1O2qhyZYXba3p6wA?=
 =?us-ascii?Q?VALiBUdJrEUPZlGl/AsX1oDk+0HeVFvjzcUZCT55vz7u3g6efXOGidgy+gLG?=
 =?us-ascii?Q?u8cFXDwXARhwkdqRpybBOVRDYOMQ3n8E6VQ/kIJtg5jeJ/m+o+0kUsp4r2sQ?=
 =?us-ascii?Q?roAUvTOsrY4T0D8sCQRfWVIxkVLgpAf0A8w+hRRP+HJMnQCNXq5l1F5/qNiZ?=
 =?us-ascii?Q?Gi/OfOqrslX3zpfjN/d5aTaVAGDC2dl60bZdLNgW5Zrjy5WGEIall1567Liq?=
 =?us-ascii?Q?G5LB1zTXYQ0oact3tmN0/u4rwMWRSwF23Z7po8djgT6Riv+RXvg/j2Y7QqCn?=
 =?us-ascii?Q?o0caxdnPQWYhS/qfcGBxAruGVVhWEjD/BLxj89kXOcGVLXdgHHL+LX0x5DYi?=
 =?us-ascii?Q?39th2G1jPnvaukePH32XrSOkiZxaGCQVKUguBMLiq3KhfZvFDF87ZeQf/BD1?=
 =?us-ascii?Q?6lZQlsf90WrzWblwsxc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a070b5dc-d041-47ba-c5bf-08de0269466c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:40:30.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwI/AzFnlhuKMLNqBmJ59FxOOi3udBlBzlSCQlB6ZE1KNc/z4btSFG8g2Omz8jDY2SiyZbtEMxODSdsQK39YfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4052
X-Authority-Analysis: v=2.4 cv=S4PUAYsP c=1 sm=1 tr=0 ts=68dfa826 cx=c_pps a=XA5JAPkejx3wACcd+9zdpQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=EG7W4yiQAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=4o6iFKJAwfiUD_TeAIIA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: 7tL3iWoUsClbazfZg2Mv4AoZeD26tetj
X-Proofpoint-ORIG-GUID: 7tL3iWoUsClbazfZg2Mv4AoZeD26tetj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDE5NCBTYWx0ZWRfXyB55oVS8nk6J q3lFSRMBSC34jjeUS1KpKWdUnkVSEFZv3TGeD1r/cqed1rrQqSFpHaP7AiVc7WvIw719aYgGZpk A6NdtllLGge9cfpj9/tm6rp0MCGEVcRpeb9gKAL9Cfvli6HQbKFh2NHhM0ge85TWZNXOP1vl4Og
 YHcjulWG+cw58iNS7WqYIxl0ug4xhbl73i23DJWO0SJ15w96wjEeDP+8L1wckCJuH+kzYc/CKwa 4UNaDp/d2Otg9N+9z9k3D+9wLcU4iLpJhz02thYmCaNsclTTAa+zKIostcekEyEtumLQrzX2Qxc PTCa3u4sZpRWCYDJ/P1duyeGmltJxa2Ysmua68+IAYSCxvoSntad49KSx2x9jtB/vidB2emX+MJ
 ZnmZ5gmx2GUM3JQUEg96d5Csj5iHpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01

Hi,

>-----Original Message-----
>From: Jakub Sitnicki <jakub@cloudflare.com>
>Sent: Thursday, October 2, 2025 5:16 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; Bharat Bhushan
><bbhushan2@marvell.com>
>Cc: netdev@vger.kernel.org
>Subject: [EXTERNAL] marvell/octeontx2: XDP vs skb headroom reservation
>
>Hi,
>
>I'm auditing calls to skb_metadata_set() in drivers and something seems of=
f in
>oceontx2. I may be completely misreading the code. I'm a total stranger to=
 that
>driver.
>
>It would seem that there is a difference between the amount of headroom th=
at
>the driver reserves for the XDP buffer vs the skb that is built from on th=
at
>buffer, while the two should match.
>
>In the receive handler we have:
>
>otx2_rcv_pkt_handler
>  otx2_xdp_rcv_pkt_handler if pfvf->xdp_prog
>    xdp_prepare_buff(..., OTX2_HEAD_ROOM, ...)
>      where OTX2_HEAD_ROOM =3D OTX2_ALIGN =3D 128
>  skb =3D napi_get_frags
>    napi_alloc_skb
>      skb_reserve(NET_SKB_PAD + NET_IP_ALIGN)
>        where NET_SKB_PAD =3D 64, NET_IP_ALIGN =3D 0 on x86
>  napi_gro_frags
>
>There are no other calls to skb_reserve there, so we seem to have a mismat=
ch.
>128B of headroom in XDP buff, and only 64B of headroom in skb head.
>
>Again, I could be totally wrong about this, I'm not familiar with the driv=
er, but I
>thought you might want to double check this.
>

The otx2 netdev driver calculates the receive buffer size to accommodate th=
e full network
packet as follows:
hw.buf_len =3D mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
In addition, it reserves OTX2_HEAD_ROOM (128 bytes). The hardware actually =
copies
the packet starting at (u64*)bufptr + OTX2_HEAD_ROOM. This means the SKB ha=
s=20
128 bytes of headroom available, which is especially useful in the XDP case=
 for adding any extra headers.

static int otx2_get_rbuf_size(struct otx2_nic *pf, int mtu)
{
        int frame_size;
        int total_size;
        int rbuf_size;

        if (pf->hw.rbuf_len)
                return ALIGN(pf->hw.rbuf_len, OTX2_ALIGN) + OTX2_HEAD_ROOM;
Thanks,
Geetha.
>Thanks,
>-jkbs

