Return-Path: <netdev+bounces-283948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMHyG9DG+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F034C145B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9693037D4D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915453E1CE4;
	Mon,  4 May 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjbAiS4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959132ABC0
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911296; cv=pass; b=XN7ggEDA3Vaozf14Y+ybFxYeNMpfiv0K7xcH/Ur72PaTyGfvTgYDGKlaAYNbAOuSCi8i5lyAvpL15wXJjXzkiKmhLq+d0dFjf9UKIgzWJc9Bm5lTm7yfp2NNPq94hBAv6vXmkitCqOY4cCu19d1YbWZIY8VrYDUhRbXaB06JEcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911296; c=relaxed/simple;
	bh=DminP7KHVm63UIC2HtxfneHs0LQ298REtw9Ib4YAqLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRqoajVjOht3ZTbhqTWK5fkQ977Fe/KbYhbcwRoPms50rn+bEj2sTX/DW6KLzyqUqwtx6C2FdoqfpIDRJUPod+iW8SyaEfQRI5LCnmlk5mu3QlAhTRXSjrwQrIReyWetuL4Y7fqrnAdmcHhywRPPh+k9w9kFEY9MANRKofw/obM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjbAiS4k; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso40606745e9.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777911292; cv=none;
        d=google.com; s=arc-20240605;
        b=Yt6wsK7TEoWJZu5spgfoloY63i+abT9WAIJs3JiouYWDvCJAxPzWWeb5QaUI9tje/6
         UhJ90ghotPizRqT4ZUkC5fo8GGLOyQgup7nuMP0tHv9+/aKeDfSn1/un/VvxiLL4V+q/
         n81eZ6rk9CFgJrBZ7q2+GZXd/WdfOu1sBx2h9+RMVlgZdGsPJDRQk09Hy/u5kfUo1+H4
         KA3Vu49VdiJOWaAWKRHv9m3pL2okTbSS2N16XmEVRTL+pRSTZQBXkWqCkI5D4JB13vXJ
         lyOXRvOupT5VIprUWQ/oBUb5LnwX80Rv1bsBg5HH6ChvuVJd6GHOY+ObAFn57eU1vSGy
         CfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uctyhl2fep2pE4Eu8P5giabdChdRC1urKFD3GIrdlNU=;
        fh=k2JnLxyEPBWd5ud4374HQqs8aq20hEISgVfQVRMosDA=;
        b=L9dgogKnSYS7G9bQmu3ivdZrG90mjszu+G/YSmgIBfPz0AnVZTCU2uTIQwvN2z02D5
         Q1Bx6UhzZETXgnJ18PxCsyjLOPAVJzcggNTMY+sk8mdUjfNncYPzPiVjRR5y4bWw7Yrd
         TxfGiqcjU9Pxr32zyG+TMnwrsKR7uAXIX8cDDVjzhIMkZ9RlWRYdi9QsnIX5/bE98wuq
         U+SHkwn8ALyD4tJlQ2U7O13ZkEO+9QxyTFe0AXF8J92GuQsMS5lQkUloiWQiM9kXXfNO
         /ZSZwW71w3HL9kOwOaGOC8MyAPdfu/MrsMYx4tszhaFjxcjYHYh/AXfbSVYiRRJTzICf
         d32g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911292; x=1778516092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uctyhl2fep2pE4Eu8P5giabdChdRC1urKFD3GIrdlNU=;
        b=jjbAiS4ktJYA3tfqTyKCsL/krzaQwVFF7itDi7cMIYE/nUy7WeASyzpoaR/8ropESt
         Lg7BSaoCPZRY3U2ExIGF+OmHqS6a17Sv/aVAU8/c8/EBbuPS4TBJbntsCGAM/N0BsPQ3
         B/+1GEoGII8l6UGFY+YSbO3AZ4uad3E/nSAebqgkeT0K5G9ZiwsBSImIPc5wKQmy1+OX
         o5Uw7TEuDM5P5qfZlaOTyzi41sEhsvy+tUbHxexRfq9WmYm9ezyokBCiLv5DWwi0gfHS
         yYku8Duvfp5wBSrKSRVkxKQ+6BtxELaINoMUpWayvHBzdaXon4c3GDrEBkkqOfEIfp5g
         d7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911292; x=1778516092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uctyhl2fep2pE4Eu8P5giabdChdRC1urKFD3GIrdlNU=;
        b=fJdFmKz9cEXcrdDh08qLYHpGggPUIxpP7aFkkLSvPMAm4HeG8fVvac1DjBTXAenPT2
         pwJUu0fIq0widVAcP8uvjHe20rdaQzm5+mdHXUnkq1dFkXYIPPLKL784OgXXKsaCHODd
         OhOytTbUNmtJb1Eleij8sdJGi0R5+AhGBgKPZVi9SvNQ45GQpNiI1Gz2KBZIXJURs98K
         HTPFLWx4EjFdB6V5Te8wX+6/K0ZNBxK9AZ+05h43R2hhe5BEbwo28MEF244bd2WTDzaH
         KcCrP2bOvTVObejC19gQoPfLOd/Bh8xr87L/mGvefOJxijLgpHQ3ZlrQJpddJmMh0efx
         gteQ==
