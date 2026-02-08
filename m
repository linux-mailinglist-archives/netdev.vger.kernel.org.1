Return-Path: <netdev+bounces-257848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMOYNRy4iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB91096AD
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F98E3002F5B
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5E34BA2E;
	Sun,  8 Feb 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmoIBTS4"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66A349AE7;
	Sun,  8 Feb 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567212; cv=fail; b=oUf+BKbAlsD7FZl5H7a+ZbzBXKrkEogIXQPeWxCFjFNzurvpCGeH751BfS6i8cJN+zpEgoi3w7dKoH4XUaYgF0wDMdBCYUixj/Y0unWfwAcLlyqcoZV6fgIrGMxvg7OGaY6f3+S4+TKCF6aiPWARwJQ1MashOKxvQuuYZg2S61A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567212; c=relaxed/simple;
	bh=wtatTmG0PTMXPmS1ugup1ru+UK62AtJO5DeJMprcgo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+EqWleZIgIhz2AxGCRQS1pTVpWxGBN/DQAa/UQg5S0kB05HdNxqRJQYU0GY2BqTn5wcYpHFGOv5JhPuYjKNs84wAvnMnrA8I0sgR5wnZDc/FCLIb0m9j9qvUr1cqX+Vj5vShT1jLY3gQ5tcumKA8DmFJMQk6qnaxaflraACO38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmoIBTS4 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeE75UGtwIaNSQ7MjvvV3ZZMlS0GIYDLTFY72huEotwnkdRvRpvELjX0clWP87fNcVJYryMe0SO/7rtFAB1rJdDZ4c6kGrEH5gAlxfplI7RarpQFedIRkZW2V0RsQSzPF6yeqcUqgxWuJxxQJSDhKuv/NuI5oWpdsfGinPbJblPAiPRyYwXXEm/xYzEaSU3yjl4Af5jEe/CkAVGEj8s97k5NFJ3+TlnpqdMYNf762psAu0mn2bDi3a2MudRdiJIgUCsjT5MgS1yKS3JRp+Z3VNKlCHqRdaQEJ4q5FIPy/4g1yXollZjfCmae5tvEVFSIXrl9Ey0wayyJw301LXgzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMztIEnKbWgvPzicj72CtU+m03bJgaDfSOqueWfLWIk=;
 b=wL/kLjIarv2iz862HllhVBjHUQeFA9oJ+GwrgDzrO+htS0wcGadhYEFQ01AUgA6fO/pq6gaQrieFgzERM88X9jjbWvbk6m0DbAqaLX0YwMr0i4JSZKFQv4gjqGFEkfOVEXHhIqHZqzVon/dGF3rnekqvGPuaXphVfhVb2NmQK9yjjtYNfP8vBSWa7ebIlY2HfD8N5lWbCGE21VuSK63Xen4goyGzbNqrpxAVYOl4BcqQZvOODn3NWHL01cotCWzgfzMo074o+MaEVd41csqHty2cZjh/NZf6mqup/vqj2dwFNE8Dhrvrn2lpF4Lk4iZ7ADNvNaGphOomy5v+uaOFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMztIEnKbWgvPzicj72CtU+m03bJgaDfSOqueWfLWIk=;
 b=mmoIBTS481FxW2rTWVXmGQtKVp4ZD/gUVvCibK4UACfrZajLEcM7Zoj6Jzo0Me4cAFXc1m9kj0+FCdQQHXYmuUCv/yFBdYaM2/ke/ofl/067aXgi7lcGkqdKukQCN2mGOYwj290f6S4FJnuTxLhWAalaZcOT1dET7aULMtrvJdvNtvheJlQ5BeYes/8/pi6K1zK2VXGPn8qo/Ecloqnt1OrsDBFzaSLqSxD+Bba5kuJK4Uv+d6LgDvpEaaD7t8LXsUXh7adZvLT5seHgVKzTphXHdHNl4/+R52SIqvriI/d3FlzfqP67mpIJsShR77xuqBzOigpQOEqZOrS9KQqhQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:13:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:13:29 +0000
