Return-Path: <netdev+bounces-178019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBDEA74033
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52113188903C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85F1DDC2E;
	Thu, 27 Mar 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai4ncbLP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E31DDA3E;
	Thu, 27 Mar 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110517; cv=none; b=myt47fwdlyszYd4J2jZk9aAMMuyZAV/NpvSIc6JKUvjVo0ktF2zhpugtLd4R032DBG364NLixz6Q638pUxUc/kf9T1OLw0IZIb6g+2JCl3fO80Nem+Mw1NyF6RAdiDMkVOw/t1CbedAywLHpfS2bisKDRx69Jf4vajh6OSGRB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110517; c=relaxed/simple;
	bh=u8ZF0qF61gU2yr4l1GcEiez+8svfoYCvfCPaIe/1iVQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=myhqIj4HvsYkCQJDCAoRw1WMXJOEOgWvxysQ+Q+fJdSMIVDAfb7q9XVZCLSnvocuz7CWmJv62Ttn/NJ6OT+ScaUS+aVrKANo+FZKJ8Azc0O9/IoL8xA8/0urU6vapjUNWwZA+H07OM2qof1HIGbjJUvgyyhhhcw4+tNBCXwQX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai4ncbLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FFBC4CEE8;
	Thu, 27 Mar 2025 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743110517;
	bh=u8ZF0qF61gU2yr4l1GcEiez+8svfoYCvfCPaIe/1iVQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ai4ncbLPtDD/mCmM5268US4xjHplHR96SY+BXC6Akgvs4jQtv5d+ZUoiW0czlXnn0
	 +pegTUWvsKLkeKLENJo17xxR+eGn5a6VDUGPOaNJBeOb0DEUQJ0eGy5VRcSUZRcQ8s
	 Fzrj9aTER0weJGwnoxrdN/+5n06t6txAGRPUWi1bAFSmghjDZiDDuvAv0NvhK3gFfd
	 ywqmAerv0ZEn5/20FBItOwE51ahI3+5d8sC9YuvG4vYYRoxnqvdH6Wrl16vIiH2N9j
	 2l3yQBn2YcfnOVTW/MbClamU5oxeL90GiA7naF94gymnMfHTUnbdNv0S6PzWRwXuPP
	 cGVIrf3FNfdWA==
Message-ID: <a9626bfa7a481cee3178f3aa80721520@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <txuujicelz5kbcnn3qyihwaspqrdc42z4kmijpwftkxlbofg2w@jsqmwj4lz662>
References: <20250226232320.93791-1-inochiama@gmail.com> <20250226232320.93791-2-inochiama@gmail.com> <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org> <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp> <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org> <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv> <b816b3d1f11b4cc2ac3fa563fe5f4784.sboyd@kernel.org> <nxvuxo7lsljsir24brvghblk2xlssxkb3mfgx6lbjahmgr4kep@fvpmciimfikg> <f5228d559599f0670e6cbf26352bd1f1.sboyd@kernel.org> <txuujicelz5kbcnn3qyihwaspqrdc42z4kmijpwftkxlbofg2w@jsqmwj4lz662>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Date: Thu, 27 Mar 2025 14:21:55 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Inochi Amaoto (2025-03-13 15:46:22)
> On Thu, Mar 13, 2025 at 01:22:28PM -0700, Stephen Boyd wrote:
> > Quoting Inochi Amaoto (2025-03-12 18:08:11)
> > > On Wed, Mar 12, 2025 at 04:43:51PM -0700, Stephen Boyd wrote:
> > > > Quoting Inochi Amaoto (2025-03-12 16:29:43)
> > > > > On Wed, Mar 12, 2025 at 04:14:37PM -0700, Stephen Boyd wrote:
> > > > > > Quoting Inochi Amaoto (2025-03-11 16:31:29)
> > > > > > >=20
> > > > > > > > or if that syscon node should just have the #clock-cells pr=
operty as
> > > > > > > > part of the node instead.
> > > > > > >=20
> > > > > > > This is not match the hardware I think. The pll area is on th=
e middle
> > > > > > > of the syscon and is hard to be separated as a subdevice of t=
he syscon
> > > > > > > or just add  "#clock-cells" to the syscon device. It is bette=
r to handle
> > > > > > > them in one device/driver. So let the clock device reference =
it.
> > > > > >=20
> > > > > > This happens all the time. We don't need a syscon for that unle=
ss the
> > > > > > registers for the pll are both inside the syscon and in the reg=
ister
> > > > > > space 0x50002000. Is that the case?=20
> > > > >=20
> > > > > Yes, the clock has two areas, one in the clk controller and one in
> > > > > the syscon, the vendor said this design is a heritage from other =
SoC.
> > > >=20
> > > > My question is more if the PLL clk_ops need to access both the sysc=
on
> > > > register range and the clk controller register range. What part of =
the
> > > > PLL clk_ops needs to access the clk controller at 0x50002000?
> > > >=20
> > >=20
> > > The PLL clk_ops does nothing, but there is an implicit dependency:
> > > When the PLL change rate, the mux attached to it must switch to=20
> > > another source to keep the output clock stable. This is the only
> > > thing it needed.
> >=20
> > I haven't looked at the clk_ops in detail (surprise! :) but that sounds
> > a lot like the parent of the mux is the PLL and there's some "safe"
> > source that is needed temporarily while the PLL is reprogrammed for a
> > new rate. Is that right? I recall the notifier is in the driver so this
> > sounds like that sort of design.
>=20
> You are right, this design is like what you say. And this design is=20
> the reason that I prefer to just reference the syscon node but not
> setting the syscon with "#clock-cell".
>=20

I don't see why a syscon phandle is preferred over #clock-cells. This
temporary parent is still a clk, right? In my opinion syscon should
never be used. It signals that we lack a proper framework in the kernel
to handle something. Even in the "miscellaneous" register range sort of
design, we can say that this grab bag of registers is exposing resources
like clks or gpios, etc. as a one off sort of thing because it was too
late to change other hardware blocks.

