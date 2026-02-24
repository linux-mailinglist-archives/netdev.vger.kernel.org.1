Return-Path: <netdev+bounces-260565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKlUEaHDnWnORwQAu9opvQ
	(envelope-from <netdev+bounces-260565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:28:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12E189021
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 127A1303A3D6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F53A4F3E;
	Tue, 24 Feb 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fqiVzUql"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021102.outbound.protection.outlook.com [52.101.125.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AF3A4F32;
	Tue, 24 Feb 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946902; cv=fail; b=YubWf2HGxmVsfIK/GaVs7SDB3PKqnqZuci+kFoIs/+qYgzNu4a9q0g0EHHkVms1wWBvI2zId119rk44oB2Y8aEZ/61YNLxqzBxo/xuJjVniBBiEvXeiU1ZL0YW84YWTpwmMK9m5ov42qI7/qZQ4BHw09XTjPrzlpHOZBeA8diD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946902; c=relaxed/simple;
	bh=DbXcRxV/gCfbvtn0x1z8ta1CnZU9iXZZyOLKKEbhUMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QN2CzypeFuiqYfXEG7rp66nglY8pJnVuN6DSeXl8wi47CResSC5nR8O3rxJoBqaC06WDQkKLX+Nx1JrjhppeGLpYukTKJAUMiKdZX7N6vGaCtrzeNsay5U4w2AGDoigdS+Swh4ZfCok1Pg1J1oEJphaSyefhw8ydBT6UmtevYSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fqiVzUql; arc=fail smtp.client-ip=52.101.125.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaH4XLa2SFwBeY58n+pkQiB8+UN8A3eU6iIP7//lGwp27LaKSfRRJXJYs3ee4iETS6yKdJ0r6qittAg7DNb4set664hBfUUQMfx5DlCUSmt3SIuu1fTtlt4J7XqWYt2hbprfDMLJAWeP+QCkC4v6mjNMukDOckBMbt7ZdGPlZyQE9lrJnYi6yixC7jIOeVLfvnW7Lc16pSCNhfJngrRPcVpcr1AfwiPaMrT8GMzW4ZU9eKtGDD5fLGANFuLsohXSHDT5Y6qMKfuxV2Fu/y4FkcazZkPUV6WBGedJ9GcbjfYESVL/IvrtReohQHZN2fgor99/VuShuhyzSdxMNriX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnaXYSypsg5d4y8lavMtesONgUOp5AE6K2sqsEYPSxE=;
 b=Rr9gP9hGZElnvTTvS3CH1p6H3himB5w0csCfXZNK1PM89H9AmYXdRor1uEvxUunEIqdrS+9hblp0B0ZqsknNoTp2l1ikUUJE0vNIYHsx3EtA7/OSormd8WTh6si/XjerVr02rccuAJxvf1Q0Kc4CPBEELYebgia7LuccdeIdC7n3xZxY4wwxN0XWVUrTEpuJtxyv3BAb8Zj2llqbYC0FzJx8iMQlmaNKWBAKUrKHPMgfgBHfAz0XCq25vyDprTZCrgmYts+wfa53zKT87xunHVprZV8FNAZpg+I/ZAYztqxsPRKupkLnTe8n9q129fy/A5/Cx3xtYc5WD43bgxlpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnaXYSypsg5d4y8lavMtesONgUOp5AE6K2sqsEYPSxE=;
 b=fqiVzUqlO5kaPf/wpG/p3y+Qs8aGvZ1DSDVn+h2zInTzV50WdPI8Xt+KCwwA04ygxVKcsPfXSDr0Bth5blvuUbtlE3nVSb1tAG3655tMsf4jaz1sHnoGJGYYi21H8afsrG9Q53uJs2Dm/ulUgEGSAsQCX+ICKlELEbcs7mfxNLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6904.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:418::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:28:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:28:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] net: ntb_netdev: Expose queue pair count via ethtool -l
