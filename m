Return-Path: <netdev+bounces-194103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC463AC757F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 03:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D061C0416A
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD31F0992;
	Thu, 29 May 2025 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YRn0t6qL"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0115A864
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483533; cv=none; b=ay1g6Zz0RDVYUZNzalTGsfvwHZtGQWW0iUSnvhmJgXQw4qIg5QZ9GV7rFjtcpdLhBw5AXAYOv/8B9Ey5mey0ePedYqSnHaJp22qFYB0lMh6oThJSQvaKPBT6A2p4SjpW5XRLM/wtrDBGMPgBrhs39jfI2WyZpc8YKyx1QqIX21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483533; c=relaxed/simple;
	bh=NpGkXL3Nr6+ks4o4P8EZCIeIM8tZfmIn7LlJLd9LAKw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=MVwu6F6C2ITuXcsQnOKHpcTCpRzazYeJe++TUEpwIdfIuapi78ZNs0bexpIoDfadehhpyXETMA7VOGx4X5KDhhUjAVLTmbZeLuMN9UcEjLqqB6YEYuUK+1RZSSKaT284aoUOAu32ouL1kLGbfmJTqPvWr2Q3ZYYtUZczOdwwRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YRn0t6qL; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748483518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj3nEQac8SumyTQbWqu5/Mtr9p89fKny4Ga+HbmaXtg=;
	b=YRn0t6qLAK7GzmX+dNGMBATUCVmLs6cB8WOZMyXOfR8oGnbXXhG2ydP0hnla+O32JR4ooD
	3Ep+8Z0kPgg6j87c/bZQR77M2pkGG1sWg7mT449qiE8z9l2xlpsybo6UEZEPRJXRjbTUaj
	WOenTWrFEFkXIlW2ve9+KW8NUR5WCYg=
Date: Thu, 29 May 2025 01:51:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <5e2c874d31392800255b86fbbd4d1174306f1c28@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Andrew Lunn" <andrew@lunn.ch>, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aDcKvwDaa6_1gZY7@shell.armlinux.org.uk>
References: <20250523132606.2814-1-yajun.deng@linux.dev>
 <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
 <fad26dc95cbe08a87b30d98a55b7e3d987683589@linux.dev>
 <aDQkLcfeu8zw8CJ_@shell.armlinux.org.uk>
 <552f550315dc503250cc61fdcd13db38c1ea00f5@linux.dev>
 <aDcKvwDaa6_1gZY7@shell.armlinux.org.uk>
X-Migadu-Flow: FLOW_OUT

May 28, 2025 at 9:08 PM, "Russell King (Oracle)" <linux@armlinux.org.uk> =
wrote:



>=20
>=20On Mon, May 26, 2025 at 08:52:12AM +0000, Yajun Deng wrote:
>=20
>=20>=20
>=20> May 26, 2025 at 4:19 PM, "Russell King (Oracle)" <linux@armlinux.or=
g.uk> wrote:
> >=20
>=20>  On Mon, May 26, 2025 at 08:11:21AM +0000, Yajun Deng wrote:
> >=20
>=20>  > $ ls /sys/class/net/eth0/phydev/c45_phy_ids
> >=20
>=20>  >=20
>=20>=20
>=20>  > mmd10_device_id mmd17_device_id mmd23_device_id mmd2_device_id m=
md7_device_id
> >=20
>=20>  >=20
>=20>=20
>=20>  > mmd11_device_id mmd18_device_id mmd24_device_id mmd30_device_id =
mmd8_device_id
> >=20
>=20>  >=20
>=20>=20
>=20>  > mmd12_device_id mmd19_device_id mmd25_device_id mmd31_device_id =
mmd9_device_id
> >=20
>=20>  >=20
>=20>=20
>=20>  > mmd13_device_id mmd1_device_id mmd26_device_id mmd3_device_id
> >=20
>=20>  >=20
>=20>=20
>=20>  > mmd14_device_id mmd20_device_id mmd27_device_id mmd4_device_id
> >=20
>=20>  >=20
>=20>=20
>=20>  > mmd15_device_id mmd21_device_id mmd28_device_id mmd5_device_id
> >=20
>=20>  >=20
>=20>=20
>=20>  > mmd16_device_id mmd22_device_id mmd29_device_id mmd6_device_id
> >=20
>=20>  >=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  I suspect you don't have a PHY that defines all these IDs. Are you=
 sure
> >=20
>=20>=20=20
>=20>=20
>=20>  your .is_visible() is working properly?
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  I'm just determining if it's a c45 device and not filtering PHY ID=
 content now.
> >=20
>=20>  I can add this condition.
> >=20
>=20
> I'm talking about listing all 31 entries, whether they're implemented i=
n
>=20
>=20the PHY or not. Look at mmds_present in struct phy_c45_device_ids to
>=20
>=20determine which IDs should be exported as well as checking whether th=
e
>=20
>=20ID value you're exporting is not 0 or ~0.
>=20

I've=20already sent v2. Please review it.

> --=20
>=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>=20
>=20FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>

