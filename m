Return-Path: <netdev+bounces-63693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1082EEA2
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 13:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A24B22C80
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6751B950;
	Tue, 16 Jan 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlX+422x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412F1B944
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzi8aAm31mNvKJdA4nTi0raeNFo36R/za5YnPC4Lfv+HBfbqb+MMXtRtT0GO3TyNsdB4i+HkFEPSzHnVpGb8NGAYsWOGKtVxGnEH1XYvLPeZ/Ms7AkfCiFtGKZZjxkLDRVj3pmo6eHxpCiTIlBtLltOn+xu9qOYNPGuZReTI07ALz2MZgPOfbs2JKts0aZSV068EnambhzBTUdjiCpoDdgfMZ9K+6xtgSCz3nwOpmnKY4VWU47WmiEl7wJAWZRAEPF9e3ogI7fKFMQuauYkVAs9YPKJveN/A7Vl2QmPRNDRMgJMGM6fX4Q4bJ+L2PjSHdBiNvOj9UX+fJbVKR1YrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuXiEU4181iBlnnH1pybMPUuvQ7MOvAAxs5Rs+54PTM=;
 b=Mg0JhhZmKd1Fzzs8x0f/IxRjf5TlGZju2vzxpIG9IccAanmZSj/+iCMSip+9UD9mzTdcUt4zYoYiIBFrRyncIbR8+JlldtaNtVI0MFZgRpA5/Io9dEB5hPbhE7E3JamX99ItJU7PP0M8+Kh3XiwNGShCmlOUMq/g9hT1GYf7qFLvCyXJFXe8cVNyn+zO87mpDj2i4O/br1EUb8aKnWcffEAqNhXI9HEG103M003YP+QX0RmBtQjxmywqwO1Nna2O0F4PzyrrQFyhiUjTVhG04psJZQDz2/k1b6CdZPkmz2InfN48K6egj/ghp6tObBEFuWtW2lRT/OXcDgglffdMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuXiEU4181iBlnnH1pybMPUuvQ7MOvAAxs5Rs+54PTM=;
 b=rlX+422x5VljuA/cUQ3Pw9r/1J5O/aySDHEB6mTNkHMmh0s3+bShGIFgIB6iiKizURmhEhDQ+xjWHUodRV55bWAdPomDt3szMA30Zl8PcxmNB1Fd+qIZo4PF3FNSDbBPL7wzfTkgZ7uzXItB/5oKS697GQ2gXg4gvfD6Ft/+38x/bJpy7gprYuNsdXpg8qR3nsKbF3dIpWNm18F0CkrT5GplIiWHqsesRucOLjGRSVr5wR954kdenBFUrg1BW+47VdaPAAGkcMQW6IqKwbZEyoPffVnapYwjV+cU4Yt/rOFW7khATBF3LFXNJ2J45YBCIJU5GbORLP+9p7kDYS2mUA==
