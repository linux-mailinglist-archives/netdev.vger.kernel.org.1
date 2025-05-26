Return-Path: <netdev+bounces-193423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C88AC3EB4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264023A87E7
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E421D54D1;
	Mon, 26 May 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="82Yre3/v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="oBTFbFvs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C511D5146
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259653; cv=none; b=Lg6eKs9dlCyQ9uedX1ZKYuZUvacy+7/+uBI8duMCeaGoL2UXbv4iXKINThLw4+8gqPB95R4uX8+sSGI4sHJjhEIF3k2oI7BjKmly7B9ZPnsyVEE2NyQxdTd8u0ISdCkAq7bRkdub/JYXA4OIgxFwmSc9TxXOv73TGFlP225YXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259653; c=relaxed/simple;
	bh=SCvMoVlsyNEW5KJAEQXD+HAIPfI/nrWFGhY1yMUom14=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qqQCup6knBqu6Fz3j3y7I0eyB5eIaPR2Pr6xKREKDgMjIerhqe7wDsOdknK/VAbKVRoM1YO9jkdt0FqNMoXUnjZk2QNKyeE/QfGv+imNH8SO0YCfD642U/wvxOyE5QkprRgkUpsgwCL9OZLYzwqwx9yy92IfBm6u8oXKrFGyf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizmail.org; spf=none smtp.mailfrom=wizmail.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=82Yre3/v; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=oBTFbFvs; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wizmail.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Autocrypt:From:References:To:Subject:MIME-Version:Date:Message-ID
	:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=6RHLaM/+iaiBW0v4pas6bS5FWWP82QwJZiyvHUVIalk=; b=82Yre3/v96IlE0EfltFQsqWeBb
	atiKZHAhlyAU3S29I2fqHEA1QNQrS47zMSJy0I0WG3D8kDULsGoL+blB6ABg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Autocrypt:
	From:References:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=6RHLaM/+iaiBW0v4pas6bS5FWWP82QwJZiyvHUVIalk=; b=oBTFbFvsWhF9nCdwg+kG0Ru0pv
	1U3cFmMXgbxPO23x90nN0yG28KjrmIdraz6gvfHIMMJijNjLkcme7Yv/ResqDDbWIkc6MDkAjg9xl
	jKCTR+NKtULp7Bfz6oXPGtS9oSdGuyGkZmwnjB53F74AtSCM0adAPwWD0El5xzcZja1tchqjxYUnz
	KyCcEv3piY/ibFQUcpcXB0ReHzO0JjL6PaIVE+VypMT5iF9DOSgQl0qJIVT9r/0x4e1fd3l5wjwFs
	JB+yBrgZ/4A+pQx8kEeHlw3UNCYIywF7YsFLwJ0seWVsLLh/ZbVn8SGTtqceh7IFy5bZfTCGlbEhA
	QgCUqERA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1uJWCA-00000000d69-276w
	(return-path <jgh@wizmail.org>);
	Mon, 26 May 2025 11:40:42 +0000
