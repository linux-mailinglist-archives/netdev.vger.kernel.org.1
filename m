Return-Path: <netdev+bounces-290084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLglDjkRDmrB5wUAu9opvQ
	(envelope-from <netdev+bounces-290084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:53:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6F598D9E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BAE93063C74
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBB35B137;
	Wed, 20 May 2026 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7RBgXrs"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7B3546FA
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306785; cv=fail; b=DhPHMowIKAMH+jk0Tfpg/FgIqfb/y40YcNv/IelRT8WonaBTSmDNmkEgOFJzo5Ww8/07sZUOvxHYEJcLwm1us2Kn8Qvu9xOikA1by5147/Evo7jZhIft7YU30CuCl5VjK5BVaZJTBVqU6VJzzGLsXiW2VO9fEEP2hUQyjFp87N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306785; c=relaxed/simple;
	bh=HTwt02+CDBMo5vTiQGaFRgfJjSdhu4tgCv7rIGLF9lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mf7KelBms3CLaryaKoyX4eZ8W3QFZeCYKRfG5Phq/fJnppGLSSSnH6YzFgVV9pSj/7n5Up+VQagcBn3cNW9zaeInGy6iK77XGbjxiAk9mVkBmQq7ZjEVGCRRvq5lmd0YzFMyEYCJ6NtBBWWHoiK6QDi7d+p/6QYSsYm+W1JStXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q7RBgXrs; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xzq0ZgQWjRI3vfiHUUClYiUFpLQFlgRef94kRm0VhhEEReLmrPjkC0E1D/ps+giL5rdFttB0RmccQFbSyKXeEKWPDBC8PVK+h8riIFDnScUppMG0sDyHDgJTfyXPdhA/0htvA/kKTkF4EmcRniZ0mgEtnTKsWIJUTJ04RFx4DS9t/TA3R/wsSG9FfB1YT02alBFspBq54KNuvfnCZ2LJpvpsfvjaqdnWnvqBhG1y/yWyfF/W+sOE3R7Z62Sia5Q8MiSzP8aMwPiEsv5g+nRSQwn4VQqVkUmQehwEbl5zArUQARraHzmahP0IAoqsAA7Wba0VIX9rm8/3LRchS8DCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k7mmf0YIFEQedB+4wjyTok+ha4Wj9iIpUEGFNnQ3iY=;
 b=oK9Exnhvx5Ujyt72oj3vcSyg9dJ1FfJpLIc+qDr3Unp2igneakG3+71Ky9XZDYdNEKyxfigJaen+3szrbIJNTlONi6vu2uekMa6hChJX4v8eI8XiQI6uXE4CmH6A0fvqy29RtI5tFkVh892farMzHVip4owQGWyWCVRuZJ4j7Ec76qEE82OYQVG186+9Q+OF+N264WpggJrb1ES8khSrihtdllJmIdZ/C6nnOxHC+Ym+A5AF3lkFiW/RPOjU5FSxWd2YAjSRGWMKaKo+4XzosM6nhCquyohBxQrRQyNFofYRrJZmbqrgvs9vf2k4dp2JMY+0lyUth7OHCsTHNXbBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k7mmf0YIFEQedB+4wjyTok+ha4Wj9iIpUEGFNnQ3iY=;
 b=Q7RBgXrsod+SdZtuFdhnWKtaqccSxv4AoIVu7LoaWUI/Hzuuas1GL08xbw+7GPuotqx1mBsR7S1xgNN4UPICVxPZ6qxRugX7W8hEFldaPHLAvL6bjy26tHg381l6G/c9l6xtN6E9KRMJZi0gR6cPq0EqR9svzsd9taAswU+eL501Rl8U47pCPHeVNJ9E5HIIeTHHlJb3uGt1y3Gtk2Q2drCTe2yStK0srpp8uu7FRWuijmPms/Vyg+byif1oaZAJ9si2Ti4Hz4cKoNN5nQOTCrihlcycb0tuGgLMxuTc0W3p7mmxlQyIR8Qe8HlDpcjbHMlvtsh57q4OrFbJWizFtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 19:53:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 19:53:00 +0000
Date: Wed, 20 May 2026 22:52:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH v2 net] net: bridge: prevent too big nested attributes in
 br_fill_linkxstats()
