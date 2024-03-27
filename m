Return-Path: <netdev+bounces-82653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018288EF1F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723F01C2AA1E
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EFD1509B2;
	Wed, 27 Mar 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aYuo3+NA"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF9130A60
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567464; cv=none; b=uxqJUpZmN1+2QfNNeP/pbkUt75Losd4pOtyFyhO/xWW6LrjVQ7deON8nAe7NXrut+t3YazkhFzy18jhmyH2+TUx3tQG4ahdvglzoBG/UrT3BnAECF4czQgEmzWo/w5dN0HJrHPfSO5v0VRA1RJG3S5Yc7dX4Ln0lmbJfFpngMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567464; c=relaxed/simple;
	bh=1e0A56XiUJiMXFdpWR9n3MWMN7nm5f2Jb5hcoQyfr+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGrESoSoMfLjFMkP4H6UeehlTjL3by7gY6uUyFmqr/xno/0B6yDyKG1Yt3kS7JYtoFM2ZZyQgMhtfAPjv0Xt30yyHVwYv1q3UzaYxUngF8zbwfRuP1R++YsZo6s491zgK2mjD9MjODVQMUU+LYGKSv6CzwQXFeheHcz5Up7ar5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aYuo3+NA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1e0A56XiUJiMXFdpWR9n3MWMN7nm5f2Jb5hcoQyfr+g=;
	t=1711567461; x=1712777061; b=aYuo3+NASBK4cnPP+xGNwq8Xa3gHqx0rGoVaBToG0jWKsql
	2MEhs+JR6qCQ2NZqTTMzHwMfneZ7vafsJlc3Kj9yoLkq0AoKyJtzb0323cbfdnHBxh1Amkxf0R+f0
	5ylfCZ0vOhQMBbl1F3EjRfe/sxNYYz2+N+DI5+Vsv1L+wgRvSz859wiqOulnl1Mnn2kKDKxFXnjIW
	4t9kAsLCLXc+ty2htFU8yeUGVKDN0Va9xCjKOlr3nFeXV6ZvrBHkJXlyeI/Q/QpPaiYm7mXFHaMm1
	8GpTdw7FX0dDeRQ7IRAvJ2k/jV8xwxZGW1ty2tFWp3ed48dnBQO1Bt4+VyR+1eGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpYsk-0000000HKPk-1bM2;
	Wed, 27 Mar 2024 20:24:18 +0100
Message-ID: <427aef33f1698c8f5b27011d0a829ec4d53b5f5c.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] using guard/__free in networking
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Date: Wed, 27 Mar 2024 20:24:17 +0100
In-Reply-To: <20240326171549.038591c8@kernel.org>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	 <20240325190957.02d74258@kernel.org>
	 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
	 <20240326073722.637e8504@kernel.org>
	 <0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
	 <20240326171549.038591c8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-26 at 17:15 -0700, Jakub Kicinski wrote:
>=20
> IIUC Willem and Stan like the construct too, so I'm fine with patches=20
> 1 and 2. But let's not convert the exiting code just yet (leave out 3)?

Sure, fair. It was mostly an illustration. Do you want a resend then?

johannes

