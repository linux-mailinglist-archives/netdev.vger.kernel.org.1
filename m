Return-Path: <netdev+bounces-259875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI20K68Am2lbpgMAu9opvQ
	(envelope-from <netdev+bounces-259875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 14:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB0716F20E
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E81B300F9F4
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2092925A2B5;
	Sun, 22 Feb 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iQ78lB5R"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3ECA6F
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765933; cv=fail; b=i4ZN9mhovkA7zpRYf6140cCnIi+w614ZnytsDXYon2AqlgSDcvh7xvPDRYY/X+1vXt3oKEzYsSMNy1cP+LrTVnj/2+2TWcniNq2dWnlJWKoKD8u6IvqDUfT6Kjsai51YjYglKLfigoZy1EZ38OFvfpAYFnGa1P8Cwo6CDK1Bomo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765933; c=relaxed/simple;
	bh=eJ3SMXh1rxiBzN5CYZzQyDMuXY5QGoH9tt6bglHTvs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RGvS5X6952MaYvRE1gBzy8MV7S2baH0fcRDAVD0ftwM2319x1fE0ttzZjkYUMVvJaL7r9g6Jw1QS04H78abDZq95SJEapc7RBkxyiFfXQQoItE+/xEYkloB0aMypArsx5Gq/3JtUs6NUvqqIYKgX1NVY2R1/5zqSQhigA2OrUQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iQ78lB5R; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWQ3lBDWR83H34MX2zQ+R2CJUIp9+C9UQWbRLUFebotS8RyKo3NAWgzbZlQgFaW6IVGEiLxj6TOyiF2dFEzd00zDgi95ljusCTK3E2Cyv8nmYxpIlETs7+ccsuxsk0xMHp++wx5iW4f79blibzAf+fWhF/Z8SrYtVe8Z9rGVwJky4k5XMpnuRwCRTCIcdfZK/qi8pliDqpQUNp6BXJdefo2N0yN/fFQsrjmDwy4eWx9549NAOnXDjI0sqkKB7N7+MeiOwxab/Y4KFyG+z1enAqxIMuhwp9NzKRw2bnTlnozJmVkZ8jR1nZ8bZTBMDhCdWvvCAzSYNQD8t3OcVzYNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3kSMjHJrI0msAgY0HsKxbJoGeu2GaWTyoOuxhvDggE=;
 b=KzNicC6nItQp7MweHb/c1gHIwo0xKk2WAYEGLxMxpEXB7mAU7Pv1uuLsKXkFT9CXTo5uaClvt2hOst3uzUGCUpq00ze8CUhfH14km5/R25dvgtpasm42NInelPuDRif9fZM0K1XOIgrE79VBRwqs0nwq1GrvHvNC6uRmnYMklzIZ4uT3OlAeBXxsyjn4sR06DIkYQWu4VYe7/IUkvmxac37NQ4wuLbKY84uEg6ExEWTPl/ziqzxOHMtgWU9DLW4UJIwrY3YtnB0eFHRz2jcUay7BN4OFYP3WEAVJ84yWJMRpYYWeEKIzhp20ZayqAVK4f+KYTf90qDP8Q0jLp8vXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3kSMjHJrI0msAgY0HsKxbJoGeu2GaWTyoOuxhvDggE=;
 b=iQ78lB5R3HSOXJOdG8s2BSYGROoHuQgWajuGIvPRNML0mFYUeaw4tnd4rgp8kLBzx8UN7D5q4tnKT1LCS6MISo16oUkpBxmKK0f7wXMyWgibZdOEtatjf1qNA5nOefTlEkMen99FNiEnXsdQCszdkr+2Ge5VWUOLLtUzXunDWg+oJoEdhT7cGlO4wClPw2XPQX3xdg23SRlannM12oDQdFlNrSC8wCcxh3iYDrOICNnekWLEe3ArbDCv+rpJ5XokFJkA8Ib6hroDDmfx29g4S4kNTvwv1JdfuY5yPv9B3lqldKF7zxpxd7o0FFdA5XnSj0vTTX6NItEQHxARI5GRzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sun, 22 Feb
 2026 13:12:08 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Sun, 22 Feb 2026
 13:12:08 +0000
Date: Sun, 22 Feb 2026 15:11:56 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Vitaliy Guschin <guschin108@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ipv4: add lwtunnel hash to fib_info_hash
 to fix mpls collisions
Message-ID: <20260222131156.GA53543@shredder>
References: <20260222010820.8994-1-guschin108@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222010820.8994-1-guschin108@gmail.com>
X-ClientProxiedBy: FR5P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::7) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b10565-a210-4990-a229-08de7213fb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+E0jkbaxhUzL7CfUFXc6nDN2KhOne9Kc0DJyqj0RTXRe567x6toOxIOcb/j?=
 =?us-ascii?Q?9bREVZ0PTAnzJKhJyrw1S7XNsGgTdRqxWRuTI1Qv/KUXwvsOd0ZD9nZFk1Pk?=
 =?us-ascii?Q?p54xHmV9SSMFPMVOSn8dbRsldqO4w0d/MyrdNQliG+4wymbu0N22AxZLToIS?=
 =?us-ascii?Q?V6et09COu9QxDxgNBXeK8dcg0/qcNYZX4Dz11abiZKSSNsUfyEwxrjrMsBbK?=
 =?us-ascii?Q?7b2iJtZXQ48RWVuqVc37BZU7MHhL39LbIMEW5OTRWWTbCClZUeCfVYxMPa2U?=
 =?us-ascii?Q?bQbqQ1uDPh2YmEGpEiHhRr3I88YpBgjqrxRc2fKg7FR9o2PU1w+6tKySduZQ?=
 =?us-ascii?Q?CgYh3xKbD8WjoEykxREVnVkVkCKMhBCMDNF2qsN2D906zF49IDl23SiStCtC?=
 =?us-ascii?Q?BSQ9hE52hrHnSb2FSHZVC50CPDIoTjDNqg4g/TnnsipvrNbZ52FrAK9rp/vE?=
 =?us-ascii?Q?pmsDL9uQgz/kYpH7IdWWg8sfrjX/CgBeNEifxp/MeisYMChrD2sUwVrjvZ4n?=
 =?us-ascii?Q?n8BaQo1trfGMznnVf5dshiFp3kn0WKyBRQItImQvcAur5JB1rBXQeVmt2Mld?=
 =?us-ascii?Q?mhP2kxbZXfvtG9sSZMRgYaoJNrMZG4elfbtggadpraLFpytlr5QE36gyq5t1?=
 =?us-ascii?Q?DigQnu02I603r//ukrTKkAqQrJdQVgwbk25lCYs7pBHHZWuSZ0NJZR58IZxy?=
 =?us-ascii?Q?t9ttvezqyVr0zWUOAC58bH4uy9zFUk3VH+UPnV79S7xneOFUIJmAwIk8wPPk?=
 =?us-ascii?Q?tkc8rgQb24ECpYnf8FGyXpEDpcMQ4mpcLuH1XNGf/K31A0zD4MzMTfdWfh4D?=
 =?us-ascii?Q?EtW66Fh90hS/ln9AJO0Kp0jh0K+YVepuJd05RjyrJUvmJS/4LoWpjTX3oavN?=
 =?us-ascii?Q?szcLMIZjCM4pB74W05xJFksK3/iLNz1Tn19Q3HgzzjxqhhGV2T2Om8x1Sh9a?=
 =?us-ascii?Q?YwZyC6n3Z68ZOfDMfASXiK4SWQoJ7BL/AIuuBYQFxqDnA3cxgWyaFD9KVbLX?=
 =?us-ascii?Q?+NMbwgiaeNkhX2Y+1SmE7aFNkgYO+Ln5IVEBeIaKmCmqB7SqLna5MdnSEuD1?=
 =?us-ascii?Q?3DImIWguIVvTDj2CKrap5FhD37o8MfF0BZoDzbdj25GohyVVVpw6YwwZVXut?=
 =?us-ascii?Q?vOOU49DDNkKrsBZVYGgdomRxFBX6qdy6RTjB6VE3LDa8c85nQgwRkJJ4hSjc?=
 =?us-ascii?Q?+iSD1HtXJrooeAYXJCdZ+iKW/BU6tYnhUICUiiFhwI8C94M6u9QBvngzYQPo?=
 =?us-ascii?Q?49OyqHzIKkAXUVk1r3HoDXKfgxQIst9pqL8JX86Q9wgHZaUjERV5Y4dVGpYc?=
 =?us-ascii?Q?h+Yk/OPbcCTEH+5c6qXxW8Zw6AKnvHzbHbil33S75g89LH+MbBNVl7DQkJV/?=
 =?us-ascii?Q?HPGdwQd7TKR6J0pRgBQDgCAzDUVZhqc7N4sFtCt98HJP209F/wW7lSgscF2c?=
 =?us-ascii?Q?DsO92bFK/wqt9NfWg6h0DHhdgU6fbu2h4PJlgMsPiOseklSqLfU4LrcuFPJX?=
 =?us-ascii?Q?BG0GiZ2e5PxmdFg7Xq2p/3or2ogvhoU9ReH0ADHRCTmglyVzouuoHsPov2tK?=
 =?us-ascii?Q?2ZHfrST7FVhpgfybZo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6TBIyqzjSq//eVihgSZBMC5CjbDSPiURuZjzJlpBxjPBS4rN9jBOO+mkvKR?=
 =?us-ascii?Q?qO8ylDBRk6ODUEekyaGLIaFLJfiqODRwFKutygJITV7oSS1/wyniwHsaR4Hr?=
 =?us-ascii?Q?Iwb8zUJTMKzPykdg/IdnSSeCy7It5YEYhDmeAFwa7FZoN7yBSIrhkyGcBmU7?=
 =?us-ascii?Q?5iXG3WzrzG3HPoly/Dec2PI4WbQs8Bzn8Mfwg6iP4i9to3dNifzq57OfSzwD?=
 =?us-ascii?Q?LrjOWq85tMnkmNt/D90yUWb5gZLB1XwmXrjhGw0wxRA3g6PAk4RwEdvIIwab?=
 =?us-ascii?Q?GjnvhPtAZFCdci315mfXQ+MkMkypIbvP31NL7SUdIY1ZkBmZVp7hFCorsXem?=
 =?us-ascii?Q?vQkNCKUW7rG8/I/bGMuZqZNwKCR4VlSJiRFOSfGpqVRNF8hfFVoF459LLFL8?=
 =?us-ascii?Q?G/6ctQ4+2LW5lfPTnqnIGqtGz6t5/nWucDVmKFXze63/A4EiuOqmzz64oLmZ?=
 =?us-ascii?Q?J9IUY7TQA8VAVBdaYm8PWj4z5Oq9hP1iEdIQ+i/OhbiEWSc1KcZ4FLlTOKdH?=
 =?us-ascii?Q?hMCemuwwT8FCA7dXN3bueE3KiJEVy1sMVu/9qfARrVzywMIkTTT9cONR13rn?=
 =?us-ascii?Q?qAnSlJxP3LWZIWRMJciYqctbq4c0x52bR+Skb+uZGKg/L8+lmfkdczbIQakL?=
 =?us-ascii?Q?EVdS/JqTnMfGFcnHclwe8jWrpmvnVfuFfsFxmbH+p3kl9S+ka6Egrm09OCR+?=
 =?us-ascii?Q?NKoh9OmZpBqxux53sbgBEPvHEg8O8VQOPNVzNWpziBnsyNb66aowAevWyOmo?=
 =?us-ascii?Q?wDi+L5qB/bGVfBqqznEyeUPyR8nLZe80l7HtZk6NA7JgJakIsoRSBSIJUyov?=
 =?us-ascii?Q?ZKZbGn+N134nPuwqjTzGufOCITS7KdZhw8kbnRfqU3vCJTeRLS7ShzlqsbdX?=
 =?us-ascii?Q?st5dc5zaMudg5C1UdhfVAf7zP3dUYxSca9Ppe/SBdIsuOv60EZA+2PPro5sR?=
 =?us-ascii?Q?4gsmL3Jf+P9H9cAM1k6QUpg+aDuPqSnFVH3K1vz4c6+hR/5w8I1+5dK58tKS?=
 =?us-ascii?Q?FKAYwuIqTV8avAvAriYI8GqqxMeZ5CDX6j+MyH8rEOembmYvSj8ZmI+O6RqZ?=
 =?us-ascii?Q?J4TCMl2XlZSdxcs+i9c16D+RePGb4a22eaRRn/M8ZWT2vOQfMyPy9x7kNj2L?=
 =?us-ascii?Q?7xK0BzA6lkXjjdzQak2AM+xGZVYq6LxLgsKWzsrl9CUJBGzWiL81nQsmkk1/?=
 =?us-ascii?Q?7LE1wrVlhZKSw8DUYRTmO+kBadYNCGzLfT4VOKsEDlhiu7J7AjKD+x2egyLX?=
 =?us-ascii?Q?Tj3uDlWTPXoJN12SrcGXZJ7jIMLM2KFNGePk83ij/5SYc0+XvCdf/5JOb7Ao?=
 =?us-ascii?Q?liLIis8WwDZOXZgBqCPk7ZnsxqXNsd9WiYB/IcJBv0BhWv42Rc5YeOINmWMy?=
 =?us-ascii?Q?v8q3NagguSQ/iZ5MKFgvW/dnm360aARrbz8P588zD2mZRU9hVuoGv6gTMnQe?=
 =?us-ascii?Q?vEAQV3n274zbrNEFumEkJ9nP20FvebFs1/9zuy21fvDFEKzsPTod/w1z9Lwr?=
 =?us-ascii?Q?+7y4+XMmiGR/vIQVNu7QItRBJEKaqe95pN5hM2Su7akPx6hZG9p38IvlCWD3?=
 =?us-ascii?Q?cgsoDlEK5zWF6FI6CfTmJtvdceYJYpk2faD2E06jaipHmInd+Oe7UXF7jUZx?=
 =?us-ascii?Q?DcGLExwAr2HSRsZza7i5IJIkwA9Lmvl87UU7DizozQUoauXY9ilBENsUSSzt?=
 =?us-ascii?Q?vDTnxSKtimrQ+SE748R9AM6oGRYkhe8dfg4TsZcVX6ANy4oH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b10565-a210-4990-a229-08de7213fb40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 13:12:08.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5HA4PZEzR8Lf8dN/qGyaB91l/0yHsQrBRWf5k9nrbv229HzMWoXdpg1f3i1VJp37HjcUx8auWFUOWRh7eIo5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lwt_hash_nhid.sh:url]
