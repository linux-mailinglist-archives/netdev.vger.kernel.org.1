Return-Path: <netdev+bounces-193379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE65AC3B36
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E801174586
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893F71E520C;
	Mon, 26 May 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NwymsCZ4"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102773595E
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247097; cv=none; b=m0KscbNDXr6G02fMgFIoXFd8qZ2xItkuDLObSXkgzuMY+VtSVAvtw0qPbSVa9X2YLyVJfNjCff8tU+Bc1CpS3tac+9L8hWbQ3M7g6KBTQObIiqsfLhP/KcGOn9H+GSovGs4aVcdMksqP+uiZ7N8H1FT/oMgxhudXkdM4rSeVHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247097; c=relaxed/simple;
	bh=SMANpNFuTSfNaRqYgZhkf6SopH9aDDfivDb5cru5GU4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=mMeMhI3QqnN1GbZhfjO6xoqepsVOMwiuJMCzZjPMgIGgn9w8X008GDUzMJmhQoone8KKDIo+DYVIlczXLM7ip5xhN1FZ3LZQntVLFSNha/ULDUFwOuws3xYTA6KJebOGsSFEzC/zNVBEKXmG9PzkRgPHAZyyaY/ra5Wfe8lbA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NwymsCZ4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748247082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2R13Ebv4F2pxOEGG5K0h8rA8GFvT2XDnU+7l2xRuSo=;
	b=NwymsCZ4pbPB1sXcEso4ZFoqU2vQF7drBm1N0vl/NxTIxRYq6naoHD3V6WHQbOzVpBej38
	9mvghyT1zleU9+VNnyUq17QlnFqmruMvXc5LcNzFcw/jMm1iW90FJ9396/z90tFUysU2Ya
	d6LWwP0uORCfyVCOV++iVnp8SnJZmEQ=
Date: Mon, 26 May 2025 08:11:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <fad26dc95cbe08a87b30d98a55b7e3d987683589@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
References: <20250523132606.2814-1-yajun.deng@linux.dev>
 <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
X-Migadu-Flow: FLOW_OUT

May 23, 2025 at 9:55 PM, "Andrew Lunn" <andrew@lunn.ch> wrote:



>=20
>=20>=20
>=20> +What: /sys/class/mdio_bus/<bus>/<device>/c45_phy_ids
> >=20
>=20>  +Date: May 2025
> >=20
>=20>  +KernelVersion: 6.16
> >=20
>=20>  +Contact: netdev@vger.kernel.org
> >=20
>=20>  +Description:
> >=20
>=20>  + This attribute contains the 32-bit PHY Identifier as reported
> >=20
>=20>  + by the device during bus enumeration, encoded in hexadecimal.
> >=20
>=20>  + These C45 IDs are used to match the device with the appropriate
> >=20
>=20>  + driver.
> >=20
>=20
> https://docs.kernel.org/filesystems/sysfs.html#attributes
>=20
>=20 Attributes should be ASCII text files, preferably with only one
>=20
>=20 value per file. It is noted that it may not be efficient to contain
>=20
>=20 only one value per file, so it is socially acceptable to express an
>=20
>=20 array of values of the same type.
>=20
>=20These are static values, so efficiency is not an issue.
>=20
>=20It might be better to have a directory
>=20
>=20/sys/class/mdio_bus/<bus>/<device>/c45_phy_ids and then for each MMD
>=20
>=20create a file. I would also suggest using is_visible() =3D=3D 0 for t=
hose
>=20
>=20with an ID =3D=3D 0.
>=20

is_visible=20only hide files, not directory. It will look like this:

c45 device:
$ ls /sys/class/net/eth0/phydev/
attached_dev  driver  of_node         phy_id         power       subsyste=
m
c45_phy_ids   hwmon   phy_has_fixups  phy_interface  statistics  uevent

$ ls /sys/class/net/eth0/phydev/c45_phy_ids
mmd10_device_id  mmd17_device_id  mmd23_device_id  mmd2_device_id   mmd7_=
device_id
mmd11_device_id  mmd18_device_id  mmd24_device_id  mmd30_device_id  mmd8_=
device_id
mmd12_device_id  mmd19_device_id  mmd25_device_id  mmd31_device_id  mmd9_=
device_id
mmd13_device_id  mmd1_device_id   mmd26_device_id  mmd3_device_id
mmd14_device_id  mmd20_device_id  mmd27_device_id  mmd4_device_id
mmd15_device_id  mmd21_device_id  mmd28_device_id  mmd5_device_id
mmd16_device_id  mmd22_device_id  mmd29_device_id  mmd6_device_id


c22 device:
$ ls /sys/class/net/eth0/phydev/
attached_dev  driver  of_node         phy_id         power       subsyste=
m
c45_phy_ids   hwmon   phy_has_fixups  phy_interface  statistics  uevent

$ ls /sys/class/net/eth0/phydev/c45_phy_ids


So is that fine?=20

>=20 Andrew
>

