Return-Path: <netdev+bounces-138153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A39AC6BB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFB41F212EB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE79137742;
	Wed, 23 Oct 2024 09:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.sysmocom.de (mail.sysmocom.de [176.9.212.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6419CC27
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.212.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676129; cv=none; b=VE0szCSJREnIV1maFAuZ1auSDvq51EOUkUwX+vQ+RRuYoT3ij3jyLiwCsBhp7ejIWxRW3R1qjlygWG4hot4rgstXOpqXu/vhMLlY4ZPmVnFXSdI4b9jGmWxfGTRMWk6W+ymhcUvGAIKfMTt8dAnYquKTlUJJOCEjdMArxuY//V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676129; c=relaxed/simple;
	bh=ak8DIHEu81gUaSM4NF/00PF87B4QSaKIyK4qyxBLNNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQz7boCHg6moH3wP8PBCxjCSZJnRihTqDcGTRvwrAWd5V6bXu0a6QoToC80qtDDsE2nq9UNfjjBU9fq3inwq+56pGc0n0RxiUJTTc8zHmPXNB53mNbEnLk/Pdh5kx0Ywfm29lxJyUluKGEEJjYKhAcW7bylTKyGxExMa2kkszm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de; spf=pass smtp.mailfrom=sysmocom.de; arc=none smtp.client-ip=176.9.212.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysmocom.de
Received: from localhost (localhost [127.0.0.1])
	by mail.sysmocom.de (Postfix) with ESMTP id 2F2E7C801F6;
	Wed, 23 Oct 2024 09:27:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([127.0.0.1])
	by localhost (mail.sysmocom.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xdh_NtUTNUYG; Wed, 23 Oct 2024 09:27:00 +0000 (UTC)
Message-ID: <93352553-9015-46fa-8797-52cb94ce14df@sysmocom.de>
Date: Wed, 23 Oct 2024 11:26:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] gtp: allow -1 to be specified as file description
 from userspace
To: Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, pespin@sysmocom.de, laforge@gnumonks.org,
 osmocom-net-gprs@lists.osmocom.org
References: <20241022144825.66740-1-pablo@netfilter.org>
Content-Language: en-US
From: Oliver Smith <osmith@sysmocom.de>
Autocrypt: addr=osmith@sysmocom.de; keydata=
 xjMEXqaMvBYJKwYBBAHaRw8BAQdAKlLfpb/UKvlUjGFwzzkDBT1fXdlqg+MaEG2+hTXDYUrN
 IU9saXZlciBTbWl0aCA8b3NtaXRoQHN5c21vY29tLmRlPsKWBBMWCAA+AhsDBQsJCAcCBhUK
 CQgLAgQWAgMBAh4BAheAFiEECfuANpg5IsWyQFcH6+DRJFm2BMUFAmDG9VIFCRTsa5YACgkQ
 6+DRJFm2BMUJ0wD+L0gpHABtBfkNQ7i0/qtMs5thoqt2yldxao6q31BBLAAA/iXUDIEYjQ0L
 wsZRtiSdXNjbBfdT9boLdh4CY+TKwuYPzjgEXqaMvBIKKwYBBAGXVQEFAQEHQPGmG2/uQrDy
 xalQoBnT1zdIbeg/xWLjl1AnOYGITnpEAwEIB8J4BBgWCAAgFiEECfuANpg5IsWyQFcH6+DR
 JFm2BMUFAl6mjLwCGwwACgkQ6+DRJFm2BMXSRgD/f8twzpyQfpE+viVjtlOxsq0HCavXZqbW
 VvIuvbyfSWQBAJhEIFF/fxmksu9r3FzixNQMOLc3EJgSwqvEYA28Db8O
In-Reply-To: <20241022144825.66740-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Pablo,

I've reproduced the regression:

> 20241023090545167 DGGSN NOTICE Initialized GTP kernel mode (genl ID is 32) (gtp-kernel.c:80)
> [    0.721705] gtp: enable gtp on -1, 4
> [    0.722017] gtp: gtp socket fd=-1 not found
> 20241023090545169 DTUN ERROR cannot create GTP tunnel device: Bad file descriptor (tun.c:213)

and verified that it is fixed with your patch. Thanks!

Best regards,
Oliver

On 22.10.24 16:48, Pablo Neira Ayuso wrote:
> Existing user space applications maintained by the Osmocom project are
> breaking since a recent fix that addresses incorrect error checking.
> 
> Restore operation for user space programs that specify -1 as file
> descriptor to skip GTPv0 or GTPv1 only sockets.
> 
> Fixes: defd8b3c37b0 ("gtp: fix a potential NULL pointer dereference")
> Reported-by: Pau Espin Pedrol <pespin@sysmocom.de>

Tested-by: Oliver Smith <osmith@sysmocom.de>

> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>   drivers/net/gtp.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index a60bfb1abb7f..70f981887518 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1702,20 +1702,24 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
>   		return -EINVAL;
>   
>   	if (data[IFLA_GTP_FD0]) {
> -		u32 fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
> +		int fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
>   
> -		sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
> -		if (IS_ERR(sk0))
> -			return PTR_ERR(sk0);
> +		if (fd0 >= 0) {
> +			sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
> +			if (IS_ERR(sk0))
> +				return PTR_ERR(sk0);
> +		}
>   	}
>   
>   	if (data[IFLA_GTP_FD1]) {
> -		u32 fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
> +		int fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
>   
> -		sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
> -		if (IS_ERR(sk1u)) {
> -			gtp_encap_disable_sock(sk0);
> -			return PTR_ERR(sk1u);
> +		if (fd1 >= 0) {
> +			sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
> +			if (IS_ERR(sk1u)) {
> +				gtp_encap_disable_sock(sk0);
> +				return PTR_ERR(sk1u);
> +			}
>   		}
>   	}
>   

-- 
- Oliver Smith <osmith@sysmocom.de>            https://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Siemensstr. 26a
* 10551 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte


