Return-Path: <netdev+bounces-223323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE3B58B60
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755F91B27BE5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597522127D;
	Tue, 16 Sep 2025 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efDleR18"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66ACA6B;
	Tue, 16 Sep 2025 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986996; cv=none; b=aKRsKmUCfPHVLpqDoKhuHZfLQroeMarYMyr9MlQNu/crtrl6F6ovSSJw7UCzZxnAkNYiGDHasnGEnD7Bw1XsHWhbJxsqArKZ+Du0+RcBFXc7wputCa+eGnx4OjkZssPG+z9pk5EMntc/BaU8jD6YnFMwTPVklRJESF0/A/TtVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986996; c=relaxed/simple;
	bh=rGF9yBokwARP5IBwNwGP3vWFFb3W8fmlnGJn0AuxBqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaOlwn9E77zjUBv9QcA+jqIwix7IEPTPKPxU7lxWInB3bJCDIayJxgS3qB+2akM5oYveAhsAIYDjTiaR6u7EhUh/CtNSzMnAvosegCcZzCMU9Aaar2QC/7TTpP1Iz36OG4loIs5WhYBMmdJArz4bSkAtJl9TI/ATac2MGlE2o60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efDleR18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B423BC4CEF1;
	Tue, 16 Sep 2025 01:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986994;
	bh=rGF9yBokwARP5IBwNwGP3vWFFb3W8fmlnGJn0AuxBqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efDleR18yrK64kISRPQQgqhRMynbLbIII7j2IrQs1kT+cF+FHqnWJqcfRoQ03eA6y
	 Sxs+O0DCeYfZ3QnwnpYCL6/hCUyCAhL8GD1wmlxNXbsxrIqUu/8JZqZHIL+xp1coo8
	 HsWUNVBiqu1ULbwGF31amK5ZMWSHlBkMbdmeka5tmEFGGOFjRDckhGPTJ5ju+Kewmw
	 Wb+dlJBoA6zDpBGYYplMCEVcIURgzU8MAF9JPczLaUYUCkcZTE+hNIE6tHtULc5xnc
	 JYFmCb9MlbikUFVRl8BNK3WECQ1ons1GCZKadCD3fBdKCtwF98o7BCrvZfRqEFYSa2
	 4epICkkiGuFJA==
Date: Mon, 15 Sep 2025 18:43:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/11] tools: ynl-gen: rename TypeArrayNest
 to TypeIndexedArray
Message-ID: <20250915184312.6a216d82@kernel.org>
In-Reply-To: <20250915144301.725949-8-ast@fiberby.net>
References: <20250915144301.725949-1-ast@fiberby.net>
	<20250915144301.725949-8-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 14:42:52 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Since TypeArrayNest can now be used with many other sub-types
> than nest, then rename it to TypeIndexedArray, to reduce
> confusion.
>=20
> This patch continues the rename, that was started in commit
> aa6485d813ad ("ynl: rename array-nest to indexed-array"),
> when the YNL type was renamed.
>=20
> In order to get rid of all references to the old naming,
> within ynl, then renaming some variables in _multi_parse().
>=20
> This is a trivial patch with no behavioural changes intended.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

