Return-Path: <netdev+bounces-36080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D07AD1CC
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 09:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0E1A128172D
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C6A10974;
	Mon, 25 Sep 2023 07:34:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B310942
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 07:34:11 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7945BFF;
	Mon, 25 Sep 2023 00:34:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ED02FF802;
	Mon, 25 Sep 2023 07:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695627248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yfaI6Efiq2wTalE4NAQVjDofyzKfIrJQng6TOLgn4g=;
	b=bn8vgqF2cv2wvuBe6AmH70CVSUm0T//A7+fE3dmCQ/VxnFEAz+WXXY+z9qDONr07sIl4sl
	yggo9HhD9KQ1shD62Kzpg4GHBPYxSOB04P4PzM5UU41wPToZreAlTyR44VDVr6s5GHxAes
	BspxgN4jIexTpwG1/EN0UOX3+5afhFjVDCmdxjkY1Hynp0TJYmPOOXAZeP+TCxm05pVb+u
	FAEDjN3kgAc3zqgCpxsD+VEM0DLnUyxqHbdAcO0Kc9kBu4hAg1vKHbwoxiwgB2MX3t+jDU
	6hWazPYG0lKN7CjEWV9Ak+YLQiB45sBAWcYiRfR4EjBAUAbGUyf/lqqzsZVweA==
Date: Mon, 25 Sep 2023 09:34:03 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v4 01/11] ieee802154: Let PAN IDs be reset
Message-ID: <20230925093403.0ec27236@xps-13>
In-Reply-To: <CAK-6q+i_fVbj3ceMcCA8F-6aRcX2YX8+iMdQSYmQ7FWLNKfP+g@mail.gmail.com>
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
	<20230922155029.592018-2-miquel.raynal@bootlin.com>
	<CAK-6q+i_fVbj3ceMcCA8F-6aRcX2YX8+iMdQSYmQ7FWLNKfP+g@mail.gmail.com>
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

Hi Alexander,

aahringo@redhat.com wrote on Sun, 24 Sep 2023 16:42:31 -0400:

> Hi,
>=20
> On Fri, Sep 22, 2023 at 11:50=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Soon association and disassociation will be implemented, which will
> > require to be able to either change the PAN ID from 0xFFFF to a real
> > value when association succeeded, or to reset the PAN ID to 0xFFFF upon
> > disassociation. Let's allow to do that manually for now.
> > =20
>=20
> ok. But keep in mind what happens when a device is associated and the
> user sets a short address manually to 0xFFFF?
>=20
> It should be a kind of forced mode of disassociation?

I believe once you start interacting with other devices with proper
associations, random user requests cannot all be addressed, in
particular once you are officially associated with another device, you
cannot change your own short address or PAN ID like that. So in the
right next series (after this one) I have a couple of small
additions through the tree to handle this kind of corner case. Here
is how it will look like in nl802154.c:

nl802154_set_short_addr():

        /* The short address only has a meaning when part of a PAN, after a
         * proper association procedure. However, we want to still offer the
         * possibility to create static networks so changing the short addr=
ess
         * is only allowed when not already associated to other devices with
         * the official handshake.
         */
        if (cfg802154_device_is_associated(wpan_dev)) {
                NL_SET_ERR_MSG(info->extack,
                               "Existing associations, changing short addre=
ss forbidden");
                return -EINVAL;
        }

nl802154_set_pan_id():

        /* Only allow changing the PAN ID when the device has no more
         * associations ongoing to avoid confusing peers.
         */
        if (cfg802154_device_is_associated(wpan_dev)) {
                NL_SET_ERR_MSG(info->extack,
                               "Existing associations, changing PAN ID forb=
idden");
                return -EINVAL;
        }

I did not want to bloat this series with too much corner case handling,
so there are a couple of "misc additions" in the next series to handle
exactly that.

Thanks,
Miqu=C3=A8l