Received: from BLAPR03CA0162.namprd03.prod.outlook.com (2603:10b6:208:32f::22)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 12:02:59 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::dd) by BLAPR03CA0162.outlook.office365.com
 (2603:10b6:208:32f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30 via Frontend
 Transport; Tue, 16 Jan 2024 12:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 16 Jan 2024 12:02:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 04:02:42 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 04:02:39 -0800
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
 <878r4volo0.fsf@nvidia.com>
 <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
 <87zfxbmp5i.fsf@nvidia.com>
 <CAM0EoMmC1z9SzF7zNtquPinBDr3Zu-wfKKRU0CMK3SP4ZobOsg@mail.gmail.com>
 <87v87ymqzq.fsf@nvidia.com>
 <CAM0EoMmLhg7DW4qOT0FZTpYN5rFX+406oNY3-wZv98td4X4Uhg@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: Petr Machata <petrm@nvidia.com>, Petr Machata <me@pmachata.org>, "Ido
 Schimmel" <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <xiyou.wangcong@gmail.com>,
	<victor@mojatatu.com>, <pctammela@mojatatu.com>, <mleitner@redhat.com>,
	<vladbu@nvidia.com>, <paulb@nvidia.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Date: Tue, 16 Jan 2024 11:15:11 +0100
In-Reply-To: <CAM0EoMmLhg7DW4qOT0FZTpYN5rFX+406oNY3-wZv98td4X4Uhg@mail.gmail.com>
Message-ID: <875xztmqoz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b053c61-f675-46f8-fb1f-08dc168b151c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4T/6qdciw1uqDw4glv/z6en9fLgokzthARHtZlqMZXl5/M/GrjcG4jfNnTGdlVsCRlOXtRwRO20SWsz0hbiaqojBdBAm5xj+5CKoEKlDMqs/SFJY+9bz80evH75J6vwlbIviHAyOvWsqkEEJHavScSYDb5BAzwQ1Z1mxnSI22Nfwue5NsUVF1Z5diNxcTL+ekZVHoswHkmcEnJ3qrhsghefNWtQVslu+hZDaQunrElWO8lg5uid00VKq1k2YBLvHq/H1IiJomC/n+d40u9PiZr54bAFuDOS6490hN2oJMMrFHitK7OytPWJ40ur57+E0S0DxYJq+BJ5GoEeOE7RIfu+lZTRjMERQpVhekwlmXt1TOA4/Eg6UAom/R6TwjSy+xsX+AiKJiFukrajXjDNV6/mlNJmrEMA6TyUMW+qH19nOrKH8MH/ubA1uLd0BiIzBhOKJTTRywlTFgleSPljrVGiPUYZPD+ho8dbSq5POvcIXtBUpe2OO4E/RZX03L0IN/tBduVPEgHemqIAf2H63rnt7tH9aN6kUZv5uBg9dyUZ8//zrTVNqFW5a0mSI27KPfjlSJg2qytACLXmKkE1vHe2nueM6RSe/iukicf1pkeM4XGroXQQU6MMnVrCs7rtMlBDJOLBhsux9UwfeygJl2Ge3g6V42nroFgsO8+KSL3DAUe4uIN/3YmHhOGe3GWzFi5SztYRihYeXr2MNhzRcsIrvNOHhSl97J+rz3aiYElMN5mRpeA+P/G+VL5NkG/O/
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(86362001)(66899024)(70586007)(53546011)(36756003)(16526019)(2616005)(83380400001)(426003)(336012)(7636003)(356005)(47076005)(107886003)(26005)(2906002)(30864003)(7416002)(316002)(5660300002)(54906003)(6666004)(478600001)(4326008)(70206006)(82740400003)(36860700001)(41300700001)(6916009)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 12:02:58.8222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b053c61-f675-46f8-fb1f-08dc168b151c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018


Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Fri, Jan 12, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.com> =
wrote:
>>
>>
>> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>>
>> > On Thu, Jan 11, 2024 at 6:22=E2=80=AFPM Petr Machata <me@pmachata.org>=
 wrote:
>> >>
>> >> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>> >> > So a packet tagged for early drop will end up being processed in so=
me
>> >> > filter chain with some specified actions. So in the case of offload,
>> >> > does it mean early drops will be sent to the kernel and land at the
>> >> > specific chain? Also trying to understand (in retrospect, not armch=
air
>> >>
>> >> For offload, the idea is that the silicon is configured to do the thi=
ngs
>> >> that the user configures at the qevent.
>> >
>> > Ok, so none of these qevents related packets need to escape to s/w the=
n.
>>
>> Like yeah, I suppose drops and marks shouldn't be /that/ numerous, so
>> maybe you can get away with the cookie / schedule from driver that you
>> talk about below. But you've got dozens of ports each of which is
>> capable of flooding the PCI on its own. I can see this working for like
>> connection tracking, or some other sort of miss that gets quickly
>> installed in HW and future traffic stays there. I'm not sure it makes
>> sense as a strategy for basically unbounded amounts of drops.
>
> I misunderstood this to be more to trigger the control plane to do
> something like adjust buffer sizes etc, etc. But if you are getting a
> lot of these packets like you said it will be tantamount to a DoS.
> For monitoring purposes (which seems to be the motivation here) I
> wouldnt send pkts to the kernel.
> Mirroring that you pointed to is sane, possibly even to a remote
> machine dedicated for this makes more sense. BTW, is there a way for
> the receiving end (where the packet is mirrored to) to know if the
> packet they received was due to a RED drop or threshold excess/ecn
> mark?

Spectrum supports these mirror headers. They are sandwiched between the
encapsulation headers of the mirrored packets and the actual packet, and
tell you the RX and TX ports, what was the mirror reason, some
timestamps, etc. Without this, you need to encode the information into
like parts of IPv6 or what not.

But it's a proprietary format. It could be expressed as a netdevice, or
maybe a special version in the ERSPAN netdevice. But there's no
standard, or public documentation, no open source tools that would
consume it. AFAIK. So adding code to ERSPAN to support it looks like a
non-starter.

I was also toying with approaches around some push_header action, but it
all seemed too clumsy. Also unclear how to express things like
timestamps, port labels, mirror reasons, latency, queue depths... It's
very, very HW-oriented header.

I suppose with P4 there might be a way for the user to describe the
encapsulation and for the driver to recognize it as the mirror header
and offload properly. With some squinting: frankly I don't see anybody
encoding things like queue depths, or anybody writing the driver code to
recognize that indeed that's what it is.

>> >> In the particular case of mlxsw, we only permit adding one chain with
>> >> one filter, which has to be a matchall, and the action has to be eith=
er
>> >> a mirred or trap, plus it needs to have hw_stats disabled. Because the
>> >> HW is limited like that, it can't do much in that context.
>> >>
>> >
>> > Understood. The challenge right now is we depend on a human to know
>> > what the h/w constraints are and on misconfig you reject the bad
>> > config. The other model is you query for the h/w capabilities and then
>> > only allow valid config (in case of skip_sw)
>>
>> This is not new with qevents though. The whole TC offload is an exercise
>> in return -EOPNOTSUPP. And half VXLAN, and IPIP, and, and. But I guess
>> that's your point, that this sucks as a general approach?
>
> Current scheme works fine - and in some cases is unavoidable. In P4 it
> is different because resources are reserved; so by the time the
> request hits the kernel, the tc layer already knows if such a request
> will succeed or not if sent to the driver. This would be hard to do if
> you have dynamic clever resourcing where you are continuously
> adjusting the hardware resources - either growing or shrinking them
> (as i think the mlxsw works); in such a case sending to the driver
> makes more sense.

The HW does some of that, in the sense that there are shared tables used
by various stages of the pipeline for different things, so more of one
means less of another. The driver is fairly simplistic though, most of
the time anyway, and just configures what the user tells it to. The only
exception might be ACLs, but even there it's nothing like noticing, oh,
none of my rules so far uses header XYZ, so I can use this denser way of
encoding the keys, to satisfy this request to cram in more stuff. If as
a user you want this effect, you are supposed to use chain templates to
give the driver a better idea of the shape of things to come.

>> >> > lawyering): why was a block necessary? feels like the goto chain
>> >> > action could have worked, no? i.e something like: qevent early_drop
>> >> > goto chain x.. Is the block perhaps tied to something in the h/w or=
 is
>> >> > it just some clever metainfo that is used to jump to tc block when =
the
>> >> > exceptions happen?
>> >>
>> >> So yeah, blocks are super fancy compared to what the HW can actually =
do.
>> >
>> > My curiosity on blocks was more if the ports added to a block are
>> > related somehow from a grouping perspective and in particular to the
>> > h/w.
>>
>> Not necessarily. You could have two nics from different vendors with
>> different offloading capabilities, and still share the same block with
>> both, so long as you use the subset of features common to both.
>
> True, for the general case. The hard part is dealing with exceptions,
> for example, lets say we have two vendors who can both mirror in
> hardware:
> if you have a rule to mirror from vendor A port 0 to vendor B port 1,
> it cant be done from Vendor A's ASIC directly. It would work if you
> made it an exception that goes via kernel and some tc chain there
> picks it up and sends it to vendor B's port1. You can probably do some
> clever things like have direct DMA from vendor A to B, but that would
> be very speacilized code.

Yep.

>> > For example in P4TC, at a hardware level we are looking to use
>> > blocks to group devices that are under one PCI-dev (PF, VFs, etc) -
>> > mostly this is because the underlying ASIC has them related already
>> > (and if for example you said to mirror from one to the other it would
>> > work whether in s/w or h/w)
>>
>> Yeah, I've noticed the "flood to other ports" patches. This is an
>> interesting use case, but not one that was necessarily part of the
>> blocks abstraction IMHO. I think originally blocks were just a sharing
>> mechanism, which was the mindset with which I worked on qevents.
>
> Basically now if you attach a mirror to a block all netdevs on that
> block will receive a copy, note sure if that will have any effect on
> what you are doing.

I'm not sure what semantics of mirroring to a qevent block are, but
beyond that, it shouldn't impact us. Such rule would be punted from HW
datapath, because there's no netdevice, and we demand a netdevice (plus
conditions on what the netdevice is allowed be).