X-Rspamd-Queue-Id: DBB0716F20E
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 01:05:39AM +0000, Vitaliy Guschin wrote:
> Currently, fib_info_hash_bucket does not account for MPLS labels
> (lwtunnel state) when calculating the hash for fib_info objects. This leads
> to massive hash collisions when many routes are configured with the same
> gateway but different MPLS labels.
> 
> To resolve this, introduce lwtunnel_get_encap_hash() helper which calls a
> new .get_encap_hash callback in lwtunnel_encap_ops. Implement this callback
> for mpls_iptunnel to provide a hash of the MPLS label set.
> 
> This ensures proper distribution in the fib_info_hash table, improving
> route installation and deletion performance by avoiding massive hash
> collisions. In a test case with 100,000 MPLS routes, this changes the
> algorithmic complexity from O(N) lookup in a single bucket to a
> well-distributed hash table lookup.
> 
> Performance test (Batch installation of 100,000 routes with MPLS labels):
> CPU: Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz
> 
> - Before patch: 6m 0.258s (sys 5m 56.895s)
> - After patch:  0m 0.879s (sys 0m 0.468s)
> 
> Signed-off-by: Vitaliy Guschin <guschin108@gmail.com>
> ---
> 
> Hi all,
> 
> This patch addresses a major performance bottleneck in the fib_info_hash
> table when using MPLS encapsulation. Currently, the hash calculation
> for fib_info objects ignores lwtunnel state, leading to O(N) collisions
> when many routes share the same gateway but use different MPLS labels
> 
> This specifically affects route installation and deletion performance,
> as all fib_info objects end up in the same hash bucket.
> 
> The test script:
> 
> #!/bin/bash
> 
> for i in {1..100000}; do 
>     echo "route add 100.$((i>>16&255)).$((i>>8&255)).$((i&255))/32 encap mpls \
>     $((i+15)) via inet 192.168.1.1 dev eth0"
> done > batch.txt
> 
> time ip -batch batch.txt
> 
> Test results:
> 
> Before patch
> 
> real    6m0.258s
> user    0m0.335s
> sys     5m56.895s
> 
> After patch
> 
> real    0m0.879s
> user    0m0.397s
> sys     0m0.468s

Did you consider using the nexthop API [1]?

It doesn't suffer from this problem since the nexthop ID is used in the
FIB info hash computation and it does not require patching every LWT
family.

[1]
# cat lwt_hash_nhid.sh 
#!/bin/bash

ip link add name dummy1 up type dummy
ip address add 192.168.1.2/24 dev dummy1

rm -f /tmp/batch.txt
for i in {1..100000}; do
        echo "nexthop add id $i encap mpls $((i+15)) via 192.168.1.1 dev dummy1"
        echo "route add 100.$((i>>16&255)).$((i>>8&255)).$((i&255))/32 nhid $i"
done > /tmp/batch.txt

time ip -batch /tmp/batch.txt
# ./lwt_hash_nhid.sh 

real    0m0.467s
user    0m0.109s
sys     0m0.347s

