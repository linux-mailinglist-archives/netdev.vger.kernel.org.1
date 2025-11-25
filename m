Return-Path: <netdev+bounces-241610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B2C86C4B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84DD23537F4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDB334C0D;
	Tue, 25 Nov 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kloOK+xW";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="daWH2Yz2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925B2868BD;
	Tue, 25 Nov 2025 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098336; cv=fail; b=eK6bcn0ZOc4CLm7K+dMO6DGCvl0d5wMTScKrlyuv5NFI9ykvLFBLNn/IJ3AHmozByR+AMkUEHJi7iq+l1qFfFpwZbW4JUEGp0NdQPZuW5kMG3c2t29erPtsaAWS+XOZZ1WuiRiiD55uCOc8318yL0ZLFbIdaK3wOsYUh8dlCvlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098336; c=relaxed/simple;
	bh=J5feg86018N4vs5STQb8BCTPhro4JGMKvN21LCQHAW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PbSg6FK9OMkNIy32T0uUbS0yHCYpEU0RWA7FOT0ZWEdQqbuOvvIDWRGbEyijCIZRoFJVVglHJH6Pdh2bAqeAdutkqCYUmXeDzfyj0vN8eK9VdvVZoGeuIve5KVOpKsKFA5FgABtLjojmpIjkwZhJt004FOPfyrVD0IcLKQvyl+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=kloOK+xW; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=daWH2Yz2; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APIgpYE1919880;
	Tue, 25 Nov 2025 11:18:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=+XnZY+WmZq/3jANCufMzw5PBnZBLp3uXMke4v8aia
	4Y=; b=kloOK+xWYLUlYJZqKT0MWVXoaIIZJj+vRcn/9UK4ocFDT49Sp3GSXlTi8
	f13poRH30oDPkDC9InFRUMQhch8l+Wml4qPoy3KzmC8Wm2092X4i5qvOWRfUyeyA
	z30BSvaZLmGAIs3iRzO0zHqJwVVllY2wXCogkpj9jbS6o49Gmy75fPD/o++TV7zn
	yyTSPT5jl8WXP4g4wZaecys2rk9ubbsmwKUn/sXdSEw18b8OlZnFltxqZQHpGLyW
	GCbKV3xJD9Sa7sqGrpIXMvpPN69UO7C9eXDS4XG3CgBRSuInhZlXQ4DOeDqRS7/i
	E5Um6ZcbvO75T+dEDDwkRERMhUBOw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022082.outbound.protection.outlook.com [52.101.43.82])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ana7r975p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrhhoAVeInbol2bUvxEDovkEm3wqTMM11CT/DWl50f0tX47si8G8uZUMvwkmBSYHeH/t+5uB9QUltbTHJjh0H2nYR5slP1TAtAUw2RxCCmrRW2+kh+LHlg4r9Dy/xs/FyAqT5BgpJpx0E4HQ7HcN5tZ/2QGS9Ky6lzBSBg5FWDnlP7GXmqadu/86iU6+qWT5F3ByQxMhUzpNUsoB8JqNco4BHAWwH0HSnoNSkG3RC9AsSnAVDyc0bvNrQ//cIhbaBDbb4jjKS54PKLViFw1+Debju2ZsfHGjx+kO2kx2qZM2Xjuc6lu50bCzNw3U5iYZsKUJxFGvt+kO5syuu8kejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XnZY+WmZq/3jANCufMzw5PBnZBLp3uXMke4v8aia4Y=;
 b=xyjceOIWlB5yTpYRCX2yiMJAOAI7nYaUBnHX0tnC9QzGcML+QEYCkP6myqW4DED6kNbIwms/GFEvCvSLHI3/vtmBwUwX8Js3zNmYbxw7jheusrlyf8zB6ur1G0lAsr1maKb3IpuVCwy9+Rdzdqx//wqtVS4NZZlJzL2DsPy9YxvqDTA9ZZ2a+Ta60k9nxyhGOX4wg/+BfUeJeu65tw8IBaIATnT5faTEpHdIsjcZKkDiRCYHHY+r6jfTn2h3eS8v710xqYTJBPapPtphClhnzaFX3J7JQal3kNwUWYfXDJByGsRlzTVt+k69HQAaQiC5weijPVVmHvKVEhX9kVKQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XnZY+WmZq/3jANCufMzw5PBnZBLp3uXMke4v8aia4Y=;
 b=daWH2Yz28T4IFAkJ46Gzi1HkA8UJbF+nahR68OIqwVBAFJI6IADqvubxlBPas72emfS31NJd7J1NUtHJV9SM+ZEH6oaDIQtnxCW7JTAzX/UnBdOtlJkkkwDfT/dJZ8YK2a2+pICgTNmyEFYhUc1lXzhlTIY2bLWBzsJgFznt8IMC+GOTEHMFybM7TssqT6oDeL7pYOvcGIunM9QgMKpe0X9vHh2X3Z74EtXEihaiJVoSG7jnuqFuOQp4mBBPzeFDN37OjDxCFr8G5ZKU3cfAiwev7UFZqPoOWGO+1g+WTRiDqfbbnu17TbFCg+WVAqxP5yYdCqDJqoiHTJHQjgzIbA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:39 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:39 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 9/9] tun: flush deferred skb free list before bulk NAPI cache get
