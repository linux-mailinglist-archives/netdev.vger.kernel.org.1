Return-Path: <netdev+bounces-222855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E201B56AFC
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F173AF29E
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D4F246BC7;
	Sun, 14 Sep 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik3Dpj8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82DC145B27;
	Sun, 14 Sep 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873286; cv=none; b=QHNeEo5zgOrMboHBSChfAwnpP8q+Gtf9cU9w3X/M5dI5DANxowq8FlipN8OE+adt5AHlUoHK/s4kk3Pb0uBvZ6a1Ba0EFiKLX8BppnE5bUaKLjSelYEDUS+mN09a7sFy429QE7cZzi8TXKh4utT1PvepXpaGZJs1399SW4CmazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873286; c=relaxed/simple;
	bh=el/KQ0lECVo3QJ94IHZinOuUbMqgM/g9vD8XwAkXXlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6dvxAPSQFYUq2+K84nHPu/OVJfjP00OQNCmstP/G4PnCJUfiWNpbkgVO+uRSLIQkqoJtXA5QYTK5FkfCtL8trCo+IiRh+66KNHWtojeWf8w6hJmWSKgNQRqG2zNgPtYbU3I7mjd37qPgmpfx6sBYTxis0ERlaSe2FP4jExT7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik3Dpj8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDFCC4CEF0;
	Sun, 14 Sep 2025 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757873286;
	bh=el/KQ0lECVo3QJ94IHZinOuUbMqgM/g9vD8XwAkXXlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ik3Dpj8TnNvG4lZjjJoB8uO63i/mrd/TDqkKdomd0E3aDazTImpl4EvAARYHyk6/2
	 pANZZEPgeBBQ+rZO9O0l0B4BBaHIsmTKPjxRlwqh5owfuJkD60EayQF82QFnJ5dPFd
	 5EEaDyb59mY9RZ9VBLOZhTc9YIfvx3nkNJJu9lb0QqZHdQrYGftO5T4JnwhssT7TlD
	 FgMvkxEFDsjPhl2N6j+UzIQgkKYaxYgwH2OMBenKO/Rmbu2SV7CX9Sx/PqtNUDBhnU
	 9Jg3WN3FCFimDXoz9tHT7xZAGRWIYwFCyB1G5l+Two+SYGRdCBAEymt8elJ6/9s5Rr
	 FggK95FkThCAw==
Date: Sun, 14 Sep 2025 11:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 04/11] tools: ynl-gen: refactor local vars
 for .attr_put() callers
Message-ID: <20250914110804.3549eb9d@kernel.org>
In-Reply-To: <20250913235847.358851-5-ast@fiberby.net>
References: <20250913235847.358851-1-ast@fiberby.net>
	<20250913235847.358851-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Sep 2025 23:58:25 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Refactor the generation of local variables needed when building
> requests, by moving the logic into the Type classes, and use the
> same helper in all places where .attr_put() is called.
>=20
> If any attributes requests identical local_vars, then they will
> be deduplicated, attributes are assumed to only use their local
> variables transiently.

Nope, this is not good enough. I prefer the obvious hack than a one-off
member mixed into the object model.

