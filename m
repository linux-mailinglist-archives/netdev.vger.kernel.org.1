Return-Path: <netdev+bounces-185429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A15A9A554
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82791B82C07
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60571FCCF7;
	Thu, 24 Apr 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I+QKQGUw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z2sHzrU8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4D1F6667;
	Thu, 24 Apr 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482139; cv=fail; b=ANYbwFIs8THiV/LsSHT2Si/noqlaJZYm7gza0YzgMOhJPxNv0C7RfdJG8swkbFhcCHsnRYbVm7adjtnvVBObC2GizxHmJuEF0DXC3HsSM3sZk35kh5NyCbkkBNkbZicYEY1Tfiv06Wra4nA8LJE7/hjiZjKGcOnaHxP3VocCE9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482139; c=relaxed/simple;
	bh=lRGgiGyJ4vam8UCkGj+SfF6y2mEQVN0+yPhRUHgIFkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MioVw5SB4oTVB7WxA7ufzVzqfuL1U0QWAxtdNvQMuewdIqUp9Q0sfA7qMSymShG4Pu83j3HS7rZFcHq3JKJQgJhkpmalAtJ/vS626kVZSAZtSHygg7ExbpzttAVPgnmmAYjqFACdTj4Z7ee0FqlG5nqtTVaHPiSqALaUMRsm2jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I+QKQGUw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z2sHzrU8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O84swB003302;
	Thu, 24 Apr 2025 08:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YUgNxv4cL/9Dxkiza7/asrzAre485Wsa4U55tpifUuU=; b=
	I+QKQGUwfbRL8szae7SkcSmHOGB6hPumojq4QA9OhQ7jEbOlIoF2V2mUvrrz5qTf
	uIFPk5x/dB8AWvhQsMpDiRsQOSn2LLeJKkoyBrgF+YjfyB4tVinoPs+/evMUAJ4t
	GyjaPon6MHzQ42FIGC0UU6D9dUpnF7U0vkoovXOfxud8YHyajSm5O0cfUNStLyUD
	50jrYp22DT1YcNw4HoQf3KkMvZquzlYrM5mEbZbongbcfan7f2p6s7XVKEhTW73N
	vHK3bKmamYoQNBhwlYnKpjuSwG09DtfF4ePIlhwbfQeRfXOETnkZjTSIioASHSmM
	CYJ9lVpE7SRCWWJQ7dYjkA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467hfm006v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6ufhP031694;
	Thu, 24 Apr 2025 08:08:39 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfr25em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB/tyrT5/XVjY9Wv9YIf+m64fVyK31KfoHHujGRd5gThLQ2KohFD39UdVDhYcKwJYzhKNMCR17lDgiWz2D6XYPZaXq6A1sK1ihFJr4dmboH8+0NPAB8HG8FNGwWn6SD7EL/fK3eRdavXlnE9B2EhbuHn+g+Fsu17nJBULnWuyDPUUChHQhONxTLZ0hOyOTM4ohjsBzBykZT/kcX5lBv+0BxTp5y4EG5arn9PgA+uwhSlnZIoIBbhJw/TaOu9Bv94whkQLI3iuylLE632maKuSnEvYJrlPpMfJzSY52mJsSGg3ObA9JjJ4anW26IIYV6Yhx5jZ+A336GAv34hzM2moQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUgNxv4cL/9Dxkiza7/asrzAre485Wsa4U55tpifUuU=;
 b=iP1NdM516KUei+0O91Fmr65Kb49P0tfkD9R56CijARBwgL6ZzeabBLlS/sLtojZ/w3c3ZXAhzifyQBBRP4JNsH2nUYpSVWit1k6oBLfg3/BXCoQNYL2ufoIiegfo7Gvmp69UpLw8PXEnBhTws8jecR+t40RFpVU419lGlPvMDJhxGRTItmtFBkXjDu10WTrHBioSYYo4UHMNZ7Hgy9Dkrqo/FFaivUOBnS9l2EVoG+JGPwBiOs5ULDMN6XGeQjwDUoGT7FMgC/Q9xyjYCAk5bo5VBSrL4YUz+GkJGIvmC8T/aZlNPLUghZX6K7A1AUx1eVfBdlgdP7lpYhpZUtAVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUgNxv4cL/9Dxkiza7/asrzAre485Wsa4U55tpifUuU=;
 b=Z2sHzrU8GUATNFIzPjbCjjSVRKOJcFyHgaWzB87VG6xWdWP7QI7eygn97Qse2nr/qDmfR6y25PsmCQOKfm3gpE9IJpJB+yNZYRGo3A30wRxIF8Uy6mJ6O4c9xXVWemX/iRxsCy3OFXQ7VnzIJR7Q+USefQ8MnA30z5VOJhw4U4s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:08:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:33 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC PATCH 5/7] mm/percpu: allow (un)charging objects without alloc/free
