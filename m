Return-Path: <netdev+bounces-301850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fZ9KAqCYPGrJpggAu9opvQ
	(envelope-from <netdev+bounces-301850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:55:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4726C27A8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hw9HpkHr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301850-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301850-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2DF3024A6A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C12DEA93;
	Thu, 25 Jun 2026 02:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C914F70
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 02:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356124; cv=none; b=qa4XMCOrGf7wT2cBCAh5hqEVqp7N+JPzPJ/5LF0DbXViXNWJzmCW/M0fnY3Y/RyQClaXssnrmN/iLE4lMK9it8PypAfvMTOaVF5DfS9CJ+Pst9CVA12LEjf7QyiG8zkbvMUdmIQR06zi3Wlrl89DyphY/2J/jzH+2X6WSpPou4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356124; c=relaxed/simple;
	bh=+DTyewdrr3c9PqDjDPYF+URpIxUPvAA/Djm6TmeaGEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9nPzBvoJRhxwD6GR57F/CFzzsViBQgMlBF/yLLwJ/4yg8bSCwRbjNLV4AYz4aWMtITbjXtZALA2ZXzQHeuC5c0zhnUllqeX1aSzn5DLjEsTI6NPcmzvMxjtdY6XT8XzCtUwhMlKC5QFGPvmVDJIGHvr8Bmm7e8WL6jpmEMxMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw9HpkHr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82481F00A3D;
	Thu, 25 Jun 2026 02:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782356123;
	bh=gNFHA5iA8UHmzGuXYaMBJooXXI4fv7MaziCZlJz6Ts8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hw9HpkHrtQya5rQAjdndl63k1BXqbDsGxTA3taCTkIOikKc8fzKEqdgz08vhERKn/
	 LaThDjn5oljUsBFv7WDr0aXfwQ5D0DLi0mSvgpb7yHgTmn4zMMlBeAZ7uc+TMQoYul
	 BIcBHIiQP7Zsco0Mqr7iFRpEkpxINSc/G4Vx3Ed6kgJefQ1gLNCMrhl4sXpjJ1Qvip
	 INXZk35krJF0vp46fAQocj5k9pYYwdHTGimWwZ4OkWiv3wA60hdRBtLQDEseP+8qxc
	 n+o8WLRxBPkYY+krwgc6S60Ad2+TEwRBq33g9TW62k9LutH1Q9tITHpYr5p5YfomU9
	 9tzLyU4+U6ETg==
Date: Wed, 24 Jun 2026 19:55:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Yue
 Sun <samsun1006219@gmail.com>
Subject: Re: [PATCH net] net: udp_tunnel: fix use-after-free by refcounting
 udp_tunnel_nic
Message-ID: <20260624195521.5972a5a8@kernel.org>
In-Reply-To: <04d09dea-baa2-4c43-ada1-cd71579aad53@linux.dev>
References: <20260624171034.4117423-1-edumazet@google.com>
	<20260624145722.083632b6@kernel.org>
	<04d09dea-baa2-4c43-ada1-cd71579aad53@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301850-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:samsun1006219@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B4726C27A8

On Thu, 25 Jun 2026 10:47:09 +0800 Jiayuan Chen wrote:
> On 6/25/26 5:57 AM, Jakub Kicinski wrote:
> > On Wed, 24 Jun 2026 17:10:34 +0000 Eric Dumazet wrote: =20
> >> Yue Sun reported a use-after-free and debugobjects warning in
> >> udp_tunnel_nic_device_sync_work() during concurrent device operations.
> >>
> >> The state flags of struct udp_tunnel_nic were originally bitfields
> >> sharing a byte, modified concurrently without locking (RCU vs worker).=
 =20
> > Can you clarify the path where the bits are modified without locks??
> > My mental model is that this is basically all under rtnl_lock, and
> > Stan added _another_ lock so that drivers can call "sync" / reply
> > without needing rtnl lock, but any changes are still under rtnl_lock.
> >
> > The gap seems to be that we don't check pending under Stan's new lock,
> > since commit 1ead7501094c6 ("udp_tunnel: remove rtnl_lock dependency")
> > did: =20
>=20
>=20
> I think the real problem is that a single work_pending flag can't track=20
> the work being queued twice:
>=20
> 1. Thread A calls queue_work() -> work_pending =3D 1.
> 2. The worker gets picked up; workqueue clears the PENDING(internal work=
=20
> queue flag) bit before running the work function.
>  =C2=A0 =C2=A0The worker then blocks on rtnl/utn->lock.
> 3. Thread B calls queue_work() again. Since PENDING was already cleared,=
=20
> it enqueues a second
>  =C2=A0 =C2=A0instance and sets work_pending =3D 1.
> 4. A's worker finally gets the lock and does work_pending =3D 0, runs,=20
> returns.
> 5. Now work_pending =3D=3D 0 but B's instance is still queued. unregister=
=20
> sees 0, frees utn.

Ah, thanks, now I get it. Claude told me the same thing but in 10,000
words and I lost the thread before reading 'til the end...=20

In that case:

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 9944ed923ddf..3b32a0afa979 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -301,7 +301,7 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, st=
ruct udp_tunnel_nic *utn)
 static void
 udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *=
utn)
 {
-       if (!utn->need_sync)
+       if (!utn->need_sync || utn->work_pending)
                return;
=20
        queue_work(udp_tunnel_nic_workqueue, &utn->work);

