Return-Path: <netdev+bounces-124826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3082996B164
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541EC1C2407A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048DD12C491;
	Wed,  4 Sep 2024 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XF7qm9kk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RU9p21Lg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C0823DE;
	Wed,  4 Sep 2024 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430711; cv=fail; b=GnCHe36hAy4AEYbsBp6aXhTy4UI2fSCd/ZRdkwzWnINNGlpPDnPhftDRb7fmXQvsXi4p/iaXrnxdmLtV4hB21C9oUMrRXz5jaz3FHG97ogTZKXk02MdxrIX+CIT8k5ng3WaCADRkOe6+C+eqnx4SGEUljMdjaWrKvsg9qOy5GCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430711; c=relaxed/simple;
	bh=0qdfX8caTI6hYj8y1Hbp56BJqkIvnXXpUXi8xL/k2AE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ZUCsc2LDc/o0qtoCDRwIjTJk4FDk4JvxNTJ+knEwblYnemDMAEZhmacadJi41p41GOmhUpSyxEHOd3EnMWE1TUN3xZ+zOpsNII+x2kT+sdDKGkm/v/LoDZtv0sO6BqN2hf9Y26LSnpeiK1xM088iQUspnTKuUUIpLtQdN0gPk3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XF7qm9kk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RU9p21Lg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841MYcQ016072;
	Wed, 4 Sep 2024 06:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=x+60BHb/MawuNT
	/uNvuccHFx/j+nD10nm94xWOx6u94=; b=XF7qm9kk77jj/Y+Esn6i5foTqUSYL2
	PHYRv0uqROmLMXWr4RHKY9wf4Ra/9uo+/jZIZNGlPI5dpTpWJVtYpSuS7jxPMCLe
	u4uJiV0KyGAhJy2FeH2XBJwh5HCgERRjN4ft72OFVElkvGKolCidi3KAca/O/2FV
	HOGfqsXJch9lmsL1zO5g3oHuf1Ilt0sAaL2PE8DrA/dwtbHpMstgmJlPVeS0RZZU
	tgFaP8E+oXucBgfSzulQgazmZko4zCAAJgc1huoq1gJ+KRKJAKkhQhZFA/KGDNPB
	vtey+sklNhr6u+fAO27EH1zV/5KGluInmyPgU7UfUQ9eZVEX1uirI8rA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7tnjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 06:18:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4843s7tJ023589;
	Wed, 4 Sep 2024 06:18:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm95m8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 06:18:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBjCGp/Xpe+mE+raqp1FvY0SPVyuuGI9xdQ3Fi5VGtM+6ii7Y4E/ZjPicwB6FVBbuY0C7LJAQ4NPOHa+qNk0rk/KziUo3wfb60EnVEqAuWDXl6umMzK45sqKd8GstAeIBZimz7QvScI8optDhdrRRSZou2gNy6edQ1ql8poQamPQO1IhU00jUiAXTVNTxjTLeHte74qMvPtwe6gBBQG85xYehkTN/RnZPQg78JNX9pDqGI9cp7lXkU9U+0TVSLIJqBXHkN9x9zT1RcgYtpQgHPx4EAy3wazznJ5Tg9f2CzCgMi4EEVendtEv45328gzmvPN3VUeNMBRcC66TFXSt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+60BHb/MawuNT/uNvuccHFx/j+nD10nm94xWOx6u94=;
 b=PW3Lza2oqbZ7sRRnDvk8IwI7E4e5x245EZBkTxAqNgl9rW0OGTshn1Fi3LIBCo7spqKpIV16qqSewLVw6b922pYD3r0torwiNYZACM1UHGPD1kLSn3okHe0U1m8XbMLpYTa7DbtEtYAyxQ8XebNBsb2GijPA9EnJpcUcr4iewg935ZFCP79RCdvhngQFM1AgALsQf6iCN0mFESU2+DIApJTemN0g+9JcAVVd/cp0JsS1dZ9x3k4bjStzTMVYvaCpa+99+uWNSrdlym+vbCiZ2ZgkRd1/kcEHjgtSclN7mxF8k5kNGb8+oCVALJBmIQLN/kIpb8Tg24tJzBOEZNiP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+60BHb/MawuNT/uNvuccHFx/j+nD10nm94xWOx6u94=;
 b=RU9p21LgcFkQbsvZ0fgnwSZfjEfkg98462NCcWia10I0Aq5H/E+61+u0UYgvyPlyWvhfUmSpFoYR4ymbKfSxF9oSgoRyyo6LJDyELCWaRnZ0li1vpmLKUtZU2NSMkdftSfGo5IYKqBP61q/GDdD0m74DVdWU6MydK83DFe2riIY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB6800.namprd10.prod.outlook.com (2603:10b6:8:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 06:17:58 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%3]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 06:17:58 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
        Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,
        nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH net-next v5 4/5] netdev_features: convert
 NETIF_F_FCOE_MTU to dev->fcoe_mtu
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <c193cbf3-58e5-41bd-855d-07a9c08e283d@redhat.com> (Paolo Abeni's
	message of "Tue, 3 Sep 2024 11:55:06 +0200")