Date: Thu, 24 Apr 2025 17:07:53 +0900
Message-ID: <20250424080755.272925-6-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0005.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee4fbdb-c64d-4d9b-0b05-08dd830734a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OwNs6JJ06qIWEjRvl7QUsjGHln/I+xO8RZ5KPzSO3Mrx1XQUTfkH0eFZcpb0?=
 =?us-ascii?Q?fj7SKe1t2x2uGHzgCX/fvs91MjEhowHD/5BVJcwWQqroOXwjX7O59I3zwllO?=
 =?us-ascii?Q?J0dYgHKhnsGFNs7DLpDZyL4CsGsfkWYVDX1iZXZ3srozLTypdff1K3gbLB8j?=
 =?us-ascii?Q?TIJueRfEC9dY7tVoJevybykhLQDo1HGih9RMyNeQ7Aj86IILF5vyAyqmIRWK?=
 =?us-ascii?Q?tx3Ou/mISMrrOSvi09yfAXZCP5nH3I28UxrL4KJrWl71cka+veMg3zwgb7GX?=
 =?us-ascii?Q?+U3wVAM3lcqExjS5XIxWjg7blIcT6ilEdUasNdEwSC4mL8C/zAuvmhrmxscX?=
 =?us-ascii?Q?3uWN75Et+yAQCVUr1sruj6kIntE9WpzHyN8v8uP3/SNIGZlpqotQRKkIA65A?=
 =?us-ascii?Q?h5rBdcREY+Y2gcFvfTByCTxJbpujKdAPgGHK+KxkTGANXF2HIasPZSO8Ptis?=
 =?us-ascii?Q?OoQw6rErWSo+JFANB6Y6tZRXTZJ3AX+m0b+lMrMZsGpEzS3zvN+3Rb+0OHAj?=
 =?us-ascii?Q?eUEZVvbqOhyqV9apYeFhgAvVDA+Y/sS4pSi0SqML+NIqRYzNYKQqSec0tA8S?=
 =?us-ascii?Q?ewZIG6Jamuq+PBTajB9edLjsaXvFQ6BDdRdVqSO/qlq5UBXN5zib6rJRmknA?=
 =?us-ascii?Q?24klFJImbYdHLB8iFMYWWnerdvCOffoGknm9+by/0fKzEuyfeII2qOCko1hN?=
 =?us-ascii?Q?ji+Ql6W/IIkV1znBitCgQPeYsi+KbN1a+m3clDkVZkhgCsWMglOjxCs5/YHo?=
 =?us-ascii?Q?L8egIMp0oEZYwAvRVZz/K3hi+cVMtMDelQAVdhFq3dj04sVbG8XmCaaRVhZU?=
 =?us-ascii?Q?UPxyiYs94Vo+NS+wwxltzT9ndC4qbZYrNjr3cqtxqeMvMQdYjUTq71gIrhrS?=
 =?us-ascii?Q?e5SKQB6pVZxcqYNcAFDxCR08k0BfrBxfs1TrbwFryBI1lf+CEghVUrSs3ker?=
 =?us-ascii?Q?fXBZsI2JM0dQdXIyFg/Tg4JJXzMFuz5Vxr5BVGeMO4nCY8REEk2UGxp0+tUJ?=
 =?us-ascii?Q?4h+2do4InwC6jYczWPIcuZRiS2iua6JheK5cF4X0hf9Q/Eb4jPKTB0x+19kl?=
 =?us-ascii?Q?itMcemEW1/eSz3thj47N7vGRRXvlhBQB5hLLx8TrM9ypJdXEPukBMaBO00Aa?=
 =?us-ascii?Q?PiClkMcDHmbbmaAB/R5SldLNhoFESRwIEcOJwt79T51t4Dw3kMaD2K/c3O8e?=
 =?us-ascii?Q?bbJf4MvsI97HBsnmuUPNgU5Bpw18pyky49gjjNozL+kmZTHgwr3WJ4oq7CSN?=
 =?us-ascii?Q?oRWGwWu31v9UOXSzXVZ+s60y6nvl7JZhGUkkWFvC2Zplj015yIHZVLLG5hwt?=
 =?us-ascii?Q?FPVYcFecyrczUFxy4mDzBh8I9ru/3ZIgDxgL9+fhUvyhPuqsdHGsIyfco1hv?=
 =?us-ascii?Q?bQvQwvFVGyTSW+3XiWGAf5DKEeonnqfB/1TH8UxL0G2Ymi+KJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tULQbJoQsiJmAYealKPif2pd+Of6+BEFYN/6pdWPd50e94012LRLEBO20kqi?=
 =?us-ascii?Q?EC70dwR3ClK8SpgFJg88aU3zvKuX+aqvId9XhSoRb5bwF/b6W+z4CUacpodM?=
 =?us-ascii?Q?2faIIJrcjf0JsX9GHUI/dXyHvuBvMQbjxdR2JIU0gb5WrbZyx0mHgVoG7OFF?=
 =?us-ascii?Q?wNt2mwgsvs9+UwZ0Wm0QnSmjzjbpahkvpr9xvSt2QISXXiAVJfMxstXFTt3s?=
 =?us-ascii?Q?4yKTmO8frdNXJB3qtNfrgTz3jG+eqMEiVMKJUCZ+xwvEwwg6ZIPnZ4Kmd3jd?=
 =?us-ascii?Q?aN0yFEd3kWwj0GtXRZ2JZz4YBdXq6EnFTdBvdjzbheB1qLLlLyNVzgc/hszH?=
 =?us-ascii?Q?RlEmssizmv5BwreZLwmYdU98yuM11BuoYNZc73i8+D+yWyPN8VE2R/KnJsvU?=
 =?us-ascii?Q?vhr2uH6TohKz5g1Eim9od57kdXLNEAx52LkhDB+u9DHABbrX613l9H9SOJmZ?=
 =?us-ascii?Q?vikzkBRI57QegoF1d2IpD/gVShBNsgE4S0bjAj2Hpk6+2m3aGO8bt3KfKcx8?=
 =?us-ascii?Q?BPGlX+l4Y4DTzxpM25J9C8v2xJuNlyGEvlMTCiDY5aHMviUBpjjc1dF65Qev?=
 =?us-ascii?Q?uMG++cdkx4xluypkLt/UmMq0f5S1j94i2kba3YY4CbgPH1A4P3Q9mNxkMtXL?=
 =?us-ascii?Q?V42fM3ckvbbQqWVioE8OtuPBVt3PwW3QuRxvytFACcVg09/xQFTTa4/F0NHY?=
 =?us-ascii?Q?C3FO4aywwG/T3CFG8atvgmuYG2UGnuGcXEZYfNRbkjzAw23S6GyQqHlVTQ57?=
 =?us-ascii?Q?9avgbllhcH/t/XQcBt97fp8fNXMwIHrYk3UrBxXcV2JR9qMrS8VT65+44dyp?=
 =?us-ascii?Q?C+1vOMgSFOUVWvXhR5mPdEisVNkuQYTK6T5M5WD7a/PtDnYYPt8Xm3Pr3DF2?=
 =?us-ascii?Q?9hgbhmrzm0qambHhtm4A5GEzAg9j7QWqLW74qZLCf6OO0SEpkTMxTNH6GIgC?=
 =?us-ascii?Q?2RbeC+DhQPRBB+E9eTMcVT1rqadydqZn+yMnNBoYltfsOYOca3C/zEbRtidX?=
 =?us-ascii?Q?GKrKTODxMIXr0as6OHg5+Ju0zptTYI+I1x4VvzL/hVQohAqmXmB5Didtnwe8?=
 =?us-ascii?Q?fudlgjDLzTC4ogBcFCLkfssCkUAmT95EUR8E1HpygZJA1JR8zysnFLSwuHt/?=
 =?us-ascii?Q?UIYinwS2J7LlsnvxBhjArAlwIoWYBhpiDxQncN9eDe13O4l4CEeS51KyIbnQ?=
 =?us-ascii?Q?sPaDapbYoyXB5urisbdD5ZvpP8p8UrHJhC2eyIpEwkqjhGeZzfaryOsIsVkO?=
 =?us-ascii?Q?vPE4rNRoT7mYPqM7HDmyKxg/mDi/+IvqQi83XlnEISQn5RlnPENjuNT9d1R+?=
 =?us-ascii?Q?7+epk+4jcpPTtKzW4G0EOkN4WBYZ0Xl/eK8uGLpfxeo0ufI000lT3+k2XjOU?=
 =?us-ascii?Q?tE/iTlQapoH3nd0N9Oc48h5JnoDYLLyghjRydjkhRz7VYEokUFWY9tRvOn9J?=
 =?us-ascii?Q?OOul4WHPEROf2mBifonajShcmEnpCZLAdRnotyYug7uX1W42Vef/9mc6TdMX?=
 =?us-ascii?Q?9l3G/WgYu8Y11mEDq0U6I9qwRihWvFJJP76GYKhBAow5O+tGRpewkpyuJ7xU?=
 =?us-ascii?Q?pX7sZELD/Mr7/n6oBdZMP+R2TvT2epq/js171CQj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HwvwQixPXvMjrB6whv0vqHiMgBOIXOXMiVPuBjwabYkPY7BxY+1jZo4HGJl/Qj+1kF4u5E34aXI4YCIEoQ1AfakoE2ZlfAcli652vyBugziaOaqIeygd03XJYUgc/Pw2tt2xGwjj/b8QgCwPFyHAtbEcZXUihqxQFyqKuaVa/MDxAmX4Wf1vTr8yjldd1GKkRhxUr3S7on0wxRSNAvpvz84yzaRFnsQQA2kylnAQmayWmStxObCf/9jVy+kUWA6SL6pomFx/il7c7Mc+ladSRrwAtc77PyqroWjlGb8hd9rLjtX77dEkFYTwAtwx/E2QHo0xIIS+fxsghag1+GmkyEnRVZVVGJJ7wmaEXJga0vGXqV20hvNwnbN73lKzxXWuTpmz7f8wfSKz03v66M199nX9PmcdW4JgTfV+7GSFEvF890agN4yxwSZvko2QCwSwxghunU7mefhkc5izw4BOe+L452m7eS7PxBZIRQC0MGvijy2ORM7L/91Sri90V+cFF5lq8O6izmWKz/KXHYykPny9vwfRV+SFRToNMC8skFYQKs8HBjmvXafoztRQlUC3xJYtFbKCGoy2EvwKA1GFxykiBhgaDRtqjFjQhiRAxVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee4fbdb-c64d-4d9b-0b05-08dd830734a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:33.0827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hCO/fq8qB/MuUTQzXPRUYK4YyuWpDDak6EDidM6Z2cOjVy6rSRCgjCGyxgvgt0q/mGAkO3G8M8d/filZSsbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240053
