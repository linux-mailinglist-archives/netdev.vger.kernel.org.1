Return-Path: <netdev+bounces-170106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172FA47472
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656281888C92
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999E1EFF99;
	Thu, 27 Feb 2025 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ywakwh7L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jvlsbOgl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FC1EFF86
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630415; cv=fail; b=BAqIFS7FQ1Pdlpx9C8A6IAxRtspw7W2jNzX1YtWMyqg0vJ10q22MSQpBbeBexVbrCg8VMM6mNjTdcoa35dCwuT+SXUKxP8gZGIoOzW5i3P9ASlbjS2UHa5JMcJLq59AfF868ALun5/uvBCi7hkDeAKXQrX5yaD++S8yL9OMTvo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630415; c=relaxed/simple;
	bh=eHJ9miyqCmWJROMQwXpnPU15CjyZz7/5lYylGhBT86Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VyDYtmMhNN+oPdzJaI/a62B6r3eZcaJG6SJvjr1nwyXyt3TshJFxMDiZT1afx/gdYA0oVlJUrZWCKK96vRzHIR/1v/8uqEF9EQU+pM3P61n38jFkaUC0RpuyYNxWcac/gHbLPG9Uy+vaEzdy7vAY7ka0UJ4O5h5VvSPaZV5zr+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ywakwh7L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jvlsbOgl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1fs4l027616
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mJVzXxwATltQmCAeoZlMlT6VvItm3C5h0v5QdPB50SI=; b=
	Ywakwh7LePaUvYcdsSjc5DtEeNAw5EQlgO0cnBv9UXe4XI+DSu0SoGcSFnraIy3d
	2V6OroFG3ij9xkcwvgRGD/HdDCbeYRCZRWzawerWp7eZ+k/Mwy9CMWZr6E2wzK3T
	D4jFj9ARYJKPosnosx/JzUclCDPFA39dauTyk85FaGgQM26g5b7tFWYQBaxJ5bFo
	luESCf7Rw1H4S0fwL8Kw2aACpRprobnj6Kl0FUW2AaTdXf4oi5oFrtHe3mH0JR3L
	uzmk56porcfp+NVkIcCHpreXwgrluwefCL4xJppSrmnnAx3RjnYONVvKbIxVUWid
	5rMaXOHejS7AAjyE/Hv9Nw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdjkuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2vb68025416
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51j6m20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIGfZR0kHOo9ydjMLafSE1cKG4kT3MxqpdQJzSy8SGLb6l1nuH58q0Wj9to1aQa8ztPN4ExDnCLPThtw1yMrisWNxlSEyGyWkPmS7Lfz7UVqSKNoARWdL8qw6MdliLn7KNFi0V2IMy3a+lEOJtUWgKHZ3MmazU8WEO6XRrCEbovj4CKQKBRTg+xsvteCpYecwP6aGwBCYAQGujfS9nk88tLrzMYCy+KZx4qrmVwM1R05wAlcHINn+B2tmkk4Q0slfydeqUZDxZujbSJSa3pPaDzxO6kKzycXoW8vru44iICeGqpA3TC8ucX9yTqCNwyULPak35L9U/J+G/fDHXtrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJVzXxwATltQmCAeoZlMlT6VvItm3C5h0v5QdPB50SI=;
 b=vcXa9vGFOpmzJ0gqRwRM/wLnGmKbGyGRZFOXZXi5R8Znr5CVVEs9B/t1x2BDVdyBTjwPhSxEUWy69MfKFMawsgNW5ZsqyFy8stqGCfmmMk4LnmuCEwM8ZZ8+60Yigkz6sZS8JtfRAXth8Yk2lri6CuGKUJsgiIZnGim+zx+MZSKg5EpCL8LbIPnVxWw31+3/RhIPwymoT5nldrmQzTOzlhjPvlmYcJn5vREgDL1HFl8AZqhCrMgCAUBABg7eJuuirad7qEggNRl6HIURbFm1w16vwql19aRJdwLC/uipd9syukR9GcsnGgARKFikz106S4if74F+d8P/sozcgDb8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJVzXxwATltQmCAeoZlMlT6VvItm3C5h0v5QdPB50SI=;
 b=jvlsbOglve1G4rREwLyrP+YKjmlspmsZQ3JnumfbYmWsnOK4ajHdx8RG8t75CywmLkUAyBkOq4YdKtbAGjKTpHrto4Uds5EgsiEUGwUkWEQZ0VzJjqEcjtMcBkmZnicAA7xvPTJ/B7UhUhogjbNAfqP3lApyZqx3b7lm/HfM8ow=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7587.namprd10.prod.outlook.com (2603:10b6:806:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:48 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 04:26:48 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard messages
Date: Wed, 26 Feb 2025 21:26:37 -0700
Message-ID: <20250227042638.82553-6-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227042638.82553-1-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0033.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::25) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA1PR10MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9e4c71-a08d-470d-dcec-08dd56e6f371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QuS530iv6/JJPbtslWgrT/7/vgihBSAMiO9jtFvIrNMDF5cGnoOQNSjBqmdQ?=
 =?us-ascii?Q?0+YSmnNkEl27p28f9UP4DDxjipBu18eZnPW/fW6lCReQkLRjWAHPxOIYxmdZ?=
 =?us-ascii?Q?vhGcxHkQKK15Lf0EeGfN2EC4Nq85Ha30iagq2H+bEgrVoPbuVuPJilU4Qy21?=
 =?us-ascii?Q?NbcsfaXGD8BIwcUCLxBmrBwn+C32vyjewlBZBzv2xqRdrnOwFJZeG5hcOzJO?=
 =?us-ascii?Q?Lzku8hQoem6zCPg94l1lHlAB++CFMCN8D+Hn8qU6XaMwfDEG75x1jOafLDdQ?=
 =?us-ascii?Q?fOqhyTvaRLd9/Z8mlXnP3PB3oS1HdeyIl3vX8TrQ30lkqw5VRsJuPOTVHWKH?=
 =?us-ascii?Q?fDUyOA4ZyuR0NA7MunGn/K0pHw6AIUwOy0IFiJQ4IiHxXuVe3T8h/fjGchwl?=
 =?us-ascii?Q?NoYlUzaBQKe1ApCQT/6URZkqf7Cw2VkT/8zBkH2fFDKPjK6BfAJhxvm0Y+dr?=
 =?us-ascii?Q?OJLmpn6+/5ubbVBz1Q13hU5y1ulrGjmfM42EIx4hcJBE4dElvWEoqZOzHvV8?=
 =?us-ascii?Q?msFIW8aBc28pu0UtRo9eAxX9fnWCJSKMTaavsUSu91T2DlQTIix/dOnZLM+y?=
 =?us-ascii?Q?w0qdQSiJvIAbfjPiYFBqMXW77RSg05Z9jKE2A7NUQiKj8dfI/n9m4E7/rjub?=
 =?us-ascii?Q?pDDJvGVfL+SvILRihqKMB8xKywpSD5bPJ5iMth6PyrPSVklvq6DTGUogJqxh?=
 =?us-ascii?Q?20ccO8VoscSbfhKpHDWkzK3ZdFj8uUOv9fECh6ZFieJyeZ/XPiwZXcB2hLFp?=
 =?us-ascii?Q?f6NrnQRvfyKWYcJPt/eaZ/4msrnHVvLQlkO48JvzuHPTiFBFZTk2bdjwcEhR?=
 =?us-ascii?Q?7/rwik4P9fnpsn4YrvIntUhEw8zXTguk4dN1OpMpMeOz1nWfJI1NVXZ+Kjr7?=
 =?us-ascii?Q?3foeRYT+j1horGPU7zrV5TMZBSOMGe3dFWnupIpsINFgcJjoHRglugfla7af?=
 =?us-ascii?Q?BJsjmds5/goFd91Mor+1ytBPtUTNHEJyTmjpM3PCe3jEasw8h1Y0K9u6PBsn?=
 =?us-ascii?Q?dhvuT8m8xWPZ3/gnFL8vqnFPUMhJ6pYUzMSwoFUrHOLnD4V2nW2xW1x2vZcZ?=
 =?us-ascii?Q?ogK6vlIEN31k1wftJWDZqxRYayWCXdTj8GmV7Lg+cgNl6qubphgtQ/MObHTN?=
 =?us-ascii?Q?7QkjJ96KgEWlE38x0JgzlnJ/42xcSNh7QRGKDnmPPJCRQYtXFq2fWkF+0tOB?=
 =?us-ascii?Q?XJdz2VgKSFXt930zup0FVjimuNCtX2Nd0Kk7WA3oshmrHqsfVA37H7GMnLkw?=
 =?us-ascii?Q?wAZyqR/de3stMfVEVjL9MP1M4joUM/VnUE2fO3vG+MQSyPW2OtQCY0+3f7Ks?=
 =?us-ascii?Q?6zMGksKSEw4xnRnmt0Bq2Wcp2HztwRSewokBuFJy5aQrys7sGiODySADOHmy?=
 =?us-ascii?Q?EEd6RIBl6m5A13Yka3+AzGa3RVr2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eQVMWlaxfA+gEftoErVVWsAXoFMdZDrVci4LDpOXvfJ7xHae+fgZYIYoKGmO?=
 =?us-ascii?Q?0ipJOqMlacpnf2x/iy/9aVCsjax06zzS9vok9JAm2k7pCSZVFUJbpvIwjL8j?=
 =?us-ascii?Q?DMmTAV/WDchHCMKTDU2LEoWYa7Nu6bGLi3FSl57vqLJ4rp2aMexOhOPAbSx+?=
 =?us-ascii?Q?zEvdESjNL0lxz3N5upulOzDaeRFyIBkLI576rMHXl77Ukw4T6WdwQMZpBOk3?=
 =?us-ascii?Q?dV/gaAN1dnN1tJzGqbswBiiSdiQmvkt6kV//yt0HBeDUWJHuLQBwWSVB9VFV?=
 =?us-ascii?Q?y3NWeMqokJhojuP8hrpsVnRLps/ZFwYEHQ+6MHxKDmpTx5qoGnRT7fh8s3e7?=
 =?us-ascii?Q?lxqxbyF7kJjr3B77RL37Jq08LOG3wnBvAR6Eqc6H0xiTVVm5NMMonfnyrsRL?=
 =?us-ascii?Q?TkKTgPVC7k1kskRFSTSU8liQThyEncwcKcISFiWQxqvsIAkNp0ZmVukXZjp+?=
 =?us-ascii?Q?ExA5cGWNEvEWDLo11X5U29MVWFAKLGUN4MDL90DTXSPn2umqFGHGh5q8F7tF?=
 =?us-ascii?Q?tytu/UUOHNXPstzRsD3yFb22gbSRQ+j/flF8x+PktT5ydsel4BKBf7LUdEb4?=
 =?us-ascii?Q?sOs9S4zFAWUdkJbKob65UZ8YxtcRLjj2ACk6JuHeORg5Ej7/w3LNmyyq6OQk?=
 =?us-ascii?Q?a1HDuHWmMwX42btnXZpj+X+9RnB3rt/gIhASkgxXk51WYkB8bwWvqN6O2+p6?=
 =?us-ascii?Q?ev2hfs1yGCyhDvNu/tZzSQLmr6ZFtvcuV43LM5BFeWOsDqrzR9zA6jymTEqL?=
 =?us-ascii?Q?a+0UA31fZkTRS+NtRU5R2atV5Ce1Dndk4RDBOKzUPqXEdO2EVLLWbAwBzsTU?=
 =?us-ascii?Q?TMWheLLUVkOsUTkOSXsKT6xiFLY6NcjsHJJeHG/wFm3WH+w7llqeNLPqQCCI?=
 =?us-ascii?Q?cIkmQyDFyRwfM+9EwTAhoAKx/qAyUeVJ/3Z6op0eXRiY4HBe55v+vEENJoAU?=
 =?us-ascii?Q?iA36agLHwNcTWe2WgMkXc7Eb/H6UFgr/1yUdk0NsjttYidSXV1LXnTrGAZOw?=
 =?us-ascii?Q?WDOFcrwixmXfI171buULb/mjV7XEhABOErI90NT3HSo6Xr/VsNycC8Yv6K+a?=
 =?us-ascii?Q?uNx6kD/6CuEmvgQ7B0imU2rpO2DQtycBHgQ6D3DKM1k5JFeFhsKoz8EDJdpD?=
 =?us-ascii?Q?q6R8ixsJ/0ebAvRHI30OzCRHUrEPonnQPWzGA9JL0EZ8AakBDgePh0aSnxE7?=
 =?us-ascii?Q?0zhlCH/aVqW7fpv47wL21SCO/PhJj3sYSIWIlrDC6jbertfMCQWOhllt76+H?=
 =?us-ascii?Q?lMa/dtSLQfAYACvb2eZY+regVysQ3ws6HFwOPaH1xYOc45cCbkhqDFv4r25Z?=
 =?us-ascii?Q?EbfvslyzPIfL8Xd7fx2smDxwKlEtMSBNOoeE/qNs22awuTIFHq28lWoWdpfe?=
 =?us-ascii?Q?sG9F7Hdw0iPafj8+OAno0PuBM2T4BluZ6IybA6tntvMdQZ27Ho/cztgy6IG9?=
 =?us-ascii?Q?z767g6uiAlYJtZE41C1klVXopz3u1F/HZd8oCHFFCbIkz4Eo9JnwCkNcXQHM?=
 =?us-ascii?Q?lwnrQB3lkfqLVKXxBg4imKH8ZRlgMNtapNF7BzH+aJePNWWNcspeV6tyS2bQ?=
 =?us-ascii?Q?M8XEfAtme3nUff1GhPSooxfNkiZliK+ER6Fe91E75db+LWLSlWh6UcMNr2WD?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rVYpOaMH1bCFdNkhpYT3qPp3lnKJ5J+TGBVSNpL6h4RMIL9RpjoGaViEmgScNQE1f6fqQhK7ktUOw79kfdfW5bwTSlUv2CmzBeOOYibPxMtmtuhx3PvNXXqaAzGz/Qn1h2NKU1ndNVZOqYcF5LF0tJtnspM1z+eYxhcElqZEALOLQMMdL8LaiGLE8D1FxeTBFTh5hnF1nN3ZeRJNOOCjAwXA6ncyR6Eci4zXAqNGUBdWMcks9527psVND4RQukP1Co6QS+dVNPQQFD5dly8DCoYvMvkAeiYapxhD5Iy7zDXbjCm2hQxRToQJtbqeWwPoyB9kQvn7frEwsa9pB1TgSOxykEEMoQAC+QRdAV6IFiN9+9Cp9w01m9bmF9eak1EdyuZP4RV/WB3cpruWvuLzxaP8lvKiWE52k+K8MZFC2VF4LuYA82bsizb+6EK6iWXRnWhqvBPPUyIa8y22ya6jpLyPeZbvyJaozD2r9oi9cVHX0GaWJaYAjVz8mHZc643rj3vPHSYR6goaFm/KpGS/8HlMP5YTJEvDKdKuCzbjAWbNZ9c8Z9PxELK7Y3ES8i314fhLDcnpkuAo8BCFNBDK2t7eAjZDveieoP5E8dxbicU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9e4c71-a08d-470d-dcec-08dd56e6f371
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:48.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hF1rXl5UWOGVUd6WS+WjpJkHsLL6GBC2WVGxjJFS3RQ2ssOj2BzhEdcwX1gfy4FuhGLqm0nOkBUU9Zw5jr/TK5GlEShFZoqxv4sgFhOogfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270031
X-Proofpoint-GUID: s-znaGNyUJM_n4aO4flUBJvXY0_wJ4ye
X-Proofpoint-ORIG-GUID: s-znaGNyUJM_n4aO4flUBJvXY0_wJ4ye

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS/TCP differs from RDS/RDMA in that message acknowledgment
is done based on TCP sequence numbers:
As soon as the last byte of a message has been acknowledged
by the TCP stack of a peer, "rds_tcp_write_space()" goes on
to discard prior messages from the send queue.

