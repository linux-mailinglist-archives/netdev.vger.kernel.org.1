Return-Path: <netdev+bounces-257844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ulAhCN+1iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A69461095D5
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E68F3016928
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BE34A79D;
	Sun,  8 Feb 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rU+1lGQz"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038827A10F;
	Sun,  8 Feb 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567060; cv=fail; b=JI0DnhGuQl4ievBpu5k6RFhtq3Z2Dw6Q+qDsHNkNEs/YjeRNjwrbiobEx0HgJWJD4iKA6zoT89v5IvHGk3tdb7vSrHC29hnG6/Oj/eygyC39VUat3LrvIrOXlk9Bo3rIh4ju6xN8UmZP8zxNV1RTya2LwnFj41Smarqwjh0xYw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567060; c=relaxed/simple;
	bh=/ovAvbdSTZL69qsiLLTVXK/eUVbneCdCMuFyG+bHQqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xqc+F1mLo+fGAite287fLlsyocfDs471AE70tv67g41QcRr3O8rV7dNr9ToDKciMxs7wWJ/DwuzfZ5cqLzKDb8EOyS6PSXY8mGEUTwI4BeVb2AQs+2Sl7w1E3Jktla0H/IKJ8avffqcQzIDAvTF72fVIleRpq2Rx+XVwU+Jj0vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rU+1lGQz reason="signature verification failed"; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmalnCLyX6qq5JvujO2ABkqhZtTjV5iRRaBbkaUJtd0GN+EcBGcLgaPZQVgZr4xFoDkQAdRu45499tlWcSp1kJO+jlnXZxgWep9fRy/vOOTFjwC43RlbiJmH1oASruMxw3c6x6WbTOdxbgj2nG0WFfyZDfkHlZtRHEDI0XevIj7hVAHMb83YnDynals285mnxBCNiQqXCAx8tQzPwyTMAQ0m5tm9unwk6fCeEJBqCMgS8LOd3eqcWTQpP0hCuaDl2vjFKAqUVVuTtsd68phehTvHKiGOfL8Jhywb9kh/kScmn4ydRVmIPar7Qc8J84quYogPvM7ubo2YhuTThgMtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toZCGJr+1BYnDCCo9lIZIz++6nfNZu+HA4x40+UmufA=;
 b=pgW0mV02h/3P96SEwJJURvDgQXhDJSPzIM83ILk4J59tS05asuHepo2TwE350XD2Qf+I8SguZEI82eSPsfp9j2zym+dUXS2iA7Rf+Vsmv1kC1pVWNuKz8yY4DVOo0ENccY3Dner4JZj4xxxsCEGD2DPZLl1Cr3jH9UH0fPWaZdhc4P84Jo1TnAOY+EKRjI8HePn5Ancsl896Wug8h0YrvqLD+DldgNgkOVzxBeeVKrk27UtnJ98I/oB/JAQ2aM2SjenbMQ9Yj82Hhu2SRiE5RPcQmI4MG3+ZGG8ANeH/87+9+mCJ1TJJSluisLbUOqMEcGriRvE+wBOGDm8e8e6Ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toZCGJr+1BYnDCCo9lIZIz++6nfNZu+HA4x40+UmufA=;
 b=rU+1lGQzNJadNC0SLEhS6X4X643otCutbHB+3OWcL4RyoSoT+DvBwko+ckzKeXuLtwiPmtAv+hdJ2WF6IRAWtL7sfIA6arQtqWVTNGj0MQN4rEEKLfaI7AubmONP9lWd1ZtKILHkgcUaSjRC7eiNhyCA1dlpwjoIZujVTwhKHSQrGaRk0xayc3dgsec8wNT5CC+hoEG95DMe5gBXBRUjos9XwpdYWUIm9NyHURfcmxhh/FDFy1n9ShhoBIdytw3VLXzunhIITo3w8leGckvnt58NCKabz9NHC8+IHjMpN5O/ZcrmJIgwot0xLQYoMateWimti8g4O7hT979JW6pDQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:10:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:10:57 +0000
