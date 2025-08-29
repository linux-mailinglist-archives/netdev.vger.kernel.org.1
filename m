Return-Path: <netdev+bounces-218303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F224CB3BDE0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3D47BFB31
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE519F115;
	Fri, 29 Aug 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hpcmvuu4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333492D661B;
	Fri, 29 Aug 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478056; cv=none; b=q9rIGUHwpu4YJdS/X6ytQfYtQU9s0Q63ojTiNBLGAprNbjhJY5OnSZvGCcOCe+fDqNf5uD1dV0jJ2jCEsWYVPVEQiic6i1Nf7FkM/HFz/cghMTjSC9QKG4Tk0b01sS5Awb134OzY3+9cf3+PoYcVspBKVpkTrABcKx5shVMJbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478056; c=relaxed/simple;
	bh=oQLywLqP0UapR1oS6W3YR7d/SqTXRWbLgl+QVBrXYGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9KeQh5Pq1+4FMAnEAUye0jeQRGQAvOQ5L1cVO+dP+tbxpbvu4/4IriDbdDt5c7HxO/k/bD0r1g8VhOzeCB9ZG/OLC1t1ZtV2yMdQFZyDNV4I6SUCf2RALIKKU/4oQx6rql+1hnxhjL+23ZuXT20EILvHwZFn61FzQD8WEgmdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hpcmvuu4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 624B54E40C4B;
	Fri, 29 Aug 2025 14:34:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22B15605F1;
	Fri, 29 Aug 2025 14:34:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DF031C22D73B;
	Fri, 29 Aug 2025 16:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756478047; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oQLywLqP0UapR1oS6W3YR7d/SqTXRWbLgl+QVBrXYGs=;
	b=hpcmvuu4bel54RwVqlbPy7qksYuceljetA6QVSxVgvoci1uD5IX32inD2Iikk7b01/wphn
	wPFFxj2eYTr8vL7QPVHf0P4a9/iOy9xfIwLWE8YloyMZtj2KwfAvwwsxrfBtN2Hi2yCd6d
	/DljhhurDCb+oOrp1j472pehDfaEem/4iYLWLSl2tfAeBeDvqm5whxHeJ+WPH+rJpaPn2z
	JJozCDLjUxAIOJ71SLDRchSG0hNRstkIvs4mEU5Ywr184Zjqp6eJcDqzGkQyIMe3l/EBid
	kN758Oh3Gvh72yZbCWsPuqONz58z/DMriowxI7+jHzDrIY7O5LwuRRaTLP/xJA==
Date: Fri, 29 Aug 2025 16:33:41 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>,
 <Parthiban.Veerasooran@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/2] net: phy: micrel: Introduce function
 __lan8814_ptp_probe_once
Message-ID: <20250829163341.17712e59@kmaincent-XPS-13-7390>
In-Reply-To: <20250829134836.1024588-2-horatiu.vultur@microchip.com>
References: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
	<20250829134836.1024588-2-horatiu.vultur@microchip.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 29 Aug 2025 15:48:35 +0200
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> Introduce the function __lan8814_ptp_probe_once as this function will be
> used also by lan8842 driver. This change doesn't have any functional
> changes.

It would have been nice to add the fact that the lan8842 has a different nu=
mber
GPIO in the commit message. It would have explained more the why.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