Which is fine, for as long as the receiver never throws any messages away.

Unfortunately, that is *not* the case since the introduction of MPRDS:
commit "RDS: TCP: Enable multipath RDS for TCP"

A new function "rds_tcp_accept_one_path" was introduced,
which is entitled to return "NULL", if no connection path is currently
available.

Unfortunately, this happens after the "->accept()" call, and the new socket
often already contains messages, since the peer already transitioned
to "RDS_CONN_UP" on behalf of "TCP_ESTABLISHED".

That's also the case after this [1]:
commit "RDS: TCP: Force every connection to be initiated by numerically
smaller IP address"

which tried to address the situation of pending data by only transitioning
connections from a smaller IP address to "RDS_CONN_UP".

But even in those cases, and in particular if the "RDS_EXTHDR_NPATHS"
handshake has not occurred yet, and therefore we're working with
"c_npaths <= 1", "c_conn[0]" may be in a state distinct from
"RDS_CONN_DOWN", and therefore all messages on the just accepted socket
will be tossed away.

This fix changes "rds_tcp_accept_one":

* If connected from a peer with a larger IP address, the new socket
  will continue to get closed right away.
  With commit [1] above, there should not be any messages
  in the socket receive buffer, since the peer never transitioned
  to "RDS_CONN_UP".
  Therefore it should be okay to not make any efforts to dispatch
  the socket receive buffer.

