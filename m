Return-Path: <netdev+bounces-155028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4FAA00B55
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031713A14DF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0D61FBCA6;
	Fri,  3 Jan 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JiVAV6GK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FlJRwf1E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F551FBC86;
	Fri,  3 Jan 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917666; cv=fail; b=JxqiiodfVWazRrGHqAf266RqQvx/Q8tg03c1pajxGLha4jtGb92FnnFI67y+IkaZ4JRx7W+GrjnWSuvCaLHJVjql3K3erfaPj/4KZFU9/MH3wp04MpuLd1Ob1qOIraIvL7K5dfD0MfLuax77ZuRfFQzzC873K+Aya/jZIJ9kCAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917666; c=relaxed/simple;
	bh=obt3rFtSIYF0ij9vuZUJa0qkD8pbsLNrLbdDpShpAL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sp4GghxEDtLUuOr9n+Gpj0zhBg2IQLfHI6hN29sSM65lSh4TQ6zFwYo9fDw6ltfaE5ubpKPrlLvS3mKiNGwUh+JLvB5O5Dfw7qhFWUKWgP1vch/5rN35IpxOMizCzHz80J216TnbfKa6JELHxqbOZ4iF1kG8XN4z1oeCpMzpbKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JiVAV6GK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FlJRwf1E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503DfrCi012178;
	Fri, 3 Jan 2025 15:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=t5ZJ0blKOai8n8OYAB
	fDDZe6pGSfGOm3XWSGu5MazPk=; b=JiVAV6GKfO6QVj4YQ7JnYn8mOdeNiJxmMQ
	v7rdLffevzUVuTHazLvmkYKFlLRZggrVQ2/vf7Imbqh3/gTLX+Fc5EADxqOPHdfw
	fpbGHi7S7QcyeIS/QsWNTKe6Ini6dATqVuUgaDt5YyEfCdDJTLfaUpvJ+oXbBpeG
	sgOLv7htKuDYpkHiXdTgxMW09/KlEu+y8UYGgk6nFDvzICmn5vFjiAbfmzDWiyAF
	IfbsWAJhcGUTuQZOGUYS/4rgJkZNPyqYspwLfN4d2Sre9H90VirYf/7/pbJwwULA
	GSlFFKvsKLM93gAPCoRBwDDUAhsT3gikmizk5fAS/0PplG2G4Njw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt87vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 15:20:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503DZ1rJ011808;
	Fri, 3 Jan 2025 15:20:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s9uj7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 15:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGaDEEyvNji0DD0fN6kGh+otmm/1qw3RtFKQoRodyPNLCLl7j+XRuwl02li+yBIDJMIhEobp25adyf+tW9IE2wS74kACF0BBavcvEgxkGHlG484kqG/bSYgGJLGHNJpGJUWL6H2hjmNUfimFqiJkQnCqKFLHFdSmzA1W8rmUpazjb1Q/WEps3VW5zMItvrgVuoON8fkPXEXVK80xzqrl99QHGem4hBwLYfXBhgisTzA5ndaxC2dr8N+n+xpY14AuosrYJAs3DkYCv66lekb3EoqVkIPNTQwct+gD2S31q5hGCEzNbNHgQSQimyZGLd1N2AWRO6JLiSfUjB+UP6HMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5ZJ0blKOai8n8OYABfDDZe6pGSfGOm3XWSGu5MazPk=;
 b=KOuJHi9T+nDtvMIkbloaYLiYDx1Q//EY40ZDiX6YK2MROhuBnsKfgBuIucW/5MegE8biel5YVXK/F3T55lLCJPXC7jqbdWk6WuT3OBnKYbiY2+hc3tJBLyJ8YflQFkITiKQHnkSr/3hJo5rfz5UeTZ76nQAQncPQVQsaf/lAFn1fFlNdZxaqxgeKhOaQyj9hIIU2QdiHJrtEocA9EZReBDsHffV359VKh0XPWZP3iKAuQElVpR5gfSIbP/JOAyBdFWGHapj4AbNwZP4U5L4DYszJPYMpXlTnhBMtb4ktYJKYSIG4SfLEpen/fdW8IZwrA4hIssSdLXA+kwR4h135qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5ZJ0blKOai8n8OYABfDDZe6pGSfGOm3XWSGu5MazPk=;
 b=FlJRwf1EKzApfsbNv7Zv0w0E7p9jkHPpcDTJdXNO7zlI37rhdvEy3FXUkp4kjlbJ77tvaD45EWVNIfKagIC3X31OMxSuajwQyO/AglfDlBSvPaAAvh3D6YlvNFQpOPKe2c1235XX0oLMYeTldxGEwkU9RNiEQ3fJHHRDnwmA6D8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM6PR10MB4220.namprd10.prod.outlook.com (2603:10b6:5:221::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 15:20:38 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 15:20:37 +0000
Date: Fri, 3 Jan 2025 10:20:34 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, jannh@google.com,
        jhs@mojatatu.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
Message-ID: <p5ych35cl5ofdzvoobk6uxu4s7f5h3joogy6wee2sq3g4m4mxb@py7tzqwueh74>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>, akpm@linux-foundation.org, davem@davemloft.net, jannh@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vinicius.gomes@intel.com, 
	xiyou.wangcong@gmail.com
References: <6756b479.050a0220.a30f1.0196.GAE@google.com>
 <6777334a.050a0220.3a8527.0058.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6777334a.050a0220.3a8527.0058.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM6PR10MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d7e051-e9eb-4a69-b52b-08dd2c0a2d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?norsUEiV/IZS6DEcnp5BmgHGMnzD5kbAfVm9ShBMfk+2ciFXfT5DjSZ7Acwp?=
 =?us-ascii?Q?eb52UALBTcs4BeuM6ExRV7DOitRK+8VmSRT+5gIycrG67B2v+08GKJbMhdZ2?=
 =?us-ascii?Q?KXdWm5g4bcjrVr0IeASO87ZJTadT/LVL+hA9IwSePylflKSlAFd82wAQEo37?=
 =?us-ascii?Q?7QLfqBhr8mrr3Uelgl0fxxGNC1+C2afwQ480lUQvmBwW/HO1z66pxStfsLjI?=
 =?us-ascii?Q?uywAZch2Lwa8rADBWjK6+opKNNQ8yEIJpTtPplnDObHmVnwERM62xzgSCIXW?=
 =?us-ascii?Q?kb5cTTw09OJrSKNUQFNaCudumCkHWcPjNdOUXZPYe4fcQBqShqyFnZiiTgSj?=
 =?us-ascii?Q?tR0Ti1jWqiE/hVu+wNzm22IeSO/oGBX46F4Aur6Kz6DcifJ0Kx06L4IzVL7S?=
 =?us-ascii?Q?JDeQ3P4qmxxFOFVWE+WYuBdemsU2CUHAraMBmYRoXTbNpVlMnsfMfYEn4Hcx?=
 =?us-ascii?Q?zU07qPtpn41smepMFIO6ppMbW7fiiShDWZRuU1OAEK2s9HzeOiQhkX0JEu8u?=
 =?us-ascii?Q?4HOLYaL5+UvdQ1gdUzlMgPYyK78XUSPi+yfRQEL3rvKl7C2pwL1htRjkHj+D?=
 =?us-ascii?Q?9qW2N53CrIs9LtFcAovwW64zXwtyiGgNvTeE6o8h3rrCSNiy7bHDtDXWSJWM?=
 =?us-ascii?Q?H0bjHKMFRPNy0gFmY2eoDbP27mCnFfPhclmyWV01Lo7sDjaIqhMsqQYtqJo/?=
 =?us-ascii?Q?DsIA8RUugewf+5xAK6zieqEk44TD4h/GpJMk/RHCV8tbX0BFp7QP0wvlE6gL?=
 =?us-ascii?Q?Hzu4n//q25wnkECgRqhse5CISQYMrO1V9tfTO/a6ZZ2D7jTUru2DhiVfw7cC?=
 =?us-ascii?Q?DEp+ZarYr3DRFQ5BxLgyqfIlLabomrGLns7S6jHfy7/29yBb1tjV4uGeBrjP?=
 =?us-ascii?Q?BiDOMc0dKoPruQPHZe7CD0MKMzVfmKQsZ6dXvSJxNYqXGNtfjmRyaXf6fwdL?=
 =?us-ascii?Q?k3GqrQLCIXYtkSqU7qmwHT5RU17TiT8R5r8qG9Voh0auoNYmz3s6k6M2ay3H?=
 =?us-ascii?Q?2aXS4He37pD/EDIHbyGCq8bt/gHSRHAZdeOlbJuHGWs3Qr5dtSEThqKgEiP6?=
 =?us-ascii?Q?CH2ZVabaag8OtLf0S4r5euuyw+7s0b5ZewMnplCVRiOW3fhKHeWQgE7qaX38?=
 =?us-ascii?Q?PYiCvMbsu0xI4fu15wyczESFjs8eSnSz+sZ4p6ThbPRyK1kiGjRMgEd7LZV0?=
 =?us-ascii?Q?s9mZyUdbJEr/RQSYTyKxMf5VjET7bSlgM9w63WxhbJgWwq/o09lDgBCVUTcG?=
 =?us-ascii?Q?EijXiSnStbMMNhPnjthfs2bNNqFniEcxan8vA/Qk+nR4VMostUO0LxAJP8+M?=
 =?us-ascii?Q?O9dQgmDQ0Nb5dCqvbxZhcCV4bKjo9x2XbOQACGIR+8nLkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FeiwR9D8hGI9XIJlHvLE3tv5Jn4braHVkDiweP5Bym4qb1mBuS/EwCiVsipu?=
 =?us-ascii?Q?EVgjK2To0bOO2FvDlWCWj89REOxMHU2PXDCfeEwrz31YfHicSGZDQYaGENz6?=
 =?us-ascii?Q?yCsMw1cqmm+Mi+wueQftkkguS7DW2IpZYDqftJ+XrCC47z/uZ+8IzcJIkn9J?=
 =?us-ascii?Q?c0jvxpj2CMOKJWJkEJxhsImTtufbFbptqyfI299AgJxI7UkEkhC7LclhIwHe?=
 =?us-ascii?Q?vf+Wn2zp5gi/2gd7uKJSvpnHSApC1xqnCS4d5R9EXd4ts8V1VPoDnNSBnHje?=
 =?us-ascii?Q?jh+lttqfhTNkzbSC/3Rh/Dd7HnDF9R9ZP4VARMTlnc2JOh215HliafYyfAPl?=
 =?us-ascii?Q?nkw2oNep7c5wInosgIpmhWIIRQ/LpjNJyjpMKHebBGpHg2kS2AO5g6J5MZhb?=
 =?us-ascii?Q?2jvFm16wgFT35xmReW2tLcp1Z/lFVNmuJOPxvzRZoU2Kq8VWHwF8WH047e3p?=
 =?us-ascii?Q?k6JFoFT3oMYe+l/cyjEoD/gdlNMwbJ3h+LfUpC4SSm1C3bq3mNXJen9gGN2k?=
 =?us-ascii?Q?U6U5g+fsUZjeKCQwFksaK6W3bBA13yXdKUcKFAYGsaEDqeJomIxbbSo5i3SZ?=
 =?us-ascii?Q?9EHlNMrpRfuX/UNy6gt9uxyxxfy/Nrc4TFEBGLN5hlRlxErVFGGWLUOzaG9W?=
 =?us-ascii?Q?VWJ6Ktmr7+w3qgjCWwsVUpBPJuM7PQb4PX/YCanX1a1unq4knT2c7g9TCxgT?=
 =?us-ascii?Q?xfEGGcuJSfD7DHkmV0+AJ6yM6pRYxwlFWaXpdhGkI9EMnnGG9vjMX4774IKf?=
 =?us-ascii?Q?2BcaD52YlLLDZec1ImuOGczj0HTUsO3GOEEruLxKwZfN1FpYubqHbiwUD7P7?=
 =?us-ascii?Q?SQj0qCsQNVp1T4ZCXZWzr+osGNsGb9ign+Ae1U61/oWSC/aDsbTlQLrR+x9I?=
 =?us-ascii?Q?12ximwv93Ml/DdGj+kAbCJfhoUQ4Fgowj6ALF9RpTR3UG4Oz8lt6R8nC67I6?=
 =?us-ascii?Q?Nb4cVq1bg0yRTdQrRXk6aWBLFkvHGY2C8VotbJfBquCnr6UbfuT9ryuKNlwS?=
 =?us-ascii?Q?ZBqzjC01+57WB2SmPFd/Ouxp1mxrlNuCe7M9c9dIZq2nvZ3QaR0CqaaoF9BN?=
 =?us-ascii?Q?hSyxpu/J0bioK8GaZu0iH8woX15rs+VQVSPE4RPzQ0LM8Z+9GG/VrOBBgbTL?=
 =?us-ascii?Q?PmLXb6CDbc8Oket0bGHJlA4ybpu2xMbEjKHp31In5EA5EXsjYOO9rsirNFdh?=
 =?us-ascii?Q?Y5ryMO3sbTW5y5ZUG4U+qCFpDsMnAKDfNZ28glV2NfOY0286UeEN9NDi1dxe?=
 =?us-ascii?Q?IsnZQADgwcyMghlx5uwziGiqN+t1vgm9APQxooJ9UYuDUop4J+0yyCl4AFIY?=
 =?us-ascii?Q?DsMU+XoW94fexpYnfk1oa6ZCJJ457pgEh4nXDoeJxPlaYRFoYOgszbLnfEFr?=
 =?us-ascii?Q?HjR9N0TZkuBHKm0bi7K5Vmwu0BL0bYif3xhdcqrlDgVg7FzrO+Vg0s+nH5Nj?=
 =?us-ascii?Q?TYQx/ywpcYq3rgXJ2B07S9yuKn0rSHngfq3j4Z0a2PoTm3aFAKnLMaRsxg3G?=
 =?us-ascii?Q?hsL1++Cv0AlxDB3DZpWGqq8ffWFGs8/g1op3NrUka9NfYfuKZtWF+pNbP8Jq?=
 =?us-ascii?Q?SeFP4b0RrAOM9y8XthayCV1oZ/s3eqQWgtqa4ndz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wXBFPqBNDPed2i9u214bKwRdW+vtWSE5zfoB8khPC15TpPVR75fRcafkFzbPSVR6oPyiUdnVYbabKzZE20hbEjA0jf5FTYj8c+FOLXjR5Ss1DJKuErwwFEBL2XmYXUPUqdeMCKFa/QZSBZoX4+3v6NeqrsReS1dYJsUOaJoQ1lBmOdtLlvI4IkiDzqRSA97OtYQLS9cfeAu9vNdONsd/fK/7MtLt1VY1DQl1u3/KJeNz03NFMU0VHbZCgZRnX0L8Y4IMELijMyBp3sdX3+n9geGfCPDtp2Vqoqn91Yi8xTblC0fqIUUxAoQpicOisGdXD2JqAVHiVXh23BPs6QSrKPGl5bVUZt53XZgh7dhoC8qR/rk6qtkvDK5VL02bQ35V2J3rAeTAm/WJjxcubmcwkkgOhpCWsYhEjafKolsNEaOlfarEZKMKezerIyncJgevPi9pjC9c+cXWS9A9n1LjU9BAB1Rytg1VzlbxC0oBapf1FU1UXS3dfiwe4qIA5apnw3ZLjPQXGdxex64iM3YV1lk6ab2vK48jYK+fKsC6NSTU8hNUK/x/hZJNMsBLnnGYSMThyBT7NvqwMmM6TCUK+P4UU43Lw2WFe3s+qDZTvKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d7e051-e9eb-4a69-b52b-08dd2c0a2d42
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 15:20:37.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cD0CUm4BGBfpDiuX18V1RIY7dEFrf49XOZEWaYJhYxze9jM9gzSewXTXCmjodbXOOebNEvKohKxPwsVzc4rYFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=793 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030135
X-Proofpoint-GUID: -EaJeKpdtvsQzlXO2bFPQH6VGS6Mj8nM
X-Proofpoint-ORIG-GUID: -EaJeKpdtvsQzlXO2bFPQH6VGS6Mj8nM

* syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com> [250102 19:47]:
> syzbot has bisected this issue to:
> 
> commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
> Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Date:   Sat Sep 29 00:59:43 2018 +0000
> 
>     tc: Add support for configuring the taprio scheduler
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117df818580000
> start commit:   feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=137df818580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=157df818580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=882589c97d51a9de68eb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e8a8df980000
> 
> Reported-by: syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

This looks wrong, if this is a bug (which looks like it is since it has
a syzbot reproducer?), then it's different than the previous two reports
and probably not related.


Vinicius,

Looking at the patch, it seems you missed some users of -1 vs
TAPRIO_ALL_GATES_OPEN in taprio_peek().  The comment in taprio_dequeue()
is useful - maybe the gate_mask rcu lock/unlock could be a function and
have that comment live in a static inline function?

Thanks,
Liam



