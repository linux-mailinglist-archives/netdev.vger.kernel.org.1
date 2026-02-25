Return-Path: <netdev+bounces-260745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB51OkRunmkvVQQAu9opvQ
	(envelope-from <netdev+bounces-260745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:36:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A697191382
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B26F3067A04
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431552BE630;
	Wed, 25 Feb 2026 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bVC8j4Si"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021125.outbound.protection.outlook.com [40.107.74.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E72701B6;
	Wed, 25 Feb 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990579; cv=fail; b=MAsiaqWQFMbrp1gg8Vj/mA7Er43/l9Tg0WW5n1daqzPRMay/MJJtHmN7P8g60qwgbYc6l/04BQRKyLmjZMQFnMKPSrUp2ATBck9pggffkj/Gzqp1MU91hRgIuF0fiW9Eg/R6g2+GpVs1XJdIQJOqtHhvMDSWOwiveuNGrRLBcfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990579; c=relaxed/simple;
	bh=+AUDxKTAFphn1FeE2wmKlLBePzfqZczLaISs3onWAJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VBYmm8F2uwS4EHvO3qzFn30GGgCo7RSEUbmDyVjVC13QRHQEwUi6GjO110lBta/oIi/DAfkmg7XjBHCV6GKwE6T212xKqk6hWgLDbyv32YsbZs0JMj3uIgoYBk6+FNa7PO6W769eeaXNVK5tQfBBVDIa6uZEQl7Hu71nmmjfBjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bVC8j4Si; arc=fail smtp.client-ip=40.107.74.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0u7Ij8KfGnphKQt4DwEnBJEGkS7vCRgMQByYYS6jjWo22RmW74iQi+ymNs3RfqQQKCbsC/IjykADnEOk/s/hMbmP9ue7uTftVPisKssqLe4j0D8YOeLZRztmFFiPwOPwhxZuyqQTdjjDUAcmOO7eSruqau2KTSBdlljOP9zo0zbIMnnNqCf80GPQFeU9/Ff5LFmlnK23tag6uLkUnwWRv8OvDp6u73V/yRw9N1eR2UNcYUnQ4eFRtRPNuCp+EYUC8ufoLwYRcFYsD0DLUPzixdOBj/abWV8p2w0jb6ppVZjVfzlz8gBH+l4xvwe3E66xNBnIPFTOY/WWevAzcO4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXytHaXYFjT8JTqOzNDRcDFPo+eIicCREk4al0aOCrQ=;
 b=PmxW/a4wWkVBlbCDkUAfFlp5NEI55ma8GeczfSlkV/0Arjnu0FZwmLrgIKt5GVmh3wQu69DLVXSr7q9GcvB5seumtadaXpksEYdbSckzAqZ1WKSqewPo9k7Ozlfqi7SBYzsLUcf5Nb4UokPmyIsVs+FXVqZtN5mX2mbJz5J+HUzTALoeHYyXg/tbySNZrg47zcwIS1W1CR8oVKBNdbDPhENy/W59yJP6O5n+DwO2TWwNJC4aHTEyru76R1lZHt0a6BYpml5oMyG0dYx90XcFkEhVwAOzkuiDBNPl4lYI8Dh0SIj57GkWoHJ7fa6fUw6hd+lf2anRN64Q93b8tqEb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXytHaXYFjT8JTqOzNDRcDFPo+eIicCREk4al0aOCrQ=;
 b=bVC8j4SiEK/6Ht/tD/mH0u+TvsoBGLiQxh0OGltJ/cd4beGb13QnEQ/gdj3tm+kmK9cTpuKSu0TdeSFG1unWICKRhm7M16+8TS19iHD/SbG2dB7ZRGZDSbosiKp5P/9jXZCYFPAaIsZ6cKtFPDlxtLo3w/+pghauqXDYWoJmy0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2960.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 03:36:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 03:36:11 +0000
Date: Wed, 25 Feb 2026 12:36:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: ntb_netdev: Add Multi-queue support
Message-ID: <u7rapy5hbjkmc7wwxoxmgloz37z57q2ml5sjubmswsimqns4r7@mqget5wihsib>
References: <20260224152809.1799199-1-den@valinux.co.jp>
 <eeae611a-d35f-44f1-a100-50a397ae3eb4@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeae611a-d35f-44f1-a100-50a397ae3eb4@intel.com>
X-ClientProxiedBy: TYCP286CA0358.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aee1ec8-a311-451e-5567-08de741f052e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h18pS/77pYlm8I9Lx0GsAinhF1AWVdtHujQg+yJ/AQCeXPNvvXy5xN9+0juK?=
 =?us-ascii?Q?4jGSRCIY2RL2td64Pg0SiWoRLDdXOgO2UHQQF1I3Jnt5TzVZrYYOaVVHzWHR?=
 =?us-ascii?Q?FCzkgd4qKj/NkkNkzkE7my5wCPW4BBHZTITVnjW8ooP4t9NFALBM0stxT4V9?=
 =?us-ascii?Q?GXBiOlQ6Qj56rAYvfQEggsYEtqSXnd5SpyPnojr4Q8iPVUFe8XPSgpNYOCdh?=
 =?us-ascii?Q?+9BJLD20Ag8mxHd/5WeJqaXAHe5dFqW0dG3VguSFX0ejiozbZKrlNRcqZsyG?=
 =?us-ascii?Q?Thelmhf4B1f+NvRb/BoPZ34Uf+JZhUXYjzZC47MJ4IpHK9RNF1xshxR6am5L?=
 =?us-ascii?Q?JB3IE83XJr5Lss1Hnl3CEbsw5kKkpcwqGb+VWMo7hKa6b9OCboYdgHfpI6rr?=
 =?us-ascii?Q?MVhShwRG8X1zjS2JInRwV59438WRhpXE53P8LveyP84sjLkD8+6TIe1LvQYy?=
 =?us-ascii?Q?aZ/ikn2sN6nirW/eLtNPsxo4CnWTxinchKurb1YOcOylrbctemLcBzil7VVO?=
 =?us-ascii?Q?pPNsOstxWkzxK22vhkbbthcVjvcw6yS6lIoPDVpdJVU1Z3L5Ex8CmiJJbOB5?=
 =?us-ascii?Q?W2x5jwdQ1SQrhun/wJ56/yhHMEi0L5PSc+mFUJ03hH2bpwk6vv/zWsKjrzVK?=
 =?us-ascii?Q?eOPoB5ehoy/Uba8n7zY+kTTBgaUdeojgjuvGPXgYNMwoyUZOo4KkVM8KQvcJ?=
 =?us-ascii?Q?VSWcSp7hWZS1LSqptXqIktH9C1IAjQlgM/LuKGT8CSCSDFmaI/G/d6wPfZfe?=
 =?us-ascii?Q?tD2I9Qj7C4fHboqmWYYZnhoy3kNBzuEKp6lg9hTqJVd0vD3l1CZv7aNOjczM?=
 =?us-ascii?Q?pp9qR1PU6K+1Kcv17nhUAySkHg5tLshFe5UlFLoKSTwTnlHFbLKa1dalLVix?=
 =?us-ascii?Q?WISPjFitLObQ1PE+LCPXuYo25X0k0OBxLQSMcbGXO4VmG9r/NWgfeCytXZli?=
 =?us-ascii?Q?SCuytOKGcxv57SgGPz4JLriswq8xKFbkTRhhTs/ljFDY4mhHlIYhFP/SAN9c?=
 =?us-ascii?Q?IShrtJ9vr84jGfkx319qwk60O+I2v+G59QJKqf/Lq2SsjfilRxhLZhXRrzD7?=
 =?us-ascii?Q?4nkgC7AE1c6A8z1cH5NHCPwCYLJXxx4JGP3FSpwCOg2dNppd42+777HNWXWQ?=
 =?us-ascii?Q?rpZ0ureDxXXZvXvlpMY81FGvW01AzflxLdcuPvuExvFpsLxqLkbEXggYlJf6?=
 =?us-ascii?Q?lqK6wsc8ZQEaJs+ngeZixwZ3DQwEr0G1E12nKwN/sE8QtTtLDgxmhRCYCN6R?=
 =?us-ascii?Q?/G4TN+bUPY3rJA+fSh4QEKpSVy6mGEKAlppvfg7K+N5MB4Ma+8ICMxqrbYH2?=
 =?us-ascii?Q?wjaAPY3OjNiiWQZNjksVnYqVfGWspIxFoYmbKAnFucyDgTEI3CShxp8THKre?=
 =?us-ascii?Q?+WSkOQj/DmhqfKwgqRbA2qH+zjedGwz+cyaIleipHwWhpHpjbIxAuLdDdexG?=
 =?us-ascii?Q?uS3I6rx5U3unbSVpae68SmcMenLteEWJ7WqzHpWapg5Mc9qhZT4D2OUnnzFW?=
 =?us-ascii?Q?ZeQPxhmCm5Guh2aRElImHViKEPPSAubVgPE4VaWSICtymDYD4qIXNjIhfVe7?=
 =?us-ascii?Q?4jo+SmUyPQeCspvwN8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juMEqAnyYWT4crlsgIlKp4as4+uiDyVMp/s0/yy0KQavRlqyu+k9W6mM3azv?=
 =?us-ascii?Q?0R4V+vCG7SvOqtOAso3BZ7cVWFeYBE2sATVgX/71k8LQScQXy3EsRrGIfOjx?=
 =?us-ascii?Q?DKk4fdH+0JzvaoiQ2cERQy9YYY8l4Ry965/IY2mqSaQSeMUjI5uhpibr4Gv2?=
 =?us-ascii?Q?7/mYrZ4qgduLJauDJ8qr0IxAtXRzMbdWrcBB9xAgPGkg/B6OKayf9ZctLJXn?=
 =?us-ascii?Q?Q9SLdq1Pqny1iq7SDICt0amBYkWegq5iKNeRkUZGxQlRI+KN97JalAcBcHu9?=
 =?us-ascii?Q?xb6fAnAx26fZomFvpdzrRyxdt1FCgx5YVm+6T+wGFbLGMqruPKdrjaK2uuwm?=
 =?us-ascii?Q?+0MWMbBIFd1xhkr4OvY6whI2jeRxbtUVTOf1c+AVdbSK5J0oPrU6mBJcEHbT?=
 =?us-ascii?Q?xwtF/+mtlcV+k6CvALpzG+03SDcuvybGCRDyoJ44qQeWTmDazKROJh91ZFKG?=
 =?us-ascii?Q?S+o7ap0prAge35jHjrp2oHlml+xr65At9gWqJN3e1SLEn35WQOw0lbVbfS/Z?=
 =?us-ascii?Q?g3pfGhW0eKjL7xT4/Ey2pWGdHYfI36wrkqgfp5kTGFFLS0P2YrmCd3VeugFv?=
 =?us-ascii?Q?pOxVXwQIno3TQktPhsFFqu4ZDLXl8bLAyN+9tJR4AZfHbIEEeGuzw78pxfEU?=
 =?us-ascii?Q?1GhpdCs04dVOi/Tg1v3V42nwzYQgyzJJw6CcNVnBbovvusWb09ZYVD5UIu3D?=
 =?us-ascii?Q?6hk4NYXWqIp8z2s6DHgMOe1o/Qb+4+k7hZh9Isn0krA1EuLgxqVs4As3bQt5?=
 =?us-ascii?Q?6Ceqy2I7Eiz3HBqpA+LSLd7h3USO8cmOke7FMbm1yu/EQqzHzoXCugyJjApT?=
 =?us-ascii?Q?FVhdZIhqTyiTjHvnluiv1MbhpvwIXT1xrrxxiZhkoBLJopAiMxOddpZ5rDTs?=
 =?us-ascii?Q?bmH09E7EigS3p0oitwi8jjSMBq1Qht+udvixVczACktTHJMk9D8OW0/8lDN1?=
 =?us-ascii?Q?frfmiHXZvklUAtjLQyr2UQGP82zne3+AzHDbPpQapmGM/fuPSfjOJTY2G8s+?=
 =?us-ascii?Q?HJltK5oox6zeOAVIAp3S3HTNEEiQK9RPYyP8tIefG+ECxqvEHDl1muuqkoqU?=
 =?us-ascii?Q?jT/l5Rbld+MgpQ/DLSNkduBWFgtzSJvz2w9tei+rjp2V7l/VSOOZSUGij7aD?=
 =?us-ascii?Q?1KCXBCAodE1wsrXPyzYjKW2Z1Az5EaEVG7YobaI+6Nf5HN0xdgVimBdBPF1g?=
 =?us-ascii?Q?G+DcBEABIidiZ7USq2EUzrINvgS4sA297tiNm4GqPMWSropwUAA8EbynfSJF?=
 =?us-ascii?Q?vljyQwkThH7EY0QeirKPNcPzkxpL1j3/09Ye3qXLTn/uQD+uBO3RfzZ1rb6C?=
 =?us-ascii?Q?oBW6mkAKi9y45lXsFzAJPG6b6FDiYY696ltXPEDHdW2Vq24vIv63dV8eUArr?=
 =?us-ascii?Q?uYomA1Qo0AbHGC4rI8RUrVIK9k3kXh6oKxuyYi+3FbRKYfbdKPTaFMIUzr+U?=
 =?us-ascii?Q?3KFsGeST9cviXXfGiPYO31hYXLGhbPikbjEiNmVY0qadlEd78CKQnOl0Duvt?=
 =?us-ascii?Q?bKMFGVY/5vcN/RtVPcMmN1NC5sv0BVQf46LY5871JlPXBHuB+cROOhvZW2LY?=
 =?us-ascii?Q?HIPZc5kc26XqIfjliDuojK2ZrHba6+JSliX2WzAa8HpKnrSSCUBzN2LptlL1?=
 =?us-ascii?Q?yqwGORwA9faGPM8/FuiDcQLYU6ZI3UWF+X4YB9HYt/VMardL8zs4QKcZ6RyR?=
 =?us-ascii?Q?8w71OeoCOLfx0rkVr4vv/Hqb5T8foeKRfg7+30QMF/4jUHCYrw5JOP0N1Jf2?=
 =?us-ascii?Q?hkWqEeamgm09lJQiNfaGKOFAQR3PzZefDyNCqoPp5NAijhpuRTct?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aee1ec8-a311-451e-5567-08de741f052e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 03:36:11.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ5TLuykFXK1hXp5fkptvos9ayfAq5i6jHzd23aZ6TW7mebG/JagmCW9Vec9tLxdj6imEw+0hfzESyRogM2bng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2960
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260745-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kudzu.us,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 4A697191382
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:20:35AM -0700, Dave Jiang wrote:
> 
> 
> On 2/24/26 8:28 AM, Koichiro Den wrote:
> > Hi,
> > 
> > ntb_netdev currently hard-codes a single NTB transport queue pair, which
> > means the datapath effectively runs as a single-queue netdev regardless
> > of available CPUs / parallel flows.
> > 
> > The longer-term motivation here is throughput scale-out: allow
> > ntb_netdev to grow beyond the single-QP bottleneck and make it possible
> > to spread TX/RX work across multiple queue pairs as link speeds and core
> > counts keep increasing.
> > 
> > Multi-queue also unlocks the standard networking knobs on top of it. In
> > particular, once the device exposes multiple TX queues, qdisc/tc can
> > steer flows/traffic classes into different queues (via
> > skb->queue_mapping), enabling per-flow/per-class scheduling and QoS in a
> > familiar way.
> > 
> > This series is a small plumbing step towards that direction:
> > 
> >   1) Introduce a per-queue context object (struct ntb_netdev_queue) and
> >      move queue-pair state out of struct ntb_netdev. Probe creates queue
> >      pairs in a loop and configures the netdev queue counts to match the
> >      number that was successfully created.
> > 
> >   2) Expose ntb_num_queues as a module parameter to request multiple
> >      queue pairs at probe time. The value is clamped to 1..64 and kept
> >      read-only for now (no runtime reconfiguration).
> > 
> >   3) Report the active queue-pair count via ethtool -l (get_channels),
> >      so users can confirm the device configuration from user space.
> > 
> > Compatibility:
> >   - Default remains ntb_num_queues=1, so behaviour is unchanged unless
> >     the user explicitly requests more queues.
> > 
> > Kernel base:
> >   - ntb-next latest:
> >     commit 7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link
> >                           disable path")
> > 
> > Usage (example):
> >   - modprobe ntb_netdev ntb_num_queues=<N> # Patch 2 takes care of it
> >   - ethtool -l <ifname> # Patch 3 takes care of it
> > 
> > Patch summary:
> >   1/3 net: ntb_netdev: Introduce per-queue context
> >   2/3 net: ntb_netdev: Make queue pair count configurable
> >   3/3 net: ntb_netdev: Expose queue pair count via ethtool -l
> > 
> > Testing / results:
> >   Environment / command line:
> >     - 2x R-Car S4 Spider boards
> >       "Kernel base" (see above) + this series
> >     - For TCP load:
> >       [RC] $ sudo iperf3 -s
> >       [EP] $ sudo iperf3 -Z -c ${SERVER_IP} -l 65480 -w 512M -P 4
> >     - For UDP load:
> >       [RC] $ sudo iperf3 -s
> >       [EP] $ sudo iperf3 -ub0 -c ${SERVER_IP} -l 65480 -w 512M -P 4
> > 
> >   Before (without this series):
> >       TCP / UDP : 602 Mbps / 598 Mbps
> > 
> >   Before (ntb_num_queues=1):
> >       TCP / UDP : 588 Mbps / 605 Mbps
> 
> What accounts for the dip in TCP performance?

