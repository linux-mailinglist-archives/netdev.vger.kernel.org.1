Return-Path: <netdev+bounces-300595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QirzMP7MNGpWhQYAu9opvQ
	(envelope-from <netdev+bounces-300595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:00:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE96A3E4A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b="N/erb+7H";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300595-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300595-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FB430588AE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6C301474;
	Fri, 19 Jun 2026 05:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D640D594;
	Fri, 19 Jun 2026 05:00:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845237; cv=none; b=sucPGZqWfmnCcQLCeXFzzADuOXhAYoi5Vu80/sC19JNXrpO2zvUvi00d9VQMwQREUHPKiFwjo3wH3q/AdvQBvEpUvVsFoMiTIGZ34tO+5YXiVdVeXLtMYQ8rNL50rjp/4iVu+V5SCZ716PtN78MENWUKtLXBXlU6bHHagVMPlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845237; c=relaxed/simple;
	bh=z6dcnm0uxiuL+DZETzXLFk13tFMAyag5TyyJMqV8I1c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EkoE7+ij1HuWd0naqVxD4f8PZGcgNnyTw0serjZk97mei2rxgkE3Rx73YfKTt/7o3IZUbSoLUckvlySnm56aBVvcbV0/y8HQjdQihUOAMvLIXG26QECrPB8+tDuIWJA40wM0mpOF7p9VVP1KP2E4Pd/QQyd3WPJI7EYbEzAZMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=N/erb+7H; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 495AA60212;
	Fri, 19 Jun 2026 01:00:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1781845228; bh=z6dcnm0uxiuL+DZETzXLFk13tFMAyag5TyyJMqV8I1c=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=N/erb+7HWBbx2a0DoIC5Unhl8qYX9Ft43tmPG6EeeLrxIg2JPYxFYICNN6gSmAgby
	 VY+nZxGztGVLpKyF7Bdq8poCzs3/DzZjhoLpmVDldHL/vy2Hy79wgIHn7m0+K9wamL
	 5PMJXzTqmfAr8/KE19/iPCMQLpPTlRPVy5/dCZxziS5kqD4vOy/ftAKkQ8fQYAQDWi
	 Ach036NEf5wMxbOzCiWmexel6B0crDu/qCjSoPsZ2iJQCiQiyDvhzOjt7ZSTnUtEQn
	 nSnLDUdJDxzuIobLp+V/VsxBhLOR5LxWzE5iFgGtyukVYt4HehGGjKGTu/DUzwp8sp
	 wHWfuVAgpzDqA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <CABvLYuBZ=U96gVpYqHnnhwBZxp8OZzH-W503MsbNd4JPqLbEpQ@mail.gmail.com>
Date: Fri, 19 Jun 2026 15:00:12 +1000
Cc: cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3A6C8D7-3B6D-4716-88C7-EC32DB9D087D@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <0FB1CAF0-D30C-4A24-A684-1D1DBEE52FA5@padl.com>
 <CABvLYuBZ=U96gVpYqHnnhwBZxp8OZzH-W503MsbNd4JPqLbEpQ@mail.gmail.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-300595-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:christoph.mellauner@joyned.at,m:kieran@sienda.com,m:cedric.jehasse@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,joyned.at,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,padl.com:dkim,padl.com:email,padl.com:mid,padl.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68DE96A3E4A



> On 28 May 2026, at 7:19=E2=80=AFpm, Cedric Jehasse =
<cedric.jehasse@gmail.com> wrote:
>=20
> On Thu, May 28, 2026 at 1:52=E2=80=AFAM Luke Howard <lukeh@padl.com> =
wrote:
>> Would also be good to add support for the 6341, which as 4 queues but =
uses the same Qav multipliers as the 6390.
> I'll have a look at the 6341

As an aside, the 6341 driver is buggy. It assumes the chip does not have =
a dedicated ATU FID register because it has 256 databases. This is =
incorrect and breaks VLAN-aware bridging. I will post a patch when the =
merge window reopens.

On the hardware side, the ATU hashing algorithm appears to easily =
collide. This causes problems with things such as installing the =
broadcast address into multiple FIDs, not to mention 802.1Q Dynamic =
Reservation Entries. The only workaround is to use the =E2=80=98direct=E2=80=
=99 algorithm which may have a performance impact (I am presuming it is =
a linear search; the data sheet warns against using it).

Luke=

