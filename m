Return-Path: <netdev+bounces-137046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE89A41D7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741FF1F25961
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085C91FF60B;
	Fri, 18 Oct 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ST+rUp6Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ksWd6lSr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F891EE03A
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263574; cv=fail; b=QUwoHuzbHOd6J55TYLUy8d6vPISkN+aDI9ulmmf2rMKG+PKsLtxA7HKSMeQhB0ebgaENX33XLRTXBpcwdPtAYwBv2wyx5oyNyuWaFW0mJxUA3sGERvEHwZWPDktzrs+TLCtSYSNgtR4JetRz0bX+XeYpeyJQZtViyhtXsAdDoA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263574; c=relaxed/simple;
	bh=JgSMrCl1C3XRNHCRAno/Sgre41qDWhkw3+/HSoVttLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=YezHyGsgJWNQ9AO6Z5LpgmkH3KIumgAU/6TTEMOV1VmaVZJFGEicjcub/fZn2RsXXRrjVfg3UT6RhKJOljf1UywdLwOX3452Mn2GpTpOROouOmPpqRnicSlCd4jecDWK/vFz1Bsy46eJd8tOaPH1jWs4id75+DEBZK+XbQUg60o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ST+rUp6Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ksWd6lSr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBfYK005772;
	Fri, 18 Oct 2024 14:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=BQaKcF9PGKYgEO9dlB
	0TXFcN3seSrMpPGUH+3dFTCug=; b=ST+rUp6YXYjL4SQlZS9lRyMZueiytQVG7V
	sqUBU9bYC1cIXP8aIhyzKsgEakWk0QeWk0l5iwjcqxecYPHnrU8x0iNiJgg0fq5G
	DSuhGty3zjqNa+QY2ctLFCWZ+vGk5SFFqkqFDX8Wzu3G8Ccg2lNumkDlK7Pb2bAT
	14KL8eS2PMZCdvV3g9cE4NbIr7uXCSnPG6GIe52CqL6BeuNHRBidc32lLnRRRubr
	N2ToLDt4KY5X/y+p9MN67LRUPWyib2kQXwEz2d9EVMeI8fv/n3focoBbGvYP02bY
	nuBooS2etCtLW9OpwxUvh7lXAcOCR6RmFBFhpf6KsX1NS6Qd/Bwg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7s23m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:59:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IENpqf026190;
	Fri, 18 Oct 2024 14:59:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbpxt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuzI3eVNxOrp+145+0SUe9+03rAdpsEBQH5heN6WgCtN2/gm0BdRVc4NqJsCls/ESkOkR45ubW8w0BXgO8yOMmhlIvy79CEQ9nerjx7zAn/LIJbvCejsIa7+TCmWlRTgU5XgyTA0j+3JEEIHoy7dKxcRdGv2/Sghr9patsafyGjzvXLEyhe0+arZTsgex1oUxAAimSz5ezuoE+FpzaROnvaa4Y0V2V2Em/ZbOwBLh+sFN/YD3+4xVwcN8kPDIUI6YGEGXuC/aPOuP+sVA68DkrBe37ux2jxtjiT1LyCTsY0KtNl8d0aWgiIBfXkCccPilTtZcIYqiymjd0ZAa/eBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQaKcF9PGKYgEO9dlB0TXFcN3seSrMpPGUH+3dFTCug=;
 b=b6bvMJq3UTXG7qJ9nsc4b8svZW+3UPi6X0W9CqvWJmAacJ6mZd5lpDSmKx2qErD3FltjMAaLMa+k9frnYjprffPX8kmZbZVrBW0hPn5Cfis9Gz6Ajd5xVUlibExClWkpGYHojFjfS0MOlBezQVUi3V0q4BZRplvaqDkvQw1X89hpwlWE3p8dfcr8Q6DhfhDONSWzaT7M7F69CifHS7D5fSZ5WnTK1mMuvNuzaMCo9URAgIIiz/eWap83HgaprNRWlOvxbTy/mD1oOM8kg7hx+NJhpES6zw1X59kJv24spyMvjeg1ONeiQzS/9qG9kzxRsHhdzIU+HMCZ8X0RtfFyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQaKcF9PGKYgEO9dlB0TXFcN3seSrMpPGUH+3dFTCug=;
 b=ksWd6lSrhxh8EvmYhWFWDdwfDNrNsVR0DQtQd0WIB91zYcCnkJnpMqioeQhsf7kEwI2QJHREynFSCo6/SJdZ2Z7j21QqAOl8fUFmhFvMze9Tc0ai6PQYhWoed2BFiZE3r/gNrum8DxY9aRFAE//gXAR9CGqqaBVwyYyq15b0jBs=
