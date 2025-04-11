Return-Path: <netdev+bounces-181741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39477A86531
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD211B847FB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73787259C91;
	Fri, 11 Apr 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EVkHuORE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ghmNB1yg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D523E34D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394547; cv=fail; b=L6+xCww2RZXH7N09NtMaFxsY11f19PUMSTrAl32AaeQbpFm0dwaQ/pZZuM+fbOSE9UWPUqCgWzT/8u5wTpPfS+NNIT8CN7cHSzdI1UUbspsJMQwAVW0hXCn31gm0TbBa7J5AZs4PfC6p9FyN15QDgIqG2ipzEH1yalQmepjDjgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394547; c=relaxed/simple;
	bh=sYQIOYc8MEgOeF6bdGMEzYdSPtV+HhSSMD6xQR1YEFo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqu9tUUorFeVU80aahrXBc85VVSdpd2NPO5pvR6jghRREG8OiI385DatAnF02UgeYDR80peJd0lati8wf6zPr9b2qzhP1qy/qvq4+ZuamYCn2CcKAwWzjhUQ9bez2a6pTAZg9DwWCvixo3vxJWjpuwAw6zQ381dqXXaoZOo7otw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EVkHuORE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ghmNB1yg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHifR7001808
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ow9gfrMsvkjWMZZ52bMDFm8P3hnI6x0RJrQakJ0rmt4=; b=
	EVkHuOREMia60QbHimolE6PD+UnhVsqU7w+eTUzHM/PFFjDuehIuCpXKv4C99fH/
	R7ii15de9SCIj382k4wvrz0gYz/in7Jsb/RBQ1EnIgt4A8eIX7PtbDl5pKgLUZpC
	andn+IvY56StLNFI9VPzTbYCbtXPSoWHA7P5exm7k+ko/ARYa6f2B713AmpvC1ez
	3j43BZlrxUJ019yj0WdKecPJbRrgCk/ac3Sh+RoLtmRkheT4bjIYLHNpHVV+TXmP
	f83H2OVgtVUBhybAaVF7KmJyd0LRzRJm5ofe4m5k//ACgUCKETRCQvWn3Zi8q9D3
	sYWCqBgpQiHErW4BF/O3PQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7g2026b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGVgZQ016129
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011031.outbound.protection.outlook.com [40.93.13.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydyngu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7zIQ1xWVgz6dGHw8ESExwA1ZaQF4KEmikQfAK781ChLFdE5ZK5uSdE7MV+cc4KitztuRf0nBzoRGcSvLVIGY5UvWEAYW1WHtWT3MNOYaB2LlmZXt7FfhOahT5QBUYFx1z6SlQyBixSxxNfvpwsfWi3i7COo5sK6Mi9A9z1HlodzAbfvkC7vZUwUjnKmA8kFXaXBfm5jyTt2yaELwqG+OCpZ18cruJ/IlfljPyPjhEOTN93+tX7KIObROyad0w6LiOnaRSMXlMUV+YchhEKjdJORdwqB5HTU5L/RvGtzfo2NRrcBPmvl464c/49OlExy6n0IRFOBgoV06Bo+f+/uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow9gfrMsvkjWMZZ52bMDFm8P3hnI6x0RJrQakJ0rmt4=;
 b=QAzZLrt+Y+pY5j34+//elGnCYJuE9w5ndIEn9O3Ox6Wb2k/m0YjoKExKf3vzFW8N4mskaOQ5b01canKO2TSTYhPDkB7lBQwoCcI0oZCeQvulCtUXwBDjYbgLmyXs6gRTtYUKcOCMWM0bz1w5x43jCZaD/wk+eAvKFW3PX120wwE9jlp8ROZlWNY1Kfpj0efRbB1brQnB6bTdx6ivnF7q+49K5YpWMXFRJbqrQWX3W2q8ZhfI0A3rBYTKD4+3Pg5mIHaOGdCeN1mfytRCHaPuhd5T9oj2cfS0KCTJKTzgrgKOaAO3AGj9vHNFLKOcKLAhL2mmz8WCgSjyYWdXKZUQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow9gfrMsvkjWMZZ52bMDFm8P3hnI6x0RJrQakJ0rmt4=;
 b=ghmNB1ygMlsTFYC7YR+An/Wuck13YnhFHhA+xsGZZlDBY7Hkma2eTPwHfcgjN/JgDeDl2uoGVWfxFcb6mf5UGY6yny+R9tHjT+Z3H/4GyqvIigCcgZM2Drwrp0Q6ArXJ0r6i8ym/3uNv/giU/9yD29YOqims7NpH54j3VVAWeZ0=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 18:02:20 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:20 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 6/8] net/rds: Encode cp_index in TCP source port
