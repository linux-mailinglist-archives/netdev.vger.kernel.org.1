Return-Path: <netdev+bounces-251815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNPDHf2bcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:27:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B1545A9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 893E75A5C4F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963A53F23B3;
	Wed, 21 Jan 2026 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="HLNojPJq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52B47B41F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987085; cv=pass; b=gELYrxSPp2NNZg35RdVPwx1tvNsiG5tSLxD+4TKA0vFGnuBVRmVtIeDbGi7K11mASkYck72I+k8p402gWnuvBgzkGazGgDFq8JFaSl2ZRG3yZ5xAssZOPXanOdUgmHkfuxRwPAR+8hQ/wh3UOtN0IKeE97EvwtpoobEBrtds7q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987085; c=relaxed/simple;
	bh=xsvOAbp/C+g24JngKUZBpQiuy41zDZPgNC5Ufv40cgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2dmW16UmCSDkEZDACwb9UQK3MhzPY9wj4+zsczoLfCnXapNIJwsol5p3kuFcIemv2bpUDGOVMmRMMcNQE9hqBu9kRi07nA8I4PcB/lyS0pRytd8qMjkhPFD+Ce17sCCg3wjFY/1g4zRTe4QQL48D5q8F3rJbIVX4Sc762VqepY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HLNojPJq; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 473D0400E1
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1768987080;
	bh=PydhRFPA87ZN8oI4CEGXyPaEIWMyP81bX5pZ66LYOIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HLNojPJqqKaKEwE1AZ31IIpUadPM5nygcJFZgfIE2e0s1X4Hevzgp8CbBfEtOlkHc
	 VbOVLPvMWE5z285mn8zTNPSPiL0IsKDCjQu2ZVpSPO/k9dU++QjXVIeCGel5CXrbk1
	 Hl5Osmok13ymxszZIGKfiD/hLSxsxi7PiEbsQNC4FmigirhDvwrqapdmCV8vCFicVH
	 ZJkbP53oxJvMxaHDX3C9qwV867LowewxpO2z9T2bR4R/L3EbnaIS4Zs12R0dxETveA
	 FRX3aH+Js/3oYveWb2ilI3Te9y5t4THe6gdY9+2yl3N+X5LqNj4/gnwLeEjCeOfkBO
	 G/xQlhFvU/Z59y8BGUJ5z6kFsQrzT7MoK4zyJak6y3eGRJ9RX4XUNfJJuQ22ZaK7Ic
	 z5Jit2b9Rf6lZWkphr8Jy4FQEjEoAEtY83Oc/quehLbiciFaqAIiK0krwPoEA3pHjF
	 2pI6BAB793FEgQTEusKSmhgg5mbTHt0rz0X/isX/uymKn0dsmdq+B96mb6unApNQfM
	 j0F6cCmrDfk93spyjDxu32+gIz3m09kQjloUGMgCekxLezWhnZ/WF8cwFheLj9zKal
	 3QVG8nFoOsbNtWQwrTFPoRJJuxX8Un93Py8oc63v4nSKIPWvL9e1xjkTRTAsoRLM03
	 Iq4PegBoPehLprBDsC9J3p/g=
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1233893db9fso1934218c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:18:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768987079; cv=none;
        d=google.com; s=arc-20240605;
        b=XV1D+nL+Cxy14z9Jw9qD2wJciJgeWhV1h95fEJkclnqU4EVo6Tdm2ZA7QPCjJ+tspw
         svJK8INLLcQb61pZbQ8qYK6XHYnagkPiFusFKVDQTo47G2K7SLEAeh0vDlIdloBT0XZQ
         fQrIb0RylDqZ0s3pa7ut2rOzfyd31TeRL0ghdyFKRYRl8jSXrxElZ5banrVbFLb+mnrT
         4Pv1m0wd75RN4hk+vYNgiSmhKQzW37RDcD5/uza6PQ+RVElFf0eFcpywYXDqx0iIdFYr
         nl4WF6dTYnLUQXK8gPgWAreMlKfsu98/tBqLJxECjjIlkzHirtYBqa1/6s6W5lGCq8Kd
         KkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PydhRFPA87ZN8oI4CEGXyPaEIWMyP81bX5pZ66LYOIw=;
        fh=Qs9L0NPLRcGS52lHqHAtp9CCVvlqAdx10p4FQWBUJXk=;
        b=bGZNJexLHubMo2AVZG85RGWWufXGqWUCm7jYv98yO0w2JlLn1p116yRS4MOleZFy56
         vgVL5iQbgp7t7yP7PjIPU0wz7qJMrRifd369B0C+8uy2htCmGshFiCNwyH9o2VnSGDtK
         M1aqeh4ymeJb9zOk5SQKO82Hp7TiRwMWwYPS1Ayn77p9fEJHHJHj+ITIbby1U95ISwug
         1myJHEKmdtK1O7svFXqt7/ZbtXwmrv/kFHfCIJytRodp6I4tJxyaXLTSWPoyAFYwOz3Y
         clQJX7VFxYsl2M4D1L+Y2ddb99nCPzcsz3d1cFbA3CLAWrz2OA/MzfSbt3UQ59Z9dx6H
         zzEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987079; x=1769591879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PydhRFPA87ZN8oI4CEGXyPaEIWMyP81bX5pZ66LYOIw=;
        b=qzUFb4dOBDJhaL1VNlIpmgR0YX5Bv7HA5gNs1u6Lks0eKB2Q+GlOLzaonCHrJcKeJ1
         Nfdx+7N0LId0dcOg1dA9JDeQRdnZVK7YOCv+xBjlTsnfeLrWqpAz0DV94kXnNbjtJlV0
         BQGHxAoOXMrVCWO29s4k+N6j5LzlThyR/emR+XR6I6794DcyWAIskccjfQx2KTfDT3dm
         8f7LBttrTj1o+JlzzegzXznsy3XBbqqd/nwclcNiLDcoACnCMiP4cvXfZfO6wDyK1aFB
         dc5hv90ws61jgcID3iqoWeB2TPq4OMH40w1zVWSfxn8eE2YpvtuIZ6DBsWzF2KtJ5lbK
         fJcg==
