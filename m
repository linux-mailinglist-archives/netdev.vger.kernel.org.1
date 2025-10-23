Return-Path: <netdev+bounces-231952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954FBFEDD8
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1B83A4ED2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0241D5CD4;
	Thu, 23 Oct 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp0mT1xM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10213AC1C;
	Thu, 23 Oct 2025 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183919; cv=none; b=nIvsKPVeCrVZ7MW/FXLY1YU4D77aJxGJFiC1s+qoj4vSXO7A00KKk6d/ncosGm03PdMRUEMbgEBxFIYTy8TqEChcV8MZfNhuAMqp0RD+qWwmRa07zRa2766v5Dd8NSlHrpDyxqUyBL25dnyOfO1XkCJdJ7I1w0S5JccNz5MX1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183919; c=relaxed/simple;
	bh=ttnZlZqD9AOwVWY0BumPMO3jxsgOx+axuNso15oTxPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUPq1w5Byi0oy0B5nhcN1nWmxBJefDHOBKHKISvecWUbQsHAnb48kwnl4yjaKtrCnc+Ju/jvcup3/vsjy3KXNo23OLEmIujIVKO5hSAh0HOm+lx8QLQS7bky40OR2xT2/eGG1TgdU3WzA3ysvCCB6kErNZEXtrNBxgA27L8VcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp0mT1xM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE5CC4CEE7;
	Thu, 23 Oct 2025 01:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761183919;
	bh=ttnZlZqD9AOwVWY0BumPMO3jxsgOx+axuNso15oTxPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wp0mT1xMf13zTLvjPiHx+Hippwo2+RHMf+Jnzo43L43VLesc/Os6jufVCDCVpFXqD
	 9oYfuVjvi89+zpFOf5pZ916b2wmMGAGZ99WvdCprYQrQ81wPwJP3MwZBAP/fJgCx2T
	 AZIwkR5CAMtSVZLBMqw03tn+r4+4DJnFmyOKKXAjum8SmnwPn4dZVxVoSAhGF6ifuJ
	 QUbnw4+ZRfm/FwA4L6Q2GD0gOB0c+rh2Dq5lh+x1f993Z5G4wQFpF536f++eD9s/z8
	 wmfYpXsGzU/3Iz3gG7afkY1h6aECjrWjtbSqw0T+21atRbsEJwgMfZk2Czajqjq4iS
	 g7mfULbqTyz8A==
Date: Wed, 22 Oct 2025 18:45:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Chia-Yu Chang
 <chia-yu.chang@nokia-bell-labs.com>, Chuck Lever <chuck.lever@oracle.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] ynl: add ignore-index flag for
 indexed-array
Message-ID: <20251022184517.55b95744@kernel.org>
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 18:26:53 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This patchset adds a way to mark if an indedex array is just an
> array, and the index is uninteresting, as previously discussed[1].
>=20
> Which is the case in most of the indexed-arrays in the current specs.
>=20
> As the name indexed-array kinda implies that the index is interesting,
> then I am using `ignore-index` to mark if the index is unused.
>=20
> This adds some noise to YNL, and as it's only few indexed-arrays which
> actually use the index, then if we can come up with some good naming,
> it may be better to reverse it so it's the default behaviour.

C code already does this, right? We just collect the attributes
completely ignoring the index. So why do we need to extend the
spec.

Have you found any case where the index matters and can be
non-contiguous (other than the known TC kerfuffle).

FWIW another concept is what TypeValue does.
"Inject" the index into the child nest as an extra member.
Most flexible but also prolly a PITA for user space to init those
for requests.

