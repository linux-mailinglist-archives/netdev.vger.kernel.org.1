Return-Path: <netdev+bounces-152840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C109F5EF7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 07:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECB4188DDBD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 06:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF515574E;
	Wed, 18 Dec 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="mmLaetpE"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5B14D439
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505098; cv=fail; b=DQzQ1ytCKpkWuQoMR2q594bPx3nINihxEM4BE7EnjbGckUMYSe0Ek6M1PNqe/2peSeF+AeOKgfHUyZZCTJwF0QWqMlf9xtH19axBA2/DT11TxgWG5h9joiQtrZwhvYNZO5Uu1pcHh2O6mvqDWL4q4m2XPwCE+/kVQo37oBYG4RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505098; c=relaxed/simple;
	bh=C0CmF7MyMA2Zl9fwbD11SlLPEs/WimihHM0S5u3Rn58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3acH5XTyD7n9GLE9oo5LVl7RkcIbs4zjbaxmWZ4tlwUoe+ys2wLs9PlK6cMgmHmAMbPk+ataNmpM9VzHfXBzowadbz6Adh2QqsQgJ5jpt4SWjHEFAfMjpLhmAgiIwjuZnDKKDp1aCBHKKIK0Gm+KI3RkxZl82TSqwOACsvkKYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=mmLaetpE; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DF47C24124F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:58:08 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 52EC1B0006C;
	Wed, 18 Dec 2024 06:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee+mz8oQquYBZmi8VJ9vuP31chxFGM211xJUA908Ut1T7aU7yy7ztQ4JmQ0P4N+CPQCU/Jva7+NziRL+6/XM8uFBQr5AM3FPf3fW1OBVgjTsgetVmgx+WwxAymDkBBT4AvNrDqcWk7oQ1S9xUjJ8VtzV0yDs1T8qE9BYFvWlGevPAfCbhdxUkhLd/2tHaDyHn+Afr9wdDWbb7gPLmRV9obx1M9xykS0THUR/StGTqFg1nh83tvD5xkykmUHT8Vxfd8c6rSIrAjp87quC1SNkZFVlDTjJ/UWwuXWn1laT5aQnltXj7/0qYxDJkIuRKST4PlnPhsMf9sy5DDz4bJF1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeS4oLdL3G2cItiGZWPvn5IXmuNfAZatjB1W71bFkaM=;
 b=RlbPm080kBnYmKmN21Z07vLHxqukPLD5wEsVd9OQn8ewkoIa4Y8WulQ9RJA0U4EfqJxqv4KFQRREC6LZf2xq23nkOo/JkEIwx34WZZ5En6NRTQk2Dyw8gGQM416HjQqgsm709UT8fuugbBLIiSD0lqkawxtYjQNxYCg68d3Z0Tj4XsCtCgBEqnlFOb8f7fdehEi17nlP0X0xDmpLanV3O/1sZOwN6ddTIeqPMY0VpJXM7CzCAgWl41DrS98hCg7M/S2QtOXeW1MFftvGnpUTEZuaof4/O9QwsTNTuLG170dZDJnf29eYwL7IcFZ4JVRkYYT9GzKcoefq5p8xIdF8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeS4oLdL3G2cItiGZWPvn5IXmuNfAZatjB1W71bFkaM=;
 b=mmLaetpEjHcV1NzMkG8WEV2CI2hcSqjNA5nbfnt8/mH5k6ibZjflHnffZlczeWaIcf2o7Sv+fYj61l0q6tLconRKUH8rMIeyy4xRI2xnywg6vHQSEv+Bw/0XipnV8cQb2scu6NCf++UmSGrweML2c6e6gduuIxKqnbUfDraH10o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PAWPR08MB11143.eurprd08.prod.outlook.com (2603:10a6:102:46e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 06:57:57 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 06:57:57 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	gnaaman@drivenets.com,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] Do not invoke addrconf_verify_rtnl unnecessarily
