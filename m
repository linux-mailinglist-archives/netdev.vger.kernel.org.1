Return-Path: <netdev+bounces-122018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC8A95F92B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422D0283BAB
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09261991D0;
	Mon, 26 Aug 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCOFhr4S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kb7C6eIa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981881AB4;
	Mon, 26 Aug 2024 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697949; cv=fail; b=louyK9Qlvl/wDT5OrtLmLWlU6oyznjF7l7Q+RKpxRrR9g7GfG+3qxR5yoZGdZtH3pvOIuzjKovf0XuFFNSFOpQGCdGV5wvjLZ2cg7k/0tF1Jnpg3dac9fiOcKrx8dYSPhhRUEb97k5LtsZO2a0e5QO5O6Qi10+XgvweHN1Vw9Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697949; c=relaxed/simple;
	bh=8DIejaWgn46eu08WcqjJmr6osopvQWjxLfPz9E+Ibkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pEVb/daunCbHjY0l90FUUX/w6/PM2fIUYky06wyHHIY1pW87zomiSwKKueqPrQ5quQTczdrmsX+ZxO6TrOTQmXho7qftyWL0OCaAEnq5cSRq5Ye1RjndJtdRdAq+JFQZQseUlnwHnMNwSfdl82kJa46U7QxgTdKNJOgjEBPmW5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCOFhr4S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kb7C6eIa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QIfRU4027829;
	Mon, 26 Aug 2024 18:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Oi1GLmXbdvzbRwc
	jVAWmUr4mmJM8fCIkRFRb4u0f1T8=; b=lCOFhr4S7vfwo7I+zwijXaUSy/TtZeE
	qeENdzKnF24X5gBGtuYnuxSX6BlMLSYQDIw+NJ8wt4HMl2n/eLZBE4JGK6NtvB0H
	ciKc3TExNQSzqHjLx3mO5H8/9sJuXwqNTMVFy2X/e568Q9uiKCOo99cn6aRUsTQz
	3ctsTYVmCGJR43I7WYT+RYpTWK9vYP0U8wJP2l8dzmcoye0sH+5jEwxeRrmFBbEF
	DFW0vSuxC0FWQK8FmxDaAJo25Q0POadAogB26Yy9tQOIL1gDKDZx69kSF4m43Jg1
	inLySeWj4Dz8re4JB1Kegsi2ocekxmja6qoQBxAJ7OgKl4NF8Q8aRgw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nabuvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 18:45:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QIJQJ8032460;
	Mon, 26 Aug 2024 18:45:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0swmh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 18:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaH5mZBPnfo/8Dt9fDfdypGrbxb/v2FXwL6MqwzKTp/1CbXvY5AcchxbuYunuNzoIlQ8hULfO5Cw99nWekdUP66ojUoY03iCnJfqXgd54AAxdTEy2Zvgb6Rz0CH5Q+3M0D0eRqy/u6Hq9FmTzzgFqu29vTfOfuXHBKy0QqP2Jt1fBgE2CL19ly3CES6MiQJTOidJQjIxQNlLWDgC8kkvgtVp24V30WYP0pzZoXliblwOgN5OVMgfBozZheP3LlWth6xSp0hT1iB0xJgJXYb3z1M0a2zEaXToHJ/BlJwGfmFwvUEt+CaqM9lExO4335YIx6OUe8t7AHdNpH1Ith8hTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi1GLmXbdvzbRwcjVAWmUr4mmJM8fCIkRFRb4u0f1T8=;
 b=HdB/1EaS0HmciCp1Bc+kwWHf/adu/80EcDeXcQ8dtoIGQLRmXUMT7kck+WuH8uuzKTHQD1HUNg7w0BzM7THx/9xQBwnuKi5rjqKXzdS9b9tTqY7VyrU/IEsFWfxCJj4KUcLjy3MENmLMi9J/+V1cwLsL5qGwWyZCqoNqDocXxq1RJXN9FYMO614yqK5swnueLUoB65+fN4fa+4sGVi5hpnveybsYCgd6AYpM/AVTKm1MbzIT7N8ufY3O9zJOZjzr5f4UVQXnnDLq8E8ymWjmWkpie/eAsbdZ6vxP8Sw6WeTUkpri7DwT6dgJ8Eil5Q8e39IOq5cMbldiX8PsJZKubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi1GLmXbdvzbRwcjVAWmUr4mmJM8fCIkRFRb4u0f1T8=;
 b=kb7C6eIaE+uTZfe+nmf8/Igxf/inBjuQruClvwH8AF4FzDycqyQfxIpYH5nB2UwcGI9Ye1Kq7Qeo/mg91QHVj6rB56Z3Bc5vdezo2WHsilJ83OzEz0PlWGbc1v75u9Wot0151lwG/eP5c5QpmeKovesMuVsYGFo9bVTx3mlurCw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6263.namprd10.prod.outlook.com (2603:10b6:930:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 18:44:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 18:44:55 +0000
Date: Mon, 26 Aug 2024 14:44:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: A K M Fazla Mehrab <a.mehrab@bytedance.com>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Subject: Re: [Patch net-next] net/handshake: use sockfd_put() helper
Message-ID: <ZszNJBRScwD6pXPB@tissot.1015granger.net>
References: <20240826182652.2449359-1-a.mehrab@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826182652.2449359-1-a.mehrab@bytedance.com>
X-ClientProxiedBy: CH0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:610:cc::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: b3772222-0861-4941-482a-08dcc5ff2dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kRdT0h+no6PijmyJQEd0CXw6zhSAVDRg0ljZziO7Udtfk3+LWxzZ+W4MXJFD?=
 =?us-ascii?Q?lQu1c9Gkr1+qMQk73XjI9zC5i2MVKOuJ81/S/rSkCvoo8jmrixgpFSxoqjW1?=
 =?us-ascii?Q?cXOrvknbZvVrw2yl+2Y1EalgHXtPn1ORRgcdrdfTSJI3k5SRRovbH6Yykazg?=
 =?us-ascii?Q?XUNl0TH9APm7o5GhOzcT8symx3P1NhxPAmTjV+K1uZle/tN35rHupyzl/h8V?=
 =?us-ascii?Q?gbSMKkv8bdDUXGURPz4YjmiBOU7j4m9SdWbHC5Y9/Dl4Asxv9tmMszuRpCPq?=
 =?us-ascii?Q?68IDJVB8QWL9GqVe2ZkKXGQGWvQ+Ol30wI8p3log2ll3FpJ/F11YSIvzqHJI?=
 =?us-ascii?Q?dJdGrYDwkjiucWbEZ63z+/W1Twtk8WMD2st53R69P5DgCRrotSd4jFVDqywj?=
 =?us-ascii?Q?FXp/kUA4YOUl/5vckPJTqMSZ0Ej3LmRqf59jrbm3Qv8pR0T8AvUT3Rycug6K?=
 =?us-ascii?Q?/DH9SI/WaIZb/4Ijpzhn6HAf/KSlDOxe5CkWfRO0sb0CEbjZNBVb5PtGlx/Z?=
 =?us-ascii?Q?m/ZcASoOKtFihf6b+WWB64UuRTdW81oP4IKp7QfrVjiEMI2ykwYJ/KZGuLpx?=
 =?us-ascii?Q?Yj1CulRDnLbbFoOaypoT3DMZ6uqPskcy6fx2ByVLdcLkfnwDPE+rgbmKRl2u?=
 =?us-ascii?Q?GzazvwUx24ISm2n41x7mp4y2BRcYfixsjgFwgy8s7RFB+UYTgb8UMC5l5+bc?=
 =?us-ascii?Q?D2Zfop6pKtTSRgjE/j0fHvP9I9IGkGbazxnm8fe6FBS0FaB97A61N4lEoglY?=
 =?us-ascii?Q?0NOaRb3PCtcGBiB59EPMKWb1tSbVWQhgLfF0ploFVU/5BaJHPgPFM6QWISC7?=
 =?us-ascii?Q?tBBP2B5LuR8KHBLCqixL3xr3J/LQpx3Dpy7CS4MgFeXUML1WcmxGijjJxF9Z?=
 =?us-ascii?Q?m79Nz8L/qDCwMiqwi1WRk4h4wGMZTweqfIL1zwexrReZ48euSKMekMj5kzEc?=
 =?us-ascii?Q?rg0cZjrb4kd5d2GVOkdvCf0XeIrE2IEXQLTzIhvgBt5x7Kynp6Yq/vrla0Hd?=
 =?us-ascii?Q?BmCpkEKv1ZAdYW3j+oGaI1XEhZc6OatgGieScgeFqo38zLxIf4lO6b/ZZw37?=
 =?us-ascii?Q?uw7RBeqvzPh0a9W0/TMUoRNkwobU65VE+WcMFBkpNHyAuLWBc2xqXlDsc3ar?=
 =?us-ascii?Q?9GdXAJoGOH7XVnRbyJSyy5G51wQMKUEF0qa+f0/6d+ScQpKFEGIoiLoPwwC6?=
 =?us-ascii?Q?+nxnCUCt6IECO5RT5gP425K9FXGQz9/4BtIndVkydvWmS91RHyPG230xjK/k?=
 =?us-ascii?Q?S9Yjx8NIFDwGrVWZRBwyb2TANNK8n1d/bJtFFTEdRJpmedllHUUr2IHEW7y9?=
 =?us-ascii?Q?v0yQITw2CZ+04iO+7no5kQCqbiEnJi9XfJ1j73WLST2k1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4aJ8AauU9saNkM24s46BeOfZy6plbiMUZOPrjazvEcmQmOLxL26A+jd4TQN?=
 =?us-ascii?Q?9NP1D1XZkSEw2nW6Pl3+h+ApgDK87criVno+b4wLA4shuKUOnRFeWK0jmxOc?=
 =?us-ascii?Q?Eg2ANU9O40cFGTw5KyuPc/2QHS+ocZN7AkGt/0TOWldQNLcAa55oyDW+YAiV?=
 =?us-ascii?Q?Tu6mfBxwUrUen1sfY7MlIHuzPQUxx4ddFXZWjAUXwTaIeRx+6DAvN711SfCt?=
 =?us-ascii?Q?OhFyEktlW+WCCfLPpF22/UX80k2glNRGPo/TEwYdWa6soylbzHLFI6QQ+6zW?=
 =?us-ascii?Q?6wkfEsEIQvlLikASqHmlUX3JBLLg+WB9BfKkM2rC2BRSi4zXz+rtq+wqqiBq?=
 =?us-ascii?Q?FcaC7HFjVNteNUU+0a/Q+eiH/k80K2GxmjUq/OjWaBJEmzD8cBBB0GAMyFKl?=
 =?us-ascii?Q?9JTOWVuqrtsjOm4OjwAvdfI3yXWHmfGWc26hbfX+qremmwSWo0YXIOb0suVm?=
 =?us-ascii?Q?U6ovf5m52737TncCFx9CKgVBOGuPvQXw/n1EDTBK8o64VOj3/76M/LshXu3k?=
 =?us-ascii?Q?j46vwh45jOb2pte8ZbOfydiqh+8T/9cuXMquzh48689s/bMZepvHLOnY7sBd?=
 =?us-ascii?Q?dFrpI8O2jaY8yVxY8EtfHuW7/SRPiNUmlvfL3ibfcjniY65lpbF9egovvypJ?=
 =?us-ascii?Q?FKLG8iooyJu7tNBspZiDFY+izbfsP/9Q54WzZ9tjMi5uYYgpYsYApVuhHORI?=
 =?us-ascii?Q?gsMCCzzQb8U7jxEROgHuBo/GnhQehTNyl0l6l6LPis1ezfSa1sX74fX1AKSQ?=
 =?us-ascii?Q?+IelJ2uwNU6id2AEC72Q2aE0Or+5qygC6PvlJTpErpkKpLapxI8EO8MSIQQ0?=
 =?us-ascii?Q?WGv72029NpnhGGmlwWSY+eRTusqOvdlQv6czk8FPCjihaNk22I/FAQf3lWP7?=
 =?us-ascii?Q?J2WXPH2TT+JwbbS68JfpVDn39SkBAwLyd+iTU7YNkIP0jWx4CDOHIi6UZej+?=
 =?us-ascii?Q?IYvG+cU5txGXoeWzHCuZshCC7uq0C+N5XObrekWEsU7wpHagUTI31UhZgXeX?=
 =?us-ascii?Q?T/qT6T8cVL9oXL7dWBdnaCoIoqV6xtGnrl3cBJgvlVduHH+Gu2Yy9w+w2yC0?=
 =?us-ascii?Q?rUuFw9imx9PbJGWa6fA2GNwCdszcbwV5yk1oldddhDUJABZcNhyVXElu88oB?=
 =?us-ascii?Q?785vnHv25TAQ4+4muLmrGZ9PbGFmZOQTXDMPfrvk9RRaV96frxvmnaeKJv6p?=
 =?us-ascii?Q?KSP6Gyh3xsRK/FdYVicjGofhYMdUD7ykegO9bHwLD+u6m1NuM+jvwlGoPfEz?=
 =?us-ascii?Q?wFIBe69Uh82EUrW3J8vATxCXjswT6IU+okfEBZItFJiseTqYlaJqdNTwH2Cz?=
 =?us-ascii?Q?uGkpUcWsA+8G/u/kkdGLI+yrf6Qwiexh+/HmsbAcnlsK8pY8o/2uCALm1B6/?=
 =?us-ascii?Q?2P6sSegg86tkCORPDuqOEWs5+ggIZE5PDvUjNuORO8sYnqzy0tSXdpFVOjTC?=
 =?us-ascii?Q?txSXX0PxZtPBSEbZoY1KPyMcw1PftypEDVo8rzSK/P5jOaitcDd2nBmruHWY?=
 =?us-ascii?Q?c3BAlG0GNLBw+DkvVP2MSI/9xtAmHfxxZdp8hlN1w8DRTqPFxfXvdOzAUyU6?=
 =?us-ascii?Q?hAQBvmk5Ir2AX56Sy7vFGrAZwCyIf8kxOF6dp32k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Km0QrMp+M1z/O5Fn2zG+RNOLfs/vmC+K2KbjWBbqkYJ65dNdhoqw2B7ox3BpVDA4YXqyUaWECc5zNNU3aAVeida8HH890XqqYw6LxYhMaXGgr4U6Pg5V23ih5T9r53biQEjMyvIwHPFQ6tSRhmmN0AlD+b8+g3H4ohkNQ6foxHtoHIqO19pdM22ARl3VCshcYCl+DJX1DeK+BaVEqgice9D5tJRsgMQ987j9hVsKkGHC71QRDkQkMim5kqbaZ3KJoeco5l2sG+wYESmzn8xelCi4Zph5pNgm7ocQrgxDbHIAHTHbLau2yiwzkKGSTFvShEvy+ILWyhqdquXGeZxY4ufZrT0eNmdxi2FzAUmq/NUHqoWsxVBJM/+rRm9ACiR1E4UEoQACOPx1ALfa3X9x54jLAGA7zuGafQCMKkI90TGJZk37RUJ3Ycd2/eidMZQj/YNOokVDmoAVhUyUbpfYvsa+/DZeoUW0qm7LZZwnX6TG20WR0ncr09CtGvyUd6ceQJRXKPB0Cx2gU9XBzjLIcwyrEBFEElxWrbkTX6uMt5MlaNVROIskCWljWr4kUQCyc52rU0RXxKyRf9I81NjGYXEclzydTYsZGk4ZVOy4Wmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3772222-0861-4941-482a-08dcc5ff2dca
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:44:55.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOz2ugfOJFkBF4yKYmjeNd7FNDhKqWKBAmDO18alR738pOYel8uJX/wocCJAN8GpaDRmijNUaF1Q9NDRVnZong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_14,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260143
X-Proofpoint-GUID: lli0KbDF70-CY_zrNfUEo5Q0BTodcxYc
X-Proofpoint-ORIG-GUID: lli0KbDF70-CY_zrNfUEo5Q0BTodcxYc

Hi-

On Mon, Aug 26, 2024 at 06:26:52PM +0000, A K M Fazla Mehrab wrote:
> Replace fput() with sockfd_put() in handshake_nl_done_doit().

The patch description needs to explain why. Lacking any other
context, I assume this is a clean-up for consistency with other
sockfd_lookup() call sites and that no behavior change is expected.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> Signed-off-by: A K M Fazla Mehrab <a.mehrab@bytedance.com>
> ---
>  net/handshake/netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 89637e732866..7e46d130dce2 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c
> @@ -153,7 +153,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (!req) {
>  		err = -EBUSY;
>  		trace_handshake_cmd_done_err(net, req, sock->sk, err);
> -		fput(sock->file);
> +		sockfd_put(sock);
>  		return err;
>  	}
>  
> @@ -164,7 +164,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
>  		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
>  
>  	handshake_complete(req, status, info);
> -	fput(sock->file);
> +	sockfd_put(sock);
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 

-- 
Chuck Lever