Date: Fri, 11 Apr 2025 11:02:05 -0700
Message-ID: <20250411180207.450312-7-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4676535c-9bc2-46e3-c2e9-08dd792300ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gvCuEcz1cxHI1HouueL7O8rNE3zKFyOvtweRFtluOPVdmwAojFjpuJOcf37?=
 =?us-ascii?Q?4zpS4ZrOhpwVLl1bbIPlK235EUnEbDCSKviBPfxae7mk+ilVySMB0h6r8HOQ?=
 =?us-ascii?Q?so4xOtal9gpssJj/yvp0UQSwb/llJSK81LjdnmT8g66IAK1ik4JMKHlIqaOb?=
 =?us-ascii?Q?xvPetwKDq2LCtQa8Ngf7djoytR+81iyWlzP3zM4h07RtVTjfUH4E4fzUX3dy?=
 =?us-ascii?Q?+PCH02GQ8VyL3K5xJRo0izbt9yk87QM7s5x/NAATHx5bHYpvf4dWb1wNZXOd?=
 =?us-ascii?Q?ZwQoQIYMrHsnkZ6Q9GM7eyLQm5R93Pp6iC1qAbWVyL3rZDZEnGdrIuHCD01G?=
 =?us-ascii?Q?wjL292NyTJ3NKsEV8tkv7+Hj2EDpMBWMK7zBIvP50fEsz7rCT4XC3tF+CvkO?=
 =?us-ascii?Q?Hgzo3GsbKXmyTPSiVFEsgxFntgNEnbwOr5mJQyetuYNsWaGM3qBDsggYN0zF?=
 =?us-ascii?Q?Zt0GlI7rGmGTtp5C8UfkCJwnzviK+HYyS6YtXeGwwlJEn9+1TdN52LqoHG8O?=
 =?us-ascii?Q?e7rwTMz3BB5mmQ2acCl8fq7dlbe8AE0oLhpXqOEIaUGTypsFtQsZTwtK8HlV?=
 =?us-ascii?Q?Dt6itwtvnnHMGHxrnicEH5tttdTM5pmvFfVQZ7n7fmgBClsuhxuG9c26qK+I?=
 =?us-ascii?Q?2mcRyybx5rDMS9G1sxROGMq8hcWN24LBA1/mNG73+XUpKQ+eOfaO/aFDWeAO?=
 =?us-ascii?Q?90jdVD6dcT5myNxcEbJBhAOZ0Kz8wu2IfFaZM4mgVF/hQwiKh7K4XgW3WChj?=
 =?us-ascii?Q?kvp+bKb6aQ8GidUTNIXYUujmY/FZZocQ+x0b4Hls9/zPCI4Am+A3pArtf/C0?=
 =?us-ascii?Q?RfsKFJ59cyLoaccl+Z6q58qSMrvYsd1sMz1sui/7YfWTVehMtrx9g/YK2JC+?=
 =?us-ascii?Q?R5OARR8EHl+mjDn4GQXowNhA3AGfmVk0Pzx5aU/DMtYb7w91XWdMTPgMsY8K?=
 =?us-ascii?Q?jBY8nR5VxUf0KB35cPly/q9m42yX3+LZ5tSrXzXJzHuy9Is9F8ADhvUqdKmP?=
 =?us-ascii?Q?v1yyWnJNhgsFz4/GA/HA1fjz6CcdrBO97Rl9afRVcD1WhZjL8y49ZsZSNRAr?=
 =?us-ascii?Q?MA1b+DrdsGbVw7BlAIOl0Mt9n58VaxCtXTzhb2RZ7aqInAFE88DZgB/YYi97?=
 =?us-ascii?Q?ojufIpkDM66U2f++FXDr2rgocpxpK8depKAgFeNd+X//KPaNuN1Kg2dbpn+p?=
 =?us-ascii?Q?6IGD0GrQQK16DLMWYGylxOEYMLvSj9WXDSev/eoGvyhppsGBqLWsBy9RYSrD?=
 =?us-ascii?Q?epzPZZ22/xkewgiSTY3voUsr106zYCfdhxu+0jE9IFvDGbFJMmYrwJtxULUG?=
 =?us-ascii?Q?TCXusHT4i8vwpW0XYIg4WeV6r+uaz7nwOH3/WIHnB13Xkngh0C/I8i0FLM12?=
 =?us-ascii?Q?kAmz71SZiRAnU1L8K5zEIrLi0ZlTs6bMae4jGAE6L7t3Mgs/wzJIzHBBZpeU?=
 =?us-ascii?Q?xJTv9E49Tps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GOFZ5WL3q+YPmlBzhG3x+R9YDUBJamhpmgqxAOf9FbD0Ox9t6B/qSvb0IOQm?=
 =?us-ascii?Q?AfTcIM9dn9AeJq+BI9mS1C7HVjqYHgUpm+/vpkDqwBRS9CdWGLmm3aZCF/la?=
 =?us-ascii?Q?5Xd+hWco+npGoGopJXj/2HSmcz1CSPZoO5X6Ymd2IDOPfefaKTmHgClVuspf?=
 =?us-ascii?Q?Hsv204IZxjeFXtOPFucBj96QZud7ivWiisTQJAhJOnqj4Dnr9lTWNMKJKssD?=
 =?us-ascii?Q?Xg/tJbopdrpte9MeCcInkBP/Cbr+NQwW8nwh2wAGGX1ThTo9eIDkHt9mkcJm?=
 =?us-ascii?Q?BR4BPN6sxxem06hH9PLxie5SUqlbcBDeAfukMBiIYx8QSLGOzcFFJZbm7bd3?=
 =?us-ascii?Q?lamNrDXHKnYhhjuLvXEniPxCIIlLz5HQRZqeN4TP5QBmHSZu8S0Ci1IPGKGD?=
 =?us-ascii?Q?/QVDgZX2w72Ed1+IOPmOmQPD4/+REXQ0WoN0TGin2F/CgGj5tbD/HJ91sMUX?=
 =?us-ascii?Q?oTus1JmSCw6/vmEAx2RalFOUKR384TjaKXfBOjoq3JWhqr4gKP3aPaZ+xp/J?=
 =?us-ascii?Q?gVL+CIwqKceftZJ2I21XqBTd+tYHDNqckeW5ujeI525PV9UncRFPRoutPBCk?=
 =?us-ascii?Q?dfe+ijwv7ggeR6+tWHSaQxzVB51M0hRVg/fsyBBaQjmv3lLO2gzY4Q7khFQI?=
 =?us-ascii?Q?6/THAOduGxyajNc7hY+1qOfVenvdbV2eNrCLXfOPutL0m0BmD0zRHLsDI82G?=
 =?us-ascii?Q?5L9WwGp+RNNa1MzGcQ47dd30JJfk2ai+N41sN7jrIc7lWE7j3foHZ5CxppE4?=
 =?us-ascii?Q?+nYzd1aSU7jZCGp/suI49zaxMnyXAUcfSB2myt0Cz0ztBTDw7CsnyQqXByPO?=
 =?us-ascii?Q?4cubsJjhhuTEosww9PC61AWbyVnoW4oZzJ+wjDge4w22Oi/4Rojj64ddZnl9?=
 =?us-ascii?Q?zKRDwbh6rx2xl/vTucYMSu2VbuOt2TVsilItmHLipDEecqLSuX7eVShe/5Dj?=
 =?us-ascii?Q?z78ZGXuXRIm4dRK7SbFIWXIGhsmLDwA7NaSv/EJEctTpvHBG1+wZ/VXph53Q?=
 =?us-ascii?Q?PrKWyqJ2cA53oGfpMCsvizpO26gXthnaq/nWRCr3pfk58TbhLtmdRcZoFhjE?=
 =?us-ascii?Q?GodTVbuTKD7BbKAxK6KEjM6wgWUIN+3OMzgFBYJd25pM54MwNXJLVpVSjOAT?=
 =?us-ascii?Q?QBIlM6JQjaIH8FElzh7J6aroye8bILyvoe/xVWz+hZjEz/04quWTt2YAKJId?=
 =?us-ascii?Q?Cmhpp5f6btn1D0e0LYnh/kWCzSlgDE7CVI4bGU+v5V5oiEsJS7XCxJouuoF7?=
 =?us-ascii?Q?pNnRbDOkATndgMrKerhzJ6NPqzijj98nnhesDWg/PqzVDZGcmTUqavEW6lnh?=
 =?us-ascii?Q?oZw/3ilgFuqyoO8yualK4HPEUNyZ7wDdyObAyGqGmMyMuKZhCB/GZoudPQOp?=
 =?us-ascii?Q?LZ7J9P5BinYRKnZzxDnFTY1JO2P+Sp2ZO1+7QK8SIKVYAFHvdehG2CbWATz2?=
 =?us-ascii?Q?/B2Z5hgUpBq1rWMljp0JxK6SkJ7JpschZJPXqr3zKOCcw91CalXlGnUBYoxu?=
 =?us-ascii?Q?4wtDpmL0g753jOY+oF3zYXDgldc+0cNPVdIcN+R/cJ9mqa7N71z/K0aZQnNu?=
 =?us-ascii?Q?wFo/e7VLqd1XxDfSWLnz7ObXTE+Jm2IPfh6umlcQrOreAGK07LI/wlRCOqoG?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UWAWK8bThO+H2Du/paSgxmrcNEgbWi8ZrDSiswuXlNJFDxvrooIrYOJoYqA17WmELyxkJ2H95awWytX1leZn7KdbR70vI+JMwGrLazWewrsB2yDePy6xjCWNnyuZNaZtKfXkDJhx6Cvna6lcaESgTylJpMPSG0Cb8IglYHzT+uyK3mnFnuB6cW+rQuWVqHJgzv7opq2OQoByWXPI1cQZaWdtpskFAeXJ+wRBK38Z8HpNvkH5dwGAvUKqpGzjxZNKlr8ZyFj1p1kkTOa+5r/X3jKlZ9WWGDs3BGDCgvKoMpXyFsEslQvRs8McJH4TfSCXCqjO2jJU2Y8DxiNKZknuJWf/dAqiHkIzA3Edm/XNiUqFFpju9jxfN5WsfAnIXI3j4MMkBMyer0p8s4PZ2cFa34e+GSew06XGLM7CbwH6byDXLX/SVW76DkcQ2DKg6AR88PEiI4lO/ZRWXSB1tjLZmHZJ2/LC4ihizSuqBVD9UshF9S2pwOOK3MZFqsH8bGmG7nXn+mtxKyWuCpKyg3n+Vc5haxax7nszrYWRGdTVq0J6EY2xcMNIw2YCiDzc87HDUWWvCC9syccN1Gl6iozAKOiREnbsTO+KHleNM5h5ILw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4676535c-9bc2-46e3-c2e9-08dd792300ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:20.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL99SWltvZPHjayDUtX04KLRIeukz9LRTtDtm3+JswySHe2ixoTFUzViC7qVpGzbGTHug68nbc3qSuRhkXWVTLg0NzyHCywH2rTQolhgxtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110114
