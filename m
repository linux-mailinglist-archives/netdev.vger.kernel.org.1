Return-Path: <netdev+bounces-102862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DFE9052F5
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB23D1F21E2F
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0780173338;
	Wed, 12 Jun 2024 12:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD661172BC1;
	Wed, 12 Jun 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196664; cv=none; b=cA43Ja7TCYrVS8mjvmmOAZr0ADQnLuIKhs6SkNH80d5jwsPgeNyHuxofemd0WfjvSVEfwLVc7B3nDSd+l+4Uf7jLu8uoEGKWQwoGKLdiJhJa8OEDV1eBtP9qfznVdGPYTrCeuhTRhSs8xHV4aa8RxPADSoQKvnLyPB7EnOa2k/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196664; c=relaxed/simple;
	bh=LKLo4gKUya3z8yt1DHN3rJHsbIY8sK5uk1+m3CG8yqE=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=JG6i4H2VViWx4pxPqvERVYtQNNVdd79pkdE5WHG5x6lwyHntm6ZiYgnW8VHz1Gj2zpil/vavB2rwZNRdJkEKPsieZcU9TU9qORoBV0uNOBBMlG1+uaNXJE0Mwr13gUkQRzHvKnehvvhxPiLaFNT5eCEvQBf1r6w7i0B54tyxv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9907278693=ms@dev.tdt.de>)
	id 1sHNRF-00B2Hr-AG; Wed, 12 Jun 2024 14:50:53 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHNRE-000GXo-Mf; Wed, 12 Jun 2024 14:50:52 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 60014240053;
	Wed, 12 Jun 2024 14:50:52 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E3964240050;
	Wed, 12 Jun 2024 14:50:51 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 72CA630F70;
	Wed, 12 Jun 2024 14:50:51 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 12 Jun 2024 14:50:51 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/12] net: dsa: lantiq_gswip: code
 improvements
Organization: TDT AG
In-Reply-To: <20240611190041.6066d6a8@kernel.org>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611190041.6066d6a8@kernel.org>
Message-ID: <6a1b2965843ad984adea7b8c34ae1d25@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718196653-C144C8CF-6F2E5A2F/0/0
X-purgate: clean
X-purgate-type: clean

On 2024-06-12 04:00, Jakub Kicinski wrote:
> On Tue, 11 Jun 2024 15:54:22 +0200 Martin Schiller wrote:
>> This patchset for the lantiq_gswip driver is a collection of minor=20
>> fixes
>> and coding improvements by Martin Blumenstingl without any real=20
>> changes
>> in the actual functionality.
>=20
> For future reference:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-=
dr

I think you refer to "don=E2=80=99t repost your patches within one 24h pe=
riod".

Sorry for that.

