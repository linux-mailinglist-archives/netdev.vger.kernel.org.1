Return-Path: <netdev+bounces-271137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDvxIyqxwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:43:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36723318444
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EDD03064D3E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976633BED34;
	Tue, 24 Mar 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBof7Pzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241143988EB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366654; cv=pass; b=cmhCSDA3csfG0xYXFXjXVsikHWhkb1cigUwYAG9Pb5wXdDtu9LcYfw5U4gj1FQldB/tonajMskDuhLI/rRmNMnx5aom1JG5IPjpJ17ImTE7XFaXk/oLiR/39DSJTbnIRzrNFT+j2C3kijWsWRQUeyUQ1PCD5bZTb7LFIJ3W0T+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366654; c=relaxed/simple;
	bh=aO0rHPZ6b8yKX59gnfCt1cb+E95HGTlMYs9Y8Z/muBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzuevbzmCiIBPsQg0iHEn1aQeAgG0saFGk6xPj365MAl1IoXB8E5FFM1Y16DE7kPPF06Ei2B0P6RvLXKHBuJhn8h1gpdxbuaH6DnkD52DM/RGrJg6e1BfsL3qZorSv+p9Sl8XiD0NuMuay/faqfvrZGNMfL2qTi7vpgM5vMzUxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HBof7Pzs; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a747448dso34712131cf.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774366652; cv=none;
        d=google.com; s=arc-20240605;
        b=WTwMHEyTTKXcTjs2ogqjL8ZqMm/MIEnyXxNRbP9M31nb/GukQdhPXuY/3gA0zbSvpy
         +QbAFZ9zd1/fgZ/ipD0k1J+Y9KaV7jflxpA40dkWeBEyG1oKps/H1pxEn6haIJDjR3q8
         lCSqZ2menuVQkg8qiXxtEItSUzl3HRmsU7PJE92/+yn25y08AYih4a4xoNEvgySejxyh
         wAG+S9PXMmye4mbPDziUflr6U74M+j1VI5uv50wPlHfm0ELO6DJs3pAnzhCAsvBJbMuo
         AB5i8hwi8y2MrhELcVyklamJYh/riRVw5Dd2w+GGBcyZcZVqXOu9KHFz6weXRnrYLdiX
         uuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ucf4TAGdBEv2SQCZ1viH+u8hoUeJ99JEmseRUJ8lq0A=;
        fh=YnRIGTzXycnrQ3W0GDJeW88VfgFniZTXDbZwAzla+O8=;
        b=V0y/3fDYHP+fJ6jvAThOx/mJFrUcStodlwHI3eHHgP2i1slmaCzSsj/QZMOpdJxBMO
         H8zhwhh7gUkqE5JqqmBmCX6yYFmCmQbyfY/tzsmAz1xyPBRbXdK4fdsVTnTb+21UM6Oa
         WgYhbkkBaUPd3o8WNMwkFvma0hHwZPtC1lbpcVgGHalQets/BwUvkdRiavkWsWADRR5V
         ikyb9SzVnnDzDONOiDJqrVviSCMYq1aLSAa2p83y69PAoekvcHUgzl3Bud6kkWvLivQJ
         t2a/Lv8hS+XVt6PCfXvMRXIqjrGFWupAuQxwtVLamT0LTXqJZ2/C0Dyi4teQRRNwXpWV
         IQBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774366652; x=1774971452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucf4TAGdBEv2SQCZ1viH+u8hoUeJ99JEmseRUJ8lq0A=;
        b=HBof7PzsUQc+KCkR6WeghlWSGAPVlt/I1T4FsxjrVl9dIH9TkBRL5KtFNb7nfzVnSN
         LwRRbOT4CBGKoyljQx5flD8bpELKws8Dtog5HztoTH+o0VfwGd5m7XANDT7DeFs6+puR
         LwNm5ilClKGYVrzrQ5u3+cWBYHxmDhy282Nnlez2v2P5nUQGG6ATZ1kO7H50TRgIRIrm
         54o05A2QnzGS/XyLa+cfbSeCPaBYqIiWX/IDKEbes9Qeo7aKyZrciPYDXkt6O3F7UHQa
         CgFlXBgmQLwendfsJ42KXR1mBbAhKnpgQ3eX03hLengXDMkuP653803TfEivrWMYo/j/
         cD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366652; x=1774971452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucf4TAGdBEv2SQCZ1viH+u8hoUeJ99JEmseRUJ8lq0A=;
        b=JyNUnl3FRf4XbVKBXe7vKbXAaEfLHjl8/jLgJnREMMGjwvvqNgRqVNWn4HSPXN46dN
         HYMrZg4QasrD3J/87LWcdj99eMcjkuf6SLbCCThkbq15XNARmu4HrfA+fblTSoiDHx39
         5r1zUM072Nxz+xRbtemdKlnEJ4eM8c9/1tZMEFYQj4X5+teyrPqluyHNBSiPJObjUNLJ
         rbNTbjarJLW7Ss1Q/4Xo2BuLWwTIDEdK/A7AI2AgeSaQQRQ0cqXi+Jt4s9xE8tA9pWr4
         v+e1rN59WgNhUGJdVeGiRz3fdJqDMwfPNaFBWiU8TmBDpNaHyPwKi8rmTvZkcUnL1QKW
         2vOw==
