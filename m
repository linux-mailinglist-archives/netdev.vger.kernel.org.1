Return-Path: <netdev+bounces-185954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41462A9C4E3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB364C0BCE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709C22F751;
	Fri, 25 Apr 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XezxIp4a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cAOc1Lt6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89D22DFF3;
	Fri, 25 Apr 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575955; cv=fail; b=GKMPc+/gWxuRdJMS6rG+OTwOu/8Kh2TtNj7F/MAgY1XImX2uVkaWHbPtT+Y0/ZKpTb2da79Ehs1SQ8bDLoJKHFulQ9UrQf2fRy0LQfky0+dPn3wsrFoCJqpPHBIPI83fXjrKu/NBbxh/S9+jseSx0ihXfhbnDCQNxxB3SfDkkQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575955; c=relaxed/simple;
	bh=EYJ3Z8lw0eKNYCUKzhtwyM0jDf6jJX/CRA2PxvimfrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ti+S0ZTtHaCi9CzpVRIBF6I2z9AXmLySVBQ0n/hKlnN2VqOqI8bVhHhVoCR91XPjAjKJ4KhG5QHusg83smDcWKbPQd+437rKr0Nwz6q+/cs7RCKLc+3TnaQ9VAmJLA+1hNhMOXkZQR7CmP5KiaxwUBLc6j1l04CVR3sm1nMVGj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XezxIp4a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cAOc1Lt6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA8FCH012959;
	Fri, 25 Apr 2025 10:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W4fTXbl9UBQAyDeQ8bXYXrxn0DcGPnf8Y+TGm5pVbJ4=; b=
	XezxIp4aDarOsgzfE4PdTD8gAmhQtmDU5HkruflrK/7u01xhKSY9TsRttyJ/UWoD
	OWfwCi7zgqx+cHY87olLdW7uv1ZmZkacgt2O0h5f2lvw8m2uiMlwjalV0VdzRCYr
	hih/mdw7ndTvxd11AgBUYKrsoH1eKy/GcKsDGvwoZtQcV6kDTyy6hpfQvdgy6mA9
	8zJvTicl7DtnO6p82qZwwSDvXrym54/u1TBws8FJdQP5sLF0UnaOl0ouVFxIv5vo
	7Jv88blTDZP+jxdT5kinsDavOJkUT4DnQJ39LFTbvlsWmYrSJ8WdI6vs9T9by7nz
	V4BZCOxqFoOHpkLx3pj+Jw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4688bv006v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:12:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9Ee7b018080;
	Fri, 25 Apr 2025 10:12:11 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvhpb9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phjK81P+D2CMUPdXIpIROE9nEUDCfSHEpBa7jgCU/davctB0Rpw1DxdfYyavnU/kFvyz2A37H0ozp7xgX5t09433JHSUKzp8STJpjyvG7CDFqNi9txSBz6GWM+5CftcFPwwAIQFyW1oo4NfP8cKZsKv1Y+a1q2m+dvuS2ICD9U8SMSrsTX0Hg3dwVT0sOkBy8K+SPMo+txrOXytt+b1PoAPz2BGJFGU9LfaGXyrSKDE82GNf8nZxjCHqQVo72riIs0e+uzssYixDoNBKuxIgE5tYuaGpGxykcQubMpmns6HtrqwnUvrqt9yQEYPRKU2XUOs6vid9YdQGFYTYwlw4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4fTXbl9UBQAyDeQ8bXYXrxn0DcGPnf8Y+TGm5pVbJ4=;
 b=wcIGBMBETVVe9ijnxhvTB6IZY378Wn4d2VtCRl0wGn9Dzx2EqDLhqAQ4+GRoXj6dsG9/rxM2rMLTIeTx7IsFFhZ/dvtURBeOsNxdYSPFKg7Q+DAy3pmx20XMEq4aycdxG+iWlF8JX6dWeHtAH/DC8HcBu6yCL9BqIaypdqq+2BGXooBoOohpvERrVLv4Gyz3gSZxj3gtjTnWgS73A3UF0y/1fUVf5IY38Vr7fx/pVq0Yk8oURwfBMn7UUr8He+3SQ2WyrMdsLaLChq2prrMVAuFw0NHZVcsMGYwDjObyF8pDm169GQCfUaBAGnSw7TH3uVYON2ZXBxP8jLD5LYezWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4fTXbl9UBQAyDeQ8bXYXrxn0DcGPnf8Y+TGm5pVbJ4=;
 b=cAOc1Lt6KKN2XE32KPuypLvIVOiuV8ZMpGaEi0/u6faJkHL+WqsAJGo5F4lejCIdkZWdvhnrNwvPeEFBadOZ5+IK+72oqNOcQvhMGOhB7/6BWoh0qyySEMyajVqaAGZrxS+5TUbK0yr1WN2alUBEevzU6fukh67u7pPrH/9YDZU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 10:12:09 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:12:09 +0000
