Return-Path: <netdev+bounces-109281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F383927AC6
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3ED1C216E8
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D81B1500;
	Thu,  4 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tNk978tW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07491AC252;
	Thu,  4 Jul 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108960; cv=none; b=kArSSJ2W7qy/eN4zwU0GHz40j70lYPmF1a2/o61ir8qdn+fx4wP3mExHO1HWWFDyb848fDa3/19PzWlEaS04sIdoURoiiGio6SL+eWvg+/Qs2g2h1RAeGYwrbQEM4pzjgdR/2P/sX1SXWPyp4sXAvTmkSa7zWpgyFjSsXpi2CWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108960; c=relaxed/simple;
	bh=412ezJhJd2chMr71hp4430KnNpntdeybGZqVYxi2nYE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Oo3uVyJFyjZx8go0R3P1yKdtD4a+hPCgJOhs/S1lfN16PipaCtYMeD8RT9cpquNsRoLYb6dAL9+Oq45nnXmM+fmZpuctUuXKI/b48ypppAF2eRBkJQwWM7cyj7oCME+gpB2hL2fAjNZklCxqnXyP4hJHDb4Zdb0N9y3jhxVieHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tNk978tW; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720108939; x=1720713739; i=markus.elfring@web.de;
	bh=ww+sy9tlzyZVvwsDOx3rAgVU1lYCE/bquZTDMZYP9c8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tNk978tWOsl97HIs1uOZ3j1iRRMjUGUytxS9bgiE+BSd39bfvd8lG9Tvov599hAj
	 PlblHp9TpeB0CDjtbjMaFxaVh+8KKMvOWuGbAM6+F3zcE4ARC3T7B6gqNmOYOLqfu
	 Wse84spa3iLWDAPXpubP3HEnTB8BrrS1Xa1fJDpHZcTuszl4ntOUuoYQzAwKb4eTm
	 p+WufT4bxXRYDHoU1uap1sTvyOlb0zDv5GACo/JXJ2woY1YAJC68IROhnoEJkCcmF
	 9/vcjvBk2nPORqrA8bqeidti0szKriWKg7Pc48bNhDYqaqKW21aIXOdOFpDFP6UsD
	 mrTPF64hfCilQSzrsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVKK-1s72kL0zNy-012jW1; Thu, 04
 Jul 2024 18:02:19 +0200
Message-ID: <7645fee3-7e92-455c-a136-061bebce1670@web.de>
Date: Thu, 4 Jul 2024 18:02:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 Justin Chen <justin.chen@broadcom.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <ZoWKBkHH9D1fqV4r@stanley.mountain>
Subject: Re: [PATCH net] net: bcmasp: Fix error code in probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZoWKBkHH9D1fqV4r@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oNWnod1BIQ/iZp45ufgYO3iTp7TrhWqDEbEyP/9h638QHKPD8IA
 LKdRQyN4dn44R+ubB+q1L5kLZOgknKx1WYtwhdIV8uYjOzsDRobrqneDnHfp0YebVhASBPo
 FwrwqKR79bKGCd6y7OZCK2fD5cd62ebqO4ogwspHvFyZmkp5SRcZ3qyHImXyjMTSAt7AMuB
 Nd2cslh7goQoF8HMKDT8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ALai391Nt5Q=;pN/S8t10ED8lLb1JaUTmSsN2KWG
 +skHmKzNjitsT5ktcpmYruyiJ1D46ORhANsq8hdODK+Cegjj9yeNWvvE/VeeDL36xaRAkWC7O
 m9AQNOV5yxyXt0/S1FjypIKczbT7uo3WiAkoTbmvwuoG4w3G/Hl21EibqEDKVqP2/Po1VLPoW
 8vjRtd8sXaU8kKeGSzOsw50QAzo/cpsy78rU+my96T2X4FZh5iIVlBuTAbC7/GVNg35MH3knH
 uDfCIPEHC/+CjC2D1c8HVSzbq6uqcbFiCssEiDcfYs6eJFtqnxW3/8rE+KMQvGoK7Va+8/b7u
 O4fcyDu768Oa0uoSu8cAn+5idGZczgUmSv1m7S+Iw+9E9qKwnGPafy3VEziEoXU9bR/7d7VBe
 V+XsR2WjglFzuQWTaCGQfHr9qoCy7wBdBVqjo6Xnwcif7QXQdNR7LDGDUuZORJIGOOrD8B3kj
 rK3GjTvIzOw9yCDKZaXISg7XUx5obN7U5X1CcGPyeidFRPXS2xyMFG40fftx4kCeuZpPo5mZe
 a1D1/n7j9Ia5lqIW1fxsEimrOwuwtm9Ii1r80sQ5+f+OEDCIIvTFrGXoD98YpuUZiLfz57KY/
 fp30IcA6MvCVF6gmWE4MbEc8KtoTK6h+k+rzMKSJ2CGSshWiyWthJ8kfA9L3Uj743XrcCFQ4h
 8bq2S0xktW/7SHymPa9iNlfGfNStp9RDu4NMeX+6ZUb6CendCn2lWLe9CQNYYaMUVBI52j0vw
 07j62P6yCnaL8Dmp66oHEve2sorxHxiAgh8B2Fb77NfM3yrG67x97cDYqeYy4gZiVAUEYpoX3
 BAR5uuTiJ7cIa0XNJHabxGppJ6kVXq8HFSaFuK8GzNUhk=

> Return an error code if bcmasp_interface_create() fails.  Don't return
> success.

Would you like to refer to the function name =E2=80=9Cbcmasp_probe=E2=80=
=9D in the summary phrase?

Regards,
Markus

