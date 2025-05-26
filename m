Return-Path: <netdev+bounces-193393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14162AC3C13
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BE67AAB20
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134C1EA7CE;
	Mon, 26 May 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tMjbSCfB"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A21D799D
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249543; cv=none; b=jmgxK423CnOqeU5sJSJPvw2D7LQ5LXxkx/va7QOpw8V5utcNAIx+HBknWamMlwkUkbMDj0h7zVN8nMWZzoTHBgbV4oztGtfKDem5gOk09oAcFgKRiUS+GYewtUm1kM/cMWxG1071MrQ3dmF88v1QLncJtdW7UmANpioawEJdyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249543; c=relaxed/simple;
	bh=M+bGXnFCRXVHeFCtbYzsS97i8k7WsHr3F3WvzvxukKQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=OmkfbwZyEPhCyjDxjvT75UNxWwsDtMqDKbJ6JSEP+xuL2H71utAfFUcqttvtmf6gr3tGFTyTTKQMOi7dsu5NNX/r9ZnzCJwCmhLz6n+o+JC9192KHVu546SlY3C3qXcQGc93oB2J8eIZ9y9BJUq/bKLNYzd5WBvQ4HT1JV65DkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tMjbSCfB; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748249535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CYXQfHMRVpFS4CUQUzSRarfKIEBSPUbPS3dEjTNyoo=;
	b=tMjbSCfBJZAn1eUgzUyAC65QXJkT3bAsv9K3AivPB2mcjtoen6MnPHX4ciPsM/Vby04RlN
	ZDEaCEBg6XpJqiZOQdTILwDn3aBz7P4Tc05qBvTgxO3P7pWKC6V+Pe+iFOBUJCDfoiP/Vj
	XejAK3vE+Q1AiIsjwU9xnYPVj/Nf5tk=
Date: Mon, 26 May 2025 08:52:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <552f550315dc503250cc61fdcd13db38c1ea00f5@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Andrew Lunn" <andrew@lunn.ch>, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aDQkLcfeu8zw8CJ_@shell.armlinux.org.uk>
References: <20250523132606.2814-1-yajun.deng@linux.dev>
 <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
 <fad26dc95cbe08a87b30d98a55b7e3d987683589@linux.dev>
 <aDQkLcfeu8zw8CJ_@shell.armlinux.org.uk>
X-Migadu-Flow: FLOW_OUT

May 26, 2025 at 4:19 PM, "Russell King (Oracle)" <linux@armlinux.org.uk> =
wrote:



>=20
>=20On Mon, May 26, 2025 at 08:11:21AM +0000, Yajun Deng wrote:
>=20
>=20>=20
>=20> c45 device:
> >=20
>=20>  $ ls /sys/class/net/eth0/phydev/
> >=20
>=20>  attached_dev driver of_node phy_id power subsystem
> >=20
>=20>  c45_phy_ids hwmon phy_has_fixups phy_interface statistics uevent
> >=20
>=20>=20=20
>=20>=20
>=20>  $ ls /sys/class/net/eth0/phydev/c45_phy_ids
> >=20
>=20>  mmd10_device_id mmd17_device_id mmd23_device_id mmd2_device_id mmd=
7_device_id
> >=20
>=20>  mmd11_device_id mmd18_device_id mmd24_device_id mmd30_device_id mm=
d8_device_id
> >=20
>=20>  mmd12_device_id mmd19_device_id mmd25_device_id mmd31_device_id mm=
d9_device_id
> >=20
>=20>  mmd13_device_id mmd1_device_id mmd26_device_id mmd3_device_id
> >=20
>=20>  mmd14_device_id mmd20_device_id mmd27_device_id mmd4_device_id
> >=20
>=20>  mmd15_device_id mmd21_device_id mmd28_device_id mmd5_device_id
> >=20
>=20>  mmd16_device_id mmd22_device_id mmd29_device_id mmd6_device_id
> >=20
>=20
> I suspect you don't have a PHY that defines all these IDs. Are you sure
>=20
>=20your .is_visible() is working properly?
>=20

I'm=20just determining if it's a c45 device and not filtering PHY ID cont=
ent now.
I can add this condition.=20


But=20the 'c45_phy_ids' directory could not be hidden if it's a c22 devic=
e.
If c45_phy_ids is a file and it has an array of values. We can hide this
file even if it's a c22 device.


> --=20
>=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>=20
>=20FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>

