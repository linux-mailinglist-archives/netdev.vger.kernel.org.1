Return-Path: <netdev+bounces-19481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE675ADA3
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA01C213DE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C218001;
	Thu, 20 Jul 2023 11:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC42598
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:58:37 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::61a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE9E4C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TacfSbm508EF/RDGvHKnZ8Bg2hYq/ssx8vEzII6mVa2WkuUXgdTHOuE5wCv9aZ/GOAdOAvo6cV0+fikAFNgf4Al5/mPEPzSWcXclT4iRVRWCu0tfwt5jrvUk2sJI4/wT8WKZGerO3yZgBtNM9pEdCUtWBX50Vo7+deHiG+jXyrp2VEO8HccT0kemGvPO94/2vC602D5RM7/IysOEoYyhdbF0+xxBi3K9p/uk9YHkOBIDuRmW0ot38Mt7oIzu1tQzfAQRBCTZOPXLv57dJyxyj1iVqbecjK6txJygad5OFqHzBFaFuBlaN9ktXHt6grKZUJs95Aum9KS+HWJkKqSu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0QrW5CquHbYiqHt80O0S3erqWVCL08hVrJLC1bwdfk=;
 b=j2AZOgQHsJC/FjlX3nlsJRxMc3fPctjGEqgV1SHimy4o3c2rhsnGNphGgm5T+Xn4YX2jp9LhhkQ0/A+wkPpqb2k2oonugEuzHpi7kcqx+Twwubm4cerxEATgnml2LyzGmimVwwwOmSgYSsAVxPgZw/SdLXshV+Uie0vq0V7BMz/0hKCtAkpX5vERrsqbnrySZwQj4F9LFU4NiooxTUeWb1Al/w+frX9M1GhFJphZZSF5uy8IqgLvbAnPP452mKiX4rLFY6BrsiLr7TF11ztt+HXviLdE49WczzXph3JB+qIcK+oKqBCjKrdvEsQ6khYiel2+B3xvSARLpyLIShFTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0QrW5CquHbYiqHt80O0S3erqWVCL08hVrJLC1bwdfk=;
 b=idJtHuwTnlBmguc00BJQTUFVwNoo8o82OhdM456D21/Ceb1L97H/p8vzHDGw/bCW60GERGc4FZOYagterQdEK19P7jRK8BdH7CatdKJl5IPmeOzicTR79S6hY12g/fsrjn/1ZATrbbJSmQgijnrxICoYH46qrYALtM4wf4OJLuatdxpMr/2mXX08oV1qNKhyCZLM4Tg2wXHlrXZEsZSlwP/1SivmyiOBGuVuraz3BDQ03+8oUwLae/86KPDYclRfHLQBMLN/sZuDlZeDqXXzXIiB9ePPt4HEV4Xq6nsUPsDRcHaF6pX0xkGqCYIddYUYVi5819LJojYNpUWPRZtEqQ==
