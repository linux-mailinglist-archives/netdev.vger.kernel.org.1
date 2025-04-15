Return-Path: <netdev+bounces-182884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CCA8A438
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F97A5E45
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AB2147EF;
	Tue, 15 Apr 2025 16:34:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06A1DF963;
	Tue, 15 Apr 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734874; cv=none; b=QFHITFyvECLV5udxeNtgViaxYqyMrYOfsqtvxu3YuugRhJsnTX+cVKEt00bmi7mf8EwQ9pHPTLBSXwrPvw7vpfaNWQvstO9EglviQkS91nGIqudOhmRsfma4AETpXGPixv0iKnKwTx1iqh38YrzU/Tu4fg7lVN0tnCAUGCcdGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734874; c=relaxed/simple;
	bh=Cf9se2zTleLRQBiig193MxIvcQgdOvlF39P3Grsjqp0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQmoRbMtjlrtN1IS5qPnjVn29dlm4+bXWTtbbZzUlYgYH+eQuKw2SXtPYPAAk7STtIouoanUuU6ZUg0r8ZjoGyTzTONW6prKXAIgzMLVQy2A0QcAzkHiMdMI9b3mzjMcEcOROZJZcW0uDqwl5mrEWzdgAmd9OdMP8DyE75babNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcV870S8Hz6L4y0;
	Wed, 16 Apr 2025 00:33:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 77C19140144;
	Wed, 16 Apr 2025 00:34:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 18:34:28 +0200
Date: Tue, 15 Apr 2025 17:34:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, "Ben Cheatham"
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 05/23] cxl: add function for type2 cxl regs setup
Message-ID: <20250415173427.00001dfc@huawei.com>
In-Reply-To: <320c4b16-2029-4792-9288-8ccf99bf07cd@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-6-alejandro.lucero-palau@amd.com>
	<20250404170329.00000401@huawei.com>
	<320c4b16-2029-4792-9288-8ccf99bf07cd@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)


>=20
> >> +	 */
> >> +	if (rc =3D=3D -ENODEV)
> >> +		return 0; =20
> > Hmm. I don't mind hugely but I'd expect the -ENODEV handler in the
> > clearly accelerator specific code that follows not here.
> >
> > That would require cxl_map_device_regs() to definitely not return
> > -ENODEV though which is a bit ugly so I guess this is ok.
> >
> > I'm not entirely convinced this helper makes sense though given
> > the 2 parts of the component regs are just done inline in
> > cxl_pci_accel_setup_regs() and if you did that then this
> > accelerator specific 'carry on anyway' would be in the function
> > with accel in the name.
> >
> > 	You'd need a
> > 	rc =3D cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
> > 	if (rc) {
> > 		if (rc !=3D -ENODEV)
> > 			return rc;
> > 	} else {
> > 		rc =3D cxl_map_device_regs();
> > 		if (rc)
> > 			return rc;=09
> > 	}=09
> > though which is a little messy. =20
>=20
>=20
> That messiness is the reason I added the other function keeping, I=20
> think, the code clearer.
>=20
> Note that other function is only used by accel code, but I can change=20
> the name for making it more visible:
>=20
>=20
> cxl_pci_setup_memdev_regs=A0 ---> cxl_accel_setup_memdev_regs
That works.

>=20
>=20
> >> +
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> >> +}
> >> +
> >> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_sta=
te *cxlds,
> >> +			      unsigned long *caps)
> >> +{
> >> +	int rc;
> >> +
> >> +	rc =3D cxl_pci_setup_memdev_regs(pdev, cxlds, caps);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	rc =3D cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> >> +				&cxlds->reg_map, caps);
> >> +	if (rc) {
> >> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> >> +		return rc;
> >> +	}
> >> +
> >> +	if (!caps || !test_bit(CXL_CM_CAP_CAP_ID_RAS, caps)) =20
> > As before. Why not just mandate caps?  If someone really doesn't
> > care they can provide a bitmap and ignore it.  Seems like a simpler
> > interface to me. =20
>=20
>=20
> Not sure what you meant here. This is not just about knowing by the=20
> caller the capabilities but also mapping the related structures if presen=
t.

I meant the !caps variable not being NULL. Just mandate that there must be =
a caps
bitmap passed in always.  Caller can throw away the value if it doesn't wan=
t it.

>=20
> The now returned caps is useful for dealing with mandatory vs optional=20
> caps which the current code targeting Type3-only can not. In other=20
> words, the core code can not know if a cap missing is an error or not.
Not that. Was a much more mundane point ;)

>=20
>=20
> >> +		return 0;
> >> +
> >> +	rc =3D cxl_map_component_regs(&cxlds->reg_map,
> >> +				    &cxlds->regs.component,
> >> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> >> +	if (rc)
> >> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> >> +
> >> +	return rc;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL"); =20


