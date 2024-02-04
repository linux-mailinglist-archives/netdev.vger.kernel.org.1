Return-Path: <netdev+bounces-68985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28B8490E6
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 22:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE44B22419
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3F250FD;
	Sun,  4 Feb 2024 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="DBfSP2uz"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2B2C689
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707083533; cv=none; b=Wg5nnE+aOfn54c3O1w1eyFkLZyMUX3cyd5DM6GMcHNh6Wdoev9f/ab4Xt3BbFm9/re+PIhVKsMhYDnDwzwwTfSUEICucGNL97WPRGhl+Gc8bwU8v2D1OuKgdsd0erUltIr22MznmibofTdxxJrlOghUCi+cpqfABZN6qqICx0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707083533; c=relaxed/simple;
	bh=0tSen8X/pgfCReMJ3IQEfX6Rk9NK8G0HJud9gQzf1hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhP1h8u9GjoahioBat5Zg23XFYb4G+mKZPbQ9npHYuxUMGBt/ux3Sjnru/HgTh3VV6Fx++Zijp+25YvkLN69zDhiyGMFthM1WuvD6PaYyziaWBKpljIAXbizwz63ycjuLK6UZnRMFFGS20ceouLl4MFZ3FpsLZVQnbm4ZsTjgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=DBfSP2uz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707083528; x=1707688328; i=wahrenst@gmx.net;
	bh=0tSen8X/pgfCReMJ3IQEfX6Rk9NK8G0HJud9gQzf1hc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DBfSP2uzmpG+BRoNbYQ2m+3UaFzMCY9UHQMf16I8UrOfXczbChgI1OYKOLyT9s0/
	 vW7iXdhisgDc7fGwich3ih+77MD1cnaew4W50eDXraDIfaYKTT9YafdAgXJsdBxDW
	 nnpGf7Ex0Fz942zK2wTTJ4rCPxiMYqh0jDLtcYkG4KdkMkMwtZc6/7mjXMeLOw37c
	 NJ9onaMetD49ZLD4eVXzIUMw7Hj/YVc29kOQcHurY/C/mz34h6lH9ohu23ws5HZG7
	 gJfC9wyiCsIFrqzFXgYHleX/dcle6xLdvhIO/wXCNG6VOxdCnGVp86TptDznsE1iv
	 nJkVwSX0SqszuBrOPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1qs1QZ2HVr-012mlr; Sun, 04
 Feb 2024 22:52:08 +0100
Message-ID: <e6c64849-ded6-49e0-aa15-283346b185e4@gmx.net>
Date: Sun, 4 Feb 2024 22:52:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qca_spi: SPI_REG_SIGNATURE sometimes not recognized
To: chf.fritz@googlemail.com
Cc: netdev <netdev@vger.kernel.org>
References: <75ea348da98cf329099b0abf1ef383cd63c70c40.camel@googlemail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <75ea348da98cf329099b0abf1ef383cd63c70c40.camel@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BUq4lRCbHWYP/K9oWydme3nfNfvjgLKssyBknYWgASy0kxcDEov
 Oojkqfxtqp6bc6EA+dK8CNgGOKc7Jul5Eb3y1aiNf0b0kSV8fCgRSu/HAdrhB2hPyvpjtiP
 hBNM9sFUFdpSH/QnK/kSnB6EWd3GgFqeNiBJAK1lNpSIUHX+Fz+GYSM7T2h/XK/S5qWyyHL
 XkH4nWtpOXmdXIVhtJKng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MQdzXM9VCko=;y1FBgGLDZUFNYQ53oUirPeDJjZc
 BukvSqSN2qvvXPfjKNFygQB15u7Zr3lKeARVcOs8sNEXCeJatU/J3BMxqj6d9ZhyN1WT0Iyw8
 bhFcpwctlLJfSgBaHCfKSE8efpXc1vKVqvYWMXpIi9GbeJEeOzi7aflU6WSPTXPsU+0bLLklv
 I+/0svftRb30eroDy4Ay44hmQETQ+FRj3WBkyd5zg8SKS2nKHcwNJXHijwwhUJcag054UvHs7
 2JT3IAPAM5yPi/V6YvG1blJQLuw7SseSSOSrx3Z7MpXxPhIQ0ROzy/js1VSHMXNZa1U7UfJ3Q
 PMLrkE9YSaH8s1P/6AIKuyUkl6JYuBt6FPHEfn9zl3kvKgLm7uSVlMNmtx7Swemj7ITcABW4F
 d1/iL33nVRuMyosh6vi6VrAjnPxVksG5KiS17a6DlFrD7VyfWL9tBBWY/KJRbUKxucAR5huOL
 Yte9D28mqpRodoV7sM+TgrcYSf1dgxpf+Dso0tGhaZimPPUBK5LbCvA3cmLF2nO23Jq/x6+cL
 7OpbjBEwMV0NtBYau3wxfSBg7YXzinwPyFR6F2stOrWEZkxvL/Sgdp85jd6bkUWc9Tv25Yknf
 PuKMsvR3kEP7ldp/iuRLUe62F1K6UYs7HX+hC3yKSf2la0pPutGFyAlnntV1+pb7RK3Voow/Y
 wEg5DeeeQuDpIaYUh3LMMda8Nd1J1UDK3J/PWM2R3cAYvyg0/5VD5gr08bhoJGR3Bi33eA4Az
 MSwJKVx8XahPdaoOvdEr0eflMT7k9QR1xHaYYS01ADlEa8NsFQM2wUlMZ963KUIG6o5Z9CluW
 O1uZZDmm1zJCjlmHA9U1eBu6CWpjSrsR/YdLOLeG6DxJs=

Hello Christoph,

Am 04.02.24 um 22:23 schrieb Christoph Fritz:
> Hello Stefan,
>
>   working on a board with QCA7005, on probe() SPI_REG_SIGNATURE
> sometimes fails (~1 out of 5 times) to be recognized correctly, even
> after multiple reads and retries.
at the time of writing the driver, i assumed the QCA7000 is always
powered up (takes ~ 1 second) during probe of the driver and the driver
could do the signature check during probe. But this doesn't work in all
cases. So qca_spi driver has the module parameter qcaspi_pluggable,
which is disabled per default. If you enable this, this will skip the
signature check during probe and let the spi thread handle the
synchronization.

Does this fix your problem?

Regardless of the results, i think qcaspi_pluggable should be enabled
per default.

Regards

>
> Any suggestions?
>
> Thanks
>   -- Christoph


