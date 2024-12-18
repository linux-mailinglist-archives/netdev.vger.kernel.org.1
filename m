Return-Path: <netdev+bounces-153096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C29F6C6D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24341694F0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0321FA241;
	Wed, 18 Dec 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bIG/fc30"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728D175D34;
	Wed, 18 Dec 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543546; cv=none; b=P4Vlr9LnFf6dtQzSY/67RMmxMmEj+Nd2ywC2l4YF8LpwGAdIF+uklmRDPbN9ZaIypN7Apb9ht+uYK0Z8FwR3PKJtSRsBUVAcR5PsLo84+PmhqULLQthX++MA3+I2CQunwb1yHmlT6X+DtZAZvCqR/fYISpwpAtGPELoFn1vSmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543546; c=relaxed/simple;
	bh=U5S4MwYDBf+wwJoNz8uVZzm4gZ937iYPGnjPcLwGL6w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=izPfV9gckurmHs6mwPyS2/3kyr4z+CzOkr6omJLQSgB5SV7vPcvAvjN+dGUhnjA2q0YYlb2vlLofhrKL6BeN4mRAEYrW6BWWcJ+mcro4dZfRR1WJR8Yqkrr3O3Art0pKeYxIGN9wO1iUXaNNOa0+d6ALhpkQ+iQJiwchdlYrm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bIG/fc30; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734543510; x=1735148310; i=markus.elfring@web.de;
	bh=k7t4oNaWZUmDndsSIfmlqR6PmTTjsV953prQswRMY6M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bIG/fc30zWhLuiQOSbsD7dn/pQryB+u1z59yt8dCcVFQ3WPzR6WDOOdxVgrdZgDZ
	 kep8rWQHlg9JDUYtElIy5FIpnpAWhVSMbGYANOAaHCBazxW+OQ/8x5lS9reoace7K
	 s6ablZ3WlXgSrVYT+hsgBysnzmclYu3xDP2nXiq33n+zsJ+to3y3/OS7xs/lix/Iy
	 DvKZuSjd3o432MnZvLCSrjbtKlJXb2+HKgGNsGeP12hmSDC7DxkSzmzz9sSzPM07F
	 Ho0hWTdsWQFPGJj4zbZ+RvK1+4e0TQSOT9XlXIeZMk+gwOWMdNVjmbzCuLR85wm1N
	 lvy5EHDq6cS18bcy9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.41]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVGC-1tfDwC2FVK-00rZPs; Wed, 18
 Dec 2024 18:38:30 +0100
Message-ID: <8d54b21b-7ca9-4126-ba13-bbd333d6ba0c@web.de>
Date: Wed, 18 Dec 2024 18:38:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH net v2 1/2] octeontx2-pf: fix netdev memory leak in
 rvu_rep_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BZjLDS3M5wjs76RkCTAjAg3DkmyAwsH8MfCz5p8ay1IN0xq8HYY
 bJirIjeIXtU1Z/gwK39OG9Y6NnWi66v2Zi/xIU77cnXhwkV7Ecet583igkIr+olwXaYghRZ
 qDB1lLOfsiduqovUynqPlp9YUeprg43yz9F4t6DjTBkq7CkSSFruwizn3GgZjmd1qSuA4XE
 T4bZ21S6cIUTaiWKO3AGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZUrw+YskXEE=;a/q1Vn0849OChlob+xMuzKY4leV
 STiYjNoYFO3WDQrYEuoSca64x7sV5tTZAv++89A0fMiRVpcPU33lSYhkVkosqEDrXmnymPE7g
 SHzgLRgh3rZCfoTzbWtv19Cj5uELx+r062ZaPTXuzm8h5Evo2TdjCbKaQ06OcNjJ8FK3xZoPX
 I7KS1N6ohipwHI8H1VTe0dB8ewkk2olug1r2kCjMlyfYoQXCObdJwuz5m+5tTdl6nOrxl36t1
 SbNDJ/0QSBtcJZe/zaRYnhUpIByCCJSvvOhD38BwlGaFHycBjkwBpmzlQ1Gwt87LgJ4HNrx9P
 AVekNw7WDT8CVJdqnJcTU6JO1gc21JCA9aI1TDm/aga/fztA56wXlKIPgT6Ypke5WocflnZcB
 ofIhWHD56lRmogY+epFbbXNFkh3VxygUQsBdxcvq1RxyaedpBhlA7tVhY1wk8HnHoQWLMWFSC
 bwSNmtzUQ2+Y2l7dVZ/XL47RoBXABhUvZ/BYyf4gdRX30KNfEO4n+mKWjZ2XZNSCUiTX7E1TF
 d1+79AGT+vT4JduYyHvOPjQPYmpkCXUwVfvxrics6Z8XqMkkbUhV7uGji7Kpt4t0FNzZfVIFB
 N69eTfEqAkp6H0ShdBwIW37+V5VEGpVxr5L74s7BUQ5RLeQc3KzCclaG604Dgw5a2EnDdmE84
 JocdYuoDZamMoy0eGoTeDCqEqNol68tAIP1IFHKD2L90sGlRFxDhLhFIKBpH4Jt+OSrWSpO92
 B6b5tPrz0FsiLdzZxEg67OHjN0FNerf/348GPoQzr3WyD/TTw4cwp2lRUAOWEqRDZq8LvgN76
 phTtG01RfUgKlB1jEOfgzfY61jMDvoNprQX3mmTQnLcbpSeZ7iQfBE2YplVbLKHQVtqKaS5W7
 6ri38oyngFzJXE6YzktCXUDRuuHJGfVFfPvRlRJ75XkpCuDctjJ+IE7eTZb0NwSl45abE8fPZ
 ksusK3vUD9juRG4U1tIHCIhjnqLk48Xh1vKxhjClPo0luLvfUNcmZPT2qkcDrPHdAiEwUgs8K
 Ex9NX/mumM8GCWCc9OAG34uwH/0gPx7/17CdwqdYa+8dp3SpMtleJKgXGjhrxsNvwUoTTesjj
 H7sKD6HE0=

> When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
> incomplete iteration before going to "exit:" label.


=E2=80=A6
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -680,8 +680,10 @@ int rvu_rep_create(struct otx2_nic *priv, struct ne=
tlink_ext_ack *extack)
>  		ndev->features |=3D ndev->hw_features;
>  		eth_hw_addr_random(ndev);
>  		err =3D rvu_rep_devlink_port_register(rep);
> -		if (err)
> +		if (err) {
> +			free_netdev(ndev);
>  			goto exit;
> +		}
>
>  		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
=E2=80=A6

I suggest to add another jump target instead so that a bit of exception ha=
ndling
can be better reused at the end of this function implementation.

Regards,
Markus

