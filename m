Return-Path: <netdev+bounces-16732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACF74E935
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BA71C20CEF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F5134C8;
	Tue, 11 Jul 2023 08:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B0171A3
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:36:42 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A6198;
	Tue, 11 Jul 2023 01:36:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B6A320002;
	Tue, 11 Jul 2023 08:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1689064597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcF/dD7Z8yfzBkNvI4P1fBcyCYyfjI5P6OTKVfbQbv8=;
	b=U8CkyYbhudE9wDZfge8cSyPHStwQgVvafl7SIb3J50Q1cboyxZRzJf3hRq+AUDnXlPZ18F
	DF1r/N7EhCkD0mojaqSJrnBnXKgKc8hPrCf9jiSBjON9piRzd/5ARHmmE5xvAnm/+/gmQD
	zH95es03wpjuDL9oSNuTjqT3rdd02NQTLL0kBTxHwpv9B5AxvlcBdUA3ctcQLXGk6by2bA
	GDnjUYyH0H21dAwImqnCeSvhG6U6rjgWjCPVsgXqjbjal7stq+ZRYOAnpz1O/j12F/xEMo
	HJbHZEl9mPGThw2J7ygBIa6JUsvcMh7+tw1bUfnf1Iowy9HB28P6IPWVDByldg==
Date: Tue, 11 Jul 2023 10:36:34 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, Marcel
 Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net 03/12] net: cfg802154: fix kernel-doc notation
 warnings
Message-ID: <20230711103634.450e66c7@xps-13>
In-Reply-To: <20230710230312.31197-4-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
	<20230710230312.31197-4-rdunlap@infradead.org>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

rdunlap@infradead.org wrote on Mon, 10 Jul 2023 16:03:03 -0700:

> Add an enum heading to the kernel-doc comments to prevent
> kernel-doc warnings.
>=20
> cfg802154.h:174: warning: Cannot understand  * @WPAN_PHY_FLAG_TRANSMIT_PO=
WER: Indicates that transceiver will support
>  on line 174 - I thought it was a doc line
>=20
> cfg802154.h:192: warning: Enum value 'WPAN_PHY_FLAG_TXPOWER' not describe=
d in enum 'wpan_phy_flags'
> cfg802154.h:192: warning: Excess enum value 'WPAN_PHY_FLAG_TRANSMIT_POWER=
' description in 'wpan_phy_flags'
>=20
> Fixes: edea8f7c75ec ("cfg802154: introduce wpan phy flags")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: linux-wpan@vger.kernel.org
> Cc: Marcel Holtmann <marcel@holtmann.org>

I believe the whole series is subject to be taken directly by the net
maintainers, so:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Please let me know if I should instead consider this patch for the wpan
tree.

Thanks,
Miqu=C3=A8l

