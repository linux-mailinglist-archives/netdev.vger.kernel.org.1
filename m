Return-Path: <netdev+bounces-283765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA89J/Vp+Gl4uQIAu9opvQ
	(envelope-from <netdev+bounces-283765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073964BB258
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8793035AA6
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5A37F01B;
	Mon,  4 May 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPERwZAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634D37F010
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887233; cv=none; b=U77LpwcHOae1apvueq4cLxeafHok5XhR2d81UPAid2uylZ4bSnGrpCfMZygRLx96iaZ8AQKKxoZd4W+zFdacNVSi1f3M5a4Kj8gPmFJw/4e95gtl2WHTNlHpLKvDOV2LL3VVi9PuJEKu+uA+rkFhT7z+FAsNzt0x6JrqDKGu/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887233; c=relaxed/simple;
	bh=CyK600bSpcUvxA2oEnqumwhvBvdD8/TNjAiasJ7K1YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwAuZaQ0SwmO9lXUpq4bLFpl0X68cVpQWPTYgufnEikI46K/7fxx9yid8QPtec8YAv8WD25Eha9KzxCPNnZdsKSC+9jbFibJrbEhPYf/BRUl5DtfiQclQFJfNHvho94ILT7F6vhzK25exRE6I3XKb45AwTwsWfdgosNtbmK2n50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPERwZAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54DBC2BCF7
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777887232;
	bh=CyK600bSpcUvxA2oEnqumwhvBvdD8/TNjAiasJ7K1YM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZPERwZAtJMJuT6qAO5lhMriYlKSY9SgtFD3U+MaZQ8Lff9g3BfjLa+DJLNtY8lvXC
	 8bWG+8BFWxeH9W4FwgXZwW6P742ORQFMpHoqFvaRfcIDJ4Hkuh7dvI6FZKKy2kbqHr
	 xILC9UExiKXQmSGcS3sFyMB3txVuNENNu+ShNkyze1mJns62kSWNnDerg7NOdcKykj
	 ee9VuQ1c4PTeDxW9Lc3CH3jJXzMNDzlz3Z78wVOR30fGIZiqobok76GJBuPmzMOLBB
	 LalQ9VL509NJOClmrb45cm7J73N1tsNd38Q1/WXmpDnxqo2EHkZHpnm31QiiviPEVf
	 sztBrAFMaD36Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a86c1fe573so1821656e87.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 02:33:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+jEE1XIjFW0hRFBY/o5LsG40GC+C7di7gYfg/l5DRNtF6twG+QSLcwSEszssCCwNlU6H5XTIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QJiMf3Jl0LSnUvyA/5NlQqhhFy8FUVrsEl6gWkk08qaeWNA6
	LclIug9bBUd8PENx0m8YLWN7eE2rRYzRz+NTxSdGlzE52BxiATKmyuFOsbeJvIci4dwbsg0Wm01
	Xmfy1ZOPsiiaODyL8JOFdBnyzCVFN1aXeHLNYw18zhw==
X-Received: by 2002:a05:6512:682:b0:5a2:78f8:60aa with SMTP id
 2adb3069b0e04-5a8631c5839mr3050732e87.37.1777887231319; Mon, 04 May 2026
 02:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
 <ca967f7e-d671-4be5-bcc2-30d75fa919aa@gmail.com> <abE6yxLHNqvq2Imz@carl-amd>
In-Reply-To: <abE6yxLHNqvq2Imz@carl-amd>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 4 May 2026 11:33:39 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfADC2ncuUQiSW7TnUwBUWCJn9i=wZ9dqYMZNo2h6qOxw@mail.gmail.com>
X-Gm-Features: AVHnY4JpWj0gJsafJp-8HOpr4-E6aktK4TBIV9WGSFNNuJkNFFpcCHDXtgAANd4
Message-ID: <CAMRc=MfADC2ncuUQiSW7TnUwBUWCJn9i=wZ9dqYMZNo2h6qOxw@mail.gmail.com>
Subject: Re: [PATCH v2] nfc: nxp-nci: remove interrupt trigger type
To: Carl Lee <qq1145099@gmail.com>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com, 
	colin.huang2@amd.com, carl.lee@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 073964BB258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,amd.com];
	TAGGED_FROM(0.00)[bounces-283765-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]

On Wed, Mar 11, 2026 at 11:01=E2=80=AFAM Carl Lee <qq1145099@gmail.com> wro=
te:
>
> On Mon, Mar 09, 2026 at 07:13:18PM +0100, Luca Stefani wrote:
> >
> > On 05/02/2026 12:11, Carl Lee wrote:
> > > For NXP NCI devices (e.g. PN7150), the interrupt is level-triggered a=
nd
> > > active high, not edge-triggered.
> > >
> > > Using IRQF_TRIGGER_RISING in the driver can cause interrupts to fail
> > > to trigger correctly.
> > >
> > > Remove IRQF_TRIGGER_RISING and rely on the IRQ trigger type configure=
d
> > > via Device Tree.
> > >
> > > Signed-off-by: Carl Lee <carl.lee@amd.com>
> > > ---
> > > This v2 of the series includes Krzysztof Kozlowski in the review list
> > > for NXP-NCI NFC.
> > >
> > > This series removes IRQF_TRIGGER_RISING in nxp-nci driver,
> > > relying on the IRQ trigger type specified via Device Tree.
> > > ---
> > > Changes in v2:
> > > - Include Krzysztof Kozlowski in the review list for NXP-NCI NFC.
> > > - Link to v1: https://lore.kernel.org/r/20260204-fc-nxp-nci-remove-in=
terrupt-trigger-type-v1-1-3bde91593173@amd.com
> > > ---
> > >   drivers/nfc/nxp-nci/i2c.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> > > index 049662ffdf97..6a5ce8ff91f0 100644
> > > --- a/drivers/nfc/nxp-nci/i2c.c
> > > +++ b/drivers/nfc/nxp-nci/i2c.c
> > > @@ -305,7 +305,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *c=
lient)
> > >     r =3D request_threaded_irq(client->irq, NULL,
> > >                              nxp_nci_i2c_irq_thread_fn,
> > > -                            IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > > +                            IRQF_ONESHOT,
> >
> > This is causing an IRQ storm on my ACPI device that eats away a core of=
 my
> > cpu...
> >
> > I'm not sure how this should be fixed but by looking at other drivers t=
hey
> > all use irq_get_trigger_type() and then apply extra bits on top.
> >
> > If there's no clear path that handles both ACPI+DT I'll upload a revert=
.
> >
>
> Thanks for the report.
>
> I=E2=80=99ve sent a follow-up patch series that restores a fallback to th=
e
> historically used rising-edge trigger when the firmware does not provide
> a trigger type. This should prevent the IRQ storm on ACPI platforms
> while keeping proper behavior on DT-based systems.
>
> Patch series link: https://lore.kernel.org/all/20260311-nfc-nxp-nci-i2c-r=
estore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com/
>

Hi!

I'm experiencing the same issue since v6.19.5 (still present on
v7.0.3) and the linked patch *does not* fix the problem - only
reverting the offending commit
(57be33f85e369ce9f69f61eaa34734e0d3bd47a7 in mainline) does. I'm
running a T14s laptop with AMD Ryzen 7 PRO 6850U.

Best Regards,
Bartosz Golaszewski