X-Gm-Message-State: AOJu0Yya11qxAo+xWxClgclXLIg5dQfwizES0t5nO56TkagP800fp4+9
	7tbsrKI6AOShg4k2lqwVLLR4+2j0l+jjxHL6UWSh9wOWed9oTALh137Nc0vNePgJCjE7HGfkhar
	9rNP0XdQLtvEwLjTtlyOjvw2RNdzDSPk=
X-Gm-Gg: AeBDieujnUJfuE7CFRWc7UtY6ipdZfoXfowfRJx5ICkGXnhpbtsXYY4NUf1Yrka/sBM
	UsY3Ue0X+BjYTGUIgucreUAay/2mPtJgDtbwOVwCJZi0ApGnXdr8vPjCaBIzFjzjjHuI10d/JRx
	SGbb+HVobge5hK7I4k5HoMQXY956gALcXb/VIevpDRaCF3zt/8rJ9/40z3oBtXzpk5QVFvqJtVx
	lHGbN3pNVZ7oI57quPdhNnuwFLmGwSKgkdhWXC+xkg7r+ibbE8FBcipp5xczGs/pj1TZxd9l65q
	a2np7UmyM3eDyYdQIA==
X-Received: by 2002:a05:600c:c170:b0:48a:7aad:4425 with SMTP id
 5b1f17b1804b1-48a9852e515mr163196585e9.3.1777911291577; Mon, 04 May 2026
 09:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501133924.3100680-1-houminxi@gmail.com> <20260501133924.3100680-3-houminxi@gmail.com>
 <f7tlddzxjex.fsf@redhat.com>
In-Reply-To: <f7tlddzxjex.fsf@redhat.com>
From: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Date: Tue, 5 May 2026 00:14:25 +0800
X-Gm-Features: AVHnY4KaIFLNi-Dh9lc5p5n5R2gxHKTnaPAl-7T1qHjZz0uGcOSuz6uNUhVgKIk
Message-ID: <CAJ0BgHdsS1sykUqhDY2rzucmnszTLbF11y4cvUoD+mOjp7jO5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: openvswitch: add pop_vlan test
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dev@openvswitch.org, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 12F034C145B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283948-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Aaron,

Thanks for the detailed review!

> Weird that this is here.  All other tests would also not work if there
> were no netns or OVS module.  Why were these added?

You're right, the modprobe and netns pre-checks are unnecessary.
run_test already gates on the module, and ovs_add_netns_and_veths
will fail naturally if netns isn't available.  I'll remove both
pre-flight blocks in v5.

> We don't like to make extra files when not requested.  For example,
> this is making some pcap file but do we need it?

Agreed. The pcap capture was overly cautious, ping success/failure
already tells us whether the VLAN tag was correctly stripped (or not).