* If connected from a peer with a smaller IP address,
  we call "rds_tcp_accept_one_path" to find a free slot/"path".
  If found, business goes on as usual.
  If none was found, we save/stash the newly accepted socket
  into "rds_tcp_accepted_sock", in order to not lose any
  messages that may have arrived already.
  We then return from "rds_tcp_accept_one" with "-ENOBUFS".
  Later on, when a slot/"path" does become available again
  (e.g. state transitioned to "RDS_CONN_DOWN",
   or HS extension header was received with "c_npaths > 1")
  we call "rds_tcp_conn_slots_available" that simply re-issues
  a "rds_tcp_accept_one_path" worker-callback and picks
  up the new socket from "rds_tcp_accepted_sock", and thereby
  continuing where it left with "-ENOBUFS" last time.
  Since a new slot has become available, those messages
  won't be lost, since processing proceeds as if that slot
  had been available the first time around.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Jack Vogel <jack.vogel@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/rds.h        |   1 +
 net/rds/recv.c       |   4 ++
 net/rds/tcp.c        |  27 +++-----
 net/rds/tcp.h        |  22 +++++-
 net/rds/tcp_listen.c | 160 ++++++++++++++++++++++++++++++-------------
 5 files changed, 148 insertions(+), 66 deletions(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index 85b47ce52266..422d5e26410e 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -548,6 +548,7 @@ struct rds_transport {
 			   __u32 scope_id);
 	int (*conn_alloc)(struct rds_connection *conn, gfp_t gfp);
 	void (*conn_free)(void *data);
+	void (*conn_slots_available)(struct rds_connection *conn);
 	int (*conn_path_connect)(struct rds_conn_path *cp);
 	void (*conn_path_shutdown)(struct rds_conn_path *conn);
 	void (*xmit_path_prepare)(struct rds_conn_path *cp);
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 5627f80013f8..c0a89af29d1b 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -230,6 +230,10 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
 	conn->c_ping_triggered = 0;
 	rds_conn_peer_gen_update(conn, new_peer_gen_num);
+
+	if (conn->c_npaths > 1 &&
+	    conn->c_trans->conn_slots_available)
+		conn->c_trans->conn_slots_available(conn);
 }
 
 /* rds_start_mprds() will synchronously start multiple paths when appropriate.
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index b3f2c6e27b59..915b35136693 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -221,6 +221,8 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 		sock->sk->sk_data_ready = sock->sk->sk_user_data;
 
 	tc->t_sock = sock;
+	if (!tc->t_rtn)
+		tc->t_rtn = net_generic(sock_net(sock->sk), rds_tcp_netid);
 	tc->t_cpath = cp;
 	tc->t_orig_data_ready = sock->sk->sk_data_ready;
 	tc->t_orig_write_space = sock->sk->sk_write_space;
@@ -386,6 +388,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		}
 		mutex_init(&tc->t_conn_path_lock);
 		tc->t_sock = NULL;
+		tc->t_rtn = NULL;
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
@@ -466,6 +469,7 @@ struct rds_transport rds_tcp_transport = {
 	.recv_path		= rds_tcp_recv_path,
 	.conn_alloc		= rds_tcp_conn_alloc,
 	.conn_free		= rds_tcp_conn_free,
+	.conn_slots_available	= rds_tcp_conn_slots_available,
 	.conn_path_connect	= rds_tcp_conn_path_connect,
 	.conn_path_shutdown	= rds_tcp_conn_path_shutdown,
 	.inc_copy_to_user	= rds_tcp_inc_copy_to_user,
@@ -481,17 +485,7 @@ struct rds_transport rds_tcp_transport = {
 	.t_unloading		= rds_tcp_is_unloading,
 };
 
-static unsigned int rds_tcp_netid;
-
-/* per-network namespace private data for this module */
-struct rds_tcp_net {
-	struct socket *rds_tcp_listen_sock;
-	struct work_struct rds_tcp_accept_w;
-	struct ctl_table_header *rds_tcp_sysctl;
-	struct ctl_table *ctl_table;
-	int sndbuf_size;
-	int rcvbuf_size;
-};
+int rds_tcp_netid;
 
 /* All module specific customizations to the RDS-TCP socket should be done in
  * rds_tcp_tune() and applied after socket creation.
@@ -538,15 +532,12 @@ static void rds_tcp_accept_worker(struct work_struct *work)
 					       struct rds_tcp_net,
 					       rds_tcp_accept_w);
 
-	while (rds_tcp_accept_one(rtn->rds_tcp_listen_sock) == 0)
+	while (rds_tcp_accept_one(rtn) == 0)
 		cond_resched();
 }
 
-void rds_tcp_accept_work(struct sock *sk)
+void rds_tcp_accept_work(struct rds_tcp_net *rtn)
 {
-	struct net *net = sock_net(sk);
-	struct rds_tcp_net *rtn = net_generic(net, rds_tcp_netid);
-
 	queue_work(rds_wq, &rtn->rds_tcp_accept_w);
 }
 
@@ -558,6 +549,8 @@ static __net_init int rds_tcp_init_net(struct net *net)
 
 	memset(rtn, 0, sizeof(*rtn));
 
+	mutex_init(&rtn->rds_tcp_accept_lock);
+
 	/* {snd, rcv}buf_size default to 0, which implies we let the
 	 * stack pick the value, and permit auto-tuning of buffer size.
 	 */