I believe this is within normal run-to-run variance. To be sure, I repeated the
TCP tests multiple times. The aggregated results are:

  +------+----------+------------------+------------------+
  |      | Baseline | ntb_num_queues=1 | ntb_num_queues=2 |
  +------+----------+------------------+------------------+
  | Mean | 599.5    | 595.2 (-0.7%)    | 600.4 (+0.2%)    |
  | Min  | 590      | 590   (+0.0%)    | 593   (+0.5%)    |
  | Max  | 605      | 604   (-0.2%)    | 605   (+0.0%)    |
  | Med  | 602      | 593              | 601.5            |
  | SD   | 5.84     | 6.01             | 4.12             |
  +------+----------+------------------+------------------+

On my setup (2x R-Car S4 Spider), I do not observe any statistically meaningful
improvement or degradation. For completeness, here is the raw data:

              .----------------------------- Baseline (without this series)
              :           .----------------- ntb_num_queues=1
              :           :            .---- ntb_num_queues=2
              :           :            :
    #1     601 Mbps    604 Mbps     601 Mbps
    #2     604 Mbps    604 Mbps     603 Mbps
    #3     592 Mbps    590 Mbps     600 Mbps
    #4     593 Mbps    593 Mbps     603 Mbps
    #5     605 Mbps    591 Mbps     605 Mbps
    #6     590 Mbps    603 Mbps     602 Mbps
    #7     605 Mbps    590 Mbps     596 Mbps
    #8     598 Mbps    594 Mbps     593 Mbps
    #9     603 Mbps    590 Mbps     605 Mbps
    #10    604 Mbps    593 Mbps     596 Mbps

