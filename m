Return-Path: <netdev+bounces-116925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8594C192
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156AA1F233D4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9930218F2D3;
	Thu,  8 Aug 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op7JQOvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533FB674
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131449; cv=none; b=qvUikRJ/F0w68L8C69yZJEqrNfuQz5oMeiIovFMe5pp0KzjdkAUCvIr3IFeOoboWE/W+kXx5GrYy2FbMrGmYSQj4bJOQeuxfzYigLl8DzWUkGclQ7mX3T+jY8+fQNhyHFh4nIf8mG1mdSd2CwMguF4g6fPcoIE3mLcODL+LraMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131449; c=relaxed/simple;
	bh=AQvbE+qltR32Xj76N7YS7xp+vf1RLAezWd3GXaVnyK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbJgYMzQ6Pv7k0ugfCuRosvbmk1XGK9DUWGA3ITOXnYkOIsjNQ+GUBCHrMpbGx0+BaoU9loI5e4NnZCd57pBtejpO5K/gQ9BLAmqD6qJwVBHAIJMMg5MBq5sN1JL1Ux9VdHCdrDC/WL3tPHWsHgaTOUmm9FNxll5FICCsgTXyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op7JQOvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE4AC32786;
	Thu,  8 Aug 2024 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131449;
	bh=AQvbE+qltR32Xj76N7YS7xp+vf1RLAezWd3GXaVnyK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=op7JQOvbWVtbgrWGwZyopRXLo170Ghgbpf3mt1tJm96Jb+//6mhX3x1gvlZpPDmge
	 q+nOk+HJgpGBBVDhxacGHDX498o88YdZgdq9bypdYpagYgLZNacaOKp0v5Tsqom9HO
	 UpaMPqGDxq4lT/gosBS6MKXl4J04cMTlpOeng08hjGTwoygT3739TY2OO61ty+6o+E
	 rW/RzaCmvSctrvKb2ty+Wx+6FFH9bvMRYqzwEuDhmx19OqabtIj2IRc5WjdwQXOcu6
	 dhpMD4DVcjmXdfQiyf4SNt3GcMCAXlSONH0IQa2gajB/iaI9I6MzFDAooQ1iDwXU+t
	 iRgjMIwlw9wyw==
Date: Thu, 8 Aug 2024 08:37:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: 'Guanjun' <guanjun@linux.alibaba.com>
Cc: kyle.swenson@est.tech, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net: pse-pd: tps23881: Fix the compiler
 error about implicit declaration of function =?UTF-8?B?4oCYRklFTERfR0VU?=
 =?UTF-8?B?4oCZ?=
Message-ID: <20240808083727.43cd0063@kernel.org>
In-Reply-To: <20240807071538.569784-1-guanjun@linux.alibaba.com>
References: <20240807071538.569784-1-guanjun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  7 Aug 2024 15:15:38 +0800 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
>=20
> bitfield.h is not explicitly included but it is required for FIELD_GET.
> There will be a compiler error:
>   drivers/net/pse-pd/tps23881.c: In function =E2=80=98tps23881_i2c_probe=
=E2=80=99:
>   drivers/net/pse-pd/tps23881.c:755:6: error: implicit declaration of fun=
ction =E2=80=98FIELD_GET=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>     755 |  if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) !=3D TPS23881_DEVI=
CE_ID) {
>         |      ^~~~~~~~~
>   cc1: some warnings being treated as errors
>=20
> Fixes: 89108cb5c285 (net: pse-pd: tps23881: Fix the device ID check)
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> ---
>  drivers/net/pse-pd/tps23881.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
> index f90db758554b..fa947e30e2ba 100644
> --- a/drivers/net/pse-pd/tps23881.c
> +++ b/drivers/net/pse-pd/tps23881.c
> @@ -10,6 +10,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/bitfield.h>
>  #include <linux/platform_device.h>
>  #include <linux/pse-pd/pse.h>
> =20

There was another fix posted shortly after which seems better:

https://lore.kernel.org/r/20240807075455.2055224-1-arnd@kernel.org/

