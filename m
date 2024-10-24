Return-Path: <netdev+bounces-138753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BBD9AEC44
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D911C24A95
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F7B1F81B8;
	Thu, 24 Oct 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le1LiewZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C091F81B2;
	Thu, 24 Oct 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787672; cv=none; b=YY/K9FW6zFOuluTWPg/Z6t3jwd8W3qZhw+Ve0bXSWGzNuT+9pMAd+q7fP0BnFjhVecaiVf7tZ7y7Cldb3yYNGkgBOAA+JCrHRx5Wq6WxM6CgBXHh+Z7DTqOlkJ4+s8YmLZwQ2h264DREmcB7buTYCmo4mKpxiNqYk0L7ll2fYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787672; c=relaxed/simple;
	bh=mXsRP0QURTXN2spewue/9HY90nPBosT7LhadWuOXHCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgZcyN6ptTXVtBGLT844AQrbSbGAJv2LXiwqPcQj0itPKYyMnTjg8vFDybfA0YVT4h5XBhS1Ts4U74t8uLAS33EGd0gwhqCEFCvf5brRGVw4g657OFt1lAOVFEzWA+I3R6Isu4n0z8rgbfdvgGnTFpG6Iuz52qgMU1vFgZA/98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le1LiewZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A954AC4CEC7;
	Thu, 24 Oct 2024 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787671;
	bh=mXsRP0QURTXN2spewue/9HY90nPBosT7LhadWuOXHCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Le1LiewZ3qiFd9CaqiMoRqCJGHOZK7EgFzWCJcO3VR7bGJkuHxoD6gCnciWAh+iil
	 UMzPTD1LbKy6ZFGGyFsfYGh6bAYFYpu/HPR8kdHXoEY75/Ql74p4iJKFG4tg9kdv2g
	 n+/tBC0RIkWbEPCwrim0NF7kSdSLPOFz+YFIv7hoFvkIzl3h/S93G0PE77eaLxWveQ
	 DMtVGJAndGoEYaAT1isRDjOP889pOBCuB4D1aqkhICKy4OatlNhHP19UKEXI4OyKPO
	 xLsAG7ti6QI5KnU7D5AysdQ8OA4EtnktHwkX7dHfNu+/UtiBnbq+LegR5irfmTuUrf
	 O4zw3pwKDDnAQ==
Date: Thu, 24 Oct 2024 17:34:27 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Cc: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: qmi_wwan: add Quectel RG650V
Message-ID: <20241024163427.GD1202098@kernel.org>
References: <20241024151113.53203-1-benoit.monin@gmx.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024151113.53203-1-benoit.monin@gmx.fr>

On Thu, Oct 24, 2024 at 05:11:13PM +0200, Benoît Monin wrote:
> Add support for Quectel RG650V which is based on Qualcomm SDX65 chip.
> The composition is DIAG / NMEA / AT / AT / QMI.
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0122 Rev=05.15
> S:  Manufacturer=Quectel
> S:  Product=RG650V-EU
> S:  SerialNumber=xxxxxxx
> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=9ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=9ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=9ms
> Signed-off-by: Benoît Monin <benoit.monin@gmx.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


