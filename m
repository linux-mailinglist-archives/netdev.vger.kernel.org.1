Return-Path: <netdev+bounces-211000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E616FB161B9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3285418C6EF3
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1732D7814;
	Wed, 30 Jul 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t83Oy5sC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D5293B73
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883121; cv=none; b=CtsUswD5GttPFeWnp7zuAoI/oNKpUbLcLoVq9erg5XNG+42l4mbl+EPiEc6SsOH2IhrQS1HNMxPz0LQLUxXYmkpjIhwkAm9JKt5v08xCKeiY+10nIG/X84kqpGm5vVrDKNb+lI/FDkMkZgiDEIotKEIUG/biHAD0enUKX1wWZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883121; c=relaxed/simple;
	bh=13ObknUHmABT+w8CaNxwkbPmI3GtDczqQN2CCJN7YjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGs8z2/L075HAue68xBCZrTv2d6h7GGQ5zpDuRW4WRMZ/sJFHJSH7OaALw1ujJL6wp6jZ1qup31PRRFkoalAaAltEWwcH4bWxrEaoha/hsj7vRagnQR+tTBlhvYIt30HYSYm/MgeJXjgRjw8T/PcGbrhdtSNQFtsvL5x8bnX0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t83Oy5sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CABC4CEE7;
	Wed, 30 Jul 2025 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883120;
	bh=13ObknUHmABT+w8CaNxwkbPmI3GtDczqQN2CCJN7YjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t83Oy5sCfDdc9Dduz4fVHZN9v1uyS2a+9XcuIuewQvegVOzJdk+irdN3AUcz5Am9z
	 zcHu1jDHNd7QyOGcsNFtj+VfnaHI5rh+I0SjxHTIu+r1axAcnO1ajZVwn8lVzmjUER
	 yu7WfvFObbDxkmtAmdOY54SA795arO5Ve9PkAoprKsHq68x2oGiKM1omVFXJpTm+av
	 VTBpK1dojJ7YLSsGxUS88pqr+KlUpYP4wg3hxqMNVV0ibzBKxMnNucwF5KSJKpMAnA
	 C3KKSawsl3j2EATteo0JYdCS6JoXt4VfRHleaJnfks3nzW6VroXzBbBfS2ZdDzjWEZ
	 lcvaQ2jKwEQpQ==
Date: Wed, 30 Jul 2025 06:45:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Andrew Lunn <andrew@lunn.ch>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 intel-wired-lan@lists.osuosl.org, Donald Hunter <donald.hunter@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <20250730064519.38abc0c3@kernel.org>
In-Reply-To: <15ca2392-1dbd-4f4d-a478-3d8edc32bc90@linux.dev>
References: <20250729102354.771859-1-vadfed@meta.com>
	<20250729184529.149be2c3@kernel.org>
	<15ca2392-1dbd-4f4d-a478-3d8edc32bc90@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2025 10:22:36 +0100 Vadim Fedorenko wrote:
> >> +    name: fec-hist
> >> +    subset-of: fec-stat =20
> >=20
> > no need to make this a subset, better to make it its own attr set =20
>=20
> like a set for general histogram? or still fec-specific?

You can make it a general histogram, I guess =F0=9F=A4=94=EF=B8=8F
No strong preference.

> >> +    attributes:
> >> +      -
> >> +        name: fec-hist-bin-low
> >> +      -
> >> +        name: fec-hist-bin-high
> >> +      -
> >> +        name: fec-hist-bin-val
> >>     -
> >>       name: fec
> >>       attr-cnt-name: __ethtool-a-fec-cnt =20
> >  =20
> >> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] =3D=
 {
> >> +	{  0,  0},
> >> +	{  1,  3},
> >> +	{  4,  7},
> >> +	{ -1, -1}
> >> +}; =20
> >=20
> > Let's add a define for the terminating element? =20
>=20
> I believe it's about (-1, -1) case. If we end up using (0, 0) then there
> is no need to define anything, right?

Yup, 0,0 is better written as {} so no need for a define.

