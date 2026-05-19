Return-Path: <netdev+bounces-289647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGV9IZzqDGq9pwUAu9opvQ
	(envelope-from <netdev+bounces-289647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:56:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B1585DF0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0DE3015E1C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643F31813A;
	Tue, 19 May 2026 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="OfGjBXY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3B384256
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231357; cv=pass; b=tK9IREerIhhSjN3XykIjxo0ke0iiYuMOipxVqxrizApqgqvLF4lxZS9b9FgXUKra45FqI9Yi9Nz7mm6+PruPZv5CHAv5FHapCWU8gfYSXeBD6X34t5rYph1/JOqFfCIkryRI4uRONcm8zajzbqj08YC444qVucHwEmS/Et7ctSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231357; c=relaxed/simple;
	bh=zUPFJo1rTiByVYkgXKubLLHMMheWBy5ucqBylfFVT0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bebOQQ370fYS+aK+cxoWot84UAzAV+ofdHJpYu6CZbQ5DRd2icBwMh2TZgH9lD0fT2OKmXbQG9k5WsVZqgJHmd9L7L9RCZ/jjqaWfe4yZGSqjgRQCMH2EtwfO8f48gCVBtNHngPSYXxE8n5e7uCSJG1+x0zIYfYhLdl7zSD210o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=OfGjBXY2; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso64609926d6.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779231355; cv=none;
        d=google.com; s=arc-20240605;
        b=ItRvBPlvyEjLrxmv2GQYQN4QIEbZ+5GRyd850YTbnSKAcgzZlf8kxPkRoQP0oZP76u
         3xXvYyeBRL9AhDr5d3mtwl9mppJroDVqIKMXs72iAEGqbhAFQdkIgmha7uJslBKW5cIE
         21k7OAIN+OTFfvyPvOnAXC8q9VJ+UmL0Nebsm7av5xagbiOqW2WoW9cKQNE6giHweZLP
         jD2p14LBa+Vt7CNsJftuhaOyGIqH2JQSgeppiFZLiq9vNHHJl0vn0rJ3gR8Z4DfyGjvV
         UUIDrRgpOElt6CiF/OfmkNDZnAqcdQJEoiEH3kZj4t7rPhsJOdNw3svXJQeqGs0SLyIR
         ZM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24ksEWR9VsphBKxWOAJhvAZFCfHVIMOuSysw47xN0p0=;
        fh=kd9pmBGzLS3bAC0BdRNVWsFZNa0NHTjcZiMyeE0e0Hc=;
        b=H/qMAFSWr4P/pvJiJ0Ov8f+dASuVBW7i23RGQTytkmNNnQc4/YTfxp5BJXNZlr4WJ3
         J1tDr5iqeFf9rXNH4GG55JcSjBmAoY+R+lIBxl4i8B0i1UTCRqD6Yi58Xge7c1kJTi11
         MjgT2vnPtBG42MChSNq09vz9FKs8ZKoKuYHfO8uuVsMDiSod7RrGBApRxtXdL5tswh3y
         pMFCePji1ABzA0RYvQ9H8YR0d3sIZuoZaqZSD/bld2hvGWsh//WRvnMQo0l9AiteeP/s
         aEikFafd2ieVAakmNONzMtqew4R1+yt+3vj0Ukl3xgA6ZLPuFBYaMnAWWlDzsOt7/e06
         uCoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1779231355; x=1779836155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24ksEWR9VsphBKxWOAJhvAZFCfHVIMOuSysw47xN0p0=;
        b=OfGjBXY2cROh5SOUa863YWMe6bEqkq6VaCJuX3u9FUHflbwNzEwKsWnTbkH4VBGXij
         HV+0TIROq7ZjrLCnVXOKi3U7MJ72PKu6PV+8wIoeQRCqqabvU5qq55c2+MEbGbVaiDbh
         AMnd7jw0mTsQR+TBUt8p+NuiTt0WtgVCSZx2d/0dT9RmBpw2/IR3SZjZ1OJG648iNPah
         UGliOgXHpHWtNO0wwoqK8toFRBfqHByUVfRi8Byt9L1WucVKt+p1EHOhx5NJmZMbjIEx
         AEsWbkRJvYWwjB66AVXfrIt4T8gTpkzLVls8uDTh5yopeGLonk5DCumpZXOB3dpjHXqQ
         1Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779231355; x=1779836155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24ksEWR9VsphBKxWOAJhvAZFCfHVIMOuSysw47xN0p0=;
        b=VgbwGs8xw41ymvWkQ0AL0CJ0LyQwYXJrrIH41wa+Rrgzt4mu51O7VT4tX2NdgPqu04
         SUppefg91g+OyKfV0z7zaH2MwS9FMyxwZtcM5J6lTRGDlezQQLDtYREne/gsFWJH+tLF
         MZNZKO8l0WGk79RhXTaEm9Cp9hcrR+SNlPEx1o1kAk/MROWGFK07aUWlP8UBJOXGx1th
         5VRnr4WDSSq6NxSSjsOCPO7M5YqZMmLCkjDYeWw3kInKIiPUla3qzNVodxnQDpdD1lV5
         6nl2YPm8RZ/QbJoAhbmLgjYFHb/sgYdxInThf9iTCXCsKpDpthkiYpvugfW4N02F1y6y
         FhQg==
X-Gm-Message-State: AOJu0YzYWiuTd/6UGtde1WUluk13Ugz3jKPGAfQqPlde6s0REzSEStO4
	8D1Ns//XYV6lbEbIfv4UvJ8kBuibm5Cdjh5FXUUKiPdls2kMb5p7wmMv+vgP3pRuOAwROgNzCLZ
	cvmornv8+sQNIqVqDp279NuquuS4IoRlHSPpVF1LxRw==
X-Gm-Gg: Acq92OHXU864bZiFtuRzKQOr2iEVo6di5ifaNabfRkSiJklJ4mhoE72wkOS76A194Ar
	NBOgXWvOb97jUSgHvgeJnSxPYM30RNcgRREOK/pFNqejfE42Q5hCHVEs8l1v8Vf900T+w6JJ4SB
	WH+9CLRhXM/Yq8INyhxysp9pdVm+DH3QRBNGWp3UAG9LOgFZ1aQfN6yOK7GEaD7SHilsY6zG64O
	uszABzafeGxLYmnkBS/5roQI9k8URhVzS31/UduvTpwR8eUnuL9PPj+ogqTSGyif7XUBSq1YDoz
	fFwiyvRV+gLm1Z4zkxMOXIZosyJpyENsTaWKPx8=
X-Received: by 2002:a05:6214:410c:b0:8ac:a708:eaa7 with SMTP id
 6a1803df08f44-8c8fae77764mr366189566d6.5.1779231354792; Tue, 19 May 2026
 15:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agqqK_6PxbvAwsMX@juliahub.com> <87ik8jmlow.fsf@nvidia.com>
In-Reply-To: <87ik8jmlow.fsf@nvidia.com>
From: Keno Fischer <keno@juliahub.com>
Date: Tue, 19 May 2026 18:55:18 -0400
X-Gm-Features: AVHnY4L9NBPDMQ6T-SVuxZtP3VUo1uUC2B2GUX2O7uOO8DTgNzm33dGHxs0ZHTc
Message-ID: <CABV8kRwnfmc_xVEP5e_9mq3+DMpz4tC0AYSamiJysgG2GUoaKg@mail.gmail.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum_dcb: Reject writes owned by an
 offloaded qdisc
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[juliahub.com,quarantine];
	R_DKIM_ALLOW(-0.20)[juliahub.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289647-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[juliahub.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keno@juliahub.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,juliahub.com:dkim,nvidia.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E41B1585DF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:03=E2=80=AFPM Petr Machata <petrm@nvidia.com> wr=
ote:
>
> I'll let it pass through a full regression tonight. Overall the patch
> looks OK to me, but Sashiko found something:

Sounds good - I will wait for your testing before sending v2.

> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> > index 73519301b744..c2ce4f3f562e 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> > @@ -2316,6 +2316,49 @@ int mlxsw_sp_setup_tc_block_qevent_mark(struct m=
lxsw_sp_port *mlxsw_sp_port,
> >                                             action_mask);
> >  }
> >
> > +bool mlxsw_sp_qdisc_has_prio_ets(struct mlxsw_sp_port *mlxsw_sp_port)
> > +{
> > +     struct mlxsw_sp_qdisc_state *qdisc_state =3D mlxsw_sp_port->qdisc=
;
> > +     struct mlxsw_sp_qdisc *root_qdisc;
> > +     bool found;
> > +
> > +     mutex_lock(&qdisc_state->lock);
> > +     root_qdisc =3D &qdisc_state->root_qdisc;
> > +     found =3D root_qdisc->ops &&
> > +                 (root_qdisc->ops->type =3D=3D MLXSW_SP_QDISC_PRIO ||
> > +                  root_qdisc->ops->type =3D=3D MLXSW_SP_QDISC_ETS);
> > +     mutex_unlock(&qdisc_state->lock);
> > +
> > +     return found;
> > +}
>
> From Sashiko review:
>
>     The check here only examines the root qdisc type. However, a prio or =
ets
>     qdisc can be a valid child of a root tbf qdisc in the offloaded
>     configuration.
>
> This is correct, ETS/PRIO are offloaded when under root TBF as well.

Good catch, thanks. I did take a look at this but then forgot to fix it.
My bad - will fix in v2 once you've run your regression tests.

Thanks,
Keno