Received: from BN8PR15CA0033.namprd15.prod.outlook.com (2603:10b6:408:c0::46)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 11:58:30 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::c3) by BN8PR15CA0033.outlook.office365.com
 (2603:10b6:408:c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 11:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 11:58:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Jul 2023
 04:58:18 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 20 Jul
 2023 04:58:16 -0700
References: <20230719185106.17614-1-gioele@svario.it>
 <20230719143628.4ca42c3f@hermes.local>
 <6041446f-ad4f-1b5a-9b7e-b496de080468@svario.it>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Gioele Barabucci <gioele@svario.it>
CC: Stephen Hemminger <stephen@networkplumber.org>, <netdev@vger.kernel.org>
Subject: Re: [iproute2 00/22] Support for stateless configuration (read from
 /etc and /usr)
Date: Thu, 20 Jul 2023 13:56:56 +0200
In-Reply-To: <6041446f-ad4f-1b5a-9b7e-b496de080468@svario.it>
Message-ID: <87v8ee7q21.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: af182906-c33d-4142-c1a3-08db8918a285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kwHwery4X85RFN6BNMPMR7Wvx6BYo49uU/bKrh+ptBqbpenxYyAqGp6o8qixqiAMJu17JgXqvUMjv7FMqh4kCmeMfbtSKxO5fuG2HX96vr/Krdnk24S+G5liL+Uas7exwRK/LI38WilHs6ihuc4sIyTjFZk/GY7erRtYeeo6IVV5qB7NqzO+RsJ49nOACJDBU1uoICMJFgkpd21wLyOM65aDbVzMqFbZ+VQx9T1rchXzGm2tYIxXlj0mlH6/DWIgtZBfk+79B0gB11yMllH16QI39FudAA/Bw3WGH/08SlbuCvtKuqJc4K4hdh6LXJcE8dri0yTtV9EzWo6L3S5K66/X6rXhfguA75ZSWCkODRRxSqjDhATFyBXhnySUP1QroEEYcHbyou0RLbapYrDgnQIrhReEIxMAv3If5d6S1IHGskr+SMN06FFouFYe9OgqcWLwxGCCQXFuPX2EYno1JvNqTemX3/lMAZ211zPBo4n/ThADUIHFfDs+GFsdFBSbjHSPDfL5SHOPCwlcUzNQf1/18vIjOm2s4aM8xIXXgtLYX+WQfiLTJKSI8OQ2jwToUaZfVI8UdgdaCMyEtevbv5SioQzhexcf9HqPSgMgmk/3M0K2rz7m4cmG3aSEde64iqy++b+6ReoBZMbDws5P/PJjjeXnVVqHBQ5l9S4zFihkfUmgk5spa07fFu2Rac4gUztHAZCzQUJt2ILHVMFfYGglPvOXsYS0bkk6kY/zmzlG40RBn5DWx1Sj9QagkZG2xEQyjFNgYpiQyD/xjGpbOA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40460700003)(66899021)(356005)(2616005)(7636003)(47076005)(426003)(53546011)(186003)(16526019)(26005)(5660300002)(70586007)(4326008)(8676002)(316002)(41300700001)(2906002)(6666004)(70206006)(966005)(36756003)(6916009)(8936002)(478600001)(54906003)(40480700001)(83380400001)(36860700001)(336012)(82740400003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 11:58:30.0077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af182906-c33d-4142-c1a3-08db8918a285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Gioele Barabucci <gioele@svario.it> writes:

> On 19/07/23 23:36, Stephen Hemminger wrote:
>> On Wed, 19 Jul 2023 20:50:44 +0200
>> Gioele Barabucci <gioele@svario.it> wrote:
>>=20
>>> this patch series adds support for the so called "stateless" configurat=
ion
>>> pattern, i.e. reading the default configuration from /usr while allowing
>>> overriding it in /etc, giving system administrators a way to define loc=
al
>>> configuration without changing any distro-provided files.
>>>
>>> In practice this means that each configuration file FOO is loaded
>>> from /usr/lib/iproute2/FOO unless /etc/iproute2/FOO exists.
>> I don't understand the motivation for the change.
>
> The main, but not the only, motivation for stateless systems is explained=
 in
>
> https://clearlinux.org/features/stateless
> https://fedoraproject.org/wiki/StatelessLinux
> https://summit.debconf.org/debconf15/meeting/276/stateless-cloud-friendly=
-debian/
>
> In a nutshell: to better support factory resets, shared read-only base sy=
stems, containers & Co, all
> software should work even without /etc.
>
> A nice side effect of adopting stateless-style configuration (read from /=
etc, fallback to /usr) is
> that it allows for distro-provided files to be strictly read-only, avoidi=
ng a bunch of common
> failures during updates and upgrades (Debian spends a huge amount of reso=
urces to correctly handle
> these so called "conffiles". The fewer, the better.)
>
>> Is /etc going away in some future version of systemd?
> This is unrelated to systemd, although systemd is probably the most well =
known software that uses
> this pattern.
>
>> Perhaps just using an an environment variable instead of hard coding
>> /etc/iproute2 directory.
>
> Build-time or run-time env variable?
>
> I'd say that run-time env variables (a l=C3=A0 XDG Base Directory) are ki=
nd of hard to deal with in a
> command like `ip` that is often invoked via `sudo` (that filters and chan=
ges env in complex ways).
>
> BTW, I strongly suggest to just go with this common pattern that is now k=
nown to all sysadmins
> instead of inventing an ad-hoc way to move the default configuration away=
 from /etc.
>
>> I do like the conslidation of the initialize_dir code though.
>
> Thanks. :)
>
> Regards,

OK, I looked at a couple bits, and the code looks reasonable overall.
I'll wait for resolution of this discussion before doing full formal
review, so as not to waste effort unnecessarily.

