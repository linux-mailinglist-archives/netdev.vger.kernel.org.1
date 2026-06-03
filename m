Return-Path: <netdev+bounces-294826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WrNJAEFaIGot1wAAu9opvQ
	(envelope-from <netdev+bounces-294826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:45:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7FA639E32
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:45:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=TEt91cxb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294826-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294826-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EB7130B9F47
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D23E1CF0;
	Wed,  3 Jun 2026 16:05:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A5304976
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:05:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502707; cv=none; b=GWjbbA0sGJ+l86Obi8xAD9yUBX/bxTk9DIvRFh3bLnYewJnEkskfxdlKB2YWrunqg+uQVDEaYCCEcdNwAyGE3ue+hu0PrErh3AHJyUXxGvS0FCbDS9bwBqbxng/7GWDq0boeWIzmCInrlBg0mnFVzWmR6A6SbMvSurpUqoG29Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502707; c=relaxed/simple;
	bh=JNOHnc1OQ2S9Oh4gIkTpWhNDDRw65TOsYC+3imQewl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQlU4XX0FzFwNuQhGEqjgy9SoV8Q1pVs5C+MRTmGyDZ8xLejFIaPm57S0VYR6FRAY33jvVCe6V/v/IDnxsIfgPYVz3OS3qA6+nOOpVaUwr0sMsKU9N08QYsMjTcLeZZWJdn5WJGjmJXGNkFmURU9vKUCtzysvPwwtPhym/fMSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TEt91cxb; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AFDAF4E40115;
	Wed,  3 Jun 2026 16:05:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 825755FA0A;
	Wed,  3 Jun 2026 16:05:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE15C10888CC6;
	Wed,  3 Jun 2026 18:05:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780502703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JNOHnc1OQ2S9Oh4gIkTpWhNDDRw65TOsYC+3imQewl0=;
	b=TEt91cxbTD3F3Dn/lZ8+0gQwqaZpadXmeCtwg0M2c6IvMJ/SvpXAIqTVPPMWtBju0XW5Pp
	zqrGv8oOdFrBBNWU39uujWQ2K5xZqhGdsz/19F6lA6oXnHZiDtLk45b7EuMO1iw/E1Mn5N
	/z/RtBtkPTlx0E5CaJLJwInqnTjvK1x3lKLxKQ5BXtqXWuRmBPQr6XLQV2B1Sjf2ZPARR9
	k7IDjzAmaTc/veC/D3oQYL5PdN9NBGiGsySwMkLF/ZP4KP/lo/lpvcn23nNfj0LyQVgQsB
	xRhCPnDjfCOEeFGabaVXsMoI9auGYvpaCK0ka9VfHZX7wWkT8gphVbKTWI8eaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  netdev@vger.kernel.org,  eric.dumazet@gmail.com,
  syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH net] ieee802154: 6lowpan: only accept IPv6 packets in
 lowpan_xmit()
In-Reply-To: <CANn89iKObcLouP=nE1RvZmq1qWywkTrA9x=O871-7_FKiWsFyQ@mail.gmail.com>
	(Eric Dumazet's message of "Wed, 3 Jun 2026 08:57:51 -0700")
References: <20260603072955.4032221-1-edumazet@google.com>
	<87h5njzkyy.fsf@bootlin.com>
	<CANn89iKObcLouP=nE1RvZmq1qWywkTrA9x=O871-7_FKiWsFyQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Jun 2026 18:04:59 +0200
Message-ID: <87tsrjy5hw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,datenfreihafen.org];
	TAGGED_FROM(0.00)[bounces-294826-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f13c19f75e1097abd116];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:from_mime,bootlin.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD7FA639E32

> Hey Miqu=C3=A8l,
>
> Yes, this is only for when the interface is configured as 6lowpan,
> which implies IPv6 traffic.
>
> If it's configured differently (e.g., for AOE), then it shouldn't be
> using the 6lowpan xmit path.

Ok, perfect then, thanks for the fix!

Miqu=C3=A8l

