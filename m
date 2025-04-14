Return-Path: <netdev+bounces-182353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E61AA8888C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0857A18CD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3A27A93E;
	Mon, 14 Apr 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/RoK1KO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9D25E813
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648022; cv=none; b=nweK8TfYyLRBDN1IIMT6dRzzFlQECaBcBAl+X65jYMdsUkLhQdpfXaJcdF59ONV4/c38whR306cuYWPs5rAFO2bVu55yU5wu9CbxQCP8kirRu8kaDYDLxoes/2a/iDEsqgdNhkYhImsTeuE4S1Qwet79mYFo+Ofjg0Ry4mK4jFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648022; c=relaxed/simple;
	bh=ZaYKAjJdQmxjzYrffS9KwgAW2DzLB47X+LtCrL0RnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mffduaj/nqXLbut288eTQQ+UlQzwQSZApk6Z0oILeY1dPGfKTJFUbpMIoBUJ2weOQOrePM6BlfMXnkQGzWB50Urk0zvCTHLFE8PYwrJ5B2+YDdMAaWjCaN2rcHQmdYxdcKt0IUaimwScdSkS98350T6iRQQVnVEGofgBPIuOeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/RoK1KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76FBC4CEEA;
	Mon, 14 Apr 2025 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744648021;
	bh=ZaYKAjJdQmxjzYrffS9KwgAW2DzLB47X+LtCrL0RnQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f/RoK1KOJvBcXG92R8TtsudI7iiOZ4oYxt79b04VhSCdMLhRWUARRyXfkAyLd+U8V
	 k48U9o0mLe7rnSRw73Q7c0K17KC+19iAIRM8gZdkhrchYaHAb6xvnhCgVx4RzGQkqW
	 /QXLCHOq7bGKzSdCEiIjhEaJBxTHu1Wpev4LlRnm3aDBJWv6C4knjDYmgJWwm2YseC
	 aIGcZqDK+TuPJ0xxOcURIcESsh83hgpFBZcVqRZQSQqaG1I9KgaGx5KGmgtgJJuucK
	 lAXeV3YGguBRbIugL7rHuqqDt8YdKjQEEP74YwWG9yLIwF5PbZrZXc4DmNe0v+td+W
	 1cDu9dlxzhrFw==
Date: Mon, 14 Apr 2025 09:27:00 -0700
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
Message-ID: <20250414092700.5965984a@kernel.org>
In-Reply-To: <9768e1e0-3a76-47af-b0f5-17793721bb0a@nvidia.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
	<20250328051350.5055efe9@kernel.org>
	<a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
	<20250401075045.1fa012f5@kernel.org>
	<1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
	<20250409150639.30a4c041@kernel.org>
	<2f747aac-767c-4631-b1db-436b11b83015@nvidia.com>
	<20250410161611.5321eb9f@kernel.org>
	<9768e1e0-3a76-47af-b0f5-17793721bb0a@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 11:27:00 +0300 Carolina Jubran wrote:
> > I hope you understand my concern, tho. Since you're providing the first
> > implementation, if the users can grow dependent on such behavior we'd
> > be in no position to explain later that it's just a quirk of mlx5 and
> > not how the API is intended to operate. =20
>=20
> Thanks for bringing this up. I want to make it clear that traffic=20
> classes must be properly matched to queues. We don=E2=80=99t rely on the=
=20
> hardware fallback behavior in mlx5. If the driver or firmware isn=E2=80=
=99t=20
> configured correctly, traffic class bandwidth control won=E2=80=99t work =
as=20
> expected =E2=80=94 the user will suffer from constant switching of the TX=
 queue=20
> between scheduling queues and head-of-line blocking. As a result, users=20
> shouldn=E2=80=99t expect reliable performance or correct bandwidth alloca=
tion.
> We don=E2=80=99t encourage configuring this without proper TX queue mappi=
ng, so=20
> users won=E2=80=99t grow dependent on behavior that only happens to work =
without it.
> We tried to highlight this in the plan section discussing queue=20
> selection and head-of-line blocking: To make traffic class shaping work,=
=20
> we must keep traffic classes separate for each transmit queue.

Right, my concern is more that there is no requirement for explicit
configuration of the queues, as long as traffic arrives silo'ed WRT
DSCP markings. As long as a VF sorts the traffic it does not have
to explicitly say (or even know) that queue A will land in TC N.

BTW the classification is before all rewrites? IOW flower or any other
forwarding rules cannot affect scheduling?