Date: Wed, 18 Dec 2024 06:57:44 +0000
Message-Id: <20241218065744.4063286-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bdf0eec2-e168-48f7-9fdf-178cce4ee18b@redhat.com>
References: <bdf0eec2-e168-48f7-9fdf-178cce4ee18b@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PAWPR08MB11143:EE_
X-MS-Office365-Filtering-Correlation-Id: 729c5493-5c57-4681-548e-08dd1f314d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NbhB29ICzyd5NXMuc3gO6dNtMXuNJv3SVtQ9IGZaFEBMemlPCIEPsnGqbcrZ?=
 =?us-ascii?Q?Dwtl2HZX/Bzt2aY/GSKVMjoMHUWnaQPkP/fv9DJ81PRKVmzAuIt6ohiQJPC5?=
 =?us-ascii?Q?JfP/DrUf8TZ07TAzvb7r1qF1npMh7cjhKLnJ0cf6WF7aciGbhwJI4TvrTqbO?=
 =?us-ascii?Q?nZGzSH7bBHnQhEL/et4Aoz7WLM9TspRAL7AvOC27m+W0PMVms7MSRx0GBIAE?=
 =?us-ascii?Q?vXT6XME3xD9gfIyvkQhC6ec5750ThfW7JOgna0lE5VPDdmXAeEUii8BzEsNF?=
 =?us-ascii?Q?u+B6DJEWxBifreirF5mr3YKIgBxkm2HfWDM+DnSXhAnTF4gm6/qM39hivn+g?=
 =?us-ascii?Q?uxmVp9JWIZuOhQYGW8BDAobhOJfLIHMORKYPTpSra++MyIPNeCSOfdQ0Vl3I?=
 =?us-ascii?Q?4xqWncJmf0BJb6jTXJLbIESW6KN61J6l0k+L7li9G4hldIEG4Ov8qzjhO7gf?=
 =?us-ascii?Q?HpyVGwN5pBgQUplyTwsWZmeDXEaf4dmRRJ7yCslgIOpAby71palapyGqtRjg?=
 =?us-ascii?Q?LWWJNyhFkY1BoRSxfn/eAGkHKIylvwbyV4cWI+VPphnO8QCYqQ4r4ZOrdW5a?=
 =?us-ascii?Q?rtgGuMiPLYijG8yC7uOy0F32WuT6S5nrwtHzJHnIRwBzlDA3MXr5sjI2vhdF?=
 =?us-ascii?Q?V04hOB57EIVeKVxhlpvrhqEEukB44hzd8BthDGmVytJ6oK4E2gkOWqMH0NlN?=
 =?us-ascii?Q?/LWPeD4fsUlsN1k4zpbdroGzHqxBhbORRcso9DZLVYVXEEFZGf4p/t029+7t?=
 =?us-ascii?Q?edeCvlR0PVZlHkvKaKWl92UZhMYEPpgNrr6w1oLsIZUGABtX4pG8/IdlJk+a?=
 =?us-ascii?Q?oK5QJ3eCicQgWjiaNQ7Em3N4eK4irtFkbI7FPx0j0r0n0gzbQ5p9YVIu7UMa?=
 =?us-ascii?Q?cvDRVcb9TkW61npvPcoKia//FcSYEM0/xc0DS68XNTg4sR+5gkG15Mnday2s?=
 =?us-ascii?Q?BHHTzfaEVV5wadXU5bzJAITcDmeFgXEVjdu70dZxOF2RdSs+jJgcljr/B5kG?=
 =?us-ascii?Q?yHcfQ7MdIOPlwprmj6JVLNTHbVfR/7UdDF/DkL7ZkzRGMuYKvlwrwgLeNN68?=
 =?us-ascii?Q?tXHacEqPxRvAQi2TVhP0Tk1pieb0Mh4C2R01/uMYxb49HZCYlpy2C52EIe8U?=
 =?us-ascii?Q?3dpmgPuUQpdFzJtLXbDBL7FSy9rMOZjVtJI5r0YXl36RWDj64hjK04cjMX10?=
 =?us-ascii?Q?rwmjgW3r5iqRC2UbgpxU6zTsw6nZ0MQDmPpcDdeUszXcHOjq87uRMbPFXMbS?=
 =?us-ascii?Q?WHQqifhc4ONpCEO0OojfgJNPuk4ztPnmVJzkELZYRzXwIxZCOtFjX9kv/X0b?=
 =?us-ascii?Q?dJ054YXWoRC/8zGFV9fbjNpNSOuBH2mZaRdBOzPqLAziSzcPuuUeFnoI5Gb0?=
 =?us-ascii?Q?gqcxNbPZJPp7CQEAu0e5U9fHWxIaSqgUBiUA1180JcTukGjA3rthoIYtjfqp?=
 =?us-ascii?Q?qPQlabHPUt8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+eOno3D1hY1MBH51kGR8407EltHTr302p01OFyg7/RNWE32o4H1l+UZMiGka?=
 =?us-ascii?Q?5HCZ9V99zmrCI2Ifttonq9JHtjnbWQKddWb8OWyqpmirAd3V4jEEP0IQwtfv?=
 =?us-ascii?Q?5r99DU7JWNg9Ewk5/Bq1JlXqxNttL7hZG73/gcZPwx2CiRIVVDB3qHgIVoLD?=
 =?us-ascii?Q?GOUpIFb/e8exdKISl9I7+wPbp5+3zcosbAB8WZ4vmwecWMUGRx2s9rInVLbq?=
 =?us-ascii?Q?d9OUjE6niO/1claySujNuQqTbWx8w9RS8xvoAzKMZNJN4XMUPuhyAugCE+q6?=
 =?us-ascii?Q?5NXWu7iMzY09w+ZUXQ4RmEEP6khVbvgfTTqLlQrcKMrN0T7bOIAQ5kRq9spB?=
 =?us-ascii?Q?gf/Sv7vYX0sg1dh8wQfmxga2aw7UB79c6+XdKBN2QvFhdhnG0FnNZA1csA79?=
 =?us-ascii?Q?QCg4IKU4bOPuXIel3anhHMxtJSRcfQSRyqu4WqB0drHR+h6zJBriWWUlpoyZ?=
 =?us-ascii?Q?waE8+JjJIc8ztW4xXNwMBW8zg6LkYTTye/Cw2/96T3IkibZBs7jwgMPTEJwq?=
 =?us-ascii?Q?VPzyDXQKj9dcG7W7y5vsv5VyarkqzlCIyv5StwJTGz+veYBjXSNlQdGZ4SKA?=
 =?us-ascii?Q?xXZdPHl/VsCf9y89bBJf31KjrGIE0cHe9PKf0I82522RneD820YbzEtvg5xL?=
 =?us-ascii?Q?AoAMbA8EHJUFSS149KtEqF8hN5tQYihK8qx0XzYrMnStDCgGfXO5obv/47UK?=
 =?us-ascii?Q?jDFl4tc3LM2K+84tIxqzdlJGnf9H3K8HU9kx5hmfpSUrOfRScqHPEPwBvuEs?=
 =?us-ascii?Q?qgswJtkS9jRg1jZxksr3dPjd2v6bumm3cSkh8ZNkB2gyYvXdQtvinjWR8D2G?=
 =?us-ascii?Q?VBBL8kycxEBnBVfd97jYH/0hnn6m/W1qtVmjs+gYRdhR9IB5npYGKCsmK7oO?=
 =?us-ascii?Q?S70+LglV48AhdGikgIYOcyMzJATZpSk4vUYmoTvugsDHbBGCS7zAZUg9b0UD?=
 =?us-ascii?Q?liWjcMWFsap/hrGenfzKllihWB/vCls+aCWMkcX4jH7X1aRJizmlHfbsPaWr?=
 =?us-ascii?Q?f96bzA7uHFYcLVodJ2VHxlUhGmud5I8RkrtCi7PIhkha+7B9rYrw6LshB6mq?=
 =?us-ascii?Q?jXj2HutuVPMQilMr6ATsIgjGXE2q8NPLRsu+TEZ70wvkrJAgQiE84G+B3uJX?=
 =?us-ascii?Q?iveKI1gj6CvO1sjc719biZ4flCmPxgX0hwkCTXEPLf53bi9R26CkHlIJwaPl?=
 =?us-ascii?Q?pZJCyYFbX0FkvKeVl67cL0QA9AX0evWQRfnftJkPJCy3ZlmzqU0TGtWop/+g?=
 =?us-ascii?Q?YLNxxYNmWIBXdjLNHW63Hg+GL7jo6mFGrBK1IRrmwSeDegbiSlRpRhCKOqDb?=
 =?us-ascii?Q?lj4z8lLxUzKgS95xWAiCsffb8Su1CuM/9Hd3ClzMTX2wgK2oLaZ6R23JCz01?=
 =?us-ascii?Q?GiCY4LWL5hCfVrQKydGMH4g1B+vXnOCwzdraxLixkj/xvylpYYMbSqQ9DrAt?=
 =?us-ascii?Q?9E+CX9cBKvgtFUTYN8SUQ7ePFx/an70KZw/AhbIbCV1monloFMWPNGSXFplH?=
 =?us-ascii?Q?Em95bgA6klX3nFMRGrR+KvqLZNM6Yw3vLLUdk2gfy5XBqQ697h7AWQCbBdIl?=
 =?us-ascii?Q?A1KybTd7rIidynptCZW/zJFzX3zD4I2M8X5S8LtC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UF8AKIRNcm+XWtXdSuGjyPlv784Lj5coLZzC879W+dnFdC5U46isCWhP2w5JZ/0FEeN4Cv7He/sONTAlyZEUgm6J2W+JFBUqoXmEqyb8fpSuwSxJOxIj5hdSxju/eAIKZn/om74ZgeptWV1UJRWGzGbWnS7BMV5wJS7nmFKKuzaWVgplm9vbKvMYMmMhzUVBxjDxsK0XX1Ltv6cyPztfLrUPDWNIR6JT7YrG0SifhmYc5Y1nD60baH81EOgIC/4p0/d65EUcjhs2YgO+iJYVHcraIw0lDD/XBP4qaMYVNpf0jAJIASlYIXRnr6H1UmX003mgEKNfy1JVIBo7F9CyC6KmNuBPHqA7VP37xgYx4uC5a/G550AtAOUA1byQlGBAJdG6ANSeEvBALkmT2MsLJ5iNgiZHVzOsP8lW8yB9lXzbkzvTg88vixkKlmHRAcdW3rlwMYKYwcbKOFPF0XJGobcXcgfpbiUBlvsq0MsbGKAIqLkidMDJ9gBnB/vFvj9c25cpGdMQtE7HLlKg4RQtsdfY6KJd0tejzPB2sXf5wVdAKvU6s5TyLkVhovDybKrY0UjQ/CmppIKXOmb1TfyldTLIO0k8/5vr2jF1zeX9uC+BrhxS3iJMxNprCAeZKa23
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729c5493-5c57-4681-548e-08dd1f314d29
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 06:57:57.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rxGGOPUN2fIO6Ym3+c6iq5wZvYxKwqmQSgJcMgJFGV5SyenbvoFL/oW+cJV/Vz8clDLQKMpbL20TDFIE5jtSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11143
X-MDID: 1734505080-HJE4EGXpQRiQ
X-MDID-O:
 eu1;fra;1734505080;HJE4EGXpQRiQ;<gnaaman@drivenets.com>;489d0494e21146abff88c0d96984588f
X-PPE-TRUSTED: V=1;DIR=OUT;

> >>> But calling "verify" immediately will result in a performance hit when
> >>> deleting many addresses.
> >>
> >> Since this is about (control plane) performances, please include the
> >> relevant test details (or even better, please add a small/fast self-test
> >> covering the use-case).
> > 
> > Is it common to add scale-test to selftests?
> 
> AFAIK, not common at all. Note that the argument "so self-test for this
> kind of thing" is actually a very good argument to add a self-tests.

Sorry, I didn't mean to present it as an argument.
I wanted a clarification if you inteded me to write a self-test to check
functionality, or performance.

And if the latter, what are we going to set as the pass-criteria for the test,
seeing that the test may run on variety of hardwares/VMs.

No objection to writing it, of course.

> > (In our original bug the VLANs were deleted, it is just easier to perf
> > one iproute command if it's a flush)
> 
> Nice, so you already have the test infra ready :)
Wouldn't call it a test infra ^^', I have a script that calls `ip` in a loop.

Thanks,
Gilad

