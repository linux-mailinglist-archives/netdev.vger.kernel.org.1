Return-Path: <netdev+bounces-293110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKx0GtGKGWosxggAu9opvQ
	(envelope-from <netdev+bounces-293110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:47:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D56026CF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32D02306EA6B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6273F18FC97;
	Fri, 29 May 2026 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="k7rNE3Bf"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0D14A4CC;
	Fri, 29 May 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058773; cv=none; b=FcQWR146YJw/JbUPzs2RpOpX74cH0PVfMMyG45dM7RP2Lby/fSXxcGfKG64hutQro3bSvfmbLEUW0dWw/znXI9o4w1j4R6TxKa13aPcBpdFRfklv7gymFmEaU4Dd3IbKEvZo5wwtyAczSjkngTmOYGlEM2I3Xhg2d/YBZRh8XWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058773; c=relaxed/simple;
	bh=O4p7mvGVwnASMXsh0QQJTKpsE+FRewWJk0oiwvK89ZE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qA2+/Ha2Zmd4lUH3wDGzEXoNsZg6+AnMfmBF/YRmy/HZTNAcaWXoSDzgBg+3BVLItnBfdYYJgtiDs71cc7B9TuFwdpf0/hvXzvptqjiffgrmbpCjuj7sNDfy7wmh8ECrmMcWLp3LDfnIycXB1cOnmmxQCfo4s+8hxq04rGj4SHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=k7rNE3Bf; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64TCjGZF007373
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 May 2026 13:45:18 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64TCjGZF007373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780058723; bh=JaiOyxbCRo/HXXQtwhs+bYauX/I3BXc366uvpnPk3vg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=k7rNE3BfOdJZgfCyCT4qHTEiFiFPOl+LQoMdVo65g8wfuDHY9LFgICkQJ1Q6HpXKG
	 /Y51vnvnc5MgGFBWSX4mByVFfgwpAVc9R/H91EIr0ILz4CWwyRm+9eOELJ5RIVIWB4
	 SaB4yF2zOQslltv+HOz5nlqR28ju5a1ibzw3JWi49IJMdSxY3H52MYC0o1fveWzKzo
	 vG9Asj+V3nv2/eV6M3kskUVbIePy5Jz1AIfOjOhgofNHkEd8h7jLy4SRPkWkpBr9sG
	 4vAU/w/VZaxA3DdhzLZF2EQWSx2zxTnLaT45/FTvcdxFx/fQPSm85CBY7pf2gTHzNA
	 IyhiaBNs08+Ug==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <gigqfzdzvtoegjd6kb73g2xv4j7uq7f5s2lkrwspiosni3c44p@him3vof5vzrm>
Date: Fri, 29 May 2026 22:45:02 +1000
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <793226E0-82B1-464E-9A18-969F773B70D4@padl.com>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
 <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
 <DA213B68-5654-498A-B688-B92703923CCE@padl.com>
 <gigqfzdzvtoegjd6kb73g2xv4j7uq7f5s2lkrwspiosni3c44p@him3vof5vzrm>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293110-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: D78D56026CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cedric,

> On 29 May 2026, at 10:32=E2=80=AFpm, Cedric Jehasse =
<cedric.jehasse@gmail.com> wrote:
>=20
> On Fri, May 29, 2026 at 09:48:33AM +1000, Luke Howard wrote:
>>> +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
>>> +  struct tc_cbs_qopt_offload *cbs)
>>> +{
>>> + const struct mv88e6xxx_avb_ops *avb_ops;
>>> + struct mv88e6xxx_chip *chip =3D ds->priv;
>>> + const struct mv88e6xxx_qav_info *qav;
>>> + const struct mv88e6xxx_ops *ops;
>>> + int hilimit_reg;
>>> + int rate_reg;
>>> + u8 queue_bit;
>>> + u16 hi_limit;
>>> + u16 rate =3D 0;
>>> + int err;
>>> +
>>> + ops =3D chip->info->ops;
>>> + avb_ops =3D ops->avb_ops;
>>> + qav =3D chip->info->qav;

These could be initialised at the top of the function, might save some =
lines=E2=80=A6

>>> + if (!qav || !avb_ops || !avb_ops->port_qav_write ||
>>> +    !ops->port_set_scheduling_mode)
>>> + return -EOPNOTSUPP;
>>=20
>> Only the first check should be necessary because the wrapper =
functions return -EOPNOTSUPP in the case of a NULL function pointer.
>>=20
> That's not the same logic.
> If one of the two function pointer is NULL, the other can still be =
executed
> (Maybe not that likely as that's probably a mistake in the driver)

True, but agree also that it shouldn=E2=80=99t happen (would be a driver =
bug).

>>> + if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
>>> + err =3D mv88e6xxx_port_set_scheduling_mode(chip, port, 0);
>>> + if (err)
>>> + goto unlock;
>>> + }
>>=20
>> Missing a newline here after closing brace.
>=20
> Is that a personal preference, or a guideline I=E2=80=99ve missed?

You=E2=80=99re right, I had just assumed it was because it=E2=80=99s the =
case in the rest of the driver (97% adherence according to Claude :))

BTW, I have a (as yet untested) MQPRIO patch rebased on your v4 CBS =
patch. In DCB mode, TCs represent AVB classes (as my previous patch =
did). In CHANNEL mode, they represent queues, so you can flexibly map =
priorities to queues, with the additional advantage that these mappings =
can be per-port on the 6390.

It=E2=80=99s potentially a questionable overloading of the MQPRIO modes =
but, it=E2=80=99s a starting point for discussion, and it avoids needing =
out-of-band configuration (e.g. command line, devlink, etc, although I =
am now using devlink to set the AVB mode rather than the device tree).

Cheers,
Luke=