X-Proofpoint-GUID: LnI6Nydh4hgVuWm5lh8pKVhrqhkGwmXl
X-Proofpoint-ORIG-GUID: LnI6Nydh4hgVuWm5lh8pKVhrqhkGwmXl

From: Gerd Rausch <gerd.rausch@oracle.com>

Upon "sendmsg", RDS/TCP selects a backend connection based
on a hash calculated from the source-port ("RDS_MPATH_HASH").

However, "rds_tcp_accept_one" accepts connections
in the order they arrive, which is non-deterministic.

Therefore the mapping of the sender's "cp->cp_index"
to that of the receiver changes if the backend
connections are dropped and reconnected.

However, connection state that's preserved across reconnects
(e.g. "cp_next_rx_seq") relies on that sender<->receiver
mapping to never change.

So we make sure that client and server of the TCP connection
have the exact same "cp->cp_index" across reconnects by
encoding "cp->cp_index" in the lower three bits of the
client's TCP source port.

A new extension "RDS_EXTHDR_SPORT_IDX" is introduced,
that allows the server to tell the difference between
clients that do the "cp->cp_index" encoding, and
legacy clients that pick source ports randomly.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/message.c     |  1 +
 net/rds/rds.h         |  3 +++
 net/rds/recv.c        |  7 +++++++
 net/rds/send.c        |  5 +++++
 net/rds/tcp.h         |  1 +
 net/rds/tcp_connect.c | 22 ++++++++++++++++++++-
 net/rds/tcp_listen.c  | 45 +++++++++++++++++++++++++++++++++++++------
 7 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 7af59d2443e5..31990ac4f3ef 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -46,6 +46,7 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 [RDS_EXTHDR_RDMA_DEST]	= sizeof(struct rds_ext_header_rdma_dest),
 [RDS_EXTHDR_NPATHS]	= sizeof(u16),
 [RDS_EXTHDR_GEN_NUM]	= sizeof(u32),
