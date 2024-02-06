Return-Path: <netdev+bounces-69614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9684BDE3
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F51C21236
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20913FE0;
	Tue,  6 Feb 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1WjOSQd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQgVvTbS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FB1426D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246478; cv=fail; b=mABN42YXW7kqWYL/lLVzepmlMUgPNcNnd4lyyteI9TZqI+rHO/V5oXQKxmx+QzfWeCPt7JMqqioqkwEOvtTiJELr+Dl8wb4M5i2OoQjeKFeG0BD/CzmexjcXiFTKyAZ8da0cXij2mcrFzTJKN9pGYXshhpSCUUG3wLYhEOFSNyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246478; c=relaxed/simple;
	bh=JFAzN3JGGOEIeHtNZ5zQty7j5IcSps+sOIA5QZvuO44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ud7mLmgyzOVJN5FG62UPpAXwm3t7+zyhkQGcVj0JStHojEC02giJiVgcMpuiGLhfJjPtOhbjOHq2PYsG4jn6hUFB2MM+rlEJy6Tit2xecKxuU2MI1hOomk5k0PPSIrzSLqE1HDeZH8d+qt5T5E5IdwH/RpL8iMf41AY4Va7e1rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C1WjOSQd; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQgVvTbS reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416IU4Ds021154;
	Tue, 6 Feb 2024 19:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=xYSMzp/m2+6BaHBQrXskk7YxOYUNuSUWHp+10V0oado=;
 b=C1WjOSQdVwKhRty008QBYAS2Wvfu/wHm/xU7BhM0dt+LQY+e9Yfg3aQECR053bCeNzRZ
 +28ud02WZyqOb7P3nHUGzSin/39vbnLyK/uaiALQK3HrpYkr1OZJQnv/QHaSB0aRCQ5B
 F43eT1shz0eQfW+62dIkiPL5oYuy6Xq7lZpgV/CSiKn9xS/e8XX4mD8tn9ebUBKaYQ0P
 0f6kvLg/Wqm0B5Xe3K9dImdxYYKL5Jz6msFERw6Cfe4pZw8uNllz2x2a6bc1IXaBW0LR
 ap+uaQF8DS4ORjR5VawOfaCbdIwXHjqn5aiRmPZFTQlaZf+Am7EKurNhp9UQq1N9axbF fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdcysk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 19:07:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416J5L5P038310;
	Tue, 6 Feb 2024 19:07:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7t8fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 19:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV4mR9r16lT861Nq23Z8vmIkoWiO4kXmAK8w8v5yGE7q5R7EB9p5a0zlvjMyb5G66+w5Eosvg6h33V7N/dJDqhqiMGM+wkFAojjmDOks0R42jE8sy7nBCNHEKjbtbuqYEhG7NAtIqHufqvIJbjChDgNBy6wfjR2gDBiy/TnK7nDcXoedWL2yAac8C3XcTGu1iryrOmmAxBG24YtEUgAz1nTet6WTrqbF8qaZDt5uYCV+TcS2kVYwCf9rjEGK1czZzaIgfjbaHGGETxtaYfd4zMZsXxbHpyVqQkAoBwLC/5OgDJNggOlUfymvuC9DxRtT0wh29uhNyIVB3O8i/yztqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndEGGCZH/nCwV1zRuHjTNJUn4hHwQeRiI//nXvCrru8=;
 b=A3g4SpdoOUFzUTMJIHgwcKm5RZ0osotdVz6v2RdGazLXQeYetQwfGqMg6twWvNWnFkB4EgaYPTyOiywfcsU/QWBQwlMwHk6E7QwMoPOrNlT6Twat66E4OgzvQlSUfrPSqs6s5fPLLrMIPHrsYjiS27ZreTFtbb6agIThZnIY7kMr12yLjfibF7CkOwYlsljxwpWFHdB1zGO7BXRrq1bn0wgyMQquSYxGdYaY7ya+GF9QKwJ5/jShjGHm3ja0xM/f0le74G04nBMVaLWwaNsxwUkrISUiD4V0qVHiAav7BrRwlI8/OQO584ILfKTksNQ8aaVEaXnYDVEYZpJIN4sehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndEGGCZH/nCwV1zRuHjTNJUn4hHwQeRiI//nXvCrru8=;
 b=AQgVvTbSgwbGvmSvyopsnIVj1z1m8ddZskxdPQ1Zo0kAI9jTZLusWaXQubZcpU4Ez0fur2ymMuz8WoGmLFZccWxebiyQBzUyXi+HPHJ+MM9aL3Q8EOBPXwqC98O8jc6PldRBDmqrFm//cAl/BSdqLDKnVl2rRx3ITSc/iKpGWbE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6565.namprd10.prod.outlook.com (2603:10b6:806:2bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 19:07:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 19:07:38 +0000
