Return-Path: <netdev+bounces-290614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLqfM9FyD2ryMQYAu9opvQ
	(envelope-from <netdev+bounces-290614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:02:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF75ABF99
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43677300C00C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722A2EC08C;
	Thu, 21 May 2026 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AozubY+e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x7WwruuY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142D10F2;
	Thu, 21 May 2026 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397316; cv=fail; b=MIaNjrSC9QrOD00Gk19O018lQWraZ328o2YMQ8fPPljWu/nh58Ov4t4+4Uz9E2xZmPL4Hxbn6h84cyS/hRGRo9Mqki0beiI99kLi0+oivbNIbp8D8KDQAakcHWZ6HvZ0HobJ6lSVUFJGX0VaczbFXNo6sX6rRdBap6vAbZsTbC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397316; c=relaxed/simple;
	bh=lZR9MQzCxeRomBdgn4OEflm8zcRTY32p+Gi+brSgCIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LhM1cncrm2U6WqOewPoWzH/ORcN3IkQ9D4Hn/kIKqWwraKyjHXhS9TAN49tjqBqgDyXY6LAoYEErJ6Vw4woWJUNJNWn/NFvW3vycR0TSGK5beWGyh7Qsgcj8Dtv/9yGawEkAwm5+YD/Gobsd9E+IeGJy6FHGs5tdSVJAfXMgJ4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AozubY+e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x7WwruuY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LJfVDx2945319;
	Thu, 21 May 2026 21:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CK/yV20Qzfw0z+AEDclj1XyKNXspSnxaZbMS6X2k8l4=; b=
	AozubY+e0TvEQsVeXlxuu10Q628wfCEtF0OG3DMCxg4LmwmHzS0d4IVRrb8trmYd
	AVlkr35460KZq8qyczUgJQBYfDnZO2JCDTGFvCkM4IjbiCXgpP+TyCx+TC+y0fG6
	xTyrHuLQdS8euz+rS3FVS/0Afz7vTABaaJ2nXfORLnOsf3WeNkXeCQvGgLiCbOc9
	59qtPhgUJAA5iDAqYbt7phng9Pc4QYZsS87fITs/rEskBHrhRLeaZYxJjD/8Zhdr
	hLtAgXFQeCRczioGhqBAV6VtkNI1mSTuhBIWJ00jvlLayfe/ZIvusEAPM6xMd+4d
	ILrS8f5JEry+uIZz6SuGrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2ct1kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 21:01:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64LKxmB5010250;
	Thu, 21 May 2026 21:01:45 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1k6r60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 21:01:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVducWvdvpVnx4E5tGSA+qciB2BzwkdtVXyX/7GOqE5gxuj5Yz/0v2qzv3XTJ5W2uwXca5Z2El+ruA4syhGtPjlPV+KWst+hbncnMZuHriAXUkib4rmFVMAIdK87vfk0ms98z19SR9qusvXOc6Y4rVoIw7Kz2+nDsNI6NfjRAVEN5H9TkBwjNI3QYdbVulrkrTHjAIhu0tdgV7mIfPq+01Dblq+mriZILq/I4e1DnRVmaD+qNiZGjVmtrkmmAeXDuqAfXJ4d3HAPKNm/KHQPVCNsdTuhBgQEOxROlSADPRhcbfX0YxKSbS7E2VJ7CG63vPN/0H/2PiquriEDwp25ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK/yV20Qzfw0z+AEDclj1XyKNXspSnxaZbMS6X2k8l4=;
 b=CT/h53YbTq4w8x+ABDJBnjEZQsH01lFjuBMwN7FtJhkwuCPN/BMEzMjvUJqDFBAHXE0g9SELhbFeNEwH5Sd8yFfL/WRb0wpBdX85PYApNI/YD5ODN6FgWPPNK/C9f2sbK8dNiZ3Kedz5tthxEj1Byfr4RNDBYWXljb9JDPhfjMY4PX5WKOv7+kWq/NmZoj3RfqWPsTcYUrl2hJI3yrtKbf7NpMZqWUy8ilAiRjacmsSCHLrWyex5NWgBA24oUBh7EwAKWHwPhw3/cs203XJvGp1S8Rvq91aZetW1Aw1jZy0d/lxdNErf2o4r8KDFDt/b7krBqnYUtg5eLFtnXC7swA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK/yV20Qzfw0z+AEDclj1XyKNXspSnxaZbMS6X2k8l4=;
 b=x7WwruuYehTxDcdnXKJ35NtQ7DDIgXdwiN54U6mlbANOJxax3QKguXEse34BalVuyv5RgKxW9uqSOy0mczy2y56BtB/TFRWo7DpjZbYCO482ppkpz649Co8E6GtmUPqLiGywgs5Tk1+l54Ejhd5Q4neGexPHUaaJNLKnD6vbVmg=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Thu, 21 May
 2026 21:01:41 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 21:01:41 +0000
Message-ID: <cc1ea6d3-f694-481c-a5db-4356c5076207@oracle.com>
Date: Thu, 21 May 2026 14:01:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: free page on short-frame rejection in
 tun_xdp_one()
To: Weiming Shi <bestswngs@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, xmei5@asu.edu,
        linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
        mst@redhat.com
References: <20260520160020.375349-2-bestswngs@gmail.com>
 <willemdebruijn.kernel.28580e8a2708a@gmail.com>
 <3f4460b0-fd07-40f6-a9c6-827dd0ce2ff8@oracle.com>
 <willemdebruijn.kernel.7526a484e05@gmail.com> <ag80f7ENWAHsK-fw@Air.local>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <ag80f7ENWAHsK-fw@Air.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|BLAPR10MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fe6bcd-a513-40ac-5bb6-08deb77c285d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|6133799003|18002099003|4143699003|4133799003;
X-Microsoft-Antispam-Message-Info:
	+6ZOVMsUaxuIu+K+/VPdcFMww/lYvj4bAIuFYJR4dJMke7XcqRXFrALroyDkBhSpRyK4wE0e3qvvN4dO0YsRImT44CG8zIkQPk9JFLgFVWfGIqb3kUumLpsWFND7FGSLtgahJMGn3bXBjmqUp+SziKpGIMLU9bt2+cjKTtdGfD52D/wQLB7rCc6piOvTNGDcoC3bWDRiqM9MhwVTeNvOAN8kzfYmCTLDxKz3sDUscEM4MqpFd7JNBghEcYIyhb1FkR1LJBmvDFgWYvtOJnJRsZxrhOsdTJZ8lCZFvre6RmsKxUVs4Wz/Fos4EN5BFnYS9e3xmt/QNJpx7W4Veu5xSP4Jz3kU1DI740yD1DStUqp031/7f8EMd87IYxnXVY8bTdWrkLh7gUNBviCyWPrwXooIiVGQwLBJcwHdsBMz5hTHxCye0oxKFZS2REX2/6qIhuDu3X83rW8k6QuzPVeeMP5qd2QtSCNcPKA4otk+T+TcF36KNVyo/DRwgCoq05UlRSTqWglYPI32wUBAlwfabWmB3+8W3fzjFNATSHrbQ5CCwX5Ytg0fe29xgTp/p6Fsg3dJwnxiKPl3kxI+jneAQpxLoBVl+OaFXqxmV+j8US3Rg2dqvIYY+lG5cdqvR4DgTD6EurqvGUz65AFATtFybg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(6133799003)(18002099003)(4143699003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmdaOUJ5R0ZmOGV2SEk5MVlwYk56dU0yNE9QcUN1ckZzNXF1blhKdnJ4MWhw?=
 =?utf-8?B?emZPa3BYMk5QZ0FOMDRsWDI1Q2hHSWFLQ0l6M1JvUHpvaEYvQ3BIWGZ4ZXVw?=
 =?utf-8?B?WjZqK0QzaWVRUCs2MTlXM2JsK2dabXlGQmFJRnVkaWgyU0JhQzJXaWF1dGl2?=
 =?utf-8?B?YzlJWEI0cjRqTkUrZUg4QVE4aVRGTlFaTmJRc0pKdmU5aGx0UUp3SWJUQWNs?=
 =?utf-8?B?UVhqdUU3Y3E3L3lvZGFudmc0eEpIZWJ3MnZmcGZkMW4zelJuOURNNnQ2bS9P?=
 =?utf-8?B?Y2xUTjRIQUhDRTRuVlZDQXJwSmIySkpJb1NQb21NT2phMXdrWUtJRHZoMUFS?=
 =?utf-8?B?WGVMb2VnZERkdTZTb0ljeW1xTXZ1aTJBcEhBZWQxckFuVi9pVWUvQ2JqbHlt?=
 =?utf-8?B?U2hkbk5uYUdHRkFCSTg0WFFickhhSURPT2FiQmpqNzZNUGNQWis4YldYLzAy?=
 =?utf-8?B?dVRKNHdTVUNqcUhWUHRka1BVK2FNSURBdXJPbXNiMzNaM280MXZTTXhsVUpu?=
 =?utf-8?B?QW9PU3dUNGphelUwVTlNMVpGMm9FV3dBUUNCbEg5QzBydFducjJEK2QzaHFh?=
 =?utf-8?B?K3JhSmNzKzVQRGN0bU9WV1laZWJNdHM5SjhoWVN2bks2YnZpOUtSUzdKRXVn?=
 =?utf-8?B?dVVzbkxiMnlpc0xFQ1lLQVdFTzBaUURZNGZwaUtsYUdIdzlzUHpTelRGdWlw?=
 =?utf-8?B?Z3dUSXAyL0tES2kxakpvbk1JbmdIYitRWDkxM1FqdnRZeVBKa2RRaTFrK0Fq?=
 =?utf-8?B?c3Z1VFZYUjFJa3RzQTd6SVRYZFpFUTFhdG9SUVhveHV4UWMwZ2FsbFRrYy9Y?=
 =?utf-8?B?Z2JEaCtGVm03VCtqYStDd1FOdSs1TFQ3dTNwSDYxUzg0Rm5GYzRKQ1o5OC9M?=
 =?utf-8?B?Z2ZHNjdRNk05R0tjZTkxMlJmMHlpL2pSUlFwaUNHSkUzYk9KTFRPNGpqTEJY?=
 =?utf-8?B?MTlZekdjZ3o5M1FGTUFId1hGSER3bm5oOXh2T0VmUU9uZnNvcWkxYTBuYkFu?=
 =?utf-8?B?NjIydkRwcGNoRCtYb0RtcVVkVUNzaWVReHlkS2dvYXl4dExDTHo0SDllM0FR?=
 =?utf-8?B?VHYxejMvc2ZpdTZmVlEyWGs3R3RaY0dXMWsxUHJTeFo5aThtUCtiUFhJSkty?=
 =?utf-8?B?UnYyRDhScmdwUFRYMVZ5eDluY1lCU2g0NkZjS3VBeWI1SVYxQmNENDgyUEsx?=
 =?utf-8?B?ZVN4NmxHTFd0RG5qSGFsVFliYVlXN3pnOWY3NFZuU081dFM2cVJ1YkRpNHdZ?=
 =?utf-8?B?cC9CVWhDVG55Z2NVaHJ0bTNTWk9URnNpZ20wTXNtZGNKTnZPSUFwZzZCbHZX?=
 =?utf-8?B?TGQzV3lXbnU5eDRqbkwzUzRCdlZNbjZ3THg5bGJRMkFBNUtJcEJsYm5FUjhZ?=
 =?utf-8?B?dGMxWkswR1JUOTlLQVE4bXIyREJQbnF1UjM0V3RLdzZiRGZqa05WQ01oblhD?=
 =?utf-8?B?eTRwdHlWaGZ3Q1ZSeVVJV2w5L0EyNTZZSnp2QW9HMS9tYmdFWlB2VUpMRnM2?=
 =?utf-8?B?THB4RHZTWG0wZGhsSXFocXpBWlUyNmgxdXVkNkNTS3FWTW5TWlh6SnordWln?=
 =?utf-8?B?aEdHSXEzTXRWbDRKY1pkaXdWbjhZWGhzYklHRmJKYURjbEtvNjdHcm0vMXh1?=
 =?utf-8?B?ZjBYSElWRnZ4dUZiZ3BZcnJMNEp2SDJyWmcvL1dpbk9TSHF0SWFFU2RHdFQ0?=
 =?utf-8?B?SGVHNmpkUVJ5UTNUeEczSGdidjFxOHlXU3FqM0NXNDdxeHRMWENZcnJxOVRX?=
 =?utf-8?B?U0FxRkY1R3hoZy9YTmhrK0pvRHl3dkNXc2ZPTG1tYkxKSjcxbEI1RHczaG5P?=
 =?utf-8?B?RDVOeGtob3RxTkV2dXNVNWVERmk2U1prN0FJU1RTdE1PaGVIUmNtdnhKaEFi?=
 =?utf-8?B?R3BscG1RSWtVTVd4VjdBS004SUY1TEtHcWY4d29yWmt5K2kwM0hNT0VGTzUv?=
 =?utf-8?B?STVCQ0xoRlZucG1mV09hT0V5MVY0ZFU2a1hKSURXczJNN0NPUHZhVll1bDNS?=
 =?utf-8?B?RlZlays2R05MSzBEbTVETzNYblkyTFVzaTBZZHl0RUtPeUJQa1daQ2Y2TDEz?=
 =?utf-8?B?SVpZVlVkeWlGQWJJelNXcjVUamFqWUoxeCszYk5JRFgxUm9UZmIvK2I3SytK?=
 =?utf-8?B?SGk5b0s2YUcyUlRodGFkTWVySHpteGRvaStXcVY4alNheEpoTDFNbmtkR1dl?=
 =?utf-8?B?UGdqZXBmaFNXdXJ4Ui9VSWkraTh2eXdaR05ZTUJhNnVLNFZpVTBqUzZNenB1?=
 =?utf-8?B?WkI1MEt0V04wY29iWTNqVU9FNitSbnVNQ29BcWVFWUpJdkxoM1hDeXZYOS9Q?=
 =?utf-8?B?NEFiU0QxT2E1Z0UwMTMrQ2FtWmRBUUV6THVGVVhoVm5LNzlyR0lsZz09?=
X-Exchange-RoutingPolicyChecked:
	YDPfrrhBAOJqC4/d5DLo9OSAdCTwieX1Nhx/zL4W5HhQA1e/bqt9gBSWlfBF/LzOeHVrZrxKkWuQjO0+FOP6PORq49r5MKyq6yY91eHUYDYHi9ueTqGGZOK8Xe/uF3vkwQjZ+CBGc3zeyn6FmDwNCTfeo6+GTRGFZHA6/FT8tdGwS89/BtP7qQMxDiDObh2qD/EIzB+NT9dIdYU95TzCK2SBEA7Fcajc31W+cLEQSF0bfiVVRwxgUMMjiA7LYPp/E0rboNonXDDTTUGBQEiFkTfqlzaae4d3HuX6TqdlXZe4JzoR+vyj4A4xKwpsLAO7sa8bXoEfOjL5YKLWX6HjGw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YWXZkVaU5S2PJfvNXBQxQQsp92ldeF2jhyP69aLItNt4He5H/3DkSPM1a/ETox57EaKFY9k/e1uns+lymojlZcO3KFVnZQJVyw4kTMkQV07O5ZZno0tj4WhB05tJxYuUMs9Dg73sSqd5Mo4Qu8iAMZQ4h8fbl2PdIj9tgyHYzWqdYgc5cQmw8PQ/lDu95nsdUBH/Ya+D/9x5dXqhBkVvXh0/ToTEXvH2PMZo2Gy6dYJu5q/otpEOIMuLCsxvTNQ8sijSchuO6za9AOrdGTPAdGdMJEIK0gMktbrDZnaNiNgPbfEyQfwRZoL1YDvGwQjS2XmEYi+PH05USJEGwEuATY80HgyXT1mkPm86nIypIoO3INI03DK8Wim8Ka4sWZgWTcfUx0gYoIaYAnOdwRjnk0ZFMGPs+5rrpb7Gx/WKUZH0foSusvj0X2O3dbvIBFB9nmO4yqya/ItHEIIaVxJ7TSWLtXyJo4qG2GZst5XTyW8XaEun5wNaw94emolRDOyc1jrCP9D/A9zETUGde++vdi1dtSjcD9p/OMdKIo2JST4rKr+WaT+kSJcupDSv0DGlpqeyFzxDq5GTxOmz/My4xCtZdyiZ0xIEEd71qEs4ZHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fe6bcd-a513-40ac-5bb6-08deb77c285d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:01:41.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG5g3ujcGp42lvvevXa7a0qRzgE/jbZz9Dmtbdc6Xx67UC8ChvovDbjU4VaX8015rH4hQvLTQe1mZ8AwKob8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605210211
X-Proofpoint-ORIG-GUID: HWZHOrhmTBiSUND5nILYFy1XQ0S4iEvy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIxMSBTYWx0ZWRfX+KyVJjIKbVnv
 sI2SerPpnT0B/HcPS5focWtQq8YYXKPXi3x91EJ+SAwBpYat9mfUBObdkpHlM4Rl9giF/fA+dcI
 JE/lxgfeBAzWdhDrQlDlKkgPvkahM8nSTsZbcFt1KLU5ttGP9bqW01doMzQ/uw4GpAiqy96hV+R
 j0XAZTL/JsXHnxp4jK+wyrA4HmmqThVs4MoDMEYyvj/YmB5/c2PccOGGke5Y2IpH2Nb/gx6qP5q
 f0XEXF97qWetOx52tcdaTR7sA3KFRG9VRS1/fJt/muk++l62Fru2Gn1gnaB87Ry06spmS1a2/Ku
 bPW5TWy1mEw3/LxwFBGXLzBOhKkj0bQe3fdJJsqc2pHfhug6B8KHOQLSQ/GiseX8iU07Dz4uAoG
 24mpx/YBf6q/itpKFh2VHZB6bHEfcmWDu2P7SZt+Pe7yPj02QaBtJpxAOOzJ1ZidcBWNGNtiVsx
 o1SFT5GRGVS6IZf+mjl3Qpu/HL3e5s0YTSvc5yNI=
X-Authority-Analysis: v=2.4 cv=Ws4b99fv c=1 sm=1 tr=0 ts=6a0f72ba b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=aCn9LpsDNY45A9dd-IIA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12299
X-Proofpoint-GUID: HWZHOrhmTBiSUND5nILYFy1XQ0S4iEvy
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290614-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,asu.edu:email,oracle.onmicrosoft.com:dkim,urldefense.com:url,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongli.zhang@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 71AF75ABF99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-05-21 9:44 AM, Weiming Shi wrote:
> On 26-05-20 20:58, Willem de Bruijn wrote:
>> Dongli Zhang wrote:
>>>
>>>
>>> On 2026-05-20 5:05 PM, Willem de Bruijn wrote:
>>>> Weiming Shi wrote:
>>>>> tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
>>>>> freeing the page that vhost_net_build_xdp() allocated for it.
>>>>> tun_sendmsg() discards that -EINVAL and still returns total_len, so
>>>>> vhost_tx_batch() takes the success path and never frees the page; each
>>>>> short frame in a batch leaks one page-frag chunk.
>>>>>
>>>>> A local process that can open /dev/net/tun and /dev/vhost-net can hit
>>>>> this path: it attaches a tun/tap device as the vhost-net backend and
>>>>> feeds TX descriptors whose length minus the virtio-net header is below
>>>>> ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
>>>>> tight submission loop exhausts host memory and triggers an OOM panic.
>>>>> Free the page before returning -EINVAL, matching the XDP-program error
>>>>> path in the same function.
>>>>>
>>>>> Fixes: 049584807f1d ("tun: add missing verification for short frame")
>>>>> Reported-by: Xiang Mei <xmei5@asu.edu>
>>>>> Assisted-by: Claude:claude-opus-4-7
>>>>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>>>>> ---
>>>>>  drivers/net/tun.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>>>> index b183189f1853..f594360d66d6 100644
>>>>> --- a/drivers/net/tun.c
>>>>> +++ b/drivers/net/tun.c
>>>>> @@ -2394,8 +2394,10 @@ static int tun_xdp_one(struct tun_struct *tun,
>>>>>  	bool skb_xdp = false;
>>>>>  	struct page *page;
>>>>>  
>>>>> -	if (unlikely(datasize < ETH_HLEN))
>>>>> +	if (unlikely(datasize < ETH_HLEN)) {
>>>>> +		put_page(virt_to_head_page(xdp->data));
>>>>>  		return -EINVAL;
>>>>> +	}
>>>>
>>>> Make sense, thanks.
>>>>
>>>> The error path from tun_xdp_act does the same. And the default: label
>>>> used to too, before a batching optimization was introduced.
>>>>
>>>> Is the same then also missing if build_skb fails?
>>>>
>>>
>>> I also agree that we may need to handle build_skb() failure.
>>
>> Thanks. Fine to defer to a separate patch btw. Either way.
>>  
>>> In addition, I think we may need this fix for tap_get_user_xdp() as well.
>>>
>>> Thank you very much!
>>>
>>> Dongli Zhang
>>
>>
> Hi,
> 
> I have sent a patch to fix the same issue  and the patch is under review now. 
> Please take a look if you have time, thanks!
> 
> https://urldefense.com/v3/__https://lore.kernel.org/all/20260521163230.1478627-2-bestswngs@gmail.com/__;!!ACWV5N9M2RV99hQ!IDJKNE6zGJJ7hjjCFU8OviGWfh4A_mNZAhrTowR0Kb4p5bm4JmoCmEI6_GfOXFjcxd2ctJ3pbcJypErFgC4-$ 
> https://urldefense.com/v3/__https://lore.kernel.org/all/20260521163312.1479805-2-bestswngs@gmail.com/__;!!ACWV5N9M2RV99hQ!IDJKNE6zGJJ7hjjCFU8OviGWfh4A_mNZAhrTowR0Kb4p5bm4JmoCmEI6_GfOXFjcxd2ctJ3pbcJypMyOq4Op$ 
> 

The bug fix applies to both TAP and TUN.

TAP has a single patch, while TUN has two separate patches. I'm not sure which
approach is better.

[PATCH net] tap: free page on error paths in tap_get_user_xdp()
https://lore.kernel.org/netdev/20260521163230.1478627-2-bestswngs@gmail.com

[PATCH net] tun: free page on short-frame rejection in tun_xdp_one()
https://lore.kernel.org/all/20260520160020.375349-2-bestswngs@gmail.com

[PATCH net] tun: free page on build_skb failure in tun_xdp_one()
https://lore.kernel.org/netdev/20260521163312.1479805-2-bestswngs@gmail.com/


The bug fix looks good to me.

Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>

+ Michael for FYI regarding vhost as well.

Thank you very much!

Dongli Zhang

