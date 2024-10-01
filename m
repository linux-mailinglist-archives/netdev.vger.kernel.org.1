Return-Path: <netdev+bounces-130882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BA98BDB8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB692B24A51
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DBD1C3F32;
	Tue,  1 Oct 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=inguin@gmx.de header.b="d7METaRW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50E4A21;
	Tue,  1 Oct 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789489; cv=none; b=T3GtbgtiCHtK9bR5LL66XfAgB/Lb6ZBZELE+cY7suxS3B3AveCAa4Sg9ZZlrAxPmFQdhqVF315m7w46ddhKwObzIoqzhscJuhvDpcbadW0aKTt3Y2RzLlGmmoo3R8JhAZ/wr+dt2VdJg2qLrTGgOAFPIm/IBIEL6kXT9Mznp+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789489; c=relaxed/simple;
	bh=7HuQYYdyvXcgH3M0Q90Zwel86yuIKti1/jdseqtoPiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCcU2vPXLWBGKDGONPGGt8ZNAx4StNYrRQp6kpcDGtCjzo72tID+Vu2HcaPHxshudwJ39uqRSADDTkAiuvrentFpmNCjTF5m+j9xk3m52nixxVcffPWni781YuV1k7ICg/vgQVgHW0ylQFB4jTh19RymzuruPoY6LfZk6ZkhqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=inguin@gmx.de header.b=d7METaRW; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727789478; x=1728394278; i=inguin@gmx.de;
	bh=6x31hl+RLOQ0EYJTk9ZHcVFp7cNPSTtuIQI3ws+a1B8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d7METaRWmZU/JxzRJBAdZAp4D32zJOM32lMAKoSkwopRmDQofCQUzHb83DXc5ra/
	 Xf3fKTQulTogNd+Q5vTR9qEKT9RKHpVHCemCA/UHZb0B6FbVdhv4UnG2kCndtGUad
	 cBU1P+coZglmM+GB4ifPMK+j7KpZk4Z6QP/ilARyJa3NQ+56TZy5v/MryKddlGWSK
	 rENGa2wTwuigIfPIV0A+ioDnwJ00muw74adbJrj6iK0FaPR/ojI98HdghXwudNqQb
	 lS+xq2X8bTqaBJaU+NXmhGCH+q2UVQvgkEeYPmH9/Z2fj2jYhs66qCjHhWf6Ev1h0
	 rH5wjD6f+plKWPO9cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.29] ([212.80.250.50]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1sM12N12tl-00eTeH; Tue, 01
 Oct 2024 15:31:18 +0200
Message-ID: <9e970294-912a-4bc4-8841-3515f789d582@gmx.de>
Date: Tue, 1 Oct 2024 15:31:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: dp83869: fix memory corruption when enabling
 fiber
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "dmurphy@ti.com" <dmurphy@ti.com>
References: <20241001075733.10986-1-inguin@gmx.de>
 <c9baa43edbde4a6aab7ec32a25eec4dae7031443.camel@siemens.com>
Content-Language: en-US
From: Ingo van Lil <inguin@gmx.de>
In-Reply-To: <c9baa43edbde4a6aab7ec32a25eec4dae7031443.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZKg5dgyHATBgZ2WG4CLwkg+A+KGjP4ewZgzEuXIh3VOvIMtKAYT
 0TNzt/ylFq3AAggGBIyLwPWW+lh7sMmmcr0bukViL6rk6lBDokup9fzzCJoRzWp0040IDKZ
 +f97pSXFT/TKXpOdZc1hI6yTavL9UL4SAgz3tM6YKg7OusGJ7BCVIcL1AEAYI90RyS9jGoK
 e+3JohMYkFca20x+hxq4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kavbk4LpglM=;5jp8SVWtArNZVO5D37F5RD5CyUJ
 fC1L2HBS1ZuzcSDVmSZgSLtWPGOwqxe+nurNv8xWIKCJaK1mDZzN4OKX5EKFOQgHNMzuETTsa
 u0VM0LutBVCe1UbQUtRNR3iHRhmyeIqPtBXFrjmUTt0Z62XDOE3TiEOEVrneyUH1WZf+VjR+N
 niaGfSd/sw8YIh5qC2UZDy9BgOnReB9Lzp1Rzkn0Ltro6CGzvKcoGW8ZlaE4e6OJboEcXmJKI
 2SsTHHwjWu9goR0DrrTuEHeva0M0omePvGwjG/uxudp6zOGeAVHamVZy/HM5eQNeMo5T3mtAm
 yuJLHTJRJlzekShsrdSbW0GbIOybieKNQAb5le23z7DZjNOBZLksSPlMKzGWcj9OAHimqw0I7
 93SMh0pp8lm5XKbdegYie+xSBvZXFWzZMI6g9KDivscFvG3tw7u76hH2eV4bjhqVYVcZV5Zha
 n5JpPSIqNSVHididz+Fr7/jqerayAm0v1H6UhlRQQtj4149Y646m2JqAEXmQhJ+XVgVMC/64u
 6Gvc7+X8Eam03dDlKw9rioRMWBG2M8tfGGoHF6sdbuYZ2M1r5BQaKgWcbyENQxcW/0PYX1Of9
 1AmB6RsbgCpT99Z/6B0+GDA1okGo1x8Cz0aIa/Lb7MtZD7lN9YkI/2AvpMrXkfUGtRgMrp+xA
 pcRFpvowOhP7+J+2vWWUyNFRe9b1yy8due2LVxsBSmEfZY5lC+lUG7u9kB2ecpX+FhLeon0hm
 pTKNQojIo1ft2TtynofEOjkLY1TAc6BmCr1GQZrhNYYwQ9v14FZ6z0yOlo7VOgxAUhZ6qve3V
 ju1cQjarExOpTaEMl0pM+jPw==

On 10/1/24 12:40, Sverdlin, Alexander wrote:

>> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
>> index d7aaefb5226b..9c5ac5d6a9fd 100644
>> --- a/drivers/net/phy/dp83869.c
>> +++ b/drivers/net/phy/dp83869.c
>> @@ -645,7 +645,7 @@ static int dp83869_configure_fiber(struct phy_devic=
e *phydev,
>>  =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 phydev->supported);
>>
>>  =C2=A0	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported=
);
>> -	linkmode_set_bit(ADVERTISED_FIBRE, phydev->advertising);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->advertising);
>
> Are you sure this linkmode_set_bit() is required at all?

You're right, it's probably not required. I just tracked a weird bug
down to this clear mistake and wanted to change as little as possible.

The logic of the function seems a bit odd to me: At the beginning,
advertising is ANDed with supported, and at the end it's ORed again.
Inside the function they are mostly manipulated together.

Couldn't that be replaced with a simple "phydev->advertising =3D
phydev->supported;" at the end?

Regards,
Ingo

