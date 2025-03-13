Return-Path: <netdev+bounces-174748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D4A60276
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73F116F7B8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F551F3FE8;
	Thu, 13 Mar 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJjow640"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093F42AA9;
	Thu, 13 Mar 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897351; cv=none; b=IqTf0H2OtCfpfES6pDZMu1oJS5gboVIejCfAGg17cmdWQJrlKkjus/UMyKoOVNwheNNR/KPlqyULBXENIBl5mB+zsm60OIh2TOvvQwAO3Ael24wjelgnPKg3v+LUXtpUzDL5eCS4gPENadaUcyKOcdHZtp7BAgZsVb510p6rasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897351; c=relaxed/simple;
	bh=2Ubrn3vw5OoeA0jFCkzjYo3i5zUpGJxfx7CRuIQHoUM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YyNserH5XL3MXocTA6QROOf6u2eTb0JniCCG+j6FwdBIjVLUAJuJ+Mk4Bs2D3KxNvQLquQEPW89WmRVWUrH/+kwInweC3y0FrtuIMSwl5BzHuHrEUT53eVyM6MEx+7u34DSEd8DEGtIAfCWTeTp9NHKvGjBdcrWjMqA/Bq8lkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJjow640; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A611EC4CEDD;
	Thu, 13 Mar 2025 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741897350;
	bh=2Ubrn3vw5OoeA0jFCkzjYo3i5zUpGJxfx7CRuIQHoUM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=XJjow640+p8SFFIt3qd7pSc55KNUf2aPDnh5lFC7h7Tp/OGU02NUQ1KgmtGdblwd+
	 XODsUZgTqEDlAwzaU8b8+x1cmywLuVsahRSiN80au+vheAXHAtC+s3fIolSgpUJBBC
	 umINKQgxcqUjIw5pZW3KY07cGjnsG1otzBZcML2xd3FWe7GBhQMheq1sduVTtcL3eC
	 h/f8JkJ2xUHaTaqVXBcdQGJbty+398gIzl8diIEj122H6uZdQxsVjoxD6u+KECMHG/
	 b4d4OTBnYSxeG3mZcWeiImnh+vDak8EcKliw34XpTbpQBXNLzYDm4wiIlZ/7ZnyGCO
	 kOwsRl6ln0DEw==
Message-ID: <f5228d559599f0670e6cbf26352bd1f1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <nxvuxo7lsljsir24brvghblk2xlssxkb3mfgx6lbjahmgr4kep@fvpmciimfikg>
References: <20250226232320.93791-1-inochiama@gmail.com> <20250226232320.93791-2-inochiama@gmail.com> <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org> <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp> <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org> <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv> <b816b3d1f11b4cc2ac3fa563fe5f4784.sboyd@kernel.org> <nxvuxo7lsljsir24brvghblk2xlssxkb3mfgx6lbjahmgr4kep@fvpmciimfikg>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Date: Thu, 13 Mar 2025 13:22:28 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Inochi Amaoto (2025-03-12 18:08:11)
> On Wed, Mar 12, 2025 at 04:43:51PM -0700, Stephen Boyd wrote:
> > Quoting Inochi Amaoto (2025-03-12 16:29:43)
> > > On Wed, Mar 12, 2025 at 04:14:37PM -0700, Stephen Boyd wrote:
> > > > Quoting Inochi Amaoto (2025-03-11 16:31:29)
> > > > >=20
> > > > > > or if that syscon node should just have the #clock-cells proper=
ty as
> > > > > > part of the node instead.
> > > > >=20
> > > > > This is not match the hardware I think. The pll area is on the mi=
ddle
> > > > > of the syscon and is hard to be separated as a subdevice of the s=
yscon
> > > > > or just add  "#clock-cells" to the syscon device. It is better to=
 handle
> > > > > them in one device/driver. So let the clock device reference it.
> > > >=20
> > > > This happens all the time. We don't need a syscon for that unless t=
he
> > > > registers for the pll are both inside the syscon and in the register
> > > > space 0x50002000. Is that the case?=20
> > >=20
> > > Yes, the clock has two areas, one in the clk controller and one in
> > > the syscon, the vendor said this design is a heritage from other SoC.
> >=20
> > My question is more if the PLL clk_ops need to access both the syscon
> > register range and the clk controller register range. What part of the
> > PLL clk_ops needs to access the clk controller at 0x50002000?
> >=20
>=20
> The PLL clk_ops does nothing, but there is an implicit dependency:
> When the PLL change rate, the mux attached to it must switch to=20
> another source to keep the output clock stable. This is the only
> thing it needed.

I haven't looked at the clk_ops in detail (surprise! :) but that sounds
a lot like the parent of the mux is the PLL and there's some "safe"
source that is needed temporarily while the PLL is reprogrammed for a
new rate. Is that right? I recall the notifier is in the driver so this
sounds like that sort of design.

