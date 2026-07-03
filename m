Return-Path: <netdev+bounces-304669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mO4WKYEqSGrknAAAu9opvQ
	(envelope-from <netdev+bounces-304669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:32:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73164705DFB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=FNWviYZD;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304669-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304669-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E67C30B9A75
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250E34389C;
	Fri,  3 Jul 2026 21:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A8321F5E;
	Fri,  3 Jul 2026 21:26:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113997; cv=none; b=I3GvwsWuRCm3FAWPbHYuu8gvCnlE2IRjTmIAvgt+p/EJZ4GieGNWc20LfFuiRnC9DlK7dWxr1lbFJ3bQ0nrYQIK5YlhE/zkR0YGzgBFszK+KjXx5BPf0UVPdEvRqYTV8eJupy+r+unvokXO8ARuwlYFw9piwb9/uoNAqKDatfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113997; c=relaxed/simple;
	bh=Cgvja1csagqIuj3l03WPZ0P+vDgHGECsuqBP6iYqpz4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mX/99L0xN067KckTcyDMhueNFiPp9Zkxjw09M2+g9/0Hcv1Xfc0p3cJ2CyI96PZItizD4GmDd7pIAW4Ndu1+/26TpgQS4kcpTp29Lhvi2lJ4E6u4Do2CZmeOLXrhlZEuuRziRLQU8QMHeFZlk6xtTDt2SU4OkQPqTWmgPXP9Ig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=FNWviYZD; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id D919C60C04;
	Fri,  3 Jul 2026 17:26:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783113992; bh=Cgvja1csagqIuj3l03WPZ0P+vDgHGECsuqBP6iYqpz4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=FNWviYZDi8isdlvj62xm+zAoL5JHflicHkGIXGqMmyuHC5dUrIBdcM4wnKCCQXYw4
	 IxQh9LJiQLSATeRFzwnP1XYQCFBCogkZH4Ya1V4luzm38lVnTjrkfmO+Q/c9eX90NS
	 6WX1e9Ilv/VuMf0o/9AeFCP5KGUiV6/aWw0ZDgdeIr9d5tQ6JdJG6MCBbmjLi71XPS
	 KKIwNbg0bkoRy+jRj77bNlT0FmCk1fz+tlby9ZtAB8Q7QHUbGDH8p65sMZRnsOfYV6
	 QTPGg+aswlkpktfHX86P5wuA7d/6wox+FAf8ByjcyA1LAw8GBlF6/wdH4qnYhh4j4X
	 2ZPTavM8JxDiQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: embedded PTP timestamp
 support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <6cc25a97-3702-42d0-a667-11494bf5cbe6@lunn.ch>
Date: Sat, 4 Jul 2026 07:26:16 +1000
Cc: Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.dea>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67304C07-AE75-4881-965E-43F0F66BD270@padl.com>
References: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
 <20260703-mv88e6xxx-ptp-fixes-v1-2-0138581889a9@padl.com>
 <6cc25a97-3702-42d0-a667-11494bf5cbe6@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304669-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.dea,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,sienda.com,rme-audio.dea,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,padl.com:from_mime,padl.com:dkim,padl.com:mid,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73164705DFB



> On 4 Jul 2026, at 1:13=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>> + /* Arrival Time Stamp Mode (ArrTSMode); see the ArrTSMode encoding =
in
>> + * hwtstamp.h. Zero (the default) leaves arrival time stamps in the
>> + * switch registers; non-zero embeds them in the frame, either =
appended
>> + * as a trailer or overwritten at that byte offset past the start of =
the
>> + * PTP common header.
>=20
> So how do you indicate trailer?

ArrTSMode being 1 (matches switch register interpretation).

Will remove (c).=

