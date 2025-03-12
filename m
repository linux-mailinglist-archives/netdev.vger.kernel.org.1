Return-Path: <netdev+bounces-174425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D693A5E89D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 00:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14AC17430D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF541F236E;
	Wed, 12 Mar 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgldZZBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F41EF088;
	Wed, 12 Mar 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823034; cv=none; b=mymO6dv5g0Lp2z2pu8+hnGyNPCXalYJRnJUJuTtEwc1Hx1SDf7ccq7h0AyP4Yy/6WIlaR7N72XfvQq9pL8yTWuB+30m4er+2OPlUFCqDuuz5D84aUlMfQ4Ek0bn19w3k9JM+X+TBez3lz/GO1hi3FGvm3/zD3rdoOAkt9xmr7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823034; c=relaxed/simple;
	bh=7qeO9k35Hmf3unT9bk7nXpFsKvN3ZjCrLqN94ZDy/xY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tIK51lhHmgLzOnYpZF7XlDZXMD4ZUYgKZ7HzsNeCAXu3CNK+rznJFlxkcoFQBBgOvrm60PycVIlS+Xet/+ZGEHxIG5/0yt1gei5PqYGHJWaQ2/McY8JKhPe7gYyeJbluRE2fs3mwOUFtxeyrUGRH2pR9GDlTcHmJEr1kNa2e60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgldZZBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314AAC4CEE3;
	Wed, 12 Mar 2025 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741823034;
	bh=7qeO9k35Hmf3unT9bk7nXpFsKvN3ZjCrLqN94ZDy/xY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UgldZZBxs1jNGFAfoJSWFhK8fC/bThJDwdWIo7KwuPexnp1DzwW/y41+LVwnYc7jA
	 KK1BXvPs5GSCJufl/Ea3cQ+G6Is1+WFv1wAz3janhGUOXjICdx1VahCtUoHl5WxBQb
	 emj3um5Lyr8RXoYPJCPrXbGEoarTQGyfhIU5tQIAg4vfY126YfahutY4zIuuKENeLD
	 qWC60FZ8KlCBUjNc2k3KZwCqp9m1eyjgarkxrYRpECLUn+0rU+ERq3U/3CJx1S0ALX
	 RcMp7oFYa+DqFrWnwbxKNt1UuwCLBWeOFM5gzZzieqa+8T5vQ28oHUkz7T+AIxB37t
	 EA46xrLB2FfKQ==
Message-ID: <b816b3d1f11b4cc2ac3fa563fe5f4784.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv>
References: <20250226232320.93791-1-inochiama@gmail.com> <20250226232320.93791-2-inochiama@gmail.com> <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org> <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp> <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org> <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Date: Wed, 12 Mar 2025 16:43:51 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Inochi Amaoto (2025-03-12 16:29:43)
> On Wed, Mar 12, 2025 at 04:14:37PM -0700, Stephen Boyd wrote:
> > Quoting Inochi Amaoto (2025-03-11 16:31:29)
> > >=20
> > > > or if that syscon node should just have the #clock-cells property as
> > > > part of the node instead.
> > >=20
> > > This is not match the hardware I think. The pll area is on the middle
> > > of the syscon and is hard to be separated as a subdevice of the syscon
> > > or just add  "#clock-cells" to the syscon device. It is better to han=
dle
> > > them in one device/driver. So let the clock device reference it.
> >=20
> > This happens all the time. We don't need a syscon for that unless the
> > registers for the pll are both inside the syscon and in the register
> > space 0x50002000. Is that the case?=20
>=20
> Yes, the clock has two areas, one in the clk controller and one in
> the syscon, the vendor said this design is a heritage from other SoC.

My question is more if the PLL clk_ops need to access both the syscon
register range and the clk controller register range. What part of the
PLL clk_ops needs to access the clk controller at 0x50002000?

>=20
> > This looks like you want there to be  one node for clks on the system
> > because logically that is clean, when the reality is that there is a
> > PLL block exposed in the syscon (someone forgot to put it in the clk
> > controller?) and a non-PLL block for the other clks.
>=20
> That is true, I prefer to keep clean and make less mistakes. Although
> the PLL is exposed in the syscon, the pll need to be tight with other
> clocks in the space 0x50002000 (especially between the PLL and mux).
> In this view, it is more like a mistake made by the hardware design.
> And I prefer not to add a subnode for the syscon.

Ok. You wouldn't add a subnode for the syscon. You would just have
#clock-cells in that syscon node and register an auxiliary device to
provide the PLL(s) from there. Then in drivers/clk we would have an
auxiliary driver that uses a regmap or gets an iomem pointer from the
parent device somehow so that we can logically put the PLL code in
drivers/clk while having one node in DT for the "miscellaneous register
area" where the hardware engineer had to expose the PLL control to
software.

