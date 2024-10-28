Return-Path: <netdev+bounces-139610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D09B38B7
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4037287347
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3071DF278;
	Mon, 28 Oct 2024 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aCWAHIkV"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979E189B98;
	Mon, 28 Oct 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138742; cv=none; b=frJvnS0QWDnboZ3+xzfekzkCPSG3WkbpkYNt8NcErB4WhaW3UvL1Z6f1J/SMSEblRysoEvDbsCdq9bQJeFts+hherRYKZ37d6mZCq494MzsJw8JlfbKp3TTcuA4/2rTaTrRdyliONKYHogTxPiQzFu5pYp3O+E2iN2GGQ/Vn3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138742; c=relaxed/simple;
	bh=t/AkSjq3S9Zhaq9PHBnxKgvJFcfCiEQtgXiQdd4roo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A13WwvJv9vo9sRF6LQ47wF0fYJ/eEfuHGZwi++LFWhTELm/1Je/x5QbhviXGKuG5gbVBo2seRHYPrRyzc8+Ao6TOIQbCsq+ZaDGxqj3JTVXGg74MT+nb8+Say5I2pB0+z3ZcS41gEyh/1Btt/LpLaUq458qknzIpBm079PXtwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aCWAHIkV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F9F01C0003;
	Mon, 28 Oct 2024 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730138736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/AkSjq3S9Zhaq9PHBnxKgvJFcfCiEQtgXiQdd4roo4=;
	b=aCWAHIkVupaq3TQFbvSiGkBTxV20bTdhv/LvX7PiVJdH7zc3k617Dp5mj/fv8EUiy9UIvf
	7oRUJwTCoJCBU8s2ZvrFqYRTNlIu9meD9xkP25qspXj2b3k0YyTD7dZAtmPQmeh946jVKW
	X8ve44DHwDMKzyDLwm+iyYAfOzIxTVnoofCCEKyScJCHslqiBw6B1NJXGSb81VDY0CHjfv
	kQgbJdMPEQo2oidgtYg+axqgd1NG+Arj8zlD1EUie6jQzWh0NHEPNhFNDR5escHlxRw5UC
	3pvZeICXcIRrQZzMuBg40wtOuaSk6NFxYbFBoDaYFJ20nuFS6uEEVpddA50g5w==
Date: Mon, 28 Oct 2024 19:05:34 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v2] Documentation: networking: Add missing
 PHY_GET command in the message list
Message-ID: <20241028190534.429733f2@fedora.home>
In-Reply-To: <20241028132351.75922-1-kory.maincent@bootlin.com>
References: <20241028132351.75922-1-kory.maincent@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello K=C3=B6ry,

On Mon, 28 Oct 2024 14:23:51 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
> Add it to the ethool netlink documentation.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Thanks for spotting and fixing this.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

