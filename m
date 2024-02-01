Return-Path: <netdev+bounces-68022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6486D845A2C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213B5293960
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE235F480;
	Thu,  1 Feb 2024 14:23:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD4626A6
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797404; cv=none; b=vAe6MqpfTZ9DVuVNZnofKa3uoB6Dqc1kJW3e2ZycaIvB5WYxd8xtveyjc+Xl8SNOObq7vbFBbt44fkzHu/oeHY5kOHlFityM1saG9o+e2BsGc1jN1iPeCw/5o5G5i2iYgkDKwzOsJELKFnqMXN3pIj6ZgHcFtdMFjZKI6sOs0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797404; c=relaxed/simple;
	bh=xzPlYSRThIaDCVbPeVhSq7kA3ynCPvfnGtpkJPCJyR8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=WShfAOpNMneoYrLSD8HLX5i6pjDu7fq0qArsdzGZWz8f87K4CEtgKw7ivFpJEfHBgZTjl50BnFiNyWOwU+fNoaoFldHGV8A//26AZ1vDvJDva0TbOLlG0X3RcnouShRXcP7UNQ66O9+70SuUoO46V0UcWoIanMXm00N4WMWOhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 07B4A7D05A;
	Thu,  1 Feb 2024 14:18:00 +0000 (UTC)
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-3-chopps@chopps.org> <ZVt7Nud5U5FbUJ3f@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 2/8] iptfs: uapi: ip: add ip_tfs_*_hdr
 packet formats
Date: Thu, 01 Feb 2024 09:15:33 -0500
In-reply-to: <ZVt7Nud5U5FbUJ3f@hog>
Message-ID: <m2cytg6zfr.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2023-11-12, 22:52:13 -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add the on-wire basic and congestion-control IP-TFS packet headers.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  include/uapi/linux/ip.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
>> index 283dec7e3645..cc83878ecf08 100644
>> --- a/include/uapi/linux/ip.h
>> +++ b/include/uapi/linux/ip.h
>> @@ -137,6 +137,23 @@ struct ip_beet_phdr {
>>  	__u8 reserved;
>>  };
>>
>> +struct ip_iptfs_hdr {
>> +	__u8 subtype;		/* 0*: basic, 1: CC */
>> +	__u8 flags;
>> +	__be16 block_offset;
>> +};
>> +
>> +struct ip_iptfs_cc_hdr {
>> +	__u8 subtype;		/* 0: basic, 1*: CC */
>> +	__u8 flags;
>> +	__be16 block_offset;
>> +	__be32 loss_rate;
>> +	__u8 rtt_and_adelay1[4];
>> +	__u8 adelay2_and_xdelay[4];
>
> Given how the fields are split, wouldn't it be more convenient to have
> a single __be64, rather than reading some bits from multiple __u8?

Changed this to __be64.


>> +	__be32 tval;
>> +	__be32 techo;
>> +};
>
> I don't think these need to be part of uapi. Can we move them to
> include/net/iptfs.h (or possibly net/xfrm/xfrm_iptfs.c)? It would also
> make more sense to have them near the definitions for
> IPTFS_SUBTYPE_*. And it would be easier to change how we split and
> name fields for kernel consumption if we're not stuck with whatever we
> put in uapi.

I saw this also as the place documenting the packet format. Userland can have raw packets delivered to them... Mostly though I was following the pattern that existed already.

Thanks,
Chris.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmW7qBgSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlrssP/jzGlqlXyw3goL7c111yUl5+zYdBREs0
puBZPuQBRyZp6r7y2r5+fmIRXdOsVXUKYiZOeinJfRyR2x6bRu2GeJAsDOC8QE0o
N4vmhJkWMKlEz9na0kT0dUA+6/fot6F+GBgyQSAQsA6pvhC3TduSWQzIXxJz3bc0
yYCQTjX52eFLUlGb3w5kEbhwk1iIA4PSFLnYsgzVFSl6fTngNIsj2rMRXogxewUV
MG/ipFvXwckRGM3R4BXI4bWXG5AeIagMmpdklAe/TFyklaaI+amTl9ucZ89bb9bt
zOiORxM2KVEi0xSSNZnMFf4i3Er5/c2IcHQVGjP6m9OMiiNWz2gAGR5K3ouS+gbr
GYoQwx3mQm9GfmnuXXH0ieYDRhbiJnR/mFMH6/Fw5fQhN2RKrVfhal/8xdFhpU2E
EDOjacgNLquE8dV8EB9cdHTC2oDzto8ZmnNpOOb4iq3KWBrp2Iby+fyIGLPpLKuY
xlUVhHHdh2ZFpPBru+6Rlw05Lv+zRjcfOuRx4zwxy2chAoj3RsdWnBmQnjtJJzm+
pFYSwc0jiLGoXJRk7iJjA4kq2y3N1TApWJZZXW2WvlEH/u0i2SShhY5o7p1Z0PHg
d5Du3KHx9yd5xtt3Grzy94Z+WBGp1sdohyaZfPGmp/tSyO2fZsPqVdivDrKclRfp
6OnrS723g9eN
=UGt1
-----END PGP SIGNATURE-----
--=-=-=--