@@ -621,6 +614,8 @@ static void rds_tcp_kill_sock(struct net *net)
 
 	rtn->rds_tcp_listen_sock = NULL;
 	rds_tcp_listen_stop(lsock, &rtn->rds_tcp_accept_w);
+	if (rtn->rds_tcp_accepted_sock)
+		sock_release(rtn->rds_tcp_accepted_sock);
 	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
 		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 053aa7da87ef..2000f4acd57a 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -4,6 +4,21 @@
 
 #define RDS_TCP_PORT	16385
 
+/* per-network namespace private data for this module */
+struct rds_tcp_net {
+	/* serialize "rds_tcp_accept_one" with "rds_tcp_accept_lock"
+	 * to protect "rds_tcp_accepted_sock"
+	 */
+	struct mutex		rds_tcp_accept_lock;
+	struct socket		*rds_tcp_listen_sock;
+	struct socket		*rds_tcp_accepted_sock;
+	struct work_struct	rds_tcp_accept_w;
+	struct ctl_table_header	*rds_tcp_sysctl;
+	struct ctl_table	*ctl_table;
+	int			sndbuf_size;
+	int			rcvbuf_size;
+};
+
 struct rds_tcp_incoming {
 	struct rds_incoming	ti_inc;
 	struct sk_buff_head	ti_skb_list;
@@ -19,6 +34,7 @@ struct rds_tcp_connection {
 	 */
 	struct mutex		t_conn_path_lock;
 	struct socket		*t_sock;
+	struct rds_tcp_net	*t_rtn;
 	void			*t_orig_write_space;
 	void			*t_orig_data_ready;
 	void			*t_orig_state_change;
@@ -49,6 +65,7 @@ struct rds_tcp_statistics {
 };
 
 /* tcp.c */
+extern int rds_tcp_netid;
 bool rds_tcp_tune(struct socket *sock);
 void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp);
 void rds_tcp_reset_callbacks(struct socket *sock, struct rds_conn_path *cp);
@@ -57,7 +74,7 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc);
 u32 rds_tcp_snd_una(struct rds_tcp_connection *tc);
 extern struct rds_transport rds_tcp_transport;
