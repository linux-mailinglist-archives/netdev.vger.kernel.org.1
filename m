Return-Path: <netdev+bounces-256553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPXgJjLDgmkpaAMAu9opvQ
	(envelope-from <netdev+bounces-256553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:55:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61396E16BD
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B1330602E1
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C62DD5F6;
	Wed,  4 Feb 2026 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZTkfiW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF72C21EB;
	Wed,  4 Feb 2026 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177256; cv=none; b=Bg7P1/5vjUmZLvGNubhNJD/5wWAIh4kqKPGSkqUMwQl5mUapTk0uNWHkEnZ3oeg6ALHFqO8BXuc7PPEuE2zAE6AvUeA5fwKZ9o7qRinKHrq7YhijQxCKXRvdpsAELeG3rRaUhjmHw0p9bWywER3nlEFBUJKIt9zwr6xnszyJPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177256; c=relaxed/simple;
	bh=JfvJdjP9ALmgcB1djDN/2/mYdI+tzqZNeVhi2LeRlHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjLvzfGbki6u8L8VGBy5kAs5q3E/tlnV6VRJUZueaEE1x1AHidG0kFLNY0gbpYTzPgWY6B32cWjVQYKPY9wv4J9Nh9z4lcN7hzupz8dFhP11ezVtexZnTXpKoSqCe8RTPLQ5ZOQqeLrI8rwXBnwoBeincaUP0C1P/cdAiNZgxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZTkfiW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A9CC4CEF7;
	Wed,  4 Feb 2026 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770177256;
	bh=JfvJdjP9ALmgcB1djDN/2/mYdI+tzqZNeVhi2LeRlHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZTkfiW58FlkqFEOqSbmwvwwWXD/wA4jUHjwDrAbWJ7RluBt17EtgOYv1BkXGGlOZ
	 qqtOmM94fWeY6QbEvEcsKq6ZCqnPYCkqhZzLsVquCTJCUyYO4enH5J8S/GKUJQlWIl
	 jfD562jhkVXBpSqjqZ/XcCG0GFI7/Qh33LSH3LdKJZdc80/QWNWs9zNUo+eJ3UHFLO
	 W75zBwhSL0hCzXueJkOQ8tqJW/H8o8XUVn8t4dGfcG8aqGnGGf+Ylt/NiaV0g9lyTi
	 lfqjfRASRfSswCDYjDX3Ek95t/MJl11uAjJUer5JJ1jK+kLE9pM8H3Ld9CFXxrlwmH
	 T95yBU0V1l8eA==
Date: Tue, 3 Feb 2026 19:54:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Eric Biggers
 <ebiggers@google.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next v3] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <20260203195415.7e462c91@kernel.org>
In-Reply-To: <CADkSEUgoOyeUqGHXqimczdo1M0S6C20GOpKH5OuEeaRhFnSTDA@mail.gmail.com>
References: <20260203013924.28582-1-enelsonmoore@gmail.com>
	<20260203194317.07432b29@kernel.org>
	<20260203194447.0ce4ffd7@kernel.org>
	<CADkSEUgoOyeUqGHXqimczdo1M0S6C20GOpKH5OuEeaRhFnSTDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256553-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61396E16BD
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 19:46:32 -0800 Ethan Nelson-Moore wrote:
> On Tue, Feb 3, 2026 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Tue, 3 Feb 2026 19:43:17 -0800 Jakub Kicinski wrote: =20
> > > Not sure these annotation on the get are useful =20
> >
> > * annotations on the review tags
> >
> > synapses misfiring over here. =20
>=20
> I will start moving them to the changelog in the future.
> Do you want me to send a new version with them removed, or are you
> going to do that when you add your tag? Either is fine with me.

It's not a big deal, applied thanks!