> Note:
> Sharing of tables, actions, etc (or as P4 calls them
> programs/pipelines) for all the ports in a block is still in play.
> Challenge: assume vendor A from earlier has N ports which are part of
> block 11: There is no need for vendor A's driver to register its tc
> callback everytime one of the N ports get added into the block, one
> should be enough (at least that is the thought process in the
> discussions for offloads with P4TC).
> Vendor A and B both register once, then you can replay the same rule
> request to both. For actions that dont require cross-ASIC activity
> (example a "drop")  it works fine because it will be localized.

Sounds reasonable so far, but reads like something that misses a
"however, consider" or "now the challenge is to" :)

>> >> Blocks have no such issues, they are self-contained. They are heavy
>> >> compared to what we need, true. But that's not really an issue -- the
>> >> driver can bounce invalid configuration just fine. And there's no risk
>> >> of making another driver or SW datapath user unhappy because their set
>> >> of constrants is something we didn't anticipate. Conceptually it's
>> >> cleaner than if we had just one action / one rule / one chain, because
>> >> you can point at e.g. ingress_block and say, this, it's the same as
>> >> this, except instead of all ingress packets, only those that are
>> >> early_dropped are passed through.
>> >
>> > /nod
>> >
>> >> BTW, newer Spectrum chips actually allow (some?) ACL matching to run =
in
>> >> the qevent context, so we may end up relaxing the matchall requirement
>> >> in the future and do a more complex offload of qevents.
>> >
>> > In P4 a lot of this could be modelled to one's liking really - but
>> > that's a different discussion.
>>
>> Pretty sure :)
>>
>> BTW Spectrum's ACLs are really fairly close to what flower is doing.
>> At least that's the ABI we get to work with. Not really a good target
>> for u32 at all. So I suspect that P4 would end up looking remarkably
>> flower-like, no offsets or layouts, most of it just pure symbolics.
>>
>
> Its a "fixed" ASIC, so it is expected. But: One should be able to
> express the Spectrum's ACLs or even the whole datapath as a P4 program

