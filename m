Return-Path: <netdev+bounces-163306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A2A29E2D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4913A75E9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCB1CD2B;
	Thu,  6 Feb 2025 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b19ESuv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708716419;
	Thu,  6 Feb 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803971; cv=none; b=UJdtUX1gHgRDgHXHlLTjcFY8gRx4YOIzxb7NYU0IMqR0vr7zpdLqNQsQTWuooXoh6um8mgIR1YOcTqdbv/736oONS15bI9tvtvjZA55ipplqgH4+/PhOLfqg8OhnF4dgV294E5PzpvUfeEf1XCqtxwWpK/cjkvZOjYd5PzncG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803971; c=relaxed/simple;
	bh=HOdWJzeU3v6e7PDsfUyTV4ESJ3IStwKy6Qzl2uh6TyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xal2Td+qTNgT7daJeMZsfp70eiu6A9UNjML8TJ3gzW05b1Cv9TBKEBhAq1Xp0DFrEzLa4a4lpyqkN/KVdylpiTu1L7qhfu7U4HoKM95I+nkBllpD+TEtPntPxj0dTxhSXwk6Z3bSYIE1RXWxp0fUTulEItjraphkSyHHzwGIYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b19ESuv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27AEC4CED1;
	Thu,  6 Feb 2025 01:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738803970;
	bh=HOdWJzeU3v6e7PDsfUyTV4ESJ3IStwKy6Qzl2uh6TyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b19ESuv5mEuDrPXgD70hvQXK7YAywPGwzw4sRD6Wfy+xdLrg37nMo1SyGtvIr5h2y
	 vO5cXwRu3wADzq7QGgQqhGOLSH6hwyDpq3oiluwHkFOpMK7l65XiB+vj5TEZCkbRRL
	 F5dFbEcOtYgQcPIH7rnYU8dvBHEnaXosbELCA2vJp7vDP3X8y9YOFKr8LoQxDIhOkI
	 DJwxHcKWrl9Z/tePl0Igu7AFKMbGZrFVEs49BelDbgwHx8da52nZnlbS30pGnGAtpF
	 KP+OQ+v8+OLcqnD/eZyQyd4b/RfVIfxEQV8+T0bs6dDBZm1xn6O2H+RCeVA7F5xU08
	 5mk/JE4jZp2Cg==
Date: Wed, 5 Feb 2025 17:06:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: Laurent Badel <laurentbadel@eaton.com>, Andrew Lunn <andrew@lunn.ch>,
 <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 "Simon Horman" <horms@kernel.org>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3] net: fec: Refactor MAC reset to function
Message-ID: <20250205170608.15076b93@kernel.org>
In-Reply-To: <7501c8ee-9272-4c13-91a9-5c614c585fcf@prolan.hu>
References: <20250122163935.213313-2-csokas.bence@prolan.hu>
	<20250204093756.253642-2-csokas.bence@prolan.hu>
	<20250204074504.523c794c@kernel.org>
	<7501c8ee-9272-4c13-91a9-5c614c585fcf@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Feb 2025 14:53:50 +0100 Cs=C3=B3k=C3=A1s Bence wrote:
> On 2025. 02. 04. 16:45, Jakub Kicinski wrote:
>  > Please don't post new versions in-reply-to, and add lore links to
>  > the previous version in the changelog. =20
>=20
> Will do. Is it okay to only include the last version, or should I=20
> collect them going back to v1?

All.

> > On Tue, 4 Feb 2025 10:37:54 +0100 Cs=C3=B3k=C3=A1s, Bence wrote: =20
> >> For instance, as of now, `fec_stop()` does not check for
> >> `FEC_QUIRK_NO_HARD_RESET`, meaning the MII/RMII mode is cleared on eg.
> >> a PM power-down event; and `fec_restart()` missed the refactor renaming
> >> the "magic" constant `1` to `FEC_ECR_RESET`. =20
> >=20
> > Laurent responded to v1 saying this was intentional. Please give more
> > details on what problem you're seeing and on what platforms. Otherwise
> > this is not a fix but refactoring. =20
>=20
> True, but he also said:
> On 2025. 01. 21. 17:09, Badel, Laurent wrote:
>  > If others disagree and there's a consensus that this change is ok,  =20
> I'm happy
>  > for the patch to get through, but I tend to err on the side of  =20
> caution in such
>  > cases. =20
>=20
> I understand he is cautious, but I'd argue that the fact that two people=
=20
> already posted Reviewed-by: (not counting Simon, who since withdrew it),=
=20
> means that others also agree that we should err on the OTHER side of=20
> caution, and do the check in both cases. He also mentions that the=20
> reason he didn't do the check in `fec_stop()` was that he believed that=20
> the only time that gets called is on driver/interface remove, but that=20
> is not the case, as I outlined in the message already.

That's a bit of a he said, she said. Either you're see a problem=20
and you can describe clearly the behavior you see, and on what
platform. Or you're just improving the code speculatively, and=20
it's not a fix. The patch as is would end up in stable.

To be clear, nobody is against the patch itself, the question is
whether its a fix or refactoring.

