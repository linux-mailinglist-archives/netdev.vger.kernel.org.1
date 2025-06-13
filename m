Return-Path: <netdev+bounces-197308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5314CAD80C7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A7B3B38A8
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3641D5CC6;
	Fri, 13 Jun 2025 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZWQdhMxB"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3281A01B9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780411; cv=none; b=iuMZKlFnKJGJ2W0na5QdVim8QTlW4ca6e1atTLh/QLoBS6aDdrLpVsNowSKehfIz5iwgKyteBpoNNMVIpDQaceqxUEwJhlFBKY3gQHpzWXhUyD5aKNxoiaZEPJzvyiUVryF/hK8wT7Xd9e7jKbQsMSJhV57RLbVELYhPklr8v0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780411; c=relaxed/simple;
	bh=nCxKwbZk4e1A1IebS659hmsoseH4KT29iPS1HkLVXXE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QViIK4Q0CLdbVxA0bHJx1Q2d3m7zXWLGodtWdTmpk7EcW3DSyZGkrWJrECcRL4kr6CnLySEWm1698Vj8fWj28y5bjQaLVIBEe9UCiy9/oZl7qNC8MVi0cKlZwyJqsPnsT+GLESqTfs5/1DXbrTOavMNIuJjL+TEzgeSYpy5A3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZWQdhMxB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749780407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1hLQZrnvipPz+3ANyt0Y2ORYvaf1oK6TEmtgPjNftQ=;
	b=ZWQdhMxBz57PYxRverZ/XRcz6H+dQXt7NKN9SaTlFGJhoWD4jfvwxj6X+zJKrAyWbB+SA+
	vi/v3h8YQA3YqNin1MBts/UKWsfmcyXTDBjquOHqqLy8Auo6ekiXI06v1yOMkEyOyxIbYn
	H6rgxpz18e6WBJkXXXYVt8j+63/0zfE=
Date: Fri, 13 Jun 2025 02:06:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <2d5322bce3f450da329e5e146bf0a850afa55fe4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH RESEND net-next v2] net: phy: Add c45_phy_ids sysfs
 directory entry
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <737294c1-258f-4780-80f8-e7a72e887f8b@lunn.ch>
References: <20250612143532.4689-1-yajun.deng@linux.dev>
 <737294c1-258f-4780-80f8-e7a72e887f8b@lunn.ch>
X-Migadu-Flow: FLOW_OUT

June 12, 2025 at 11:31 PM, "Andrew Lunn" <andrew@lunn.ch> wrote:



>=20
>=20>=20
>=20> +#define MMD_INDICES \
> >=20
>=20>  + _(1) _(2) _(3) _(4) _(5) _(6) _(7) _(8) \
> >=20
>=20>  + _(9) _(10) _(11) _(12) _(13) _(14) _(15) _(16) \
> >=20
>=20>  + _(17) _(18) _(19) _(20) _(21) _(22) _(23) _(24) \
> >=20
>=20>  + _(25) _(26) _(27) _(28) _(29) _(30) _(31)
> >=20
>=20
> Is 0 not valid?
>=20

Yes,=20the MMD starts at 1. See "include/uapi/linux/mdio.h".

> >=20
>=20> +#define MMD_DEVICE_ID_ATTR(n) \
> >=20
>=20>  +static ssize_t mmd##n##_device_id_show(struct device *dev, \
> >=20
>=20>  + struct device_attribute *attr, char *buf) \
> >=20
>=20>  +{ \
> >=20
>=20>  + struct phy_device *phydev =3D to_phy_device(dev); \
> >=20
>=20>  + return sysfs_emit(buf, "0x%.8lx\n", \
> >=20
>=20>  + (unsigned long)phydev->c45_ids.device_ids[n]); \
> >=20
>=20>  +} \
> >=20
>=20>  +static DEVICE_ATTR_RO(mmd##n##_device_id)
> >=20
>=20
> This macro magic i can follow, you see this quite a bit in the kernel.
>=20

Okay.

>=20>=20
>=20> +
> >=20
>=20>  +#define _(x) MMD_DEVICE_ID_ATTR(x);
> >=20
>=20>  +MMD_INDICES
> >=20
>=20>  +#undef _
> >=20
>=20>  +
> >=20
>=20>  +static struct attribute *phy_mmd_attrs[] =3D {
> >=20
>=20>  + #define _(x) &dev_attr_mmd##x##_device_id.attr,
> >=20
>=20>  + MMD_INDICES
> >=20
>=20>  + #undef _
> >=20
>=20>  + NULL
> >=20
>=20>  +};
> >=20
>=20
> If i squint at this enough, i can work it out, but generally a much
>=20
>=20more readable KISS approach is taken, of just invoking a macro 32
>=20
>=20times. See mdio_bus.c as an example.
>=20

Okay.

>=20 Andrew
>=20
>=20---
>=20
>=20pw-bot: cr
>

