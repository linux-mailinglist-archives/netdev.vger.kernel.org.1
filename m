Return-Path: <netdev+bounces-136408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770C9A1AAF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A5A1F21C2C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BCC18E04C;
	Thu, 17 Oct 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="U24sDLE7"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBC158205
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146708; cv=fail; b=uHK1BusqCR773RVrILnPO3s/qmMjtqOOYWWTxdNR2Ro3A8MyhireetoH6SLXXdkDsvszvomy4Dskmo8k5DJd45UfjPP+nEqOGY2PVev/oDb8xuoKuMl/S3LDxeF+ORscB1ltLpBjQbZAvMaf3sliR4WPQjGH6yFoQdwpidEAn9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146708; c=relaxed/simple;
	bh=gUKEX32dAm0NaSS25uwYkTFRf2Xym5x8Xif8iRTqhqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ekrf02XDNkzsjT9wQJ7CbiHvI8lqGIHtNl4ypAzv9ei5CA7qVWjRhVjMIneT4UvdISI2TDRsThjPsTUyvRhmrQI13FGcXt8kUIGA9chzKsVxn5DRMqKwo/kttXhpuwz7B44lPjE+s1lyDUVuRsmb97zPVV7bb+Aa9APAUYWi2LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=U24sDLE7; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A1AE1480058;
	Thu, 17 Oct 2024 06:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5Ramzeec9hZfCffzmZD1nPformGg/wTaqdAnD3G/hB2kPuwnqOZGYJLPNTlQZDxQXI06zLpxSQRHVDcX7cJriDbM1HLK/0RQCWcn6uXVm6pgsjEri95r8r45qa3HQ2rgTlJkj3eVF4cegTrh2G2qWIfLmi8Pb+CQSA53SH1oN2Z/A3HBlXo/S61MFbiThfKbIXo7SrWfPgoorRn+MZfOoHjMLWwnDqyuhnkKenR5Vmvy7ZNsuP5oUUyl4ohc94w7WL/alCxgzSr2cyH1azfR5NA3CNPTaNSnsxIANTogDC1V4RMCIwzK8yNJD4vYLAdAMM1c1j51Wy9yAGdm+8kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUKEX32dAm0NaSS25uwYkTFRf2Xym5x8Xif8iRTqhqQ=;
 b=E2RhAbgbLzdQSvDeb1w1GBDhODzlJq3YsnG847sKPuXA1jH9/P4/nvOYGH+n1IrxFpFtsuOgPpWgfapaVWQeJNYD38TZBqYQI6gQ0MoZ3y5GYHFbJImnfbMT9HUYfkcHQiH0p3G/thPcXWOMImcTe3jSYjNpCji4CaKGd8e7qUuCgtK09bFgDR3auNRpMx3oO56Ewtfyt2R6m7arFxAOJw7rFM237CLTDa9TdEN4t0OEhm86lW5xkFd5oVpVIFHO1c2VAXyJ+TJjn8sOrI+Hcd427XFFViIA3ryD8Q+3b7D7P5ph2+OVTiwT9AYNvHse9lWgNFoDyOIJNYkWvDFf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUKEX32dAm0NaSS25uwYkTFRf2Xym5x8Xif8iRTqhqQ=;
 b=U24sDLE7l1vGKyjv+fqLzZlhBjfudJj7poPwHtI7G3GzV1knc2EDSM6lLReJXXE0GVtG09eZHD+4LhjlmHU7B94Reu7QQeTl0pBS2o+6VrHqOfz5zjPKcl4A7yVBuFRWHQfQv7UpEgb5crDwl5kAlpXbfm4JZ3Rue0rZXUt6moE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB9695.eurprd08.prod.outlook.com (2603:10a6:20b:615::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 17 Oct
 2024 06:31:34 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 06:31:34 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v4 3/6] Convert neigh_* seq_file functions to use hlist