X-Proofpoint-GUID: --QRqZqRwSQrzYl9AdvUh0J3AExGv7Nd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MyBTYWx0ZWRfX3xFEBXD+2Z2T nlzsdMt3XI1fbNzIIEaykfy0RnG4wauJi7T1BXn7fNLq1/H/cs/Pq/8Nth5l8Wua7AiyvayIuYW q/Ce8tvaAZaDFlD2ptzL5AgpUkuKXwsAEXLrc5DQw2xoS0cAN2GJ0Y609mpcBaW5SkS/2Niped3
 zoIsz96UtLgDJnStHeIuANWOqHq6XfliiR8mUAMpEmiR6bQKwEB5ftKRIJsqI2YX1qxPeIHrY4R Z+CWTm7eW17l952CDWlZTJsb9MxhITl/e7PThc5KiR1XGgiE5FYy5hB8iiQXgzpjG45tB9FZFmG 9cqtQ4tbTZ8sWsGI72+MsMc2VbQG+N0qbbV5aANcU8atFVgWW9msjnQ4PfLDivf01gTBoof5xCl Zc2dXHpE
X-Proofpoint-ORIG-GUID: --QRqZqRwSQrzYl9AdvUh0J3AExGv7Nd

With a slab ctor/dtor pair, slab objects can retain a pointer to percpu
memory that remains allocated until the slab destructor frees it.

