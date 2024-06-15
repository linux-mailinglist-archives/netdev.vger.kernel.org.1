Return-Path: <netdev+bounces-103772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9AF90969B
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 09:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C8B21E30
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E917BA9;
	Sat, 15 Jun 2024 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="Q5UNIb0n"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911B17BA7
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718437495; cv=none; b=g42DcKQdCepMcbzo4e2KYFmh5td9L7lzIVBuqUS54UME0yDwV2/ia00yP0qcMHjPthlMCVOebBnJv9wyK4R6AcBqAFmAxiN44T9Ovx8p01QDSEhjzs8eHVMugNcosyFD1SW9arARZ2avAeOq6jA4dyqPuOJ7jzf1tSTPLoVbmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718437495; c=relaxed/simple;
	bh=m8NQrLtdl/KLzxryhpCnMJiu+Kg8URsFhrv28iaiq+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSKqKAIWtnWBwisWXukMe71NjNiwCQtJ+DWHVKOb8Kb5ITtsP8UXDy6rx9w70EDff+Js0oZCZGmyDI5Nw7FL69AznK36/e7yqibQKE3CR147nJPratOCUk8qZbPd3QpkSEzIvPVqn+nxINOuTT2HVGm8Bu4utU9Tw/NnNC3NKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=Q5UNIb0n; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718437477; x=1719042277; i=hfdevel@gmx.net;
	bh=8TlcXKLYR39R59/9APwduDKHjDaKL0R/RQGfBST/Tn4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q5UNIb0nbNBxpI6Ry2tzX0ZpLPSKyw68sgxYN1EBzh2f8ozUX7GlGJrXNSNKA+A+
	 zJS1TKQzDkCbJS1kcR3mf3hFNjtu0SPAt8cRn1gDcWM8W2j0BTTKGSRScVj5LMX7S
	 BV5pnNcgKHqw/USXFIV8Nhwe3UKGOguiXE0N+KbmvUmcCowlA+Wz7hLa73QzGmKxF
	 b8Jk/5HQbfG80T00F38aFOX6gwJ9dEhbyq54AyVMIADX+bM09pwvXTSozCdpPrkx8
	 ianNK6RF2bTowPxL6DlZYuH4yGcKaajFHPyfU0nuhLqzlSg4Y9jEI1wR8ZotlmF6j
	 M6nKQ6i13GYUuePPHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1sN4vG0kp1-00623y; Sat, 15
 Jun 2024 09:44:37 +0200
Message-ID: <1ae2ddab-b6d2-499d-9aa1-3033c730bb87@gmx.net>
Date: Sat, 15 Jun 2024 09:44:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
To: Jakub Kicinski <kuba@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 naveenm@marvell.com, jdamato@fastly.com
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
 <20240611045217.78529-5-fujita.tomonori@gmail.com>
 <20240613173038.18b2a1ce@kernel.org>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240613173038.18b2a1ce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wv1vYn7bAF6Bi19iyp/41nhZlM/DwmpmmpT8dO+RbY+YpDrhcxK
 eUFNz97Vh2X/nCSMVV2g2J2C0txV3lRrQnNnD3btw2Ncx1Tg+72z6Xwx9YwVY7Q5i5JZPNB
 9w167kHVXZjbNha1t0AoW6zsjU6E7zaP614KhhL7sjzSHqc/4MJ2MEgGE3NYapYPvLuFxn5
 fij53vT88KRC6x5suqsHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AfE7Hn0x6+8=;xrNSsSassJWkj9q1RdAGlB58gMN
 mIa6Bqf9BOrTyNSogB4njmLJQEWAk3GuHnaLpltidCdtCctUb9/J44yGRw+MSxItH55Rr1PA6
 wV8oWDAGHDgM6Q71tmvWeH/tQ2KK7QPBFiJ6YZ/fvhVuUgUNrVpfxOjZlv6uJ3i9ndsh0F1AR
 q/NUAc6rMcDm4//WjfGuPKxgaaTDDX28YHNsyqtYF2sgT1xIc/Yonj2L+aNAimu57t8tbiRCH
 IThxyGNpkJ2KuJa6GpjMeuqkATYMFiVVoTxsuH7qxEv065K1WjRr/bojn8ieQI/kkllLkvUnC
 zVk7oUThIs6DIfdwQ1mEFXUBTm7sTU8852T//TvR9IyikpoG+kbXh3Yd2EJ3sja72AJpvVJI9
 pdh141Ur9Rnat+p+bJrLJV/OKGiRv5u7JkGmd4BSLoXS7PEqz2mFnvDKuw04c0U5TIthUJmtO
 BQXt6eaz7DQywY8Suv+TM0ZaMbOmMbFtjWpX/ysLsjuPD5BQ6SWs+yD4u1pAXTf6XMhDeHvCb
 EOK9AajOovSpUOSnEEMHBy+OD6HKYWfJjnWZyAmw+3CrvXYBGIIGbKoUt7T66L4Ygtd8Rt77h
 x5gCm90YFY+FZKBGiZxSPCMbRr9FmTga2yfc0HJvM8NuT30BBcL9qFHzW9ugM2kU+IipG11Ra
 s8i9RtEa6oHwZn5uLLcNWoZ/524LQiViaWzoocROa8DPPMey3XkQmAyJXI2IpSUvzbNX9xx4w
 3xsn3DKQtYy1dWtjnxlcL8Z5Umdc/gJvglgzJEasSMzkiyDOpScWn9Q5Rqbfx8UELl/Osm9Yz
 mO4WiOGZY24CVl+1Q6eBdxuumxtM1LkC09uTOJyELdJss=

On 14.06.2024 02.30, Jakub Kicinski wrote:

> On Tue, 11 Jun 2024 13:52:14 +0900 FUJITA Tomonori wrote:
>> +static void tn40_init_txd_sizes(void)
>> +{
>> +	int i, lwords;
>> +
>> +	if (tn40_txd_sizes[0].bytes)
>> +		return;
>> +
>> +	/* 7 - is number of lwords in txd with one phys buffer
>> +	 * 3 - is number of lwords used for every additional phys buffer
>> +	 */
>> +	for (i =3D 0; i < TN40_MAX_PBL; i++) {
>> +		lwords =3D 7 + (i * 3);
>> +		if (lwords & 1)
>> +			lwords++;	/* pad it with 1 lword */
>> +		tn40_txd_sizes[i].qwords =3D lwords >> 1;
>> +		tn40_txd_sizes[i].bytes =3D lwords << 2;
>> +	}
>> +}
> Since this initializes global data - you should do it in module init.
> Due to this you can't rely on module_pci_driver(), you gotta write
> the module init / exit functions by hand.
I would rather move tn40_txd_sizes into tn40_priv and initialize it at
probe-time. Just thinking what will happen if there is more than one
tn40 card in a computer. Then a driver-based global struct would lead to
all sorts of problems.

