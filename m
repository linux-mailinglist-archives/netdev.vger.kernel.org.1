Return-Path: <netdev+bounces-241394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B277C8354C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 513B54E1A9B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4016284689;
	Tue, 25 Nov 2025 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="EFxWzcF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch [109.224.244.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561512CDBE;
	Tue, 25 Nov 2025 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764044976; cv=none; b=TsOwfWzbAqw+S0mpjOC90uZrmCU/iKm0Bi32C33Fp+Go4J7rwfLEBSouPhXFTuCeWJ+TPPctJ3UeVIsrTqiYS2ecZX2HeYZcAU4lPRJShN146sUnc+TfqHJRss45lhSeGTEqhYUTpygf7oQTH0kryLVmafz7NYXvvzokRDfFgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764044976; c=relaxed/simple;
	bh=+I/Q2o6Dsn3gHWDBmg2b0MganE6v/P6P0PtYU5JYcE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogU3EOwCaNI+xmMXwUQbMYlbjzP3a0MdVosnWIryC4abelDQ7ljxSdKdOxoq/jAxWvFXJZctFOa8PHWa1oj7MUyQFpsQy3Zx0WlprRLwBUC6h1WxfKwvpJkuQqjJghauklAOgTcaDdG2MK50SX/RbZZiMJ1x7cYW4/68kcCPiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=EFxWzcF3; arc=none smtp.client-ip=109.224.244.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1764044416; x=1764303616;
	bh=+I/Q2o6Dsn3gHWDBmg2b0MganE6v/P6P0PtYU5JYcE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EFxWzcF3adqBr87RcRLTU727hynIU0Wz4mD3ivvmchpSIEKpUah4RNS4Qs+UmzXAo
	 Xhu6Eggm9KBV9VYCy5zgPget+YXtLc5dFoEtVcmagedSd8CY13yIKy2XozRKW2BkJC
	 wfZEwDalSaErwL+PASYR8LGKLcC83rR+QB6RVbuFbkLqEGDOEROGXr68nk2kqKnVKO
	 Wj6Gp60XXqa/5JS2NTSMVV8c+wbfmLYvRCRfV9+arm5ZQnS8BAhws4fuYB2/wTm+e3
	 yiAfxOcJO1GzV7ConVhFaNegEj0L5FggO41b0qVFTRqZ2qKIN1453agwxOX/8qe4mN
	 YJeclbBZZShfQ==
Date: Tue, 25 Nov 2025 04:20:13 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: William Liu <will@willsroot.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jschung2@proton.me, savy@syst3mfailure.io
Subject: Re: [Bug 220774] New: netem is broken in 6.18
Message-ID: <PKMd5btHYmJcKSiIJdtxQvZBEfuS4RQkBnE4M-TZkjUq_Rdj6Wgm8wDmX-p6rIkSRGDJN8ufn0HcDI6-r2lgibdSk7cn1mHIdbZEohJFKMg=@willsroot.io>
In-Reply-To: <20251124191625.74569868@kernel.org>
References: <20251110123807.07ff5d89@phoenix> <aR/qwlyEWm/pFAfM@pop-os.localdomain> <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com> <aSDdYoK7Vhw9ONzN@pop-os.localdomain> <20251121161322.1eb61823@phoenix.local> <20251121175556.26843d75@kernel.org> <aSH9mvol/++40XT0@pop-os.localdomain> <20251124191625.74569868@kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: ee86c3d61e813f6cff3aa12335b19592854ed931
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Part of the original issue was that alternative proposed fixes did not work=
 and still allowed for local DOSes [1] [2].

An easy fix that was suggested was to not enqueue from the root [3][4]. How=
ever, this changes behavior that has existed since the beginning, immediate=
ly caused a new bug, and Hemminger mentioned that the original behavior was=
 necessary for "trying to keep proper semantics and accounting especially w=
hen doing rate limits." An argument can be made that Cong's change doesn't =
violate manpage semantics, but that may still break user setups, just like =
the current scenario.

Jamal had a good idea on using tc_skb_ext extensions, but I pointed out a f=
ew implementation issues we would have to deal with [5]. From what I unders=
tood though, that solution would preserve all the existing behaviors and av=
oid the DOS bug. It's been a while so let me know if that is not the case. =
Otherwise, I can try to implement it - I am quite busy though so it might t=
ake a while.

On Tuesday, November 25th, 2025 at 3:16 AM, Jakub Kicinski <kuba@kernel.org=
> wrote:

>=20
>=20
> On Sat, 22 Nov 2025 10:14:50 -0800 Cong Wang wrote:
>=20
> > > I guess we forgot about mq.. IIRC mq doesn't come into play in
> > > duplication, we should be able to just adjust the check to allow
> >=20
> > This is not true, I warned you and Jamal with precisely the mq+netem
> > combination before applying the patch, both of you chose to ignore.
>=20
>=20
> I'm curious why we did.. Link?

The issue was due to filters redirecting packets iirc [6]. We decided to mo=
ve with it and come back to it if someone did rely on this rare setup [7].

If anyone wants a quick refresher on the bug, please take a read at [6] as =
it contains all the details and issues.

[1] https://lore.kernel.org/netdev/20250701231306.376762-1-xiyou.wangcong@g=
mail.com/T/#u
[2] https://lore.kernel.org/netdev/20250707195015.823492-1-xiyou.wangcong@g=
mail.com/T/#u
[3] https://lore.kernel.org/netdev/20250713214748.1377876-1-xiyou.wangcong@=
gmail.com/T/#u
[4] https://lore.kernel.org/netdev/CAM0EoMmTZon=3DnFmLsDPKhDEzHruw701iV9=3D=
mq92At9oKo0LGpA@mail.gmail.com/T/#u
[5] https://lore.kernel.org/netdev/pGE9OHWRSf4oJwC4gS0oPonBy8_0WsDthxgLzBYG=
BtMVeT_EDc-HAz8NbhJxcWe0NEUrf_a7Fyq2op5FVFujfc2KyO-I38Yx_HlQhFwB0Cs=3D@will=
sroot.io/
[6] https://lore.kernel.org/netdev/CAM0EoMnd0nZxJW3zpEuBGWTwB3AnJSnj242f9hM=
pcLdBWdcbfQ@mail.gmail.com/
[7] https://lore.kernel.org/netdev/20250707142617.10849b9e@kernel.org/