Organization: Oracle Corporation
Message-ID: <yq15xrc7xl5.fsf@ca-mkp.ca.oracle.com>
References: <20240829123340.789395-1-aleksander.lobakin@intel.com>
	<20240829123340.789395-5-aleksander.lobakin@intel.com>
	<c193cbf3-58e5-41bd-855d-07a9c08e283d@redhat.com>
Date: Wed, 04 Sep 2024 02:17:55 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: f9568e6a-8762-49be-0bfc-08dccca9521c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D0MoWF7fPm5ZZl82iqpU5wkCSldszbvva9syhw73ksR0H1YYC+Q5ncgFwCph?=
 =?us-ascii?Q?lAbH8bMR31cPiXdi1pDhZaWhgOAJ0M7XdX+kKcRUONduTCqCtq9hNZrDh9kC?=
 =?us-ascii?Q?oNSddwmwTU2XT69JKCYlO66KjyYazo1tkhJ8BZNGjR1UipKgYyx8/cJAdGDs?=
 =?us-ascii?Q?DEjLqDXbCYYMuB8EMaD2/0cQtPsTLA9wbZOuKIIcuMHVyrPvitt3Gb7WtOeb?=
 =?us-ascii?Q?1NGUe3oV7L8LCcwzdWtEjCmHJEWCcgixVFFoiPRWna3m2oXaanf+FH0LtxE0?=
 =?us-ascii?Q?C+5gBLAoPh/WyOwXBlE59yQDS0LWXTnto5w1pLg+UDLzvtKuE/4HUcCv7IrO?=
 =?us-ascii?Q?xeqFoIjQkgDGvFlyvPNrGuS14sDThhQsO5GFk+2Ubm+ZTuuO7iQMS0A1kWay?=
 =?us-ascii?Q?CyVlIe4imYZLsvLYW6uGQU9ps7E2a+fBTwmFMaX4USOA7m4v4P/qffP/jgpQ?=
 =?us-ascii?Q?3W41rAlk0GMgbCe62je0Q+Gx9IiQckNjNoxMsDqt4c1CNRs1ZJgYGhRzYk9e?=
 =?us-ascii?Q?IRhfIk5dA3Zay2KdYyA3Uw/kbD4/rMXi2c/PFEaLFbmIbKxH64hLsD5O5Jk3?=
 =?us-ascii?Q?fgVMF2UsKkdbljOIDqfvA8GdqFnLXNsY2/o+mIi3yFT4fcgpZC0ghIe+X3N8?=
 =?us-ascii?Q?ICcmO9NMSEUwBNnXnecGPCiMgzG35RqAw1TQc8HF/RvhHV+q2Ov9/EmGeoHc?=
 =?us-ascii?Q?kfJJ7HnrrgLHgMi4WW+wc9OqHjgTdd/clZX0xdTgdYC3kB52BtTps+jEQo1r?=
 =?us-ascii?Q?hTYa6TwqG4rVNOmta0AT/qVq8EMJ9CXXdNRqi6/FZZUCrfHrsQZ413G9xXgj?=
 =?us-ascii?Q?BunBuukAE/aIZlCEDvdhL1uJgNIZI6awL11khf7Hs8K3XnFwJxIy+U17TsuH?=
 =?us-ascii?Q?JP4/xUe1VvCX4hWHxmo2pmLBqklkqGiwSUF/IywKRxXOxTchkp83D+ldnCWg?=
 =?us-ascii?Q?FCPtgJguA7n+PKT5U0nxs63uTOgKt5y/RwUIkEIivWJYEMjJJFZ1sS5Az1/C?=
 =?us-ascii?Q?NR4FAVvKTSTV+C/esdB0ZDgxOG7emfIfR7R0nNiU94+Y6MeQT/vfP/ijikVc?=
 =?us-ascii?Q?4jH4XuMcGcJfG1I6Nk4zCs6N+XprSwTiV8rT87XH283EDbYHWDtUxcDi4D3A?=
 =?us-ascii?Q?YIPah5ml3hP3RUR9/8IVldzh3Og7YP32B1avfvELJTwOiJup1zE9/PsgpI25?=
 =?us-ascii?Q?L5jV8riAwdJ52KspqoU5DasLbmHYxf06j7XSMenqWBgyDoEfs+8jaSuUjGyi?=
 =?us-ascii?Q?TExDI61mRfLow0DNxa/JPp+o59TGpHLZRvN5szW+nDfnllzpyMBH7WLwy4Gy?=
 =?us-ascii?Q?iYjTEWEtaT0/wybH24XSBdOtj4ufhvu9km2cKrQzZv3e4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GLSHcyc8C7HS7V3FnS70UEm3PZiB/8LUGMPa5Gl1Wcmp+bIDptN2zdZspK+F?=
 =?us-ascii?Q?obRw/CFFPOi+R1uuiIuPG2lE3CrRhZv1PluiO6u7RCcfQPKI7KglfBPR1jr1?=
 =?us-ascii?Q?+5R+PH/I01G0Nz32VAgIKrcO7fwX77xBmekea4fHKxW3CrlmhL1MDIFwWlhf?=
 =?us-ascii?Q?L1d3vBT3HpdKNw54hJWh3d4fzR98zaLNgpHndRik2dS27f8RRkYUh8hzle8d?=
 =?us-ascii?Q?OGQz5S4dIAQsBPtMmDSBvijJLgNgrI0gFKBOPWgXb4jvwhauXjfTLEvt19mL?=
 =?us-ascii?Q?23syH12yAOuisgMSwiSotXmzZZmFzOEn6EK1NGtgyoDJimxU1q23xUOtc4h+?=
 =?us-ascii?Q?hn4Z1/uSmmqJSWlt9HGFoB5Hhnm7qJO3J9IObCtO8QCWXDUEKWAd6+MtybAh?=
 =?us-ascii?Q?cBMnNJ/6mYer9BD1q8084G6BYYb6Cj6pbENZdicNUTaoMNg/8kTHp4gibZ/w?=
 =?us-ascii?Q?CYaQsp7RG37tXs+P+36xDz3iNOnevZ7KthCrXOEjeBtGax/DBz2N2AJ7eX0M?=
 =?us-ascii?Q?253/tvvfH4kzG0bXdQNce195/XAzNzalQ8hdKOEOf7yAFZI4qhjE1upZqFEM?=
 =?us-ascii?Q?e+yD4jbt3vODXGPfscNV8iF1rTWbi67AE384buLnzHu/DLRUga7fT7JRArv6?=
 =?us-ascii?Q?3T8U7emJub490Spj5HgUPPZ7/8LmOOm0Ky/9HEA2+dEVi1srFS0VBaEgVbtb?=
 =?us-ascii?Q?NfCK0F/gSgCv8hKy2zxLhthh/DSZb9lk9jzbzYzTrrT5KBNJHedZoe9CVztO?=
 =?us-ascii?Q?Kle+fTi9eliUbD8Llb6UjKglsRhW1vq7h+xUXDBF/I+EqKcfnxMRbypew9cy?=
 =?us-ascii?Q?KmeX0bcplRGpf4j7GmgLsQo81JIv2/PR6zrC/grW7CaB8AEojxYJv83KAHoe?=
 =?us-ascii?Q?h89xW3g/+gJvtGafjd7bTSeOfHZfeOFKuRUWTqEU0Y0Zy6wnzh3XcMMdQNUV?=
 =?us-ascii?Q?RmOPPoyOVhDmJilgzzujLmmEO33l8IWUBK+bGJuy7SE/cZQpuQGKS1yaDsy1?=
 =?us-ascii?Q?vcJghJDsNZpGU3gYVEdN8bgtc4/j0BF/m+/ixdlMlll6XQ56WQ5/Xvyi7lft?=
 =?us-ascii?Q?JizEnbrFFLpGnRo35GuInm45rrMf81df7BCR2UEV4X5vQeptH39c6NRJN4n3?=
 =?us-ascii?Q?WpNSNS0gj4UY1O7nlP60L+hGtMfaOrfviwnj1zFJvydxoubB/CNarq2GXvLO?=
 =?us-ascii?Q?Woo6Wf/vxnXxRgu46/iskM/dLPosw4lYaynarqt+s7TM8nMK2y3Gw61m/991?=
 =?us-ascii?Q?r5V4oN23nUZ+xMGlDxBh77Y5DIrDeEOpexb8bWD+AioMlSMdQuOsRC2npaMq?=
 =?us-ascii?Q?gAh/uIWN4rHaVpOXNXiRPpW1kW9fsOQedwA9ebtT8TJuipHQQlK8R4EFtm0G?=
 =?us-ascii?Q?jCHkqEDXy3vRo0E6peKVcDVkXptrEcWVsJf2F9X//dgNVDSElhi7R1x0ndlk?=
 =?us-ascii?Q?jgslRYvSBa/RhjTGaD6lPC4X/vi+OlU0KUvWEwpAq+NqBg2F8zbqvcuDRnCh?=
 =?us-ascii?Q?/3HYAV8pCTecpAEr/yeGIHjw2/4LK+B8KA3fviA/EMNaEXpq70QDxMhn73W+?=
 =?us-ascii?Q?jbjTspEJwWU+4ko228LP6u3KmBWgnRs70jRn8beECsLper2b9YPUsm854Jwd?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dLO56An2v8e43Exwyvy13CaqjLsZD5bxa/kd4/yO93gfrnmRr1DZFsoD2FGi5S+4eXYwr9EOPsfMWdKYyIL5PbzqnknsXUHmWn2dB6qQXV7UkXqNsb/Qxt0AHOWt1/f8agebDQoyONyKzbjdQCAlwsCA/RSOumVn1A7GeEeOUfn6ir2ZcObVfgYAnpmkFyPWesGZDbfXGg/0jyJFHetmqs4eGNHIXWjlKqpYuAtHQo6RJRdj/kvACZiSPmtq0sts0B+T2PYESidm64kRXVjZ6WOrdV36pOTRMELiYrQ6JJYqC99ZRNkNR8EasCB4dGoA7BQcXvcE899g92jDfwmOHUtHWVniaEUwsx3R3SgAdC+qhDY021Ucc7dablHL5KKzq9PKVNddbKHHUpzde7KWRgzp7QY+iZrhVWd3FTa/I1rhv44F8sZH2mv93MjfCA0icYKM5P/xswrK7ogP7rSTOBm23tSplF8u0H2rNJm0DfMunKOLA2gWNLM3DMKLKVsOpHPxjvXO8bmD5fgUsTIVa8WPddEhXdRxfunW/SQF1xkDjW+mSsbBl1F185c15feJhTXoMBgRAvsNq6GiSF6ZAh2nCyHg7PsvuCbrkDMurTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9568e6a-8762-49be-0bfc-08dccca9521c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 06:17:58.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKhXMSyWrC7KVbSR8UwDE1FpUfB3b6QYZpBDlNU/oixjE+d/6OqKiOVT8WjP4MqEcwQKZI8CCbQCTZd3C1cojSrO4msn0yNawqq5moGS8ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040047
X-Proofpoint-GUID: reMElxbwHnRNL7COIumxnaJjYetC6swM
X-Proofpoint-ORIG-GUID: reMElxbwHnRNL7COIumxnaJjYetC6swM


Paolo,

> CC: Martin and Hannes, to raise awareness that the core networking
> changes in here will introduce a small delta in the scsi subsystem,
> too.

That's fine. No objections to the SCSI changes.

-- 
Martin K. Petersen	Oracle Linux Engineering