-void rds_tcp_accept_work(struct sock *sk);
+void rds_tcp_accept_work(struct rds_tcp_net *rtn);
 int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 			__u32 scope_id);
 /* tcp_connect.c */
@@ -69,7 +86,8 @@ void rds_tcp_state_change(struct sock *sk);
 struct socket *rds_tcp_listen_init(struct net *net, bool isv6);
 void rds_tcp_listen_stop(struct socket *sock, struct work_struct *acceptor);
 void rds_tcp_listen_data_ready(struct sock *sk);
-int rds_tcp_accept_one(struct socket *sock);
+void rds_tcp_conn_slots_available(struct rds_connection *conn);
+int rds_tcp_accept_one(struct rds_tcp_net *rtn);
 void rds_tcp_keepalive(struct socket *sock);
 void *rds_tcp_listen_sock_def_readable(struct net *net);
 
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 886b5373843e..e44384f0adf7 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -35,6 +35,8 @@
 #include <linux/in.h>
 #include <net/tcp.h>
 #include <trace/events/sock.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
 
 #include "rds.h"
 #include "tcp.h"
@@ -66,32 +68,47 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 	int i;
 	int npaths = max_t(int, 1, conn->c_npaths);
 
-	/* for mprds, all paths MUST be initiated by the peer
-	 * with the smaller address.
-	 */
-	if (rds_addr_cmp(&conn->c_faddr, &conn->c_laddr) >= 0) {
-		/* Make sure we initiate at least one path if this
-		 * has not already been done; rds_start_mprds() will
-		 * take care of additional paths, if necessary.
-		 */
-		if (npaths == 1)
-			rds_conn_path_connect_if_down(&conn->c_path[0]);
-		return NULL;
-	}
-
 	for (i = 0; i < npaths; i++) {
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
-					     RDS_CONN_CONNECTING)) {
+					     RDS_CONN_CONNECTING))
 			return cp->cp_transport_data;