X-Forwarded-Encrypted: i=1; AJvYcCVdt1avzNYQRN30is2usMTBjt5gBpfm5LDxhRn2tQQAsU1Leo20hBEu1dTzol64bQMkpPPOaC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw7hGY83eqFU63Tsekm8DwhGeUVKCFx8mfugnqn3qmucYp/Gv1
	6XJvU9namD4a5PMUVgF72aLfbzloqUiPmxHElBd7KcDJeqvowTIq6AfYaKl7UcE1yQY4bioMM4J
	BrDUSdeCsIdtjF0k3He54RtgaACOJBJYIPerB/Pn36hrvNN/vLB5/dqnDfcUL/PxzrPWEZBWIWR
	1gNwIAe379SxJVCXt0f6F/C7FvogGvdbxKRYvUx0in+B1YRSOb
X-Gm-Gg: AZuq6aKwIJ8lNzYdl4Xo2i5mc4RhtE6ihGutdiRKuwj2LgVWlqTgtxW6cg7EAztBnpH
	CvhbeRbdCHBP8VfqKHlrIZDowCUsEF06URg2mWBOY+FscfCmmjYVZn7sz40NUciytWtt7WCJPAc
	XCeLn+wVdgPmFiQgFf6UchW48SCu0nT+QtF6p/ECY8HykA0Jtt91Srk5a9m7q81Spobg==
X-Received: by 2002:a05:7022:e03:b0:119:e569:fb91 with SMTP id a92af1059eb24-1244a6592d5mr15161372c88.0.1768987078732;
        Wed, 21 Jan 2026 01:17:58 -0800 (PST)
