Return-Path: <netdev+bounces-109459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FCE9288BC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC851B24CB9
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89549148FE1;
	Fri,  5 Jul 2024 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YbUht7Xr"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332CC6A039
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182819; cv=none; b=ncnRzVpQpau/PYf7rrO1BlY5jFpUIQMmwbCpiwlm6Q4/7kvlEJoVT/+riV60a4SQR6LzXaQxHr793arn/tnX9VnDxAbn6+nPf8alkfYHi/DpoyUUy9NIgyk9P+Te3DgcR9qQ1fFpF0V/1s/7sAFImNMs3PJ8IaB9nma9sMT7ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182819; c=relaxed/simple;
	bh=ualno3A38hXYParwcoLN7Dz4DaV7XftQ/sL+cG/GMJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GjOJh/P9doG3HnVIAZvvqWPy0DERoGYdurRbQUnLbRtKCp4CXsR/X4Py94BewfVgyjk0nUecmaaKpf9MoY8yRh+rNfIjndOhDrwfX7xDyaHWFdpRCMY+VzgeRMYsh0Hvz4vq0TkWM8dC5NwGGJ2qPQdVmRg84Czq8DCvHC/s0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YbUht7Xr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=51G7StPSqauznycUHApskWm2QYBPoaSSWpKYmFsQzQQ=;
	t=1720182817; x=1721392417; b=YbUht7XrKoaqHE5BNydTmY1TzN9EZ81Sli+Ao54jW3Fizap
	UIJOiIAJ2KSsJ9eiLOxIXovd2KTgkvUbedklLL6YKij5dSIuDNDgf3km0JCxc+xjNVjGZyLNdB2Av
	bUSm+uxN/117pVpEuL425jbMtgzhn8zcJMFYIed9JD4LQ/MvkYknkFHo98qk2nvJqmM6kBFyV+cxI
	9CtIzOo9SX0EMLz+gonXRw7lnRzwEpL0BuD07hkhSRxpo9/zn/agi61NmSdJS8Ulv6plq1GDLRyIz
	dvXwbZYexKWLeTKI0oUROlOLVoA+8zWK9wB/RfmGRMQSuiNfxRAoo1FyY3oO9LuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPi85-0000000GMTL-07Uu;
	Fri, 05 Jul 2024 14:33:33 +0200
Message-ID: <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Fri, 05 Jul 2024 14:33:31 +0200
In-Reply-To: <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
References: 
	<20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
	 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Fri,  5 Jul 2024 13:42:06 +0200
>=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > WARN_ON_ONCE("string") doesn't really do what appears to
> > be intended, so fix that.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> "Fixes:" tag?

There keep being discussions around this so I have no idea what's the
guideline-du-jour ... It changes the code but it's not really an issue?

johannes

