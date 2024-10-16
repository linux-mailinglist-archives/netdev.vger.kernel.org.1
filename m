Return-Path: <netdev+bounces-136068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EFC9A034D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC3D28880C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C81D270A;
	Wed, 16 Oct 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P8u/fntn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OYWGw1sW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF331D2708
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065354; cv=fail; b=KRkOkHSokoP66t0COJdxSK0TE6V/v66O4PNqT3+tqz2m6HfDhaPpT8m0F1gcDc5/raV7rgMgWjwqPvr0N1vqGT3sknwcvWLtzapmoK2iWIvAHlG9jP+++3l5yZAdZOY41OmrrRHQBisWh5Di1J+okZQQUtvMViOSiYM2tqDQ9Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065354; c=relaxed/simple;
	bh=OKZdWNQXctKpdSgPf/JpNQtLt9/q7ijT14iHAxU/x4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=dpt7Sg6X4mCA62LPaB1NYm6VFEWiqgRpqXAiqrLyEXmAd1cz12GI67u10c2uJdYCWF9I0ut0DAfX4OOzJv6vpTzZaC9nJAcKXbc6ol2k2++nJYHXrbbjqvIjWVdS4OdjjGM5ah+yKPUc7L9Soj2ZoYU3KRRI8MJFOUToeJptNzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P8u/fntn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OYWGw1sW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G7fdlT008085;
	Wed, 16 Oct 2024 07:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lMoQRL0/XC5950xhNs
	pU3I7h4nDhprCPNSZTlzBk4+c=; b=P8u/fntnXDKk3bXXoW+uW0pihDOQMFNPtL
	ZPivYDbMTR2Rj/Y15vTp20WpHppbkL7VAV19neKpPFuIT8O67RVTop7jprAQVKYR
	hFgq4Z9dSwAhCTWeI0Rse/1fHjuCJuba0qV3b9yjPQcHquuzhSkmiMTsk3C/vNxY
	lA6oSUpqpLJTL5Ytcv3zOLDcpGgWGpty552dHU7aHAj5KJoBVlIjcwxXp8m7suXo
	8vPXRCCht+kv0srJP44HPVdZImlAW6lQW7+H1srnQGPcQdLlqKLqjWeGogGwdoZ/
	I8G0VvkEyK4O5/wMsoAwkv7JpDzmqzCM6H+0mBa//gi/E5neBQtQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt33pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 07:55:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6QZjM026407;
	Wed, 16 Oct 2024 07:55:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8gjea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 07:55:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w09vS+miHL8HyZNQ++RjWxWRwSDWAK52lgYoHgeY4rBps/Y/Fc6vRxWSVWl5qMsQZghlvyO016K0IfmR2Vpe4vULjShEKg0edmm+2HfsX4OykoYFA+890v++RN+WscJhKAeKVwWuxSqWKA4a6tIGS+jkGpcOhSM8YBUJcOZtzVPhHnyhYdxOvsfHVoFmZFJU+U+nkDkKBotYefQF58gpWo6kUqvfDOlRTVRsP5wrQFXulCOgK9fTigEuwD/YtYLn8RhW3XvfzBDeg64IZpjAhawtLjGsvfH67dbEWRqjscNX/Xt3ila0DmpQFfF1L7IIjLaq6JqHFqJd74gqODPGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMoQRL0/XC5950xhNspU3I7h4nDhprCPNSZTlzBk4+c=;
 b=euDVAWiq4axQNLXbEIaTiNAJqk2pLsEysa6U40OzhNatSTCmqnfManKXlopZqaUTIJcA6Fujl83vyU8Gp9ZJUOpKcKq6gUIfiIJtlu9Seegilj8jyK2HWzar+bA7eezyl28Iiubo3pcZ+UPKpWhitBjrDxTeW26xc+glPZYPq4jLR8XX9A3d0xQf335Hit/yes4aP5Q+h8pLmiim0phLtvXS0i+oUPdXnG54uvLF8mYl3bnWuf9oXTeMMBa6roiu9sIQYECa4K0wPDA6GmdOYUAqketgQ/6cnU0rroBUdBpYH/aeuuBTrZuRTAi8ALnUswbZG/Bl4QI12bXA9AuwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMoQRL0/XC5950xhNspU3I7h4nDhprCPNSZTlzBk4+c=;
 b=OYWGw1sWb/NkvaLs8dw8f2UL/Q0XIMZhL8iyBjXGuj66sczEqtwTroNOaz66Q/QfDy5TbiD9pLqiw9ULHs7Wi2cjmQRHIdP5yhVzbuDeQz1kCeB0JK6UgETm7+d7W/2sHDULlaGtmO2Gx52pyO3GQXon2ZMTdHewrNhATo0FT60=