X-Forwarded-Encrypted: i=1; AJvYcCX9N68YprrqGh9CkyviJVd3thUukcseshF6h4o6iemeR60ct+N+O5mnrT8Yhs4hTC3K6hq6dFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivI5caN7DAqFWtbNa03A2HY1hGlxn2u2p3N/BN+uIAPFhWu6g
	KD7jj31Pdm7e+p1wHr0lUeliZBtYIb7rUeQWMfMy5Mw6XWrIE/KBZA0NrPGAFytWY2OwCo8VVvn
	ZhUKe9gzmQ6N/e3ZT6XNGpmNqrRjq1gaunUNxgKxa
X-Gm-Gg: ATEYQzyJHODL09Qx3T7F1qEGCO8J5T/XQ6PdiRga//zeZqWIqw5tR64yIqT1rsncfUL
	kC/eS/ksouFU5QgvxJPFvKRnok0Zm6G+p5GnQPU7zWRJipuYuHSFTYQv3cTB72pl/7dUREl/Mgm
	ZWoaZDL/r9TZD4ISyL4Y7iyV0FroRiI8QvYtQiWeqJXZRjf1eWlyORVx1A9f6Q3CpfjXjBnSM+g
	xwkfN8xen7nmsOX4+GfM76/GHnSUL5qspHrJczagV75UQdVRXYytPY4wMtlu5eVTMtr6BOOte5g
	QTSCyrh0brfQi952QKBQ4ipe17wL6Yz8ENvX9GfEASZDwYXUGvnXWbHnPb0P
X-Received: by 2002:a05:622a:4ca:b0:509:39b5:a97c with SMTP id
 d75a77b69052e-50b80d70658mr1262501cf.27.1774366651777; Tue, 24 Mar 2026
 08:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312100407.551173-14-jiri@resnulli.us> <20260324151014.860376-1-ben.copeland@linaro.org>
 <vms2w2ctvoojfqm25hkqapeq7gvn4bsybnrj5rxwsuvfbwutw7@4i5pbtckvlqn>
In-Reply-To: <vms2w2ctvoojfqm25hkqapeq7gvn4bsybnrj5rxwsuvfbwutw7@4i5pbtckvlqn>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Tue, 24 Mar 2026 15:37:20 +0000
X-Gm-Features: AQROBzC6Z26_bkKWBwFtSwRM7x0SVesgyajNebBCMtYyb_dIiv2ErOc2Ep4I_RM
Message-ID: <CAL0q8a6OXJ8qQYYYDCfAdujrsJ-QPt75kB=YQ3rwdZq5L=eO5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 13/15] net/mlx5: Add a shared devlink instance
 for PFs on same chip
To: Jiri Pirko <jiri@resnulli.us>
Cc: jiri@nvidia.com, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.copeland@linaro.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: 36723318444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 at 15:21, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Mar 24, 2026 at 04:10:14PM +0100, ben.copeland@linaro.org wrote:
> >Hi Jiri,
> >
> >This breaks probe on AmpereOne systems where VPD has no serial number:
> >
> >[    0.839394] mlx5_core 0000:01:00.0: probe_one:1952:(pid 10): mlx5_shd_init failed with error code -2
> >[    0.846302] mlx5_core 0000:01:00.0: probe with driver mlx5_core failed with error -2
> >
> >Returning 0 instead of -ENOENT when no SN is found fixes it:
> >
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> >@@ -33,7 +33,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
> >               start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> >                                                    PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> >               if (start < 0)
> >-                      return -ENOENT;
> >+                      return 0;
>
> Okay. That is probably the best fall-back. Do you want to send the fix,
> or should I?

I will leave it with you.

Thanks,

Ben

>
>
> >       }
> >
> >Thanks,
> >Ben
> >