> We also have a specific spawn function `ovs_netns_spawn_daemon` that
> should take care of cleaning up at least the PID.

Understood. I'll use existing helpers rather than rolling custom
infrastructure.

> Do we really need these tcpdump checks?  The ping commands above
> should already capture when we are expecting tagged / untagged
> traffic.

Makes sense.  In v5 I'll drop the start_capture/stop_capture helpers
entirely and rely solely on ping results:

  - Baseline: ping without VLAN flow succeeds (ARP resolution works)
  - Negative: ping with tagged traffic and no pop_vlan fails
  - Positive: ping with tagged traffic and pop_vlan succeeds

This will significantly simplify the test.

I was previously working as QE, so my instinct was to add
defensive pre-checks and packet-level capture for every test.
I'm still adjusting to the kernel selftest convention of keeping
tests minimal and relying on existing infrastructure.

Appreciate the guidance.

Combined with the depth-check removal from patch 1/2 feedback, v5 will
be a much leaner series.

B,R
Minxi

Aaron Conole <aconole@redhat.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=80 23:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Minxi,
>
> Thanks for the test (and the support infra in 1/2).  Questions below.
>
> Minxi Hou <houminxi@gmail.com> writes:
>
> > Add a test for the OVS datapath POP_VLAN action.  The test uses
> > the VLAN sub-interface of a veth pair to generate 802.1Q tagged
> > frames and verifies that pop_vlan correctly strips the VLAN tag
> > before delivery via pcap frame capture.
> >
> > The test has two verifications:
> > - Negative: forward tagged frames without pop_vlan, verify the
> >   VLAN tag is still present on the egress interface.
> > - Positive: apply pop_vlan, verify the tag is removed and an
> >   untagged ICMP echo request arrives at the egress interface.
> >
> > Static ARP entries avoid the complexity of VLAN-tagged ARP
> > resolution (the egress side has no VLAN sub-interface and cannot
> > process tagged ARP).
> >
> > Signed-off-by: Minxi Hou <houminxi@gmail.com>
> > ---
> > v1 -> v2: rebase to latest net-next/main, drop --base=3Dauto
> >
> >  .../selftests/net/openvswitch/openvswitch.sh  | 132 ++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/t=
ools/testing/selftests/net/openvswitch/openvswitch.sh
> > index b327d3061ed5..cd614ff7b740 100755
> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > @@ -27,6 +27,7 @@ tests=3D"
> >       upcall_interfaces                       ovs: test the upcall inte=
rfaces
> >       tunnel_metadata                         ovs: test extraction of t=
unnel metadata
> >       drop_reason                             drop: test drop reasons a=
re emitted
> > +     pop_vlan                                        vlan-pop: POP_VLA=
N action strips 802.1Q tag
>
> nit: The whitespace alignment above is slightly off.
>
> >       psample                                 psample: Sampling packets=
 with psample"