Received: from BN8PR10MB3508.namprd10.prod.outlook.com (2603:10b6:408:ae::32)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 07:55:23 +0000
Received: from BN8PR10MB3508.namprd10.prod.outlook.com
 ([fe80::5938:7839:ff36:b916]) by BN8PR10MB3508.namprd10.prod.outlook.com
 ([fe80::5938:7839:ff36:b916%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:55:23 +0000
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
 <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/5] virtio_net: enable premapped mode by default
In-Reply-To: <20241014005529-mutt-send-email-mst@kernel.org>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014005529-mutt-send-email-mst@kernel.org>
Date: Wed, 16 Oct 2024 08:55:21 +0100
Message-ID: <m2bjzkeb2u.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DU7P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::32) To BN8PR10MB3508.namprd10.prod.outlook.com
 (2603:10b6:408:ae::32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB3508:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e8b522-993e-44dc-5e7c-08dcedb7e3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7IGs/uQ5j9QU27ApdTCZt78rjJ4Z2KTEbEZ9nrJEsXp+aR3JSf45zoV1/e7?=
 =?us-ascii?Q?S5dCLDsgqDRDOFMof4UhrAEMG6cWxg+0LaOL3FfPJfkAPcB96Fuifpt4eWvj?=
 =?us-ascii?Q?3OfjsZt/D50qKPv3EdJEgxXPz9dduDVpIXO/z44ILY8kQQjpzUhgRcOOq9Hs?=
 =?us-ascii?Q?WTSxY5F+LtSYOIgtG36HFM96k+d+sMoVX4lKTaJZZGmdkG7gelYqyaxRHMqz?=
 =?us-ascii?Q?+MpLMekxkz2Ulx2hVa8evh4F4LNNg3NOR0dAUydr2f2FCKovZMhRfJmQmIoY?=
 =?us-ascii?Q?SH50jIrGe78PvCLQkPSu62+Atrzl7qmzTcmRTey3J8kjqQDGtWzXujwk55Tw?=
 =?us-ascii?Q?qMD7GmG7X/mFoYEztd7qQtevKRXycDQ/uVotu6BMWgKkIV9YmNXTS3CZ+K7h?=
 =?us-ascii?Q?JtSF59KCFlVq2PfjfS+qcuomd+IgfhuCPccQM9An9x4zRARfcQw9ceTVF26R?=
 =?us-ascii?Q?UC7PUdbRsq0CtVxTvkTlPNAQVt8LXaPTNG9zxy0mFTii00gB4f1oexld5N4k?=
 =?us-ascii?Q?eXGLMd+uOBT3wDBsH/KQuka9R+fulm6oqjwQn2MqVeJ1wObzmZvg6tki2/Fp?=
 =?us-ascii?Q?BC6cjdCg4+mp19GJt0Mi86uqRxC8g0meXWtVP2J7DpUIFhA7p7ROymDOYdzT?=
 =?us-ascii?Q?rLCYHD07rq/A41sXXmwLb5HjtZNrCszVbsDg4qacEWGqDKFBtAkBbdjxdTrx?=
 =?us-ascii?Q?6uZ8hCld5Jwdlu6i9i+G/+WrFAOmTwQWr61H7NOmicKmHK7VfV7X8ElcSOr0?=
 =?us-ascii?Q?4YZsgVY29z7e2hMCDCSClJ8Lxd1VQzlUJIG4R/twKDXVlSBIP8WBkfP6VMt4?=
 =?us-ascii?Q?ASubHUNKHVXMsh6a8Ssu0V9J2r9GLee/YWkoSL7NyiLLKELCiETAssQraeQA?=
 =?us-ascii?Q?w43tjFqHHrrw6jOKw2pPrNejvjpoFtrZzYTr1WiXZW9ciyEVJE+gXdzycz1N?=
 =?us-ascii?Q?8oMkaJbXNxow6D7I2QRuVclBO76GznbIXFowLWqujoqia3OOz8HX0bulO72k?=
 =?us-ascii?Q?kHdXdwWJEQhTk9m1V1Y9j6k30dpdhqNYtuE1JcPj0oYU9JI+Tin1nNZuA+FH?=
 =?us-ascii?Q?7ynXPRP24Fg5cWT1+G3JMCAHTVPz10f9Pn+Rs0ZzNSMA/l04ouHps1cais02?=
 =?us-ascii?Q?owgmyaRbBdlWSgREm+njF236eW7z3yTHIm78OggmyM8N4gfjOAvYMiV/E1cz?=
 =?us-ascii?Q?3fmhWdmivfveU/+d02OfnwqcC5NJe1ITjnkf7kItbbrumWKPfyXZK4xUlK41?=
 =?us-ascii?Q?/ngtNV4GWZ/TO7q1E3kQ2x+6NbP0430mz4UDHGdiA+OeuLSwju3sgiZOU6+z?=
 =?us-ascii?Q?PDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3508.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P5K0sOuzMb7KOw3y0/zNgIoxPnWyUKe8ZwwdlpXsBPJ8+m4C0EAwwUcIAPsJ?=
 =?us-ascii?Q?M/gSiKvbr4P99eXVeWrwURcBwj3WzrB1g5yLSKmVOUoswiqrh/e4h46c+7ni?=
 =?us-ascii?Q?XArkYcikTV3J/XY2OzfORoxlohniy3SobWZfMAKZTLBOpbdbY1FFTcsg+8Va?=
 =?us-ascii?Q?QxwUMmdb+qejt2Y86E27bCFmlGqa0qB8PcL8vGOlELfAcVDcYQ5xZmyhIDEH?=
 =?us-ascii?Q?027SbcDoqxj6k6j/mx1fLGNSM6njplIXNx2QTn+xDjC16nDaem/CGfAdKrme?=
 =?us-ascii?Q?tyvwHP1jtsCJt/rKXyTMYK0eP+uXZsJkvh+DygxKeKnI39iOm5YhFJrM8+jR?=
 =?us-ascii?Q?NvzZxDpIgDHjX7nr+TN5jS7/bSv+VG+dsSA58L28T6cEymtZGikE2iws4+Gj?=
 =?us-ascii?Q?+euD0GHRJ4OvSBs3QdWFoTlP6SifiVJlveXk80Org+bG1UxbvEMRckA63dyW?=
 =?us-ascii?Q?JEUv74O/9f3qdpMyosPeu8opDkhWb2DuxKzAMYp0hcj7NUAaY1u1p2QLXtGC?=
 =?us-ascii?Q?lV8RWDFo+uEj4ASHxT3FNlAeDvhBY3dZnucaviupljulyk4cfD5ABZwNpOBn?=
 =?us-ascii?Q?mGssdFjV/Aehx9zyaunAEhu69YGq9mK79Ghf0IjIqqjuqdoBor6GgHvBG+V6?=
 =?us-ascii?Q?w0phamqyPsAkWa8dgbLNavRPPDyui/pV2//u2tFkxwMxTzKDkG/vpS2k+BY8?=
 =?us-ascii?Q?ZrtYgyhniCHfjRUZw+Dq2gWVw5oc3RvzIACKMA3m5reS34WOvpdk7VtPV5WC?=
 =?us-ascii?Q?qytyd06WKjFU2vz3vb9L7MHHQ7J/ARcVWREdaprpDSWDyLZpwLTc/7tlSM37?=
 =?us-ascii?Q?gA2pvNkV6/MW1HiH+cTsMEy0LyeCdcfiouPG+U1WQd8DWjvO1W7G37ZoBgXL?=
 =?us-ascii?Q?uqW+DZq7VNveCLSlRi3nrHcUq50cOvZ9HhCmCkWCGkWEJXvHPxemVYjqhDUN?=
 =?us-ascii?Q?/vl1lx56hQix+wu66NRdX3Nwb6fUzgYkADyVYTjB8lZi7wX20/9XrQuOG3gj?=
 =?us-ascii?Q?LpS6XRnYRfFnaCtPAFc+KMmfJWY1287/+jEvoA6qVOjSbx2ka1sbE+Y8yr4A?=
 =?us-ascii?Q?4whg3uWjIRFCyckiZNvfK5SGypaUe5itSZSPakNetDjehlq/WN58+pW1E9/M?=
 =?us-ascii?Q?Xjnr2ZQeEq25aAacW8CAF74OL/ZkV3G9WqLtnFVPyKafUNCEcWYO82Kg5Pl3?=
 =?us-ascii?Q?jGqWVwVqtAdnK6qH498NRjJVr44TAiOHRqYavxtjhzj10zRYcP8ZDmFk9v9s?=
 =?us-ascii?Q?7BXkM2Au7rKh+aFx92Ih+H4Ece7D4dbX1LFrSEhdyIV7/V6EbwkLbqhf6U8B?=
 =?us-ascii?Q?X7YkRL4tSYcUlwFtv9d5G7Nu4n3J3uU93tfYcEoXO1O2wP9CZ6bI44catJbJ?=
 =?us-ascii?Q?BPuOsX5DQTjEx4g8QashpTtlONo3m+/U81g56eH+FW70rxYeWm7EvmkcHtCN?=
 =?us-ascii?Q?D4+0hmgusGRPF7xWUo6z+KnRVVcaBumIQNZAd8Ewrkli0swDgK8tWSDqwmQl?=
 =?us-ascii?Q?qCopJe1aZ4y8opEhMNQyQHVy5Du2HpAZW6ddpm1FID1m7P2nNYis/MoMOzfE?=
 =?us-ascii?Q?y4RyNZ6hVgua/YtWd+mmc0IeSZwK3kVFX4Zu+CQ5ELEUsTMwJehNmWQRhjxA?=
 =?us-ascii?Q?fZE/f8nDwqi+fO2nFBCi5WJYxFfot/jz2hD0udQ8XENQn5/yVIy8bridpfH9?=
 =?us-ascii?Q?MXmogQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AZK+zsuJCTTYUygNTqiLnz4XRFSdIs47/nShNJ0nRscUcQ93O3Dhss7SRSVquK84y4XrVrcMUJk6pJaC9ToNmJppRTPK1ylsbEXk/OqsCE/wBrCBxyILE6q5HmUw7A5GC05DHzKr8idLawMlk9wU6EuKgciS7IOGCLkc2vfUJzkHtgo6FseEsK/8j3/Smld/v5Kb+7FGl469gfiuf91hy1pOO3HRJ+9SAtqYfEYZ1Qzx0hIdHp3WFMkak5Y5QGzlyxrhwychV/SSeQxHvC7rw0xL9sZxgtFiRdG7z7y0DiUzmazLzBaKmqagDvHHar4A1CMqzmlO5wI9UKlQ3h6Sua8CpPMqSd7uvWFl6P5AKw1aZf6d7J4KCeWBCJHkE6psLflp3tsFQjRp9y38cx7ZSya+i6Ecp7sg9GB9nnYagZW0F+s5Tt5rd2QEL9Hjp9creGn6hgJgAnwJbkrkXIHf9HpJTWcGVPa4K1NOHX30hW0Vqvyiv3p98ZsZLQ1PX3JMMR/Imm4JkhVhNVYk2xWCyCKyDuZq1jisg5o6e9EyFHjdevb8iatV21zi+hcyMWI9MB+GuUIU+j2yQ88inwXPPV+csTyGLeCdNBslEnnEtHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e8b522-993e-44dc-5e7c-08dcedb7e3b4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3508.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:55:23.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aefa3KTwP+R+Up7xIOdkz2U0fP8VZRP4TnNdbRlxNLmGYWZ6vhn03ErRhYqdP/OmpI2XyxV61QdWJW8tdCUi9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_05,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160051
X-Proofpoint-GUID: cajSce4gOY3sRGuy6joez7HGXpc8CEef
X-Proofpoint-ORIG-GUID: cajSce4gOY3sRGuy6joez7HGXpc8CEef

Hi Michael,

On Monday, 2024-10-14 at 00:57:41 -04, Michael S. Tsirkin wrote:
> On Mon, Oct 14, 2024 at 11:12:29AM +0800, Xuan Zhuo wrote:
>> In the last linux version, we disabled this feature to fix the
>> regress[1].
>> 
>> The patch set is try to fix the problem and re-enable it.
>> 
>> More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
>> 
>> Thanks.
>> 
>> [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
>
> Darren, you previously reported crashes with a patch very similar to 1/5.
> Can you please test this patchset and report whether they
> are still observed?
> If yes, any data on how to reproduce would be very benefitial for Xuan
> Zhuo.
>

I aim to get to this in the next week, but I don't currently have
access to a system to test it, it will take a few days at least before I
can get one.

Thanks,

Darren.


>
>> Xuan Zhuo (5):
>>   virtio-net: fix overflow inside virtnet_rq_alloc
>>   virtio_net: introduce vi->mode
>>   virtio_net: big mode skip the unmap check
>>   virtio_net: enable premapped mode for merge and small by default
>>   virtio_net: rx remove premapped failover code
>> 
>>  drivers/net/virtio_net.c | 168 ++++++++++++++++++++++++---------------
>>  1 file changed, 105 insertions(+), 63 deletions(-)
>> 
>> --
>> 2.32.0.3.g01195cf9f

