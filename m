Return-Path: <netdev+bounces-272623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL43BHu8xmnoNwUAu9opvQ
	(envelope-from <netdev+bounces-272623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:20:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1164C348392
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DC0130A1F92
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEFD344DB8;
	Fri, 27 Mar 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="bghKSz0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vep36r/f"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4E32939C
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630619; cv=none; b=qA7cZpmXQI90gyQZ6e9lGqvsubal6pLXlI4rdZcrLkbUlsSaCGOLaiWhWRX/x6NogNdoLHsL5KoiwLUwuOnTJwKADL2kndLdq22MY3kTMZHM2nThRSq/F+Ld5doMxQ1I+6fEomS62rXaxy8ROm+/7jST3CBzIljBOiRmdE8OXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630619; c=relaxed/simple;
	bh=lgjeEjnHfK0RXWZhxczxyUnqQIqhpvRNCIfKGK1M1VI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Xh7tqd7p1ynmjoVwq7Ar4AJ7F4G/fzc+5C6rJohaSuz8UQTQqWL7izevfmE7HREtBbVu1EY5a+KEerLpPAVBcOQhktM4jFrFkrQmoKX0Urqw+Bk+V6kOibagfM/ydte1kfl7Zi/VxPX3eBxCLEeNoXRRkGOSEFlfKCwnh9tqba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=bghKSz0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vep36r/f; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD3157A0178;
	Fri, 27 Mar 2026 12:56:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Mar 2026 12:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1774630615; x=1774717015; bh=LMErKQf+RgPxozTNX0G2QEeBrBnPAtJ/
	n6DsU6ecMg8=; b=bghKSz0iebg8CcqEGztbGmHTmCB+qNiVWkyNe4lUlQHFTrc3
	f75ypNWzbAGt7lrBVeJF7FyDyt0EsQ5OYG+u21uJIUGokshYC0jY5XKTPQOSTpBF
	+kKqH1udFv882qhbMVNx8HnYgtQy0rRZdSBArnrYIys7nWkNtmuTS6KQG8Kx08N5
	S/plG41s5Yvj6Re1xlReqFMhkm1xYdrCViWBtvyzHHWAmYK8bJA51h7xHZf4Xz7R
	T9tWgdenhgUz2FjjEMJEKBy5/DgK2Qo/2jroSIdDNBk2KASkBHn/536nB+xv+wrH
	3TiYROwg/BPrEy8mjBJN28JGJ6fcSmB2rph8eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774630615; x=
	1774717015; bh=LMErKQf+RgPxozTNX0G2QEeBrBnPAtJ/n6DsU6ecMg8=; b=v
	ep36r/f9omaX/rqbXwBkQUMa5kOXEcoc/YZY8hqm1ECRy9qY+EUP+1FvKltqjLJ9
	33j7heuma7CpNEIEY4Kp91iBHC3dMbkpHL7ROPH8t675qZ+oxMKQVpW/DKNT28Ri
	c0Tqnq2uHxbIzp13toF/LsvIkuHVe//wjUimIWDtcHKBST/lQSW4IvLBPNPnQKFw
	RJRSa9mSL7ihg8q2k3Jo5S10fHt8rY46ukMCmj490GwplqCaBQjqdbWZX3l69T0A
	S81Kkzt9gSd2azYcGKvMSOVRK4QOOpldNbGdJInH5WEXJgUzmHiFpczBi37lWjcO
	SCg2fOmEeVub05XfRIh3Q==
X-ME-Sender: <xms:17bGaT_gzR0uq0IxkMdxAxqxrUz5hq7oxY87M14KvADtLDArp6JZAQ>
    <xme:17bGaST16DazWz30mEMJsZiNbe19z9wKj732mMGZw1Qy_LSJOTKksjCdRfPmD3Abq
    4_s-NiZAVeGzk594VQuFWOqCt8qQePTaxakEhZR0bWwF42VQnZWXQ>
X-ME-Received: <xmr:17bGaUqNvGm8Ut4USLlYUNKjg0EmwGD3rF6WopPV8dHjg5UY2KPHI0r3VRYuWQD3Ayg-eEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlohhuihhsrdhstggrlhgsvghrthesieifihhnugdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghnugihsehgrhgvhihhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
    pdhrtghpthhtohepfhgslhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehshhgvmhhmihhnghgvrhesvhihrghtthgrrdgtoh
    hm
X-ME-Proxy: <xmx:17bGaflZ_eXoQ66DmrlXaexPNd_od8oBZ6GQDyqiNU1xDstphZQ83A>
    <xmx:17bGadc0wexXVA4474u_eCLaLZGiy_JDWRI34ZJ9ZG4r6iKv7sZNOA>
    <xmx:17bGabpfkp1jNhnzqD6lAWEFNWq0w3uBWkKhDqHPY_N4_eSTDBfO4A>
    <xmx:17bGaXPa0u0Q0og8VTlXy-Hp2CYd3e8PZLejAhjhBaROYs30rzisWg>
    <xmx:17bGaTROukOTaH7ZbIJWd2wiwaChTW92rorn2wb4KhvAAah4KHcyloRY>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:56:54 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id A46B11C0081; Fri, 27 Mar 2026 09:56:53 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id A240E1C005D;
	Fri, 27 Mar 2026 11:56:53 -0500 (CDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com
Subject: Re: [PATCH net v2 1/3] bonding: 3ad: fix carrier when no valid slaves
In-reply-to: <CAJ5u_OcpOGSPYK-EzYeW8LdpJrLd16fGn6zN6cvk+tCjCi+QxA@mail.gmail.com>
References: <20260325134439.3048615-1-louis.scalbert@6wind.com> <20260325134439.3048615-2-louis.scalbert@6wind.com> <CAJ5u_OcpOGSPYK-EzYeW8LdpJrLd16fGn6zN6cvk+tCjCi+QxA@mail.gmail.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Fri, 27 Mar 2026 17:16:38 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Mar 2026 11:56:53 -0500
Message-ID: <118159.1774630613@vermin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272623-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1164C348392
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>Hi everyone,
>
>Le mer. 25 mars 2026 =C3=A0 14:44, Louis Scalbert
><louis.scalbert@6wind.com> a =C3=A9crit :
>>
>> When an 802.3ad (LACP) bonding interface has no slaves in the
>> collecting/distributing state, the bonding master may still report
>> carrier as up. In this situation, no slave is actually able to transmit
>> or receive traffic.
>>
>I=E2=80=99ve just realized that the issue description is not entirely accu=
rate.
>
>Bonding links that are not in LACP Collecting/Distributing state are
>excluded from traffic
>distribution in favor of those that are. However, if no links are in
>Collecting/Distributing state,
>the kernel considers all links as valid for distributing traffic.
>
>> As a result, upper-layer daemons consider the interface operational
>> while traffic is effectively blackholed.
>
>There are situations where traffic is not blackholed.
>
>For example, a Linux machine A is connected to machine B using two
>aggregated links.
>On A, LACP is configured, but not on B. As a result, LACP will not
>reach the Collecting/Distributing
>state since B does not send LACP frames. However, the bonding
>interface will still be up on both
>sides, and traffic can be exchanged.

	Bonding does this because, in the absense of a LACP partner, the
interfaces in the bond will become Individual links, each of which will
become its own aggregator, one of which will be chosen to be active.

	This is in compliance with the standard, (802.1AX-2014, 6.1.1.j)
and is intended to permit some communication between a system that is
LACP-enabled and a system that is not.  The common example I'm familiar
with is a host that PXE boots over a network, connected to a
LACP-enabled switch.  During early boot, the PXE environment does not
perform LACP, but still needs to communicate with the switch.

>This behavior is, of course, not compliant with the LACP (802.3ad)
>standard, but applying this fix
>as-is could introduce regressions in some setups. Under normal
>conditions, having no Collecting /
>Distributing links means that no interfaces are operational for
>handling traffic - that is precisely the
>purpose of using LACP.

	FWIW, generally speaking we've settled on IEEE 802.1AX-2014 as
the version of the standard to which the bonding implementation should
be conformant.  There is a more recent version, -2020, but it is a
significant change from the prior versions.

>I will publish a new version with a knob to enforce compliance with
>the LACP standard. It will be
>disabled by default for backward compatibility.
>
>What do you think of "lacp_strict" or "lacp_enforce" ?

	I'm not convinced that we are in violation of the standard with
the present behavior.  That said, if such a switch is necessary, I'd
vote for "lacp_strict".

	-J

>>
>> Fix this by asserting carrier only when at least 'min_links' slaves are
>> in the collecting/distributing state (or collecting only if the
>> coupled_control default behavior is disabled).
>>
>> Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>> Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>> ---
>>  drivers/net/bonding/bond_3ad.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
>> index af7f74cfdc08..6d3613755d45 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregator=
 *aggregator, int val)
>>         }
>>  }
>>
>> +static int __agg_valid_ports(struct aggregator *agg)
>> +{
>> +       struct port *port;
>> +       int valid =3D 0;
>> +
>> +       for (port =3D agg->lag_ports; port;
>> +            port =3D port->next_port_in_aggregator) {
>> +               if (port->actor_oper_port_state & LACP_STATE_COLLECTING =
&&
>> +                   (!port->slave->bond->params.coupled_control ||
>> +                    port->actor_oper_port_state & LACP_STATE_DISTRIBUTI=
NG))
>> +                       valid++;
>> +       }
>> +
>> +       return valid;
>> +}
>> +
>>  static int __agg_active_ports(struct aggregator *agg)
>>  {
>>         struct port *port;
>> @@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(stru=
ct port *port,
>>                           port->actor_port_number,
>>                           port->aggregator->aggregator_identifier);
>>                 __enable_port(port);
>> +               bond_3ad_set_carrier(port->slave->bond);
>>                 /* Slave array needs update */
>>                 *update_slave_arr =3D true;
>>                 /* Should notify peers if possible */
>> @@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(str=
uct port *port,
>>                           port->actor_port_number,
>>                           port->aggregator->aggregator_identifier);
>>                 __disable_port(port);
>> +               bond_3ad_set_carrier(port->slave->bond);
>>                 /* Slave array needs an update */
>>                 *update_slave_arr =3D true;
>>         }
>> @@ -2819,8 +2837,10 @@ int bond_3ad_set_carrier(struct bonding *bond)
>>         }
>>         active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggreg=
ator));
>>         if (active) {
>> -               /* are enough slaves available to consider link up? */
>> -               if (__agg_active_ports(active) < bond->params.min_links)=
 {
>> +               /* are enough slaves in collecting (and distributing) st=
ate to consider
>> +                * link up?
>> +                */
>> +               if (__agg_valid_ports(active) < bond->params.min_links) {
>>                         if (netif_carrier_ok(bond->dev)) {
>>                                 netif_carrier_off(bond->dev);
>>                                 goto out;
>> --
>> 2.39.2
>>

---
	-Jay Vosburgh, jv@jvosburgh.net

