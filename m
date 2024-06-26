Return-Path: <netdev+bounces-106933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906219182D5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497DD1F21D4B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99916183066;
	Wed, 26 Jun 2024 13:42:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161AD27A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409336; cv=none; b=sUWisVPjumrRGMNgQGc80yv2cpP7JLnSzIyaIsSXozmyePy/cuUjkWi5MTlVbVNR9/EPYnp75ZAegvRLK93Kb53xNS0LHaDx66tbwmuwU45iMGPfpvc7nK7kYySvSfCINV6IHXefff+kyyWwpRg/xQjsPykbt+B9UEciOxI+cA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409336; c=relaxed/simple;
	bh=6NgSQXZsuv7+xyVHRyW4/L/SEC4GkxiBZn8XQIlU5oo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=eAZX0iXtVEqpVIAFpyuaZikbdPYsR6MYRjNkdZUvBgBQxu4Vgv8yvO7GyzB2kYETF/5Veu0OCIksXFwVr4n2TrxdxFd57zLzKVgSXgQ5KkLinvpcuFdLqLrnwQR/NU6WwUDraDiOq6hKjAMMD9v3gur2iXoyR8apJYsrRQ7cpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 576E97D023;
	Wed, 26 Jun 2024 13:42:07 +0000 (UTC)
References: <20240617205316.939774-1-chopps@chopps.org>
 <20240617205316.939774-6-chopps@chopps.org>
 <ZnmQ2k9qUyOyBWap@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v4 05/18] xfrm: netlink: add
 config (netlink) options
Date: Wed, 26 Jun 2024 09:38:57 -0400
In-reply-to: <ZnmQ2k9qUyOyBWap@Antony2201.local>
Message-ID: <m2jzibakia.fsf@ja.int.chopps.org>
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


Antony Antony via Devel <devel@linux-ipsec.org> writes:

> On Mon, Jun 17, 2024 at 04:53:03PM -0400, Christian Hopps via Devel wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add netlink options for configuring IP-TFS SAs.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  include/uapi/linux/xfrm.h |  9 ++++++-
>>  net/xfrm/xfrm_compat.c    | 10 ++++++--
>>  net/xfrm/xfrm_user.c      | 52 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 68 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
>> index 18ceaba8486e..3bd1f810e079 100644
>> --- a/include/uapi/linux/xfrm.h
>> +++ b/include/uapi/linux/xfrm.h
>> @@ -158,7 +158,8 @@ enum {
>>  #define XFRM_MODE_ROUTEOPTIMIZATION 2
>>  #define XFRM_MODE_IN_TRIGGER 3
>>  #define XFRM_MODE_BEET 4
>> -#define XFRM_MODE_MAX 5
>> +#define XFRM_MODE_IPTFS 5
>> +#define XFRM_MODE_MAX 6
>>
>>  /* Netlink configuration messages.  */
>>  enum {
>> @@ -321,6 +322,12 @@ enum xfrm_attr_type_t {
>>  	XFRMA_IF_ID,		/* __u32 */
>>  	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
>>  	XFRMA_SA_DIR,		/* __u8 */
>> +	XFRMA_IPTFS_DROP_TIME,	/* __u32 in: usec to wait for next seq */
>> +	XFRMA_IPTFS_REORDER_WINDOW, /* __u16 in: reorder window size */
>> +	XFRMA_IPTFS_DONT_FRAG,	/* out: don't use fragmentation */
>> +	XFRMA_IPTFS_INIT_DELAY,	/* __u32 out: initial packet wait delay (usec) */
>> +	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 out: max ingress queue size */
>
> +	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 out: max ingress queue size octets */
>
> Add the units in comments? This would help the users.  The "struct
> xfrm_iptfs_config {" mentions it is octets. Adding it to uapi would help the
> users more. The defaults are not so obvious to find.

Will add "octets" to comment (and "pkts" to reorder window comment).

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmZ8Gq0SHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl1dAP/j+d8/8AI+votDOHPUsvKAM9otEGRjf0
Y80+Plo6KZkvFlfcstWJNtUmQh/NmkSSQMDI2J9OEEx23WWSeXm3Hn1rEp/06Kw7
O3EX2L3J+MJq1CLYVI9/hOWnCZPCnIj3Vhaq3iJRGLzvN5aM7abiNSUXhF/xvzD7
wvS/tHKZxXrumysEA5QB7F4JSeaUp0EByQcgRDERCKyke8SfbSDoRPiZIBmGYwMj
5wBxY65FRXGtNHhscpzJnkebEdbTIT6r/nTt4e1z9q910o4OGDwX3I1h8d2CFJ4R
S047lcngqi0b8AzSF4+y5GNKrtnHBZsn7vzKjqsVEpochnq6XFXrcLt56uBXJS1P
1EyNqnpeGhcDFZgHCIt9VPnq7awoShGIC/fpd18DrY38JyJkeScdtYHKxH0rXAQh
QFFN1NEEm84KPVuYNeg62lb1pyNl9OTOBbFce4hevkaNsD7B5nSK/nxAJlc69OKx
NCH9FJ/tGOYhTXJyLqxgpKO2TKwP51hlJ837cFIPNW1VHjZWPpBL/HHeoVMFLVce
3U5E72jjoSj0Tn4buxwy4cVd0hBbJYeBUhBSq7kCB5HjhPOI4owhUzdY2yYe1zVb
pEi9fDiCZzV3grXFhfZB1eh6nmbNfxMAVMAhyIjFwef1X0yHBzPIx3pUJsulo16b
CuUmiHNYyIbl
=bzfP
-----END PGP SIGNATURE-----
--=-=-=--