> >
> >  info() {
> > @@ -830,6 +831,137 @@ test_tunnel_metadata() {
> >       return 0
> >  }
> >
> > +test_pop_vlan() {
> > +     modprobe -q openvswitch 2>/dev/null || true
> > +     [ -d /sys/module/openvswitch ] || return $ksft_skip
> > +     ip netns add __test_pop_vlan_netns__ 2>/dev/null || \
> > +             { info "CONFIG_NET_NS missing"; return $ksft_skip; }
> > +     ip netns del __test_pop_vlan_netns__ 2>/dev/null
>
> Weird that this is here.  All other tests would also not work if there
> were no netns or OVS module.  Why were these added?
>
> > +     modprobe -q 8021q 2>/dev/null || true
> > +     [ -d /sys/module/8021q ] || { info "CONFIG_VLAN_8021Q missing"; r=
eturn $ksft_skip; }
> > +
> > +     local sbx=3D"test_pop_vlan"
> > +     sbx_add "$sbx" || return $ksft_skip
> > +     ovs_add_dp "$sbx" vlandp || return 1
> > +
> > +     # --- baseline: untagged forwarding ---
> > +     ovs_add_netns_and_veths "$sbx" vlandp ns1 veth1 ns1veth 192.0.2.1=
/24 || return 1
> > +     ovs_add_netns_and_veths "$sbx" vlandp ns2 veth2 ns2veth 192.0.2.2=
/24 || return 1
> > +
> > +     # ARP + IPv4 bidirectional (all untagged)
> > +     ovs_add_flow "$sbx" vlandp \
> > +             'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> > +     ovs_add_flow "$sbx" vlandp \
> > +             'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> > +     ovs_add_flow "$sbx" vlandp \
> > +             'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return =
1
> > +     ovs_add_flow "$sbx" vlandp \
> > +             'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return =
1
> > +     ip netns exec ns1 ping -c 3 -W 2 192.0.2.2 || return 1
> > +
> > +     # --- POP_VLAN test ---
> > +     # Register cleanup before creating resources (safe on failure pat=
hs)
> > +     on_exit "ip -n ns1 link del ns1veth.10 2>/dev/null || true
> > +              ip -n ns2 addr del 198.51.100.2/24 dev ns2veth 2>/dev/nu=
ll || true"
> > +
> > +     # ns1: VLAN sub-interface generates tagged frames
> > +     ip -n ns1 link add link ns1veth name ns1veth.10 type vlan id 10
> > +     ip -n ns1 addr add 198.51.100.1/24 dev ns1veth.10
> > +     ip -n ns1 link set ns1veth.10 up
> > +
> > +     # ns2: no VLAN sub-interface. POP delivers untagged frames to ns2=
veth
> > +     ip -n ns2 addr add 198.51.100.2/24 dev ns2veth
> > +
> > +     # veth disable VLAN offload + GRO (ensure kernel software tag pro=
cessing)
> > +     if command -v ethtool >/dev/null 2>&1; then
> > +             ip netns exec ns1 ethtool -k ns1veth 2>/dev/null | grep -=
q vlan-offload && \
> > +                     ip netns exec ns1 ethtool -K ns1veth rx-vlan-offl=
oad off \
> > +                             tx-vlan-offload off gro off 2>/dev/null |=
| true
> > +             ip netns exec ns2 ethtool -k ns2veth 2>/dev/null | grep -=
q vlan-offload && \
> > +                     ip netns exec ns2 ethtool -K ns2veth rx-vlan-offl=
oad off \
> > +                             tx-vlan-offload off gro off 2>/dev/null |=
| true
> > +     fi
> > +
> > +     ovs_del_flows "$sbx" vlandp
> > +
> > +     # Static ARP avoids VLAN-tagged ARP complexity (ns2 has no VLAN
> > +     # sub-interface, so tagged ARP would be invisible to ns2).
> > +     local ns1veth10mac ns2mac
> > +     ns1veth10mac=3D$(ip -n ns1 link show ns1veth.10 | \
> > +             awk '/link\/ether/ {print $2}')
> > +     ns2mac=3D$(ip -n ns2 link show ns2veth | \
> > +             awk '/link\/ether/ {print $2}')
> > +     [ -n "$ns1veth10mac" ] && echo "$ns1veth10mac" | \
> > +             grep -qE "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$" || return=
 1
> > +     [ -n "$ns2mac" ] && echo "$ns2mac" | \
> > +             grep -qE "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$" || return=
 1
