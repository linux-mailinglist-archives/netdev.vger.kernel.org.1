Return-Path: <netdev+bounces-242585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B37C9259D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC40E3A8892
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA87302CA3;
	Fri, 28 Nov 2025 14:43:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C7258ED4
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341017; cv=none; b=VHurg8kl4VkXKZDa84oTAAjM4rScgWbzZviwGtUR5IBcdlfqrfHup3TdZ8IKVWwt1W8GpC2r04iaC5R527CBfWH6zCeoHEFRZuAyvz6orE8NDUnroF3StR9PJxoW9X/KI9kF1RGidHBWFDC3TscWLxvrSQnah+0QRpELdphKonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341017; c=relaxed/simple;
	bh=3HGQZF98qKlNBGJ2wumMCwOcckQnmudBq1/5AiF5HKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhnEzmQHOtbw1gj1oq7/EyS4UIGV0h9r7YuJNna4aWH+WynYnhCohh0M83BnL52l1k1Q5cloM5gOzGKMJ+qNb4bGajSowMyWMi8yjDFBuPybbGpg9of/2gVUbBPirv9DpNIxVeWEW6awNzQrVXzoZrlTtIbTSIu5aQgddN9Q7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOzgx-0007ON-B3; Fri, 28 Nov 2025 15:43:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOzgv-002yGK-2q;
	Fri, 28 Nov 2025 15:43:21 +0100
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:5024:fae3:d3e7:bd69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7D0654AA535;
	Fri, 28 Nov 2025 14:43:21 +0000 (UTC)
Date: Fri, 28 Nov 2025 15:43:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [can-next] can: Kconfig: select CAN driver infrastructure by
 default
Message-ID: <20251128-terrestrial-gainful-goose-0723b2-mkl@pengutronix.de>
References: <20251128100803.65707-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251128100803.65707-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 28.11.2025 11:08:03, Oliver Hartkopp wrote:
> The CAN bus support enabled with CONFIG_CAN provides a socket-based
> access to CAN interfaces. With the introduction of the latest CAN protocol
> CAN XL additional configuration status information needs to be exposed to
> the network layer than formerly provided by standard Linux network driver=
s.
>
> This requires the CAN driver infrastructure to be selected by default.
> As the CAN network layer can only operate on CAN interfaces anyway all
> distributions and common default configs enable at least one CAN driver.
>
> So selecting CONFIG_CAN_DEV when CONFIG_CAN is selected by the user has
> no effect on established configurations but solves potential build issues
> when CONFIG_CAN[_XXX]=3Dy is set together with CANFIG_CAN_DEV=3Dm
>
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> Reported-by: Vincent Mailhol <mailhol@kernel.org>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

I think we take this, at least for now. But I'll remove my Suggested-by,
which was a leftover from v3.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

