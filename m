Return-Path: <netdev+bounces-228437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B8BCAD5C
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 22:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0186B4EB821
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B727381B;
	Thu,  9 Oct 2025 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="a1mEsrWo"
X-Original-To: netdev@vger.kernel.org
Received: from out14.tophost.ch (out14.tophost.ch [46.232.182.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968326F28B;
	Thu,  9 Oct 2025 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043023; cv=none; b=BHLOShrtDi2k2qpUpxs+KBYKCeU60aNQHZUs1o5E+wQ38iwvhR5c9x8roYr1YuO1QPx3GUbpM8N9b4Woz2mzMV82bRQ6y7H0euWCLiDDMO+NY/zoQqaVZ+A8ZdMPfHDLI77gZncM/n2A+Bw9/rRHwkziUQ74bs7+qob3jkNUfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043023; c=relaxed/simple;
	bh=h7C8bbH7FTsJm/m6VuuDxPp60Ab4hcjl9IC2Mx8oSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEJQ18x5zWdSgPhbtJG4QuEyB0tVOUKcDKEvBJl/J54LgoBLWJGhFKG9z3tLLYQsaH8YlnO7OUV8s/fOUUsAU52dE29cfok5uoi7QGuv6h8NTl0b0KJwkrT9cZuxuvmvEFcfDp4UG9vbcJa2SEkS+xR/Tdl7wPhtHirQ0y6v3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=a1mEsrWo; arc=none smtp.client-ip=46.232.182.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter3.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v6xK6-00EmFi-9Q; Thu, 09 Oct 2025 22:33:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=r+FQKIahc4AdcTu9MP/YjPLvJqAErAgW2W1JFVZbD+0=; b=a1mEsrWo4avpTkrhSImsB5UGm4
	N5yv8KrVx/bwIrUIo99WxMp0TJJoJNvJzG7PBqUmfXM0NG6qTH1BqA3iwo70QX8c6PWirlQNJdHPd
	GeSil43TtrWcV1KyOWJgb6v8qaBTytMER+gknEgOHn3Rfc65qQoUBlOPqVOzbYrH5DJo/EskQD10w
	TKExlEi2D7xnC12cmCr7W459SOMo72PorS2/8tde3fOHpqIz4kK1m2hbQHqzTDWfmHAbLj6F0vSA+
	I4YnYgIC0B/ICz9kJ0GKvMf8k4jTekv3epFZlQqzBlVU73V3ksi4KjfAa09FZUyVsosRc7CCFt9a7
	4Y6QPS6w==;
Received: from [213.55.187.112] (port=29561 helo=pavilion)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v6xK6-0000000Bolp-3cxo;
	Thu, 09 Oct 2025 22:33:12 +0200
Date: Thu, 9 Oct 2025 22:33:02 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <20251009223302.306e036a@pavilion>
In-Reply-To: <e14c6932-efc9-4bf2-a07b-6bbb56d7ffbd@lunn.ch>
References: <20251004180351.118779-2-thomas@wismer.xyz>
	<20251004180351.118779-8-thomas@wismer.xyz>
	<20251007-stipulate-replace-1be954b0e7d2@spud>
	<20251008135243.22a908ec@pavilion>
	<e14c6932-efc9-4bf2-a07b-6bbb56d7ffbd@lunn.ch>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV5syPzpWv16mXo6WqDDpKEChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zCvB
 nHFO2C20Agb2jY8TN+tZAgLCw6A7Sh9BwFiRtflYCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wddIY3ooDH3xmALJ0KCcsszI9W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoaa3aob+2ep/i3+axOc3wuNrBFopv3W0A/6jdtvQFsFcEZ6r1mIX
 TkUcixE/iazZc2YO2mSYszIDlxkwEZ8fnuR7LXwCeCXaZcCIsMJ2o/2ujxmhezcbEYEnpDmAcTfE
 51BQLRIJ0/39Sx8paaNvJtgjTd22pIMOV6MGf1IoEnGcoojFFzGYcVBOELIFSPRcJvCCGRwzGhIB
 n8K8QObBEcFy1rHCr/p9+O1cMFuPCw8Rw9bimy3J24SMAfwTPM20rmcIMnYyRa+Bc9vTSIXNo6NG
 jc0E8ca/vyZdGzimB4971HTxt1KgeGT0AYbCA9JcYz9+MmwS2ESJ9FbsMjQvPUE4US07ML7bZl3B
 4ELDaI1Br8bNxUUhGgM9iMk00Ol1lR+PUJGNrv8YmVULgw8ynq3PwqXDlE/GOTxn2uh+ba1iSzzB
 zDg3BItzbKnXDzHjtYwak50DLeVtBir2eUz0vtJvzgRrucRkwUB/zcu0o0WjWBsS3EZt9a+xyS/d
 Oq7TUhP+6w9smK/hg5o9u16qyIzlag+DgD9xY7Yj7fvC65xWAU3TJceJXG+jXar6FtDTl0oJdoJl
 7aEINilYsbM6oAZrC6sT/uNPEeEqTef/Ol/iIK/1NH5THMtlYvyHAYGOGmt9snL6N2Lurj43vXKI
 A3wrdQGYbD42gELmInj8QJZkozR5O9XsbZeBMYvhp9yUjVB76PAdPOZc5pCcLmx6HKVOK2srP1V3
 FBjQKvmhoLnK6kP1PdPHwcRpK1Jfq8KXZJCOHPPfveAz91ASJF2pOtB5TU55xiswakgM5lOd+GWz
 5IE7WyBl+BpLY+3NgjjaJatsJHAzgC46MYYXOcKJkR7v8ULU8lsSL+ZtOiP52Ihta1zoSEKZCyqy
 2ggLPoY1IxZ8QhrAYAPpA+rFW/t09L+dJR8RoVtd/HdiZZXcS7V1ZXBi9hWEAP02Kq9O1EK/TUyG
 hPICNC2zTh4DKhoaqzbtHxt9xuMG1/ohztXDro3vjaZ+6AQSCtYoWH/x+cNDkrnpHUIpm7ZLrjsD
 ZQ6GNZpocet31KkgQlKZh9NdH2SPoVBq1Qsh973/NcIMY8uCXoCtFMTxqJ/9ILpZImF31Vkhp7tU
 3Sz1xIwbpb/q5AsF
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

Am Wed, 8 Oct 2025 14:38:52 +0200
schrieb Andrew Lunn <andrew@lunn.ch>:

> On Wed, Oct 08, 2025 at 01:52:43PM +0200, Thomas Wismer wrote:
> > Am Tue, 7 Oct 2025 21:40:03 +0100
> > schrieb Conor Dooley <conor@kernel.org>:
> >   
> > > On Sat, Oct 04, 2025 at 08:03:53PM +0200, Thomas Wismer wrote:  
> > > > From: Thomas Wismer <thomas.wismer@scs.ch>
> > > > 
> > > > Add the TPS23881B I2C power sourcing equipment controller to the
> > > > list of supported devices.    
> > > 
> > > Missing an explanation for why a fallback compatible is not
> > > suitable here. Seems like it is, if the only difference is that
> > > the firmware is not required to be refreshed, provided that
> > > loading the non-B firmware on a B device would not be
> > > problematic.  
> > 
> > Loading the non-B firmware on a B device is indeed problematic. I'll
> > append the following paragraph to the patch when reposting it after
> > the current merge window has closed.  
> 
> Is it possible to ask the device what it is?

Yes, the devices allow the silicon revision to be read, which would
enable a driver to correctly handle the case distinctions.

> If you can, maybe you don't even need a new compatible, just load the
> appropriate firmware depending on what the device says it is.

When adapting the driver, I also considered an auto-detection mechanism.
However, it felt safer to rely on the devicetree information than reading
a silicon revision register, which has a totally different meaning on
some other device. I have therefore decided to make the driver behaviour
solely dependent on the devicetree information and to use the silicon
revision only as a sanity check (as already implemented in the driver).
Is there any best practice when to use auto-detection with I2C devices?

Regardless of whether the driver queries the silicon revision, the B
device declaration would look somehow strange to me with a driver having
one single compatible, i.e. compatible = "ti,tps23881b", "ti,tps23881".
The first one specifically names the hardware, the fallback is actually
the name of its predecessor, which is strictly speaking not 100%
compatible but required to have the driver loaded.

