Return-Path: <netdev+bounces-220510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5CB46767
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D699A4823B
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D777464;
	Sat,  6 Sep 2025 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h62Efr5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF904C97;
	Sat,  6 Sep 2025 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757117527; cv=none; b=a3IKQsOLTPUp/LGr6EnLGWPydx7RQzGz1S5pHFX+ijEummzJhmVSx74ETNML2i0UgSkLcSA4W4ZTC9aEoBTNE7SC8bUfMJy4Gf8NKr9LWiHea/6Gy7jkwr1/mmt9iTk8/BMHlr0eAFUT/XFMTjusPfuQk+H4whJfmoe+vr0FLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757117527; c=relaxed/simple;
	bh=FPIcx5ZD9itca0Z0lBkQaxYvEdw750jRqVZ4wjT495k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdndOnGRwoNSnMsnFDy5+VpaJXmAekwctlPD0yoIQb71PczD0e9qFTyU5ltPqgBxnislWwjbpVYWSc3jSBN6nxv71SKiUWLDhPETNw8YcRVunkJmjBW1sXVfT+K1nvFrbQd4gnMDWQyyxx4cWyqIHcNugoVAFaJQ3ptXVa/ARtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h62Efr5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1109C4CEF1;
	Sat,  6 Sep 2025 00:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757117526;
	bh=FPIcx5ZD9itca0Z0lBkQaxYvEdw750jRqVZ4wjT495k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h62Efr5qLZgARqjyjaFXl2uvoWkqdjnsZQ2lCHbkpg7YscQ91b7sSZ0Nma9RWLQ+8
	 +7IoCLnrUtJxdbbAGPIPvrrk9xPw7w73OUpUxZIaw0QnuQdXZy8YBGEMR0NSPv4c2h
	 RWU4XYyFdXCiudxShp4qneMrIdYsWfp6U7gEwwbJy2gycV2U9WpKdaRogO3QYfnYJd
	 eDzJfStQWOutWPwMB3xxjmXo4Xx+5sELLxjYWFxsFLuzU1N/A8NfQTRoryacWEzlL2
	 HcoryIlK+LDpNy2lcDPQTRTvxPraiGue+l+2kez9HC3yhAHLb/ODeyAQQEKNTkjTTs
	 YKemlqy5FEovQ==
Date: Fri, 5 Sep 2025 17:12:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/11] tools: ynl-gen: add sub-type check
Message-ID: <20250905171204.483b5f4f@kernel.org>
In-Reply-To: <20250904220156.1006541-3-ast@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Sep 2025 22:01:26 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Add a check to verify that the sub-type is "nest", and throw an
> exception if no policy could be generated, as a guard to prevent
> against generating a bad policy.
>=20
> This is a trivial patch with no behavioural changes intended.

I _think_ the expectation was that one of the other methods which
validate the types more thoroughly has to be called if this one is.
But either way:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