To see a tangible performance gain, another patch series I submitted yesterday
is also relevant:

  [PATCH 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
  https://lore.kernel.org/all/20260224133459.1741537-1-den@valinux.co.jp/

With that series applied as well, and with irq smp_affinity properly adjusted,
the results become:

  After (ntb_num_queues=2 + the other series also applied):
      TCP / UDP : 1.15 Gbps / 1.18 Gbps

In that sense, that series is also important groundwork from a performance
perspective. Since that work touches NTB-tree code, I'd appreciate it if you
could also have a look at that series.

Side note: R-Car S4 Spider has limited BAR resources. Although BAR2 is
resizable, ~2 MiB appears to be the practical ceiling for arbitrary mappings in
this setup, so I haven't tested larger ntb_num_queues=<N> values. On platforms
with more BAR space, sufficient CPUs for memcpy, or sufficent DMA channels for
DMA memcpy available to ntb_transport, further scaling with larger <N> values
should be possible.

Thanks,
Koichiro

> 
> > 
> >   After (ntb_num_queues=2):
> >       TCP / UDP : 602 Mbps / 598 Mbps
> > 
> >   Notes:
> >     In my current test environment, enabling multiple queue pairs does
> >     not improve throughput. The receive-side memcpy in ntb_transport is
> >     the dominant cost and limits scaling at present.
> > 
> >     Still, this series lays the groundwork for future scaling, for
> >     example once a transport backend is introduced that avoids memcpy
> >     to/from PCI memory space on both ends (see the superseded RFC
> >     series:
> >     https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/).
> > 
> > 
> > Best regards,
> > Koichiro
> > 
> > Koichiro Den (3):
> >   net: ntb_netdev: Introduce per-queue context
> >   net: ntb_netdev: Make queue pair count configurable
> >   net: ntb_netdev: Expose queue pair count via ethtool -l
> > 
> >  drivers/net/ntb_netdev.c | 326 +++++++++++++++++++++++++++------------
> >  1 file changed, 228 insertions(+), 98 deletions(-)
> > 
> 
> for the series
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 

