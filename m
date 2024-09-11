Return-Path: <netdev+bounces-127419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA1975523
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0D51F2539E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9E19C564;
	Wed, 11 Sep 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LpKfpKac";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jLai+ru4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784C190671
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064359; cv=fail; b=Hz4Hf4qqmxlRLWmQi9IdPc2rb03ULUnVxLJ5gVwwURJD+/hVfPxT5ZNysxt+tDBCEqDJ5+1oU0RZqJLORY2meG+ABD6ZxMeLj7oKnotxjqndyV5FgOpBwCfM/QO5W1jtBNf1ZtmfCw6QjoAfm0LPZgoubfN//izMv6A1eOv4cGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064359; c=relaxed/simple;
	bh=GyHSV/OHgshMYlceTvYZN9nUDGv8m4sai+224IEJg+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Dn/2BxxZ0njgF6+NBG49mCa2eNXZ4LAAV2mIo6SmDjhQqRAcVZ7CScQk678aEa/o+4snHJMj5RtBJ3x2mpc2pyVyVipCgqAobysUeDL2t+sxOwkvZ+OMZH0Xi+IprOtFu6Phd5RUz8vNC+eNZH53EStTAE+Y3OIzdt3Vvb+M+Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LpKfpKac; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jLai+ru4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCgZI9032355;
	Wed, 11 Sep 2024 14:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=sW8sUiLqVpNfYP
	5FceWqluVqwaWdCGHMmqd2bSxxsOg=; b=LpKfpKacvGFA/C2aQwhpRDAZNtiswV
	U+0Kfyy1W6uCdhwFyIE3k6izuy5EnVzZl2Oo08lNDfNMHnsyKvTa9TmaSw8nDxQj
	L541DmdwWTZdWuoifr4rB1xipn5Hbla0N0rNkgYn0se0C52yl/1Jmvi/EqTtrRPv
	bNoBkT8oX/ADN34aPNcXrZ9gvsxaPYcyE35PxDpjyZ2CjFPzYFWCRlJ5T3b5FcR1
	uSkvx1Dig1/+RdlNACLx++wiYD/IRJ5EV6mM8dqJ6hAOJELsjtyg/Sw3hpQmmEBk
	K5xnpO5O3jJiVXOMePWCQGs0SRc9Fj1INNX/VKmvGam1obPdKnmZ/+5g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde08d0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 14:19:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BDHwJb000300;
	Wed, 11 Sep 2024 14:19:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bhckk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 14:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuCxIhiHtLI9KOYjsihKEqZ/O6murS1bxed/BeRmrAQHTd4l7dahozbzRExjF1nV8wTUuSIu3527LAgIJEzDFmULaGG1Iq2VBmB7p6YTjxLxUKSANnLDWGSSz84aheWlhXx2ZZ80zrb9bHJqd/zuwjD0p++AKQAUZEsr89cAU3E0gaNx8UrWpE87WS9DTzB4jzHs6z50XoFFNrWDdthUgvoSGiFcToLm4ruEuc/ivLalOCi3i3MtCEeQMMrrnHGIGqqpd68a+KdyymRHpO+kK+xoBICuFT8qKG+AMClKSfhQTSg9QPllSMfp8hkJdB8gecvvdvsaHAKeXkLg5CDqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW8sUiLqVpNfYP5FceWqluVqwaWdCGHMmqd2bSxxsOg=;
 b=csGHRTdqM3barmJUFbOuJUfasuPI09FGSDgT9cu2jci+OvL10eBqwaw4fuDmwXDpIJpDue6HtTZU/nVDsM1aKnIuOHpFAfpdyT8YD+sQPc7LyD2UHEAc3jwRv67HRQ5qDsRS8XkFa1UYvhoAga31UJ8wUE80wMLEczjoYQ04VDX6DyjBMp10pvyojnPADJ0/ZD9WfEEVsUHjp+QsJaa5T4aOeunA/yIzTLO8cB5/Odbi3URWvSFJOJgJ8QYyF/Vr5QYU8SyeSTsVJoxXyaumP2a/xrZq2SVB5cjObKSZFX1SQ7lKLCT92TtQ3S3K/PchdLn0APmGbHLoTCsUVJo8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW8sUiLqVpNfYP5FceWqluVqwaWdCGHMmqd2bSxxsOg=;
 b=jLai+ru4sLeLwVa/h4YE5CizIWz0d+TsL8EgU0TG5gP6ua72HH9YXOgNkNH54P8uLkV2dF7CtM30NI21Fd2haaDPERIVsB7G6eAPuEPS48q8yBb5MxSAZpxXJ6fT466JeeCTRoqaIolsXFMPIMA9eLkgwRdVOluoTU7VyxUja4k=
