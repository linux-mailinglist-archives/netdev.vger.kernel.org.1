Return-Path: <netdev+bounces-41382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC18D7CABC6
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094861C20975
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB3286BC;
	Mon, 16 Oct 2023 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PZsVQ2YO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99328E1C
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:41:54 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE066A2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697467310; x=1729003310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AfY4KWDk/y0chtVhZrLZNLcgBVTn2dPIVHmMu5VynyI=;
  b=PZsVQ2YOdFU0wb/ga5sb1Y9kf8OWSJ+x+L0Vt2XZjurfRpe4FIhCX0E6
   GZ1BnRmTpbPRL2LTYUZ6zauWSUtRaFoVNU8CVbccajchFSBf0BbwWnc9+
   LZ5sInvPdJbCfRvZGdT4rZk/3wIDDzK3GHVkewUO9nMvfCPfHMdiNrcU/
   l7Q+2yg79Tr1BUvkUgyOt+wvUWnJMfeUrPHYkRwc+ulldS9tdxjEcLgaz
   oPOXdybJPyiYzO1no5LHjREU1Jvy1dtfbeZSQGOXg9+z3SqH/lA/I0yZ6
   +XC73jxi9vMV95X4lRpd59q7ZS4I6zpvFkkjsxbJoEnpL57a3ZJY9/Lbo
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,229,1694728800"; 
   d="scan'208";a="33485842"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Oct 2023 16:41:48 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 653E0280082;
	Mon, 16 Oct 2023 16:41:48 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Russell King <linux@armlinux.org.uk>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Date: Mon, 16 Oct 2023 16:41:50 +0200
Message-ID: <3527956.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231016153154.31d92529@xps-13>
References: <20231012193410.3d1812cf@xps-13> <2245614.iZASKD2KPV@steina-w> <20231016153154.31d92529@xps-13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Miquel,

Am Montag, 16. Oktober 2023, 15:31:54 CEST schrieb Miquel Raynal:
> Hi Alexander,
>=20
> Thanks a lot for your feedback.
>=20
> > > switch to partitions #0, OK
> > > mmc1 is current device
> > > reading boot.scr
> > > 444 bytes read in 10 ms (43 KiB/s)
> > > ## Executing script at 20000000
> > > Booting from mmc ...
> > > reading zImage
> > > 9160016 bytes read in 462 ms (18.9 MiB/s)
> > > reading <board>.dtb
> >=20
> > Which device tree is that?
> >=20
> > > 40052 bytes read in 22 ms (1.7 MiB/s)
> > > boot device tree kernel ...
> > > Kernel image @ 0x12000000 [ 0x000000 - 0x8bc550 ]
> > > ## Flattened Device Tree blob at 18000000
> > >=20
> > >    Booting using the fdt blob at 0x18000000
> > >    Using Device Tree in place at 18000000, end 1800cc73
> > >=20
> > > Starting kernel ...
> > >=20
> > > [    0.000000] Booting Linux on physical CPU 0x0
> > > [    0.000000] Linux version 6.5.0 (mraynal@xps-13)
> > > (arm-linux-gcc.br_real
> > > (Buildroot 2 020.08-14-ge5a2a90) 10.2.0, GNU ld (GNU Binutils) 2.34)
> > > #120
> > > SMP Thu Oct 12 18:10:20 CE ST 2023
> > > [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),
> > > cr=3D10c5387d [    0.000000] CPU: PIPT / VIPT nonaliasing data cache,=
 VIPT
> > > aliasing instruction cache
> > > [    0.000000] OF: fdt: Machine model: TQ TQMa6Q
> > > on MBa6x
> >=20
> > Your first mail mentions a custom board, but this indicates "TQMa6Q
> > on MBa6x", so which is it?
>=20
> It's a custom carrier board with a TQMA6Q-AA module.

Could you please adjust the machine model to your mainboard if it is not a=
=20
MBa6x? Thanks.
Which HW revision is this module? It should be printed in u-boot during sta=
rt.=20
Can you provide a full log?

> > Please note that there are two different module variants,
> > imx6qdl-tqma6a.dtsi and imx6qdl-tqma6b.dtsi. They deal with i.MX6's
> > ERR006687 differently. Package drop without any load somewhat indicates
> > this issue.
>=20
> I've tried with and without the fsl,err006687-workaround-present DT
> property. It gets successfully parsed an I see the lower idle state
> being disabled under mach-imx. I've also tried just commenting out the
> registration of the cpuidle driver, just to be sure. I saw no
> difference.

fsl,err006687-workaround-present requires a specific HW workaround, see [1]=
=2E=20
So this is not applicable on every module.

> By the way, we tried with a TQ eval board with this SoM and saw the same
> issue (not me, I don't have this board in hands). Don't you experience
> something similar? I went across a couple of people reporting similar
> issues with these modules but none of them reported how they fixed it
> (if they did). I tried two different images based on TQ's Github using
> v4.14.69 and v5.10 kernels.

Personally I've heard the first time about this issue. I never noticed=20
something like this. Does this issue also appear when using TCP? Or is it a=
n=20
UDP only issue?

Best regards,
Alexander

[1] https://github.com/tq-systems/linux-tqmaxx/blob/TQMa8-fslc-5.10-2.1.x-i=
mx/
arch/arm/boot/dts/imx6qdl-tqma6a.dtsi#L36-L48

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



