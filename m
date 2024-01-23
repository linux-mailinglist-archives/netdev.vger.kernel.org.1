Return-Path: <netdev+bounces-65128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6758394B3
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3891C2215F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85AF7F7D5;
	Tue, 23 Jan 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmOdM/+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2027F7C8;
	Tue, 23 Jan 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027597; cv=none; b=gmBIZNfiDylK698ScGJeds0T/Gk31cl/hZkbY3Tg/ZqxuYwh0/TrWYbigs5FuI0a9wDIK95jmNM1wDZr5tocB7yMo0U19LysHJ7wry53/xU+E59Nw2V6xzo4fAia1E2Q92U38E7SpAgwKt01dhhtJuueIaQU9X84rdTGyGo4BbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027597; c=relaxed/simple;
	bh=cEYWb7z5zhOm8nWILXf35I2a7INgOaPVXMR7/EvtqwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBWJdsgav2caqY+CjFnwhTUDHv6Tt645DFWFKzrRq2HOnvwcMgYI9Wml8fGSkvAdpTTmhF6xcSmMIC7BmKe94owGAGYrASOWOzOUx5HUVQ8mD5pgnv/suSNw8Lc97cbKH8K+HNTSdBudIv7IWZLAGZElkUu8eyTM9UpDWcet+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmOdM/+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC1AC433F1;
	Tue, 23 Jan 2024 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027597;
	bh=cEYWb7z5zhOm8nWILXf35I2a7INgOaPVXMR7/EvtqwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VmOdM/+GhaqIl3wzihLquSnkq+hRNBwDwqh6goHtBgnhwX/a8cjJ5Ta5LD+MIfBGy
	 M7oVi4Brz9E5txKTk+qP1L7xXjKHvrHCAQ6YzoPVVgiG09lmSdhNcVf7D7n80r+1N2
	 3zf3RYtwkDcPW3JgdVTA1hRCkIjCc2lcN6RKHivdjQi3n9G9gBTYaLcMP8uyELN8wz
	 1uqvCe8YoFG+mSYUkK0Zb43FZqMRqrjQh828w78IXDEf9yzhCk1i4PxZ0fAjWf1Sxz
	 1CDz8FduBf9vQ55Us8a1XEg73TBEVje1gg9fM7oCIwJhpXEt/h6+PyBhOmcUyEgf2B
	 iC+vg/2nQvzbA==
Date: Tue, 23 Jan 2024 08:33:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Matthias May <matthias.may@westermo.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240123083315.1f971ab6@kernel.org>
In-Reply-To: <8734uonhfv.fsf@nvidia.com>
References: <20240122091612.3f1a3e3d@kernel.org>
	<87fryonx35.fsf@nvidia.com>
	<83ff5327-c76a-4b78-ad4b-d34dae477d61@westermo.com>
	<87bk9cnp73.fsf@nvidia.com>
	<20240123073018.0e6c6a13@kernel.org>
	<8734uonhfv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 17:05:12 +0100 Petr Machata wrote:
> >> It looks like whatever is serving the output should use MIME of
> >> "text/plain;charset=3DUTF-8" instead of just "text/plain". =20
> >
> > =F0=9F=98=AE=EF=B8=8F interesting. The table characters are not part of=
 ASCII, right?  =20
>=20
> Yeah, the table is UTF-8.
>=20
> > So it must be using some extended charset. Firefox hid the option=20
> > to tweak encoding tho so IDK what it actually uses :S =20
>=20
> My guess would be ISO-8859-1, but dunno. The developer console shows
> Firefox has had to guess the encoding, but not what guess it made.
>=20
> It seems weird to guess anything but UTF-8 in this day and age. Maybe
> the logic is that modern web has correct content-type, because it needs
> UTF-8, so if it doesn't declare encoding, it's something ancient.

Ah, sorry, I read your message backwards. I remember fixing the encoding
on the NIPA nginx to make it utf-8 so I thought you said it's utf-8
and should be something else... But the runner has a separate
instance, and there the charset is indeed not set. Fixed now!

