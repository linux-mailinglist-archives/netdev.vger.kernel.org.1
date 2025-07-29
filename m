Return-Path: <netdev+bounces-210865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13692B152A0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C38118A0D34
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBE22FDE8;
	Tue, 29 Jul 2025 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGdet10w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80B41C71;
	Tue, 29 Jul 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813417; cv=none; b=vF1pltVZMEAFHrwf/kZ05RQds/RCYIpjOR0l2mB5DTm9jYUECdUUUXtecU7MDQrYb25GHiOgqANzVx1eqV/mIg7LjU8uY6gvwNMuLpm8hS4gvF9+aFT0m1TwhZiZou92Md53A2BEQfnTDyiHciasbFKLnSloqJnMoJ1eQucJeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813417; c=relaxed/simple;
	bh=S1tVaqZobHB8q9zjdGUx4CXCdPJYTMB9/vmvwSE1Ngw=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvYqkbp7NP1+RaI8UsKrtr1tsP6Fe7hL0csgbf4tWQVDAK/90h+ulsDkfee2vxlpm0/MXKTA5zEWCewQr5aFjKAvdPbgGXcSJtYTmV8DxqFlA35OFRDVsbQTdh8hnWqJ1vk4ROl5OYrHPRlYDRKWa0lNxVxz5IPcNGmIytct0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGdet10w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E77C4CEEF;
	Tue, 29 Jul 2025 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813416;
	bh=S1tVaqZobHB8q9zjdGUx4CXCdPJYTMB9/vmvwSE1Ngw=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=bGdet10w95kEaVqZn66PTWKcCrQ78pas7YX0h5Jj3YVyP1v45ehhoXFa5Mnq4cBGO
	 Aw2K6KyZ+79DM9hHGkYMzpIaPSOGiyldRvbe3oHecsS0hmX+jQ/otlnpB9wxYH4B9y
	 +i8B7fALpX8urWnUKgAXO3XKElJmuUs0WTxSvyhOYTPavIZB2KxQkTO+HIAGqw9aHw
	 fnHpQ6QPc/CNqmvSRcdzy5Byq57LeA6FibVZ5nq/siixmZbr8CB3Nc4Bu+3BTqe+Oi
	 Spscd9g6Fbeytin+kD23bKs7N6rZm6N3GUtV5FOCEnYOthfGVCxOcJqjT+qDlWhNb6
	 7Z26rBeuksO0w==
Date: Tue, 29 Jul 2025 11:23:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jul 29th (meeting notes + TSC)
Message-ID: <20250729112335.19061045@kernel.org>
In-Reply-To: <20250728085356.3f88e8e4@kernel.org>
References: <20250728085356.3f88e8e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2025 08:53:56 -0700 Jakub Kicinski wrote:
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) /=20
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
>=20
> We have one agenda topic - Arkadiusz Kubalewski says:
>=20
>   Wanted to meet and discuss the need for clock id on microchip driver
>   provided by Ivan, I hope we could have a meeting to brainstorm some
>   ideas and decide next steps on how to deal with such cases.
>=20
> I can also provide a quick update on the netdev foundation activities.

Agenda items for next meeting (Aug 12th):
 - standalone phylink PCS drivers: as part of phylink? or as standalone
   subsystem? or not at all?

Meeting notes
DPLL
 - Arkadiusz: The standalone DPLL driver from Ivan doesn't have a
   unique clock ID, which is supposed to be the handle for the whole DPLL
   devices. The clock ID works for time appliances. The standalone DPLL
   device doesn't have a network card, so no MAC address, or ID.
 - Ivan: the device can be connected to multiple controllers, and drive
   multiple clocks. There=E2=80=99s no ID on the device, no serial even. We=
 use
   a random number for now, devlink can be used to change it.
 - Andrew: it=E2=80=99s an i2c device? (yes, i2c or SPI) Can we use the add=
ress?
 - Ivan: yes, but the i2c address is static, so if there are multiple
   buses or a mux the address will be the same for all devices in the
   system.
 - Andrew: we can include the full bus address (with the bus).
 - Jakub: can we define the relationship to the netdev port in the DT?
 - Ivan: we could extend the DT note which contains the pins to include the=
 MAC phandle.
 - Andrew: you can use the DSA definition as the sample to steal ideas from.
 - Ivan: the DPLL can drive multiple NICs, which device to pick for the clo=
ck ID.
 - Andrew: a diagram will be very helpful; Jakub: prefer using an explicit =
annotation.
Next step: send an RFC to the DT list..



We also had a netdev foundation TSC meeting today, here are the notes:

CI migration / HW lab:
 - Simon: we sent the RFQ out, colo is 10-15k, managed solution is
   double that at least, last minute we got an offer to host the lab
   for free.
 - Andrew: having a commitment for the free offer for at least a year
   would be good
 - Johannes: the company is considering joining the Governing Board
   too, so they should stick around
 - Eric: what is the location?
 - Simon: Chicago and Amsterdam, none of them have our people local
The HW lab project ($70k regardless of colo selection) is approved for
funding.

Small budget items (<$1k/yr total - Google Drive, Plausible subscription):
 - Pay for a Google Drive for TSC docs and Plausible for web analytics
Approved

New members:
 - The company trying to join made us realize we don't have a process defin=
ed.
 - There may be contentious applications in future, do we want some control?
 - We have a voting system for electing TSC members, but not to Governing B=
oard.
Revisit in next meeting.

Rate / rank other projects on GH:
 - We need a shepherd per project first - assign tickets in github
 - TSC members to "like" projects they want to see done
 - Johannes to add more labels/milestones to mark what's already in progress
Revisit in next meeting.

How do we engage with the Governing Board:
 - Simon: the GB has a chair elected. Whenever we have a proposal we
   contact the chair and ask for them to convene.
 - Willem: does the board has a regular meeting?
 - Simon: the cadence is not decided, the default is every 3mo. We can
   ask to expedite, or even to meet monthly.
 - Willem: if we=E2=80=99re trying to get them to convene we should ask abo=
ut
   the membership vote right now. Avoid delays.
 - Ask LF if membership approval is allowed. Ask for simple majority vote.
 - Simon: LF will be involved in the email exchange with GB, we can go
   direct to GB. Probably want a =E2=85=94 majority, simple majority is too
   weak, veto is too strong.
 - Jakub: what about renewals. How about also optional =E2=85=94 vote to bl=
ock renewals,
   if no vote requested renewals auto-approved.
Ask the board for: HW lab, small items, and the membership vote amendment.

