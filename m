Return-Path: <netdev+bounces-96949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E703A8C863C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885B61F22D47
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735DB42059;
	Fri, 17 May 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MkbccwGF"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FF41C87;
	Fri, 17 May 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948890; cv=none; b=JjusIyB/sROkCOmXbDwo5RLG73UU7NQUDzW967cNy1GNwlruTXZ8y/YqnvkqWB9+5ArhXhmN1D4ZPdMp3TKsEi2sow93Ifvv2f+ZQFGrlr0afeuX87UVM/ZU7oXEl+hucDBWq3Fi5Etssaj0aiDuBZaDCvfm4sNyAmYnAgHSDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948890; c=relaxed/simple;
	bh=atI66/2NNiLDrPCmOuGAYSfPDhUQh7ULKl9Vno6ma+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7tDxcvRRjH/UB0AXielLI3dWADo4gsBiqPV2MLyoHDodoidxaJe8fNGaWAjkxUTXyJBDvA2KOFxacbVOS09v7hUQZh5neSN2H//S+CHR9mDRV/AYX9ChrDQCC2kmrloSu4WP4QZQyddMIXFFGYhuafCIaYWHvgpUu1+eVYI0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MkbccwGF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D485240010;
	Fri, 17 May 2024 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715948884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atI66/2NNiLDrPCmOuGAYSfPDhUQh7ULKl9Vno6ma+I=;
	b=MkbccwGFxUuvnqwd6swuQOhF+Ap+COqF/49nwAiFuYgfPNSvi7eiiAehVAokiJdjXtgpyR
	xzTNIvg7kcNsisI8N4z8IC96bxCZ9MtkMIVikc6WePSvejiS0xVPMlCCWS8GToGcBbTsmO
	e2jdam97nDkVYDLaeZeM7dZi4kG2lk1aSZSt8A9Ot+gQtmnDeOItAMzmG/WfVFwfoBJjCH
	lJ3PTDnc3Euzso8i16v3Eb0/6ZzyVi9xY6KeHWcNEZQDxkRU3MwiApCMyOErzoCqa3ub3x
	Hrm8fOHKApM3ig9xPkXJTzDlS1cuGXndWVDeVGp6h6sb1lbc87wMZWJ1e1p54g==
Date: Fri, 17 May 2024 14:28:03 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH ethtool-next 0/2] Add support for Power over Ethernet
Message-ID: <20240517142803.6c28b699@kmaincent-XPS-13-7390>
In-Reply-To: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
References: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 23 Apr 2024 11:05:40 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> Expand the PSE support with Power over Ethernet (clause 33) alongside
> the already existing PoDL support.

Hello,

Any news on this patch series?
Would someone have the time to take a look at it?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

