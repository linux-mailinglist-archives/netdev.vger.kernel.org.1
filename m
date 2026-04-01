Return-Path: <netdev+bounces-273829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFYrFi57zGkbTQYAu9opvQ
	(envelope-from <netdev+bounces-273829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:55:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA684373955
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCE08304DF2D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CFF2D97BD;
	Wed,  1 Apr 2026 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II/XDMKn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288B2D3A60;
	Wed,  1 Apr 2026 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008438; cv=none; b=NzsHcBZGBP5emZKQUXzWNDRqvnCYIcQXVnNhhRE772QAuCv98yRt9vutv3Pbp/bHT9KNiDkgO9Y/f4vWW2Dq7MqOyMeyf0JZcTCnUzNDRKHBaaa9uAaLV2RZOItFOED5pXJ1dHA2ph6v7cIBS5Lw5vo8wBo8utkx7Fj6HCIB/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008438; c=relaxed/simple;
	bh=HhT6yASQN5Ht2USg6j+SW+L3E2x59AbUi5P3+MA1mKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyB5k0XcA9nX9gw3+MwMsNAwNp+rG0z/E7UDcjcUPcr0hqXhKGEmXLAVJNPIoE1Ni/YK2xEmRzvQKujCp1vCcS0V0zoCn4s+lyI26vYpbBua+95PCOpEAWyq1K9uC3hRqzprvgwUFnxSOpsOpCdAgEed2zLsaLvDZJ3ubxnoTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II/XDMKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BF3C19423;
	Wed,  1 Apr 2026 01:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775008437;
	bh=HhT6yASQN5Ht2USg6j+SW+L3E2x59AbUi5P3+MA1mKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=II/XDMKnvKJ+vkndI8SZhicoBoFbTSRUZWtM0DJou+Hlpbgh10wb+Ndr61Mu7zMVU
	 WIzEwylq093GQGYmjf4w7qHwfT+7u+ckY3TBPAAmQVUbxdpTHf+v2AgXLf+PkcqN2G
	 dKMIGeUoxb/6Ym1KQVnSXJamChQwf+thb5Hc3x5znwwt6t8BmM5Wk6pt7ylreHxzYM
	 7Nj4NEZ0FvinOyWwaQ9PbIveOdvBY+A4aLI5vtoy8s/070a+8cRm04/StQTjJipda+
	 fQXGoHnxkmB47z8TbIhcGk8YgZWtftSfCRqUe0xAJlOptXm/f6PtnDICpJ6+iNyIXn
	 sGztK9p+GayOQ==
Date: Tue, 31 Mar 2026 18:53:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, willemb@google.com,
 maheshb@google.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] Decouple receive and transmit enablement
 in team driver
Message-ID: <20260331185356.572493d5@kernel.org>
In-Reply-To: <CANkEMgkMRmyi3y-PdVTN66FHSrEO=neCp1N8PWbBrSA0yfDAzQ@mail.gmail.com>
References: <20260331053353.2504254-1-marcharvey@google.com>
	<20260331103308.421aac59@kernel.org>
	<CANkEMgkMRmyi3y-PdVTN66FHSrEO=neCp1N8PWbBrSA0yfDAzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-273829-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA684373955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 18:42:26 -0700 Marc Harvey wrote:
> On Tue, Mar 31, 2026 at 10:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Tue, 31 Mar 2026 05:33:46 +0000 Marc Harvey wrote: =20
> > > Allow independent control over receive and transmit enablement states
> > > for aggregated ports in the team driver.
> > >
> > > The motivation is that IEE 802.3ad LACP "independent control" can't
> > > be implemented for the team driver currently. This was added to the
> > > bonding driver in commit 240fd405528b ("bonding: Add independent
> > > control state machine").
> > >
> > > This series also has a few patches that add tests to show that the old
> > > coupled enablement still works and that the new decoupled enalbment
> > > works as intended (4, 5, and 7).
> > >
> > > There are three patches with small fixes as well, with the goal of
> > > making the final decouplement patch clearer (1, 2, and 3). =20
> >
> > The tests don't pass for us, any dependencies we should be aware of? =20
>=20
> Ah, I added a check for this using the `require_command` function, but
> it seems I used it incorrectly. I will fix this in v2, and probably
> remove the pv dependency altogether.

Instead of adding require_command - please use socat if you can?

pv is frankly highly unusual, most system images won't have it
installed. nc has multiple incompatible implementations so it's
a portability nightmare.

