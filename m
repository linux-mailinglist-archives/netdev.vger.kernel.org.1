Return-Path: <netdev+bounces-289288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGIsJlMHDGodUAUAu9opvQ
	(envelope-from <netdev+bounces-289288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2774A5784E1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82CA1305685E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9390A39A06E;
	Tue, 19 May 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZPt18rY"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCC399342;
	Tue, 19 May 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172836; cv=fail; b=WU8AHp//9ZI4ioBYAEkSI8Sg5Ldw99vrdWmkD1Qn3wfJZ3tmfMgVt5UKMcHWgAj3MI2vBrsMeC/zCyJqS/fvD3/IJldpC0VzyN5Jqm9Lbnt0TxV/2K94omm9aze2ZOHtU5FvYaxQAi4UpdByCk4Og05g+tLyhhkdrCbgxtx6qQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172836; c=relaxed/simple;
	bh=KbAmsAZxdYgy8luig858STWZO6csf7/lHDn12+MZ1tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imrI2J76S5XIgv53Zn3WDmMFsch5lUQzEcKQYMiF1R3JRLOYvnyrJo4x2/lgx7/vunUdWXiITqkDjKZsSjpIQHGfWynxB43SRdHEi7e6mFCz9MgCd/CSxADn5hIAuJ/JrH2HKGkro8PbA2YGQz/PW2NdnlwYVK1lXDG9+42i+qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sZPt18rY; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8Dx2r/25uyF0ktAKl7b+5Or77MdYmu5ZzLpvD3i35ALgKPBJ8cT9uurYGBy7QxHW6ypYS2ZwfmAtMuimelOyo74ujS+YfDwbKLzBQdIQpHGCn2RuH94TdN8cbahjsYY32zVkLQ3gEnAKttDSEYYtuKMJKgJep059XcNO0MkcgQ9DoAniQcQULHf9Ja7CZIIBXjLGQ9KLbGmvLcp/gubS6PJ22n6IXBJbi7M5YLcafZnWTDjm9sQjJQ/CWrWaOuv+R8SsaIZAqLB17FjQPXr7G0YxhWXltNDzEGue334bh4mCF98UPGZo+cabo5dzjL57skhVMs3mymyN+DIsOd7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzFacYu/6pcoKl8873XrDHl81h85aFTT9TdasEclmQY=;
 b=bbhWSSJueImkJWlhp5Gr6AyaoS9KLkDj96ZuQh3QeEmhPUlG+lCYty+sPDUqXD1YIcsD2kqcXLarfD8Kre8NHePWcsHwE4s6ouDoGr+ZY/JoLEugLfUbaYtjXW2ToQsbbX9zxQ4PB4HCBVd3/wv6HX0lTkKWM49uRlQSPvLDHUZ1alXMI+YDpKS6uT90FPe6cCN0rsvTbHeK8ZJBN+yzyo2fs5wM2cNvNbt5rbYMnCHrxtr8QqKJL/gnahjLfHUqmMqa8GVTjo5JOfwnYrz9fT1cSLIIzYrxVVk0l9cgEfFi2c1HxcY0ElLDPfLXlLN+QIo2V9D7e4WMptRD0kVWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzFacYu/6pcoKl8873XrDHl81h85aFTT9TdasEclmQY=;
 b=sZPt18rYgq/3CCv1VbmhkrTByFfIRdn2/csHUj7v5yAulOmXWABJNj6uMRGoQ24dC8Jo2H/I62veZMSoum5deHFB8ohvzTTVAWvpq4MRUmlO7/38m7yueyDYAE4Mwk1Gsjg5XR3F7wau95J2Z1HwTtFuRkEq7qRdm78Hl44TYwQt52PDeWG+5rrNG0gUfKd/q1xM07uN05Yj/mc/DY9i/eIEK4JMHPhqcPuYoeSRN732qrfRoLwOVT1kCGYp4ZBW7FszBoKSwuDWJFviav8j2gaGftqSsH8SfaY8oOtww5yk3cwe3FTgcmVoxFquQFNe6GzWiLLC7ph3QvtOaWlOjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF590085732.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 19 May
 2026 06:40:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:40:30 +0000
Date: Tue, 19 May 2026 09:40:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: syzbot <syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com>,
	marek.lindner@mailbox.org, sw@simonwunderlich.de,
	antonio@mandelbit.com, sven@narfation.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in arp_create (4)
Message-ID: <20260519064017.GA370647@shredder>
References: <6a09f2c4.a00a0220.300e5b.000a.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a09f2c4.a00a0220.300e5b.000a.GAE@google.com>
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 439d14e7-c0dc-4b67-1811-08deb57183ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|3023799003|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+r5fAbwLBEOXlssTsjCulYR1G/7p1SXa3CpZjR2IUXl70KFrjV4AwYnSASLk018vnunXv49zPW/a/LuJhhs5RiUYvkByMIId+kEnuPkonco1GQ9k5ZSj4QWRMC2L9b2rL0oNXJs4wyFt7403vPyemdB0s5v+ypFIjhq0kurcCZNmk/1U//0ZE+YljtKlsunRMnydcf8VzhfM4cBwxFubxtn6yQysa8MyFwyytvw5gDxs3ZfovxybXLpsxNfIdDKkc/pwoz95vCaehw9IBhxoWshn0znfoCw81MvL7Q15B2wwWZ5eMyTAGMDh4KOfVkrnRxy5pV259LjJaXfJrE03Y2DC8r1QRGTV0gksu8yC8EdnkNEfgaq4WWQ7RyA32i0S2l41dAWBXWurnZzMGv8F4JBomdbqOYr7DHBKTGLGeqnSRDUY0YZQcbRb0swZVg9KN0RFJKqzJViWaSDc269INspHo99Zdy223qsPryA0rNMHG296f3kkNols+TTu/qWY3CThJwy3OVI3p8LKz5A9tRzf0FJLVi1BC5L8DW0ezkihDWDAaicI7GeuG70wzuy4aqOspLTwseK+YBBJ04Qg2y4wqRPb72fVpEkYgBzjnVk+vbi31w4dOwS/vrGPSHoqav833o7qtvosQgqt+8EYpm7UgNqqsKrRcy09varVO9HR93U0ZecJUyZ2lMFg/5WE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(3023799003)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJvt9cSDEiSZS/DCGxUFhqqzPxtkFS1l//WrLIk5k2vHFTHIge63UKERZpJH?=
 =?us-ascii?Q?8wH82/dDpWuLeQlb0ORA7+pkIDMhfUJ99RKtCl4/VseZ17oOCFfQmFg+Tocf?=
 =?us-ascii?Q?AnLqzvjPidPujeK0q7IzMecmyQkpM7hRy5jo8TQh6T41uMYlCZwaVUzBqzs4?=
 =?us-ascii?Q?e20pEQjFdHacCyH9rgIaRfJjAqpUynh7X21fx9DfRw7HeT7e9cFmJma/6LFL?=
 =?us-ascii?Q?JmhB82r3xRVAoaAbEV1CmpM0q6Ms1fFnL8Zd8dbYBgGr3YoL/dQRkg329+D6?=
 =?us-ascii?Q?WgZhgntr0cwF/8mlEFu8Ter1JfvjJOAJ0wa6Z3pf/9CRAVL9m8yRq5Jj00qr?=
 =?us-ascii?Q?X4VgbE9FAvBw4zd3aS1D+2sq7vZqPtIy6P3ZKsRBmBfqIBM7UBdjkh3E+16u?=
 =?us-ascii?Q?fcfJJEJXmSjE1LqOdxMG5qZTaTHjrgWXGnJBu7TQD8N7eYZoDZDVtpUOxgcv?=
 =?us-ascii?Q?uo277YYF6eQ3BPjabEt+4/kwON1IbiGPVXu4/wrCJEQiaks7CY9gKJ8yV7U0?=
 =?us-ascii?Q?juCSSKVHqd3Kyd4nLLmNyZFgjst35IdF5WEMLt35YpLhrBsFsll8YNx3/Beg?=
 =?us-ascii?Q?hIyH1A3ilvMfrks26b32DwhgY+WDkfZNKRZej/IHyfYh7MxQNO0g6c2nhHh4?=
 =?us-ascii?Q?9DCyXsALvwWXTSm0qj8oR7Rd6QbdeEEcwY5tkKcKBMrfDZADbMRKvwokvDDu?=
 =?us-ascii?Q?Qf3+EIkmfLYDCYFhOHo+Z/LxCnav2VhRpEwKRyQcUvW9+1YXMBgG14lS+oaA?=
 =?us-ascii?Q?8680H3BRKhBw73o75uHWtRrpz7Q38z2/2rJANc/CEtSvdoErJL5kPuuK5rjU?=
 =?us-ascii?Q?cuXb6nQrofl18a8i3bkAmBFI4KLCSl2KuOyM/HiXYrtMs95wKUynxR2BNPgR?=
 =?us-ascii?Q?HB2Xw9LN1pmPbZRfGuAk4MStkkoJZuxFGqulGeVPpxwXTGxodRXJG8T67GzH?=
 =?us-ascii?Q?u7ddLkZBiI01RN06zrZdfGbN/G1FFsAcDFX28cb7714P/3dKgai+aoZ3fQ0d?=
 =?us-ascii?Q?UMveD4tB2Ok4uBrJX+jdWGR8MoSC+SRrXsfHjaHoL/ouTtr/x4vigU0GYTiu?=
 =?us-ascii?Q?tXkzOitdUZWSe2Vo+eUt4DeCqRkYPESgC6juAtWfoeTb445FLdWlneWCU18T?=
 =?us-ascii?Q?cTJKh1ZIZ8zDZVUPBPGKdNOJ4bUHEeONZ9TnbtcdS/OvNUk+wSuO6hHzjmeO?=
 =?us-ascii?Q?BWiD3eftsdKVRSIHbCJQ/+FunKMMnv6vVubKOakNe7VWhVdPyj1/i+UKPcFN?=
 =?us-ascii?Q?ZAIhzOLuEDP56B5mkEs77y6Ha4zTNGl6GSdNAqUV/hCfdaUEQNVdqg1815b1?=
 =?us-ascii?Q?275yZ+Lm6O9KG2Vj1SenuzJskkJAfUDJGjLwi2c8IGoI77OAJdNhikD7Q2c2?=
 =?us-ascii?Q?dvW/B85A8wwbP3wiPvXHbZ/UguUQfmitFhiAxp18J+DCB3VyOB9cTzV0IM3M?=
 =?us-ascii?Q?VZQszrrIfH22MhNChIfVRSqKs3NL1Da+zR/17Ez3JW9zOBvtyia0d7+PssSS?=
 =?us-ascii?Q?JD6ttUWxRB/Uie5UyYEN7vkjcs9FcLFiUWIxZIKDDByoDfHUikzwyVOssTE9?=
 =?us-ascii?Q?YMBqe34x3X8f6pU0ABdqbmwwbUifq2F/mfL4cSRcVdyvw3qeUDyi/gyB/VZ0?=
 =?us-ascii?Q?rnlKN+sCxcr/jIN+t5wtSb/nQDUjgyE6tj8X+TM57jf6IgQR0HGDXkvpIJuy?=
 =?us-ascii?Q?wmjraS0EWuuzBCXu/xG99iHJYUgoXp2UGmd05tUWMh56Ptra?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439d14e7-c0dc-4b67-1811-08deb57183ca
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:40:29.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwJ+Jh4gmgTZxj6yW9K3oBc7xsGxQg05rkxT6tUusp1SpVs76Z5t+wa1lvRvXxLvlCMnzN5IigV5/do/dlc9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-289288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,9fdcc9f05a98a540b816];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 2774A5784E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ batman maintainers

