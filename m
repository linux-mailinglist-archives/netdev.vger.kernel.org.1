Return-Path: <netdev+bounces-192912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A8AC19F3
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 04:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CD5501CE5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A21D516F;
	Fri, 23 May 2025 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDtKIzvi"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3A2DCBE6
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747966207; cv=none; b=Cqixbasny8Mixz+CqQHHPHzkHd0R+sfrDvgMJW/3zuVpUUxf5Mvj3Z0fLdC47lSAsDTfZjl+QsvkJcYmEu3EBZjnRgxM/8+W8HwItn7pR3WNRlEONe3CD0KKL2Lup8HkaQOpnwxi9ZA6n0gEaYo0axcqlg6OWtxSaDs5gyUoiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747966207; c=relaxed/simple;
	bh=TNqXOnWcNIfiMgfEiDsYoNFb3ECDDi/KmP9vNAXFGy0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=BxHWpSowe2nBt1zdhbgkSZIMSOSkjBo0lrR6Gm5QO0irlibcDgiqoelclYr/xjvy5ScRAQq/ZwPtWlTnvS+gC99WJLSTm+ZxYNI/M3IppgrUzsiqnJXQE0zsVVKUWWlaKqcosoLmGMNkeI1miNARJ7CM1oh3y8VmYJzF20n73IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDtKIzvi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747966202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEWWkt48ZgSDB2keCSx6Ca4Ps/tea7MKBqhomnRjgFE=;
	b=dDtKIzviT8cK0DuET6TktszFCSVjG5GV2tRBaH7RWThifU5uCYrEFogvETCKsjd4ToKS9P
	jjFqxyl1cMKnZ1aqluCLQKm9ERyx4SqHD3VTrpNsbK0KPJQ8kyGjNyA+GpOMxXkoydBmLu
	ND8p0w57UvNLvGCc594fNF46vdSURDQ=
Date: Fri, 23 May 2025 02:10:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <5d16e7c3201df22074019574d947dab1b5934b87@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <831a5923-5946-457e-8ff6-e92c8a0818fd@lunn.ch>
References: <20250522131918.31454-1-yajun.deng@linux.dev>
 <831a5923-5946-457e-8ff6-e92c8a0818fd@lunn.ch>
X-Migadu-Flow: FLOW_OUT

May 22, 2025 at 9:39 PM, "Andrew Lunn" <andrew@lunn.ch> wrote:



>=20
>=20On Thu, May 22, 2025 at 09:19:18PM +0800, Yajun Deng wrote:
>=20
>=20>=20
>=20> The phy_id_show() function emit the phy_id for the phy device. If t=
he phy
> >=20
>=20>  device is a c45 device, the phy_id is empty. In other words, phy_i=
d_show()
> >=20
>=20>  only works with the c22 device.
> >=20
>=20>=20=20
>=20>=20
>=20>  Synchronize c45_ids to phy_id, phy_id_show() will work with both t=
he c22
> >=20
>=20>  and c45 devices.
> >=20
>=20
> First off, they are different things. A device can have both a C22 and
>=20
>=20a collection of C45 IDs. So they should not be mixed up in one sysfs
>=20
>=20attribute.

In get_phy_device(), only one of get_phy_c45_ids() or get_phy_c22_id()
is called. Even if a device has both a c22 and c45 IDs, only one of the
phy_id and the c45_ids has values.

>=20
>=20The second point has already been made by Russell, there are lots of
>=20
>=20different C45 IDs, and phylib will try to find a driver based on any
>=20
>=20of them.

I noticed that. I tested the BCM89890, 88X3310 and 88Q2110 PHY devices,
and the ID is always the same in different MMDs.

>=20
>=20If you want to export the C45 IDs, please think about adding new sysf=
s
>=20
>=20attributes.
>=20

Okay.

>=20 Andrew
>

