Return-Path: <netdev+bounces-259348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGcgENwIlmldYwIAu9opvQ
	(envelope-from <netdev+bounces-259348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B649B158CDF
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E940F30094F7
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97423346E70;
	Wed, 18 Feb 2026 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ke5aENWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF46346E45
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440306; cv=pass; b=JVRjKfsG7RcXk47NbVSE8YyrpPTZZ91zaujfXSjR1eLiqirPyJ/RAStoDt9iJmhbLREgk/pv7/b3DY9HzbGWs4XcKWVHg3k6GiuVEnAQms3F/aFCLycwO7+BLSEP8hNOc0ryim7gAzf985YqfbXH7kp+mYG0JRmUBcSgyze29zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440306; c=relaxed/simple;
	bh=GgpOgWwikENo4nZwbTZSakqVtonJNJKzXPP8cv5U+d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMuIGzZywfJBi0S5s3HvMo8J4GKXmVr8Kg7Eg5uTgsUv3xB2v4g+PG0weSRfRUySSAm7x1S3xLDnacTULv3y8MRnq8sbfudMquo4+X6NzWt6+pNURRLZfHD2UEQ1NiKXHISTMHuey/Z3M5WH7uU6WGkgnjfY4y11etE2tJLLpug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ke5aENWh; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so606295ad.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:45:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771440304; cv=none;
        d=google.com; s=arc-20240605;
        b=QO/2AslrkFR2EDn9T3zF//VxkMUBCGN84r+8RrqDJM41cZzewtdHv43wRd1u5f7X5c
         vHQXr4qZpVD61PIrse1HzaOuyDS6Hjq66GGpZlBs28Bcq+OSetXPYGLe+FXv7tG72Jej
         SVGg2zsD01kGGlqNQ5OFytRoiOpfqsFLBU/Z4XbNB0t0Oya6orkr0kNKR1Xgabhajy/X
         QWWDWcmCJUjYJIgQ5U6vPyiVrkcTjUcAZAuC059O7/zouaJfCo7qi4RddiL+n7/68lx7
         GSl3/nseqW168xdfo2Y2v22NvrfJvFH6Uhc3ZdytzoDXV0Sl7FnEqp89ST54em0Wk4Rs
         CtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2mYNSoMgfUcOb5o7Afpsb3KEbBOQDER3TI5S8xd1h8=;
        fh=BLnPErI1htU8Wb+eVBLt2n7oTduNaKcWy5xbLF9ldp0=;
        b=dRmVrzWt5dDCeHHaueGxpwwesAFR1WIENXUEzAlzNyhnxV9iZbYYdP1fGp/1Vi0tK4
         eSX5oA+3HjY90mOecNRG5hNLrsbseucHFZe1+sogDYbYvxxecTrxIFBqENkrFckWyKvs
         lKdZD35rFBnPn6BXSoWsf0g52sQ8Kc3edj1QsYMuEtMg5EDXjxozNgDCT1qM4B94Qqye
         TdxGVhvqKB4Pa8oGipJVoR+1LEE69/1wZ8Cr+9EX5tFHvTfLqnz9YkCcs00KohU1Ke3e
         L2rkh/tPzOuCSbJDukEf1q5UCgWIl7HUG+97IUI5Tw6ZCFDZepqna8AhB/yircfzQUSO
         PCSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771440304; x=1772045104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2mYNSoMgfUcOb5o7Afpsb3KEbBOQDER3TI5S8xd1h8=;
        b=ke5aENWhEyMf8fSsY7IFwqMvFaT/DYV7tzlSDk3cH8hZyn0HslXmufiZZivWdixKpW
         XbThJhhYfg1JmQyhCUENiP67VSAgzGqKnp4rJvjrb1Inm+Jf5wl0BWKorLxErWguCygB
         j//GQ2T0u7mFi7vBGJrfBOkBc6kudO0hJZtBcrwN7oPfsvHAKbDyxSt7KFhhuyboJqpC
         4qsWcG5cTAsH10nmhgjJRFar1JeeUMlubB+X0iI4+CUL+hJMLEsxboDwxEtXd3jcJe7/
         ZAiPnzyp6nSbBf/8twJhSe7wrhZi/sLglsfYiDCESxXePld7zOjRdQUZsg8rukIfbNt8
         gqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771440304; x=1772045104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2mYNSoMgfUcOb5o7Afpsb3KEbBOQDER3TI5S8xd1h8=;
        b=e6hWNJVmJbi/c/zJ2yAYlO4cdWg2AJYPWxE3vd0ymkHsSJ3TQf+od1fuJCFo7cnGF7
         DdneUArzy9zkxr+0d6hLPFATp7N+h7U1hrvG0LpF566q7rwlmGxWcXwqBBRpv9/aDIDt
         vEXGk6D6S82gCz+0Q0trfpPt2Y2TFBHxOYnq6zNTOIvLn5m6QbOZ/SEhCbIMrgGWcKP+
         Bx9nVfU6bemFsHng/8GpWmaNHcEDyg8e5AOXgNnLPrFKb9wQEfrUYD5o/03r75cwa9NV
         RpPsX5mWMOLsC8keIIwAmf1rsaxmNVWj4jHyijA/5QwfeTDSbFo3J3wSBxsK6d7loUYP
         ESKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyvAXUuDIdhNABi/VG7arJAw7QrBqFJSKvIiHipnkGhxnm+4i9NV4XsxPEMBhpIB50u/2ZKLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmvccUIftRK04ijM4gKdO/sb7cMGf0puFQsIZ0FyNqb2j4Gll
	eyyw21fCmQsCWxal9/gpoSxiQbK535zCMtWV/ayqH2tv9qpF2/Czs2HAzrRIuoKaNHPgBpwzE6A
	SgWVYy+v4npJO2xHyZc4IgA1lO8+qwdMB52rGDkj4
X-Gm-Gg: AZuq6aJ1xHP35yuLLnOEXpxcVkODtsLXSVe3qKJ2xq/FPdXcaPnTLhHhAAArDqicJzN
	auT2Zm2+9DQ01bf9WtotPXHBaDZoE82wu6smPt+5/r+nHsxM67dNq0GzZiLGywFQe8yWG+cgtDN
	Wekr/Yo7rvMfruot30R0NlpkLRXnoiMM6wOU63MqAvGlT/xQ9+zbzeeagn9UNWRgWpFSjiaLUgp
	1uKt9SMwWNVS7UxS/7TyU4tGKBbXIDenbrrEg2Cdf/nYJQytT4fLwx0j/qkgCFTGCW4m+eFtzE1
	6epPQ/EpRLPzCdk=
X-Received: by 2002:a17:902:e74e:b0:2ab:2311:e4fc with SMTP id
 d9443c01a7336-2ad50fb5883mr28648015ad.56.1771440304012; Wed, 18 Feb 2026
 10:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org> <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org> <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org> <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
In-Reply-To: <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Feb 2026 13:44:51 -0500
X-Gm-Features: AaiRm52BzF_oGJJBu_vIKqBGtWu0zS-JcPJhJKWKs_758uVlhIDKzYdDId7ibOE
Message-ID: <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259348-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,ovn.org:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B649B158CDF
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM Ilya Maximets <i.maximets@ovn.or=
g> wrote:
> >
> > On 2/18/26 3:28 PM, Jamal Hadi Salim wrote:
> > > On Tue, Feb 17, 2026 at 2:37=E2=80=AFPM Ilya Maximets <i.maximets@ovn=
.org> wrote:
> > >>
> > >> On 2/17/26 4:52 PM, Paolo Abeni wrote:
> > >>> Adding Florian, too
> > >>>
> > >>> On 2/17/26 3:49 PM, Ilya Maximets wrote:
> > >>>> On 2/17/26 10:38 AM, Paolo Abeni wrote:
> > >>>>> Since the blamed commit below, classify can return TC_ACT_CONSUME=
D while
> > >>>>> the current skb being held by the defragmentation engine. As repo=
rted by
> > >>>>> GangMin Kim, if such packet is that may cause a UaF when the defr=
ag engine
> > >>>>> later on tries to tuch again such packet.
> > >>>>>
> > >>>>> act_ct was never meant to be used outside of the ingress path. Ma=
king
> > >>>>> defrag really works for act_ct outside such constraints range fro=
m very
> > >>>>> difficult to completely impossible.
> > >>>>>
> > >>>>> Address the issue making act_ct drop any packet when not attached=
 to the
> > >>>>> ingress path and additionally emit a warning about the bad
> > >>>>> configuration.
> > >>>>>
> > >>>>> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> > >>>>> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc=
")
> > >>>>> CC: stable@vger.kernel.org
> > >>>>> Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e72674=
42afa7.1770394932.git.pabeni@redhat.com
> > >>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > >>>>> ---
> > >>>>> Catching the bad configuration at runtime instead of init time to=
 reduce
> > >>>>> complexity
> > >>>>> ---
> > >>>>>  net/sched/act_ct.c | 6 ++++++
> > >>>>>  1 file changed, 6 insertions(+)
> > >>>>>
> > >>>>> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > >>>>> index 81d488655793..e8eb0d195f4a 100644
> > >>>>> --- a/net/sched/act_ct.c
> > >>>>> +++ b/net/sched/act_ct.c
> > >>>>> @@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_b=
uff *skb, const struct tc_action *a,
> > >>>>>     tcf_lastuse_update(&c->tcf_tm);
> > >>>>>     tcf_action_update_bstats(&c->common, skb);
> > >>>>>
> > >>>>> +   if (!skb_at_tc_ingress(skb)) {
> > >>>>> +           pr_warn_once("act_CT should be attached at ingress!\n=
");
> > >>>>
> > >>>> Hi, Paolo.  I didn't test this yet, but I'm a little concerned abo=
ut this
> > >>>> change.  For TC offload of OVS tunnels, we create egress qdisc for=
 internal
> > >>>> ports, a.k.a. bridge ports.  This is necessary for tunnels to work=
.
> > >>>> A typical setup looks like this:
> > >>>>
> > >>>>     Bridge br-int (10.0.0.1)
> > >>>>         Port br-int
> > >>>>             Interface br-int
> > >>>>                 type: internal
> > >>>>         Port vm
> > >>>>             Interface vm
> > >>>>         Port vxlan0
> > >>>>             Interface vxlan0
> > >>>>                 type: vxlan
> > >>>>                 options: {remote_ip=3D"172.31.1.1"}
> > >>>>
> > >>>>     Bridge br-phy (172.31.1.100)
> > >>>>         Port br-phy
> > >>>>             Interface br-phy
> > >>>>                 type: internal
> > >>>>         Port eth0
> > >>>>             Interface eth0
> > >>>>
> > >>>> When a VM sends a packet that supposed to go through the tunnel, i=
t enters
> > >>>> from the vm port and OVS forwards it into vxlan0 LWT with an appro=
priate
> > >>>> tunnel metadata.  Then it gets encapsulated and put into kernel ro=
uting to
> > >>>> find the next hop, which is via br-phy bridge.  Packet enters br-p=
hy and
> > >>>> OVS forwards the packet to eth0.  There can be stateful processing=
 in the
> > >>>> br-phy bridge involving passing packets through conntrack.
> > >>>>
> > >>>> With the TC offload enabled, OVS creates following filters:
> > >>>>
> > >>>> 1. Ingress filter on vm interface that forwards packets to vxlan0.
> > >>>> 2. Egress filter on br-phy interface that forwards encapsulated pa=
ckets
> > >>>>    to eth0 interface.
> > >>>>
> > >>>> If some stateful processing is involved, both of those could have =
act_ct
> > >>>> in them.
> > >>>>
> > >>>> AFAIU, we have to use Egress qdisc for the br-phy, because the pac=
ket is
> > >>>> egressing from the kernel routing via br-phy and the ingress qdisc=
 is not
> > >>>> invoked.  Ingress will be at play when packets are flowing in the =
opposite
> > >>>> direction from eth0 to br-phy, as that's where they will ingress i=
nto
> > >>>> standard kernel routing.
> > >>>>
> > >>>> If act_tc will not be allowed on Egress, then stateful processing =
will
> > >>>> not be possible in this case in br-phy bridge.
> > >>>>
> > >>>> Thoughts?
> > >>>
> > >>> This looks very problematic. A slightly different patch tried to
> > >>> somewhat preserve functionality, but it simply can't work in presen=
ce of
> > >>> IP fragments.
> > >>>
> > >>> Why stateful processing on  br-int/port vm ingress is not enough?
> > >>
> > >> In general we don't know where the packet will go after encapsulatio=
n,
> > >> so we do not know beforehand if it will end up in another OVS bridge
> > >> or not.  Hence the processing has to be split in two parts, the ingr=
ess
> > >> on vm port and egress on the other bridge port.
> > >>
> > >> At the same time, thinking more about potential use cases, I don't s=
ee
> > >> a good one for running encapsulated traffic through conntrack.  Most
> > >> of the time it's a UDP unidirectional traffic with hashes for source
> > >> ports.  Not sure what functionality would require to do anything
> > >> stateful on such packets.  So, maybe it's fine to prohibit act_ct on
> > >> the egress after all.
> > >>
> > >
> > > Another alternative is to drop packets that have fragments? i.e
> > > Paolo's original patch but instead of accepting to drop
> > > Or perhaps if there are no consequences there is nothing wrong with
> > > Paolo's original patch..
> > >
> > > From a validation/testability/debugability POV, assuming its bad to
> > > ignore frags processing:
> > > The issue is for the user to distinguish between a bad setup (like
> > > getting fragments in ct) and a good one where there were no frags. If
> > > I were to write a tdc test to send two packets - one with fragments
> > > and another without - a good way to check is to look at the tc
> > > action/qdisc counters.. Paolo's original patch was accepting in both
> > > cases the counter so the accept counter would read as 2 but if it was
> > > dropped it would say 1 dropped and 1 accepted, so its easy to test (o=
r
> > > the user to debug)
> > >
> >
> > From a user's perspective I'd prefer if RTM_NEWTFILTER just fails when
> > it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
> > for the application that makes a request and for the user if they make
> > the request manually with 'tc filter ...'.
> >
>

Actually, looking closely at the code - this is doable. Let's see if a
patch can be cooked.


cheers,
jamal

> The challenge is actions could be created as a standalone i.e "tc
> actions add action ct..." then later bound via tc filter. Don't forget
> actions can also be shared by multiple filters (which could be a mix
> of egress/ingress)...
>


> > If the filter with act_ct is allowed to be created, but only works for
> > non-fragmented traffic, that would be pretty hard to debug for someone
> > who is not an expert in the area, but also would be a pretty inconsiste=
nt
> > user API.
> >
>
> True. The drop counter is better than "nothing"..
>
> cheers,
> jamal
>
>
> > Best regards, Ilya Maximets.
> >
> > > cheers,
> > > jamal
> > >
> > >> For the implementation however, let's look at a different very simpl=
e
> > >> use case:
> > >>
> > >>    Application on the host -> br-phy -> NAT -> eth0.
> > >>
> > >> This is a very common thing to NAT traffic before it leaves the host=
.
> > >> It can be for load balancing reasons, e.g. if a destination is a ser=
vice
> > >> IP with multiple backends and we want multiple applications to hit
> > >> different backends.
> > >>
> > >> There is no actual reason to try and offload such traffic to TC, as =
it
> > >> would not be possible to offload it to hardware (since the traffic
> > >> source is an application on the host).
> > >>
> > >> However, since OVS doesn't really know that it's not possible to off=
load
> > >> to hardware and TC by itself allows creation of such filter, it will
> > >> create the filter on the egress qdisc on the bridge port and that eg=
ress
> > >> filter will be performing act_ct with the NAT.
> > >>
> > >> With this patch applied, all this traffic will be just dropped.  If =
we're
> > >> going to prohibit act_ct on egress, that should be done at the momen=
t of
> > >> creation of this action on the egress qdisc, so the user knows that =
it's
> > >> not supposed to be there.  E.g. if OVS will try to create such actio=
n and
> > >> fail, it will keep forwarding the traffic successfully through the n=
ormal
> > >> openvswitch datapath.  But if the TC filter creation succeeds, all t=
raffic
> > >> will be just dropped by it.  That doesn't sound right.
> > >>
> > >> Best regards, Ilya Maximets.
> >