+[RDS_EXTHDR_SPORT_IDX]  = 1,
 };
 
 void rds_message_addref(struct rds_message *rm)
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 0d66d4f4cc63..89235873eb71 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -151,6 +151,7 @@ struct rds_connection {
 				c_ping_triggered:1,
 				c_pad_to_32:29;
 	int			c_npaths;
+	bool			c_with_sport_idx;
 	struct rds_connection	*c_passive;
 	struct rds_transport	*c_trans;
 
@@ -267,8 +268,10 @@ struct rds_ext_header_rdma_dest {
  */
 #define RDS_EXTHDR_NPATHS	5
 #define RDS_EXTHDR_GEN_NUM	6
+#define RDS_EXTHDR_SPORT_IDX    8
 
 #define __RDS_EXTHDR_MAX	16 /* for now */
+
 #define RDS_RX_MAX_TRACES	(RDS_MSG_RX_DGRAM_TRACE_MAX + 1)
 #define	RDS_MSG_RX_HDR		0
 #define	RDS_MSG_RX_START	1
diff --git a/net/rds/recv.c b/net/rds/recv.c
index c0a89af29d1b..f33b4904073d 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -204,7 +204,9 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		struct rds_ext_header_version version;
 		u16 rds_npaths;
 		u32 rds_gen_num;
+		u8     dummy;
 	} buffer;
+	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
 
 	while (1) {
@@ -221,11 +223,16 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		case RDS_EXTHDR_GEN_NUM:
 			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
 			break;
+		case RDS_EXTHDR_SPORT_IDX:
+			new_with_sport_idx = true;
+			break;
 		default:
 			pr_warn_ratelimited("ignoring unknown exthdr type "
 					     "0x%x\n", type);
 		}
 	}
