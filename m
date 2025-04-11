Return-Path: <netdev+bounces-181738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E53AA8652E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094481BC0D10
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2825949A;
	Fri, 11 Apr 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLgrqphy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I6QEAmfa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA825258CE7
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394541; cv=fail; b=Wb5ffGc2c2QcX3gV4NzVhFn99AqWylWqFsAGUopM77RG8x114GfZLAfnPRjB9HlwXrr8RLSTnHnClCxkBcSGgu0OkCchjj/YtaAhOOeAZp4VEIS7rvhh/J/O321UbHl741QyUhz/eLAUQtNj625OLtiJzwIhCUWmdRSVqzhb5uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394541; c=relaxed/simple;
	bh=veDuIDxqxe8JP92sBlYldNStqRRkV05SbT1VH6MOALU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fm8XPZh7j2SdOzAniI0c/pWp4fIYxUWdHFE4o7SsETvI1sl/cMl5Yjhx5XPN4fe8yNdXASbi7X24SI/pMOtlDFGxy5e/dvy3rxB5Ln6xO40iP4gHmPt2nTwJ2la327MmAo1oAIvDunV30+bBB6acWioWJa6Gdu/Np04CBDm9qII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lLgrqphy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I6QEAmfa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHl8mb012689
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vdONsqNxGvuNKs2OAm4DLL4V5pKrFrlA+iHoAORuG8U=; b=
	lLgrqphycqu1MErlUJiTDSHKVbbCLeVnWLIZ4hGxbzzRXGiFY73HaZbFTiMK9xEf
	ez3b9fGyOlWF8zWkjvdJX7+ZhZQ90RrTWDekSC/2K9GXX6asgRamRQQVJ10fuG99
	qy5pvwlEnFIwdCqsddB2NU4y+tttpk4Qqf39swah8dwS1kwjb4WcDeSoiUjHKvxK
	Ivdw2pNXo+IAUlsa7vE0ZJvn+KXjmdfmvcmMGQA5HcGAPdkJitOps2554CPtKPW9
	2VcZF8GHSN85EYI7bwME9YL6ZaxpGdu7k4/lT5o3zHX+m7T9nOW3AJWHfq2tH0IB
	ntKiP2AekU1p6j0C7AkRCA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7sfr0wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHQ3DS022469
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:17 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010007.outbound.protection.outlook.com [40.93.10.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyequb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMjL7xEeWERzNU3vU5JGjOzWDaOxlBS+cVwqyPKN9AJkMoAdUGtJEoUp/DjkbAqmf6dL2lE+4LX1pfCeRobi2dXMU7mV+d8VCOSjbyNqaegtn9aC3AlQq5BUigZDPfrswGKkgExU4g4Bd2BqT8po0NKWg5N8Yr4sjJYqvx7fxHDOClc1V5bSzOxNY1kJNztvWVhmrwpgD0mZR6Hw88+BjKbdD0+kKK5Tgt7k4gpoFX6B+ncRW3+Om1et0XRh/CCa1kiBL/fold7qF/cnN3VuIWg5WpTqAnRAjIswbMhppktPn47DdV3i8te2xBulfGqgq3Kr92CZmr4rmzWPRsuZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdONsqNxGvuNKs2OAm4DLL4V5pKrFrlA+iHoAORuG8U=;
 b=Vk8IQl2CzL26zxatx4VxAcliz8PdHUT6Wv4iuCMTu5nGhu4yTfSDzC1Ypn6ynu4/cRH4h4iEIxSsegQAvHZM5YggjjbEuPEtQJMLd3IcL/LL5RxmArGxQ1ijyC4kEHFUPv/I5qe38pP6METD2eh0witeBPWUSPNaTSr0tHf1hXb/uk3qEpe6GwlpC14Vr8cjL48/aH3RC345maw/AFJ3PgYSw6YQQwiZStLn2ioO70nrzDak+bDiLxgBjqV7DpEhivopKUlbzrilrBamYrTQtF6aHqDqi1IF0VWwkaWlMlBgw20IzzR6rmCaAzAdHayz1Nk2FrPhqk4iNVpMcbF/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdONsqNxGvuNKs2OAm4DLL4V5pKrFrlA+iHoAORuG8U=;
 b=I6QEAmfaRCJjgratkt3jhXANnYmUZP7+nSlrjoPeHwjUcAyEYcnS+k0q5a7Y2Fo1cIsXGoOdtG9Vt0BXy68oZR8v5+1h14HeGUwu8VJbRAZrSOj3cFwv5DzOOzVBJky9mxz0cWXUOvWN9wsOoYO9+INOIA9KSnbuyDuPapKACwI=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 18:02:14 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:14 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 3/8] net/rds: Re-factor queuing of shutdown work
