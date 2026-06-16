Return-Path: <netdev+bounces-299948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fs0iMF+pMWqGowUAu9opvQ
	(envelope-from <netdev+bounces-299948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17146695039
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:51:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fF1DitCK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299948-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299948-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13251300A8EF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3F3793A2;
	Tue, 16 Jun 2026 19:51:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531937880B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 19:51:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639501; cv=none; b=DUayJo0JUpW2j+UemV+kjti2JjCucZ43K34HceWVs92kXorp9DKgMoSLneb5fBi3RNXYxvNChyy58/hp4ESWfipjzsDDYzOG6O0RwS7rAiznkCl0xJ/+hV0ar4+QMv3JPtkN+ZB5OhLa8J8+ZECUyKc0A93rh6v3Vm9Qym0nt2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639501; c=relaxed/simple;
	bh=GX8N9trKYdtf49eD0j1+zVcA2b1DBWxetvDojTllNZk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LA/KgxBum8srI4JUzKqwHMFVStHuG2lIhB/XEILNLeLnIH75TCQHEhv9c7V1ErgcMt/UE1LQ8jczc+clu8+1kOBIuTMJ8CglQdcr0GhCdpChW1aNxnwK9grnZ2Mlnpgr3TNBcs/XFtUrkN6nnq/JaH2aZYhf+7KSzmCyObLTQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF1DitCK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535511F00A3D;
	Tue, 16 Jun 2026 19:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639499;
	bh=g+d1VjQnWZ4F0rmbmwqYmuKkUshVGKY8qkV/N9ULV48=;
	h=Date:From:To:In-Reply-To:References:Subject;
	b=fF1DitCK8MRaotFhX9WswEPH5XfSSQBeIw5po/YXvTLiJE0WzpcSI6fKfbnxOojzj
	 R4XrVxbRA/h/v1pRUvJ/bwD66XmPvh0cJsPmu8cBTV4FzewaJnOOQXF+rb+NugMIJh
	 U5aYmxSdaQ+4Ppypx7TYLsaepIhCxwdUqEcHeimDEgsBokAUVtcEXxgyPeUC9Ft8kG
	 RMJNhhV4Yslqka/KdXPLUzl/RDiqqOYbP865DT6m4W+WRn8cRJ8cSN111Ja+gNH3OV
	 RbegXrMpYS78tUOObkclC62A/yOTa7vh86E3W9AlaY41Q66m2avlMRXvyJWTJBQ3vP
	 +CB3JHsEwTlkQ==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9FEFBF40092;
	Tue, 16 Jun 2026 15:51:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 16 Jun 2026 15:51:38 -0400
X-ME-Sender: <xms:Sqkxai62Cv2sOk_l4juhCT1ehdtjxijW960pZWGtDdgOsGS3p8fQpQ>
    <xme:SqkxaqJrHZZFcHsdTI8SrEreMklja_bF5BnlGvFZF2lTTIlXcqinXWM4nKV6RElej
    nmqJhDufo9Z0cdfWfI2dpq_DK3NXsecBZEQR1-x5jySwuk-CfLcVQ>
X-ME-Received: <xmr:Sqkxaqyj4AU3jGrmFqveZsNKD73M_YrwWhxLnAd9kUHkg3RpZ36zJY8ZQeiVTlQfUD1VPLwEADtyZcBVkZ-7m4RPGJ5Y0p0nQ7Q>
X-ME-Proxy-Cause: dmFkZTGzIRrfK5fMc/tJSSQmDxLsrUZpcJ7+yMLsmEFII1xd97HLysDFEx3D9J+MXzl4Eg
    8P0Rn6yOupE2fK185tmaAKV2+rpBjZXsDPSD/+g+ZtK8smW+uLnNYfhUBFuB4sAa2jYrjt
    P2fZl6cFVsOPZQ3lkjfs9B1GWyipsgcfhBm6bQ3Og5kEF7JjUwm7ox+McJk7U45tKL1Tse
    3xSAzORzlccg6kn0qURYXaCEB/KQ7l4EqCt1R53U+6qsr+onKYj3L1zCL6eIUrkBsBXsrI
    mf4gfYVvciHLI2AlutFxOLuy/zmiL+y80RvtbT7OKCg1sZbebMTBysaUJj8B+uRb30PLVX
    QqOjrZ2t6h64RVPdKG/A4kcwM8M4MDBzpaxMnu7urNMD/W0n02pbLbII8JCgKnbjZyPoxo
    H45XP7dqL3Dm3ee+LBuwBoVqEYFuxalFsRHVXPVk11FHUhTNfBdlGLb60Uk0p0xA02t2jI
    dbUqL5tC2ciCM+WF4PpFKmQHWoNqcp5hzcZbT9RRRSFsoASQv96aUxIVOBpINzK/ND57Tl
    lfBNd3WOZFLvLHP6zJVFSZE+lYF63cyvEm8zMmesy6Koa58KvucDvIPB3x4MUjZjWxSJGt
    rDjIFbNZ+jV9Zo97qGKAQ93+XJzMlYABYjdckf0e4fl/K0P1r+PXK24FEY6g
X-ME-Proxy: <xmx:SqkxaiILJ1WMDRk2nNJG4jWcZWkuQ3FUvPd-Vrz95vipjHeFxisFmQ>
    <xmx:SqkxapVkw-R4aOQDvUyejVszyz6rWFnuaV2M1evt7SWy4FVuiUWgsA>
    <xmx:SqkxalYcHaB3bLBNDoQMbxnsTPtMvM2iAmrlV4seuT_SyA_ZSmDEfQ>
    <xmx:SqkxagyOc8_XUt1a6RnPjZn73QZQNCRAT1bOvsRhUmFLdrV3wIX-9w>
    <xmx:Sqkxal2AkLMqrlIS8B3IoAR-e80R-oxBKkIOt0YVAGu5gg7_VDVdboIk>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 15:51:38 -0400 (EDT)
Date: Tue, 16 Jun 2026 12:51:36 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 netdev@vger.kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Message-ID: <6a31a948d61f5_9b8551006b@djbw-dev.notmuch>
In-Reply-To: <50d8e423-8248-4e26-901b-010d14d22e67@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
 <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
 <96ee638f-3b10-4baa-a6df-5a79efee8b8f@amd.com>
 <dcc502fa-1a06-465a-abab-9b039b9c2672@amd.com>
 <50d8e423-8248-4e26-901b-010d14d22e67@amd.com>
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299948-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alucerop@amd.com,m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,djbw-dev.notmuch:mid,amd.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17146695039

Alejandro Lucero Palau wrote:
> =

> On 6/10/26 14:56, Alejandro Lucero Palau wrote:
> >
> > On 6/10/26 07:10, Alejandro Lucero Palau wrote:
> >>
> >> On 6/10/26 00:30, Dan Williams (nvidia) wrote:
> >>> alejandro.lucero-palau@ wrote:
> >>>> From: Alejandro Lucero <alucerop@amd.com>
> >>>>
> >>>> Use core API for safely obtain the CXL range linked to an HDM =

> >>>> committed
> >>>> by the BIOS. Map such a range for being used as the ctpio buffer.
> >>>>
> >>>> A potential user space action through sysfs unbinding or core cxl
> >>>> modules remove will trigger sfc driver device detachment, with tha=
t =

> >>>> case
> >>>> not racing with this mapping as this is done during driver probe a=
nd
> >>>> therefore protected with device lock against those user space acti=
ons.
> >>>>
> >>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >>>> ---
> >>>> =C2=A0 drivers/net/ethernet/sfc/efx.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> >>>> =C2=A0 drivers/net/ethernet/sfc/efx_cxl.c | 24 +++++++++++++++++++=
+++++
> >>>> =C2=A0 drivers/net/ethernet/sfc/efx_cxl.h |=C2=A0 3 +++
> >>>> =C2=A0 3 files changed, 28 insertions(+)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/sfc/efx.c =

> >>>> b/drivers/net/ethernet/sfc/efx.c
> >>>> index 90ccbe310386..578054c21e79 100644
> >>>> --- a/drivers/net/ethernet/sfc/efx.c
> >>>> +++ b/drivers/net/ethernet/sfc/efx.c
> >>>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev =

> >>>> *pci_dev)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efx_fini_io(efx);
> >>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 probe_data =3D container_of(=
efx, struct efx_probe_data, efx);
> >>>> +=C2=A0=C2=A0=C2=A0 efx_cxl_exit(probe_data);
> >>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dbg(efx->pci_dev, "shutd=
own successful\n");
> >>>> =C2=A0 diff --git a/drivers/net/ethernet/sfc/efx_cxl.c =

> >>>> b/drivers/net/ethernet/sfc/efx_cxl.c
> >>>> index 4d55c08cf2a1..d5766a40e2cf 100644
> >>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> >>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> >>>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_da=
ta)
> >>>> =C2=A0 {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct efx_nic *efx =3D &probe_data=
->efx;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *pci_dev =3D efx->pc=
i_dev;
> >>>> +=C2=A0=C2=A0=C2=A0 struct range cxl_pio_range;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct efx_cxl *cxl;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 dvsec;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
> >>>> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_d=
ata)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENO=
DEV;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 cxl->cxlmd =3D devm_cxl_probe_mem(&cxl-=
>cxlds, &cxl_pio_range);
> >>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(cxl->cxlmd)) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_err(pci_dev, "CXL =
accel memdev creation failed\n");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(cxl->cx=
lmd);
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 cxl->ctpio_cxl =3D ioremap_wc(cxl_pio_range.st=
art,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_len(&cxl_pio_range=
));
> >>>> +=C2=A0=C2=A0=C2=A0 if (!cxl->ctpio_cxl) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_err(pci_dev, "CXL =
ioremap region (%pra) failed\n",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &cxl_pio_range);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> >>> Dave caught the iounmap leak, but another concern is since you want=
 to
> >>> continue operation if efx_cxl_init() fails then you probably also w=
ant
> >>> to release the successful attachment to the CXL domain if this happ=
ens.
> >>
> >>
> >> I will do that.
> >>
> >
> > Looking at this issue, I think an error when creating the memdev or =

> > during the region attach triggers the memdev removal, but ...
> >
> >
> >>
> >>> Minor since something else is likely to fail if ioremap is not =

> >>> reliable.
> >
> >
> > .. if we want to specifically do that with an unlikely (but possible)=
 =

> > ioremap error something else needs to be exported like =

> > cxl_memdev_unregister(). Are you happy with that approach?
> >
> =

> I have just tested with this:
> =

> +void cxl_memdev_remove(void *_cxlmd)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cxl_memdev *cxlmd =3D _cxl=
md;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &cxlmd->de=
v;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devm_remove_action_nowarn(cxlmd->=
cxlds->dev, cxl_memdev_unregister,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cxlmd);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cdev_device_del(&cxlmd->cdev, dev=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cxl_memdev_shutdown(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_device(dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_remove, "CXL");
> =

> =

> only called if the ioremap fails.
> =

> =

> Please, let me know if you like this approach before sending another =

> version.

A devres group can automatically cleanup after devm_cxl_memdev_probe()
in the error path with no new exports needed from the CXL core.
Something like:

        void *group =3D devres_open_group(cxl->cxlds.dev, NULL, GFP_KERNE=
L);
        int rc =3D 0;

        if (!group)
                return -ENOMEM;
        =

        cxl->cxlmd =3D devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
        if (IS_ERR(cxl->cxlmd)) {
                pci_err(pci_dev, "CXL accel memdev creation failed\n");
                rc =3D PTR_ERR(cxl->cxlmd);
                goto out;
        }

        cxl->ctpio_cxl =3D
                ioremap_wc(cxl_pio_range.start, range_len(&cxl_pio_range)=
);
        if (!cxl->ctpio_cxl) {
                pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
                        &cxl_pio_range);
                rc =3D -ENOMEM;
        }

out:
        if (rc)
                devres_release_group(group);
        else
                devres_remove_group(group);
        return rc;=

