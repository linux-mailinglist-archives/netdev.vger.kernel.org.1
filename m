Return-Path: <netdev+bounces-207588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B5B07F51
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230E3A45EE3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7337C2900AA;
	Wed, 16 Jul 2025 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MihocQ5C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6028B3EF;
	Wed, 16 Jul 2025 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700169; cv=none; b=axCeR4Kzg3WB/w2QkjolqSiRVOghR1YMKPf2w/bmWGhPzVmPPybrVarQflQkzg0XBkNXntCGjP6Iadn6a44CrjUYkt75Brk5fh+cf2seABAOoKdX6YEZhNjQrsbDNNS+I4LCLxThgh6tEHxjeuzJ9QsCZjLUtdBe6/71rg11HZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700169; c=relaxed/simple;
	bh=ZvjiIuDfrlWWbykzDv6yMKlbKFJ9c3SfR0on8ygzWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kO1NMTtCu9yq9dzFXtgnkzb3mIJ3RANkw4KP6EN8kOQTbleXlhd7A0GAbwQ+aFxaXbgWy6SPFLr6SWV/52DACX4sUOJ4Df8EdMPtQUUXoDbn3FKEXRFOrhzRuvMjD1CA4c3zzaNm2xLGKq4ejREb19uIAIePb+dwlASuiRJeQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MihocQ5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FEAC4CEE7;
	Wed, 16 Jul 2025 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752700168;
	bh=ZvjiIuDfrlWWbykzDv6yMKlbKFJ9c3SfR0on8ygzWv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MihocQ5CfRgKpACI/aeFhkJ5efmhxN3ecKFo8AYnY89VPMXR1C4T9t3Q5aqmsISYQ
	 qCkS257leQLzb3LjhZJLla7Ra3zItwwNU0vjngd7HF8DOwzYXcApTXAtRKMdASzWXk
	 bsIuuYDUqO8H9+hXjPIpDIyxKpdq9ojwWIjBZpnPONeJ+NUMqJfY9apufkcTpVxGf+
	 mqxztjqJ45Cuf0YQFLrSYrn+NgT04N5m5cXOPE0zL4wk8Md5xd1+z++31VnqlA3wDv
	 MPZi8dXrwsIGfwlsTYa1mm6JKvAWH2KnMbiq1NDRbD5vdqWTAuBn4wx7y3ZTYAYN7r
	 p1LStuyyw3sgQ==
Date: Wed, 16 Jul 2025 14:09:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>,
 andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, robh
 <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, conor+dt
 <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, richardcochran
 <richardcochran@gmail.com>, s hauer <s.hauer@pengutronix.de>, m-karicheri2
 <m-karicheri2@ti.com>, glaroque <glaroque@baylibre.com>, afd <afd@ti.com>,
 saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, jacob
 e keller <jacob.e.keller@intel.com>, diogo ivo <diogo.ivo@siemens.com>,
 javier carrasco cruz <javier.carrasco.cruz@gmail.com>, horms
 <horms@kernel.org>, s-anna <s-anna@ti.com>, basharath
 <basharath@couthit.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, netdev <netdev@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, pratheesh <pratheesh@ti.com>, Prajith
 Jayarajan <prajith@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, praneeth
 <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, krishna
 <krishna@couthit.com>, pmohan <pmohan@couthit.com>, mohan
 <mohan@couthit.com>
Subject: Re: [PATCH net-next v10 04/11] net: ti: prueth: Adds link
 detection, RX and TX support.
Message-ID: <20250716140926.3aa10894@kernel.org>
In-Reply-To: <1616453705.30524.1752671471644.JavaMail.zimbra@couthit.local>
References: <20250702140633.1612269-1-parvathi@couthit.com>
	<20250702151756.1656470-5-parvathi@couthit.com>
	<20250708180107.7886ea41@kernel.org>
	<723330733.1712525.1752237188810.JavaMail.zimbra@couthit.local>
	<1616453705.30524.1752671471644.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2025 18:41:11 +0530 (IST) Parvathi Pudi wrote:
> >> Something needs to stop the queue, right? Otherwise the stack will
> >> send the frame right back to the driver.
> >=20
> > Yes, we will notify upper layer with =E2=80=9Cnetif_tx_stop_queue()=E2=
=80=9D when returning
> > =E2=80=9CNETDEV_TX_BUSY=E2=80=9D to not push again immediately.
>=20
> We reviewed the flow and found that the reason for NETDEV_TX_BUSY being
> notified to the upper layers is due lack of support for reliably detecting
> the TX completion event.
>=20
> In case of ICSSM PRU Ethernet, we do not have support for TX complete
> notification back to the driver from firmware and its like store and
> forget approach. So it will be tricky to enable back/resume the queue
> if we stop it when we see busy status.

IIUC this is all implemented in SW / FW. You either need to add=20
the notification or use a timer to unblock the queue.