Message-ID: <20260520195248.GA738586@shredder>
References: <20260520114207.1394241-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520114207.1394241-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea2788e-e1aa-4d50-38a8-08deb6a9659d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o/bu99EwfQ0jVsa7zjLEhqRc+0IKyOT47wLGVIuCmcIFfQZirHiUQ9k/K7t8f348/kS1Bz6sZG13rUZxgmD5iDG/y4aG74O4uVwct0TZtUJk3zSqQxAr3vQvqm2VDBfqhQf4hzn7GgRuuVZcTw45tz6KE7HgAJGulXm5hhQzzFBnWTs1X79Fg3bZDEht3zCBGJnHdWv+c1PtIYQ1AE7LmcuS61MQFRqG5L4vYvtwtK3L6CMi2ZsZtgsD5hd/oQDbe6E8DLlWHItweXd7fOpMX0srOfz54a/uAtNdXLI/mCwqQt3Ine4A8/+ZB25KGdrV/6gvtVmQ6/0rMIiBpoK+l78atBVta/IWOQg7KPQzyUzJ8yQj2KQL/XZUYStwpKrPOXvl5WuXn8Q3QA0BclR9PngAX4UmAT0HY212WKx4V7ojxt/rVOn0YMw7EeFebqon4fKoEqIH6Jm4NmzT5bRWWWgGPB2k12cVAVqMsX2A5LDlkETUW/tNp/svrqNtKfHHWbre7mDE63lfDGYfES5yUF4n3e1kXofEMq12f2AAqKvYPeKrGLcIxIVTB0qhfBo11Q5k14vJXrEZebQv+jNcHUTHKk8sikzCtO/5BGZgTv5j5HRWTDM5x2QNK1y8NG9F34CdWTP3VQFFxGhUOwopUrofuH9lDxGrjc5WXk8uWVW8DwG4pGEFtxVe74G/ES+arPH17KvrGACYIxHK/45i+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RKLuKuPZOYMbj8MnBUtxiz5x7eCvfOw+kephzhSA/S9ITjOkoC4NdGlA7ZWV?=
 =?us-ascii?Q?2A7qjd646+0pMH3nVyxcwQiOA8GfZhvOANY144I+q0W2itFAjVpF2/lsGz+q?=
 =?us-ascii?Q?jeXsaQYU0GO/eO7CkfVHiADMRfBhG+0DLlzYfGsbob/EWoJIjS2ZYaLeh98d?=
 =?us-ascii?Q?GQo0bw6bfjeZCbqSlPW900wybUVbQMN3KPFnllqAkjckq2mNqBxAm9/YLkM6?=
 =?us-ascii?Q?YK0DaZy0kY2+QfbIWO+LWxmHsWdqdTldm96fMyZfVtzeJahG4awksnPwn9nA?=
 =?us-ascii?Q?WKQNpUAJDEWUkyRy/MDur9veKXusebw27MRSkQXEHtTwK0bK0QQ4GjYXmeR+?=
 =?us-ascii?Q?6nP/Ue5Xdz31thRuTxysmJsOFhfNZobSG0eRJc/6d9r4PMraNZih6coXebf9?=
 =?us-ascii?Q?5AvC32w+CldcghQs1smIUf96GqCzs70PeQkHLWKFoZaEKwy7txumbnkHaQrT?=
 =?us-ascii?Q?GhB2RY9hQ4DNw9YlvIwemNsCa71BHpLrwdT1JixH64AlxU6CthDYd+/MG9yv?=
 =?us-ascii?Q?/M4HFGWxO/Xy/w3WBAsfK3DW+o4Ec1wdR/sXdVdBlorMnYrgApBLRc/rbSsu?=
 =?us-ascii?Q?4o7lhcQX8QK9XAJI8vbnAoW/4A6G9pSSnDN0Lz8+lmMdPuQBm5phCJKsVSK4?=
 =?us-ascii?Q?uGoeb92X3hd0sB8t0kd4t8ajHv00G9YUx5mnZD26X7MrZG5qJvMvPcx7NXPi?=
 =?us-ascii?Q?mcjs/Yy8Az7n92TX87Ilbbgvr/9ZnukIpeI/YGia38T4l9iS5Ewc9v+L29PC?=
 =?us-ascii?Q?ghoPxyGevUETSF1p11Yj9xyXQAZUBH78U/sJ40r53HMga8aZkPAbJ06Ab38m?=
 =?us-ascii?Q?s7kiLV6i0nQ2lyRpOuEGBYZlWqbLO1K1crsZGCmEYReQrMe5M4VwWSZV0s2I?=
 =?us-ascii?Q?WbPEto1DOK+lq/HdM0+ui0B5Cf6/yMDnTCecXh0365upPY+Xbz1zver6tN1q?=
 =?us-ascii?Q?wOaYapNuiDJVWV0hAwyylXPpMPpJaTJRPrPy+4SqBkPj+sDYQGEEMJTSJjPS?=
 =?us-ascii?Q?oRom8aNpEQUTVzqbXCLbOxmtp7vMqbwMX6c2/wz5wbro34nCZCb/AqvRNUsM?=
 =?us-ascii?Q?zbuDfdYU28NpAixyrBUB7fslTDgpj/neJNENkYwy0NwLWJizw3higXtq7lmb?=
 =?us-ascii?Q?/hwPyw9HpRtbHclvcAafUBKKlzFgPAq0Dk0CPjjmZ6qPftad3LlQZwKSc4HQ?=
 =?us-ascii?Q?YamoeAAsSqBpbjPfQef/AU9CVqtqA+mnKhlfnv3tLW/kvXOEFIwN9+ArP4Fl?=
 =?us-ascii?Q?H4RIA/udnDn61Wv173nnKVieBN+41jo1h2BZ0jR87n5pKAdOkuwOJy7CFZvR?=
 =?us-ascii?Q?3sBrnBM6Me7OJhqQCzCo1D0oa21ng0GQ7iQDo3eK/epg632ZZRYc42t4Ia3V?=
 =?us-ascii?Q?PcvSmiXzrkhYoQyovbCgqM5qvncJ1j5Kf7xZtCGuaAkkuf9of87O6EwTTHxH?=
 =?us-ascii?Q?6cgq1Np6GPIF/0012UHmGyiekQwaOweUSzsDsHLwxo8G6sxe9EBHCB667HcF?=
 =?us-ascii?Q?1Vp5W/VaUTEvZyKqrjUO57MjL1Wr3aw0AEroqM8hG7lTgbTI6aDdGf4okq/2?=
 =?us-ascii?Q?YjsjnH/TXjB0XuBBijYgzlgz55LuyTzp6DoYngE4SGXGxYZ1iG0d9lfc9kRJ?=
 =?us-ascii?Q?r7Qidm31nUQX7V5dnRpfTR3bnkEL6W8rhn6j2OKcMv+fwlvUCj/TpoZMPZnP?=
 =?us-ascii?Q?aSZqBUkvqyCpXRY8mFuxZfjk/wlKj8BaGRrlK8LJ0QIlZkTXb9pXRG9ej7XH?=
 =?us-ascii?Q?qXEdpg1FwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea2788e-e1aa-4d50-38a8-08deb6a9659d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:53:00.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLtfnvEWUwM/O2xwh5PkTRI/SjDIwDGuXqjHhXPZaJQM8bdd27LG1XtZQky/J1+qRlh3LLVInVL26dItvTTq5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290084-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,a35f9259d08f907c06e6];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,Nvidia.com:dkim,appspotmail.com:email]
X-Rspamd-Queue-Id: E2F6F598D9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:42:07AM +0000, Eric Dumazet wrote:
> After commit ff205bf8c554 ("netlink: add one debug check in nla_nest_end()")
> syzbot found that br_fill_linkxstats() can send corrupted netlink packets.
> 
> Make sure the nested attribute size is bounded.
> 
> Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
> Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a0b0da3.050a0220.175f0c.0000.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

