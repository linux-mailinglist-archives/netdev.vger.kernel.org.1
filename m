Return-Path: <netdev+bounces-34879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330AB7A5AF7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DE1C20C4D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5411358A9;
	Tue, 19 Sep 2023 07:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62534CF5
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:32:47 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81567114;
	Tue, 19 Sep 2023 00:32:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD8DB1BF20A;
	Tue, 19 Sep 2023 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695108765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vxL7pYoQxk9FSR+fqgg0+sjwi0fCCi1XB+3HlChxV0=;
	b=JdVtLK+5cLlScXDozenIb4lPgdx148FNLNOG2Id4iyo8764/hRSHNTyWm9YCign9VGEF29
	+PIsNUj4O4I1goIg6De/Mp7IfEBlyB6OyZWv7EcK4n3tdeqKogUi7nEzQDWLm/1iVjAHEw
	dqS5cWOJO8mK7HegkfJzRSk5qwMcboWgk+gUnT6xa3FTN3ZrFlXmz/PbXbgAaB4WlxmVcd
	iN8e4ZJUUcWuyTcUPgKCPwaSm90zDqmVy/dApyJL7UB/eTEKMUTPcmHOisLbo7o5Xo0Hn/
	HCL0PBlMhj+lXCthHEpt+V0QwRydfS/0aKGHj3jyckjgJPMj+G2prERRcCKfHg==
Date: Tue, 19 Sep 2023 09:32:43 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: kernel test robot <lkp@intel.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v3 11/11] ieee802154: Give the user the
 association list
Message-ID: <20230919093243.3e5f3429@xps-13>
In-Reply-To: <202309191044.4ABvPP5X-lkp@intel.com>
References: <20230918150809.275058-12-miquel.raynal@bootlin.com>
	<202309191044.4ABvPP5X-lkp@intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

>    net/ieee802154/nl802154.c: In function 'nl802154_list_associations':
> >> net/ieee802154/nl802154.c:1778:15: error: implicit declaration of func=
tion 'nl802154_prepare_wpan_dev_dump' [-Werror=3Dimplicit-function-declarat=
ion] =20
>     1778 |         err =3D nl802154_prepare_wpan_dev_dump(skb, cb, &rdev,=
 &wpan_dev);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> net/ieee802154/nl802154.c:1811:9: error: implicit declaration of funct=
ion 'nl802154_finish_wpan_dev_dump' [-Werror=3Dimplicit-function-declaratio=
n] =20
>     1811 |         nl802154_finish_wpan_dev_dump(rdev);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>=20
>=20
> vim +/nl802154_prepare_wpan_dev_dump +1778 net/ieee802154/nl802154.c
>=20
>   1769=09
>   1770	static int nl802154_list_associations(struct sk_buff *skb,
>   1771					      struct netlink_callback *cb)
>   1772	{
>   1773		struct cfg802154_registered_device *rdev;
>   1774		struct ieee802154_pan_device *child;
>   1775		struct wpan_dev *wpan_dev;
>   1776		int err;
>   1777=09
> > 1778		err =3D nl802154_prepare_wpan_dev_dump(skb, cb, &rdev, &wpan_dev)=
; =20

[...]

> > 1811		nl802154_finish_wpan_dev_dump(rdev); =20

These two are defined within #ifdef EXPERIMENTAL. I will move them out
as I need them as well inthe !EXPERIMENTAL case. Good that kernel test
robot eventually catch that.

Thanks,
Miqu=C3=A8l

