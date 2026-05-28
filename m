Return-Path: <netdev+bounces-292575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMXdHLvzF2q5WAgAu9opvQ
	(envelope-from <netdev+bounces-292575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:50:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 171C75EDF67
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 534A930A3625
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548FC34DB72;
	Thu, 28 May 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RRj0XWqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76D34C815;
	Thu, 28 May 2026 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954310; cv=none; b=OItKjaKPZrsIBA60n487ycsh56eei7K9dTdFUfQM4rwtDzNGfsgjgtnYTaRXMGWv9VyYmY/TcIqkxNxvJbGXaDWR+KTF0vzlHnHI5kml1dgSzle4uYNeWAEcJqbO3U0R458eM2qN3hUNf6zH6/WcJVL1eznUiQg74nrT/OJPvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954310; c=relaxed/simple;
	bh=EJub6JXBaWWgRu5cZ1gvCapF88tx4Za6Fv68dCVsrMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XxQu5Hpb9NXXxkjt7H3YA4QG1tlHDGAzh7lWcGwZRB07VtZIm5K9/WAlKDXVWkzQ7YNVwXVQtelgTqpoP06ZufcBI5XmRw7E9m9D4JcNDq4MMXP5xFuKRpnuHsCqQvXG7guWi1juMO8v3rdx+SuIenHZJUhzS//gywnL/J6KPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RRj0XWqY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E4E744E4106B;
	Thu, 28 May 2026 07:45:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8FE960495;
	Thu, 28 May 2026 07:45:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 422B81088806E;
	Thu, 28 May 2026 09:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779954305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o+jaleTw1PrS9lddrKqjpqnnZcDe+XAxXAP5SJyBXWo=;
	b=RRj0XWqYSEpbhqlQ28lfttUnTJSiY064TTecno3eu5Mnxy4ThKtkOuZ0AeLc4x+SxANGyT
	jWAyTaNwuwdW5uB6FfMIjfrMnKjA+qEdqzvJnq9a41EWCaEjbBjJP7gqvbeijwa1e8cfTB
	uq8YXUjq+foDA41bcXMfmQsX7VParDd9bWIgDGoCcEADUpPUQLxUexMIYIDQdO2F5Qv/TA
	Tp2a7oLhwDb9/HbhUi9swCax7Meznh/H43E/Cdx9i65klynIbufrqbrG1Ph/40h7+facKt
	ZppX/0ttMwX0Klsgn0G6VvkU6HjTa+aX84Zvmtaql4ydmmgOI+KUX4fH/6MO3A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "syzbot" <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com,  "Alexander Aring"
 <alex.aring@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,
  <linux-wpan@vger.kernel.org>,  <netdev@vger.kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Stefan Schmidt" <stefan@datenfreihafen.org>,
  horms@kernel.org,  linux-kernel@vger.kernel.org,  syzbot@lists.linux.dev
Subject: Re: [PATCH] ieee802154: fix kernel-infoleak in dgram_recvmsg()
In-Reply-To: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
	(syzbot@kernel.org's message of "Wed, 27 May 2026 20:18:18 +0000
	(UTC)")
References: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 09:45:00 +0200
Message-ID: <878q94htab.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292575-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[googlegroups.com,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,datenfreihafen.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 171C75EDF67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

LGTM.

> -	addr->mode =3D mode;
> -
> -	if (mode =3D=3D IEEE802154_ADDR_NONE)
> +	if (mode =3D=3D IEEE802154_ADDR_NONE) {
> +		memset(addr, 0, sizeof(*addr));
> +		addr->mode =3D IEEE802154_ADDR_NONE;
>  		return 0;
> +	}
> +
> +	addr->mode =3D mode;
>=20=20
>  	if (!omit_pan) {
>  		memcpy(&addr->pan_id, buf + pos, 2);
>
>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

