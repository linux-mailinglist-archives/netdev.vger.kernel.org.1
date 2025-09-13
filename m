Return-Path: <netdev+bounces-222751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484A7B55AAB
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064E7176D08
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945681BC3F;
	Sat, 13 Sep 2025 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIBMiDKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA511CA9;
	Sat, 13 Sep 2025 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723060; cv=none; b=raX7dhXPYWZyR7k6jpG9I2xyUY3sbEneoENJJxx8m3drOJMGhT/lkT64qapv6N44vHb6ZBixdNHwz9O1dYTCZXCIz9EYQ5TLDmBW8hEHNJFt2jVj/OlEWd88FZohAfS5uoAI+LUAp/nMRZ35daikdrQveSCFk4hKFzVkS/eGpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723060; c=relaxed/simple;
	bh=sxUedUP+MYOFlJfnA//ovQa/iV1ta0xI8YrzfhybySs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oE14ohE39iZNArBqSa5Ra1wiRBuK9H6WAPU5+JLKMhP/usl5x6Weyjz6+99wDYLkHDx7eGoxljB8EzPmBIYt99p40aVVIvGeQY5j+mq/j3FQpDAHE4sDWrmTYAfops99SayVav6vMiYzjzVFK6/fuqNBoI6khzkbkGvwiTFSkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIBMiDKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B0CC4CEF1;
	Sat, 13 Sep 2025 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723060;
	bh=sxUedUP+MYOFlJfnA//ovQa/iV1ta0xI8YrzfhybySs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RIBMiDKHAVVUuJHNTBDmqerPnclOmfi7GuLsEP09bz8J10RgAeUPNhjQslosxXHAu
	 199aUWHzOW9CBiNw4Xy+gTZSpbgD2fVKfFRmvQQYvgNuUUEWiv1z4tpgL4JQ5bUYjG
	 hQMqcSQ79TNXWbnmCDUmj6nfQH4JtSJ7NN5dfbnZNPTO+4jFgiSq0GRnMQYsSxUZxO
	 bTOy+sMN1I+AHi1EzZOvMkDlMWurdJmFpyiq7gFXc3wOKdC325+Cii6nu1VPzVKPF6
	 vi25oDG4KHp/diCBL7WtZ/vt1cegp+Aw0IvPPfA16OGBS058Uw0U87DGEhshW4HNCg
	 cm4xItpq1JgZg==
Date: Fri, 12 Sep 2025 17:24:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/13] tools: ynl-gen: deduplicate
 fixed_header handling
Message-ID: <20250912172418.1271771d@kernel.org>
In-Reply-To: <20250911200508.79341-7-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-7-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 20:04:59 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Fixed headers are handled nearly identical in print_dump(),
> print_req() and put_req_nested(), generalize them and use a
> common function to generate them.
>=20
> This only causes cosmetic changes to tc_netem_attrs_put() in
> tc-user.c.
>=20
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 39 ++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 19 deletions(-)

This only makes the code longer and harder to follow.