Date: Wed, 25 Feb 2026 00:28:09 +0900
Message-ID: <20260224152809.1799199-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224152809.1799199-1-den@valinux.co.jp>
References: <20260224152809.1799199-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0124.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7436d4-30c4-4b5b-b168-08de73b95365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8U6pf4YErZPsUrKibPuAYn2glC18RDiiRDY7VNc7ot0W8bg5BYq6KEC6DGcr?=
 =?us-ascii?Q?27TeVI2JaLM8L9WhzGC+JRMoC6zSpF3Al47e57zl2JodQsonZYa0cTXGdxm5?=
 =?us-ascii?Q?nByf1XgRjiolxjEohZ5lK6z6I7Xw3EbrgyR6ZhEZk2S7AhKQCjvrO4Ei5VG3?=
 =?us-ascii?Q?DGUwoPUa1vjzQxI3vmQ25WSmRBYx/1FwF6QYc0ZNCr4gwgLLUIABRJHC1P9y?=
 =?us-ascii?Q?3d50hjVzNmDGRUZgX4/1vSKheV75IFSh6QlKvlWyyvJiJ8w6E+a8sU161hkc?=
 =?us-ascii?Q?5DxGJ+AiFm5Zf6vcwZauwNtr8mOfqtiQ7XBbwZP19rL/mK8cjOgQaypgxuZZ?=
 =?us-ascii?Q?QSqolu4bDxtZjZxjkUYkhI1hnUZ3gTTMeSg7hG8qwFzDaOX05x0+aE2J2Aqp?=
 =?us-ascii?Q?vD9U2XDh/RnMK6YIyLFmH93xXH2Nmjo2yVor1AIMpE3a7uI9+ieaqGqu/RE7?=
 =?us-ascii?Q?G9+Wc89y6BwbDjKFVCDN0ddb9fzXGLeqUbejD7JHV2s7QhO8NhwQggv8M3Np?=
 =?us-ascii?Q?MAJDxQSFl87LXRKOsAiZUcrHFrb2TS2fAWxwQejJr0A8z5JCF3rB7q3kBRFr?=
 =?us-ascii?Q?B/6Z6+2zcbCqEUFDF5BPqXSNVuOKSjLyYn25J9LE5QdtkUJk3Rbu1hn5adsp?=
 =?us-ascii?Q?077nfy7ZPrOLYJYQj+TcrExyge4/IaR2x/nzMFPPwlbmYVviOc6JL6sB3DnQ?=
 =?us-ascii?Q?F+8P38zz0C20yojG0/sgDzDVDyA3fJpN3xw5JaVpvY0jlwl5x/USC8iYIcwV?=
 =?us-ascii?Q?ahTMOhNX/Xffvxls8ex0xWu/hXDicF920hppVMyApTxC47p37HQkFwCIza7n?=
 =?us-ascii?Q?+JMurVNwx1uuBAgUlDhO8fS8oKnin8kMzcJyB4x0dYHDUIqYUJXYALLfonov?=
 =?us-ascii?Q?3xzhP4E0QS8SPGpmqM9FHaVLgsCbFF4WoEOrGdT5K+uYPpjRBXswMY7D9kTM?=
 =?us-ascii?Q?RWV/GjQ4xUG5XmvJZqxUdG+XArKdnHN/RPFQN08z9y1H8qDxF9GVHqeVjk8u?=
 =?us-ascii?Q?FKFqJicfBFmCxogRL+/xmT5uUXpmfBXMT3nsHMCtKKMfB8LR4HuUlLIUDwxd?=
 =?us-ascii?Q?5a1KZviB+RbGwPSHJqFpgM/LsqWZvOpp47RJJupd7jMCDsaW4PkbyMnLAs4M?=
 =?us-ascii?Q?XoOVU2j/wKodH8RFzeF8V0fGFUxibYR98MIY58c8kLjWZm1mx5r3VNaosrsN?=
 =?us-ascii?Q?hTG5tNU5CWbJJrnhFiMKMe/FCfIyXU+5HRfz3B1DxhLq9dDePz8SAQYXXEcO?=
 =?us-ascii?Q?0odhZKuo4p+p6S1TS69zfc7/svgpLZnSoH/ybjx27nTd6NNHdHgMk45RVNk8?=
 =?us-ascii?Q?T4ePlziwSwqyodVESdiOkYHZBps7KDxmjwBeWeKeQ9efXzi8F1DD1k6kAvKu?=
 =?us-ascii?Q?XuSq+XEDlGXZPC3UTcErZrd3neItgmad443/8JdTGSHEKyDWvwquuf1JYm7Q?=
 =?us-ascii?Q?ufbh78tockVc9PzIi3Bf1kA/7oyRiclxRrGuw6HfJsANyKJXssXQ5kbeoJTi?=
 =?us-ascii?Q?9JKpzLyu65Vs0PbBLAxmnZQc1goKoD+9FL393E8P47WNvQyZit9ViQdWKaBO?=
 =?us-ascii?Q?W1vPnk7YKJMwoqAtK1o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hgMncuvr8pfZ4ZHW9V0nvn8ak+HY68LV7N64/rxRtvSjM7jWnPH1erfVew+?=
 =?us-ascii?Q?hI1nO1nocm7qqJibuebllbFrlNbIqYlzMXbG87niCkmbTCYCiksAu06hyo7A?=
 =?us-ascii?Q?hkSzkKUv1oi0lAcObhGWNZ1WF6dLUVB+bRwf/WiDU24R8QIplJ5k5L6t3k0I?=
 =?us-ascii?Q?CFS0x2fBQXmzBP6RDSUZ6zlYDnuR4UuYDwJjgIeKwG+Typfn/T4k8/YL34EN?=
 =?us-ascii?Q?qYUrpVJ0vGxzfgVGpYDEngVKHeXx5KMktPf2wpd+IJeTBJ1QHh0r2YIPAHSh?=
 =?us-ascii?Q?JrmLD2jYAZ/jKmwbVHrNeAzGmHB+Bf63DSc0m+meHwYUbKLMCTVK7HF0rckr?=
 =?us-ascii?Q?Yy4Mhhck0YpOowXWDnb+jDm/NQntSxiyZYx2ioPq+8AEUW/9QyBbml/2XODp?=
 =?us-ascii?Q?qx66Qr0gqQzUWbt5+CAJ6Im1Uq9CoTwEECas1eZq3CceoCkvhjvlnE7DqIb6?=
 =?us-ascii?Q?pH4XvfcqlXCtIXG+WrLWmZsOyHznrF7sowhUQnHdZneCU5l20YHSYXvn4dC8?=
 =?us-ascii?Q?XSJC91Zk/FhxKqIHb52HLD1RObE8g43/onvnBUSTU8Rqn4efDy7bP2f+rVv5?=
 =?us-ascii?Q?U6JiIHvqdm0VSL4YjG3UxquUm2QrS2mdhKXeyh9On88us5gcrjnnbp4xwNUo?=
 =?us-ascii?Q?oe29frmEIobSDjke5WYtI1QroyE3WUlunodywD3ejBXVmB9FY5Qqc/G/7hNI?=
 =?us-ascii?Q?DNBPugVNAnU7CrRBKLNshDVcy36D7kT2mFKiRqTeUbjfVWJqn6MKlmovjJ87?=
 =?us-ascii?Q?vDBkncVotG9eXWJsgmo7D7IN0Tv3kfTY2MYMwSKBY8N1B1Bai9nzRCg3xTFw?=
 =?us-ascii?Q?Opf+gm9jJPUVtsCLR+FSuK69L4M0jRsVJndNaUMKW42QKXzGcUuxzgbgruSi?=
 =?us-ascii?Q?ug2hi4QOwOitbborM+/UQeuk341Y74U3JhYIP5OzZhBEtq20OtlDwHWiDFpo?=
 =?us-ascii?Q?ZOVrK/Lz3Mf+6yoEUtuYu6/Tjw3tUM/Y1shHey0cTo3W+Mh2LrB90waEnLoq?=
 =?us-ascii?Q?nf92u/0ykTqeCRJ6g7lh+qubADZQS1S9mJpQ9CMEN5abzbzIkDHDc4svR9pc?=
 =?us-ascii?Q?yILHKMdt7fOROwTnGylLLfsJj9GqlHL03hEOiEYuxgMNepPnh7b4LjYXo1h6?=
 =?us-ascii?Q?z0afrfH1vcMyBqJ5YT1+uvhEd9dLnhL7WpKex3lGXhmHbeW/QT34upKF92vo?=
 =?us-ascii?Q?iaCzcWgl/4Ms+2kFNQHjub2NxZvl98+oeSJlPcrJV0Fj8W7qRx/pfBN5zVYW?=
 =?us-ascii?Q?jz5ShIDn3PUZS/nKZ1zZmorFgDXETjKouhJy2pFbIllyhTuwWOoDsAjDUWbC?=
 =?us-ascii?Q?/GJ8NY0b1Ag59M7QyfQYMwEYMdxTAwpE7HOFm0FUWsqqWvC+P4M3Auew/n5U?=
 =?us-ascii?Q?ZC8ec0Oh60ZQDC10yDYsbI/ohk+x3MFrTu/a09Dfnx4BjzQxTepuo8qT0ZId?=
 =?us-ascii?Q?aXPXFjyrh83OS7wkdzztGovG7CzngjLbt0Vz6inb+tle4WMwPPW3sJwY2fIQ?=
 =?us-ascii?Q?MQhttfdtMPE6AipilTpE4bYfWQU6dvUPG1lh9OwLRhoDISPzjvT+GHQfT//m?=
 =?us-ascii?Q?xSm1mth8imXw75LwrNM+fV2QXxHFkcAcGtiR3vBxPGK5RUpNSFT3tf5q3aR3?=
 =?us-ascii?Q?i9yyzb9Om9Z+rVHZbphQ64R2FA/zHx8miasVDc80jGDOTGHImZ7TOqBGwTiH?=
 =?us-ascii?Q?J5avyMb5DWNjeE8a6Ck5hfLal+IvLZbqfi2kNIGrKRu+6wNjTJAidENwqUTS?=
 =?us-ascii?Q?s3dfJta79P3YiwM8tbYjLCHtkiHuLK19lluCOGnTZ2Z3Zj/WPeCk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7436d4-30c4-4b5b-b168-08de73b95365
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:28:13.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFPny/jI8QiY33rySCHi+hOF3cFwbKGxtk25FnjQNAPyvlmguwMHikgN5ra9xnCOR6rbEqQCCpp0zkcsvz+Cbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6904
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-260565-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: DB12E189021
X-Rspamd-Action: no action

Implement the read-only get_channels ethtool callback so the active
number of queue pairs is visible via ethtool -l.

Report dev->num_queues as the combined channel count and maximum. The
driver does not support changing the channel count at runtime, so no
set_channels implementation is provided.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 837a2e95f06e..185cc9ddfce7 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -470,10 +470,20 @@ static int ntb_get_link_ksettings(struct net_device *dev,
 	return 0;
 }
 
+static void ntb_get_channels(struct net_device *ndev,
+			     struct ethtool_channels *channels)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+
+	channels->max_combined = dev->num_queues;
+	channels->combined_count = dev->num_queues;
+}
+
 static const struct ethtool_ops ntb_ethtool_ops = {
 	.get_drvinfo = ntb_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_link_ksettings = ntb_get_link_ksettings,
+	.get_channels = ntb_get_channels,
 };
 
 static const struct ntb_queue_handlers ntb_netdev_handlers = {
-- 
2.51.0