Received: from BN8PR10MB3508.namprd10.prod.outlook.com (2603:10b6:408:ae::32)
 by PH0PR10MB7097.namprd10.prod.outlook.com (2603:10b6:510:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 14:59:16 +0000
Received: from BN8PR10MB3508.namprd10.prod.outlook.com
 ([fe80::5938:7839:ff36:b916]) by BN8PR10MB3508.namprd10.prod.outlook.com
 ([fe80::5938:7839:ff36:b916%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 14:59:16 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
        Si-Wei Liu
 <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/5] virtio_net: enable premapped mode by default
In-Reply-To: <m2bjzkeb2u.fsf@oracle.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014005529-mutt-send-email-mst@kernel.org>
 <m2bjzkeb2u.fsf@oracle.com>
Date: Fri, 18 Oct 2024 15:59:14 +0100
Message-ID: <m2zfn1a24d.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB3PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:8:1::25)
 To BN8PR10MB3508.namprd10.prod.outlook.com (2603:10b6:408:ae::32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB3508:EE_|PH0PR10MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbd4aba-d09c-4140-ae07-08dcef856fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQn7m6itptMZj92RS2g8IA5f54MrBDa6bYdaxnyHE3YZAQfe9lg0jicDvWul?=
 =?us-ascii?Q?wB8rRyZ7/gy4b0RSRVGNNoHUoL5ZA24b54FHdYSvaU3G06ygAgLGVE64ZI3G?=
 =?us-ascii?Q?RCIorXxdZOCNS7icPtUBstghshhNVn34SjVzNwxeG61ol6EZUSj+E1ucObyq?=
 =?us-ascii?Q?x1GGZCuibxg812x5vFxwgRIjNGkDlh53g6QMwuRj9qBqimPNiP8dcDr3WLKs?=
 =?us-ascii?Q?Kk+JK2mHTrVBFVrH2Lj2t0M2J/I/citdDZFb1/RwCl+PZnXnbAYZsjWuP+/q?=
 =?us-ascii?Q?2Se//I47BwX3ltuLIoasFQOwdt6RLq9QE7OSEPBw1mWc58MuMQrIQAHeBl92?=
 =?us-ascii?Q?JEiVIDqnx/Wza5b7CGG21B9a/kBf2OYjIsy5t4/bDfPyf3DY4XOUQUbM5mbD?=
 =?us-ascii?Q?YgcD0sfOcDrn+enJ7SfbCRswoytJNs24lBmDByB6CeL4aYaBguWAIqW4K+uS?=
 =?us-ascii?Q?1HA15q1b4KTc6G2QcudwYtdHNLVbkzrrzvzvGujIV1CyN1/6Vn1HSD4yDWUV?=
 =?us-ascii?Q?8YSwgPV3wzuH/uXnjYN+enInTGJmwcbYA7gWoTKxXoZ30VMotEfEYdTKxl4u?=
 =?us-ascii?Q?ajjTGl+DN+39r21bt9YgV5nEI7Tfk1GKnQ4ws6al1qF8owQC20ntxsBpMAWK?=
 =?us-ascii?Q?x14goSyVJVUZPHd165ms7unxOtD+4ic3MvbB6cDiDlY1HpJgY6C/AoumFwPk?=
 =?us-ascii?Q?M+Pcc50BL2ZA3uxISyWSIXusbAjIkuDx51eP3mt0iraFIuvdCvHtgB8FxTKL?=
 =?us-ascii?Q?0m1Ih5uKjp0WryKyz/lg+BqpF/rVC9ToxJ0p3CfXcBUiY4zHATjf2zzHZbFn?=
 =?us-ascii?Q?JZeZuphOia6Ej1N0BUvZHQihYVIdj6/k6Ho8YkT3rXv0oVFXDJfj+zBRw9Hd?=
 =?us-ascii?Q?2z89WFTFBU6C66Jh+A599CPVIh2myU0kAae7nS4n8IUnOwtBL0VPFsuqtccN?=
 =?us-ascii?Q?q3oJ1znpR7+THSuSdKiWCCotzFBptQQHZIFF9X1mU1yCNRGsdn1HaG2rOm91?=
 =?us-ascii?Q?yPNJ/TS0hddK6YbVZMDxMvTJXUTJ1mDHpAyv1sj0w2CyZuRjN4QZqKTgNekK?=
 =?us-ascii?Q?pBI2NtE2bm9dGas7PnwifrRSp4OrsU2P9WPc4xRAu6ma+e3g5qVnV4lUpsnl?=
 =?us-ascii?Q?Gy1+YeiAislmJmVEK+1hGBthSeP68eHcuDXMrVlv2YbTqh8LII/idMM3vKib?=
 =?us-ascii?Q?IFB6Kbsil5SkLm1LMVGarSrxQPihZ+IliN/zEVb7HqSDHNcvNbsWVlthVktI?=
 =?us-ascii?Q?IRyQswMZ4io4YWiu/KT2xP5UcShQa2Y6uBCrCkQgHvTlIrosLFrxDQhuaosk?=
 =?us-ascii?Q?YvLtHrN9TL+/jYMe0NJL/3by?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3508.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/bmKMKKYdXVFgsrmgR5wZ2djkr473+I7xa9JwEGy/JEB/EGRvbH+K9Xm9sUe?=
 =?us-ascii?Q?X2J/20XiKsCIWYx0zsqCyxDslsLisBKOo/Y+Uo+rrMZUJ7fqB84yiN3cRaRb?=
 =?us-ascii?Q?a6b7RtqfgBMciaQR4cHjfQiCRYzBFA/9vcyubhtQZXhPETuKlnf7Ay1DUpk3?=
 =?us-ascii?Q?G9oomI6BnFrlQtZ/iR6PPZMXH5xMkqzvBX8yxsniEYi6Bd8AXcHRJlL7bJQu?=
 =?us-ascii?Q?VjVw0rd1RBGPglV7JrfHJjkvPxq6RneHSW1xc5Q6smMH5sGp5ycXDk0bnHN1?=
 =?us-ascii?Q?qdY1ReDrEgLL1VBYWzMk6WX5Rt1nKpjNf9rKaSogeBRbCp8oH8awvBd/uJBJ?=
 =?us-ascii?Q?n/SKG4pvGBpjwNUPJj1rqQgU+vU8aNI+i6IjQpfLsmQDC3w0vzu2FbNqYR5v?=
 =?us-ascii?Q?M3PeYBpQIzhLPgTCqI2jm1YCizYBe5pswwhYfl1wXdyfxRru9tnWRkzuuK79?=
 =?us-ascii?Q?49hsMrMLUoNAu+0bV2/w+BVfC12nzJiWRVDcYWmYlE+H7z4at3PSGSq70h1X?=
 =?us-ascii?Q?C1w9K3Ys/m+/zSlOURsR6ZgRAeLcRZzVOGSQs9NG1ARrMccCbXlMJrcZQhv2?=
 =?us-ascii?Q?fdtPSvZDBfuc7q3uks6rjBj/N4219Aeot01glNJdtUHuoYGmiROsQGEaZ+t6?=
 =?us-ascii?Q?SLv/+jN6A4tAoQy0sRRmWAujsxObsqgDlr6d4Q+sZNZkXNnBbA8k4h3/1xzf?=
 =?us-ascii?Q?2xHfNF5Dnlyw5Tnbv8yR2/h3mZ0pdEeKjWh9DMJYt6Es8UHCIP5W4i1iWML/?=
 =?us-ascii?Q?M6V7+6ePPw5oCab8Qe5965Q5eB10JtFmNhYfQOBnHrdctCwJIp7t+2mh0vfY?=
 =?us-ascii?Q?lG9kLp2/B2boPP4XJeev92q2h/Pn2zLPXbJTV4hPUiWtA0dC+pUx0IxrP6Fg?=
 =?us-ascii?Q?uzA/tEhRmN41tVK3VzuNaBJpXQhCaTEh+NDhKpdy+LXmNScQ7caGOnnNBZzq?=
 =?us-ascii?Q?/A8kMTQpI7P/d9k5BqG/XMWnMIaA+zPR2D81hP5kH2NXviqC08w3SOLuxqxe?=
 =?us-ascii?Q?k1JVM8udkAl0WIXm/saCK5wW6stxsliakEYub7nTVwtiRTQQi7wKhEf2Ua3V?=
 =?us-ascii?Q?V5irWTQmqEHALYecDM2qE6enMiuJKKNGY1jf+eGbTjaFDxo9ftNZ4JgX5Y52?=
 =?us-ascii?Q?Iw2TU95KbsF2JyL3LEx3reYFyxKhPNDN7n3dD5yng+EeWRbEXiX7IGgP8RH5?=
 =?us-ascii?Q?yyAvr4+PTY9UT6B4lwYqsBb80bNKeC/JJfy22IiSXGW61dy/E/9QrMYqYAgo?=
 =?us-ascii?Q?z9+8Io1Rh2LoVr8e/ErAekaekDRMwnAGDpbxHwYWEwmRylzQNsB8KiBSRhsH?=
 =?us-ascii?Q?LMCebUz6uSgxEIcSYVww2yhnyLv8RlK4Wn37AF+y1Gl8bWOR/EfQ4Mvrdbzg?=
 =?us-ascii?Q?qzxMn+l5jUS7fGYKCgsWW/yLxsUqv22B3iomcDl3yLXXFDRbptgJg51rIb7a?=
 =?us-ascii?Q?3CDFlhUSmpZrSLcH/+uzTqtzCbKUTnIunxF4Lp8Pnizg2kfbUnHmu5V52RUb?=
 =?us-ascii?Q?c5o7uYMnAkvzJgnVweWpt7q7zLyBv6Re7/4Q6YWWBRukmvUWrVTTpXaOOXxG?=
 =?us-ascii?Q?4cgiRXJU52FkBTpmgbzJbwP9kY1Bkd8/2tpiQu66/kL7kS+d5nUdvivzjeRa?=
 =?us-ascii?Q?OZFjnGnmhR/aJWAbOpwFHwaul2xx4W182YYOEkzBlEcph9SvDpRKp+lGok5l?=
 =?us-ascii?Q?FPy4Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fbTdLHueagebLeIPMS93djPTBNSy4RlkiomM4nyjxmzai27gAPFKDSDtZIwBd9DrpAjRJLfsUJsoG7msorjdBFNvj9TaEi2gW0TyyLCSLctWhxqht1RnUQIPbPo6rfqrkWbCJqq1IHHD+4KCn/6+mtt5jKEmOmXaaSKwM+Mvr2T04pxRvXZ+8m2pUrXDPKunY5hTP2ELzE73Pq+J7Z/qXaiVe2DDpqlP22PDDixKjdYWxLf/1Rq8vIbq5lmTlO7UN8NISPo2o/MHXJ5FMouaKt6+WBahthuz8jf7My0OzFhISvF590HqMLQYY1xaAxEDbdAKYLCftbKkjnnC4XeXUapAMte/MY8ftNT+J/J9RcJksLa94EHNvnBXlTIIhicUV309avy+Xc1kkoRsOU5qYww6KajjNJ6Kid1DSoqCwRERtaoiG9HcU4dR71DCXoZbCbcLQ90Fi7dPfZp87fcWDeAc3y2Gfq994S7U+egY7fRw9yk6fzLZDigoHwH5iMObVUWr4R1ClXgh/B923ckXzCCZrFPTxe/jLIKrxbkFxHRg/PkKKgFRkDavpRYsqh0YDe801WNzfMFlzYqI8lirPDAyqjScYoG/dzhy+Gnj1No=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbd4aba-d09c-4140-ae07-08dcef856fd5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3508.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:59:16.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqonq06E+qVYpHOqeqvoRqHd3twjsvabNOtuGCA+nJPCFqaJzBM/VnnHYcPabVLe671EHXrFV+MpDtB6eg6vsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180096
X-Proofpoint-ORIG-GUID: pGq9D7bdh0uYbKOaAaV1Ci8H99GGwDX0
X-Proofpoint-GUID: pGq9D7bdh0uYbKOaAaV1Ci8H99GGwDX0

Hi Michael / Xuan Zhuo,

On Wednesday, 2024-10-16 at 08:55:21 +01, Darren Kenny wrote:
> Hi Michael,
>
> On Monday, 2024-10-14 at 00:57:41 -04, Michael S. Tsirkin wrote:
>> On Mon, Oct 14, 2024 at 11:12:29AM +0800, Xuan Zhuo wrote:
>>> In the last linux version, we disabled this feature to fix the
>>> regress[1].
>>> 
>>> The patch set is try to fix the problem and re-enable it.
>>> 
>>> More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
>>> 
>>> Thanks.
>>> 
>>> [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
>>
>> Darren, you previously reported crashes with a patch very similar to 1/5.
>> Can you please test this patchset and report whether they
>> are still observed?
>> If yes, any data on how to reproduce would be very benefitial for Xuan
>> Zhuo.
>>
>
> I aim to get to this in the next week, but I don't currently have
> access to a system to test it, it will take a few days at least before I
> can get one.

I finally a managed to get access to a system to test this on, and it
looks like things are working with this patch-set. So...

Tested-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

