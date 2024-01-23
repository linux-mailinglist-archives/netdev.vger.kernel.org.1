Return-Path: <netdev+bounces-65083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22198392B7
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710FFB24FC9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F525FDC8;
	Tue, 23 Jan 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLsQbKGW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE05FDB9;
	Tue, 23 Jan 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023820; cv=none; b=XGYy6F8AgX9QpXeRcVwEosUWhZtjgCp4fhcjq9QEWMYYMLpbzronu/9kbj8CaEb8SvSEMDSJyYRluQ9k1D2O59K5uPS9fXrTvOdSLcyyNn59Pkh8fBFmJ4NUpobdF5U4SruRSipQFuJ7l5uXlgZGPsVIdmn3CGqWK/x0RjRKmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023820; c=relaxed/simple;
	bh=6+wTgznk/MwMz/b5fD8GeYwMnBREWk3561CMnyOnjRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo/55U4O8ap+regVlmCkp3odnP9ZKZFmbS4zU0m2cPotOwX95vOoTCTw/ndiGpsnfNn3oajw2dg/03yV8X+mpRYA7dT3FrfLyyH1U0AKCc99N6+XTAi6x0dsfk/vXLCzFfn9vT55DgoF8gnlW6WFKuWSUZpdQvF4zYhV05Zv/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLsQbKGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D0BC433F1;
	Tue, 23 Jan 2024 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706023819;
	bh=6+wTgznk/MwMz/b5fD8GeYwMnBREWk3561CMnyOnjRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLsQbKGWcAwZU9kzUaLTS1t7grzNNEPsRq6YHqwSZeG2CHfOokWvmrVXvHbwYkwAA
	 y/vsdU71hoVeyQRG5O5kx2cf5KiRGqbpdwIit9iJcnR6Hst8IDvaEa6lRhHxOQYLXq
	 e+INbUJaHIHvoRU1UFAK0xqE47WUbOfXCO9hggtUYyD1N1VbBEep7YozmfIClvefrH
	 a8zeZ+WQ7KwDb3M5CcspTtcu8TKo2OS3UmPgkppByNWjdhoJg3RpSvoAGKZft8Zsu3
	 AhygbKKy/CWcU/fcsQRy+QKKMyLCKMzGwrIffH6NcDB5j9q34dHDnBpGk6kMgU5KGb
	 B80xbLEe30MHA==
Date: Tue, 23 Jan 2024 07:30:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Matthias May <matthias.may@westermo.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240123073018.0e6c6a13@kernel.org>
In-Reply-To: <87bk9cnp73.fsf@nvidia.com>
References: <20240122091612.3f1a3e3d@kernel.org>
	<87fryonx35.fsf@nvidia.com>
	<83ff5327-c76a-4b78-ad4b-d34dae477d61@westermo.com>
	<87bk9cnp73.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 14:38:24 +0100 Petr Machata wrote:
> Matthias May <matthias.may@westermo.com> writes:
>=20
> > Also there seems to be something wrong with ending, see
> > https://netdev-2.bots.linux.dev/vmksft-net/results/433200/81-l2-tos-ttl=
-inherit-sh
> > The test outputs the results in a table with box drawing characters (=
=E2=94=8C=E2=94=80=E2=94=AC=E2=94=90=E2=94=9C=E2=94=80=E2=94=BC=E2=94=A4=E2=
=94=94=E2=94=80=E2=94=B4=E2=94=98) =20
>=20
> It looks like whatever is serving the output should use MIME of
> "text/plain;charset=3DUTF-8" instead of just "text/plain".

=F0=9F=98=AE=EF=B8=8F interesting. The table characters are not part of ASC=
II, right?=20
So it must be using some extended charset. Firefox hid the option=20
to tweak encoding tho so IDK what it actually uses :S