Date: Tue, 25 Nov 2025 13:00:36 -0700
Message-ID: <20251125200041.1565663-10-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3229099c-66ce-475a-fff5-08de2c57705f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G1gZrvHCVsKPDADCENP8YWk+W+ifXgf68E/RzhJAnfyqet8dEonIeDIXTRWT?=
 =?us-ascii?Q?KUvFtQg9u9Z7QrLIkmBvr+q14GuUoXS2ODXluLdGnNPIglutn/sughMEdqZ7?=
 =?us-ascii?Q?SSN9lZpm7au3ub+fnKiBXnL6+hVoQxeqciSkPA8g7UkCdVrFXzHywRkoYf2E?=
 =?us-ascii?Q?wvETrz0lwDM9KnBc6iAIvD2u6CPhJYeSeM/hwwOV3wemY3UAsVG2NJRdwxmz?=
 =?us-ascii?Q?qU4ofEQgF/XHXxL7UoSPItt6LniU3V9WuW/rY8MhjGify5GLIuWYv1bZtG/R?=
 =?us-ascii?Q?8zxQ+ICuc4eucLXt8Je2gzwZmalYIj21q+qElSePEADw/fynaGivBkI0fNaV?=
 =?us-ascii?Q?8fPR79YAQ3aRG57RIXFDdmXjc11sBTcMY1us+7tUiFPoka6Ai0vAy/gJQpdK?=
 =?us-ascii?Q?iJs4260VxNc2DTbFJt0z8p37UHkPqyVSrM95mLqU9uHRlemGogRAzU4yVySx?=
 =?us-ascii?Q?Rs7Mv2cVD+q+bkRD3T4Oay79ZKtdKimWE4b+7vXItlUXXanOPwqvuBeHshpX?=
 =?us-ascii?Q?GOqZ8uaCn5w8qyja/uJgstrlolpAHl8va3MuZYoiMe4ZfvowfawUjb20VMvt?=
 =?us-ascii?Q?vYstoQhcjU7XF7/+Z6Equ02p8NCYR61wCI4MJ/IPjVwsujBWwmsWmjfvnspn?=
 =?us-ascii?Q?9QYIk5xznsppABEKZbK8RyN5y5jxjZ5OTbnec/+2pcc6xHN+8lnNhuovt7Kn?=
 =?us-ascii?Q?fS0ZcTxeT1sGyYtj+SxdkAS+oboXUF2fC59OcZfXJfplWx6ey1+3kYMX4f4U?=
 =?us-ascii?Q?kwCuMSQ0g7awX/MeqDaQXzx0kZdC2HiMUciJTj2+B11GvMNVMEWflLoWlrU5?=
 =?us-ascii?Q?8WIhwmXkabw11Ks0aDWpizYt1Lgzr1TwqwCugwXT9hP5Oc5ifSXCLWJRqkAM?=
 =?us-ascii?Q?KNiCQYxYPKz3UTHL1pFWjgSVjjqQyTEZXfO1QMFMtiApewvdIqY2jnGuODrp?=
 =?us-ascii?Q?5M2tSvjc3k8Eag51Ep0sNM8DTK8oW5XFb3O4VdPvtjzXVcbHCzLZ5RH3DdOJ?=
 =?us-ascii?Q?+akHyiQ01qbwe5HAy9nISRAarzrdSrDGI4WejocVHa/6zIcUleqWzSU3s5Ur?=
 =?us-ascii?Q?Z55v11V0tVVMS2zndYWdDRM05cRD+sLe7llncJUm6kNpWZwT51KWbpQnwpeI?=
 =?us-ascii?Q?CAcQkllH9COewLMR1GtxXPYj80kONodGPFWYagVObed4KW/VwjT1bNuKk/Zq?=
 =?us-ascii?Q?BpXsw0zztahTZM0v9fFBCWwQKfukYL+KOYkanKOjqf0F/2NUYoQGoUloX+pW?=
 =?us-ascii?Q?Dka0dOLfC70Qh/QJ6VbrlN4sKHUwnVrpABY0L+3EQE6JFvuADlO19vhvMVCw?=
 =?us-ascii?Q?UNfFULGKRNvCPYEd1XZWA8Ho4h8dNpwLanNZJx4Ikh4uYbFT5FNyM5gRCY4q?=
 =?us-ascii?Q?7f3WecQZXqDItrBMGCsLCu1Hwa0YlI6te2xyVd7jlzAvHQ4uQQ1XXbev0G7o?=
 =?us-ascii?Q?t0RT2TqASjQ389BKaC5pTl5XvwVjyNjFGy0ZQU3VdPwY2ca2xGhwKMtDmLeU?=
 =?us-ascii?Q?VdzFBa2iVSCKRPN526zjHiEK1rp3SOabf4vi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4N4I0qgJfc9jqShSx/TKKhzlupSNrJ3Qosx97xjwQ0UK0DZDSeMr354imqEL?=
 =?us-ascii?Q?L/8cnNU48AuF8QEFWXcN3oCKvZpdMj1b2LYwRooJjqwf4jJo/M3ygAPuBPQn?=
 =?us-ascii?Q?CLSxfShSknW2GKo7trRN3+mnBG84Te/aX7J5cWFsr51tYJ0G8G/jk0elsa4/?=
 =?us-ascii?Q?0GVTRxlRNkxZ+GPzsaY3iU8zsheCp2IEsU3iB9Fnf70VV6ZWn2UaXuMElwoD?=
 =?us-ascii?Q?xy7cV9A6TUDs+DPu5a77Kpe1zmCJs9FakuA0FQeN30lBMplm2m/gQIHHUL0M?=
 =?us-ascii?Q?GOHKhyug3Pn3fvkztror6ofpPTjCUrClYd+flF5Jq64CFd9nwYg/k2rjtob5?=
 =?us-ascii?Q?We66T9tuSY+FEvz0J5epRmlT5CmhvHLbKhugbuVYSZ+At+2G6o26qJExncC5?=
 =?us-ascii?Q?G1BzUZHN7u/ZPwiRoTO7Q9WT8Ei8hwstLo0cbBdKPFbaiut7OPjThXff4Qrd?=
 =?us-ascii?Q?WOf7VFl7gsxF15acR3KHZ7DMD+OhmIHPKJhlXM7tSUPkGNIoT1V0vchygTlT?=
 =?us-ascii?Q?Ga3a38cMuY97lNsFWbch86zhxfhMdoX7mWWdWry0txFo1wMpIGhSkB9xZkbV?=
 =?us-ascii?Q?15qCE5yFiUmzDX1ECcYQ1UuXFnrh7Mgk6bc1pUfEYS2vKCvgsrFnyLrNYhN9?=
 =?us-ascii?Q?/zcbUDrO5a9A3zXXTmArPgKsqMnE0ES7Oj3W911REi/TuP5I9rPJXmr8JydH?=
 =?us-ascii?Q?BVJ7PUecP8i8zK0NH0KIkX7YGi8ae0Bjzoz3EiBfju80IvADhrhzSHXmu/Og?=
 =?us-ascii?Q?Kz9pSycLMMHCLoPyFSFSCBuFaV69+9Upw4SMbGrIC/FEcOulAMr7w6MSrh5m?=
 =?us-ascii?Q?QafsfvwX61lXvBvZxJCZWbH9jRB8cV6VFamvnR63d+j7GGsoQ4a+caen2ZrM?=
 =?us-ascii?Q?Tdv3v1chX6BjdeBM3/DbMIdo1Rwz7/dsXYNFR+KCgkMYKTE+IqdxHZWR11S+?=
 =?us-ascii?Q?sf2bfYZkOjh8Qzpw2Y5VW4nlXWYZHcLvMWH2OIJP1DcDAcsN+TdZP3DZcfFn?=
 =?us-ascii?Q?Md+0ynXYES8A3U7LkxejD6g5NkkeUmSxJmyxVxtNAXlL1SNIOkJzhv2IhtUh?=
 =?us-ascii?Q?9GgFYgB2PAJWX9yQSKEu8YjrvdtBAVph8NIhbJ6wtWB1guA25DBFyqsyYUew?=
 =?us-ascii?Q?MsyT0yqSzijh8JLauWBRp4CauC9jEaU7WRDqJ0HNi5FGUu73o0ZvSCIqFv8S?=
 =?us-ascii?Q?kkiephq5pdLQsdTnJ9HLvsKYLFt8MwE7TChCYNtbXu6pFFGxHWP1tlJugzGZ?=
 =?us-ascii?Q?rYP7ZdzKo3UKq7nhn8UKnSJBTeKoDx3MU/BjolL/h34caC9H8bN5mFrRRBlJ?=
 =?us-ascii?Q?Nef6lP0fgEV6RacFlnEp2YHqM07dmGsWsUgQp2tZrp0zV4MS2hWqIWo1eiME?=
 =?us-ascii?Q?b+IOBCRr9G7ISTsxQpUYU+byXys9I1xS/99/lxG3lX9FK/I/qfczhVO6v952?=
 =?us-ascii?Q?ol76O1mtramq9QDYSE3QYWFslYdb7+3f6Lj6d8zr0crywtEnYapNwuU8ZZIp?=
 =?us-ascii?Q?iiarc9Ll7QZX6+33l+YGfp6zj+tKWCzdNMfP5R/irSBRhbnLs4X79T83CV/L?=
 =?us-ascii?Q?23DP0KmWn0Aaxw3v0XXsrN0W41WwQOHguKHyFVHlp0t68El+AfK0/69L+P/8?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3229099c-66ce-475a-fff5-08de2c57705f
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:39.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahpbF64p63ilAfxvX4er7DO3NW/+HKdCfDWW+pN0hDbmLmdwh4HwaqtzPANSTXJPt0RcbFlkQyGExnpQua9yrQCsnk8p0qN7NFXRUd8zO2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Authority-Analysis: v=2.4 cv=OuhCCi/t c=1 sm=1 tr=0 ts=69260111 cx=c_pps
 a=MPeZxNXPLKxVoTdC8D++DA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=uoglhUzKxJeFjB3JZUEA:9