In such cases, the charging and uncharging of percpu memory should be
invoked when slab objects are allocated and freed. Allow explicit
(un)charging of percpu memory to ensure accurate memory accounting
for the slab destructor users.

Note that these APIs only (un)charge memory only for memory cgroups.
They do not affect memory allocation profiling. Memory allocation
profiling records percpu memory only when it is actually allocated or
freed.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/percpu.h | 10 ++++++
 mm/percpu.c            | 79 +++++++++++++++++++++++++++++-------------
 2 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 52b5ea663b9f..2d13ef0885d6 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -140,6 +140,16 @@ extern void __init setup_per_cpu_areas(void);
 extern void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 				   gfp_t gfp) __alloc_size(1);
 
+#ifdef CONFIG_MEMCG
+extern bool pcpu_charge(void __percpu *__pdata, size_t size, gfp_t gfp);
+extern void pcpu_uncharge(void __percpu *__pdata, size_t size);
+#else
+static inline bool pcpu_charge(void __percpu *__pdata, size_t size, gfp_t gfp)
+{
+	return true;
+}
+static inline void pcpu_uncharge(void __percpu *__pdata, size_t size) { }
+#endif
 #define __alloc_percpu_gfp(_size, _align, _gfp)				\
 	alloc_hooks(pcpu_alloc_noprof(_size, _align, false, _gfp))
 #define __alloc_percpu(_size, _align)					\