Date: Sun, 8 Feb 2026 18:10:48 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 10/14] net: bridge: mcast: track active
 state, bridge up/down
Message-ID: <20260208161048.GJ154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-11-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-11-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7bd3ac-b44c-4ec2-be95-08de672ca4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?k8wFF7dx67Jj0zJo7w3q+vbxAwHHVYSq83fJWqHl89MohBkEk/4UVJlHV2?=
 =?iso-8859-1?Q?a7uDX3RgMNoRB8CYCXtB3TY0OPj30k+jen0K+phOQmPTMe6E9ji344kqW8?=
 =?iso-8859-1?Q?/zcclO1q/OFKRyqp5h+CH/9kIwdRR2AP2qKaqj5XgNNIe7IhTztiXSuoYK?=
 =?iso-8859-1?Q?wM+A6hE/uMmOsjXExrcPz8THVbDgplP2StjctYmTwMLkFSZrrj61Uamw70?=
 =?iso-8859-1?Q?YlujHuQOhL8y6NDKorRWJUyrN2jzrnvACuF+LZVsctdOxnWwhfIUf6Omta?=
 =?iso-8859-1?Q?PWdaPj0Qx/cJX4fbCtED2jxTgjY8ZW3/AorQDzMYp19wqz4f3qG4yLP3gy?=
 =?iso-8859-1?Q?Ay1Te00urh0iAdlyO5t55Jlkv9o9jn1hFy7P6YhUf+mpGg5pHmungkPucF?=
 =?iso-8859-1?Q?wIbyH5A0rKfmncJqn3F//1/D/xonNsRpa24PUvNwXwMWk36eNOolRZcERw?=
 =?iso-8859-1?Q?GiwJr5/MsEPXfdOd1TbD8ZD1mSz0wV6IZFWVUFtQQcwdKLKuhwaYRJrBZH?=
 =?iso-8859-1?Q?Ot4oYiQ1kBP/RhNAdx8carYlD0Xfu9MTmQVNPcUxIUkwtMPpHFXNoFKiEI?=
 =?iso-8859-1?Q?Nv+ICQryzQX1NDW2kdalg2/cv5B+GgjgfbTGjltlCsJLCsMuZhYUULFPO/?=
 =?iso-8859-1?Q?M2a4yfwEVqUqB0VMNT3myepcDajTA8jzweh2w6MEFT7FPPfjp+V5A6rUqk?=
 =?iso-8859-1?Q?SnPziDtnjYF2XIrVfoUilmE4D/MTizZZcLv83c3kLWtYcSdsrei9dwSGQ/?=
 =?iso-8859-1?Q?hCH9phb0HDZWor781GofOSsXLjLoIg2YQKjgjHfI0bi9fdovZ5lWhAxt1i?=
 =?iso-8859-1?Q?WUO//RUl6yH9rEcg+fTPblGPxDCxpIaPOqXE8UXR0po8ltxuYWXXpriFbs?=
 =?iso-8859-1?Q?ayvU0fBHYs2Kk2J0q4KPInaQUqLqvdjVLl2Dtx7yU8iA75YsFYaOa63+WY?=
 =?iso-8859-1?Q?FNM7kBAzygMUPYQJ/qEOxZ62k6prYqKCGgKaFyThy11iu80oMI7YMkuw37?=
 =?iso-8859-1?Q?FR1HQm1bn4YZaXMab/2oeB1LSe2XxFZz1630hXg+m+SDqtRVT+oiJuu4mO?=
 =?iso-8859-1?Q?ySTaATVBU88KXga0NjGJdPuOMlWqCjSXN16bqi5Duz0gmKOf1tMJCA5Z/L?=
 =?iso-8859-1?Q?nGMo7QlRKVIcqCnYsa0D/SGXGVu4iz/o/0xnQy4HJSNZsjjIgjqDhXB5Kq?=
 =?iso-8859-1?Q?N5g33Fi1KyI3eUeE2fyfwirq1sTvb8cflGmY6bapIu5D7HkwGYBh9fH/yJ?=
 =?iso-8859-1?Q?N16dJL8QeGRDele6si1Q4yjbNUhWAsqLrsVqlrBS6UO0752oL7PuzrNody?=
 =?iso-8859-1?Q?8x2tUx9V1WEriQcSd+Xo1+DigVsyZy5sIlUfUmLnXASxU/nS6xZ/aAead1?=
 =?iso-8859-1?Q?xFws5OU282sy9XlAg50Bc5SjWLe79/ITGkcYgYUxsmZqBbvyMBwPfUNFK3?=
 =?iso-8859-1?Q?5RQ71feNLVQwYazF2XgjzaWNEMa38KXnWliUTjHRSCvikMTePeVNChIEm3?=
 =?iso-8859-1?Q?4tf88wjECpEj85oiT76lt378dWMGZ539/Y0NSG/DlcO+xY3RKkQm5GK11f?=
 =?iso-8859-1?Q?2uMi9sTgYHZ/H0yzOUR0NSCr8vynGGWgr3Fxny76W7cihMo95y1eUdvjp+?=
 =?iso-8859-1?Q?7nxNQe9gRYiv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kavcBeI9O2rcw1OTh7AFu1LaxdRw9TvPDGEuEF1HLtjPI3njrKuDyLAgjH?=
 =?iso-8859-1?Q?hc71Iv2sPevlYF9/wow0dMB/rCvdyn1t/lrRgsRXJfcZe5DPcS1wbqLHAi?=
 =?iso-8859-1?Q?BhIqxPYIoroxYk3o35LFgrjPzui6N6ydIP41SVnABUrW55qarUo2O/+r43?=
 =?iso-8859-1?Q?AThAQHTZGemCpoy8yM3z+Y7+X+yxPSNU7DZSk7r7u3jXIKzRdVT1C3HJVo?=
 =?iso-8859-1?Q?eZu06so71adJtEpOGMgFLmWBhGkhEszzatlAcDVSloUJEKHdBIlOEm8FZm?=
 =?iso-8859-1?Q?YbqA/3dRsWj+NBbNVzUvOl5YZmn/kHYOzZygxhN9ZPo+pIslYTYAOol+d4?=
 =?iso-8859-1?Q?u6ntu0j8s4GM8XZ+W+zLjXj3YBsUtVZLa5LBDFVsMHLyiX74u1wF91S3os?=
 =?iso-8859-1?Q?fdduZ3yw8+5l7Gce3KcbltsRAfRo3RtBohtE376kCZHIcPpJcrhZyHxGV6?=
 =?iso-8859-1?Q?WNic50HBq9iAkTc4KD/XqFXk9MsOVczrt//ewCIhmp29RLVQRYtIm+Q2iG?=
 =?iso-8859-1?Q?sRFwzYmWG7reDrb4y51qK+5Hb+nuq2ShWxqaVDdtrs598rghmI8BgFaATy?=
 =?iso-8859-1?Q?e9RZCHs2KbRnpoXkCQtQZLzTh/wPfUIdLpEybJDl5Z7URif/526WPN+l1a?=
 =?iso-8859-1?Q?EKv2QTyM4WHJSGtyQD5zbk2ilADkTl9zuTaVdBnwKiZzUVWI/EmSMqmRbb?=
 =?iso-8859-1?Q?FmL4P47zslinG7ksWlkL4uWfTAfKkcUZHyVvPtSEC7kV8fbUhebbdnv3K1?=
 =?iso-8859-1?Q?R5ceFudDeIXu/ZOPKdQGGtQoMBocbIlYlAY4DJ3xC4HNxgVoQDMEm50pBr?=
 =?iso-8859-1?Q?ExDS6ko5XQvOmd2zztpEuw1U4EoeZzMd+KTQ/A4bQy1cNMoP0svEizp5oY?=
 =?iso-8859-1?Q?DVRkB9jc/LLXpkHHJa0hPbfUrfQ9NVSA9O0ZzjMxUOOYJsq3dOIHGBXrii?=
 =?iso-8859-1?Q?5MsCQnRfoEqQzkBwCCyRlGxU6pNywqj8Wcs7oWMxqlua4XJamcgHXZv/Jh?=
 =?iso-8859-1?Q?N3AL4vyBWl6jZr+Fw8+WeKAn/UmiZjjgiLv+UeEKXHtgsnOJQxcfCoBYAw?=
 =?iso-8859-1?Q?Mx4w+xyxjQMXJG1Jao4CDPT4Kx21V4fNuVl5HgOkcFnDviXDTaei5LNrH1?=
 =?iso-8859-1?Q?9OSfqBVcUFQOXQBvCwDptUs62SVFtlPe9QGBwpEWEELT/xJ/uYU1vCF81a?=
 =?iso-8859-1?Q?A0guOSmuzHM6mWN2JgndXomzmKeKPyqpiV/ZdzOrKmQ/FLZhvNv3CZMq2k?=
 =?iso-8859-1?Q?2D0/Nqd30JmrnCucmTyZCabOF3Fs9gER5TBewkzmVbBhp/gnGbdXxjYFur?=
 =?iso-8859-1?Q?xXcnQwujkHB6+XJHdfpZh507JUZiK+ZzfRl6pnmk8DwHW2Zm9I6YHF+ARz?=
 =?iso-8859-1?Q?5fC4ToVpSrOwdZkmJR4iPQWenOUcokaKJofgYxiKj2JKXeooT6faPe0fuT?=
 =?iso-8859-1?Q?/+MccHd7hIMa0uEj7DTbS5NmbGRoPxOtn8TJrP7pdCJxyphebh72IxaWkD?=
 =?iso-8859-1?Q?677gFOXjc8GRl0bq6M8kvGDKc3JAisFS/FPxrD28mjo5qFpq+CNTbsMYPI?=
 =?iso-8859-1?Q?alj/IdSeO/Y1WP2ve1gvFnbGe8lNl7ajpGXXUqt9gQo5EFuuTY8PfdlAyO?=
 =?iso-8859-1?Q?p3FHcyeQk2Fu8u4IDwxCXkv5+097YE54zhgIXUPduFb9XrXosBhRVNsTnD?=
 =?iso-8859-1?Q?3AFt6HFhCvb3vWUGFwV4cp+/RuWtcdVAG+/cyklGC044z6DeGBKvCqXjw1?=
 =?iso-8859-1?Q?CEBy7eC4C8c5B24fZu+6KGqVQK+80IY93I3ocQLgPT6fxakavlC22aLVS2?=
 =?iso-8859-1?Q?A5rJLhNAUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7bd3ac-b44c-4ec2-be95-08de672ca4fa
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:10:57.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4GVLc8SZROCyG+wwCUC9bNzxur+TE4FmZ16RiQv/i7+MXdxI/sfzjwOV9OIJPKDjGKqY7w2AAD2PGUF2oEwMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: A69461095D5
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:16AM +0100, Linus Lüssing wrote:
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 2a2f54009e0f..7a32c6bed111 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1124,6 +1124,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
>   *
>   * The multicast active state is set, per protocol family, if:
>   *
> + * - the bridge interface is up
>   * - multicast snooping is enabled
>   * - an IGMP/MLD querier is present
>   * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
> @@ -1140,6 +1141,9 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
>  
>  	lockdep_assert_held_once(&brmctx->br->multicast_lock);
>  
> +	if (!netif_running(brmctx->br->dev))
> +		force_inactive = true;
> +

Same comment as before. Let's skip unnecessary checks

>  	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
>  		force_inactive = true;

