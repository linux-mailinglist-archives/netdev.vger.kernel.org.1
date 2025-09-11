Return-Path: <netdev+bounces-221902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BEB524F9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382527B8F55
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 00:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B1155A4E;
	Thu, 11 Sep 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIhN/Jjk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996D184;
	Thu, 11 Sep 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757550436; cv=none; b=csElXkn/JI7rlBeuNDwEKwFf0woE8ikYvA6fRQOx9EfIx4rGxmrgbVWZlOANxPPdvkMRcB5ktzLN8ZaC3Iw1Z10VPKhI1wYRs4Yeecz8bDBR86XfCRM4kvO6TjLj3LkGY9JUDMdwnZb+uO7on2fERpFYheTa6FgPkEkx7UrVGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757550436; c=relaxed/simple;
	bh=ekesoh0ujj8ocHBC1cUZS+xosIHxerCs0+Ur0dMvGi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FephN2I9hu9glLxOoeKuQcp+J8wZIEVyF39zuwx/UBcHmw1Rp6ggaEWZxuZuPB+nWoVVv42Af7z16zTBejcPkBomql0TozS5joahIv5gkY9piAgxhsEv7+DQmj7vERWVSCd4Lf6jYqTiAB7gJIPmZB6pVR3yCCPxOjTjyf9xBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIhN/Jjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90746C4CEEB;
	Thu, 11 Sep 2025 00:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757550436;
	bh=ekesoh0ujj8ocHBC1cUZS+xosIHxerCs0+Ur0dMvGi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YIhN/Jjk8lbtMZhvPs99IMb6DdxMzOmkgeqMoNjFFvsSopF4C03eCmdaNXFunkFvO
	 tJTq/3wP9RJO953v+ZcFNXousLQ89L9a9Fxk3q0QJ25jSpKj6Vew4cN7EguQCDPCH9
	 sHsefFAn5irX2yQFIuJaVaETLuvCq3YTu1MDf5cvsIBU4jpUjxbA1tZkhtQ6M/Bnix
	 vJMmJNlCa+W8d8TwNUWKgi9CfTtwsahcoRWE1QdLP5Qp6tEaHKpNR9ldc5NlidxcGY
	 +RTt664nXbt5PDp6riNGqdNGB1s4nrkEihivlt0a8pFnjERj0lV1yrsVN+yGtEYY5L
	 a0ezPeEfv34dg==
Date: Wed, 10 Sep 2025 17:27:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] tools: ynl-gen: define nlattr *array in
 a block scope
Message-ID: <20250910172714.25274ad0@kernel.org>
In-Reply-To: <3b52386e-6127-4bdc-b7db-e3c885b03f72@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-5-ast@fiberby.net>
	<20250905171809.694562c6@kernel.org>
	<4eda9c57-bde0-43c3-b8a0-3e45f2e672ac@fiberby.net>
	<20250906120754.7b90c718@kernel.org>
	<3b52386e-6127-4bdc-b7db-e3c885b03f72@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 00:01:48 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> I left this for you to submit, there is a trivial conflict with patch 8
> in my v2 posting.

Hah, no, please take this and submit as yours if you can. You can add
me as Suggested-by. I already dropped it form my tree.
Maintainers tend to throw random snippets of code at people, it's just
quicker than explaining but we have enough commits in our name..