Received: from PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5)
 by PH7PR10MB6281.namprd10.prod.outlook.com (2603:10b6:510:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.7; Wed, 11 Sep
 2024 14:18:58 +0000
Received: from PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990]) by PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990%6]) with mapi id 15.20.7939.010; Wed, 11 Sep 2024
 14:18:58 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
        Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
In-Reply-To: <20240910081147-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20240910081147-mutt-send-email-mst@kernel.org>
Date: Wed, 11 Sep 2024 15:18:55 +0100
Message-ID: <m2ed5qnui8.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB8P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::20) To PH8PR10MB6622.namprd10.prod.outlook.com
 (2603:10b6:510:222::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6622:EE_|PH7PR10MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2f4357-61e3-4f16-3a7a-08dcd26cacff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5dfmi4lST4rCdpdH2LkhmFYLrLLGcgiz1/Pxy5DadmRslOBSGqgmDFJ5psjx?=
 =?us-ascii?Q?2zexPBJCZyzgpQlH6UwIeM94rYhV+9Q6vXHmt8sTMuMAHbDLerSUZw4g33rc?=
 =?us-ascii?Q?1LsCgS6DSB3oJhl27jOGob32xcl8iHS3F/x0ipgcLLEobdqE5X0ir0WIEAJs?=
 =?us-ascii?Q?ZjcxBFdORWVDgT7kPJqP1v6fmO/NpHDRJRbvLoCZncN0QAkOeeqBHOIKScr1?=
 =?us-ascii?Q?3vOndIhZf4mzMK/6tuxXZ6t+mWD7a4qQlCb3u9JVxAVVuAlUeQ0nFmgb7c2e?=
 =?us-ascii?Q?ecpRzpEE31azTtQ4uRqSCDiPVEmr0p4Ky8Wz6TwiuNlB6LUdHsIRxUPfyIMd?=
 =?us-ascii?Q?xl6N/1arHOCXJmOD2naATNysajfZWSjlpzyrpm170UsMplusSz/rcC+7oVWp?=
 =?us-ascii?Q?XcCZ4tx7vVUKJiVkpdYT0fSLjMzGUGR55OFk5GiUGCp7GriajI644gNOOn27?=
 =?us-ascii?Q?SOPIrdA/abMp9WSFKakqR3aI9nu7ZUQ296/sY1w7hCbX6tAR7s5O3e57w2HT?=
 =?us-ascii?Q?E09lyBmm65SQq1I6j0nPMJU6b/OZKPZ4xjaKO3p54tlsPtOXWS4aSdDCMXJB?=
 =?us-ascii?Q?y/JBenHfwsnoRpU0t9XgVPAq7KzaPT44aZp2boyqDYgqkjEEAtiz3mOrUfn+?=
 =?us-ascii?Q?MtjhvjgLdu3KiFd5QHe//VT8YWZSw2W2Kc82NOrHq1pkJgzNyORmlb0C7L1C?=
 =?us-ascii?Q?3EO6CktHyhIGeEUeWTaxgcaG7J4mNOXea2E04Cx3AokOx4IJhnjZBrk9TQzX?=
 =?us-ascii?Q?pKIm3p0tfo6tlB67qtkbBJTGLdtsjp0LeyqIv8rnPAkKkk1y4qiTlORWlPW1?=
 =?us-ascii?Q?/qPTTLBlsw54SvPKw1XCub4fzHJtJH05NT4XD0cXbmTVl8feEcYAun8F3mZ8?=
 =?us-ascii?Q?YXoDoDdVik2Y18mKrTgiB1TfExhWtSvVtupirxp3TqdBeXjXdr6IOZgAAZmV?=
 =?us-ascii?Q?OnoyiQFWQlivac7RZCbuQeBgV5hv8f4lniY70BiYAg80WQJxTl7RfdGU4YVU?=
 =?us-ascii?Q?Q04FdFuWzHQ0CYRcqZXvFwuf/Bv7J8Oml32LkK0mg+/cclNJ9d8PO1CeLnAE?=
 =?us-ascii?Q?oIKlP9GkRK1Zdi8ton19G/MNTm/Uki4f7WZ5cHuM9JLLiLcLbQcBC0zVRlE/?=
 =?us-ascii?Q?hwH+apRX1PubChs7jfyFWo+s5kigwIVuaXcUQErY/lzet/hyhuJagbjro/hv?=
 =?us-ascii?Q?fnHsf8tnCRszEOJjEa9GEHbzcvYl2tXpqSkCeadjAqJJh55q7UF2NzG18L7N?=
 =?us-ascii?Q?1QOwtkhpgXFo3pZ8cRgUTIxFbL8eDvg9tLXR0LZhg74FnW5RRoM/8j4v03iC?=
 =?us-ascii?Q?kDufCID4q8iI5ZUW3XiTy+1ZVZfbSOsDTCGnJWIJ0AzOYAYdvzqt3gaWDlIs?=
 =?us-ascii?Q?8+/8nSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGpR4ab5YQ7bD+S3bflXmU1ZIOxn3t8IQwtWjwqcs4ot2IDVBJjGNEpsSwXR?=
 =?us-ascii?Q?f/27MGq6INn1HlSF/oT/xafCyrpin4o8EbHFtMHCdDw4ARcMh9F6DbyWXdgp?=
 =?us-ascii?Q?FFusyqqtsyrSCVfAKMheEJqgk8EZeakS/qXi24rGHIBUTzK9rGixmHk4MT0V?=
 =?us-ascii?Q?V5mNOrMXILKkWzb2gqcqz/ItnlnBq5IQ0VvviAbDVLDw35JX3LQ22/qMQTps?=
 =?us-ascii?Q?G4CcSYMRKxZGk24wrkbeMgRYFx5wniPVxRM0E6vKujwka3bAeMpEP5dqZImb?=
 =?us-ascii?Q?BInVd6cTq/cQKMocGwLr0e5Cb8nEHnhagPobadWxRPQBfC2e5hYgPMPefjDC?=
 =?us-ascii?Q?63ZG+eBog7+CSHK7ME+NjdYzDiic5jQNQ07j5+nRg3lRRfW8nJXqauX9O000?=
 =?us-ascii?Q?U9xgjXThGboDxMCZsnrlEaqZPWpTJWp5UI6+ffh4nruYnJZGgH3to6oxXSDS?=
 =?us-ascii?Q?EjdJZSsrKGPpuUNIQ8TpnQPUXPxZ3IRIwtwvufk5sgDAbMNnk/rNDnFwiOeg?=
 =?us-ascii?Q?a4X4TuMx7bbdFo/4JOnKMnk/77bz4z7BTfVHAN93iaIK1tcVtXiOGnRgUUkd?=
 =?us-ascii?Q?bhkZPNbAF87lUaDtjTYSDM1qrRRefz9ogr+okN0dJxSLA8nHF3AoN6xgteHZ?=
 =?us-ascii?Q?ztRNIC23PUi7rSoj8g+kqd7TCA1NE8O9d1G1QIw92D1QjDX642syc+D6HmWM?=
 =?us-ascii?Q?ch9pvkzTSchTj/dx7k0Fkjui65N+ZcfZ+04nopUxpIdxQr0/+wzKQZNjh4ab?=
 =?us-ascii?Q?sTGUJWO9A6b45lyySBKVZiKmGnTvwWo3N6aeCIpGvQ7vlZkP8l4LjYF1WaTF?=
 =?us-ascii?Q?ssMOyOZwOjxnIp+paRnuRXlEP+hwW1EzVdTD/Skqns5aa8vl7Xj54CSLsvz/?=
 =?us-ascii?Q?nGBP6KpD6wMuiDq8iXAtvRjWpTZ1cU8SDAZWOSlaQaa5zrgInECqbw8ddHAe?=
 =?us-ascii?Q?jqMHDLHdXPB+tYCTk0U4Ho2EjnDd/Po9r0Wt9kWNXtZn9XaD5OdOBX7Cxt7i?=
 =?us-ascii?Q?hNkYe7Z/9P3eyMs1GukSYuKcGa2r/xVGM8xwwMrO+40c29JAw4dS/zOcJ7YL?=
 =?us-ascii?Q?lwGyGO6XXl9Lvyasw8o6WqtNp2rMFOIklwtRZy0V7S82JvHn6r8L4mO2FsJl?=
 =?us-ascii?Q?Liy8uRtnx+QasxldogSR3Movz1nLt4ieQeshUAxu4zBORvHs8XciApHUe5Dg?=
 =?us-ascii?Q?S9zTCngmAocJYDgub1EK8RsCN5L+8yM2LoqqRLspI3MB1MeFgdOocEX6D9Aa?=
 =?us-ascii?Q?ZM/8Xs5MyvkGOJPUkK6lzdVk28nilR+z8EdA0A7DYEPe+Jl21IjlPEND/h9w?=
 =?us-ascii?Q?iaA7Ex1+2EKvmz1bbIEru67KSgPZ531WcdIvsRYyx8FLbyVfhrXuWUz4TnA3?=
 =?us-ascii?Q?WuxWEkq00dB1SOpP+2G51PH9lRV0mpqLGsGw54a/6FiAaEXei1LpuN0G6doF?=
 =?us-ascii?Q?k1BsTk7iZWqpuKPMrwTBY+tYF3amcbSrMYNN6MqLPaPGeeJgmsyBD6FKo0NB?=
 =?us-ascii?Q?ewgrXoJ7kffI1OxX30NC1Lad3Hu3GoEaRY+cs9KxKkPx+1nUCPvOlri5IiF0?=
 =?us-ascii?Q?Af6KGUZ3VruGgJSODvp6itVhYGBrL30BG2aO8WccQJ4yTOkOjsns4m0pgcBc?=
 =?us-ascii?Q?pwCAaWwfSyGMsS8YRytxo0Jspdg0GIeeXxWRWHKIKp1KEKUABj3cXOiK406a?=
 =?us-ascii?Q?A+cPjg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fo/no6pgNl9QyPdaDjHUBaRFiWIJ4ObJjwJB9EC9FDOxbcZhsGd0KCmiPFlgQ2gmhytYCogGL/uQJDizfmAEumV4xK08uIMGQXCNyXeC5M5M7+RQnkHg/QmFWKzbf6m1X4I6IINNlAM5V2GG9pGsi9YtHfRK6AxzL1DN7J+7l8Iqj+m/8BkqRqP0IYJP4/FjuH04Iwf2wIaM8DT5jF5DmA8TaPnA+nYYtrCyqeeq9YdmZgKORaF2oGAEfVFUz2P3U6ld0k23qGFS+w/yKZtYIDAHR90v+3iC87aRlamgLoQvCmIBBM5U9Z8Lg3NpzENw/QLGh8l5h2Olkq2OniiYW6Y3RU011VVxhJTnaMaXCUtHeVFKFeVaZx8qC+DXFngwpTwntHRVR1iZxTLxhEetSKWKwr+X7PWB7ZV6yVTYAvhPYhhC4O1/ITYbjcNbr1mdEQC0Qc2IodbyYN2XgP4H31YGSqzxYYWhJhQL0DLB8sb8AfBRho3911cBJdDfPGu0BXay0GGkwsK1QPyBlP2ZPi3RDNLN/tNRI7y+9NaemlvIXbfOeLxFZCqvZGkB+L7IMWScyRj24W1UWMK5OearfcWugHOj0PnH0tCYA3LXW1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2f4357-61e3-4f16-3a7a-08dcd26cacff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 14:18:58.3323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Dhc8KqTCKSKQ6KKdv8015nNxlYmjv6xCMVLj5KAWNOeX60hD5HFW0tKrWvE+dGeX+o5xIc6ZRwMsQakb4Q6KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110108
X-Proofpoint-ORIG-GUID: gTC6nZwwVXJNdWrX3wP4ui0H-ZR9pNu5
X-Proofpoint-GUID: gTC6nZwwVXJNdWrX3wP4ui0H-ZR9pNu5

For the record, I got a chance to test these changes and confirmed that
they resolved the issue for me when applied on 6.11-rc7.

Tested-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

PS - I'll try get to looking at the other potential fix when I have time.

On Tuesday, 2024-09-10 at 08:12:06 -04, Michael S. Tsirkin wrote:
> On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
>> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
>> 
>> I still think that the patch can fix the problem, I hope Darren can re-test it
>> or give me more info.
>> 
>>     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
>> 
>> If that can not work or Darren can not reply in time, Michael you can try this
>> patch set.
>
> Just making sure netdev maintainers see this, this patch is for net.
>
>> Thanks.
>> 
>> Xuan Zhuo (3):
>>   Revert "virtio_net: rx remove premapped failover code"
>>   Revert "virtio_net: big mode skip the unmap check"
>>   virtio_net: disable premapped mode by default
>> 
>>  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
>>  1 file changed, 46 insertions(+), 49 deletions(-)
>> 
>> --
>> 2.32.0.3.g01195cf9f

