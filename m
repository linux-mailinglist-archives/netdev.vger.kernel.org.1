Return-Path: <netdev+bounces-251238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AFD3B62B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E0E93021EEE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F138F236;
	Mon, 19 Jan 2026 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="jCWxrInE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118524BD03
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848633; cv=none; b=Qr2SHdMj77mws1+wJzzKnKmMC5F/lxQBZ8a0i1nImL0uRw7ZsZxbXQk5fVehmpiBKsSzFS+bxINORlKM5lnVPbxHKGk84aZjV6vbnn5XRWUcXrFZdIKCGtNjTc7qhWfsyE/T5doReCUg3s5LEWD5aWrFLuELgLmDxmmvkLrylJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848633; c=relaxed/simple;
	bh=FmhelTXDMRdF5kxIDXr2Lw9tqn1prlQd8Gk6beCbtV8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6LbeZcwaMu0LfD59bjrhqipxe7EGCLXQSsNpdp5dGvoGM9Z26f12/98ho9qDpbOrBEm0lVDzZWIWpY1+seCrnM+eeYBiO3TP3A0XAqD5P2h0MbQId7UvlMkWsF99upGTGBzmyw82BnGupZVs2J5QgRIWW2sFZdxzhHQD8yL36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=fail smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=jCWxrInE; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768848613; x=1769107813;
	bh=FmhelTXDMRdF5kxIDXr2Lw9tqn1prlQd8Gk6beCbtV8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jCWxrInEnqKXhhEe+G29dV/8CVp0gOwG6+f3Dkzey2aOPRWcyj7fZTG48Rx3CiOCO
	 LmBPA2A09Hf42lUqF5Iw9lMw15JK2AYk1+/NpCuYSuaIg/82ng87S2Sicn+8bU6OFr
	 6F5qD5b8GUgPdx+qspmClAEaRbTaglEJPHvcaxCo7bdWTKJzVYUdRAMoZCJ4sU+ubn
	 fvjjg4EVjg59ggGs/JaELypNMXmweNs4oVGQ8B0vZKYJYb190MHVelrHcerOeXCZA7
	 1m/ZGHtZj4hQ155eeByfd1/Etz70AgDgiPQoi9DOsWuIjObpyKuLglvdR1ETXnJ1lE
	 zsfgApGNY/Hqg==
Date: Mon, 19 Jan 2026 18:50:08 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v1 0/3] act_gate fixes and gate selftest update
Message-ID: <BYUIZiIrbb9DuEGCzlZalUF5QXjBrQOyJOBOS6fyWQWUJkUN29LhrahP0603mdAW3y5Y7pgSJc0i8Y2O5yJ6ythPAknipI3h4N-aceF6jos=@1g4.org>
In-Reply-To: <20260119103251.41eb61aa@kernel.org>
References: <20260116112522.159480-1-p@1g4.org> <20260119103251.41eb61aa@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 6f2db73979e4bf230e9ae753610b7eb6c430dc26
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

I originally submitted to security@kernel.org on Dec 27th and this submissi=
on was a direct request from the maintainers. So if your concern is whether=
 or not they are tracking, I can confirm that they are. If it's just a matt=
er of adherence to process, than I will go ahead and do it, but wanted to a=
void the churn if unnecessary.=20

The big question currently is what is appropriate for stable. I do not beli=
eve it's possible to fix this issue without negatively impacting the perfor=
mance of the gate without either using a unlock =E2=86=92 cancel =E2=86=
=92 relock pattern or conversion to RCU. Neither of which is ideal for stab=
le, so more constructive input is needed.

Thanks
Paul




On Monday, January 19th, 2026 at 12:32 PM, Jakub Kicinski <kuba@kernel.org>=
 wrote:

>=20
>=20
> On Fri, 16 Jan 2026 11:25:50 +0000 Paul Moses wrote:
>=20
> > This series fixes act_gate schedule update races by switching to an RCU
> > prepare-then-swap update pattern and ensures netlink dump structs are
> > zeroed to avoid leaking padding to userspace. It also updates the
> > tc-testing gate replace test to include the mandatory schedule entries
> > so the test suite reflects the action's strict semantics.
>=20
>=20
> Please repost and CC appropriate maintainers and authors.
> ./scripts/get_maintainer.pl $patch
> --
> pw-bot: cr

