Return-Path: <netdev+bounces-90356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3638ADD9B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1D61C21417
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8222619;
	Tue, 23 Apr 2024 06:44:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBC2A1D4
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854661; cv=none; b=Lq5XJN3cfuaXsSiBC3ofE7dHt0rUaT9Xij6aG8isC5gLahQs6j22WM7xC9hos38aTBDOZhkTV8jYB+MwuKXtXKgvX+t3ovCCBhULuYM4+zzva03KfzWW2sqR/Pj3wrJnKEjwpFo6hDwr4jKZy0NSh8CV5U+2EYZbk+mRar39i78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854661; c=relaxed/simple;
	bh=3yvG2JR0FVm384FMkHjhLQhJrk9XdHHltko3LnCBBic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BNy4UWe0Up2Ys0dY6RQ8ekgUgADHt7Puc+hdwiTyOfpJR+Ir1s+7hiQP6QBI1PNbExKYaKkm8Y5haauSnDSBG2L/yVynsB24PAMp5/ygN4XncSCAxvE1q+ZR2cptiI8k7VYmVaV9ftG27Y2ChT8AJefiC5s972k/ckT+yxTwM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rz9sp-0007P6-Hm; Tue, 23 Apr 2024 08:44:03 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  Clark Wang <xiaoning.wang@nxp.com>,  Linux Team
 <linux-imx@nxp.com>,  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  Jose Abreu <joabreu@synopsys.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/3] arm64: mx93: etherrnet: set TX_CLK in RMII mode
In-Reply-To: <f01d49cf-5955-405c-9c2b-05b0c7bb982c@armadeus.com>
 (=?utf-8?Q?=22S=C3=A9bastien?=
	Szymanski"'s message of "Mon, 22 Apr 2024 11:28:08 +0200")
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
	<f01d49cf-5955-405c-9c2b-05b0c7bb982c@armadeus.com>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Tue, 23 Apr 2024 08:43:58 +0200
Message-ID: <87mspkk28h.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


Hi,

On 2024-04-22 at 11:28 +02, S=C3=A9bastien Szymanski <sebastien.szymanski@a=
rmadeus.com> wrote:=20
=20
> Hello,  On 4/22/24 10:46, Steffen Trumtrar wrote:=20
> > This series adds support for setting the TX_CLK direction in the eQOS e=
thernet core on the i.MX93 when RMII mode is used.  According to AN14149, w=
hen the i.MX93 ethernet controller is used in RMII mode, the TX_CLK *must* =
be set to output mode.=20
>  Must ? I don't think that is true. Downstream NXP kernel has an option t=
o set TX_CLK as an input:=20
>

re-reading that passage again, it only says "other registers that must be c=
onfigured" and that the ENET_QOS_CLK_TX_CLK_SEL bit "is 0b1" for RMII. So, =
maybe you are right.=20


Thanks,
Steffen

> https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/Documentation/devicetr=
ee/bindings/net/nxp%2Cdwmac-imx.yaml#L69
>=20
> https://github.com/nxp-imx/linux-imx/commit/fbc17f6f7919d03c275fc48b0400c=
212475b60ec
>=20

--=20
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

