Return-Path: <netdev+bounces-50212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B327F4EF8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063DAB20C5E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B0D56475;
	Wed, 22 Nov 2023 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fm2p2vQL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB1B2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 10:11:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41ea9c5e83cso12551cf.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700676701; x=1701281501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAQB8Hqqm5OvoGj9nVayTd/1ohNlYq2PenxVIqdoeMw=;
        b=fm2p2vQLatnCZwoh8euniQPcouWhq6w+hG12y3Zr5zi8FDkGjNbfmrCaRUHBgH6teP
         wFR+w1wM1oNoQL2q09ae+ckbFuL2L89lVWa9yB3yk2MLLd9czstvKxoXd9v9RPCk6UcV
         Oec+RLvRxtbETqebZPscvPP5++7vZGlJp6ny+SxqGLf3+vsW4hWoJr/K0k0C8AdMHP85
         sZznmIqTOw7+MaT3Gw9Z39IIxlx8B8inISbxNaJzmXzdeZaqxBkP6W7GTHIqG8XavbYm
         2MDDT4mAF+qxpfe/9XJI8+UIQnrmxNoYF+3P4QFBEgFaRzt3YHk/8garZlUKW0ff/vLz
         vKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676701; x=1701281501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAQB8Hqqm5OvoGj9nVayTd/1ohNlYq2PenxVIqdoeMw=;
        b=lA0KTXRgiS9erFqaQNAG1Ko1sNn3sMMu2e6Uc1Ac8KiYtnO5Q6huxmp62O2qr8T6Aj
         ffGBC6+6l7cJAmsPrv/6pKOuZBSfVYrOfrjhUwI0OLgRn8r9vav4AK4DkqK5i2F+bCgS
         42Qxr38XNMj0TWMRW50JGf/gZcVOuUW21NaUUJ5yBFjOue9gNu1kkLSYEXlbpNpvTDkg
         xXIuNoTsmYu3+5dP4dkD1Wfccsq99FM9MKSw5wF+6AEI7LT5ARZKoWPCl9DqPeJ8egjw
         nv4rOwYLN1GhINWaOckD4xQS/eG1t7rtAl7UmSFNmsjPFAl3Wf2TmB/G9a4a6VhK5x+2
         j6fQ==
X-Gm-Message-State: AOJu0YxwSypwuukBsfW866wgSsaqIWzSLVdxV+NDwoSugZq1urW3DoFE
	xrLqyPTs/xJxZJM9WZqQlEfxMniVjMHNMh5zAeVgbw==
X-Google-Smtp-Source: AGHT+IGnVy3OkrkedALWFXc2ZxGZceq3AwioxW/zk3TSCzH69K8tQhpDqZs4kwBm6hQdtLLNyQBm88m5ggQuiUU9tgg=
X-Received: by 2002:ac8:4e54:0:b0:420:d18c:ffd2 with SMTP id
 e20-20020ac84e54000000b00420d18cffd2mr306349qtw.24.1700676700854; Wed, 22 Nov
 2023 10:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120115839.74ee5492@kernel.org> <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org> <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390> <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390> <20231122140850.li2mvf6tpo3f2fhh@skbuf>
 <20231122143618.cqyb45po7bon2xzg@skbuf> <20231122085459.1601141e@kernel.org>
 <20231122165955.tujcadked5bgqjet@skbuf> <20231122095525.1438eaa3@kernel.org>
In-Reply-To: <20231122095525.1438eaa3@kernel.org>
From: Willem de Bruijn <willemb@google.com>
Date: Wed, 22 Nov 2023 13:11:02 -0500
Message-ID: <CA+FuTSe+SOFciGf+d+e=Co22yZ56gGGkJ0WBbvfT-2P0+Ug8DQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Simon Horman <horms@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 12:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 22 Nov 2023 18:59:55 +0200 Vladimir Oltean wrote:
> > I wouldn't be so sure. The alternative interpretation "for PTP, give me
> > timestamps from both sources" also sounds reasonable for the distant
> > future where that will be possible (with proper cmsg identification).
> > But I don't see how to distinguish the two - the filters, expressed in
> > these terms, would be the same.
>
> We can add an attribute that explicitly says that the configuration
> is only requesting one stamp. But feels like jumping the gun at this
> stage, given we have no other option to express there.
>
> > So the ptp4l source code would have to be modified to still work with
> > the same precision as before? I'm not seeing this through.
>
> We can do the opposite and add a socket flag which says "DMA is okay".

There already is a disconnect between configuring hardware timestamp
generation. Through the ioctl, which is a global admin-only interface.
And requesting timestamps with SO_TIMESTAMPING.

Today the user of ptp4l already has to know that the admin has
configured the right RX and TX filters. That is no different if
multiple filters can be installed? (PHY for PTP, DMA for everything
else).

If attribution becomes important, we could add another cmsg alongside
the timestamp. On TX this already happens with
IP_RECVERR/IPV6_RECVERR/PACKET_TX_TIMESTAMP. Maybe the
sock_extended_err struct even still has a field that can be (ab)used
for this purpose.

Being able to pass multiple timestamps up to userspace eventually will
be interesting. A large blocker is where to store these values in the
sk_buff on the path between the driver and the socket (skb_ext?). At
Google we already have this scenario, where the local TCP stack and
userspace both want converted hardware timestamps -- but converted
from raw to different timebases.