+
+	conn->c_with_sport_idx = new_with_sport_idx;
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
 	conn->c_ping_triggered = 0;
diff --git a/net/rds/send.c b/net/rds/send.c
index 44a89d6c27a0..e173c6bcf7d5 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1456,6 +1456,7 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 	    cp->cp_conn->c_trans->t_mp_capable) {
 		u16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
 		u32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
+		u8 dummy = 0;
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_NPATHS, &npaths,
@@ -1464,6 +1465,10 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 					  RDS_EXTHDR_GEN_NUM,
 					  &my_gen_num,
 					  sizeof(u32));
+		rds_message_add_extension(&rm->m_inc.i_hdr,
+					  RDS_EXTHDR_SPORT_IDX,
+					  &dummy,
+					  sizeof(u8));
 	}
 	spin_unlock_irqrestore(&cp->cp_lock, flags);
 
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 2000f4acd57a..3beb0557104e 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -34,6 +34,7 @@ struct rds_tcp_connection {
 	 */
 	struct mutex		t_conn_path_lock;
 	struct socket		*t_sock;
+	u32			t_client_port_group;
 	struct rds_tcp_net	*t_rtn;
 	void			*t_orig_write_space;
 	void			*t_orig_data_ready;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index a0046e99d6df..6b9d4776e504 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -93,6 +93,8 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
 	struct sockaddr *addr;
+	int port_low, port_high, port;
+	int port_groups, groups_left;
 	int addrlen;
 	bool isv6;
 	int ret;
@@ -145,7 +147,25 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = kernel_bind(sock, addr, addrlen);
+	/* encode cp->cp_index in lowest bits of source-port */
+	inet_get_local_port_range(rds_conn_net(conn), &port_low, &port_high);
+	port_low = ALIGN(port_low, RDS_MPATH_WORKERS);
+	port_groups = (port_high - port_low + 1) / RDS_MPATH_WORKERS;
+	ret = -EADDRINUSE;
+	groups_left = port_groups;
+	while (groups_left-- > 0 && ret) {
+		if (++tc->t_client_port_group >= port_groups)
+			tc->t_client_port_group = 0;
+		port =  port_low +
+			tc->t_client_port_group * RDS_MPATH_WORKERS +
+			cp->cp_index;
+
+		if (isv6)
+			sin6.sin6_port = htons(port);
+		else
+			sin.sin_port = htons(port);
+		ret = sock->ops->bind(sock, addr, addrlen);
+	}
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 78d4990b2086..30146204dc6c 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -62,19 +62,52 @@ void rds_tcp_keepalive(struct socket *sock)
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
  */
-static
-struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
+static struct rds_tcp_connection *
+rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 {
-	int i;
-	int npaths = max_t(int, 1, conn->c_npaths);
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr addr;
+		struct sockaddr_in sin;
+		struct sockaddr_in6 sin6;
+	} saddr;
+	int sport, npaths, i_min, i_max, i;
+
+	if (conn->c_with_sport_idx &&
+	    kernel_getpeername(sock, &saddr.addr) == 0) {
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		switch (saddr.addr.sa_family) {
+		case AF_INET:
+			sport = ntohs(saddr.sin.sin_port);
+			break;
+		case AF_INET6:
+			sport = ntohs(saddr.sin6.sin6_port);
+			break;
+		default:
+			sport = -1;
+		}
+	} else {
+		sport = -1;
+	}
+
+	npaths = max_t(int, 1, conn->c_npaths);
 
-	for (i = 0; i < npaths; i++) {
+	if (sport >= 0) {
+		i_min = sport % npaths;
+		i_max = i_min;
+	} else {
+		i_min = 0;
+		i_max = npaths - 1;
+	}
+
+	for (i = i_min; i <= i_max; i++) {
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
 					     RDS_CONN_CONNECTING))
 			return cp->cp_transport_data;
 	}
+
 	return NULL;
 }
 
@@ -220,7 +253,7 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		 * to and discarded by the sender.
 		 * We must not throw those away!
 		 */
-		rs_tcp = rds_tcp_accept_one_path(conn);
+		rs_tcp = rds_tcp_accept_one_path(conn, new_sock);
 		if (!rs_tcp) {
 			/* It's okay to stash "new_sock", since
 			 * "rds_tcp_conn_slots_available" triggers "rds_tcp_accept_one"
-- 
2.43.0


