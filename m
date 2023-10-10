Return-Path: <netdev+bounces-39469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876727BF638
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAF92819EA
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4BD2F2;
	Tue, 10 Oct 2023 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ivbCgZR6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C098A34
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:40:59 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A8DB0;
	Tue, 10 Oct 2023 01:40:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 566BA60015;
	Tue, 10 Oct 2023 08:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696927256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK4zIFPqfurxMkHf6VB6s+SlOkIyziORUxbFuzfwqTs=;
	b=ivbCgZR6obEsPfq2D5fylfPAo4F37C9TLOps9qaTjvpHeQZNGrpcx/HYSQiaFRa9xt82T1
	+fCve+epducw5Df/xmMDoytnpOsW1SyDtog5ZgQIE/y7mLjBtVN22QRwn0DtScTGHhdEV0
	kabf6eU7KDOEmVjBqMCmo0Mu0tTAZ0VKtb47JEGsBBmn4UV9ywQXjelp7hjKjTHVB5UJ9u
	6isfpc/N5uNsqwujTpLdia7vf7e//NQP1hFO/AQfcWmBt9Jcg/okkB7l4r2znCnMkIa0kH
	j16fMxKy7NrsUcLBSCk5MeK7FZel5WYph7OMkEDszWSEvWpdekCxkf/dB6x0bA==
Date: Tue, 10 Oct 2023 10:40:49 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Walle <michael@walle.cc>, Jacob Keller
 <jacob.e.keller@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 09/16] netlink: specs: Introduce new netlink
 command to get current timestamp
Message-ID: <20231010104049.1cbff3f8@kmaincent-XPS-13-7390>
In-Reply-To: <dca2c4a8-7805-4cdb-a311-d308057cdd75@broadcom.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
	<20231009155138.86458-10-kory.maincent@bootlin.com>
	<dca2c4a8-7805-4cdb-a311-d308057cdd75@broadcom.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 14:21:42 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> On 10/9/23 08:51, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > Add a new commands allowing to get the current time stamping on a
> > netdevice's link.
> >=20
> > Example usage :
> > ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do ts-get \
> > 	     --json '{"header":{"dev-name":"eth0"}}'
> > {'header': {'dev-index': 3, 'dev-name': 'eth0'}, 'ts-layer': 1}
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> This is small enough you could probably fold this patch into patch 8.

I like having it separate. Indeed the ynl tool does not have a proper usage
documentation. I took quite some times to me to understand how use it
especially with bitset. Using the commit messages to add examples like that
would have help me a lot in the process.
I could also squash the example in the previous commit message but then it
become more noisy.
What do you think?

