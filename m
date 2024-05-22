Return-Path: <netdev+bounces-97622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B08CC6CC
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD50281BB4
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5E1422B0;
	Wed, 22 May 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="RxTiNusr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091CD51E
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405672; cv=none; b=kF80KGV53Hy0api2FFSXZCMOvoHw94OdgQRTFBjNqSuAF5P+4tTAw4r0sNe//1B32d+MFr7yykyklmpFcplT7o7jd2IpGrtoh859qCmFwEjt9sZZexgnzLxffARDYrWzd/A8F+Vmav8AHdB5t7ORw46St84wnVIHwltxHD2ZPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405672; c=relaxed/simple;
	bh=Sk5zse0IhIruaguXl992OXCDVIoIwnGTwaTDKG2jJqI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=i7OO/QTM74vhIP/wYr10uJXoswWbbG7pdHEmL3dcZFmbciuJZM+u2+IpI9wr6GCGUVezGQtQy762yICqbiPAficsQoih8NEWSeFzZP+DHAydU7ib5vFYd1jV9ioiSXWDTVmbpczrc6jWsky+QILRZJBdCx3Ir/wVvN81TWPSeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=RxTiNusr; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description; bh=Sk5zse0IhIruaguXl992OXCDVIoIwnGTwaTDKG2jJqI=; b=RxTiN
	usrlFplFAc2Hv5RRtPHfdnULRvKFAgMWcqV9oooz9yO4FXnX6Gm+mXxxorM6Y3OqN+ZRFooaLWRVL
	axEElRr0KuPkMW6JNfhcTugCjDhd7GeN+0WjnHgBMWMw5MazT1lMqF88hEqSTPlpH+VOirBwB7Aqw
	gBGWv0680WkcPMk6BvoVvBeHJpCX27OQcuzDZYPvzipz5lZyJQdzziR62raq+8rewszSCwAb0Pops
	u5TJdtI8zg0uLAGr1jIELUavQFruR61/PLS6jNpr5PoKTqGamm7bLg5Kz+9+Xh8IVBhY3qAZdG6h5
	0lCJ1Bxb9njuO8jSUxTNE3kw9Zzqw==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9rWP-000ecY-0K
	for netdev@vger.kernel.org;
	Wed, 22 May 2024 19:21:09 +0000
Message-ID: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
Date: Thu, 23 May 2024 03:21:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
Subject: iproute2: color output should assume dark background
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Debian is now building iproute2 with color output on by default. This brings attention to the fact that iproute2 defaults to a color palette suitable for light backgrounds.

The COLORFGBG environment variable, if present and correctly set would select a dark background. However COLORFGBG is neither ubiquitous nor standard. It wouldn't typically be present in a non-graphical vt, nor is it presnet in XFCE and many other desktop environments.

Dark backgrounds seem to be the more common default, and it seems many people stick to that in actual use.

The dark blue used by the ip command for IPv6 addresses is particularly hard to read on a dark background. It's really important for the ip command to provide basic usability e.g. when manually bringing up networking at the console in an emergency. I find that fiddling with extra details just to disable or improve the colors would be an unwelcome nuisance in such situations, but the Debian maintainer outright refuses to revert this change, without explanation or discussion.

Instead the maintainer suggested I submit a patch upstream, which I will do. I've never contributed here before, so your patience and guidance would be very highly appreciated.

Ref: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071582

Thanks,

Gedalya