Yeah, I think so, too.

> and i dont see why it wouldnt work with P4TC. Matty has at least once
> in the past, if i am not mistaken, pitched such an idea.

I don't see why it wouldn't work. What I'm saying is that at least the
ACL bits will just look fairly close to flower, because that's the HW we
are working with. And then the benefits of P4 are not as clear, because
flower is already here and also looks like flower.

On the upside, we would get more flexibility with different matching
approaches. Mixing different matchers is awkward (say flower + basic
might occasionally be useful), so there's this tendency to cram
everything into flower.

I mentioned the mirror headers above, that's one area where TC just
doesn't have the tools we need.

>> >> >> > Also: Is it only Red or other qdiscs could behave this way?
>> >> >>
>> >> >> Currently only red supports any qevents at all, but in principle t=
he
>> >> >> mechanism is reusable. With my mlxsw hat on, an obvious next candi=
date
>> >> >> would be tail_drop on FIFO qdisc.
>> >> >
>> >> > Sounds cool. I can see use even for s/w only dpath.
>> >>
>> >> FIFO is tricky to extend BTW. I wrote some patches way back before it
>> >> got backburner'd, and the only payloads that are currently bounced are
>> >> those that are <=3D3 bytes. Everything else is interpreted to mean
>> >> something, extra garbage is ignored, etc. Fun fun.
>> >
>> > FIFO may have undergone too many changes to be general purpose anymore
>> > (thinking of the attempts to make it lockless in particular) but I
>> > would think that all you need is to share the netlink attributes with
>> > the h/w, no? i.e you need a new attribute to enable qevents on fifo.
>>
>> Like the buffer model of our HW is just wildly incompatible with qdiscs'
>> ideas. But that's not what I wanted to say. Say you want to add a new
>> configuration knob to FIFO, e.g. the tail_drop qevent. How do you
>> configure it?
>>
>> For reasonable qdiscs it's a simple matter of adding new attributes. But
>> with FIFO, there _are_ no attributes. It's literally just if no nlattr,
>> use defaults, otherwise bounce if the payload size < 4, else first 4
>> bytes are limit and ignore the rest. Done & done. No attributes, and
>> nowhere to put them in a backward compatible manner. So extending it is
>> a bit hacky. (Can be done safely I believe, but it's not very pretty.)
>
> I believe you but will have to look to make sense. There's at least
> one attribute you mention above carried in some data structure in a
> TLV (if i am not mistaken it is queue size either in packet or bytes,
> depending on which fifo mode you are running). You are saying you cant
> add another one or a flag at least?

Not backward-compatibly. The sole attribute's payload is interpreted as
follows:

- length<4? Bounce.
- length>=3D4? First u32 is queue limit, the rest is ignored garbage.

So you have to stash any new stuff into the now-ignored garbage, thus
changing behavior. The I-think-safe approach that I mention above is
passing limit=3D0 and serializing the real attribute tree into the garbage
area. So if limit=3D0 and the garbage parses as an atrribute tree, use
that, otherwise it's really just limit of 0 and some garbage.

I think this is safe, because the combination of limit=3D0 (already an
improbable configuration) and parseable garbage is unlikely to arise by
mistake. But it's kludgy.

Or maybe the flag could be in the message header, but that seems wrong
given we are talking about extending one qdisc kind.