On Sun, May 17, 2026 at 09:54:28AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    70eda68668d1 Merge tag 'hid-for-linus-2026051401' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f56e36580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
> dashboard link: https://syzkaller.appspot.com/bug?extid=9fdcc9f05a98a540b816
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6f3c10169d74/disk-70eda686.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/67977be60189/vmlinux-70eda686.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cf642084f321/bzImage-70eda686.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000016: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
> CPU: 1 UID: 0 PID: 37 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> Workqueue: bat_events batadv_bla_periodic_work
> RIP: 0010:arp_create+0xb1/0x980 net/ipv4/arp.c:554
> Code: 89 4c 24 78 4a 89 04 21 e8 8c f7 a0 f7 44 89 b4 24 a0 00 00 00 89 9c 24 b0 00 00 00 49 8d bf b4 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 15 06 00 00 41 0f b7 9f b4 00 00 00 49
> RSP: 0018:ffffc90000ad7720 EFLAGS: 00010213
> RAX: 0000000000000016 RBX: 0000000000000000 RCX: ffff8880202edc40
> RDX: 0000000000000000 RSI: 0000000000000806 RDI: 00000000000000b4
> RBP: ffffc90000ad7840 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffff5200015af20 R12: dffffc0000000000
> R13: ffff88806501d0a0 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88812538a000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000032000 CR3: 0000000022ee7000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  batadv_bla_send_claim+0x183/0xeb0 net/batman-adv/bridge_loop_avoidance.c:361
>  batadv_bla_send_loopdetect net/batman-adv/bridge_loop_avoidance.c:1402 [inline]
>  batadv_bla_periodic_work+0x654/0xae0 net/batman-adv/bridge_loop_avoidance.c:1492