X-Proofpoint-ORIG-GUID: FwbkDHt4saUEsJgtdH1ZCrMqgPMvInnD
X-Proofpoint-GUID: FwbkDHt4saUEsJgtdH1ZCrMqgPMvInnD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfXwgP6o1DOVn/7
 oPS8T+iVzJSUR8s5yBjqsPaoEJwMEHKaW9w/VU/tqwiER0MbX2Ova9EThMAE/rCUCgUy2oxSMts
 hOlCQ0HGS8g+4RpaRjRoF9xPvfTKD15PBjvo0ByDIN7rdfdhEDsyU9dRMV6+FQ+RQros+ZcWDCY
 bijiv2sMs1m/HG5mCqho6GbAeKKaryLFRL48uapJ00JJvt4xYnVRo/NeGD8MrMx13VnFaBWhjNA
 7gHSVNGYVAlrNnVkBTpQg56y8iR5ZBoAi1kDFjI+52LXOpXk7vjh7+bldbBNqEz6rsn2AlzbpEc
 LP3mKpThyqCjw4hU6NqapI/SyTQ5odInvn/1Qa/M1dYWWNf217M2GxnfJ08QSTEX7KSIgN7GfaA
 D+zK1WgPV0VPs3qQxGd8XJEelfUnXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Call skb_defer_free_flush() immediately before invoking
napi_skb_cache_get_bulk() in the XDP batch path. This ensures any
deferred skb frees are processed so that the NAPI skb cache is refilled
just in time for use. Keeping the cache warm helps reduce unnecessary
IPIs during heavy transmit workloads.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b48a66b39e0a..7d7f1ddcb707 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2589,6 +2589,12 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		rcu_read_lock();
 		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
+		/* Attempt to flush deferred free list immediately
+		 * prior to bulk get, which will help repopulate the local
+		 * cache and help reduce the amount of IPIs a TX hot core
+		 * will receive when the defer list grows high.
+		 */
+		skb_defer_free_flush();
 		num_skbs = napi_skb_cache_get_bulk(skbs, n);
 
 		for (i = 0; i < num_skbs; i++) {
-- 
2.43.0


