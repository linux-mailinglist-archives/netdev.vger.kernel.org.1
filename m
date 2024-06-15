Return-Path: <netdev+bounces-103785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C349097E5
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D056B20F00
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA72561D;
	Sat, 15 Jun 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HqjmOBtS"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3436179BC;
	Sat, 15 Jun 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718450180; cv=none; b=jqFFEMFIuVRCAMSohmHpgXAn+She3nrKRYyfg3LY6QimyCYrYyP+f2nICc8gPrtBwv700U9kYVp52DjE52mBDFkzKQgQ0efOna7Q5lvO/f3JUfCYC12lHSbCJalV4jJKomh4P6AC0e/TAjD/9m+Y+IlxPJcs3WDatlIGic4uJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718450180; c=relaxed/simple;
	bh=43ZgOL9YKF8h621TBgkfyaGeYGcUg0kFE7OE3DmN7n4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=h2AVWhAj7gOXF/aSRnwzbc4H7qgzsVI0qIOdeXkboMeZTaIbDc6ovP/tqv3c6JMFM94QiWevvychqbtwsWYb/b7duujci1leNCJCJ5etFrY0USW4y8bZVr25rFyOaHp3pO+2bqGOiCpVah/7yjdHTgSLdb8R4RoPQzubkxe2vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HqjmOBtS; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718450142; x=1719054942; i=markus.elfring@web.de;
	bh=GVe2jkxEYkenXyOm2W4BRSWAV7lrAsxmZvBTV2Z3Q1Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HqjmOBtSnGPk6zK4zIXPujK33WWTveCin2WuDJ7mLZZVL8anGQDfs50eqKJ432pz
	 I4V1sAQu/2BsG8RObqEFJgwQJKIM/EZYiKouCzPuv+2yp8RAZiHMa6pG8xHzDHIl0
	 ZhTYM/JEPIxVrEomknBRzHyKLps+bzFXc7/hIekW5qm6bczPlp2Ran8CS8GjYi+7J
	 MT+yTWoJW3V1RTxrZPX6C1fFNsLW7dCGDgFzi4diAbPPpXZje3YNRyC3h7mCGZ0OI
	 YIvOkEdVnIjfqO9c+XWURTHUeu3lHaPXZBcrfazZZ/dxprv8Nr69U+9U/Ily/suik
	 qAhPij7WMZ6UmTcJow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgibW-1ssrWU2sqy-00npTp; Sat, 15
 Jun 2024 13:15:42 +0200
Message-ID: <98cf0387-eb8e-492b-a78b-b21e3f6dd7e3@web.de>
Date: Sat, 15 Jun 2024 13:15:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hariprasad Kelam
 <hkelam@marvell.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
References: <20240611162213.22213-2-gakula@marvell.com>
Subject: Re: [net-next PATCH v5 01/10] octeontx2-pf: Refactoring RVU driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240611162213.22213-2-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NSdjg9D5vhbBbGqE0umagq3x2FwiXii9Hzx58V8GaWL8lclQtPb
 RPpIhhyL9jeVaNRIgONDLN8aijVQGSl7btMULbAz9wRDVJkWPt4radTxL58zdAjUOdY9p+H
 j03ClgPxj+cl2O8x1lmB70hwVhnqDer2Y/0UXNQi7EcE/GOswfRBYNFgdeCTSetYQu4QjfJ
 YxXkglWt2EF/rZe20Bhug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uTBMgqz8/C8=;qrdO8M4BMDbaK2d2cE0VowkzJlc
 9ZBRjWrwDtEvL4fbUchakKlRbJ8y5lyK+5g79jrznRW8v1Xu21g4aU2tSOIiMT1Oj/KHkYu+3
 Snr0IoIaxAe25HS9csndxZy+YUbAKJ7auGfJtwf+4/vUYFOWFNlMvx+DGv3uB2VKKeMjx40Sm
 hv9Ca3LxPJgsVyOAI1vnoGJhxyGU4Yfo74bSSb4M8KojiysQG0damNuQr7xOkY2wIojVj3A34
 OnGNsoa4jO4jNk2TNdbnvmVNX2dpv805f8txt9U0CptYd5Rdo3K9gOdIoqC2APFN/Yztu2Rt7
 PRTL7+r2KVAsap1b2X+ilozlPwwlzCI4gk73iI+8FbPXnyKtY/yW8cvWi2p2zsQvDEHYz/XCE
 fm7ADKcKqq/eY9bm4knscgWh2+zIWBRK26aGK9Cr+f3JK1Ogr2rSqEkuD8p6IuH/gjo3z6r2j
 VCXUykff+qK3b0YVJPVmbaejjkIACTbdtPtHqtZ5WMCy9upYFKzYiouF8DOT2dR/3N75mA9n8
 /QSjQ35r08Bw+V8yfHXX13Cmyw1aGaWBiktsMT3RIjPlrDrD+BYrIIwGWTDGYh4lfyxa7euHv
 VFn5MMOgEeYTl1nlx4ux0odPkSgvOGMFv17lZOl1tBatCXBbXPTkHGjuHFXvJCPmymaY30TAX
 h8RLPvNV0xIE9UKCcoP9nbZY9rJnPAOGsWDMGym0ab8sO5hgXS/gw1kpKun2dhv4ACWxG90xH
 74l7jtaQ8gUaDQ3G9yV214JG93fx5E1znAnLCOUkZ+iE/z6rZjPrflWeQEgSrjRaoigerT5H6
 l6uB5mp3gCv7ovCJnpKF/U73ONY+r5dsipnw7NMkwMqPM=

=E2=80=A6
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
=E2=80=A6
> +void otx2_disable_napi(struct otx2_nic *pf)
>  {
=E2=80=A6
> -		cancel_work_sync(&cq_poll->dim.work);
> +		work =3D &cq_poll->dim.work;
> +		if (work->func)
> +			cancel_work_sync(&cq_poll->dim.work);
=E2=80=A6

I suggest to use the shown local variable once more.

+			cancel_work_sync(work);


=E2=80=A6
> +int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)
> +{
=E2=80=A6
> +	return 0;
> +
> +err_detach_rsrc:
> +	if (pf->hw.lmt_info)
> +		free_percpu(pf->hw.lmt_info);
> +	if (test_bit(CN10K_LMTST, &pf->hw.cap_flag))
> +		qmem_free(pf->dev, pf->dync_lmt);
> +	otx2_detach_resources(&pf->mbox);
> +err_disable_mbox_intr:
> +	otx2_disable_mbox_intr(pf);
> +err_mbox_destroy:
> +	otx2_pfaf_mbox_destroy(pf);
> +err_free_irq_vectors:
> +	pci_free_irq_vectors(hw->pdev);
> +
> +	return err;
> +}
=E2=80=A6

Would you become interested to convert any usages of goto chains
into applications of scope-based resource management?
https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/cleanup.h#=
L8

Regards,
Markus