-		}
 	}
 	return NULL;
 }
 
-int rds_tcp_accept_one(struct socket *sock)
+void rds_tcp_conn_slots_available(struct rds_connection *conn)
+{
+	struct rds_tcp_connection *tc;
+	struct rds_tcp_net *rtn;
+
+	smp_rmb();
+	if (test_bit(RDS_DESTROY_PENDING, &conn->c_path->cp_flags))
+		return;
+
+	tc = conn->c_path->cp_transport_data;
+	rtn = tc->t_rtn;
+	if (!rtn)
+		return;
+
+	/* As soon as a connection went down,
+	 * it is safe to schedule a "rds_tcp_accept_one"
+	 * attempt even if there are no connections pending:
+	 * Function "rds_tcp_accept_one" won't block
+	 * but simply return -EAGAIN in that case.
+	 *
+	 * Doing so is necessary to address the case where an
+	 * incoming connection on "rds_tcp_listen_sock" is ready
+	 * to be acccepted prior to a free slot being available:
+	 * the -ENOBUFS case in "rds_tcp_accept_one".
+	 */
+	rds_tcp_accept_work(rtn);
+}
+
+int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 {
+	struct socket *listen_sock = rtn->rds_tcp_listen_sock;
 	struct socket *new_sock = NULL;
 	struct rds_connection *conn;
 	int ret;
@@ -109,37 +126,45 @@ int rds_tcp_accept_one(struct socket *sock)
 #endif
 	int dev_if = 0;
 
-	if (!sock) /* module unload or netns delete in progress */
-		return -ENETUNREACH;
+	mutex_lock(&rtn->rds_tcp_accept_lock);
 
-	ret = sock_create_lite(sock->sk->sk_family,
-			       sock->sk->sk_type, sock->sk->sk_protocol,
-			       &new_sock);
-	if (ret)
-		goto out;
+	if (!listen_sock)
+		return -ENETUNREACH;
 
-	ret = sock->ops->accept(sock, new_sock, &arg);
-	if (ret < 0)
-		goto out;
+	new_sock = rtn->rds_tcp_accepted_sock;
+	rtn->rds_tcp_accepted_sock = NULL;
+
+	if (!new_sock) {
+		ret = sock_create_lite(listen_sock->sk->sk_family,
+				       listen_sock->sk->sk_type,
+				       listen_sock->sk->sk_protocol,
+				       &new_sock);
+		if (ret)
+			goto out;
+
+		ret = listen_sock->ops->accept(listen_sock, new_sock, &arg);
+		if (ret < 0)
+			goto out;
+
+		/* sock_create_lite() does not get a hold on the owner module so we
+		 * need to do it here.  Note that sock_release() uses sock->ops to
+		 * determine if it needs to decrement the reference count.  So set
+		 * sock->ops after calling accept() in case that fails.  And there's
+		 * no need to do try_module_get() as the listener should have a hold
+		 * already.
+		 */
+		new_sock->ops = listen_sock->ops;
+		__module_get(new_sock->ops->owner);
 
-	/* sock_create_lite() does not get a hold on the owner module so we
-	 * need to do it here.  Note that sock_release() uses sock->ops to
-	 * determine if it needs to decrement the reference count.  So set
-	 * sock->ops after calling accept() in case that fails.  And there's
-	 * no need to do try_module_get() as the listener should have a hold
-	 * already.
-	 */
-	new_sock->ops = sock->ops;
-	__module_get(new_sock->ops->owner);
+		rds_tcp_keepalive(new_sock);
+		if (!rds_tcp_tune(new_sock)) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-	rds_tcp_keepalive(new_sock);
-	if (!rds_tcp_tune(new_sock)) {
-		ret = -EINVAL;
-		goto out;
+		inet = inet_sk(new_sock->sk);
 	}
 
-	inet = inet_sk(new_sock->sk);
-
 #if IS_ENABLED(CONFIG_IPV6)
 	my_addr = &new_sock->sk->sk_v6_rcv_saddr;
 	peer_addr = &new_sock->sk->sk_v6_daddr;
@@ -150,7 +175,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	peer_addr = &daddr;
 #endif
 	rdsdebug("accepted family %d tcp %pI6c:%u -> %pI6c:%u\n",
-		 sock->sk->sk_family,
+		 listen_sock->sk->sk_family,
 		 my_addr, ntohs(inet->inet_sport),
 		 peer_addr, ntohs(inet->inet_dport));
 
@@ -170,13 +195,13 @@ int rds_tcp_accept_one(struct socket *sock)
 	}
 #endif
 
-	if (!rds_tcp_laddr_check(sock_net(sock->sk), peer_addr, dev_if)) {
+	if (!rds_tcp_laddr_check(sock_net(listen_sock->sk), peer_addr, dev_if)) {
 		/* local address connection is only allowed via loopback */
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
-	conn = rds_conn_create(sock_net(sock->sk),
+	conn = rds_conn_create(sock_net(listen_sock->sk),
 			       my_addr, peer_addr,
 			       &rds_tcp_transport, 0, GFP_KERNEL, dev_if);
 
@@ -189,15 +214,51 @@ int rds_tcp_accept_one(struct socket *sock)
 	 * If the client reboots, this conn will need to be cleaned up.
 	 * rds_tcp_state_change() will do that cleanup
 	 */
-	rs_tcp = rds_tcp_accept_one_path(conn);
-	if (!rs_tcp)
+	if (rds_addr_cmp(&conn->c_faddr, &conn->c_laddr) < 0) {
+		/* Try to obtain a free connection slot.
+		 * If unsuccessful, we need to preserve "new_sock"
+		 * that we just accepted, since its "sk_receive_queue"
+		 * may contain messages already that have been acknowledged
+		 * to and discarded by the sender.
+		 * We must not throw those away!
+		 */
+		rs_tcp = rds_tcp_accept_one_path(conn);
+		if (!rs_tcp) {
+			/* It's okay to stash "new_sock", since
+			 * "rds_tcp_conn_slots_available" triggers "rds_tcp_accept_one"
+			 * again as soon as one of the connection slots
+			 * becomes available again
+			 */
+			rtn->rds_tcp_accepted_sock = new_sock;
+			new_sock = NULL;
+			ret = -ENOBUFS;
+			goto out;
+		}
+	} else {
+		/* This connection request came from a peer with
+		 * a larger address.
+		 * Function "rds_tcp_state_change" makes sure
+		 * that the connection doesn't transition
+		 * to state "RDS_CONN_UP", and therefore
+		 * we should not have received any messages
+		 * on this socket yet.
+		 * This is the only case where it's okay to
+		 * not dequeue messages from "sk_receive_queue".
+		 */
+		if (conn->c_npaths <= 1)
+			rds_conn_path_connect_if_down(&conn->c_path[0]);
+		rs_tcp = NULL;
 		goto rst_nsk;
+	}
+
 	mutex_lock(&rs_tcp->t_conn_path_lock);
 	cp = rs_tcp->t_cpath;
 	conn_state = rds_conn_path_state(cp);
 	WARN_ON(conn_state == RDS_CONN_UP);
-	if (conn_state != RDS_CONN_CONNECTING && conn_state != RDS_CONN_ERROR)
+	if (conn_state != RDS_CONN_CONNECTING && conn_state != RDS_CONN_ERROR) {
+		rds_conn_path_drop(cp, 0);
 		goto rst_nsk;
+	}
 	if (rs_tcp->t_sock) {
 		/* Duelling SYN has been handled in rds_tcp_accept_one() */
 		rds_tcp_reset_callbacks(new_sock, cp);
@@ -228,6 +289,9 @@ int rds_tcp_accept_one(struct socket *sock)
 		mutex_unlock(&rs_tcp->t_conn_path_lock);
 	if (new_sock)
 		sock_release(new_sock);
+
+	mutex_unlock(&rtn->rds_tcp_accept_lock);
+
 	return ret;
 }
 
@@ -255,7 +319,7 @@ void rds_tcp_listen_data_ready(struct sock *sk)
 	 * the listen socket is being torn down.
 	 */
 	if (sk->sk_state == TCP_LISTEN)
-		rds_tcp_accept_work(sk);
+		rds_tcp_accept_work(net_generic(sock_net(sk), rds_tcp_netid));
 	else
 		ready = rds_tcp_listen_sock_def_readable(sock_net(sk));
 
-- 
2.43.0


