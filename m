Return-Path: <netdev+bounces-229701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04AFBDFF35
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B10546330
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50672FFDFA;
	Wed, 15 Oct 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3FfehVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2F1547EE;
	Wed, 15 Oct 2025 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550806; cv=none; b=OzjzbT6/7/UFx0ZjI2Qw6Ml0ACmCB68AHHmcXAr6AbLt3KD4FKy+Kwmx1WrOQp8uv3yj+D0WouAK0+xBu0cnrx/3gvU6sguXumusrFgKh/G8lgJ/CtBCvyb7O6RmxVUj5KxJcLXqqtgRuxw7Gm6I7LV6JsDtpC087i1tvk4MFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550806; c=relaxed/simple;
	bh=M/aIcBS8J3HmXSplvgK4CDJCr+E7y/oHbQ0Pz0V7Kak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU6pqNzJsz6fXc8fFIwmA4GN19J1x7ZQEsM4pOufdPAUn+lSzgamio0DJ0i/cA7xnkPu0GQvZ9BuNs/FonxREzBZfEJI8m7x9caTChBOOJMTCRjCEdDgA+db3a9J8outN0yGxEBlIQ2TfHkbqXzbEy5esqegmJfXmj7Y81r95yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3FfehVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51366C4CEF8;
	Wed, 15 Oct 2025 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760550805;
	bh=M/aIcBS8J3HmXSplvgK4CDJCr+E7y/oHbQ0Pz0V7Kak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3FfehVgvIXCy9L64S2PD2yx6VgZ9hrVhfS2hw56aO8ssaAUL8taYBTIs66VHyAkT
	 +ObG/yMw1U1bOGNp7JAlMn8T1MaYd1bQvx30Sxmxp74q1tR5k46Vuo7d+W5IWoZpEs
	 z/Mj9mi25V5Ej/Tc8J3+W24pAXwB1SOhqzPi0Zmn28ZRx131ObA0ox5jZsKeeptgUJ
	 DvU/MlLA2YsJTQJPG7NRcpIRpP07oB9xZ7wnMf7SRRDZFSRxvBqlznY+f0tRvQ4eVu
	 NZZPhXFTfWGEzA0PC7YE0OVtnPAioykH4j/3PGl/mrJYGS6LwwFEdQXAZQ/gcjXJx6
	 kpdVN2WSmKnbA==
Date: Wed, 15 Oct 2025 10:53:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Frank Li <Frank.Li@nxp.com>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251015105323.7342652f@kernel.org>
In-Reply-To: <CAL_Jsq+wHG_DW1D_=dR6Q_mwyqFAXKGx771PsqjvW+XCRKM3tw@mail.gmail.com>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
	<20251014-flattop-limping-46220a9eda46@spud>
	<20251014-projector-immovably-59a2a48857cc@spud>
	<20251014120213.002308f2@kernel.org>
	<20251014-unclothed-outsource-d0438fbf1b23@spud>
	<20251014204807.GA1075103-robh@kernel.org>
	<20251014181302.44537f00@kernel.org>
	<CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>
	<20251015072547.40c38a2f@kernel.org>
	<CAL_Jsq+wHG_DW1D_=dR6Q_mwyqFAXKGx771PsqjvW+XCRKM3tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 12:32:14 -0500 Rob Herring wrote:
> On Wed, Oct 15, 2025 at 9:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Wed, 15 Oct 2025 06:53:01 -0500 Rob Herring wrote: =20
> > > That's fine. Though it will be optional for you, but not us? We have
> > > to ignore tags without the project if tags intended for netdev are
> > > continued without the project. Or does no project mean I want to
> > > update every project? =20
> >
> > Fair :( I imagine your workflow is that patches land in your pw, and
> > once a DT maintainer reviewed them you don't care about them any more? =
=20
>=20
> Not exactly. Often I don't, but for example sometimes I need to apply
> the patch (probably should setup a group tree, but it's enough of an
> exception I haven't.).
>=20
> > So perhaps a better bot on your end would be a bot which listens to
> > Ack/Review tags from DT maintainers. When tag is received the patch
> > gets dropped from PW as "Handled Elsewhere", and patch id (or whatever
> > that patch hash thing is called) gets recorded to automatically discard
> > pure reposts. =20
>=20
> I already have that in place too. Well, kind of, it updates my
> review/ack automatically on subsequent versions, but I currently do a
> separate pass of what Conor and Krzysztof reviewed. Where the pw-bot
> tags are useful is when there are changes requested. I suppose I could
> look for replies from them without acks, but while that usually
> indicates changes are needed, not always. So the pw-bot tag is useful
> to say the other DT maintainers don't need to look at this patch at
> all.

I don't think we need to do anything, then. Changes-requested will=20
apply across all the patchwork instances. Only not-applicable /
handled-elsewhere gets tricky with multiple instances.