Date: Fri, 11 Apr 2025 11:02:02 -0700
Message-ID: <20250411180207.450312-4-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 49514ace-30ae-4e2d-71f2-08dd7922fd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnRjWU1Ib3Jrb2orWjJVMWhOaDBjaGgxUkFqR20vU0JaSjFodXJOZFlMaXc2?=
 =?utf-8?B?ZWRYbUVJRmVqdkdSaUNBL0IvQkZtYitBSmtkMzRLSDdiR3IyM0lsU1Rka0Iz?=
 =?utf-8?B?TmFYK1BGeFowamVYckVrNlhwOFUweGx0TzI1cUc4UlJ2YmxNbUdVZUJtdUFE?=
 =?utf-8?B?aUdmRFhPNTFWUHMxRGFlQmg5TzFNUEVJTFg2QzlnWlRWOE1qZnhwRVlzQ1g3?=
 =?utf-8?B?T1IvMW9nd09sOEM5bFhFV0dqK251c3dMZ1lsMHVsRjNLL3hTYjVmTUxOcW9a?=
 =?utf-8?B?M29FdFBTbi9wVHNyUUpvVU5raG5pcUg2cW14Z3NTYjM5ZGRXK01LcVNHNDha?=
 =?utf-8?B?cFc0enlUOEtkUFVlSmxCbzlIOUlUUmRrVWpTVUxzQjFkd2pRcVlzYnVyRHJt?=
 =?utf-8?B?WFZ1bTB3YmQ2U2ROOHNwZFpSd2FFRWI5Y0RSdE5yUWdqbkxqd1AxU3pKc0x4?=
 =?utf-8?B?ZjhKTmE2dnFrK0FENVJFMTNSL0Z5YytBdlhoSHEzY0l4TW55TmtDemh3VUhv?=
 =?utf-8?B?SVozUmUybjlBUzgwUEwvcFR2Y1ZEVTgydDFnS3hsdTVOeCthNklTeXZzQWEr?=
 =?utf-8?B?R0ZiZ1FqTkJvekc3WG1NQlBxTUlyYmUzZzJ1ZmRRcW5jSGpKSEJuMVZlZS9X?=
 =?utf-8?B?Wm00aG1GdHV5YU1BcXVTMXQ5OWVjbGZOdEZnbDhtTGN3WHBXdWVQV3JKQms1?=
 =?utf-8?B?YWVhOXFoYzdPQ01GUXJ5VndUY2NHMFBKWTRKVGhQdExDQ1FZODNIRXB5OEdr?=
 =?utf-8?B?SzJVZXpGalNUNjZKb2VEd2RFYzZ3cFdKelZSNE92SW5nQTZVMy8xZXNuaURw?=
 =?utf-8?B?Qkl5NElaclo0RkQ2UGpBZ3RJVHBpOGpKTlY3Slg1VWdHVFFqYzd1dnczTkh3?=
 =?utf-8?B?N2JFMFVDd1hRUDF1T3RlRTltNEVxNzkrcmthYnpESG84UDdIQm1Ndm4vZmYy?=
 =?utf-8?B?aS9OdTJHMmMzM25rUEw4aVdGNjl4VzNTUUFVYmlUOCtiUTNEYnNGQllkRkt2?=
 =?utf-8?B?ZXI3VkprcVVEdzJ3WnVYWnFBVGVrNUV3YkI0ODE2Y3VTbENwclViV0FLN3VY?=
 =?utf-8?B?WlBJeU9VY0NZL3o3aFQ2c3d2d1puVWR0UWxoZXBTYnY3UUFOU1JwMFNQNVFh?=
 =?utf-8?B?YVNtWTZubjJqOGxEaS95ZytUNW84Q09KWnhuQi8vU29ZU0JybURJN28yVzNu?=
 =?utf-8?B?MGVIQmhxRDZ0cVdtZk5GdnhTSlFMN1k0U0JFRTdwQjNJZ21KRGxuMHJQTjRV?=
 =?utf-8?B?bjFHS2VsQWI4K1JaQXdpMFVacGh6aFVZNDkyQkFTMm54YlRCTnZMY1FXbmV3?=
 =?utf-8?B?ekE5N1RmVzYrbEJGd0FqTUVmRDd4K1JnSkFCSGFpdWlYWXJSNEIxSmFjREw1?=
 =?utf-8?B?d0phWnRuTGFLZk40QktrWnlTWWZ5MTdhcDJMSFV1WUpZWXEwSHJzWXVIWDFL?=
 =?utf-8?B?UG1lemNpYkZITjRmaDRoZ0VtcUU3Y0JJWjI1eXI5cjFqcWhnMU1UNG4vR1ZS?=
 =?utf-8?B?V1FUenhJWVllZ3FTWmJBOVZmYWFzRzBWdWZuZHpnYThia01NVXJtRmZMUFhD?=
 =?utf-8?B?bXNKUGZJcElyS3BYUnZvenk5eUo5a0xlNjV2QnZOUkpCbktuSkZ4cEh1NDZh?=
 =?utf-8?B?MGgyaVdwZk54cngwYjU0QkQyL0tsRGRLeTZQSVJHenNHOEdPT3FVL3Fya0VS?=
 =?utf-8?B?YVRwTnJtbHBTbFpqVHhNRnRpcnFad0draTdOR202ellYTjVyT3Y0YXJqOFht?=
 =?utf-8?B?dmx5TFVOMEhjaExKMGNFdElDeW1DTFRDcjJxMWMrOHBRb0xYencyZW5hSGUw?=
 =?utf-8?B?L0I1UzlHUzNGRndtbU9ScUFpSVBJUmRUdGU3MXhwU28zV2dxRFYwMU1seEVW?=
 =?utf-8?B?TUdFNmEvUXRuaGNSMWo2eUtXYkRkd1hWQVVhUkYvYXltUEFsbGhGWS9xSmhv?=
 =?utf-8?Q?UccBiQdl4VI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LytnWlZMRzFPa285S1ZvaXZkTUwwWkk2cDE5alBPT0VaMlVpYzNRTGdJQjhN?=
 =?utf-8?B?MWk5YTg5YWErSVBPclB6aUdJTy9VMEZoTXJiTS9ESVZ1SkNJd0pYS3NrRTFp?=
 =?utf-8?B?dDVOYzdOTUJHVHc0MWtkNHpZWmcxUFB1aTBOOU9VNmxrNWw4c0lyR1NVbDZR?=
 =?utf-8?B?dmFibm9nQW0ySFhORGxFUjVzakR0SWVYVGZHOWZtTytqczlCZFB3MFczbk1E?=
 =?utf-8?B?L0M3dU10dnRoS05INlQ0RG14MElqV2tyZjZOOHl1dUFTdFc2K3MwbE1PTlNY?=
 =?utf-8?B?NUlmQ3lVVnZYQS9nb1o4cFphcVRXVldCc0tpSE4yUkNOTVVFaHZZV3BHRUlY?=
 =?utf-8?B?Zk9XME1HVmRQSlc0U3lURkxHYk9FMHdyTkI5QjFzVWh2QXVvdWJtSDNiajVx?=
 =?utf-8?B?MlpRT0RyK0g2YU1QWGtPZUg0U2pJcUtTbEpRc3hSMnpMTkVOQnJHTkRaQ1lz?=
 =?utf-8?B?K0d1cm5TZ2ZZMWdjbjFXV1pJK1VxYm1MaExvQ0s4U3JJTjR0OE41NVhYL3da?=
 =?utf-8?B?RnpsanJNdnNTZHlXYUZROVBMZGlRU3F3U21EOFB5OEFqeHY3L0IxVGFEUk16?=
 =?utf-8?B?Vnc0QWIxNGxuL1Y4VVhoeHJOdkRYM2xGY2grVTdhL2FDTDJtcUlvdVhFM3hx?=
 =?utf-8?B?NmZCcFA0T3RLZkQ4YVE0UzhSZDBIdlZJNys3eUE0Qk1mZFhhRlpRT0ROdWts?=
 =?utf-8?B?UGtENVRHUHc0RmpXNzIrMnlvM3p6SWN1aWxoUmNUK3g0aFprcHM3MEZ5WEE2?=
 =?utf-8?B?bTEzeTJyRk5aMDMydWljUUhDOEdncnBGVkxMbmNsMk9yQldsV2QrK2xmRURR?=
 =?utf-8?B?WWp6a0o3VXp0a0xkRUlzSHByVTBwWWorUUZKTHpmRXVxa3FDSTJEb21hQ2ZP?=
 =?utf-8?B?R3BRR2puNVljUFRDajY2Z2g5VkhYNCtHVFhhOG42cWp2dmxrRHh3VDNsbHov?=
 =?utf-8?B?b2pnQ2FKY0JrdTJoc0pOTUlMV1Z4UUE2SmlxZ2hCaFhTUGFCTFBxVnNsbUpY?=
 =?utf-8?B?Sm9MYWJYTjZoekFtZWNXNHJCVktGR05nN0J0bXFQS1JqbGlmL3A0QmhFN29u?=
 =?utf-8?B?OTJud0dGZkIxOURHWS9OMnpXekxqSTZiOWpyMHFnMlNYR1pjbFRHWWI0WFlU?=
 =?utf-8?B?ckNoWG5aZHVRcWlmYUx4QkttbzVmbmFlcy9OR3JsdFc5VHRHUUpCTmlhaWVa?=
 =?utf-8?B?YlhZeFV0YitKY0J0eFVwVHJPam0vbk01eEJpQzE4em1MalRySmJFcDl4NUh1?=
 =?utf-8?B?RnovaHIxak03b29CVnNnMU1WZTZ0Z0RycksyWm9EVTJGVFpBOUQwL1ZzYkJP?=
 =?utf-8?B?dFUvM3dSOVd5aGNpWmtRM08reitIWmthbXk0TTg3cEZPbDdIUm9ycTlIL24r?=
 =?utf-8?B?NnBrcHgxUUZBRmR4YzVkTkNMb0lTalZ3dHovL1k2eWdZc1R0VDEzRm54SGhR?=
 =?utf-8?B?WlpmUmRxQ3NtYVdvbnNWb3U1MGJpUmpVbHlaK3UybzB6bGp6YWJnV0prOXo0?=
 =?utf-8?B?QUplelVpblNqbjh1d080Mk9CWmpJZThIQkZocnJyd0lOd0k1c1Y0SStTK2tw?=
 =?utf-8?B?WnYvTFROeHVDQnpJcitBdGZRdDdpMDd0WXgxclJ3NHJsbm0reGQ5RlY2RUFY?=
 =?utf-8?B?NHVQbGFoVkRKTUMveGVmUGVLSkZyUzJoZEw4QUY3b1BYTUpMS2UwZnVuOHlK?=
 =?utf-8?B?QnNwcUJjb2xkREpoNVBjR0FXK2ZwRFc0ZENYNm9tT01sRDU1NlkycE1YYUVL?=
 =?utf-8?B?YlkwOGZzd0thdE4rY09hSk5xVXdiTXJrZmRGUnB0VjI0RTU1TEtiVW9KV0Vz?=
 =?utf-8?B?M1RSc0JpcUY3REhWZ0F0U0s4TUxiMTRjZDNFcmRYUVJqYUFBTC8vUGpZK2h1?=
 =?utf-8?B?VHlaakRxdGZzSkt3R2txc2plS2ZZUmVXSU5rMGlkNW4rbXJNWjM1K2xVMzYr?=
 =?utf-8?B?cHZpY3B2SHVON21Ua1ZQZG5pdlpPeWtSeDRnTjRoS0F6QmNqd3AyV2hpSFE5?=
 =?utf-8?B?bDA5MnpMY3d1c3ZLZFFtNjNVRCttSFdYcHY1NTl1SCtEWlN1ck5wejhmaFNm?=
 =?utf-8?B?czRVRlBwRGNueSszL3ZUMEhqbDNYRjRZUS9nZVJ0ZCsvZldIK29Va0pJRDhn?=
 =?utf-8?B?R0dxYXJReWNiZ0owOTFMd3g0YjE1QXNUWWdqTzBhcUUxcDlFRi95VFplaUFw?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fqZ9IxX+Kzn2tguKXsn6gVNqcGqoO9q1hesa9pHiv+iTvzkfxxsYWNEeEg57XQuWPM6KOLRg11T+27HRdUFGx+Cwh/SR3clOm3oXrxqf1Jpqv0TEzdaJRTSdXhDnB68hPQObVAWemRAkNfSmxtQ3sPPwwy10FUXodhGhklRPzX78kgnRmQap04cGpgLeU1la0WBVGsxnFsjduBk6vjUs50MfWD77OEKSrjmrXZeZ/bWPvW0rybPbtJWky8k8Za2waGewjxXgMQTKYDN8oM57gslmFYQb+6Ryv82lEtc1nVi4mn+pwMfFnLDUQxNPRN01uC6ejGxVmoATxcXC3hGrdr5V4bjcqtzDebD/INGho3Y9A28VOYz+W1R52q7A/MX+GGvExxMk8OVQ3LJq6cEquMxXuEXUZxwLJuu5FVFUPC6pEmpgD2p28Yyuwn5dZqM1nPzrgXBOKkCjI8LFGqhkoZtEn56QoBp4+WqFKhidSJObgQ8FMJ3/r3y7HtEmju5XHNntuwfPNDExBEhxF9jjhv5aLdQuS4VnOgrvXJdZhMdKTprUOfyJ15M7XQyQgomAm3jn9snJvZoAJap+mvvE0Bqis/m/qCZfvz03gKqJ/Es=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49514ace-30ae-4e2d-71f2-08dd7922fd85
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:14.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRBDZxDkwPS2SYk9fIyMgTPrMQFGzqaUGPzmF7sSmM/1/U+yG1ECCEy4K/zirT+l5LZXni0ENbnk9m4HTYDFmEQTyv8ogHxrrU0YsB/+ep0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110114
X-Proofpoint-ORIG-GUID: bys7TW4ttR5hjbEAf1dc9epL0oElmPjx
X-Proofpoint-GUID: bys7TW4ttR5hjbEAf1dc9epL0oElmPjx