Date: Fri, 25 Apr 2025 19:12:02 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <aAtf8t4lNG2DhWMy@harry>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
X-ClientProxiedBy: SE2P216CA0023.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: cc80b1f6-19da-41fa-3b87-08dd83e1a36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1maVgxWkFoODNOMEI4dUY5MkxDUXdWRk8vNWdTZzF3REpTOTBobzh2U09K?=
 =?utf-8?B?dG8wemxZMXkwaVh0Vi9LVTJKQ3pyWmU1a2xsb2orU01vdUp2c2IwWCtKaEdw?=
 =?utf-8?B?emVuM1JJdm5ZMlFQUzBCeTY0c09kanZaMlFjcTl0UEwvRWRsS2YwVWNoL0pB?=
 =?utf-8?B?MTNvbHFtTkc2a2xuZ051MGhKVXpUQ1BzZEFxTWkwL2g5Y0tYTS9HaHY2bVdz?=
 =?utf-8?B?Qnk1S2NCZlN6Z0hSM0hXZFNyUE5LLzZKL0c0L09qbldMdVZ5cFFoemRhWmFR?=
 =?utf-8?B?Z2x4QXpQVHJIbXc1M3hHMnZaWnExcVRmbEw0bGhrRFA0MGNHTGp0SzNqTWFn?=
 =?utf-8?B?SlAranhaWi9xSWNvK2NOc0ZqTThkYzcxUWd0cXhRVUlxUXBZNERRUldHSVdt?=
 =?utf-8?B?MU5QUVQvdlFEMXVPbFpWaDRkaXlHTE9VZkxBcGRycWN2SkNXNnlzMVZmU0Jm?=
 =?utf-8?B?MXIzUHJkVENZTXUxUVo2R0xrMmxhb0lsTWU3Z3kvUEFHaFl5TWN6QUtmZTQy?=
 =?utf-8?B?RlROUVVrR1UyNXpPNW5HZ0pDcHpqbTRQejg4eXpwOVF2eWZGRURZMHc1SFlZ?=
 =?utf-8?B?bTVKVm50RWtodFVRZGpMQ3A1dTlJdjlnZjd5N21lN2FLNFROb3Mrb0ZrMXMw?=
 =?utf-8?B?T085UUpXYWxXLzM1TE9rRC9QbmF1Vk84NTU3RkhDYjlEQzlEd25zclVFR2wr?=
 =?utf-8?B?QWtad3UwSCthS2w3elFYeitCTmxueTVjSWpJb2g4NUNkMUZKVUtmbEtGQ2VN?=
 =?utf-8?B?NW9HN1B4MEMyckpDRUFLeC9rdTlGa2J4U2tPaldLS2J1dnRZUEk1TldaWENa?=
 =?utf-8?B?ajdJM1MwZlZXSmczR1g1eVFNRVhNVHJwSmFJTXBlOEFnRk5MWDA5RE84aXRP?=
 =?utf-8?B?amxaaVBFd0I0Uk5zYWJCRVpYc2MyZHo2OVhubUVFekZlem42ZjZOUHFDVG02?=
 =?utf-8?B?QlV5VEZINE52RWs4ZEFzcHhveHJsdUZlOFlTMjNPcjMrcEpESXlCN2FqTlRn?=
 =?utf-8?B?YytEdDd0endvd0FEaEd2WDMzeVUxYmZYSGNheEx6WXY0eXJZd05zRFpMUEIv?=
 =?utf-8?B?Y3NxNVFIQ3hyVDZJMnJ2STNOYzQyY1cvRHVhcUdZRHRVaDFodlFLZFl0RUl6?=
 =?utf-8?B?dkt0Q0RIQUQ5ZVR1ZlNTQUZjNW1xRUt0VXo0VGw3dGY1aGVUb0xyaE55Q0VH?=
 =?utf-8?B?aSttUjhwU1lMRFZCdGhPUmdYdXM3N2pWajFyK05oc0tuQVI0UlR1bCszanhn?=
 =?utf-8?B?ZkNyREdIU1QzZnFkODhFYVZQK2tiWWFraDNRUXUvMnZuTWtyQUVmMVlEMjZS?=
 =?utf-8?B?Nm1YWUlDN2JoRDNUamw3VEkyNTRZWU1LL1RQWktULzJQMldXTHpSajNwZG1n?=
 =?utf-8?B?OXljTVMxWG5qSnkyNVVEOTdZbEYvdTFPYnI2VzZlZ2ZDeXZQQ1k4TG40WGt2?=
 =?utf-8?B?ZXIzY0pZQTRKeHUrMTF1NmlqaEZTaWNqQ1ZhaXlKZXdUd0FCUStSTnpGK01y?=
 =?utf-8?B?U09PeVYvMHJYdzUxdCtUYzVYcDBqNTd2MkZ6TStxRXhQRjdLbTVRTUV3ejBU?=
 =?utf-8?B?OGxiQUxTeEVmVmVPZHZYNGpiRk5xWEwydVZhRGZQWWR6R1BTVFN1TU53R0FW?=
 =?utf-8?B?d0lUcEg2ZkZFRWJFRmprYWI0cXA0b0ozWUFXdGh5YjFuYXN4eGVJWFlxVjRZ?=
 =?utf-8?B?VzgyeksyTlI2T0E0LzRTQ2tBTW1NamN4cTJpRTJ0L2JGRlRDWTZ1d044L2kx?=
 =?utf-8?B?TThBTnc4cUVySUZXenRneTVMZ0VzVVFUeisvZHVFTU9XNmE2eW1iakFET3lJ?=
 =?utf-8?B?ZEFLRkkxWTF6bWtkc3hMbW5RWEY4WVNuTVQrUG9SbWNCcThLR0N1NkZ5SDBq?=
 =?utf-8?B?MjYxclcwWUhmOWlua0F1azlqQ05zTlJWOXVJdVZFZVA2VUNhYXo0YWxjNytt?=
 =?utf-8?Q?g38bhHyQe4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGlpSWwwYW5OUDJtVUczb2IremJPeCsrT2NkT2FvWjlqd2Q4Z3FLYkF6R3JK?=
 =?utf-8?B?Y0htTTRzWDhOTnZjZS9VQXZLVnFOTm5xRHM5bWVUSUliNGlxRlowazdoMFVm?=
 =?utf-8?B?ZnRRTHJsb1ZVZkpQUnBkQjdIcE1XMUhtZXlET2hORDBmUk1SWTkvcW5EYUw5?=
 =?utf-8?B?K1VOMWcvc1BkOWFKeVAvT29NV3VFZUVBSzQ2eUtHY0F1NzZNS2FFTDRzOTZU?=
 =?utf-8?B?MkVwWHBCMjBiZGc1Ty9wdHFMelRpNWZUTE5iMXBoUmFld01nY2hKWUZ4UkJL?=
 =?utf-8?B?ZnNUSTErd3ZEVkpNNmQrUXVFNFZsSU80dG85WnZtWmliYUhvSVd0ZXp6N3F3?=
 =?utf-8?B?YjEvcENraUI3b0JBcU1zeGl0MEl6NXpCTVRzUnRDVXJlS2RMNzRlWlU2THFJ?=
 =?utf-8?B?dFQ3VTQ0VWVBVm5qRktuQ29YNnErNFRMTGFZVHBKbEthZmRpOHNBRDloUUhC?=
 =?utf-8?B?aG1hQzZhVzhYKzZlVFpETDNFek5MRHZnbzJVRFhvbE5zYmE1Q1pOU0FwY3BD?=
 =?utf-8?B?NjRaaFVaR0I4VEpYWG80QjVWNVlvdjZjVGN2SVpkRkRheW52NnpXZ1JoOWpO?=
 =?utf-8?B?NWNBNDNOeGh5ejdqdEhIZWg3OWNqQmpWTCtUdlVucXZQTHVRTW1XWmlxT2JP?=
 =?utf-8?B?bmE5T0I0VlYyTENncXR2Z1hIRFA2NHRTVHhLTk1wd1FLVFM0RVNzRHEvMWU0?=
 =?utf-8?B?Y0NwQ1F1WENyTDVJVWNONVJzNEpTZ1JMUWp6a2RJTjdBMk8vdWNDTlEzTXNS?=
 =?utf-8?B?YWx3UUFaOEM0UEw0MVpxQW81NnA2SXVrakcvNVh4T09DeE9sNjJ3M0FKZFpj?=
 =?utf-8?B?dWtXN2J1V1pwdDZyMnBBWEdaVXJ4UW83d1RrL29hTU1QOENiM1JFcEo2ejFp?=
 =?utf-8?B?U3d3aWk4Yi8vMThLMkd4SW1tYm1OZ0RueSt3Z1VsREhTQWNCeFAzZWNaUXRL?=
 =?utf-8?B?R3ZJOHY3Q3VoRmdFMW5nbXM1bkNKTzdwTnNUUEFLWTJJcXA2RDJsV0gwVkdP?=
 =?utf-8?B?V1NrVTdJeWdGQkVpMUsrVG5wQVp1RDBwY0xnV2U0MVlja2hiYnFTWmZiU3ZH?=
 =?utf-8?B?TlBqUHpoU2xDcGlQVDZxV2l3UDZmWGJZQ0hTY243bVh6cnNMMVZURjdkV3JD?=
 =?utf-8?B?MWw5RG9xUUNNRGpCN0daaklFUk1EUmhKVlp5RFFXSHRaYWVtT0F1RVRkS00z?=
 =?utf-8?B?cFhudDUyOXAvOXp0bGgwS2NWSjF6WklkZFVxRGRIZW52ck9IeGh2c2lYMzd0?=
 =?utf-8?B?LzE2M1dZWGowQUREQ2VlaHpHL3NFZkpzSDh3dDFVZmh3SWdJQ05KUEpibzJy?=
 =?utf-8?B?Y3h1dEFkZUJ5bEtrY2Yxb1JWUnRxTHdFRHlNQXhISXROcXlEaVNtNzhsYlpt?=
 =?utf-8?B?SjMrL2Z1dkdZQWkxMllTdG10Qm9NTGlLTnVNcVpULzFxOENQcHNIbFpHZU0v?=
 =?utf-8?B?ZG83Njk3V20zUlJQa2tHUzFTZ3lteHJmek50WnhNRmV1N1cyeVJzNWFtVkp0?=
 =?utf-8?B?TTB0SHhoZENaeHBXbWFyWm5lU21VZzdRYTZCUHRKOGVkWmZBTDRKU1ZRbGJU?=
 =?utf-8?B?QmpCWkpjbUJjSklEbjBaSldxemFsak1reXh4bWdSa1hOcmRFUk5UVU5xaTlF?=
 =?utf-8?B?Z3JqaW1lRlBOUnJHa1k5UWtXRmZuOEJhQ2dKczFTN2E1ZE5oRkRMdnVVR1dY?=
 =?utf-8?B?N255MmdjZTNidDA2OGZkYVdUdFVoemJwMml0aDRGZGE1YzYrZ3JkM3VXUVVj?=
 =?utf-8?B?R0ZzWHlVTno4S2pXMHpYTFN6YWc3MVBjRFpNTU5JWVc2cEh6dmlmZzFqbUxQ?=
 =?utf-8?B?Vkt0elA5Z2lhdVpGQW95VmxSOG5NTWdyeHRlWnQxSlVnZysrS2JWNTdvalJ1?=
 =?utf-8?B?d2MxYXdlZ2tKMEhiRWU3Vi9zMlBYdzAyQjNncHgrRzFiT0lXNUpTVThqTWth?=
 =?utf-8?B?cFE0WXlvQXRKc0NBR1BTbjl4TVFGbU1LWGlOM2pVaFljdDRrV245QThGWnNB?=
 =?utf-8?B?T1h3WUxEWkJKVG5OZDY4SkhRL0dpKytrVXAwSlRaQkdWK1N5bEFEMzVoaGRG?=
 =?utf-8?B?Ymd2ZHlxZmNWaWlIYmtGWE5QWGtsV3pCWDcvMlBWVnRBUDYvUmd1Sm9zSFF2?=
 =?utf-8?Q?xgxE1FQgCFV0efoET8LXXDNTr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6pYwf8nS5gjg/+5CSYqprZoO5FuhRepFwt9ggN6LB/LAz2shnZXW5nnf+Pl5MHVgpCJVQLyi6Km+XeYHHWt70g5jZCL5TWb28CQRCmBlFvVTFKbiAYgNb/etnxXZ5jjkdRVOfy3UkPrFJI3WJgcjR0olpHlQjhWno3fUrPmnX2EaEoUQtUjbjDHW8d84eymzeheJ2S9zJc77I+8igFmN+xas7j1xZE9riW74iGqmD7ETGD+9+ve3RN6RxMzW32OWk2uzvNZ3B1I3nhUaMWroWy2j9iLC1XcO1gFxZiK5wejsXJn72M4q+TKLzevdS5o7xircqa1v0WRZk5Dl2JxqULpY2e31y6iVvUNt/LxJ+meyekrGIAGogwzlbvDyPnetZ4Pb45K836HDU0LZaucwnFHCm+XW7OCk1+BbLQV0FLs9mpcojPtEwMQ4QZKFICeH3EcxQnN6wKXsPSQTgmVoJahR4gK714Od4fcKQnznJNpXOhcU3itjqPSSbaGE/GLyV4ytCy7o37b9LcHBxj6Vh47/TZpxq9hb3wAMm1pdhi/MkUBSL7UwhTbs7G3MYhLjEVJX9wEKGWDi7skVWqKRTfLcvWmGe7a278DPU8RBgAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc80b1f6-19da-41fa-3b87-08dd83e1a36e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:12:09.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAW0vkNvB7t6GSLp7Aq6NKlsXRoLE3zUtuDjH/1CRShd1Gyb3uZqRb9gHB+naGqQQwKhiTGgL8jwcnsoL72AOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250073