diff --git a/mm/percpu.c b/mm/percpu.c
index b35494c8ede2..069d8e593164 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1606,6 +1606,32 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
 	return pcpu_get_page_chunk(pcpu_addr_to_page(addr));
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
+		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
+			      current->alloc_tag, size);
+	}
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
+		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
+}
+#else
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+}
+#endif
+
 #ifdef CONFIG_MEMCG
 static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 				      struct obj_cgroup **objcgp)
@@ -1667,7 +1693,35 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 
 	obj_cgroup_put(objcg);
 }
+bool pcpu_charge(void *ptr, size_t size, gfp_t gfp)
+{
+	struct obj_cgroup *objcg = NULL;
+	void *addr;
+	struct pcpu_chunk *chunk;
+	int off;
+
+	addr = __pcpu_ptr_to_addr(ptr);
+	chunk = pcpu_chunk_addr_search(addr);
+	off = addr - chunk->base_addr;
+
+	if (!pcpu_memcg_pre_alloc_hook(size, gfp, &objcg))
+		return false;
+	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
+	return true;
+}
+
+void pcpu_uncharge(void *ptr, size_t size)
+{
+	void *addr;
+	struct pcpu_chunk *chunk;
+	int off;
+
+	addr = __pcpu_ptr_to_addr(ptr);
+	chunk = pcpu_chunk_addr_search(addr);
+	off = addr - chunk->base_addr;
 
+	pcpu_memcg_free_hook(chunk, off, size);
+}
 #else /* CONFIG_MEMCG */
 static bool
 pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp, struct obj_cgroup **objcgp)
@@ -1686,31 +1740,6 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 }
 #endif /* CONFIG_MEMCG */
 
-#ifdef CONFIG_MEM_ALLOC_PROFILING
-static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
-				      size_t size)
-{
-	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
-		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
-			      current->alloc_tag, size);
-	}
-}
-
-static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
-{
-	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
-		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
-}
-#else
-static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
-				      size_t size)
-{
-}
-
-static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
-{
-}
-#endif
 
 /**
  * pcpu_alloc - the percpu allocator
-- 
2.43.0


