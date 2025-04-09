Return-Path: <netdev+bounces-180957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC96A833EA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCDA7A99CF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30E214201;
	Wed,  9 Apr 2025 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8LhXGVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B621E5713
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236402; cv=none; b=LYlqVrQwGgh7l3mnL6FgNZan1IPXgHXj7ks2bFeVq/1kIsgCVwawdp3tDtlDhh/VBQxR8p0wA8NmKOKgAgUti0303oRCGsy/+XvRachhQMWfRjdyUnqBcRMqRrqpi4O+msszbI/2YwNDHPRsU2NSw7NOF1lkRBnCLilv/Nt4Ntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236402; c=relaxed/simple;
	bh=tjTLNSTCp3maD979cYWZBH6QdBvoEM2OgvE3a03Ox28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfLMwsFWlGzpYFrlbcMmeYwXn9SgwNBXkekGeO3ZxkYPilvsYv6UBxWPDOyXCishLPZsNI+wnzVrijsJLEZ1+JTfZQMbTx8QVq5pv58JWl1xfuvISQ2N2a1kNe/fmjNogdiAIDBemnvz/EDv2PkoAbYe/jfnveQ7N0/ceqew7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8LhXGVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EA9C4CEE2;
	Wed,  9 Apr 2025 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744236400;
	bh=tjTLNSTCp3maD979cYWZBH6QdBvoEM2OgvE3a03Ox28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8LhXGVoOb8Ymbmdlx7nKtgLri7C0nxl8H88oowbjUNHP4YNcmQjTJ4tlLpev0HUx
	 reDjj6WLh8px+dr169jGVzLFmNtjFrQsB1zxIhj/KsQ4V+F0ZpenfcAhUc5dnVSRSa
	 ozyeAwjWOu54LrtpP4GFyVJ1sK2+wKWvr7TUtKi0UCPA8IHqVrj4/2PXpVTaUYbPZ/
	 Gd+YN3hdNoWhKIJEqaqmY1ptaO9kj1OL7+QrvxqUOkHcv12Fp5QAlymiil7Ipi9+y3
	 vmZYE/GNdCcr9+Osqe4VDbeG9cpZwl5JsvioUBlRSbi4JA/HO40ifhOAW2CbgRSTGJ
	 RdvOROSKhRv8g==
Date: Wed, 9 Apr 2025 15:06:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: net-shapers plan
Message-ID: <20250409150639.30a4c041@kernel.org>
In-Reply-To: <1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
	<20250328051350.5055efe9@kernel.org>
	<a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
	<20250401075045.1fa012f5@kernel.org>
	<1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 17:43:19 +0300 Carolina Jubran wrote:
> >> I don't believe there's a specific real-world scenario. It's really
> >> about maximizing flexibility. Essentially, if a user sets things up in=
 a
> >> less-than-optimal way, the hardware can ensure that traffic is
> >> classified and managed properly. =20
> >=20
> > I see. If you could turn it off and leave it out, at least until clear
> > user appears that'd be great. Reclassifying packets on Tx slightly goes
> > against the netdev recommendation to limit any packet parsing and
> > interpretation on Tx. =20
>=20
> The hardware enforces a match between the packet=E2=80=99s priority and t=
he=20
> scheduling queue=E2=80=99s configured priority. If they match, the packet=
 is=20
> transmitted without further processing. If not, the hardware moves the=20
> Tx queue to the right scheduling queue to ensure proper traffic class=20
> separation.
> This check is always active and cannot currently be disabled. Even when
> the queue is configured with the correct priority, the hardware still=20
> verifies the match before sending.

It needs to work as intended :( so you probably need to enforce
the correct mapping in the FW or the driver.

