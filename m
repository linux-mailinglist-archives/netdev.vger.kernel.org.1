Return-Path: <netdev+bounces-256514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG3BLOirgmnYXwMAu9opvQ
	(envelope-from <netdev+bounces-256514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:16:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A188E0BF2
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD71F300C595
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE569255F28;
	Wed,  4 Feb 2026 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="d2dHbus1"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959E84A35;
	Wed,  4 Feb 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171365; cv=fail; b=iTIi1rJM9zH1c5P6CL6hr7CAAdCj4pC2gDqTQPFLcgUqSIaB1JZ7KbxNMzlHSqjt9CJU3ZIsuHsNk0x2dRHwwKXQI8xJRSsntrXHq30HTfegCXm3hgT0lhzoI1Gm9F8YrHUH/gu3Jf+Dtd2/Y6k9oRJw7xAKg2kFghcf6nOIAWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171365; c=relaxed/simple;
	bh=eZGrE5OJ9iQLqeIrslnNboczIfxkRECR2+k0SUKRBTM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QmapV10sAe9QcNqF1MU7MSJIRhXb1S1m2NhneuOPYijW/lKR5Co0RE4laWkF/+wkgMed0FCQ+mtZf5UnyCKz0qvk36/PPisLw/mkzhyP6OTpzUcn60xiF+6LS4MvDFAS1+SjHc9xvw59OaGs6XH61p8MdqbcL/1XsWMS5P2zyfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=d2dHbus1; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ski9JgMdQe7Ei9uq8uumYogQ5FQJ/XA7meLcBlVRtN6apjEZNNRe6Bw2clgkdlqRhP8g3jDdrdOih0qPZR6l+JxDuvoj043Q0ELKHPNdb0ozs95ccrpxDTzrcGoKUXVrEW/dGH+4zhn/iGQRNGpl6en+HKIBPIfQhw1x4wKugsgX7lQclD02j5SXLFBwolfeSuvmNEVwsJEuBfNpbAjZwMc67zzJ/Bn+HhIk7JDDAdowkULQ8ah+dh8mHFfwDh+yesbLZmp9ivNOfw1bFRv2elr2MqdrmmAKiRIWxZM68VDS0kgXzcoNPxbU6V1D95Hb+5t4AFMRFUpVjhaShSqS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKE7Ue4j+7Uh8sff8M9BEXyHTZ3698birl6N97Laj+I=;
 b=iwN6aDXMbYEPMi8bpeM9iXo0SPklCwxVY8e01QhbqTH2KxvbrCtBzwey2qcmSuI1svki8fOhqSoLaAaG/fbFpPidNOhj77e1+3/JhgdsV4DfFSsBLi6XaIJojMJXCt/KTN/0t4daYO7FEMXcPBDlyDox/S7pSA+ani2O1wrm/jPN7YkWnaEo0uzRB7xRRPdH7BkjtdNPpoV7zN1aPFXwVeQ7v1I0XgwmXkeoDwZRgqOAbJPUaSOKQTmkRTaKRGACx84KqyOaPOCPLL+fbY9pTb/gHvtnJcYBygMJpvvdcmWk2VUAlpBZi50c9n1iT+sy5PEaMIZHgWZ7ct/UB3KoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKE7Ue4j+7Uh8sff8M9BEXyHTZ3698birl6N97Laj+I=;
 b=d2dHbus11nI3iuiZEJhoiUEnJbqjR7zcELvNtlGPMQzEhTFtR3J8H4RvXaZcLa1LmuYaCIUQv6EXL68X5VcPIv1E6LtdyAU+z1eDHqSEvlBjFkjHLhMKYoeQCXraZa76uX8UVpyP0nasdyFNK84cfwrzM5uMmxi5IwVFT1r88Rm6LdTQ5nncRw+flNqZMPnFtpY7lnz1YcWw+PjbFiZLwgvjKj2WRBfZNDPVO2aoOavCOz+WgpdDVrjHFw88Oz6F7AJBLnVinPJghXZAR8LanSxkbTtWpGE3TI9oXS2JEL78np0Aw3xdDMavflSrB0evHV6kusEj+I/IUU1QtiDWhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS7PR03MB8036.namprd03.prod.outlook.com (2603:10b6:8:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 02:16:02 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 02:16:01 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: stmmac: Disable queues before tx_disable
Date: Tue,  3 Feb 2026 18:15:58 -0800
Message-Id: <20260204021558.24592-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DS7PR03MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c6ecc7-28f8-4c51-9d9d-08de63935772
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gdc1p0mUU3jLZ5/rn5zSd3n03PSWjD9A+CqPmcQULPZfR5woy4q9PLn5YJ73?=
 =?us-ascii?Q?hF3o2KSZABRssqShSFl+or7JsMx5SFfHa/Py4zbJBj5M0fn6s3wdQYieLrbh?=
 =?us-ascii?Q?+/iFymVx0kLSAs+jH6/GEMxn9NSeDUUFDkPVo/hUvSiDUyhjuV9RfR6EJCRc?=
 =?us-ascii?Q?+r/x5nQqbpwGW/dYzioFOwB9A6lyopSDy1g1aqKoWysJg+SDmIHD5bEkT7ny?=
 =?us-ascii?Q?C/D/VTu5aOrJO3c0rpylr0inG4DwDKst4xk7d5510ni++eNGaoh53iqIdkRI?=
 =?us-ascii?Q?1tCtYBIaPzNXyFViBMPedLJR7o91LZTX7NoAE0BgjSBgQspZLe0sPk5ozJmS?=
 =?us-ascii?Q?Fr3pZh9h4XupSHhdtnwx1JQ9jmwogSOOjpdM2i1jJz24cSjwRnczLxC0z0tF?=
 =?us-ascii?Q?roSnNGMtF093FB7aw94XLEycC8QtrNJhOIrE35eQFZVfZ+CcRV/NmvpUPyur?=
 =?us-ascii?Q?I6BP2MM3n/mOqaGrx7lA5zkzWW6GvvNdp3uFgdwQ0YuULZ2aplltcfPdehtk?=
 =?us-ascii?Q?uJsywv8iK3ae+bgW7Csa9HWQV2Hr3afDAkPepJSQ+ip/GNtmzIIATFaGs4v/?=
 =?us-ascii?Q?wSNHZhBwpzLYLR0Keq79VUrjQ2GUli3W34zl1vqbx1EWkj01IbOe7RYYO6u0?=
 =?us-ascii?Q?gpcWHYIgGntIqeRWE2F1hqMhdSuXLz4BVcwmK5tkevHt9e+It9dQiq3OOV34?=
 =?us-ascii?Q?Qw+IYzxpTE3hRJT3PRWCVBhkKa9PthpDI0NDmQE5sgZiLFs1tkITqBS7CUCT?=
 =?us-ascii?Q?zXtHhHXTX27S77hf5vQb4LycYdDS8P6AJ+1EdJHs1drbyIQiHo88C0tBdM35?=
 =?us-ascii?Q?MOF4jg3pHx8l7Y+0pCPrdCfWMYE3nWVE7phbQjB/4qGxHPVHrTLwL5hQsMKP?=
 =?us-ascii?Q?VQPW1DjT9MDd6+yEoyL1s0pNLohCw8xGb/u0nWV8OMU31cHao1C7Sl4PRxrp?=
 =?us-ascii?Q?kMlLhiD9szrFVEM5o1aA3ZKiMT/I/qv+C0JWaMEufavQ4HKGVo5ickVP95TZ?=
 =?us-ascii?Q?YPNWlTZk0xFV9L+by4JdRKzOHfrm4T3YhMtiLkvhQCvi2HSn3eJR2C9lL4rc?=
 =?us-ascii?Q?+oGBzCvDV2U82aBWsJ2iQ5x7psunK1/AC+SQL4rkLra/9IJyYbSoO1CgOC0e?=
 =?us-ascii?Q?JkbVB0k9drm36dj4lNiW6lJCKpz8txDH86YC2y1UXfZVuRjKr1mnDp0yLAji?=
 =?us-ascii?Q?DvZS/O7unQRHV5YvqZbw0+czNLY/zsXh5zbKGwgcOBIblzznLwCqYwWQVbqF?=
 =?us-ascii?Q?omojzXcUky5ONN6ia1M46lujcGTwTc7CYUed2t55xsEIwT8NIalMQC/Mx/Bz?=
 =?us-ascii?Q?zgREvBdovhon2HRlaV5ZqUYz3osVtnUWTQZ8MWYYAZOyK1yqhM+v6wb96aBo?=
 =?us-ascii?Q?RIo5NduwAT+09JrhOKcMKTzYdbMSFDy9Eb65o/K33LwWeR3DjiVfZk7B5Lbt?=
 =?us-ascii?Q?a3RwgjaAr5Rsoi6ZT78jMEILLQ/WQoNAVbYIH9aKMKLjRnREmes9D6wuqiJ/?=
 =?us-ascii?Q?zBAJWGeS6s9gSF6UQpOnlFkks/QsGQKAZETUUyXpXhpMqB42D58G+q4NsGfd?=
 =?us-ascii?Q?5+EOUFmCPXl1DpdfdSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sjxvJZ0H/deJcywoC3pZcqOEV44NUXYAZg+Q1dNiCYaehN4RPRB12inJt0Z?=
 =?us-ascii?Q?4lwuyxQU23ODyVoHVN+zVRSx1k6F5SHskhE2nfBfwHBVWwYfHydFp4RAnv1M?=
 =?us-ascii?Q?iybbUwegtaIw2hi2Jc+z4W5pFAlGsREPLZ44VULfcIABbhuGMfV8s6gkDgq4?=
 =?us-ascii?Q?9hSpBBua61CWMKx5kW/M2cdapnZEU/CVZNKueBFvHynKXGDq4DfnagpcApOl?=
 =?us-ascii?Q?XTasi8uRfqcFG4nKOswkUNer+sdlq5FxJnVEv1jIS6AvVTKRAijZVZS5fxIV?=
 =?us-ascii?Q?srQiD42+hcWHxab+RuaVtMvf44qJ4gRNG0YISpJvkYaoaJOoRdLGlH7c7TNu?=
 =?us-ascii?Q?McNed4TIAnsvnpCFAfcj7QllZWqIV/oac9/rLCgPXr0DfQE7uU8uRQcMdQkZ?=
 =?us-ascii?Q?GsmRwefdHZq7ayn6uITQ9rq+OnJhW89N5uIO1WSg9gi1GGSLpkKDdUXNGmUQ?=
 =?us-ascii?Q?a+zrGdBfU7jc60PJuBysvwG9YlEbfxU9a66S6ooQt3Au8pQMrJ5aNAFKhTTf?=
 =?us-ascii?Q?F8bB7wbCpu8YT4BRQBlfr7RSSmV2Rm/Q6EJpO0Wt+AC3/MnNNlLP9tNKUv5r?=
 =?us-ascii?Q?EkPPnmGth4C2DZybCf0CwOejbVJw0PThV6+avNyTJw+GRwrseH8/YL2CUiVb?=
 =?us-ascii?Q?K/CZ/Jqct1VZ8+TZwtaYEtPj2xjFw9C+mqtpS/blw6OvHPchg8x1IOb457jW?=
 =?us-ascii?Q?Cw9BVpHwSDrXZRuatRISPi7zNcfSZ4ejSYEH+DIOamsKuyiLb0J6O4jkUHr/?=
 =?us-ascii?Q?Ez4Cx9FuzBH1/C25jYK9mNAgXvo9KW3U2yyFJrdit2bXp4lPdLNw9N1hPlT/?=
 =?us-ascii?Q?I0MCVgAJHP3WUIOxBemm0u6gAjZCanF+Pa69V7s8YE5Q4vBhtFsowXsZ3OmM?=
 =?us-ascii?Q?gzdcbsI/B7Jj4k3uG94soy5q4+1Qo72mwl6wuyAMJMRLYuR3FcoS3xwoBTUy?=
 =?us-ascii?Q?Hd3Dn+WUJO6QG2DqCo+o9+JrF+GTbYoleJDo6ja9Ku9DJ4bA1UGu3+ZNBgqz?=
 =?us-ascii?Q?Htb6d3b4+nWpuATwvvPPyRlWIZMpR2QLAnqGD2Bkb+b4+6rIQB/XtXsUlFfL?=
 =?us-ascii?Q?A+beaC+FKhzALqL4hVtm+7YNqZ4AG3lIXEeSqkYR5PlNvZRvp/mWdO6CzsG5?=
 =?us-ascii?Q?YdkrfqUUZjouwajvJS1SjSUzswyxI2miWafWAcTpEAyEyy23P5fBZR4de0AY?=
 =?us-ascii?Q?FxMCvcdO9pmbUTE6xFmawIVnqc9LAniJe/a3jHzhb3LNRmvpaGbZjtP7/cS/?=
 =?us-ascii?Q?Ixvcqx26KwsYsKGbQxXnzmavxNgk8C2G+L89qwpSGQDnT3mUlCxIVixs6en5?=
 =?us-ascii?Q?Wi9Z0T+rQUtaYpo2zY40A3Nf9p3+5VDq7qQIf6J8uPmHpUw/5ku9ElJCSMgM?=
 =?us-ascii?Q?v9wlcs590AZdxijQDBvueqqfbpS7EVgweRWnWF4IZ9scssdNXiWByQmZKBcE?=
 =?us-ascii?Q?aYSoypBgYqnGFNG9nEao0yIcIIY6GpP1TAMy/b2csTQb/nkw2W54hhQSobdl?=
 =?us-ascii?Q?x6nNVKeG++QAG5UHe9j7/cGQGI5VK2lRQcapK8/fNn+8uuJl4MGOa1w6uDWC?=
 =?us-ascii?Q?2dnTkPBSWI5IJNTMRnPb/CCjO6NPA0b8LB6CP5Yb8bw/8SrNlQpUYLL0TRxv?=
 =?us-ascii?Q?FnEp3NN3MKizuly/slTCqbGzPBpMdTebRrNqKHtHtJomCwTELiI50X/Iln8P?=
 =?us-ascii?Q?4dwC16tkMv49mWh2xAtqezurvXgy0yM4L/JSAVzUdJ6O7GYxxIOXf8O153HR?=
 =?us-ascii?Q?4xvdFk4/5tlTO1PillgU8hEN8SyTd8FksY9F9KKAqTZNG62AIMaQ2MdJWg5i?=
X-MS-Exchange-AntiSpam-MessageData-1: wGrHycR68tMqiQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c6ecc7-28f8-4c51-9d9d-08de63935772
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 02:16:01.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSgkkX0cP7txSFmy7txs6+U9y+Ab8QkxlYhnVhyNMoJ3gbK/AQR7WqQaSErEjB3e6+h5alSP6TD7HtTnRXHCsy8oxbEfU4SXDuo9xEkGocN0pcigK+juSSh21tcWMqGTxvxlKJn4xj03HkkaEirMVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8036
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A188E0BF2
X-Rspamd-Action: no action

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Disable all queues and disconnect before tx_disable in stmmac_xdp_release
to prevent a corner case where packet may be still queued at the same time
tx_disable is called resulting in kernel panic if some packet still has to
be processed.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index da206b24aaed..7f5a6f30c231 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6967,15 +6967,15 @@ void stmmac_xdp_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u32 chan;
 
-	/* Ensure tx function is not running */
-	netif_tx_disable(dev);
-
 	/* Disable NAPI process */
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
+	/* Ensure tx function is not running */
+	netif_tx_disable(dev);
+
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-- 
2.43.7


