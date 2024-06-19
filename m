Return-Path: <netdev+bounces-105081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94C990F9D0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820C91C2165E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82015B112;
	Wed, 19 Jun 2024 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxPv9RjD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BFF9E8;
	Wed, 19 Jun 2024 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718840286; cv=none; b=YYzo1N6lZ2AXbMfjzM2hkHaNUAK7MHLgxIekJaifEvobIXtaUNl2fG1eC2T9QI9BTgIJj+QLkHLQ8k+yftxzR3oaZ1HAuTLS8tp/HgsuO4j7sCQIiYHzleHnDfiMrVLZMXHl44YOqNa7vMtgLoTW2jNrHvhkSQUE5uETMS5idQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718840286; c=relaxed/simple;
	bh=pMFC1L80r+HKtEqEtcqW/lrqNA7cATLlLk4yYdkyGaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+vhiITl7vchbXsiE+klw89xL/fN5bcaC0Ps7/HyY5KsGvTMpn2GNLbaJVX/2kAXhvFXa7iyBRHiLkFWCZsuJmONMyA8TViGfvWxiQXwEkfvV4MPtajnBju+3/d9zWCu5Ky0oSoE4pBxU6E85hsrl7vUUbmd78aYdfTKHF/YSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxPv9RjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60EFC2BBFC;
	Wed, 19 Jun 2024 23:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718840285;
	bh=pMFC1L80r+HKtEqEtcqW/lrqNA7cATLlLk4yYdkyGaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sxPv9RjDTXneMVpxOVzgyndQCUrZbrE0mUWHgVS05kq5SGHKyYE7kkCRblm3q6wTw
	 W3Ou1G2+P4gjCb29VZEJLppiXrNy2cwXXsRMrj74Z5MMn/Dd2sfHOVg0HUrtqKUbaK
	 ZyEeGDSBCu6/WLOaeJjMoDvo3Mlp9dfiQgub85Pus5uiBjyMSL0vqGF6Cnm/jL/4sp
	 VXuoHXrPkMjkBsz0t6mzkkPaX9yQ5hT497Y58WnxFP2apxVgYw1Pyw06qx1HjGjD8C
	 TDpLUZ41JKmEnYw4yqiEfoBofShn0HcZnark8Z5qig2hf7jhCaiNFvZy4Dj4W7exxE
	 aqqE1C0e66xNQ==
Date: Wed, 19 Jun 2024 16:38:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: Conor Dooley <conor@kernel.org>, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240619163803.6ba73ec5@kernel.org>
In-Reply-To: <20240619-plow-audacity-8ee9d98a005e@spud>
References: <20240619150359.311459-1-kamilh@axis.com>
	<20240619150359.311459-4-kamilh@axis.com>
	<20240619-plow-audacity-8ee9d98a005e@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jun 2024 18:36:16 +0100 Conor Dooley wrote:
> > Signed-off-by: Kamil Hor=C3=A1k - 2N <kamilh@axis.com> =20
>=20
> Please fix your SoB and from addresses via your gitconfig as I told you
> to in response to the off-list mail you sent me. You also dropped my Ack
> without an explanation, why?

+1, possibly repeating what Conor already said but the common
format if 2N is your employer or sponsor of the work would be:

  Signed-off-by: Kamil Hor=C3=A1k (2N) <kamilh@axis.com> =20
--=20
pw-bot: cr

