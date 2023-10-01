Return-Path: <netdev+bounces-37290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E6F7B48C7
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6E26D281964
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A6EAC9;
	Sun,  1 Oct 2023 17:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36AD2FC
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 17:13:25 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575683;
	Sun,  1 Oct 2023 10:13:23 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 247CE60006;
	Sun,  1 Oct 2023 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696180400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqDlq23BdivJmb4Esbr99inDuNaw3gvSKLPwMkXV73I=;
	b=IrqthlLpqqDLnIbT9dzYKmTcnXLVXR/CwZW2pn8440viRostXbGF5WodVKlOwFQcarnL5k
	JdSxfd/XAMbpttOxh9/2tqEi6KtrLq6DGQpFykyJGMGhaBCz1nmiwRAElvE8jJx9U8Noht
	wyCoyKlCVP9uODP6RYOIdOVjl5tW7u2FzVdnLh50tb96IOXcEM4pDDl+JWpOhiYdYt3sOr
	x8CeS9N7+0mgVMywqPHbABoKWNGzaQRMdYdgGPMIeTsajRyQodcMMeecqFXhqwIQ3VbjtP
	5v3hFrDxHIuc7llT+Guz0FEeEcWf2dY+KD+sA7qpNJI1bPnBxE4QqzBoUA4n4w==
Date: Sun, 1 Oct 2023 19:13:16 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org,
 =?UTF-8?B?SsOpcsOpbWll?= Dautheribes <jeremie.dautheribes@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sylvain.girard@se.com,
 pascal.eberhard@se.com
Subject: Re: [PATCH net-next] can: sja1000: Fix comment
Message-ID: <20231001191316.466d0482@xps-13>
In-Reply-To: <20230928123556.GH24230@kernel.org>
References: <20230922155130.592187-1-miquel.raynal@bootlin.com>
	<20230928123556.GH24230@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

horms@kernel.org wrote on Thu, 28 Sep 2023 14:35:56 +0200:

> On Fri, Sep 22, 2023 at 05:51:30PM +0200, Miquel Raynal wrote:
> > There is likely a copy-paste error here, as the exact same comment
> > appears below in this function, one time calling set_reset_mode(), the
> > other set_normal_mode().
> >=20
> > Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller") =20
>=20
> I'm not sure this warrants a fixes tag, which implies backporting,
> but in any case the tag is correct.

My understanding is that "Fixes" does not imply backporting, whereas
"Cc: stable@vger.kernel.org" actually does. In practice, stable
maintainers are using magic scripts which, it's true, often select
patches which contain a Fixes tag, but that's more a consequence of
people not Cc'ing stable when it's relevant :)

> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> The above comment notwithstanding, this seems correct to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the review,
Miqu=C3=A8l

