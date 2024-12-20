Return-Path: <netdev+bounces-153539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A49F8990
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124971885706
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD72594AE;
	Fri, 20 Dec 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cX/UkfXj"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BD259497
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734658449; cv=none; b=MPDlPLnf/S/eFEYRKd49cx3QDX788pCbfxRZuxpim4Ehozbly33tq+LyMRfGLZ5ynzjqU+uJk08NjzergYlCelcEBYbLPLjnyVCNunkLMx74HQjOuxVI+SekHp6+BEADK9aQ1JOIVD1SIk/4p/rVsYyQCu40A4kqK5Q9fewV130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734658449; c=relaxed/simple;
	bh=WU9SX61oilyzAPKKxaHpZ7IaIVhXMkvbS+IUVw6Eo38=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=oRgTTHzjLHYPONB2WQzJwOU5VAk3IP2qJ30AIMH6LmM0re4EjTZrPvqPNS0N6SCZdexyjcjhWa6YxCrCIoc61YNXc3DBHRYgtL0rxCPKjFofilAmm3Y04DaxvPNbjYvNIYaY9ilniaI413xTbY/k33yX/vWotLozHjYxfO1ngfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cX/UkfXj; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734658443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BomEA7lvJnvVYAFn67tkqTGATCMBN+1ck92UY7i1ISA=;
	b=cX/UkfXjB3jS8oNf09reoHD7oXnb0UbxDfW7jWD2obht3YViq/N67WDtK99hLvkPuV6DzU
	HbVm4YxYpFbOW4YGmXj3Oj9Ivdnejq2sqzEdcemaAYF0O5E5v4RguEuqbbgkZ7lQsNOyR8
	Tc3bQs3nJBv60UvZPbgFLy6bDaVMT+0=
Date: Fri, 20 Dec 2024 01:34:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <c35f6cd71fcf782e0333b8cc4cabb6d65812f134@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v2] net: mdio_bus: change the bus name to mdio
To: "Florian Fainelli" <f.fainelli@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <40cbb576-edd9-40c1-8f7a-8dd6dfa5d7ed@gmail.com>
References: <20241219100454.1623211-1-yajun.deng@linux.dev>
 <f062d436-5448-418a-9969-f1c368e10f8c@lunn.ch>
 <40cbb576-edd9-40c1-8f7a-8dd6dfa5d7ed@gmail.com>
X-Migadu-Flow: FLOW_OUT

December 20, 2024 at 12:52 AM, "Florian Fainelli" <f.fainelli@gmail.com> =
wrote:



>=20
>=20On 12/19/24 02:20, Andrew Lunn wrote:
>=20
>=20>=20
>=20> On Thu, Dec 19, 2024 at 06:04:54PM +0800, Yajun Deng wrote:
> >=20
>=20> >=20
>=20> > Since all directories under the /sys/bus are bus, we don't need t=
o add a
> > >=20
>=20> >  bus suffix to mdio.
> > >=20
>=20> >  This is the only one directory with the bus suffix, sysfs-bus-md=
io is
> > >=20
>=20> >  now a testing ABI, and didn't have Users in it. This is the time=
 to change
> > >=20
>=20> >  it before it's moved to the stable ABI.
> > >=20
>=20>=20
>=20>  So are you saying nobody has udev scripts referencing MDIO devices=
?
> >=20
>=20>  Nobody has scripts accessing the statistics? You don't expect anyt=
hing
> >=20
>=20>  in userspace to break because of this change?
> >=20
>=20>  I personally think it is too late to change this, something will b=
reak
> >=20
>=20>  and somebody will report a regression.
> >=20
>=20
> It is too late, merging this patch would be breaking ABI and that is no=
t acceptable.
>=20

Okay,=20I got it.

> -- Florian
>

