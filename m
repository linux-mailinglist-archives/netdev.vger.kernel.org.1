Return-Path: <netdev+bounces-18814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CC758B94
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832F8281865
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D617C4;
	Wed, 19 Jul 2023 02:54:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0178D1FAF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D3C433C8;
	Wed, 19 Jul 2023 02:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689735255;
	bh=wlZfctky3f4PK8EC1uB7joPxedy1epUHYSMhC4EUhUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZf6/6a76OyeGixaJOFwU+ORSziU9wVBHSN+Z2MLWUH9dZydOURdxlBEtBRxTZsck
	 C2oiq+IKiAQzUMQP0trAVCPLpjPeZIbhHWmKUigqARKPXIJfxLHlRWqT8w51laFm3u
	 P7PoKoOik5KdhokVOx6gWXVTHiapOv7O+yMZpspgl8Vrh3xtK3jccVzMj9OMEJuVxL
	 BNUASAAkUpkrv7RvH7/E6YsO2ci1YsWXYvcXLuv45UaF7ZXx8gE8uYPEIP8vuuaFyX
	 z4bDa+KPriS2ThXw44nJdQoSdZOUypyAKQ2Bl4+kajv1U8qJAu/egr1yD1FqKPzGIw
	 jd0y3w/oHhOeg==
Date: Tue, 18 Jul 2023 19:54:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org, mchan@broadcom.com,
 netdev@vger.kernel.org, pabeni@redhat.com, prashant@broadcom.com,
 siva.kallam@broadcom.com
Subject: Re: [PATCH] tg3: fix array subscript out of bounds compilation
 error
Message-ID: <20230718195414.4c6f359f@kernel.org>
In-Reply-To: <c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
References: <20230717143443.163732-1-carlos.bilbao@amd.com>
	<20230717192403.96187-1-kuniyu@amazon.com>
	<c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jul 2023 10:52:39 -0500 Carlos Bilbao wrote:
> >> Fix encountered compilation error in tg3.c where an array subscript wa=
s =20
> >=20
> > What is the error ? =20
>=20
> drivers/net/ethernet/broadcom/tg3.c: In function =E2=80=98tg3_init_one=E2=
=80=99:

What compiler are you using? Any extra flags?

I remember seeing this warning too, but I can't repro it now (gcc 13.1;
clang 16).

> >> above the array bounds of 'struct tg3_napi[5]'. Add an additional chec=
k in
> >> the for loop to ensure that it does not exceed the bounds of
> >> 'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).
> >>
> >> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>

We need a sign-off tag
--=20
pw-bot: cr

