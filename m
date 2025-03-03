Return-Path: <netdev+bounces-171715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F583A4E4FD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA92C189CDF3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59628D070;
	Tue,  4 Mar 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AThAQGHZ"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39460205AC3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102948; cv=fail; b=esKp+Vb4Mcih0GC5T5aKIkwOJ0Yqm4pHGTd/RZNWp+l3HPCt7x61wOyBnYbj1PmYW3Zc6fbRpvj5SbO90pym07pwZPTo1GRjFpGnjlbzy63LTY4+U4VfJ8l4PbuClnCZQ0YdSAVBY5dRCLHIgsz6a/DSE6XlMfZGwlJQmKAsbIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102948; c=relaxed/simple;
	bh=4V4Q0QC6enYhZ0HGrj84kONUL41I3OhfuiezJI+AGj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NtiK8dLJ4YVlVK8308RqY49M0f8nCoowjhV9ieo8WN+v0TW3tQsO+reYoEd5Ty+TNaQoxiBTgc57E1jp5ZDFmS5+npdPyZ9mNpCY7JAxb/umqqXk8p7Tz9lRst36/g1XRnUeq9BzsiuPgn1lh1dIJn4jq7C1KRLp0vD4I0uCbVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AThAQGHZ reason="signature verification failed"; arc=none smtp.client-ip=198.47.19.245; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 6A12E40CEC8C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:42:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fz93kZPzG15n
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:40:53 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0117142724; Tue,  4 Mar 2025 18:40:37 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AThAQGHZ
X-Envelope-From: <linux-kernel+bounces-541831-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AThAQGHZ
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 886F541F0F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:38:27 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 5C706305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:38:27 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C146188E98C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7415A2135B8;
	Mon,  3 Mar 2025 13:37:12 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B7212F83;
	Mon,  3 Mar 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009029; cv=none; b=RcAlzUABSD+qCd44KsxxjlOCt6CQw6R2c5RGGUhutFVwJ71LKBSDrlM/49LsI4a7iSLtpOz8q40lkb7G3ywguMYV2Em48OWdPrHUKbCAiNzoewGg5XRvk0vSFqJNfLoZDN4rBz/dPdhkIbG+LLJ/zN0uwalLMJYNvF0xtw+AMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009029; c=relaxed/simple;
	bh=Xn1k7B4WleaLurRItO3p71bGSf1i/m3KCkUgXG8UOWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+JHW47s+grGTjYvWpLxr9AYBn6lUH9guaq9jKyb8SSd/qCNLwWQaXCBNUmSYl6oacP+gdx7alN0B9vdZDE8Z5GANFubKTPpYbrT8AVPuUEpbfMxtRP7GGJu3y5ZQjso7BcN1WdkBiQO5Fuvgf43FLrNNCjZhxrJo8aRJ9j12U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AThAQGHZ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523DaFOx2693754
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 3 Mar 2025 07:36:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741008975;
	bh=YsrLgmhopKk68gcwDTV/NQFgsX6Svsgvrj64ryk9wwg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AThAQGHZNeEI4KCqBCVdeJJtIRwBAEZYQVgkKje9cHHogVrGS+9oqS4lW9ujZYEKM
	 tlCNdOtsVejDrivOD6u9N4titcuS2lPfiSiAc9ZeD4fZ5e1D8Tp8oq0gh0NwvSqM42
	 bCyGzWrzn8Yu3jsljDGwILtjFXOmOMjoqb6uS81o=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523DaFPo086963;
	Mon, 3 Mar 2025 07:36:15 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 07:36:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 07:36:15 -0600