X-Received: by 2002:a05:7022:e03:b0:119:e569:fb91 with SMTP id
 a92af1059eb24-1244a6592d5mr15161362c88.0.1768987077983; Wed, 21 Jan 2026
 01:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121075106.401770-1-aaron.ma@canonical.com> <IA3PR11MB898667FBC0C4394FF41B003DE596A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898667FBC0C4394FF41B003DE596A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Wed, 21 Jan 2026 17:17:45 +0800
X-Gm-Features: AZwV_QjtgO59u7CXRMqjpSdGIrULmhwWmJsg7sllbumDMtrUmhuuew1AYPZyBN4
Message-ID: <CAJ6xRxVxLbHFZu3CqT37MF4br9Sj3HJ5nwb=qo3kNspymp38WA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ice: Fix PTP NULL pointer dereference
 during VSI rebuild
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[canonical.com,reject];
	TAGGED_FROM(0.00)[bounces-251815-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,canonical.com:email,canonical.com:dkim,osuosl.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: 198B1545A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 4:21=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Aaron Ma via Intel-wired-lan
> > Sent: Wednesday, January 21, 2026 8:51 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH] ice: Fix PTP NULL pointer
> > dereference during VSI rebuild
> >
> > Fix race condition where PTP periodic work runs while VSI is being
> > rebuilt, accessing NULL vsi->rx_rings.
> >
> > The sequence was:
> > 1. ice_ptp_prepare_for_reset() cancels PTP work 2. ice_ptp_rebuild()
> > immediately queues PTP work 3. VSI rebuild happens AFTER
> > ice_ptp_rebuild() 4. PTP work runs and accesses NULL vsi->rx_rings
> >
> > Fix: Keep PTP work cancelled during rebuild, only queue it after VSI
> > rebuild completes in ice_rebuild().
> >
> > Added ice_ptp_queue_work() helper function to encapsulate the logic
> > for queuing PTP work, ensuring it's only queued when PTP is supported
> > and the state is ICE_PTP_READY.
> >
> > Error log:
> > [  121.392544] ice 0000:60:00.1: PTP reset successful [  121.392692]
> > BUG: kernel NULL pointer dereference, address: 0000000000000000 [
> > 121.392712] #PF: supervisor read access in kernel mode [  121.392720]
> > #PF: error_code(0x0000) - not-present page [  121.392727] PGD 0 [
> > 121.392734] Oops: Oops: 0000 [#1] SMP NOPTI
> > [  121.392746] CPU: 8 UID: 0 PID: 1005 Comm: ice-ptp-0000:60 Tainted:
> > G S                  6.19.0-rc6+ #4 PREEMPT(voluntary)
> > [  121.392761] Tainted: [S]=3DCPU_OUT_OF_SPEC [  121.392773] RIP:
> > 0010:ice_ptp_update_cached_phctime+0xbf/0x150 [ice] [  121.393042]
> > Call Trace:
> > [  121.393047]  <TASK>
> > [  121.393055]  ice_ptp_periodic_work+0x69/0x180 [ice] [  121.393202]
> > kthread_worker_fn+0xa2/0x260 [  121.393216]  ?
> > __pfx_ice_ptp_periodic_work+0x10/0x10 [ice] [  121.393359]  ?
> > __pfx_kthread_worker_fn+0x10/0x10 [  121.393371]  kthread+0x10d/0x230
> > [  121.393382]  ? __pfx_kthread+0x10/0x10 [  121.393393]
> > ret_from_fork+0x273/0x2b0 [  121.393407]  ? __pfx_kthread+0x10/0x10 [
> > 121.393417]  ret_from_fork_asm+0x1a/0x30 [  121.393432]  </TASK>
> >
> > Fixes: 803bef817807d ("ice: factor out ice_ptp_rebuild_owner()")
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_main.c |  3 +++
> > drivers/net/ethernet/intel/ice/ice_ptp.c  | 26 ++++++++++++++++++-----
> > drivers/net/ethernet/intel/ice/ice_ptp.h  |  5 +++++
> >  3 files changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> > b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 1851e9932cefe..2f5961573842d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -7814,6 +7814,9 @@ static void ice_rebuild(struct ice_pf *pf, enum
> > ice_reset_req reset_type)
> >
> >       /* Restore timestamp mode settings after VSI rebuild */
> >       ice_ptp_restore_timestamp_mode(pf);
> > +
> > +     /* Start PTP periodic work after VSI is fully rebuilt */
> > +     ice_ptp_queue_work(pf);
> >       return;
> >
> >  err_vsi_rebuild:
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index 4c8d20f2d2c0a..8e5d93acaf108 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -2817,6 +2817,20 @@ static void ice_ptp_periodic_work(struct
> > kthread_work *work)
> >                                  msecs_to_jiffies(err ? 10 : 500));  }
> >
> > +/**
> > + * ice_ptp_queue_work - Queue PTP periodic work for a PF
> > + * @pf: Board private structure
> > + *
> > + * Helper function to queue PTP periodic work after VSI rebuild
> > completes.
> > + * This ensures that PTP work only runs when VSI structures are
> > ready.
> > + */
> > +void ice_ptp_queue_work(struct ice_pf *pf) {
> > +     if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
> > +         pf->ptp.state =3D=3D ICE_PTP_READY)
> > +             kthread_queue_delayed_work(pf->ptp.kworker, &pf-
> > >ptp.work, 0); }
> > +
> >  /**
> >   * ice_ptp_prepare_rebuild_sec - Prepare second NAC for PTP reset or
> > rebuild
> >   * @pf: Board private structure
> > @@ -2835,10 +2849,15 @@ static void ice_ptp_prepare_rebuild_sec(struct
> > ice_pf *pf, bool rebuild,
> >               struct ice_pf *peer_pf =3D ptp_port_to_pf(port);
> >
> >               if (!ice_is_primary(&peer_pf->hw)) {
> > -                     if (rebuild)
> > +                     if (rebuild) {
> > +                             /* TODO: When implementing rebuild=3Dtrue=
:
> > +                              * 1. Ensure secondary PFs' VSIs are
> > rebuilt
> > +                              * 2. Call ice_ptp_queue_work(peer_pf)
> > after VSI rebuild
> > +                              */
> Shouldn't we resolve all TODOs before merging?
>

now the code only set rebuild =3D false.
This note is for future if anyone implement secondary PFs rebuilt,
So add todo here.

Thanks for review.
Aaron

>
> >                               ice_ptp_rebuild(peer_pf, reset_type);
> > -                     else
> > +                     } else {
> >                               ice_ptp_prepare_for_reset(peer_pf,
> > reset_type);
> > +                     }
> >               }
> >       }
> >  }
> > @@ -2984,9 +3003,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum
> > ice_reset_req reset_type)
> >
> >       ptp->state =3D ICE_PTP_READY;
> >
> > -     /* Start periodic work going */
> > -     kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
> > -
> >       dev_info(ice_pf_to_dev(pf), "PTP reset successful\n");
> >       return;
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h
> > b/drivers/net/ethernet/intel/ice/ice_ptp.h
> > index 27016aac4f1e8..428f7f79343a7 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> > @@ -317,6 +317,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf,
> > void ice_ptp_init(struct ice_pf *pf);  void ice_ptp_release(struct
> > ice_pf *pf);  void ice_ptp_link_change(struct ice_pf *pf, bool
> > linkup);
> > +void ice_ptp_queue_work(struct ice_pf *pf);
> >  #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
> >
> >  static inline int ice_ptp_hwtstamp_get(struct net_device *netdev, @@
> > -383,6 +384,10 @@ static inline void ice_ptp_link_change(struct ice_pf
> > *pf, bool linkup)  {  }
> >
> > +static inline void ice_ptp_queue_work(struct ice_pf *pf) { }
> > +
> >  static inline int ice_ptp_clock_index(struct ice_pf *pf)  {
> >       return -1;
> > --
> > 2.43.0
>