Date: Thu, 17 Oct 2024 06:31:26 +0000
Message-ID: <20241017063126.3890888-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241016205437.12812-1-kuniyu@amazon.com>
References: <20241016205437.12812-1-kuniyu@amazon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::21) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe6fbb4-d4d8-4257-f449-08dcee755850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8tMtIZ0O/kFoS7Y2GXCK5bJSut2gkl8VUDQjxGZco5cvU/WxIBBXKU0ldiy?=
 =?us-ascii?Q?rjgKO+6uwOLqXqNG9T5S4ez7F0BzDo5glhKFCYM3YRq86MAuT5Y5aquNcHSA?=
 =?us-ascii?Q?8TbOehJLlwbTZL1U8/q4SdEztJLswTyK0BvTSGnfpw/r8UdKZcNckI2GcbSp?=
 =?us-ascii?Q?R/ynGFLF2Emp+/Z5TNplyyr+JaFqrcT2rcHnexE37i+8PqUhU2AVI+kIL5I1?=
 =?us-ascii?Q?Ttj4iwh93avVToqnsLqzxjHmVqwplIZmE2pYwDLfO8pCNp4pxNcgmfKF16ck?=
 =?us-ascii?Q?WZEFHawIO4BlKH8Sdblt1abBTdCsgVjtF/kVCDnn4C4b63AYY8kPIP/4qVaT?=
 =?us-ascii?Q?k2XvN4MToeUZOAZPJl2+9qaFMwGWKxanujntZ39wo5iZ1NsJ0r8C2G5FTWnU?=
 =?us-ascii?Q?8v1cK7LQNTMQi0FT8XQTnUKRS/O+o53Surqgm9eH/6PsCl4+r4vzqjQkMJns?=
 =?us-ascii?Q?MkLKtmNlN4cJVJ4Mv5OXa1nQiRnTdiZo5CwaU3hijrRZFf9eWokqX9uP1ZgE?=
 =?us-ascii?Q?/SaVYxA5AsVj4p05DzAfUU4PVgx81w+RU3RGufWPxgNawL2CEnGUhZn7ymZW?=
 =?us-ascii?Q?OGK+ctZpiHDkJcVRSkjF0TEDofnQKH2bFx/IUnrctKoZzdWxew2ANWy58Qfb?=
 =?us-ascii?Q?2dGhAy8hpXTzVaxjHAfFfmM3GcXFLBO0N04x71kjoFEpx1U7xQpz+cTJb0l2?=
 =?us-ascii?Q?SuNYbV+H3i5b0kcWQdiuUIFMyt97mZ1ORgRE5vXm/rqp6YU68rbAc4piagBl?=
 =?us-ascii?Q?snHpcue0GLs+KNPbER2g8U4jB4pmCbt36KarXjW8Hn68vGhlMOxDstrgCFHR?=
 =?us-ascii?Q?X4uWo44JMWYOVunAQfZFpiFBv3cYCDo5FzB/P13OGIPzbqRx9hDiQlo8GiNb?=
 =?us-ascii?Q?CGMkCvxJcuXkHjflqRes1PyzgSIE1+BNQpCArTXNOPh6qDox2nHbDfehJuYA?=
 =?us-ascii?Q?KUdPolKDQ92saGtCdkCVztDwEee9up3QJihuqsOq6rNL/OHu7VnL7/PhP5Gm?=
 =?us-ascii?Q?bhZMWu918zcq3IrD+DCDC0DFpYL47Xs7DT3FWwhz/janPX+QnZpuIpAC0TiY?=
 =?us-ascii?Q?KB0Yv8LZifJLKFP3sekLuS2zT7RQTf5NphwRYl7gWBn6+zJcVVxsOawzjOA9?=
 =?us-ascii?Q?9ClvwNDtObbMCE2AEqCNJ4wOiN2cN5gxqIyIV6kORYJU2Piku3v25spRiEg4?=
 =?us-ascii?Q?qI6ALDzuJ4tME1MZ5u6ZE/ODMIbNg99EJB8q/NF2aBQaiugo/Vzhfh0SYvgX?=
 =?us-ascii?Q?N8L3qDKbvtF6sROlM7ZquxRydLEfTEo4FpJXJFd5JT2jvkd9RNmvPHO/QrVA?=
 =?us-ascii?Q?4cbg1qtHzFP7uw6y4FZ0W+lnNig46k2KUoV0FBNCFqPsH1jq14OMBLACHL+T?=
 =?us-ascii?Q?LjU9q2I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yfj0vWqIWBhtE8zBdY6Pef9NLmpw6vGdaDZJFlaPcFPi5NFnaMIMHaQuoiqC?=
 =?us-ascii?Q?uH3WzC8SkG+Ka7unNIJmA70hwizACpJ2OkbEC4ivl1ufpiUVqlq7yTJSe8CW?=
 =?us-ascii?Q?HGoGjpyVzUwEGKtXK4Ba6ZQYFjvZ/sO/yTak8SSWgWgZLL4YfGt2X666Gzyj?=
 =?us-ascii?Q?TULwMVoyesqqm8VmDT8cqwKrjUdEwnzNBTMw3RMjrki+66r9n7o7PI/490T4?=
 =?us-ascii?Q?9ZMboldWfnuhdrhp0VrRfUtXZibvWfhkszW3I/yOtZDdCm1NaIoWL5IN5vZK?=
 =?us-ascii?Q?1qgAVo0Bfm5p/gaqQcU2ZAixC9nRh7WWtF1L5mys5eIqVgDpTRsDCbstbBkr?=
 =?us-ascii?Q?SJBiO7BZYhCQypMZT2uz9lOPgRtYOx9XW6COhlhrATKoDMDH6c4YxUL9/Wqv?=
 =?us-ascii?Q?Mw8st/w0YUTVybM+heo7njmWjGV812OZVJzvuy561pPQqAaPNGhRYP21eIBd?=
 =?us-ascii?Q?RWqwwPjgkJ5PlwBCauzdGMR4LUeJJ5qRjzzdu93iBWgJxfmphfCQ6LNNo+N0?=
 =?us-ascii?Q?llmjaiYCjboxoJaL2szVbw+XhZR8dnK2+PsHqzkTzxc85LU4UCq9gxk8Qagm?=
 =?us-ascii?Q?SWnEQPJLYb5aSKnv0wOccX8Ti/opmlXy5oyF8eqUk84EMx2QFga7mo1ePG8U?=
 =?us-ascii?Q?Qhw7C/n/H3Vb2k7VMl2i9dUmTiIiteizOw12NaEcWS4/ImnakGXSj82TIxXQ?=
 =?us-ascii?Q?rlI/+6TeO33CVTraW+jBaIYTDcHYx97/2ZHmP0aFLKyd00/UCXbqpaP70Pck?=
 =?us-ascii?Q?TdPKy9UI51kz9MmxblpMGFseRGUPjopqdMbNYNa/1Pe6RflpGUkuQup8Tkhe?=
 =?us-ascii?Q?1k6MLhlhfi7xnTW8orJep8uf+9cLGjjgEMJ93oq/jTJmc39hR/fkaWor3c3R?=
 =?us-ascii?Q?60Ulc1i05oMvtf++F0U6XvdZ3RZ3udW2e6zaAedt69wkqradWDcCCVRP8Upd?=
 =?us-ascii?Q?diguYiRQaJc6zEvFgdUt/Dkz0M7UfXtds+VGtS7AQl58PAhzyE/wkXsbMHaf?=
 =?us-ascii?Q?1PVHRq1bmAkCfQjj79t6QNOHt1JdV2F5ZkJpWV/l4j3lAyMI5K2m0ZUast0i?=
 =?us-ascii?Q?+aPClHfHDlsKrj2Y185JEOua3IoFvqvg7Ap/vOxHU1g1iG0lKNoPI/Lh9CcY?=
 =?us-ascii?Q?ipPKRSCIXDiOv8vveYuLCvobQ6aFlrHmqNLSS/eEXqgOAcO1G5Ca/3tYEUIK?=
 =?us-ascii?Q?AsfNNTFSisTQcicRFf4uaQjzABPuRfR0Ua/ktcGNcyZnDSttdcRNj33ROcku?=
 =?us-ascii?Q?7pfTaUzkVcW+9r2QAoDuIpEDKyXlN43v8uY5E8UMogJoCeGNBh0NfhvrFsar?=
 =?us-ascii?Q?QYCEYXYqzWu1EJOKsXpLAqecMIDJ2aOyWRlMS5feA0gRynD7zhSf/orhaJR+?=
 =?us-ascii?Q?GelQhO/OsaNXa1Loue6hl61wdhNU9xJe7d3dKD/buzUkz7iec+If7WRXf845?=
 =?us-ascii?Q?BQ7DJQYI5D/ZIgA1VnQHQA1K8tW9XkHu1LiQIfSUil+Fn/kKJBKreCEehYVu?=
 =?us-ascii?Q?ZSZIzjxrt911JeMNP3GO+FMH4jDjppT2yN+cQSlC6/feBKUSNmTVYxB+/sNj?=
 =?us-ascii?Q?vd8stonOancPgCrcL5+JYoYn5RgU8qeruVxEOOz9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gSaIrAWG0m5FoqMKxPRcKMq0RPL2GrrnyqRQfx0c09umlLSHawVQoXCsU/WuWgPQAYpQoNtxWvuwRT1GpUz6fDunwnZWoolyBPa4OSyZKmSjaKXVEH4ZTjhzW6qVHN1HUOjO76oc2vUFArQdUr4vtAnE3gv0zooSoukP7hIxNCIuNXJr8q+0x8FPfW47Gzk8fl9tDcFRXcDKPuLtqLwE6n+HpN5+ZxuzcWkf93Hgf7yi1dA8eRmUIEw1yWzaQIu2PUgUuf2i9RlWttzv0VSEMmesK+bc1sqQCJO9DiQq1jq+wv8mdTemKqTqD1R5NcvzTccENKIoU9jChcJGDnBoJzyn8ifrB+BtKsrO+eDFSgVTwf9ypelrTXRgRKeA2EoW2zO6fryCfddk85Q2crrbujZLlzS8wwQcxIqYB2o3p5hBk3j3NldWjtvtbntt2f7+f+I2eFHrY5yZEvOwPr4l+fYqLlMKpJMZGSsaUMwnTy/U4BeOkXaBB/TZj4dF0uRIri8rrNJkGdSaH+YhNjKU4ci5rXgacD07Ph1oSr20OBWFpl7nT14NJAe8MSBDI46htj4jPa8eHBKu40Y3pbdWuxy/OlG3+TqXPkpBcrbOKWECxpTtUDfis9CDrYqXbDKi
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe6fbb4-d4d8-4257-f449-08dcee755850
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:31:34.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzjJjO23NtanXJBvf+sE63wQfLtznRT+2GHoWhwYBPrG1QSuyQceDXRF/HR8aI1hO45udL7l2PfYLi1p0k4R9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9695
X-MDID: 1729146699-M4owFtmQ-hHy
X-MDID-O:
 eu1;ams;1729146699;M4owFtmQ-hHy;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;


> How about factorising the operations inside loops and use
> hlist_for_each_entry_continue() and call neigh_get_first()
> in neigh_get_next() ?

Yes, this works.
(Just had to initialize buckets to `-1` since `neigh_get_first` always
advances it, and otherwise the first bucket would have been skipped)

