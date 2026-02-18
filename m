Return-Path: <netdev+bounces-259317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBwnJI7MlWl+UwIAu9opvQ
	(envelope-from <netdev+bounces-259317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:28:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB95B157102
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2704230071F4
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7C327C10;
	Wed, 18 Feb 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XmVxKON1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E6329E43
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424907; cv=pass; b=LNv9NZUMNcgxUz6gDYq68kpcLOM5NvYbqzEqJ+qUPl3aJARL2jCCeFoaxUICV1hjzvqUIJ+EqfB/DoXcuP9RW1eijb5Z5crVbh4tQIpVc70vQmrAULnizSgA8UpoTjlHCscz3Qrsj7e3HkRZxyL4jFseNDXQJslgdInDGLyO4v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424907; c=relaxed/simple;
	bh=ytmQ1Pj+We/VSt3cq3WiGeJoJbgSS+ahgl9LQgmC5yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huG6FUH5Z50s7/Q67ElzQ5WRJ3LTzHJgwqPJFGej+8x+R060xvy4wISKid05Epbjw2pegHRdRLMmGl9+iL4CXczwiXyTgk1/b3PVl2HRw2JPXMA2o9iY9gtnUa47X0GCu3qSav77vz770VRc0s7SyFxh8B7T4useRD0HX0aUxq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=XmVxKON1; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a962230847so45511435ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 06:28:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771424905; cv=none;
        d=google.com; s=arc-20240605;
        b=iV2rVdeCb1bWtvgzbHdmGIL/CNIlmT6klJyq/NKDmQ9XEfRyFe4JIlJAWa6hvQQ8rc
         KXPoB3V1WGBtBC2ot0h3fgOeQbzjgWDJEn5QvOVPI4P0rhLfZaDACYa1l2tdGffIxi1/
         feGzrpr7HE6dJCoOvgGzKGLRhTBHkjhh2P4OSUHPEJqlt3IMUTMoH7Y0vCIMkYb7degc
         2WHbRgEYJUJ3FsO8REVOTyYNeSeJkN3B7qofE7QyCKJq77XvrBps26UNDIrwsjmvihNc
         UiQiNKMaY8I9FAaO2gT15EpyGpQhm3MobH+swGv0ePhmYczkN+g2h0lcQBmLOoNnibQM
         tG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lkQrFZEfUYr4lnUMytUhCXaXQOrjakVRTMgVwHbvc88=;
        fh=+XLqf4oqWWcaLgYm4AGRvcNcnvUmokuaO/O2G05M/Xg=;
        b=ahtByewX37jTGXsjnWkPETRB/zoIYMdhAD/2M4lsQvH/WFa6e3sxqObf3OzaqcJagR
         tRxbDKOOlO9BYbcS6LbhqoigFmBayK5Ic7DXpfTZZ7QN5qnZNQ0L+Nq64YpdoM723oj6
         iyl8FsChNkL9x/R2UQTLw5j5E8wmCg+eL+eRa4P862FHQrvPzT8t1OHskSKiDeK0CbC2
         +dODL/56iSyLwze2jVVROC5SSlKo0EvD3GOSw4pdLqanWQ1oQ9hczWCXs4qkF7I7NPA7
         rwNLQC89n3BpEYR3hoS0AGGV+GtndUWxJxUCjg07Br7xevsttd65PG1WGzqaakeTMcW7
         p4uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771424905; x=1772029705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkQrFZEfUYr4lnUMytUhCXaXQOrjakVRTMgVwHbvc88=;
        b=XmVxKON1zSgm/NURtRdxZbpqfJM67654/zhQTSA68jKfrGFW1jlToBnQEH5ts2w4ac
         muocAEfV56hNSgFiigGZ+Vek5nXT8vL1ahTP9kos4zpgTHUfCdE0hv4A/zMjjPh7hHGO
         XgY2cN1SJHXFBhf+ICqtqs8ulfMh2nOVFnV1CmCOJmrzwUKxFSNb4X9uEMaLBfJz6GP3
         5SiP4uJ4ud1Qph2R2QnqUu3fnAY5bFdVUwsc6sQ6DZC/zE6jynOD7Bb1YOKngOBJAKrF
         mk3r+TLZk08Wly9VnsPnuVxkKrR18ytWNUiVIy3VN/kFsYOsshSrbZGOA5iRrhfxsmca
         N7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771424905; x=1772029705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkQrFZEfUYr4lnUMytUhCXaXQOrjakVRTMgVwHbvc88=;
        b=BVlAXlyCahGnbD0S+asjIek8y6AVaPBYSDXBcGk0jDGONPuwphG0QknoKWVhvX5BI5
         zevBjCnEcZr85H8lUsCfa7hox1rA/2ulK86+etgZzH+U4a4HG8M5bcDDfzq/BHvUl0ak
         i3JWW52GyKRMAOl4RS+1oUbtf6SrzQJUfK+Y7LIsUI+jCHWFlWNUBVQXTq8VZY7/NwvJ
         VMniWyrFg//NCF71xvrsc9pkNP2ZS3O+3IDdye/pO+wUS7PoLTwVqfOZVHqWT3ZDgiV+
         /NyS2q31JME0ynKOJz68n1a245HX69wpksGDIhX4Xd1vxmlPB0gH6gHfljmXtqLZCQ74
         Q5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuiOhiIQO4DnrDcM3Zs6/ZUnO0yft8Jzw6E0JReiZC/GeB5nt1OcbOD1+SNikLMUMU+Z7hc3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lVxNvhTWTEHvunKFfBqBD48DFFjZz9flpxAcDo2ECRUZ1sOG
	m5TmuRwE+VzESNIajI+850jcgCkcyRpTbYZKR7pOUVpov5wZdY/9dT2ef3df75Zm5ZvHaBzUk8e
	/qjijQF7AwUeAq93lYaETIE7S2b3nbdb+6RzkueRE
X-Gm-Gg: AZuq6aInyMOQPagumNKsrKNpJSnlaphpbCNtEVr7ilJI2W3HIvpXldeuD99XD3H9pb8
	TT4e/wXyZpTsDJCUmzu7BlB3O3zyBbk7vVILnVqxfFYYq/KMrt+ZI/YeCJkjeSxRpBhGLxSF2bv
	HFlxeymG3p5TPPBBsBX1mPLBtRJ1LDVN7C4L4y+VPlmou/LRlikFL+rwsjfF39Qntp+ZIZn4xJY
	tRc+9kGUvNX54V/AP+93w1s25PQxlFbkRoJVsnrBdkGfjILGU2lktE+emz3r5IA2IyiuhuZF4yp
	g62Us4+O2KPCQ2WCLtvX4QLTYg==
X-Received: by 2002:a17:903:9cf:b0:2aa:d5ea:56ae with SMTP id
 d9443c01a7336-2ad50e583a7mr18923925ad.2.1771424905197; Wed, 18 Feb 2026
 06:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org> <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org>
In-Reply-To: <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Feb 2026 09:28:14 -0500
X-Gm-Features: AaiRm50HNng2mwl0z17uG-o097jayXvdxRVXMIKFPZd5ZJJOZcPHg7676Dc7TlU
Message-ID: <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Henrik Steen <henrist@henrist.net>, Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>, 
	GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-259317-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,strlen.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CB95B157102
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 2:37=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 2/17/26 4:52 PM, Paolo Abeni wrote:
> > Adding Florian, too
> >
> > On 2/17/26 3:49 PM, Ilya Maximets wrote:
> >> On 2/17/26 10:38 AM, Paolo Abeni wrote:
> >>> Since the blamed commit below, classify can return TC_ACT_CONSUMED wh=
ile
> >>> the current skb being held by the defragmentation engine. As reported=
 by
> >>> GangMin Kim, if such packet is that may cause a UaF when the defrag e=
ngine
> >>> later on tries to tuch again such packet.
> >>>
> >>> act_ct was never meant to be used outside of the ingress path. Making
> >>> defrag really works for act_ct outside such constraints range from ve=
ry
> >>> difficult to completely impossible.
> >>>
> >>> Address the issue making act_ct drop any packet when not attached to =
the
> >>> ingress path and additionally emit a warning about the bad
> >>> configuration.
> >>>
> >>> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> >>> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> >>> CC: stable@vger.kernel.org
> >>> Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e7267442af=
a7.1770394932.git.pabeni@redhat.com
> >>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>> ---
> >>> Catching the bad configuration at runtime instead of init time to red=
uce
> >>> complexity
> >>> ---
> >>>  net/sched/act_ct.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> >>> index 81d488655793..e8eb0d195f4a 100644
> >>> --- a/net/sched/act_ct.c
> >>> +++ b/net/sched/act_ct.c
> >>> @@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff =
*skb, const struct tc_action *a,
> >>>     tcf_lastuse_update(&c->tcf_tm);
> >>>     tcf_action_update_bstats(&c->common, skb);
> >>>
> >>> +   if (!skb_at_tc_ingress(skb)) {
> >>> +           pr_warn_once("act_CT should be attached at ingress!\n");
> >>
> >> Hi, Paolo.  I didn't test this yet, but I'm a little concerned about t=
his
> >> change.  For TC offload of OVS tunnels, we create egress qdisc for int=
ernal
> >> ports, a.k.a. bridge ports.  This is necessary for tunnels to work.
> >> A typical setup looks like this:
> >>
> >>     Bridge br-int (10.0.0.1)
> >>         Port br-int
> >>             Interface br-int
> >>                 type: internal
> >>         Port vm
> >>             Interface vm
> >>         Port vxlan0
> >>             Interface vxlan0
> >>                 type: vxlan
> >>                 options: {remote_ip=3D"172.31.1.1"}
> >>
> >>     Bridge br-phy (172.31.1.100)
> >>         Port br-phy
> >>             Interface br-phy
> >>                 type: internal
> >>         Port eth0
> >>             Interface eth0
> >>
> >> When a VM sends a packet that supposed to go through the tunnel, it en=
ters
> >> from the vm port and OVS forwards it into vxlan0 LWT with an appropria=
te
> >> tunnel metadata.  Then it gets encapsulated and put into kernel routin=
g to
> >> find the next hop, which is via br-phy bridge.  Packet enters br-phy a=
nd
> >> OVS forwards the packet to eth0.  There can be stateful processing in =
the
> >> br-phy bridge involving passing packets through conntrack.
> >>
> >> With the TC offload enabled, OVS creates following filters:
> >>
> >> 1. Ingress filter on vm interface that forwards packets to vxlan0.
> >> 2. Egress filter on br-phy interface that forwards encapsulated packet=
s
> >>    to eth0 interface.
> >>
> >> If some stateful processing is involved, both of those could have act_=
ct
> >> in them.
> >>
> >> AFAIU, we have to use Egress qdisc for the br-phy, because the packet =
is
> >> egressing from the kernel routing via br-phy and the ingress qdisc is =
not
> >> invoked.  Ingress will be at play when packets are flowing in the oppo=
site
> >> direction from eth0 to br-phy, as that's where they will ingress into
> >> standard kernel routing.
> >>
> >> If act_tc will not be allowed on Egress, then stateful processing will
> >> not be possible in this case in br-phy bridge.
> >>
> >> Thoughts?
> >
> > This looks very problematic. A slightly different patch tried to
> > somewhat preserve functionality, but it simply can't work in presence o=
f
> > IP fragments.
> >
> > Why stateful processing on  br-int/port vm ingress is not enough?
>
> In general we don't know where the packet will go after encapsulation,
> so we do not know beforehand if it will end up in another OVS bridge
> or not.  Hence the processing has to be split in two parts, the ingress
> on vm port and egress on the other bridge port.
>
> At the same time, thinking more about potential use cases, I don't see
> a good one for running encapsulated traffic through conntrack.  Most
> of the time it's a UDP unidirectional traffic with hashes for source
> ports.  Not sure what functionality would require to do anything
> stateful on such packets.  So, maybe it's fine to prohibit act_ct on
> the egress after all.
>

Another alternative is to drop packets that have fragments? i.e
Paolo's original patch but instead of accepting to drop
Or perhaps if there are no consequences there is nothing wrong with
Paolo's original patch..

From a validation/testability/debugability POV, assuming its bad to
ignore frags processing:
The issue is for the user to distinguish between a bad setup (like
getting fragments in ct) and a good one where there were no frags. If
I were to write a tdc test to send two packets - one with fragments
and another without - a good way to check is to look at the tc
action/qdisc counters.. Paolo's original patch was accepting in both
cases the counter so the accept counter would read as 2 but if it was
dropped it would say 1 dropped and 1 accepted, so its easy to test (or
the user to debug)

cheers,
jamal

> For the implementation however, let's look at a different very simple
> use case:
>
>    Application on the host -> br-phy -> NAT -> eth0.
>
> This is a very common thing to NAT traffic before it leaves the host.
> It can be for load balancing reasons, e.g. if a destination is a service
> IP with multiple backends and we want multiple applications to hit
> different backends.
>
> There is no actual reason to try and offload such traffic to TC, as it
> would not be possible to offload it to hardware (since the traffic
> source is an application on the host).
>
> However, since OVS doesn't really know that it's not possible to offload
> to hardware and TC by itself allows creation of such filter, it will
> create the filter on the egress qdisc on the bridge port and that egress
> filter will be performing act_ct with the NAT.
>
> With this patch applied, all this traffic will be just dropped.  If we're
> going to prohibit act_ct on egress, that should be done at the moment of
> creation of this action on the egress qdisc, so the user knows that it's
> not supposed to be there.  E.g. if OVS will try to create such action and
> fail, it will keep forwarding the traffic successfully through the normal
> openvswitch datapath.  But if the TC filter creation succeeds, all traffi=
c
> will be just dropped by it.  That doesn't sound right.
>
> Best regards, Ilya Maximets.

