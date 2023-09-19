Return-Path: <netdev+bounces-35030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDC97A6807
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A701C20A50
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE61FA1;
	Tue, 19 Sep 2023 15:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059198475
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:27:25 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F12F93
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:27:19 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695137238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1Z6DN/Wm7Y++3x213tD97iZjY0CkY6NClOP4LoLQJs=;
	b=k1LgwO9MpPhqEG+v3K6lFUmx+dDBWSfwuDCUe412oIciuWd8WrhOao8JXDtRzO1I0Kl/fp
	jEmTMYpBXCtnEPduHsyQ7zJkniYG1cgGxsmCzJ9GmyI9kFBgbtwwW49O/vzGYAJYcf/BNj
	24mKu3W8Hlak+aPFeFu37qi0t3bOMIxsks7DrIM/i/4LMFnKS3JuXC9hcs5Ol3JLDWGDX0
	Ax7axH1HgursrLrwfd/P4++sQIWlZrK3FGPa+ANhoiB99gfYY5WAOCuLk6/rjreJVu6Zwe
	bnCENAKj8ikkS2aLQcAYuhKx3NHgpUN1xOqdfESw5ux9btkR5+UPLxLkX75yDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695137238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1Z6DN/Wm7Y++3x213tD97iZjY0CkY6NClOP4LoLQJs=;
	b=JurguHAxIRci4rvVzN1ukLI9gVeELT2iG1ZPRshLYPW1s+WARoOs3EWwHk9uKi4uRPznuk
	VLKoUXLPwn4wYAAQ==
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 3/9] net: dsa: hirschmann: Convert to platform
 remove callback returning void
In-Reply-To: <20230918191916.1299418-4-u.kleine-koenig@pengutronix.de>
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-4-u.kleine-koenig@pengutronix.de>
Date: Tue, 19 Sep 2023 17:27:15 +0200
Message-ID: <878r92chf0.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Sep 18 2023, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmUJvdMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtrkD/9mgNjZIN3mrM7wttES2IfDHgO/vkLB
cWC0L6i3QzWeQkIL2lzsCL3za7fGde8ZVGLrvfyvEbOcA+n8YedZqkTAvXEtHRtF
KbYVXRpERVeXsBNy+bXcwD74wfuwfuMLfw4AqCF5ZyuCiyG7knvqLoglsjJHZk+a
pNSqUT/ZgaeMJ7tzIiEXkZB6faJ6FG96LHH00sb9Qtgtk6ZIT/bmptJW0aUOjn+v
1DmKZjOpzCs3iV70Hu94Mtl8BNlltkCfUoXyb7BcAXMnPUkj4gSd6f7BF8K9176h
KJwixStHeQO6CTSU61JZIHKYzgptldQjb3Xx1Tsb6lapq9v/INC7NHXX1wnZv299
bapo4Vpv0W8MYhemaFxb13WeHa7jeZvx03nlyqJAhiwWgJIx6nu2LOrhUqW0xfvF
nlxGuoUYX91ypfKlo0312JaWjQ4P9JDtGmoHMzMpX+Xc2FIrio3PDpNqJZtOxFDJ
SWSirPkC62OvyTffjwBhvN6/8DdTM65KzJ7Lvt4gp2DZbFY7aSHIoifzazqvfG1c
4bL4fvZMXIoC4jq5xjARReebDnTS3B6+myHxrRSQu266oQCbWA64fB9rWwDbqI/H
f+6KMBha2IpCdRI9fyn9Lqj2IUSr+DoCd2knLXoO+Cwsgyr7/D5/QPbbbpTrJGgX
USCNLpVe254JxA==
=eGJ4
-----END PGP SIGNATURE-----
--=-=-=--