Date: Sun, 8 Feb 2026 18:13:17 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 14/14] net: bridge: mcast: add inactive state
 assertions
Message-ID: <20260208161317.GN154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-15-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-15-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e18ac6-2623-41ff-a551-08de672cff33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?GzUQa242RiAxFUTKgS0PXXj8rIaNLJyIoMOch30+wL18G1ryNuLWBUZ3ks?=
 =?iso-8859-1?Q?I5SGGtOO4GB1SNWmW1Hn5+ijGAI4Jbo2V1zbRIb/Q6mnpJlu3mOOD7WiML?=
 =?iso-8859-1?Q?oZMTyPISq23CtwBVaswa43EEeRGEVc878SHXlEJYryYI+UqarqEqb+RMbm?=
 =?iso-8859-1?Q?UbwhPTkfvEr9okiImSc+D8A/s2kwjiyT+cf+hIh7f5vryMPXix6F3j/8Ud?=
 =?iso-8859-1?Q?EipmB/ZSi72Cegt0NfYAedoneYJxyQ7nJgVSW3iXFUFXlGHoAT9lO1MJAH?=
 =?iso-8859-1?Q?SIm3c5aDdMzZlToW1nPq8lvDh6SqgV7Ur2ee2m4EeplXKCb/g6jvvD/nPK?=
 =?iso-8859-1?Q?y0klrxSg+GaDrDt2TavFo6HIgyOOpy8uplnYX30aBOa19h6wDvF1xgvhD8?=
 =?iso-8859-1?Q?UfZJPo5ASs15XKBmnxp23vvO1sc7XJf/yviccwi2mDb4wJ2ddaDCaZcaOB?=
 =?iso-8859-1?Q?jWldzJNYKlbxgWYnlpXhwBXEvM72VpmaCk5paOITZCE4g/T+9zw6CCJjT+?=
 =?iso-8859-1?Q?k3DqoXbHAZv78v3NxJ+MitUmelb6U9Haq8UFxN5AIV8XIxDTEfifabUiu9?=
 =?iso-8859-1?Q?gPg8MdQJ9+BgcoF8f/Q4J4ugFWTjzGMxGVesHf2PPsSmvZDwZfyVhoKA10?=
 =?iso-8859-1?Q?lTZJHgR07cF03DcsoNIPkt8ddsZXOYLtFIMd57jGKdQglZ8kt9Ns6eppvK?=
 =?iso-8859-1?Q?vqT01rCDHrT50RRq8SfO6USxK1nzZosVI8CmgcUnyF1wX91dieIcyuTo40?=
 =?iso-8859-1?Q?lORwwIC+0bRrtuM1OiS7doieiuKpwzyv34VzOrVxmHGJg4ijRmwAF/KpXQ?=
 =?iso-8859-1?Q?TCtXADU/dO0UZOztTKSUNoz6RypliZ8A/XeYlMN8tvAfL9R8Yzh0lo1EAD?=
 =?iso-8859-1?Q?ruV05wca2KYul7VLHUrclqZEcKP90MYhdI9t2qbY5fdULo1vO0r/U1rma8?=
 =?iso-8859-1?Q?yqNuBLH36NC/nV/mE1VcEO4+h95s55p71htl+h0H2rSdFQ8kvP1L/X7pVS?=
 =?iso-8859-1?Q?7Mzbn+W7+PAA9oI08+e30mTCz+ks08i+EdaTgq5uftO42blT23BENHodPy?=
 =?iso-8859-1?Q?BxuKRcBHTKbk8NCQjwu46fdD6d9wnwugOFypvwUtUBHrLJHNmbrOGY556Y?=
 =?iso-8859-1?Q?fx+1PDowRn4NF/AO4L+DPbuanTSsntuYvGI/UEmov2V9Ig3wKSQ6OuIndc?=
 =?iso-8859-1?Q?TAXPe8brkAFX8eB0rqk0G7s2lmCBIbn7A08XObcZDNQCvp+p4HZZiu+ucB?=
 =?iso-8859-1?Q?k1Xg+Uy0+dEkO60pHoYSVwEmuj/G7Og7qQpEXaxUiyGQHotSh0ukAbNaC6?=
 =?iso-8859-1?Q?CxW6rZGSXiO6aEGyyBPRpESS8hvSlUT90hu4PHKYfDY0wgZTlfUSpetckH?=
 =?iso-8859-1?Q?CskoF9kujp4AOdFshHuh/aPskYiO7SD+5hCclUoVEG00e2kYmHadBcZw9q?=
 =?iso-8859-1?Q?mvqpN0Jit095ylVdCk4ThFDmgn4BmSYZRFAe9cQ50J1058QGcOz8jxpswN?=
 =?iso-8859-1?Q?f7AnJJpwWRFxaco3acedaj/uFQLMWf0Onvdxm8AxhH6wRYE3uocpchuM8p?=
 =?iso-8859-1?Q?57dw2tWC10Zh5JByypa/ljMfZzqi5M4jDGNK6xvrLlNWH/m5R2FPkI9oK/?=
 =?iso-8859-1?Q?Ipibhv9M9mNkc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wQD+ekRsdxpMrYYepHzhIrptchawqECagxM+/ENyY1gzeUHzc6B/qNqK2O?=
 =?iso-8859-1?Q?DUF0fCd12LPaf36Cnb+FizC85lOQejQq3UuUtoxNb/lxnRCPlY3GmzgzfC?=
 =?iso-8859-1?Q?jzWzTEWBkVxlBOpwTjiymL8g3JQM6b/I+fs/6WL3zTLTgKMjzqPKlHSBbk?=
 =?iso-8859-1?Q?udCLC+GXCaO7QIua/Grrj24YiccRZjC11eo3Djcn/4AEmg3mWHwcJOD3fP?=
 =?iso-8859-1?Q?P2SsTxcFIHgs1LblfRXzXygNRcvTgz/+PBrStl1l3C49AxE6dOND27pYq/?=
 =?iso-8859-1?Q?DOXZsYG4chfbdSfjHIWLzGiXNtq4itCcX/nPudYZ6Mu7XqZTxl+Z7Vz6++?=
 =?iso-8859-1?Q?AzQJnqle0xFNt8LYnCULLg5DFbCcqkNZdB7BC1Y5H/KRXEn6N93PGO1dhX?=
 =?iso-8859-1?Q?2eE9Rv1h4q8HT8t8l7sTY3KOl3Q+ld10nUTFF69bytvQaq2+auaRQ7ft4q?=
 =?iso-8859-1?Q?ImXiWUUBxNWtN/znv8YgGAGgHgNF9z1P8GOvAE5OSomQN2SUW02Snql5oT?=
 =?iso-8859-1?Q?ruj9Z6jUE6czRrQDNGFrK4lPDsIZy6ut3mi7yZ/4vjWRMxnEj6857KmY5H?=
 =?iso-8859-1?Q?5mBFB3KKzTiq6M9G+RY2LUZ9qb9vaj3wwo8i4SZY/OyG4O+eyx8jholtkH?=
 =?iso-8859-1?Q?ePyIlccsc3jrveTMw9cxqaeGz3kXxevYX2eUUyw2OVZUc91o+sSH/34vnZ?=
 =?iso-8859-1?Q?CQWr7oN56jZknVtP22CGnxPro28VfhQIVzBmBI7laDAuuP2G+sBhXSITmR?=
 =?iso-8859-1?Q?uK0yiiqdNDFcrcjBxxhsFHxlQ/UlUqINRLvOY+DJuj5lhjBgGOL7b4B+ZW?=
 =?iso-8859-1?Q?H0+8bRzeT5Raw2Z6wu6wDpOF3LSLbQJBugD48Nz/wO6/4fA4WVFfGWCjYU?=
 =?iso-8859-1?Q?F6Qu5hcmQLHo6qB/UdYGJ6UxUFzlstOAwCx44PuI7x8dge8REn7i0efam4?=
 =?iso-8859-1?Q?wP+ohay+HKIuwlwS+d1DuZRzkABhMZ6WR0tbMH1fv2ckyR7pg0cclGeVre?=
 =?iso-8859-1?Q?DN2umEk0nzAfDEKkVzRaxqayyALGkddGWhtx+bZZteQikp+Ns/HkH7ESit?=
 =?iso-8859-1?Q?v13ogk7SSEBrDXzrX2NdFY4IOnYj5LSGZwav0XfSbOkPNX6xzLl9mCdKwO?=
 =?iso-8859-1?Q?vYRm4WS6L/mjdAP9JPUhOcYLU6/ksTMayTcY/JGm9Ch7MY0gk9nlTOM9zw?=
 =?iso-8859-1?Q?zLQnumLmvr7bNa5Aegs8XIGMIud9dj1VGLHho8vE1919ra6KCvS+pvdqD5?=
 =?iso-8859-1?Q?ia/W4ulxPtCIzZEDPlgymuXwkgcAqj0//tKb31bHTYQGfsQLQqjWFlzoSh?=
 =?iso-8859-1?Q?WG1HywRIPDxD/NjHKOPIXC+DJ0rHlhFPgXwRb0pAbXGf/6/pM8KVGTOEQZ?=
 =?iso-8859-1?Q?TzanKHtnjXnZucYHJkgY1UNsfo3bs4iZYzAnVsdWc9TmqeJ8W0FXqqZhgG?=
 =?iso-8859-1?Q?YdAKWmJ/bnWErrSdYowzWDbIzjf+dTOSkyLRpuc7EIngqfV601rZOkAgJA?=
 =?iso-8859-1?Q?FlpX/ILKAgJTK3ddwaw4Thjks03bpV5uQ/61oneZ6/IA8A4ZCZrc1pi3Pe?=
 =?iso-8859-1?Q?Gg4QcpFuG0FUMYPfIkKrdP3l73HW+4H55C03xXKBLvCNTjFNd+/ySLaOey?=
 =?iso-8859-1?Q?J6R+HCmQFPr0s9dM6AmL4U6htIEHsEMGMwsEj72efOh4O0Eks4ItPgSChl?=
 =?iso-8859-1?Q?4l8V8rcjYpFuSH1nr7khZaayTJQ8xYKslT7mWPW0yIPo0awacnlqNNxH4i?=
 =?iso-8859-1?Q?jSbgnUnGFv6dlPTzR4wFEvApHYLakFTo3xwYaijN1rVcnz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e18ac6-2623-41ff-a551-08de672cff33
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:13:29.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQmasz1KrDVLWjvWl3j0cJ6ncpByDVOR+pnVSkk/uHULjFCaEBpCjkqZpSG4RyRCTS8eL7HPi8n7mGrL4+Mv9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EFDB91096AD
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:20AM +0100, Linus Lüssing wrote:
> @@ -1418,10 +1418,29 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
>  	return NULL;
>  }
>  
> +static void br_ip4_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
> +{
> +	WARN_ON(br_multicast_snooping_active(brmctx, htons(ETH_P_IP), NULL));

Can't this be WARN_ON_ONCE()? If something is actually wrong, WARN_ON()
has the potential to flood the kernel log

> +}
> +
> +static void br_ip6_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
> +{
> +	WARN_ON(br_multicast_snooping_active(brmctx, htons(ETH_P_IPV6), NULL));

Same

> +}

