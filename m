Return-Path: <netdev+bounces-276005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LjTI5MP1Wl20AcAu9opvQ
	(envelope-from <netdev+bounces-276005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:07:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB93AFB63
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A30313012228
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513B2036E9;
	Tue,  7 Apr 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE4jobFy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7570818
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570659; cv=none; b=E+2fJ08Fk7uFyvUIKnepieiV73is3LhszygApwDxnQZmcKZj77Xt8FclGJ9UEwSdaH5/RmdPL4z0hFVbu7VFqVaywvcbEUCKJU944bxLVNhTwMaNslCZfvmM4e6fG2NwMLT9YXHWI6Ql00zX9HL3N6CelrjWkk4XTCutW8QbJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570659; c=relaxed/simple;
	bh=YpiW0E2JUUnKYs4Ck/w3P0cqQOsNWSO9qCHnjdUPI6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXCRpQ7IXZioWc5dfwvCEDKVVGISnYb9XsQsRJGjHIRAiflphZK8JX/nTHduuUIb+bWB7xWIPcQ2yzXrT0JglE6S5em/A6sduuiRzs6jU7wNG9B1mA4fjLuSgmyx93Bm338a+UsRTvQwG3pQT3NT+Jq1tRJKEJz7O/I7dIQ8AAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE4jobFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C63C116C6;
	Tue,  7 Apr 2026 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775570659;
	bh=YpiW0E2JUUnKYs4Ck/w3P0cqQOsNWSO9qCHnjdUPI6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CE4jobFyUGbzBZv/mUiT335g/hHhb1W0R4g/7WnQ76y6qjJJPhlYx26qMNl2wN9L8
	 BB7wfn1tRlVN/e/liJWfYca8vYd+tV+c+FnYo847pJ6phnLLGELMHVZKpvuDbT//FM
	 7VWBSEcwSoytRIUe1TLKpbqLun/5letcOKYsCmbw70QN5dfoPPcXo+HvSsrfnzyPq6
	 uk4zKiSVPLekgHQ8jM8lAjvcj0fIdDS3PJ/jJIz41e7QCWBVsBMQmWPyQfQyn69MeA
	 /5JOBORD8x0tvNT/wknBOkADcPz8GPZLWgNG7Emdm20ijB4n2gB9AgGUOdrg+38AWZ
	 fCQSsLzI37/Qw==
Date: Tue, 7 Apr 2026 07:04:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: dropreason: add
 SKB_DROP_REASON_{BROAD,MULTI}CAST_BACKLOG
Message-ID: <20260407070417.38ace6ca@kernel.org>
In-Reply-To: <CANn89iJeijaiWZUeGfXUBBN-JjWRfB=afrPXP9=PH_vPSU2s6w@mail.gmail.com>
References: <20260403022443.3480770-1-edumazet@google.com>
	<20260406180254.5221a267@kernel.org>
	<CANn89iJeijaiWZUeGfXUBBN-JjWRfB=afrPXP9=PH_vPSU2s6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276005-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6CB93AFB63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 03:09:41 -0700 Eric Dumazet wrote:
> On Mon, Apr 6, 2026 at 6:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Fri,  3 Apr 2026 02:24:43 +0000 Eric Dumazet wrote: =20
> > > ipvlan and macvlan use queues to process broadcast or multicast packe=
ts
> > > from a work queue.
> > >
> > > Under attack these queues can drop packets.
> > >
> > > Add BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.
> > >
> > > Add MULTICAST_BACKLOG drop_reason for ipvlan multicast queue. =20
> >
> > What distinction are you trying to communicate by using BROADCAST
> > vs MULTICAST? Funny naming of the functions aside I believe that
> > in both cases we're basically dealing with multicast traffic.
> > Reading the code it seems like macvlan has some optimization where
> > it delivers the frame inline if the multicast group is not very
> > popular. And if it is popular it schedules a work (and calls that
> > broadcast). ipvlan doesn't have the inline filter and calls the
> > deliver via work multicast.
> >
> > tl;dr I think the drivers do the same thing just call their functions
> > broadcast vs multicast. Having two drop reasons here is actively
> > misleading? =20
>=20
> My intent was to differentiate ipvlan and macvlan reasons, some
> deployments use both.
>=20
> I can rename the reasons if you think this is better.
>=20
> IPVLAN_MULTICAST_BACKLOG
>=20
> MACVLAN_BROADCAST_BACKLOG

Sounds better, thanks