batadv_bla_send_claim() is calling arp_create() with
primary_if->mesh_iface being NULL

>  process_one_work kernel/workqueue.c:3314 [inline]
>  process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
>  worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
>  kthread+0x389/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:arp_create+0xb1/0x980 net/ipv4/arp.c:554
> Code: 89 4c 24 78 4a 89 04 21 e8 8c f7 a0 f7 44 89 b4 24 a0 00 00 00 89 9c 24 b0 00 00 00 49 8d bf b4 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 15 06 00 00 41 0f b7 9f b4 00 00 00 49
> RSP: 0018:ffffc90000ad7720 EFLAGS: 00010213
> RAX: 0000000000000016 RBX: 0000000000000000 RCX: ffff8880202edc40
> RDX: 0000000000000000 RSI: 0000000000000806 RDI: 00000000000000b4
> RBP: ffffc90000ad7840 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffff5200015af20 R12: dffffc0000000000
> R13: ffff88806501d0a0 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88812538a000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000032000 CR3: 0000000022ee7000 CR4: 0000000000350ef0
> ----------------
> Code disassembly (best guess):
>    0:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
>    4:	4a 89 04 21          	mov    %rax,(%rcx,%r12,1)
>    8:	e8 8c f7 a0 f7       	call   0xf7a0f799
>    d:	44 89 b4 24 a0 00 00 	mov    %r14d,0xa0(%rsp)
>   14:	00
>   15:	89 9c 24 b0 00 00 00 	mov    %ebx,0xb0(%rsp)
>   1c:	49 8d bf b4 00 00 00 	lea    0xb4(%r15),%rdi
>   23:	48 89 f8             	mov    %rdi,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
>   2f:	84 c0                	test   %al,%al
>   31:	0f 85 15 06 00 00    	jne    0x64c
>   37:	41 0f b7 9f b4 00 00 	movzwl 0xb4(%r15),%ebx
>   3e:	00
>   3f:	49                   	rex.WB
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

