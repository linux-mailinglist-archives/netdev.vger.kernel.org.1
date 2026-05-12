Return-Path: <netdev+bounces-287211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDZmIrdBA2oy2QEAu9opvQ
	(envelope-from <netdev+bounces-287211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:05:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 224EB523405
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3C9A301EB41
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B83750BC;
	Tue, 12 May 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rymft1e3"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5136A371;
	Tue, 12 May 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598090; cv=fail; b=QkOf1LObX07oYNBAUVpqXBbvv+BlwMLVK2fG4rXZMsZ9LYomt+iJvkieOUActaFO3yfaFMwnawDLeY3YezKp+WkZ1i1mO+4fBhapFK+Qck3BeW2BL4qJ5NOFNpF3VlFG+JLJ8MdP/HyMMwZ76r3rxZpP8xulV9Er6/ZYZKcePHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598090; c=relaxed/simple;
	bh=T73M58TWX0bNWIgzgL2Dc9JsD86+fh12TR2Ni5Qw4pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L0TARWAC9CyBrTM8s7TKD+GNPLY3j8N+fZ189+HfugbH1aYNZ8uKGUsBOa1MaxxEdZRZPRJiVxzFo079EAzGDGDFSa0h+3oR59MXsgvU11+oOnDcdQMCxTF3a/vDnsFUuTJqHkcntZYFLwZ/VpRKQQt05i/J1+MFKHASx0wXsL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rymft1e3; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwbjaqnI6sVfiQ4UW2GR5vsaxrCLMGvv4gWooEYKWKfpx+MueiWsgcvLJs7cOi7ASkoFUXuIipWETKDPZ2KbVVpxCabf/Ami247ImHhxZvawayDrexo6JbfFErXk7KoEGaZkSXy6e/dvqyAowUZfKoCpus/8R4JCUfuw9ewcVZJ0mgo+fEmBNbQhchAWU3g/8ZHkjZ6ZUKdXgtFr0QJQmr5WvZgPVNA0GgJY//7+9qXXiFIli6B9iROoXibr9mroRrZsM7N9l9EdO3BHAD7o6rT4TnLOj7DXgi7KWyhgUaWKJUX2H6tEeXWFKO9P74Fk8mPmYAVzUm/70lu/hijyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLsmmg8ITcOWVR3fX1GW6lTAyDi3UrSpWBVHPYESMy8=;
 b=o7undTYFE3xisenqkUuf1nDkLiqMCzkJvPkx58jdVH3YkrFbPvQTeeHTYfgZTiBtjqpYYiBMdNqX0Ke6yFcENWnZeSMs5JDxhaP1GAuCc01KK+ayNPJoIa+DuBMFrgP7TCR3DQYUBnTyjvCA7KF5BZaCOhsFHttdd4/suc2MEwnfeU+7HuDpAwkcnCUnDWLKp23ZDzZuQcsFSGW8MF9tJ90ZjGaKJ8hl5OzE06OJXmOJlh6moC0GYeXJwbYLHdhY4MDAUkz9gM4v118ftyDQLFSuEy81JbkBQ7VUGSdoIosxL6k0tP+BXPEyrrM3Ya3vTS3r5V2RW6cEHX5nli1czA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLsmmg8ITcOWVR3fX1GW6lTAyDi3UrSpWBVHPYESMy8=;
 b=Rymft1e3Dmhd9TsmbMiD9Y2u2h5YGiCyK1pvp2jiVJSQ9Mh919f+xfQszsS8f2sx/q+MTHR2dizKSjjIWr6ejBwTzYJS84DFvHM5Y4KL/e4VTh0dBE5/c2qFsIuOXBIBQHV+fBUi7v3/QtJWOyQCLhE2txUXqZlJ5lcG0kD9uehZEMZ18APhdwiok/ghBcXLMz246xdEkgTcNcSU9sEgTbrcAoY3MaWpU569to4L/I5oV8CLtUUP2BgAkVkTBWfklYK6nAyLzG5/F9q//h6ENG/zqhkEMEf8tP3FIL7jLvLEAvz9VVn1RSCy9IZO6SKHszvS/bjxA/HTl1rZWEUhDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by AM9PR04MB8987.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 12 May
 2026 15:01:25 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 15:01:25 +0000
Date: Tue, 12 May 2026 18:01:22 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH phy-next 3/5] phy: lynx-28g: require an OF node to probe
Message-ID: <xn77hfn32clk4jgokbtd2shazhblbw4hkei4a4pvmit3ey7wfd@xvp6cshgtal2>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-4-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511150023.1903577-4-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AS4PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::6) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|AM9PR04MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 103f203b-ec42-4b9e-2ea2-08deb037568d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|56012099003|18002099003|11063799003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	ZQ6rSJXfc4OOpJ42najlLTaWDh6bMJBYSyR+M1tHOdE+1xirb67amtVBFm2UMqVLd2+I3aBEsgO8HFHX++7Q7lSNhpFUi/Dc/Yh3JdYo2ucyFrfP9eRPK7HhfG56KVrojXsix5hGsYCRd89GjreDq2FPjHg3K4QeDtCjdlUjJQavH0o/7jFSAV/wKTXkhPPtPlKosohK1GVO+OzuG9NV+5zEUlKJGu1drqAr3rJMrWxbN2d9MvmjxEQpbq9Duk9rXNlsZwy7ry4LXREim3h9VyAmsWesPiYGw4EyT/COI0yQwxX91svaZ1afv66eBJCekPgfXgoC6vMu8RH0vInxRmX9erUnNHJ/BCqGsJBapDGeHMdwlFwQWJkwVtbJAKPOi4sUIVe8eACVtG65bQnweKZTXezTX7KZgS5HJd0gF1kSavZ0MbRGGTLnMIRkMMyM10248t8r2RxalMtkFk0LEfbWOjT9K676bk6KTSZdRJLfnuREWbqbZJXC0hk/PmlRJzbbv7PulCLQOuEWiK4iClQ7doc3TJEPJytt92yjcvshNfElT7DNxK6PuuLAwkeG3xxt+ZCBuyjS4njYJz17nPutA0UQnI0ZXUnwWvma8J4+lIBQl84I9Jzqg9yH9ktm8NWCYHUJ4lUanGMiuA3wo1xizI6krxjKX1zosAgpcAyKaiooPRM0wNIvYbjDhMQN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(56012099003)(18002099003)(11063799003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q7ttfnzkSzvKPHzPJBhAwPQcJxvzhXVy2kOaCV/Jfka1fv7dtQ9AMLChYsr1?=
 =?us-ascii?Q?ARbRQzWBl+E0ME027Vx5Pecg8Pj6MierHVS/UcaBkRF7iCHjPqAnjUAyqDzt?=
 =?us-ascii?Q?faUdW5pJVRPBoW8kRuiCZY+ztrIDoJYHyY+Pu6aEc1QV7nPMi8LCgUvCGbFM?=
 =?us-ascii?Q?tRtWM1OQUFYSsMbhwaqxNyIlhPAvvj1R/bpexG0nVqOQO2FHElcrrE6ruxE4?=
 =?us-ascii?Q?aR/hvOricDkAlu7eY3pDfi2ZMiwkhUQJI3cCeBBaQUsRVan4QB6urjCHL4lZ?=
 =?us-ascii?Q?xrGOmtO09GtJ7ic4f07/aMPYcJk0VeBj7szMMUgneNJ25sPe2bidt4E4CRPI?=
 =?us-ascii?Q?/j9WS358+cxrHl0KTklj0YBJp1IMMpsGMN5QsWcTviIx0oxh7c+ru/c/l54n?=
 =?us-ascii?Q?XiUpDmkeBMnHbBKFKAF6pLRSPjxSBJAzBCPxSnuByvY4xu5/URWyvY0/A+W4?=
 =?us-ascii?Q?QQXmcOmTDrZUEoWW93MgcVgAVzK0/h1NEWGBX2ZMenbvRwbSccncpMAgAfKe?=
 =?us-ascii?Q?D2AuqmTe9YJGAKwuuKDrEH8ZFDC1h4aCrYoVZb8A6qQPI+PFs8uyDXP5Jezg?=
 =?us-ascii?Q?JmFxB3IYx6uJCot4dyqMgMYqgc16pcWGbI6i/hY6XOPld/gkQAw5nt2usQff?=
 =?us-ascii?Q?769fLkR/hxzw1+1GcoCmknb/fFl+Ic9iyfnvWWrg8SuQSttdOuo1yvONbZiY?=
 =?us-ascii?Q?50HE5dPjTWA0t4YmzeOx88g/KHJWKc1NJZU8DYlNYeoK4+y0396llluf5Z+O?=
 =?us-ascii?Q?cBpwpuNueIHoKx4U+ZLn0wTn5eqgSdt0yUz/1jf4fO/lJyigJSEOUsxIN/+Y?=
 =?us-ascii?Q?UY+jofwxKZDdKPY+g67TgoM/BqigqoVd7yRgfmoaVhAUwqYbkjrMJ7zarY0J?=
 =?us-ascii?Q?JrgG2n3rhzhojbXNAOciAQN9HpXDhUBaotZ/bS9ZSIb7aZNrp1JPeCz36XQ6?=
 =?us-ascii?Q?QQfK1BAgvWTmxPRGzKuiZGqDNfXvyywTbmDbUvEiVVGwOTXuI9K1uTo4dCsQ?=
 =?us-ascii?Q?I3xKeLp4MqBa1Wm9oYpS1feNA5yrUyLOjfnAR/sqBVo/TfVpiS/F3x1n8lXJ?=
 =?us-ascii?Q?dj0Fl+RbcDTS1WfFul2LaoOL1pXMz4iF6swXmu99Q6EKtLG21DZyPLsGP45a?=
 =?us-ascii?Q?PzfkLuoCQowLkz+gFy4qC5hj3WgdhrehVi4ao2FikvxLElC3pWsFvFawG9aF?=
 =?us-ascii?Q?+KtP/qYEj9GwUolu2gi65Z3GOdwqKmgkLtzMAyPbVZ3MoXIAFANav9J9wBxt?=
 =?us-ascii?Q?SD27uTO8XTBHKbWFUEg/GrVcWFpwUYW77I3fbDQNQcFViB1jUnT7NB1NTV0/?=
 =?us-ascii?Q?/dU11o3GTgUzwTTDB2WnAy0wyp2E5e35CGAWN/6WAwXHvlk2gJRBCh8/kx6C?=
 =?us-ascii?Q?aEcku42btYIVbDjD0sSOhp4jFOH7Rdo4/g2qq1qWJ+u/OfPSxC5fTTqJec9d?=
 =?us-ascii?Q?D5NO9p0dIi2QZ8piRpspXu6JHgoUSFBaRBv7d8fsr2BTWX9YioMAYIXjRAPC?=
 =?us-ascii?Q?mgBk8fj2LMzuQpqlW18TEoI5zv3+iEGcm7katcODvjYfLJ39zKXjndjG4VT3?=
 =?us-ascii?Q?lCz6LfsFkLqxJNjrbqskSyjEEPpZsb/iNFPtuwhwaIi8ULPAY1Zm5qLT/sA+?=
 =?us-ascii?Q?PBcgqSSWSPz6hMZkltS1PQ8JApNaU9pkxUXVFRIWE8cmMlNFK50n+8VzsYzH?=
 =?us-ascii?Q?NOF0od2Ay1g4lhjYRpK8CMMzbM+QPfqoSmX4J7vABqnqh8fQizuT/e4mBgkI?=
 =?us-ascii?Q?2z/TxKme8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103f203b-ec42-4b9e-2ea2-08deb037568d
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:01:25.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCGxi40Ig3kzVkzHX83no0sJsL52DHdkoOK6U0T9b5KcRK7zfI5yKJ9D9ZxhqgZJ0grt+qoaR3qgukpM01XcNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8987
X-Rspamd-Queue-Id: 224EB523405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:00:21PM +0300, Vladimir Oltean wrote:
> The driver will gain support for variants in an upcoming change, and
> will use of_device_get_match_data() to deduce the running variant from
> the compatible string.
> 
> Currently, the driver expects the schema at phy/fsl,lynx-28g.yaml, and
> OF-based consumers, but doesn't enforce this. And it is possible for
> user space to force-bind the driver to a device without OF node using
> the driver_override sysfs.
> 
> To avoid future surprise crashes for an unsupported configuration,
> explicitly test for the presence of an OF node and fail probing if
> found.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