Message-ID: <55787952-ea5b-4b1f-b285-4036e2897161@wizmail.org>
Date: Mon, 26 May 2025 12:40:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does "TCP Fast Open": not work on 6.14.7?
To: Konstantin Kharlamov <Hi-Angel@yandex.ru>, netdev@vger.kernel.org
References: <985e79fa5c4ea841cb361458cdcf0114050bfb62.camel@yandex.ru>
From: Jeremy Harris <jgh@wizmail.org>
Content-Language: en-GB
Autocrypt: addr=jgh@wizmail.org; keydata=
 xsBNBFWABsQBCADTFfb9EHGGiDel/iFzU0ag1RuoHfL/09z1y7iQlLynOAQTRRNwCWezmqpD
 p6zDFOf1Ldp0EdEQtUXva5g2lm3o56o+mnXrEQr11uZIcsfGIck7yV/y/17I7ApgXMPg/mcj
 ifOTM9C7+Ptghf3jUhj4ErYMFQLelBGEZZifnnAoHLOEAH70DENCI08PfYRRG6lZDB09nPW7
 vVG8RbRUWjQyxQUWwXuq4gQohSFDqF4NE8zDHE/DgPJ/yFy+wFr2ab90DsE7vOYb42y95keK
 tTBp98/Y7/2xbzi8EYrXC+291dwZELMHnYLF5sO/fDcrDdwrde2cbZ+wtpJwtSYPNvVxABEB
 AAHNJkplcmVteSBIYXJyaXMgKG5vbmUpIDxqZ2hAd2l6bWFpbC5vcmc+wsCOBBMBCAA4FiEE
 qYbzpr1jd9hzCVjevOWMjOQfMt8FAl4WMuMCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AA
 CgkQvOWMjOQfMt946ggAvqDr2jvVnGIN2Njnjl2iiKyw4dYdFzNhZgjTaryiV90BftUDxRsB
 uTVFUC6XU+B13MEgSK0zRDyI5NpEH+JTW539gWlmz2k2WTTmoBsm/js1ELoAjGr/i32SByqm
 0fo3JPctn/lc7oTo0muGYvB5xWhTHRlcT9zGTRUb/6ucabVLiJUrcGhS1OqDGq7nvYQpFZdf
 Dj7hyyrCKrq6YUPRvoq3aWw/o6aPUN8gmJj+h4pB5dMbbNKm7umz4O3RHWceO9JCGYxfC4uh
 0k85bgIVb4wtaljBW90YZRU/5zIjD6r2b6rluY55rLulsyT7xAqe14eE1AlRB1og/s4rUtRf
 8M7ATQRVgAbEAQgA6YSx2ik6EbkfxO0x3qwYgow2rcAmhEzijk2Ns0QUKWkN9qfxdlyBi0vA
 nNu/oK2UikOmV9GTeOzvgBchRxfAx/dCF2RaSUd0W/M4F0/I5y19PAzN9XhAmR50cxYRpTpq
 ulgFJagdxigj1AmNnOHk0V8qFy7Xk8a1wmKI+Ocv2Jr5Wa5aJwTYzwQMh4jvyzc/le32bTbD
 ezf1xq5y23HTXzXfkg9RDZmyyfEb8spsYLk8gf5GvSXYxxyKEBCei9eugd4YXwh6bfIgtBj2
 ZLYvSDJdDaCdNvYyZtyatahHHhAZ+R+UDBp+hauuIl8E7DtUzDVMKVsfKY71e8FSMYyPGQAR
 AQABwsB8BBgBCAAmAhsMFiEEqYbzpr1jd9hzCVjevOWMjOQfMt8FAmgeKicFCRZfl6wACgkQ
 vOWMjOQfMt8Bewf9F3xhidAAzCrlwceeSx16n82sSmtCopkoSp85++P6P3Nzt/erkqnhZY0Y
 OZM5xIBJU5ejKalb6aYB4OU7q20MfTerPo+XhuWDjKYb0RrMmekVsE4/V5sFCgdwkqjax1ZX
 Jk3/vkTRnpHtuKas9FxGxeyaJrsYBhJIgzcXAfN3zYRD+x6L/zNYzvvoEEH8dKIeKh0dEXg0
 3p0VWJU8zfWo2NT+xeqYnG8OO2HAr9/D9Sw9W4HZ4csdWXOJ/GmnHYri9Q4RyrF8uH4fAxKr
 c1cFYEY84iaBog5uv3dti9vUit8XWyae8rTPC/QyAekgREvAJnISWxLQWWbOqd6TkoTqJw==
In-Reply-To: <985e79fa5c4ea841cb361458cdcf0114050bfb62.camel@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

On 2025/05/26 10:02 AM, Konstantin Kharlamov wrote:
> 3. Connect to it with `nc -v localhost 8080`

The application needs to specifically request TFO.
-- 
Cheers,
   Jeremy

