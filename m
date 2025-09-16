Return-Path: <netdev+bounces-223320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3241B58B59
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31FF3B57D3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F4217716;
	Tue, 16 Sep 2025 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvbr8TxA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B8154425;
	Tue, 16 Sep 2025 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986933; cv=none; b=NDeZtIhXeyWq+CzCJ/59QzK55FpDUY8WTSdo69sDFNubPVxpOnE/jP06g4P0WjQV59xYF72Ryx1Jbgp12yh+5/mGgwPK+6KpQUmD5TPY1i7LDeps4nKJE7TGvwqafqU+gr4CQxYBth4f83/qp+kEkTbIJFFUIcfZme9J35E6Fr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986933; c=relaxed/simple;
	bh=cEbPcPh84M0mskAwQZCusts2IzzcqM/jBUtK/XGRNNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zo8j3dMDlTmqLhfBsAwxQSpEzcSz1JgjiukssJE5wwWHHXw6j/eR30d3PciAWb6/BZgvo9HAiVe5g5AiulHHSxpGgVTZnFQrNhcEtkeiNeIfJkAEWIOMSKcI9NHRG3ZLmZNN7ToDtCc4pVgV7l0FQzfXVS+x2bn8iYtNgEAWdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvbr8TxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04BAC4CEF1;
	Tue, 16 Sep 2025 01:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986933;
	bh=cEbPcPh84M0mskAwQZCusts2IzzcqM/jBUtK/XGRNNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hvbr8TxA+7xfE2rx271ZLwyVy9+IGciTMEcZ7EM2y5RNx3VKJSpP9IlvoFyJLlNk9
	 zIaz15Bn3SFA343yCVI/Z6bRYryXZ2F2NuypWVGVLqng/Nlbqyupa44DuxsxhlxPE2
	 3iAK5CIuQ3xRMG6WNkixbzVbGX7L4us91jiWugVCOjgd0lQ02TEMiKweimbfZ0LoXp
	 TEXcY9sTbVcRzlmz965sPWmbG8Lk60r/OA1sMVAkR10yqeem6sWHR6vrGHRjJowJxi
	 AZJGRsc1Yf6qw840vLJW6vV8LGot39KZqxshgiPHpDY0cGRjxJJ3Q5xB9wwUtJo/sv
	 h5GK+HHrmzyPg==
Date: Mon, 15 Sep 2025 18:42:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/11] tools: ynl-gen: refactor local vars
 for .attr_put() callers
Message-ID: <20250915184212.1dc0abf2@kernel.org>
In-Reply-To: <20250915144301.725949-5-ast@fiberby.net>
References: <20250915144301.725949-1-ast@fiberby.net>
	<20250915144301.725949-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 14:42:49 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Refactor the generation of local variables needed when building
> requests, by moving the logic from put_req_nested() into a new
> helper put_local_vars(), and use the helper before .attr_put() is
> called, thus generating the local variables assumed by .attr_put().
>=20
> Previously only put_req_nested() generated the variables assumed
> by .attr_put(),  print_req() only generated the count iterator `i`,
> and print_dump() neither generated `i` nor `array`.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