Received: from [172.24.21.156] (lt9560gk3.dhcp.ti.com [172.24.21.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523Da8cj073172;
	Mon, 3 Mar 2025 07:36:09 -0600
Message-ID: <40ce8ed3-b36c-4d5f-b75a-7e0409beb713@ti.com>
Date: Mon, 3 Mar 2025 19:06:07 +0530
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add
 XDP support
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <u.kleine-koenig@baylibre.com>,
        <matthias.schiffer@ew.tq-group.com>, <schnelle@linux.ibm.com>,
        <diogo.ivo@siemens.com>, <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
 <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>
 <2c0c1a4f-95d4-40c9-9ede-6f92b173f05d@stanley.mountain>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <2c0c1a4f-95d4-40c9-9ede-6f92b173f05d@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fz93kZPzG15n
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707702.31648@XUOV4lwZWag2esiu9WrtyQ
X-ITU-MailScanner-SpamCheck: not spam



On 3/3/2025 6:01 PM, Dan Carpenter wrote:
> On Mon, Mar 03, 2025 at 05:=E2=80=8A36:=E2=80=8A41PM +0530, Malladi, Me=
ghana wrote: > >=20
>  > +static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff=20
> *xdp, > > > + struct page *page) > > > +{ > > > + struct net_device
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source=20
> of this email and know the content is safe.
> Report=C2=A0Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!=20
> uldqV3eFFkc7oMXFHHkDX4AFLVsE3ldskf6bPMMFmxDOsNtMfZjUscGelUkBFpAeybNre38=
L_c2LiiUb7AZxLvAeqSk9ifgbPE1AYFU$>
> ZjQcmQRYFpfptBannerEnd
>=20
> On Mon, Mar 03, 2025 at 05:36:41PM +0530, Malladi, Meghana wrote:
>> > > +static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff=
 *xdp,
>> > > +			struct page *page)
>> > > +{
>> > > +	struct net_device *ndev =3D emac->ndev;
>> > > +	int err, result =3D ICSSG_XDP_PASS;
>> > > +	struct bpf_prog *xdp_prog;
>> > > +	struct xdp_frame *xdpf;
>> > > +	int q_idx;
>> > > +	u32 act;
>> > > +
>> > > +	xdp_prog =3D READ_ONCE(emac->xdp_prog);
>> > > +	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
>> > > +	switch (act) {
>> > > +	case XDP_PASS:
>> > > +		break;
>> > > +	case XDP_TX:
>> > > +		/* Send packet to TX ring for immediate transmission */
>> > > +		xdpf =3D xdp_convert_buff_to_frame(xdp);
>> > > +		if (unlikely(!xdpf))
>> >=20
>> > This is the second unlikely() macro which is added in this patchset.
>> > The rule with likely/unlikely() is that it should only be added if i=
t
>> > likely makes a difference in benchmarking.  Quite often the compiler
>> > is able to predict that valid pointers are more likely than NULL
>> > pointers so often these types of annotations don't make any differen=
ce
>> > at all to the compiled code.  But it depends on the compiler and the=
 -O2
>> > options.
>> >=20
>>=20
>> Do correct me if I am wrong, but from my understanding, XDP feature de=
pends
>> alot of performance and benchmarking and having unlikely does make a
>> difference. Atleast in all the other drivers I see this being used for=
 XDP.
>>=20
>=20
> Which compiler are you on when you say that "having unlikely does make =
a
> difference"?

I'm on gcc version 10.3.1.

>=20
> I'm on gcc version 14.2.0 (Debian 14.2.0-16) and it doesn't make a
> difference to the compiled code.  This matches what one would expect fr=
om
> a compiler.  Valid pointers are fast path and NULL pointers are slow pa=
th.
>=20

Can you tell me how did you verify this? I actually don't know what=20
level of optimization to expect from a compiler. I said so, because I=20
have checked with other drivers which implemented XDP and everywhere=20
unlikely is used. But now I understand its not the driver but the=20
compiler that plays the major role in defining the optimization.

> Adding an unlikely() is a micro optimization.  There are so many other
> things you can do to speed up the code.  I wouldn't start with that.
>

Ok, if you believe that unlikely is doing more harm than good, I am ok=20
with dropping them off.

> regards,
> dan
>=20



