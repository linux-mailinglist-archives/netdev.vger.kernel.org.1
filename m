Return-Path: <netdev+bounces-304671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uOuhOLgrSGpHnQAAu9opvQ
	(envelope-from <netdev+bounces-304671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448E705EC2
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:38:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=z38URStH;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304671-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304671-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A478D317D600
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8E36A34D;
	Fri,  3 Jul 2026 21:29:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E941367B6F;
	Fri,  3 Jul 2026 21:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783114143; cv=none; b=qcI1vXk8N4lB5YJsK77pNmOSpJ8n4naWwvmw4ZR5StE52JWwmF6A4l8V9QkfYhSmBYf17xKhTYFN4Df2RTiKvYT1DeGP0z3o1rQrIuig2QW4O3XVu67hKTRwpVyyPXQPWcy+y+Wj9dNlZ3DkglS9V4oWkY9hyXu6PczIfFEe0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783114143; c=relaxed/simple;
	bh=H8Oh5WNFrN+Ck/WW8FMVJYknXWuolVN9RFcUwNuTD/8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hYWJ8YHuB46nWVT8wVGxCYryHV75GzyXfRqp3+35dB4bMzZ/SIxeBXaI8LEIHg55HlocV55v9/ICGF6WVI3PCCBffxfbzug+OBghE3CYxaWXX/SODNukXZpBSrHHWSeDqtVxCmApDEJxXAIMck5QUrEF5zrojPGrwFHkmw12Ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=z38URStH; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id B66CA60C04;
	Fri,  3 Jul 2026 17:28:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783114141; bh=dmKqoQKcaom728Y18bEKBZJCw8RcqHWrHKv7ql09orc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=z38URStHzu9IzdQvIGEbfj5/Kss1OsGJ+nKt37/ShSfELSmM0sneGGnMwbvHFVXfv
	 sON62ODmXV8GDYQx+HYftrqKK9wDldjYzQD/8qI6I2IRsSc2yQmW7oKpZFMk4PHl4n
	 RMRpjDcEMfGXvgWfK/SwH7Q9RGu3pc+CEFLb9FH/5Qq/hj5VEvX+85++TYHywXPuEg
	 o6rlWOlyN5G52+jomqWzx/cfADu0bpyLu1yoblIurS03W5Koz1ojDuY0wkQId52pDE
	 c1c9jEl2aKa7IOpgkZVapUO/qEhS9xWof3YNt7RdbwPyyqPqtoS4LjG7PWLGgvge1b
	 GaaiBpMmungyg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: write the ATU FID
 register on 88E6141/88E6341
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <eadfade3-c46d-42fd-8301-3b2acebd7bcb@lunn.ch>
Date: Sat, 4 Jul 2026 07:28:47 +1000
Cc: Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74C991B2-E764-4F4A-A7DE-EA7D78FD10FD@padl.com>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-1-fbd3a1bf8965@padl.com>
 <eadfade3-c46d-42fd-8301-3b2acebd7bcb@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304671-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,padl.com:from_mime,padl.com:dkim,padl.com:mid,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6448E705EC2



> On 4 Jul 2026, at 1:31=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> On Fri, Jul 03, 2026 at 04:42:55PM +1000, Luke Howard wrote:
>> The existing code assumed the 88E6141/88E6341 did not have a =
dedicated
>> ATU FID register because of its database count (256), instead taking
>> the legacy path which resulted in the FID register never being set.
>>=20
>> This resulted in every FDB entry being loaded into FID 0, breaking
>> VLAN aware bridging.
>>=20
>> Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet =
switch 88E6341")
>=20
> Please submit fixes to the net tree.
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Will do.

>> @@ -131,6 +131,7 @@ struct mv88e6xxx_info {
>> u16 prod_num;
>> const char *name;
>> unsigned int num_databases;
>> + bool atu_fid_reg;
>> unsigned int num_macs;
>> unsigned int num_ports;
>> unsigned int num_internal_phys;
>=20
> Please think about padding. The current structure layout is not great,
> invalid_port_mask should be somewhere else, but please don't make it
> worse. Also, this structure has some reasonable comments. You have the
> chance to comment that the number of FIBs does not imply if there is a
> dedicated register, there are examples with 255 and a dedicated
> register.

Noted.

>=20
>> diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c =
b/drivers/net/dsa/mv88e6xxx/global1_atu.c
>> index c47f068f56b32..aa5adc78607ca 100644
>> --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
>> +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
>> @@ -135,7 +135,7 @@ static int mv88e6xxx_g1_atu_op(struct =
mv88e6xxx_chip *chip, u16 fid, u16 op)
>> int err;
>>=20
>> /* FID bits are dispatched all around gradually as more are supported =
*/
>> - if (mv88e6xxx_num_databases(chip) > 256) {
>> + if (mv88e6xxx_num_databases(chip) > 256 || chip->info->atu_fid_reg) =
{
>=20
> So currently, > 256 implies a dedicated register.  But do we need both
>> 255 and chip->info->atu_fid_reg? I would probably set atu_fid_reg
> true for all devices which have a dedicated register.

Noted.

Luke=

