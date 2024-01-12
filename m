Return-Path: <netdev+bounces-63315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2AB82C40B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9741D284439
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7903E7763B;
	Fri, 12 Jan 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdsLmfRY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2B7762B
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPAq7Nzt3m9M2Tj2Z9RMtVVjAeUxqYIn1iaHsxSnbDzyC2o/N1eIkq7Wl8OZfbf1FvWBba87Td67FgoA3YmX52hPPUObEPCQGHUCM3dBL2AFHQjinZayMmVXZ4XAb/z7BWFfCk8XcmnK/dEZRK/KNUEFKgTBCGJC5fdUtMk9EbI0virRcZ+N6SvhwXdmte4PKADDZKmHFJDRMZMs/t6mfx6ZI1qP7y0IP0mUeXpoxGUI4PjJkGg64+86sowyPWFXR0cU5F7pvMTi+6Q5/hZn2slC5bYx069mbsizCzwu2DOya6Ni+StPY4GUEq7wBidyPl16E1NxntLJ1ErI1EOMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evXj6CXcVJ/n+MSxql2OrjBF0ChPH4dgtcpAparf2Ig=;
 b=GqKtkFijBaREaYgwGatslCZicg+sHHbYsz4h2GBpMx35VLU/S/ru9beu1MK1aJ8UvsF6luf04Cd79+fkQv5Hesf2B8rciDfBS92EGYB1OSCxKIwZ3FDUNmlcHw3+n7p4s1QhSiZ+OR05z8uNGcMiMiJk4AGty9S5vMdlL3dK7qY+0/UkADqA0giJtxcv58jIgEAs/RYXYJH/e7sjXwwZr+8AbegvE7jp+OCCcYsEJlcfQRMmOR9L3dYnMs5oCU4Md2YNK4S+w/kGa2dlmGYvmF4FL4J3yLBDgdPz7+rMBTX77csoLjp4XBlYol8jK3+s73eKZBUH69Pp6oh/2C326A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evXj6CXcVJ/n+MSxql2OrjBF0ChPH4dgtcpAparf2Ig=;
 b=ZdsLmfRYoaC6OKT/1gAq1dwNEzYcGFI2hqupSdwjdNQ9Gdv2iJ8NLPEd0eoHYr9PvP5XQQE/MX3G4sIRucqDBP5f+m/vNBD5ErMes4BRTF2dlbNS6q4N/8r+zWiTtJssEiCw9RoKyP1A1TnDaoQAYMsDS5HXjlGd+FeTgl8Skspkth98b4jqs0Gm2r2rZHRKRlyzKTQTUAFNcRDT2GBlfJr/5TGBZLX/6b+hmn6ax9eDO40318WgO8E9w4hCuuCYXiUKpljgK36Uke0kYbf2zBytKnU11O0wHfwo17e8/C8vT8v6/lqOt1EmkuehEjOltEumF1ScCJXudqdJGyVu+w==