Date: Tue, 6 Feb 2024 14:07:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Persistent problem with handshake unit tests
Message-ID: <ZcKDd1to4MPANCrn@tissot.1015granger.net>
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <ZcJihCDh30LD4NPy@tissot.1015granger.net>
 <6904162b-5ac1-4f2c-a48a-02c104f6fe4c@roeck-us.net>
 <e6e235a2-85d9-4e3d-9ee4-3a9f00aaf1a5@roeck-us.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6e235a2-85d9-4e3d-9ee4-3a9f00aaf1a5@roeck-us.net>
X-ClientProxiedBy: CH0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:b0::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edea60a-daa9-4fba-e358-08dc2746e294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hL8CVwAGckdS3Q2+ru+fi46xgD7arelzbNE3tBoFZthN+OWaVLyyz2e9F5EihPFBeVdjCq/x0sXKqW7YSyPifWGrCX9OmKNtAqTswZ3UEZcY2+A55os4oipUN+ny74+dtUxafLlHzAop896pR60kJtFpExWaocchpiFj8HSxOr6OWY4g7aBtQ580sAsKEHevRH20iGqr/8bZbu2dZCJJPMSGYWxPtUMgJwSB0lHFTwdZZkByqvITmePYnlAcw4RhV+5zIwCX9gZ9RCXMgnkPMAQddiTlZB6AuOtEZk2c/YxFe4Ec/5zwH8DKuG+xJP7HWlcwCNvzHs+CR+dTIMVHxzRE7Gog7/3mMldSbe2I77zfTkEwP8sRft+QiSgTyYloLSad7azkPL37kDIJpPHs0pEYlellQaMVq4rFtAPEFX8R8kKXyjzDFb8SQLCuTidoG4cD5cDfLGV2MrfXB/tbFeaRMt6BY2hniA2bEzBg98nAbAnhTK6gug5V3HnZVBzv13YM+IldyHqYXGd3PKEJ+DRrvf325Y+DLKvzGYXC7q2JQcjS7pL3y/JS2juuquL/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(2906002)(38100700002)(41300700001)(316002)(26005)(66556008)(6916009)(66476007)(66946007)(53546011)(6666004)(86362001)(4326008)(8676002)(8936002)(44832011)(9686003)(5660300002)(6512007)(6506007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?7rP1CvptJVW1ybF+UFs+I1LhUm6TO4tbgERN/OEP8gPRlvVhVdUdDe7WDN?=
 =?iso-8859-1?Q?9aKF8zvzU7dG5/NPnJNOnGMt31FKpCdBk3DiG5NGa3ADULEMQcsE3h83XH?=
 =?iso-8859-1?Q?axugdeodZ8WExpnxW/Nbg0YwUjCPqxqoUiGOmALBGiNPze01KXyeLgKGnc?=
 =?iso-8859-1?Q?piw8BpE9b3B2MwCYkOiGhi5aw2fUUnj2BDjygMGaMwFsl+0JOCcz3O7Q3J?=
 =?iso-8859-1?Q?GvL6dnb242B3O5ZwY1VGmFEKG05niCO0FcRYXyh8oEsusAfipjOeFeZy6c?=
 =?iso-8859-1?Q?mHCj3/Xu7YtvZmc32iM4aOSZWP3jiJzvDCela8kZh+2Cxo7dykxaUDXWlJ?=
 =?iso-8859-1?Q?BtfdC7rd6xGBqMvVWZvbPI2jQhJJDTfPPX+3HZ9qihFGi7V0RiCqIoRSF9?=
 =?iso-8859-1?Q?sfNQbir3qO2VO0GDB0hsVqjax7muBjOKmcp7CjXMSAHSOPPDAEN/FGG3Z8?=
 =?iso-8859-1?Q?8hIrQ413LKJeugJ26pQ1/lx3MzzruCAOlNRgwgmpePmVajjQZlwL95+gmL?=
 =?iso-8859-1?Q?YDmE3jdK870n41IEsjrH+3Aq9+bqQDAwkyfizAi4mExehkcTD5wTjnqNjw?=
 =?iso-8859-1?Q?yGvzd59P/ytBwNRn7B0nISl0lcChIuNmKA7LbfvcVMgZc9IzaQWNn2KHa1?=
 =?iso-8859-1?Q?fIxxFH0rMXCot8Fs60Irg39DvulQo92l6cCWOjNZzokbMvvY4/VKRuaRaE?=
 =?iso-8859-1?Q?Zv8Z6P5bBG0eUnx4/leUeFSqJ1qujJWmAnUsZjOWsiCzHrqFj4wCkNCen1?=
 =?iso-8859-1?Q?qYE9AlssgqRWmJ/BHjWt53kfI0NKPhsx4oZFHrRYbw+fx0U/lGITIzve0s?=
 =?iso-8859-1?Q?CmUibeGbq5yVivZ5e4A8lwUZde6tzUh2jGcxrolyMt1AchhhjRSPcRWTWm?=
 =?iso-8859-1?Q?x7NaMZ4pBtALHg6PHmFMv83z3lzK/dMZrjtYwlo9NcujdWCOpKe4EtTVJE?=
 =?iso-8859-1?Q?22X8hVQPWn6r3GsfFXjDdJ+VJHeRyemMcHShW3iNrFeGN7zl8fJrRYfi1m?=
 =?iso-8859-1?Q?cJyOU0GGef9pkH9M7Z7WgLy9CK+Ka4Wlt3AJZNYLeZBUWM3/0Vt2mk4ZAk?=
 =?iso-8859-1?Q?V7u39d78uB3rbaERUT4MF2jc5v9mNp2SauA21WZFW5b6Pl1ykMC8ubZB1Z?=
 =?iso-8859-1?Q?efKwCtvm2PhIJKJFHUEA3z/Ws7PZN/rf26S5W8gk/6M69X3KKjHKn/+nRi?=
 =?iso-8859-1?Q?3R2GCY2vBZdrOVKEWtsefqJMWkOEIksYwPVwI2QORyIa0S81FPY/qeZQ/E?=
 =?iso-8859-1?Q?qs0x/owMWNPp4o/yP9Xq7KqMHTd9x9Q7bCG61eUMmPc0uopXkkZ7qxu9z5?=
 =?iso-8859-1?Q?UjKwUG27A734CNlsQbTuAbXGC2z5d+2kInE0VqSE3/KFrsDA1JqxAhsnmV?=
 =?iso-8859-1?Q?w2uD+7cJlTEZop7LQdxbvD8CLT2ajV2ws4UiQxeJLGHUZjIIr+xrPZoXia?=
 =?iso-8859-1?Q?n0zz1pyzRWuAKxghc9LNavcwfyDks4crK/G9cAF8Bt274/INSguwyfOTCA?=
 =?iso-8859-1?Q?bPCYB6zEpAKv3uM5WEGPBGe64gx9W+4JsYm6bbb5bcPBNPPZUkn7AwvN8t?=
 =?iso-8859-1?Q?8mqEbUQQ2br5brGjckNRZHzsZPPfZuQEGOQ4AMAwwTUPcuQu3Jb/AuVb2X?=
 =?iso-8859-1?Q?IYhJIJ3D3ws4yucuX3JpIlXYeJbFVF/WbUJGw9Vo6o5edh9AVxinV4Gw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o54TUDXEmMoxfd6UHSBoh0PdqNHNxeQT1t2JHwQ5xJvqDlqVEEPcqItbTbS5CTskQuPs6lndnkKIpK62iCv2pPLyP5z74fSnknp4fSiGepDKdWXbYagSRbKKHVjKtGyaQdVn6Hqp3VPzM+3YdOU7gZ5wIa5ebBPHH8D6to7pN99CM52eripe16jHa+reoMgJqEzUWQEcLcMPWzZbI/HB9cEVypTM60wWcKY2Sw0tu88TvBkNZ5jrbYGEK79kkY1YsKXT1pfp/LQDGjKcwpAi/r6BdFIP5suVPfN611BeUW2l/qsWfbCdrMRtKId+bKzD32EaGPrC0gyJrqOs8dv5FZX8TKkQT7cFJ+bN2Lm7lsLCM32D8kUCEQcX9e+91heJSrq9CJuwxJGEgg9vr3Z9u/offL7pEZ/eQAXLyPYPPIJa9NQqlDZG61PvNOafdLpFx/5VUsFR4HaKvf54MUN4bkxqXQipDYav09BzXeDzO6Mfl3F0mJfiVcOOADnBXflRudPYRE7xSvPOFbqN+d64PMyCXzM0LezQsMrENdc0T6URExIubb4u2dytO8dIBnAvJ+Y7uHL6d3qdxJ4b2pMK3P/BTkQZFL26IMg5ePwTaYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edea60a-daa9-4fba-e358-08dc2746e294
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 19:07:38.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soiADLEG3oeiaAx783qb6wYzQNQ+MEpLIZMzmIy+Bi6zmSEzxYYiRqMfS+dZVi70emjnhph9PfTOLJ543bqXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=985 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060131
X-Proofpoint-GUID: dxV3EZcrTrFX6I-qqdZI4rRbwR7v_xYH
X-Proofpoint-ORIG-GUID: dxV3EZcrTrFX6I-qqdZI4rRbwR7v_xYH

On Tue, Feb 06, 2024 at 11:05:36AM -0800, Guenter Roeck wrote:
> On 2/6/24 09:55, Guenter Roeck wrote:
> [ ...]
> 
> > 
> > Since the destroy function runs asynchronously, the best I could come up with
> > was to use completion handling. The following patch fixes the problem for me.
> > 
> 
> I don't know if it is a proper fix, but I no longer see the problem with
> the patch below applied on top of v6.8-rc3.

I've got something similar but simpler that I will post with a full
patch description, root cause, and rationale. Stand by.


> Guenter
> 
> > 
> > ---
> > diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
> > index 16ed7bfd29e4..dc119c1e211b 100644
> > --- a/net/handshake/handshake-test.c
> > +++ b/net/handshake/handshake-test.c
> > @@ -432,9 +432,12 @@ static void handshake_req_cancel_test3(struct kunit *test)
> > 
> >   static struct handshake_req *handshake_req_destroy_test;
> > 
> > +static DECLARE_COMPLETION(handshake_request_destroyed);
> > +
> >   static void test_destroy_func(struct handshake_req *req)
> >   {
> >          handshake_req_destroy_test = req;
> > +       complete(&handshake_request_destroyed);
> >   }
> > 
> >   static struct handshake_proto handshake_req_alloc_proto_destroy = {
> > @@ -473,6 +476,8 @@ static void handshake_req_destroy_test1(struct kunit *test)
> >          /* Act */
> >          fput(filp);
> > 
> > +       wait_for_completion_timeout(&handshake_request_destroyed, msecs_to_jiffies(100));
> > +
> >          /* Assert */
> >          KUNIT_EXPECT_PTR_EQ(test, handshake_req_destroy_test, req);
> >   }
> > 
> > 
> > 
> 

-- 
Chuck Lever