X-Proofpoint-GUID: fDVeoUbfZmHDEwQedPK35O-Zxwj0L0T-
X-Proofpoint-ORIG-GUID: fDVeoUbfZmHDEwQedPK35O-Zxwj0L0T-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NCBTYWx0ZWRfXx96kf/6d2rFh ANCsC7ehsR02BrILOUBKFbN5ftRXL6aT0DsVV6i9FLPbfloY7+KE4+q0+F6BJ6XWcdkEbptgqZN jqfbkfOXwDniWw1Pzhe58zKcNLKBcqlyQCPlPnI+cTinquqyBEZQRFWdM6Te8YKeM5ebhmeZ3VT
 NrEF6dTB6SXbuHr713mLKeTMc28I0ETssh/MwgqCXRhTq8QEuhvQ2lyu2U9V5z3k4JVTAQ+OOCW Z4wG1q+P9FVyZ4AlfHfle6kZShrO5N9qnlv6JsPr2ReBmYX2VAyiYsHJudyrSXQJAJGiWQZdt7t QBR/4MUijnpnBlYq5EYV3wRxDG6/OZUPlzJ8l2n2NOnFxVxZAAPL9eL6ji/cu8EPeXhREKEe+hv e4WSGXtY

On Thu, Apr 24, 2025 at 12:28:37PM +0100, Pedro Falcato wrote:
> On Thu, Apr 24, 2025 at 05:07:48PM +0900, Harry Yoo wrote:
> > Overview
> > ========
> > 
> > The slab destructor feature existed in early days of slab allocator(s).
> > It was removed by the commit c59def9f222d ("Slab allocators: Drop support
> > for destructors") in 2007 due to lack of serious use cases at that time.
> > 
> > Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> > constructor/destructor pair to mitigate the global serialization point
> > (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> > percpu memory during its lifetime.
> > 
> > Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> > so each allocate–free cycle requires two expensive acquire/release on
> > that mutex.
> > 
> > We can mitigate this contention by retaining the percpu regions after
> > the object is freed and releasing them only when the backing slab pages
> > are freed.
> > 
> > How to do this with slab constructors and destructors: the constructor
> > allocates percpu memory, and the destructor frees it when the slab pages
> > are reclaimed; this slightly alters the constructor’s semantics,
> > as it can now fail.
> > 
> 
> I really really really really don't like this. We're opening a pandora's box
> of locking issues for slab deadlocks and other subtle issues. IMO the best
> solution there would be, what, failing dtors? which says a lot about the whole
> situation...
> 
> Case in point:

<...snip...>

> Then there are obviously other problems like: whatever you're calling must
> not ever require the slab allocator (directly or indirectly) and must not
> do direct reclaim (ever!), at the risk of a deadlock. The pcpu allocator
> is a no-go (AIUI!) already because of such issues.

Could you please elaborate more on this?

-- 
Cheers,
Harry / Hyeonggon