Received: from SJ0PR13CA0155.namprd13.prod.outlook.com (2603:10b6:a03:2c7::10)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Fri, 12 Jan
 2024 16:55:07 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::7c) by SJ0PR13CA0155.outlook.office365.com
 (2603:10b6:a03:2c7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15 via Frontend
 Transport; Fri, 12 Jan 2024 16:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 16:55:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Jan
 2024 08:54:55 -0800
Received: from yaviefel (10.126.231.35) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Jan
 2024 08:54:51 -0800
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
 <878r4volo0.fsf@nvidia.com>
 <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
 <87zfxbmp5i.fsf@nvidia.com>
 <CAM0EoMmC1z9SzF7zNtquPinBDr3Zu-wfKKRU0CMK3SP4ZobOsg@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: Petr Machata <me@pmachata.org>, Petr Machata <petrm@nvidia.com>, "Ido
 Schimmel" <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <xiyou.wangcong@gmail.com>,
	<victor@mojatatu.com>, <pctammela@mojatatu.com>, <mleitner@redhat.com>,
	<vladbu@nvidia.com>, <paulb@nvidia.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Date: Fri, 12 Jan 2024 16:37:47 +0100
In-Reply-To: <CAM0EoMmC1z9SzF7zNtquPinBDr3Zu-wfKKRU0CMK3SP4ZobOsg@mail.gmail.com>
Message-ID: <87v87ymqzq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 drhqmail201.nvidia.com (10.126.190.180)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afee201-7f79-41ea-7a51-08dc138f3aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DrMQ0Ha8ecYKcb231YtUd2XCiBr5pj7Se9zmKiMiL0tQyWNdnHyAEu8cH/VXrfGe4XDJhFWYmXdGFPWXL9ibsLBIa2wUHWxsZgxO4CSU4U+6X9Z/9MK8w2a5ctIYo5cYHeygrZOLlSb3AlSC7oUnT+Zo6TSE/QHuovy6JErUVB4O9KwL4DlHRvi4rn3jSt7hRx4tYeRVk4ooXbkOTIHCDUk0ZoOz/6GW5sNwBik60merpfoE4/6LoNLN3JoCs5jM860ivsCzypHFL9xrwDNk95kMqRY1nhIJTfnAPLsN7Q9ZaUIekEIOo3ci8qkoTK/0J1bcbg1jELQq8TliD+fPUaA2d56/Lst3l509skQ/aGLxtJrXWhqqnJRxPWqS8+UQwb4u33JuEl/melayxtnnc3jkoim5pHB4WS4dXiaXeud87kl412eA/h6zNeVKRvmySDV6qGqIzd5n196vbLge+bwGKfl4FiTfKHWJ40DahLBvTFDw8Dy36QkYAIWr4hFdudad/HJfLs16BlFGfBup4WN4ZfKiqEgUMWS9R9KH47zfjG/zgqkS4oWpbwTnC2lqHDzKOGBQK5Bx6DgIZIWMaEUu1Bu9K6EgcZOW6ysJzgyA8bczcb7KNlwRevYJgrLSRggz7P/JXZIFlF2HsHhcs56z9ztNw1dDEdQP3JAH/OytN+Vl68rSRm/BzT89cQc0Hv7VFylSOJCBnexeCjqi/CKHEuyk6P0QwgNastQTLzxNqO0P3RS5LfR8Sv0zKAUHulE6Srk8PZMoj1raBuBPaiu/c4LNDa2sZNUhJtPnTBk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(30864003)(2906002)(7416002)(5660300002)(426003)(2616005)(8676002)(86362001)(478600001)(6666004)(336012)(70206006)(26005)(70586007)(53546011)(36756003)(316002)(8936002)(54906003)(6916009)(82740400003)(36860700001)(83380400001)(4326008)(107886003)(47076005)(16526019)(7636003)(356005)(41300700001)(966005)(40460700003)(40480700001)(66899024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:55:06.5219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afee201-7f79-41ea-7a51-08dc138f3aae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077


Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Thu, Jan 11, 2024 at 6:22=E2=80=AFPM Petr Machata <me@pmachata.org> wr=
ote:
>>
>> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>>
>> > On Thu, Jan 11, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.co=
m> wrote:
>> >
>> >> qevents are binding locations for blocks, similar in principle to
>> >> clsact's ingress_block / egress_block. So the way to create a block is
>> >> the same: just mention the block number for the first time.
>> >>
>> >> What qevents there are depends on the qdisc. They are supposed to
>> >> reflect events that are somehow interesting, from the point of view of
>> >> an skb within a qdisc. Thus RED has two qevents: early_drop for packe=
ts
>> >> that were chosen to be, well, dropped early, and mark for packets that
>> >> are ECN-marked. So when a packet is, say, early-dropped, the RED qdisc
>> >> passes it through the TC block bound at that qevent (if any).
>> >>
>> >
>> > Ok, the confusing part was the missing block command. I am assuming in
>> > addition to Ido's example one would need to create block 10 and then
>> > attach a filter to it?
>> > Something like:
>> > tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min
>> > 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
>> > early_drop block 10
>> > tc filter add block 10 ...
>>
>> Yes, correct.
>>
>> > So a packet tagged for early drop will end up being processed in some
>> > filter chain with some specified actions. So in the case of offload,
>> > does it mean early drops will be sent to the kernel and land at the
>> > specific chain? Also trying to understand (in retrospect, not armchair
>>
>> For offload, the idea is that the silicon is configured to do the things
>> that the user configures at the qevent.
>
> Ok, so none of these qevents related packets need to escape to s/w then.

Like yeah, I suppose drops and marks shouldn't be /that/ numerous, so
maybe you can get away with the cookie / schedule from driver that you
talk about below. But you've got dozens of ports each of which is
capable of flooding the PCI on its own. I can see this working for like
connection tracking, or some other sort of miss that gets quickly
installed in HW and future traffic stays there. I'm not sure it makes
sense as a strategy for basically unbounded amounts of drops.

>> In the particular case of mlxsw, we only permit adding one chain with
>> one filter, which has to be a matchall, and the action has to be either
>> a mirred or trap, plus it needs to have hw_stats disabled. Because the
>> HW is limited like that, it can't do much in that context.
>>
>
> Understood. The challenge right now is we depend on a human to know
> what the h/w constraints are and on misconfig you reject the bad
> config. The other model is you query for the h/w capabilities and then
> only allow valid config (in case of skip_sw)

This is not new with qevents though. The whole TC offload is an exercise
in return -EOPNOTSUPP. And half VXLAN, and IPIP, and, and. But I guess
that's your point, that this sucks as a general approach?

>> > lawyering): why was a block necessary? feels like the goto chain
>> > action could have worked, no? i.e something like: qevent early_drop
>> > goto chain x.. Is the block perhaps tied to something in the h/w or is
>> > it just some clever metainfo that is used to jump to tc block when the
>> > exceptions happen?
>>
>> So yeah, blocks are super fancy compared to what the HW can actually do.
>
> My curiosity on blocks was more if the ports added to a block are
> related somehow from a grouping perspective and in particular to the
> h/w.

Not necessarily. You could have two nics from different vendors with
different offloading capabilities, and still share the same block with
both, so long as you use the subset of features common to both.

> For example in P4TC, at a hardware level we are looking to use
> blocks to group devices that are under one PCI-dev (PF, VFs, etc) -
> mostly this is because the underlying ASIC has them related already
> (and if for example you said to mirror from one to the other it would
> work whether in s/w or h/w)

Yeah, I've noticed the "flood to other ports" patches. This is an
interesting use case, but not one that was necessarily part of the
blocks abstraction IMHO. I think originally blocks were just a sharing
mechanism, which was the mindset with which I worked on qevents.

>> The initial idea was to have a single action, but then what if the HW
>> can do more than that? And qdiscs still exist as SW entitites obviously,
>> why limit ourselves to a single action in SW? OK, so maybe we can make
>> that one action a goto chain, where the real stuff is, but where would
>> it look the chain up? On ingress? Egress? So say that we know where to
>> look it up,
>
> Note: At the NIC offloads i have seen - typically it is the driver
> that would maintain such state and would know where to jump to.
>
>> but then also you'll end up with totally unhinged actions on
>> an ingress / egress qdisc that are there just as jump targets of some
>> qevent. Plus the set of actions permissible on ingress / egress can be
>> arbitrarily different from the set of actions permissible on a qevent,
>> which makes the validation in an offloading driver difficult. And chain
>> reuse is really not a thing in Linux TC, so keeping a chain on its own
>> seems wrong. Plus the goto chain is still unclear in that scenario.
>
> It is a configuration/policy domain and requires human knowledge. The
> NIC guys do it today. There's some default assumptions of "missed"
> lookups - which end up as exceptions on chain 0 of the same qdisc
> where skip_sw is configured. But you are right on the ingress/egress
> issues: the NIC model at the moment assumes an ingress only approach
> (at least in the ASICs), whereas you as a switch have to deal with
> both. The good news is that TC can be taught to handle both.

Oh, right. You mean give the packets a cookie to recognize them later,
and do the scheduling by hand in the driver. Instead of injecting to
ingress, directly pass the packet through some chain. But again, you
need a well-defined way to specify which chain should be invoked, and it
needs to work for any qdisc that decides to implement qevents. I know I
sound like a broken record, but just make that reference be a block
number and it's done for you, and everybody will agree on the semantics.

>> Blocks have no such issues, they are self-contained. They are heavy
>> compared to what we need, true. But that's not really an issue -- the
>> driver can bounce invalid configuration just fine. And there's no risk
>> of making another driver or SW datapath user unhappy because their set
>> of constrants is something we didn't anticipate. Conceptually it's
>> cleaner than if we had just one action / one rule / one chain, because
>> you can point at e.g. ingress_block and say, this, it's the same as
>> this, except instead of all ingress packets, only those that are
>> early_dropped are passed through.
>
> /nod
>
>> BTW, newer Spectrum chips actually allow (some?) ACL matching to run in
>> the qevent context, so we may end up relaxing the matchall requirement
>> in the future and do a more complex offload of qevents.
>
> In P4 a lot of this could be modelled to one's liking really - but
> that's a different discussion.

Pretty sure :)

BTW Spectrum's ACLs are really fairly close to what flower is doing.
At least that's the ABI we get to work with. Not really a good target
for u32 at all. So I suspect that P4 would end up looking remarkably
flower-like, no offsets or layouts, most of it just pure symbolics.

>> > Important thing is we need tests so we can catch these regressions in
>> > the future.  If you can, point me to some (outside of the ones Ido
>> > posted) and we'll put them on tdc.
>>
>> We just have the followin. Pretty sure that's where Ido's come from:
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
>>
>> Which is doing this (or s/early_drop/mark/ instead):
>>
>>     tc qdisc add dev $swp3 parent 1: handle 108: red \
>>             limit 1000000 min $BACKLOG max $((BACKLOG + 1)) \
>>             probability 1.0 avpkt 8000 burst 38 qevent early_drop block =
10
>>
>> And then installing a rule like one of these:
>>
>>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
>>             action mirred egress mirror dev $swp2 hw_stats disabled
>>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
>>             action trap hw_stats disabled
>>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
>>             action trap_fwd hw_stats disabled
>>
>> Then in runs traffic and checks the right amount gets mirrored or trappe=
d.
>>
>
> Makes sense. Is the Red piece offloaded as well?

Yeah, it does offload the early dropping / ECN marking logic, as per the
configured min/max, if that's what you mean.

>> >> > Also: Is it only Red or other qdiscs could behave this way?
>> >>
>> >> Currently only red supports any qevents at all, but in principle the
>> >> mechanism is reusable. With my mlxsw hat on, an obvious next candidate
>> >> would be tail_drop on FIFO qdisc.
>> >
>> > Sounds cool. I can see use even for s/w only dpath.
>>
>> FIFO is tricky to extend BTW. I wrote some patches way back before it
>> got backburner'd, and the only payloads that are currently bounced are
>> those that are <=3D3 bytes. Everything else is interpreted to mean
>> something, extra garbage is ignored, etc. Fun fun.
>
> FIFO may have undergone too many changes to be general purpose anymore
> (thinking of the attempts to make it lockless in particular) but I
> would think that all you need is to share the netlink attributes with
> the h/w, no? i.e you need a new attribute to enable qevents on fifo.

Like the buffer model of our HW is just wildly incompatible with qdiscs'
ideas. But that's not what I wanted to say. Say you want to add a new
configuration knob to FIFO, e.g. the tail_drop qevent. How do you
configure it?

For reasonable qdiscs it's a simple matter of adding new attributes. But
with FIFO, there _are_ no attributes. It's literally just if no nlattr,
use defaults, otherwise bounce if the payload size < 4, else first 4
bytes are limit and ignore the rest. Done & done. No attributes, and
nowhere to put them in a backward compatible manner. So extending it is
a bit hacky. (Can be done safely I believe, but it's not very pretty.)

