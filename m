Return-Path: <netdev+bounces-49170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE47F1003
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FF51C2142E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B4312B90;
	Mon, 20 Nov 2023 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q8ErNCta"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BDBA;
	Mon, 20 Nov 2023 02:13:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 704F21BF215;
	Mon, 20 Nov 2023 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700475227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmUGH3YuoMjyTyRQ6pJiUJgPb2L/5jsBh4vmboUNNnY=;
	b=Q8ErNCtaXnZs5qZYQUDMJbWRAD/Jy/F3Vv3Vj3ZQEQ4nyuJQyw6q1BNJhz1bze05MEkXgO
	eVvuiHZLXRdQtFpD6kVPZqpHXivAeFRekC2ixepAQqok/6gwVtIhbXEMPl7E6+HmtcdjQu
	LfixvgdAFoNyI6OwAv/KIquB6SW/xc49HY0E/QU+Nb/QOYHY0T2JfHP7SmOFLWW/crwv1Q
	5bCsckNXqP5gPUZLxU4V/lGOCMIUU8rGbWdAk9PcWi7SQhyKd0NZO8/nSvDkimNwA1o168
	8ZNQcvrO3mCBcNTlr8qqbR9asKBGLBSKOXolaMnlxxmQMJPjKzbzpgA0vfqW/g==
Date: Mon, 20 Nov 2023 11:13:45 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] netlink: specs: Expand the pse netlink
 command with PoE interface
Message-ID: <20231120111345.0ad15ea5@kmaincent-XPS-13-7390>
In-Reply-To: <20231118160131.207b7e57@kernel.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-6-be48044bf249@bootlin.com>
	<20231118160131.207b7e57@kernel.org>
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

On Sat, 18 Nov 2023 16:01:31 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 16 Nov 2023 15:01:38 +0100 Kory Maincent wrote:
> > +        name: pse-admin-state
> > +        type: u32
> > +        name-prefix: ethtool-a-
> > +      -
> > +        name: pse-admin-control
> > +        type: u32
> > +        name-prefix: ethtool-a-
> > +      -
> > +        name: pse-pw-d-status
> > +        type: u32
> > +        name-prefix: ethtool-a- =20
>=20
> The default prefix is ethtool-a-pse-
> Why don't you leave that be and drop the pse- from the names?

Oh right, thanks, I copied blindly the PoDL lines.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

