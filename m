Return-Path: <netdev+bounces-197829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5BAD9FA4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807851894ADC
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCFA2DA767;
	Sat, 14 Jun 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp4GTHXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4EA1BD9C1
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749931640; cv=none; b=LLUvHbom9Pwa9MDRxSwQoBAh8c5nkF8yImaLwtiSgkce3SNSi5XkdQhqzccvbZMZSkj0QG/IopzQwXmNvJVXCqM7P3kZYg1Iq1g0VIwBOda/jR8XknCItNGf96xlBlg9EJhs0KcRme4eP9yjRBo2tB2ou+FygHon667P9NhKssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749931640; c=relaxed/simple;
	bh=VrTlknlqtPODRHZVYCwVAC+FY2zebRAMTKS2R8HmGLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfXEPFNucUln0iGvMNP9nEO46zmtDNcmilNXky2wJm8tA4xfo5Mwr9vmI7NZiTfPokwae8ytE9HXci0rOPheuffOyI0NtyUZ1V4R5LPt2wmtkYBSlljHaj0er78J52wiwAEaIBOwCbtNxNwWTBG85vRt0fG2VMrhn8peIfdkK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp4GTHXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBB8C4CEEB;
	Sat, 14 Jun 2025 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749931638;
	bh=VrTlknlqtPODRHZVYCwVAC+FY2zebRAMTKS2R8HmGLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dp4GTHXyVAj/ukZFQ7rxDxGlHbHsvyxk9rQwJdmeLYU2JFIccM75CIcb18AEHa5Bx
	 fWeAFcLwQ/BkQTDXHgVZfquMhHWO9lxFbNxsHEe08kADyrLUFeyP/fHOPbg/6S73tl
	 I6Hdh4fliyuFiPCfvNte2GoItEuriT6OhsLKz3Q6x0uQ9q/wMwUOnCxv1DwjG/br11
	 8O2KyE204ziHtmPlmWHq88bIGpVCtxp3/62nF+ToFOJ3zmoz8E+wdoattSYKeVhb4d
	 4tCTIaMws+YBkKV0aBs7x6nbamYRj8kUlK+HBeBFFBzcXQmjLwDGAzDzNLiAeJZs10
	 IYIb66hBkStOQ==
Date: Sat, 14 Jun 2025 13:07:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
 <ycheng@google.com>
Subject: Re: [PATCH net-next 1/3] tcp: remove obsolete and unused
 RFC3517/RFC6675 loss recovery code
Message-ID: <20250614130717.40a42cce@kernel.org>
In-Reply-To: <20250613230907.1702265-2-ncardwell.sw@gmail.com>
References: <20250613230907.1702265-1-ncardwell.sw@gmail.com>
	<20250613230907.1702265-2-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2025 19:09:04 -0400 Neal Cardwell wrote:
> RACK-TLP loss detection has been enabled as the default loss detection
> algorithm for Linux TCP since 2018, in:
>=20
>  commit b38a51fec1c1 ("tcp: disable RFC6675 loss detection")

Hi! There is a warning here:

net/ipv4/tcp_input.c:2959:6: warning: variable 'fast_rexmit' set but not us=
ed [-Wunused-but-set-variable]
 2959 |         int fast_rexmit =3D 0, flag =3D *ack_flag;
      |             ^

and another one in patch 2:

net/ipv4/tcp_input.c:3367:29: warning: variable =E2=80=98delta=E2=80=99 set=
 but not used [-Wunused-but-set-variable]
 3367 |                         int delta;
      |                             ^~~~~
--=20
pw-bot: cr

