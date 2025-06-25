Return-Path: <netdev+bounces-201312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977AFAE8F4B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB365A8550
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20625C711;
	Wed, 25 Jun 2025 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngzoEYHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D11E9B29
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750882624; cv=none; b=Dce6RZWioTKzXlyhgad+pZZwbioWo+MBO2N90nvGEoLdgUS3I5a6ArROBFXQ0hqZ0d0+00zuD8QEnns2Bd/gnbDrk1qxR++SxEWRvzplEN+CkfcjCBNCVY8xyRETjYDTCchDonebbKbf98EnkzSa14zktaHGje9LNjgSH3ETZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750882624; c=relaxed/simple;
	bh=RfMeaqk7yZ2D3PEPUy1Dsq7HxLJefC1s67/gSAXdGIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2EI79vuacYGaYGENnmb2BAIYfb7MHGSRSj9hdJXZGDna0fsroYUBMHvb8RZqKmTaBgyAkb9vmHKTcNfjciYQzRyvsmekHxOdp8Ty3RShD3qm3v4sLEU2JTql3numfcH1HIHgfLjPFJ+rreb0lcpzqtUY3fKLbiNJ7C0iaJ3JH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngzoEYHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3E0C4CEEA;
	Wed, 25 Jun 2025 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750882623;
	bh=RfMeaqk7yZ2D3PEPUy1Dsq7HxLJefC1s67/gSAXdGIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngzoEYHl0rU9SI64yWHJv6VXSQjCol8LyaAmPL6q7LdJQYk1jQZzYb/R2CW26yyyV
	 8zzyFMKy8tgJ5IdhP895YNXzIbYVFwWQRzjllWsGS9AwJfTbFhJUKyur4XdLyffA+W
	 k/rivpPay25fxb0R/no+o1uzP/kItXTiR5BFcKn6q47sXrLtruNj08BRjaQInUj3Lu
	 t7Q2Oq8+dDO0WAa3E6IJv7VH2uupQa/WNYkDN7NU5ezsaSCq7KPr3CRIg8TNxWet4R
	 km73yJrOm+iX8+hmF1A2aAXl/8en4k6QlkRxc15f7rdXJSa+/kZtdcLwa4j0ejgLtj
	 UOm5wfrkDm27A==
Date: Wed, 25 Jun 2025 13:17:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 0/9] net: ethtool: add dedicated RXFH driver
 callbacks
Message-ID: <20250625131702.173bd5ee@kernel.org>
In-Reply-To: <db9f1187-a994-49e8-a05a-58322a317102@nvidia.com>
References: <20250611145949.2674086-1-kuba@kernel.org>
	<db9f1187-a994-49e8-a05a-58322a317102@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jun 2025 09:44:04 +0300 Gal Pressman wrote:
> On 11/06/2025 17:59, Jakub Kicinski wrote:
> > The future of n-tuple filters is uncertain within netlink. =20
>=20
> What does that mean exactly?

Just that I don't have a clear idea of where it should go.
In this series I was refactoring rxnfc code - one could argue
I should also add dedicated callbacks for n-tuple ioctls
which are also muxed into the rxnfc driver op. But at some
point some people were pushing for n-tuple filters to be
deprecated in favor of cls_flower. Also Jamal's P4-ish
proposal could become n-tuple-next-gen. Or we could lift
existing ntuple filters into netlink.. =F0=9F=A4=B7=EF=B8=8F=20

IDK where we are on that, so I'm not refactoring the ntuple callbacks.