> > +     ip -n ns1 neigh replace 198.51.100.2 lladdr "$ns2mac" \
> > +             dev ns1veth.10 nud permanent || return 1
> > +     ip -n ns2 neigh replace 198.51.100.1 lladdr "$ns1veth10mac" \
> > +             dev ns2veth nud permanent || return 1
> > +
> > +     # --- Negative check: fwd without pop_vlan, VLAN tag stays ---
> > +     ovs_add_flow "$sbx" vlandp \
> > +             'in_port(1),eth(),eth_type(0x8100),vlan(vid=3D10),encap(e=
th_type(0x0800),ipv4(src=3D198.51.100.1,proto=3D1),icmp())' \
> > +             '2' || return 1
> > +
> > +     local pcap_no_pop
> > +     pcap_no_pop=3D$(mktemp --suffix=3D.pcap)
> > +     on_exit "rm -f $pcap_no_pop"
> > +     ip netns exec ns2 tcpdump -nei ns2veth -w "$pcap_no_pop" -U &
> > +     local tpid_no_pop=3D$!
> > +     on_exit "kill $tpid_no_pop 2>/dev/null || true"
> > +     sleep $((WAIT_TIMEOUT / 5 < 2 ? 2 : WAIT_TIMEOUT / 5))
> > +
>
> We don't like to make extra files when not requested.  For example, this
> is making some pcap file but do we need it?  We also have a specific
> spawn function `ovs_netns_spawn_daemon` that should take care of
> cleaning up at least the PID.
>
> > +     ip netns exec ns1 ping -I ns1veth.10 -c 3 -W 1 198.51.100.2 \
> > +             >/dev/null 2>&1 || true
> > +     kill $tpid_no_pop 2>/dev/null || true; wait $tpid_no_pop 2>/dev/n=
ull || true
> > +
> > +     # assert: VLAN tag still present (no pop_vlan in action)
> > +     tcpdump -nr "$pcap_no_pop" 'vlan' 2>/dev/null | grep -q . || {
> > +             info "FAIL: negative check: no VLAN tag (expected tag pre=
sent)"; return 1
> > +     }
> > +
> > +     ovs_del_flows "$sbx" vlandp
> > +
> > +     # --- Positive: pop_vlan strips tag ---
> > +     ovs_add_flow "$sbx" vlandp \
> > +             'in_port(1),eth(),eth_type(0x8100),vlan(vid=3D10),encap(e=
th_type(0x0800),ipv4(src=3D198.51.100.1,proto=3D1),icmp())' \
> > +             'pop_vlan,2' || return 1
> > +     ovs_add_flow "$sbx" vlandp \
> > +             'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return =
1
> > +
> > +     local pcap
> > +     pcap=3D$(mktemp --suffix=3D.pcap)
> > +     on_exit "rm -f $pcap"
> > +     ip netns exec ns2 tcpdump -nei ns2veth -w "$pcap" -U &
> > +     local tpid=3D$!
> > +     on_exit "kill $tpid 2>/dev/null || true"
> > +     sleep $((WAIT_TIMEOUT / 5 < 2 ? 2 : WAIT_TIMEOUT / 5))
> > +
> > +     # ping reply unreachable: ns1veth.10 only accepts tagged frames,
> > +     # ns2 sends untagged reply -> dropped by ns1veth.10.
> > +     local ping_rc=3D0
> > +     ip netns exec ns1 ping -I ns1veth.10 -c 3 -W 1 198.51.100.2 \
> > +             >/dev/null 2>&1 || ping_rc=3D$?
> > +     kill $tpid 2>/dev/null || true; wait $tpid 2>/dev/null || true
> > +
> > +     # ping failure is expected (reply path asymmetric)
> > +     [ "$ping_rc" -ne 0 ] || \
> > +             info "NOTE: ping succeeded unexpectedly (reply reached ns=
1veth.10)"
> > +
> > +     # assert: no VLAN tag (POP succeeded), untagged ICMP echo request=
 arrived
> > +     tcpdump -nr "$pcap" 'vlan' 2>/dev/null | grep -q . && {
> > +             info "FAIL: POP_VLAN: VLAN tag still present"; return 1
> > +     }
> > +     tcpdump -nr "$pcap" 'icmp and icmp[icmptype]=3D8' \
> > +             2>/dev/null | grep -q . || {
> > +             info "FAIL: POP_VLAN: no untagged ICMP echo request"; ret=
urn 1
> > +     }
>
> Do we really need these tcpdump checks?  The ping commands above should
> already capture when we are expecting tagged / untagged traffic.
>
> > +     return 0
> > +}
> > +
> >  run_test() {
> >       (
> >       tname=3D"$1"
>

