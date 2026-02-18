Return-Path: <netdev+bounces-259346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFU3O4sFlmm4YQIAu9opvQ
	(envelope-from <netdev+bounces-259346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:31:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B9158BAD
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F740301452A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C63033F4;
	Wed, 18 Feb 2026 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZMyvRCPa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B392638BA
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439497; cv=pass; b=qpD9/dNErQnmV60whn0qLZbtYPo8OvvCet17XvgFHjLS53kX3H4CyTyCTJVkGWaDPAumglOXcdINJrIVNd4nE746xw5xcRgpGyo+AWsifnGdsEoEvzFckiPk0/i96w8TakQLawwvHZIVI547HXhwN4hyibAA3XqiwpaadK+s9D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439497; c=relaxed/simple;
	bh=Y6M27Ic0koRP+vl66BEjMrMcLxXTIPaGDfpHMLZrgyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba2x3TPPjSlSjlXcq2HTPPXDwz73U9KV0BVM5uYKB1/5ECHoy8qvZGSbSOqHS1x3KoUycsJgt4dUckaOrppdZVpACfcZh8x4NDhXAVxPJ6js9tyZ+Ua4LR8+v6FEZzt9afWghYnEZTbZCd9uxkVNQMmvueobNt++wkL5sRr0Cik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZMyvRCPa; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c633984fbeeso512747a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:31:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771439494; cv=none;
        d=google.com; s=arc-20240605;
        b=UiMA5I4G9JQo7QQXGWQy1C4ofcouDFSj8X6DXQeEogmFSpfLc/Nq9p4POXcr7YfyMS
         tWCTPFBnN9BT9L3rQ77HAOmL4hms0wjRBfGHe2FMN205iP4UoQP18S6mDvbWZklYXcKO
         DHQEG0eMLCjGus4Xmr0bGj9w8cjuWx9WSxMKtxmqjOg+WsKL70QGOIGtTeYVX4xPU7OS
         ieLsRLwozo3M1kTTFF1PgoJuD7DteFN97syiCfoNjvCX8zHV8wPx4Sj00Up4Y9F01oa+
         Y8hL51SzCIO2cxju36nUbQc2UJ/02x1CsfkkrTUbLfeIAclKfHXAlu5f/1xUKnbRxzWW
         2gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pduTSNbd6jWw3gd8v5Id2JiIC1HzFGZd56C7j90FZ24=;
        fh=fP0cF2SsXBktCWQvutU08ReaKKqNh57MqPyQy0MLgLo=;
        b=gJGRYma3YdD3+gQ6rs1cYO2lN7wkuL9YTUycK63ztL9C/3bkq5VXkuarklYGwWB85o
         zcLOiw6vG/OttY7tqgpRB8QoiP3MsxMhoREiNAwhp62/57LRQDRS/JKuvSsPxaYdiSgs
         n87SD+1x1a0IcnXzv9HddAIZl4kYpG+L0f0Y9qCifYvoFKRbR4YeSwIg9jbFvBgKCvdm
         PUeb+9g4WZqcqEbxlglt9plwFbxt0xM2hAxGmoCey4tB0r+VhMN6EKDfY8Tf1m0oOx4N
         RSaQdW12IfCCSuuJpxaP9lHtGTvSYBS2OYLU0xTgSaeZk5qQ00rhi+7fLkFaEvNAHs2s
         nQqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771439494; x=1772044294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pduTSNbd6jWw3gd8v5Id2JiIC1HzFGZd56C7j90FZ24=;
        b=ZMyvRCPaUmGRVd8AU9SZ3S5V0fbBPev6Cvl8VYU1h1pjXkPz8DPPXM6w3FxO9dhx4n
         5WP7xNjLzsDXI8tH+v0N8iubVZH+l2MTwuiMobDM34XqLrArZyQVS0P95hcttAabpOqk
         NzlQ2eKtgwDBtAfPq4E/rf3KmzoCn2AGp0KLR9GCNiJQeI1jdRvYoGgHcjDucwfsBVwQ
         b87OTSdPezFA/kemR8b3WB9D9Gb7j/cl4/ktBtgqCDwKsRXUksoytoCYzUOqyo40HIF+
         X+nL+fZFqn0TMrTvnpcs6mOBT3tYHyji1J5wQj4EHgHnnT2rGmG59pSivU98u/l3/Mzb
         OQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439494; x=1772044294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pduTSNbd6jWw3gd8v5Id2JiIC1HzFGZd56C7j90FZ24=;
        b=AdINFzILhHO5m78jM2HYXRkBarO/SQ4inJKqf4OX4wO3g/PV9m1x0cCiorhnQBIRcQ
         580uYpZBmIFbz56/nd01X7CesjCIeTVMjcvi5xgf1eZPl/3hQpb6SUebkMm7AlgA0hce
         eO+nobJKaigYmAdYBImP6HWHU+/IQ/KxcEZnIFSOMQbUfl7BacqhstE6j+y2+53JDHsU
         giOxoyFwrJ4sY02nU9PXE+x8uSb26jHpzke5c4qRWv32rM9JCDclaTAcC25Bdgz7fikg
         Amiq24Z8cs0sfCPMkyuTbgwhDFKR9ujUpD7+5P2w73BtZV8GlZU1X6ObxcgwWvFVR3AB
         KgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL7GRszHFUuhxe6Y5uuU9MCti72Lp7WbXrYi95SCUt2QHhC58anzTYo6exHg6BMW5kQTc6QIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoP99yz9Is4qrgsM3RICCLuUdUwIyEMipWZhyDXt+SSI3Hd7p
	1QXEUFqhTPXVfHKUTCdOE7S235oyzLxFTAIa73JfXMuysGXlF5MatCzi8PyaHlt2uNzDYVEMElg
	RlTp9dBAxDb1oimC5RSHn6BjPMZQIMjwbrH8UT23Sgvg2Rm2xuMU=
X-Gm-Gg: AZuq6aL+jOIIczcgHtMkcfDtkd6j2795fxedr9vjWEreDchTM9fisDPOeOpZvuGGbkf
	QLdEi09d2Tw/s14yWkRjbNs23jmhE2HMF18+uY8hiRLaTtkJXgNSgJc72Ggq7bUe5TD04FS7daW
	xd0c+KJvmCVnYMY/FxCzQlAZeygZh4hkNglFjH2kpkWC38AQd6LldaSd76sQwKvWUZsvw6Kphar
	NV4u+DfGPYJAoWh8cRR6VrlnMTVS8wXpGZC56s+wXdflGnASfJUZmok5SIMWszFjna5KTU0/u8J
	OayNLphpe4lr1mw=
X-Received: by 2002:a17:903:2283:b0:2a0:9a3b:d2a4 with SMTP id
 d9443c01a7336-2ad50ba9cdcmr28430915ad.10.1771439494394; Wed, 18 Feb 2026
 10:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org> <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org> <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org>
In-Reply-To: <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Feb 2026 13:31:22 -0500
X-Gm-Features: AaiRm50aeJiTPTDbeUMR5zFyKYtU_D_DdkEj2uho8CVblNGTNUIY_AN3SiGI9k0
Message-ID: <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259346-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,strlen.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 242B9158BAD
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> On 2/18/26 3:28 PM, Jamal Hadi Salim wrote:
> > On Tue, Feb 17, 2026 at 2:37=E2=80=AFPM Ilya Maximets <i.maximets@ovn.o=
rg> wrote:
> >>
> >> On 2/17/26 4:52 PM, Paolo Abeni wrote:
> >>> Adding Florian, too
> >>>
> >>> On 2/17/26 3:49 PM, Ilya Maximets wrote:
> >>>> On 2/17/26 10:38 AM, Paolo Abeni wrote:
> >>>>> Since the blamed commit below, classify can return TC_ACT_CONSUMED =
while
> >>>>> the current skb being held by the defragmentation engine. As report=
ed by
> >>>>> GangMin Kim, if such packet is that may cause a UaF when the defrag=
 engine
> >>>>> later on tries to tuch again such packet.
> >>>>>
> >>>>> act_ct was never meant to be used outside of the ingress path. Maki=
ng
> >>>>> defrag really works for act_ct outside such constraints range from =
very
> >>>>> difficult to completely impossible.
> >>>>>
> >>>>> Address the issue making act_ct drop any packet when not attached t=
o the
> >>>>> ingress path and additionally emit a warning about the bad
> >>>>> configuration.
> >>>>>
> >>>>> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> >>>>> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> >>>>> CC: stable@vger.kernel.org
> >>>>> Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e7267442=
afa7.1770394932.git.pabeni@redhat.com
> >>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>>> ---
> >>>>> Catching the bad configuration at runtime instead of init time to r=
educe
> >>>>> complexity
> >>>>> ---
> >>>>>  net/sched/act_ct.c | 6 ++++++
> >>>>>  1 file changed, 6 insertions(+)
> >>>>>
> >>>>> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> >>>>> index 81d488655793..e8eb0d195f4a 100644
> >>>>> --- a/net/sched/act_ct.c
> >>>>> +++ b/net/sched/act_ct.c
> >>>>> @@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buf=
f *skb, const struct tc_action *a,
> >>>>>     tcf_lastuse_update(&c->tcf_tm);
> >>>>>     tcf_action_update_bstats(&c->common, skb);
> >>>>>
> >>>>> +   if (!skb_at_tc_ingress(skb)) {
> >>>>> +           pr_warn_once("act_CT should be attached at ingress!\n")=
;
> >>>>
> >>>> Hi, Paolo.  I didn't test this yet, but I'm a little concerned about=
 this
> >>>> change.  For TC offload of OVS tunnels, we create egress qdisc for i=
nternal
> >>>> ports, a.k.a. bridge ports.  This is necessary for tunnels to work.
> >>>> A typical setup looks like this:
> >>>>
> >>>>     Bridge br-int (10.0.0.1)
> >>>>         Port br-int
> >>>>             Interface br-int
> >>>>                 type: internal
> >>>>         Port vm
> >>>>             Interface vm
> >>>>         Port vxlan0
> >>>>             Interface vxlan0
> >>>>                 type: vxlan
> >>>>                 options: {remote_ip=3D"172.31.1.1"}
> >>>>
> >>>>     Bridge br-phy (172.31.1.100)
> >>>>         Port br-phy
> >>>>             Interface br-phy
> >>>>                 type: internal
> >>>>         Port eth0
> >>>>             Interface eth0
> >>>>
> >>>> When a VM sends a packet that supposed to go through the tunnel, it =
enters
> >>>> from the vm port and OVS forwards it into vxlan0 LWT with an appropr=
iate
> >>>> tunnel metadata.  Then it gets encapsulated and put into kernel rout=
ing to
> >>>> find the next hop, which is via br-phy bridge.  Packet enters br-phy=
 and
> >>>> OVS forwards the packet to eth0.  There can be stateful processing i=
n the
> >>>> br-phy bridge involving passing packets through conntrack.
> >>>>
> >>>> With the TC offload enabled, OVS creates following filters:
> >>>>
> >>>> 1. Ingress filter on vm interface that forwards packets to vxlan0.
> >>>> 2. Egress filter on br-phy interface that forwards encapsulated pack=
ets
> >>>>    to eth0 interface.
> >>>>
> >>>> If some stateful processing is involved, both of those could have ac=
t_ct
> >>>> in them.
> >>>>
> >>>> AFAIU, we have to use Egress qdisc for the br-phy, because the packe=
t is
> >>>> egressing from the kernel routing via br-phy and the ingress qdisc i=
s not
> >>>> invoked.  Ingress will be at play when packets are flowing in the op=
posite
> >>>> direction from eth0 to br-phy, as that's where they will ingress int=
o
> >>>> standard kernel routing.
> >>>>
> >>>> If act_tc will not be allowed on Egress, then stateful processing wi=
ll
> >>>> not be possible in this case in br-phy bridge.
> >>>>
> >>>> Thoughts?
> >>>
> >>> This looks very problematic. A slightly different patch tried to
> >>> somewhat preserve functionality, but it simply can't work in presence=
 of
> >>> IP fragments.
> >>>
> >>> Why stateful processing on  br-int/port vm ingress is not enough?
> >>
> >> In general we don't know where the packet will go after encapsulation,
> >> so we do not know beforehand if it will end up in another OVS bridge
> >> or not.  Hence the processing has to be split in two parts, the ingres=
s
> >> on vm port and egress on the other bridge port.
> >>
> >> At the same time, thinking more about potential use cases, I don't see
> >> a good one for running encapsulated traffic through conntrack.  Most
> >> of the time it's a UDP unidirectional traffic with hashes for source
> >> ports.  Not sure what functionality would require to do anything
> >> stateful on such packets.  So, maybe it's fine to prohibit act_ct on
> >> the egress after all.
> >>
> >
> > Another alternative is to drop packets that have fragments? i.e
> > Paolo's original patch but instead of accepting to drop
> > Or perhaps if there are no consequences there is nothing wrong with
> > Paolo's original patch..
> >
> > From a validation/testability/debugability POV, assuming its bad to
> > ignore frags processing:
> > The issue is for the user to distinguish between a bad setup (like
> > getting fragments in ct) and a good one where there were no frags. If
> > I were to write a tdc test to send two packets - one with fragments
> > and another without - a good way to check is to look at the tc
> > action/qdisc counters.. Paolo's original patch was accepting in both
> > cases the counter so the accept counter would read as 2 but if it was
> > dropped it would say 1 dropped and 1 accepted, so its easy to test (or
> > the user to debug)
> >
>
> From a user's perspective I'd prefer if RTM_NEWTFILTER just fails when
> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
> for the application that makes a request and for the user if they make
> the request manually with 'tc filter ...'.
>

The challenge is actions could be created as a standalone i.e "tc
actions add action ct..." then later bound via tc filter. Don't forget
actions can also be shared by multiple filters (which could be a mix
of egress/ingress)...

> If the filter with act_ct is allowed to be created, but only works for
> non-fragmented traffic, that would be pretty hard to debug for someone
> who is not an expert in the area, but also would be a pretty inconsistent
> user API.
>

True. The drop counter is better than "nothing"..

cheers,
jamal


> Best regards, Ilya Maximets.
>
> > cheers,
> > jamal
> >
> >> For the implementation however, let's look at a different very simple
> >> use case:
> >>
> >>    Application on the host -> br-phy -> NAT -> eth0.
> >>
> >> This is a very common thing to NAT traffic before it leaves the host.
> >> It can be for load balancing reasons, e.g. if a destination is a servi=
ce
> >> IP with multiple backends and we want multiple applications to hit
> >> different backends.
> >>
> >> There is no actual reason to try and offload such traffic to TC, as it
> >> would not be possible to offload it to hardware (since the traffic
> >> source is an application on the host).
> >>
> >> However, since OVS doesn't really know that it's not possible to offlo=
ad
> >> to hardware and TC by itself allows creation of such filter, it will
> >> create the filter on the egress qdisc on the bridge port and that egre=
ss
> >> filter will be performing act_ct with the NAT.
> >>
> >> With this patch applied, all this traffic will be just dropped.  If we=
're
> >> going to prohibit act_ct on egress, that should be done at the moment =
of
> >> creation of this action on the egress qdisc, so the user knows that it=
's
> >> not supposed to be there.  E.g. if OVS will try to create such action =
and
> >> fail, it will keep forwarding the traffic successfully through the nor=
mal
> >> openvswitch datapath.  But if the TC filter creation succeeds, all tra=
ffic
> >> will be just dropped by it.  That doesn't sound right.
> >>
> >> Best regards, Ilya Maximets.
>