From: Håkon Bugge <haakon.bugge@oracle.com>

When RDS receives an RDMA_CM_EVENT_ESTABLISHED in close proximity in
time with a reconnect timeout, shutdown worker may be queued twice.

The reconnect timeout calls rds_conn_path_drop() which sets the
connection state to RDS_CONN_ERROR, before rds_connect_path_complete()
is able to set it to RDS_CONN_UP.

Fixed by conditionally queue the shutdown worker.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 5 +++--
 net/rds/rds.h        | 1 +
 net/rds/threads.c    | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index f7f48abf7233..17fd7f34ebbd 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -693,7 +693,6 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(rds_for_each_conn_info);
-
 static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 				    struct rds_info_iterator *iter,
 				    struct rds_info_lengths *lens,
@@ -892,7 +891,9 @@ void rds_conn_path_drop(struct rds_conn_path *cp, bool destroy)
 		rcu_read_unlock();
 		return;
 	}
-	queue_work(cp->cp_wq, &cp->cp_down_w);
+	if (!test_and_set_bit(RDS_SHUTDOWN_WORK_QUEUED, &cp->cp_flags))
+		queue_work(cp->cp_wq, &cp->cp_down_w);
+
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(rds_conn_path_drop);
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 71a0020fe41d..d8d3abb2d5a6 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -93,6 +93,7 @@ enum {
 #define RDS_IN_XMIT		2
 #define RDS_RECV_REFILL		3
 #define	RDS_DESTROY_PENDING	4
+#define RDS_SHUTDOWN_WORK_QUEUED 7
 
 /* Max number of multipaths per RDS connection. Must be a power of 2 */
 #define	RDS_MPATH_WORKERS	8
diff --git a/net/rds/threads.c b/net/rds/threads.c
index f713c6d9cd32..915e57b06d73 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -250,6 +250,7 @@ void rds_shutdown_worker(struct work_struct *work)
 						cp_down_w);
 
 	rds_conn_shutdown(cp);
+	clear_bit(RDS_SHUTDOWN_WORK_QUEUED, &cp->cp_flags);
 }
 
 void rds_threads_exit(void)
-- 
2.43.0


