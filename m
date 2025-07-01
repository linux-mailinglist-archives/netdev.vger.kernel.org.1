Return-Path: <netdev+bounces-202978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDFAF006D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C6F4A5644
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95FE1F428F;
	Tue,  1 Jul 2025 16:44:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18C276058;
	Tue,  1 Jul 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388247; cv=none; b=pTuW0iYf44k7w/49uHfyT+5dEReIzJLXoiDMm0EG0YIpfjVnu3aPej8HJWeDahgJDmXhKaxvwqM+KMw07ILT1HtJYV9n6O8F96ZdHyUaG/UHjEL1xNKUqxPTdC0q/Iw6B2ghrg9X1lxk4wsRszsigKHeSiKmY6jFwjz28kxwVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388247; c=relaxed/simple;
	bh=icP6GQ+jTO5MvEfK/FVAT62KM9tODwB9qKuOq+5G2Z0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObLH2MAVMTr7wNAuWjTzaHs9Pr+nDKCfpinPCGs5oAtu5SMS1kpgBI7Uc+E+PxSaE5+dhebTjtmm8cQFtJUU5kSYI+jTPL3/4S81HEPvL0w/eWsq3X76SiYu+sHzHqnknLu+9GgXr57enou/Qupv7kskx0zzljS/H4W+8DBUntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWpgq2mw8z6L4w0;
	Wed,  2 Jul 2025 00:41:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 39F8714011A;
	Wed,  2 Jul 2025 00:44:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 18:44:01 +0200
Date: Tue, 1 Jul 2025 17:44:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Message-ID: <20250701174400.0000339b@huawei.com>
In-Reply-To: <b29bf20f-456f-4772-959b-2287ec0f54d4@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-11-alejandro.lucero-palau@amd.com>
	<30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
	<20250630172005.0000747c@huawei.com>
	<34d7b634-0a4f-4cbe-a96f-cd1a8cea72ef@amd.com>
	<b29bf20f-456f-4772-959b-2287ec0f54d4@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 1 Jul 2025 09:25:44 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/1/25 9:07 AM, Alejandro Lucero Palau wrote:
> >=20
> > On 6/30/25 17:20, Jonathan Cameron wrote: =20
> >> Hi Dave,
> >> =20
> >>>> +/*
> >>>> + * Try to get a locked reference on a memdev's CXL port topology
> >>>> + * connection. Be careful to observe when cxl_mem_probe() has depos=
ited
> >>>> + * a probe deferral awaiting the arrival of the CXL root driver.
> >>>> + */
> >>>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd) =20
> >> Just focusing on this part.
> >> =20
> >>> Annotation of __acquires() is needed here to annotate that this funct=
ion is taking multiple locks and keeping the locks. =20
> >> Messy because it's a conditional case and on error we never have
> >> a call marked __releases() so sparse may moan.
> >>
> >> In theory we have __cond_acquires() but I think the sparse tooling
> >> is still missing for that.
> >>
> >> One option is to hike the thing into a header as inline and use __acqu=
ire()
> >> in the appropriate places.=A0 Then sparse can see the markings
> >> without problems.
> >>
> >> https://lore.kernel.org/all/20250305161652.GA18280@noisy.programming.k=
icks-ass.net/
> >>
> >> has some discussion on fixing the annotation issues around conditional=
 locks
> >> for LLVM but for now I think we are still stuck.
> >>
> >> For the original __cond_acquires()
> >> https://lore.kernel.org/all/CAHk-=3DwjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=3DH=
gPdvJbgrvASfA@mail.gmail.com/
> >>
> >> Linus posted sparse and kernel support but I think only the kernel bit=
 merged
> >> as sparse is currently (I think) unmaintained.
> >> =20
> >=20
> > Not sure what is the conclusion to this: should I do it or not? =20
>=20
> Sounds like we can't with the way it's conditionally done.

All you can do today is hike the function implementation that conditionally
takes locks to the header as static inline and use explicit __acquire() mar=
kings
in paths where you exit with locks held.

Here's one I did earlier:

https://elixir.bootlin.com/linux/v6.16-rc4/source/include/linux/iio/iio.h#L=
674

static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
{
	if (!__iio_device_claim_direct(indio_dev))
		return false;

	__acquire(iio_dev);

	return true;
}


That exposes the marking so sparse can see it and correctly track the locki=
ng.

Or you could step up an maintain sparse (I've been trying to talk someone
into doing that but no luck yet ;)


> >=20
> >=20
> > I can not see the __acquires being used yet by cxl core so I wonder if =
this needs to be introduced only when new code is added or it should requir=
e a core revision for adding all required. I mean, those locks being used i=
n other code parts but not "advertised" by __acquires, is not that a proble=
m? =20
>=20
> It's only needed if you acquire a lock and leaving it held and then relea=
ses it in a different function. That allows sparse(?) to track if you are l=
ocking correctly. You don't need it if it's being done in the same function.

Exactly right.  There is work on going I believe to make this work
with LLVMs tracking, but right now that is too simplistic to generate
reliable results.  Note that sparse also sometimes gives false positives
if the code flow gets a bit complex but mostly that only happens when
the code probably needs a rethink anyway.

For now I'd go with do nothing here.

Jonathan

>=20
> DJ
>=20
>=20
> >=20
> >  =20
> >>>> +{
> >>>> +=A0=A0=A0 struct cxl_port *endpoint;
> >>>> +=A0=A0=A0 int rc =3D -ENXIO;
> >>>> +
> >>>> +=A0=A0=A0 device_lock(&cxlmd->dev); =20
> >>>> +> +=A0=A0=A0 endpoint =3D cxlmd->endpoint; =20
> >>>> +=A0=A0=A0 if (!endpoint)
> >>>> +=A0=A0=A0=A0=A0=A0=A0 goto err;
> >>>> +
> >>>> +=A0=A0=A0 if (IS_ERR(endpoint)) {
> >>>> +=A0=A0=A0=A0=A0=A0=A0 rc =3D PTR_ERR(endpoint);
> >>>> +=A0=A0=A0=A0=A0=A0=A0 goto err;
> >>>> +=A0=A0=A0 }
> >>>> +
> >>>> +=A0=A0=A0 device_lock(&endpoint->dev);
> >>>> +=A0=A0=A0 if (!endpoint->dev.driver)> +=A0=A0=A0=A0=A0=A0=A0 goto e=
rr_endpoint;
> >>>> +
> >>>> +=A0=A0=A0 return endpoint;
> >>>> +
> >>>> +err_endpoint:
> >>>> +=A0=A0=A0 device_unlock(&endpoint->dev);
> >>>> +err:
> >>>> +=A0=A0=A0 device_unlock(&cxlmd->dev);
> >>>> +=A0=A0=A0 return ERR_PTR(rc);
> >>>> +}
> >>>> +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
> >>>> +
> >>>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port=
 *endpoint) =20
> >>> And __releases() here to release the lock annotations =20
> >>>> +{
> >>>> +=A0=A0=A0 device_unlock(&endpoint->dev);
> >>>> +=A0=A0=A0 device_unlock(&cxlmd->dev);
> >>>> +}
> >>>> +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL"); =20
> >> =20
>=20
>=20


