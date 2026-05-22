Return-Path: <netdev+bounces-290883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHA/IxGOEGqIZgYAu9opvQ
	(envelope-from <netdev+bounces-290883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:10:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49A5B7FA5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0859306D0E8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0E3D3480;
	Fri, 22 May 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="LMmoGJps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10342FF66B
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469324; cv=pass; b=m9/HSZVjx8+X4ZXbxgXjjOfb9fcYGVCSaHEpgsPr3Exvu3hcvkhwxz5PjRRyEv37m9/cQRzK9nN23dWAU3V2zayYCL+xgDOijSJOx3joJtXg35QXhVJyXakDaXEwHqB3XB51AovHE2WBYwNp5EomFiuvtOZplOyf4pm1gubM4hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469324; c=relaxed/simple;
	bh=mqn7STvKDZSv0TpIEua8uQ8epMOFEcyxopvU6qmvyf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjwZO5FmpOrPZ2XJVqQrGarHjgu94WyorRDDwdbJzkwLK8KSGFtxeoILMwE15qGvxuvim37gbJg8Ie/gWOcqGKAj4g/1BGnl1sN5TlImSaJ+Vxp6nAmMMhvbf8nq565DdbMkmBXHVAsPqGURIpQx+tcyb4B++OQkrRtYw0EQ3/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=LMmoGJps; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-365d8e43759so3986589a91.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779469322; cv=none;
        d=google.com; s=arc-20240605;
        b=cUstNkSW6KGzZPQMIOTBCWqeXpAiijzUcGZdH99InT5BDyp/ox22o0ZDE23GY3Dwxh
         /01B3p3UenAg1GfZbwtbm7zscY14LQORCNVbZ3WPxExh/7zN6aqfWCjY5hw1kYWDCTYK
         uhoyUi95x+JIickfNEySsuQUYqNFqNHV7efzpMEhUZQr300DniGxisJKzBiv5FfoYi6u
         6d6ctIodrQxf67+DLJMGZQifeLEvFYd3Ro+zmgiFj9BlLBkCbqF6bZXJdwNV2MGZ7FPm
         GXYsBiNjKvu5/TeZyBc3yJtGSNN4htJeW4ceY/DVLAk5xZR+4SuEw0PXx/YcYKW+d+TU
         rbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jh5rForrKuNurhSC4zeL6NZeYa7yuiyu9toHS7ozOQU=;
        fh=b8iPltKV+LKUmFNdIIf3uE6GAuI8mE2wAPy+F0MxcXM=;
        b=KecaqDp6qaog+2Y8rkHfX9HusBxvkspsG9SRqqFqo3nVyz/jvYtanIbyz0Oi4URWMf
         A19ZPsGfuKDS21nAjqZygbdbTjHoQlN3NDFsgF0W18aKeCpKJgDMimRGbDIWCNzJV65c
         Rn22ty653foCq7H2OEAB1+Wvw+YVTO9tiTcqLDumZVmepbX/hm/Ym1AVPhmuYZclQBjI
         ahciXtbkiaPowxGxef5jC+/TF2bGdsaOjYfmRHG1RQSzERXqr9EcdqL/hZ2It1WGfPHu
         la6YmNOOEi1XyS48vuPiTAF94adgk4Ml6NA+IxKZT/jqf69nt9VnjeNHpf89rdwp8uey
         nOYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779469322; x=1780074122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh5rForrKuNurhSC4zeL6NZeYa7yuiyu9toHS7ozOQU=;
        b=LMmoGJps03j4lKUE4XhaD08Z3EgwPFOQHwFXbQp7DO8swhmPkJwLOWQCIxZRdMaRle
         NXpmXZpy4c84V97/GVCtU/gWy1j800g3XwQmSmCjWkXK41qpVieFdug0Eqq1ruE1HT1A
         xPOCTtIDZ/uukpBm/QHYL12VY6WbfwzQqCQMWhqQZ9nvcZyITD7IwLzPER2lWVoQOcBC
         CFWh09jJCAEjM9Emoh8sK+5aSRPLCiolSUbcILtZ5qDCTY8/rPoXpX4bdCb6uNCP2jF4
         Ok4plQPUKFEMq3ea/Kpx5SJA0QJLsIpZdB+RjxBP2MvC/Ndb469EZ6v5zTRN/zwvu1gF
         E4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779469322; x=1780074122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jh5rForrKuNurhSC4zeL6NZeYa7yuiyu9toHS7ozOQU=;
        b=pdaoIgHzcmCwXApV7qba+6kB+U6SJatjFu5qVuHXBAKiNqbRvMrclvbwi6XzHO2gDb
         on/L3fctN1ESUdO8t+HARHKVFGgoERv3eyDWWgpSWsi53SpZ6ECIfTtS8WK6AHlH2Llu
         9ynRts+UQHbOaz6gXGJVBJGl1gPMeBy6ioS0IwnYJqbSya8lvuZFzgxX79N6U42al/P/
         VZa8+QC7rMXRCR72/gPRL+1ztj0P2qJcVSEgixxbU6/qOKKtpjtknnAtKM5brDBDtuk3
         MKkmNQi/OaNKVXM0IcEdyyfl6vdsyRmDchsvJy9QbtOhPauggsbebR5YJVu8/v4gATb/
         43nw==
X-Forwarded-Encrypted: i=1; AFNElJ9IDIYVpZNro84u98spgPUVX61B0/bNLbIJSu/Nl2Fy5dhLLIz0EZe1Wc/Vs95pGDfRrSIawco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjsl0xPHrnMV+sdv8mhqrFlqblv2dn2NsEM+KtYYkbP2/czrj
	ldN/5k045cuNSahFarJkpwUAzGi4HQJHq/53M66mL1W1wUzQQOeVTjhBpFK33lULOv6oDtk/733
	K+2RRYC3ZqvztgHLEBpdHzcpEgHYXoGTDyiZufLMl
X-Gm-Gg: Acq92OE4mn2sheTXPfpwq8uCWTbc9IbPtgdXSmsZSJyXB+RwpZeK0wzPoQhJl05aAzK
	XbTJQUZsH9SQL0bqyjma6ELAzoLJC0nDNQNqNkpnwZRF/WHCYMwPQIhMSb1fbs3oTppKXQy/9R8
	jn9HF0qwm4Mzc1lJ2g/ZWOVBML4AMp9VG9Uv9wZjDoeADOiDP73fpo09d8oswNditJJ++TFWQ3T
	dtyNdCH5qiRqcZMOrIZw1gV55oG+LdnF2FuEtzwqzXQ6ZWxQxziJS1Gpck0aVkY/ghGeoDyWSuk
	ITzEC4kqRG3zmNLG7Rw=
X-Received: by 2002:a17:90b:5810:b0:369:f4e5:e556 with SMTP id
 98e67ed59e1d1-36a4799fb8cmr6960823a91.12.1779469321419; Fri, 22 May 2026
 10:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org> <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org> <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
In-Reply-To: <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 22 May 2026 13:01:49 -0400
X-Gm-Features: AVHnY4LsBTIOc1CkPm61OL81CGY9ZDiPQl8d_JMDh0neWTle2m0D33WuXWx-DfQ
Message-ID: <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-290883-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DB49A5B7FA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 12:37=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Fri, May 22, 2026 at 11:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Fri, 22 May 2026 07:47:32 -0400 Jamal Hadi Salim wrote:
> > > > > All these issues stem from the shared frags point, but the patchl=
et i
> > > > > showed is unrelated to SKBFL_SHARED_FRAG, it is more related to
> > > > > cloned+frags.
> > > >
> > > > Right, right. Just pointing it out cause Rajat's patch adds another
> > > > skb_has_shared_frag(). Which we'll then have to delete in net-next =
:\
> > >
> > > With a note that the exploits currently take advantage of that
> > > specific cache issue. How about we allow it for net now and then
> > > schedule a follow-up phase to remove it when you get rid of "shared
> > > frags"?
> >
> > I must be missing something. What's the problem with changing the patch
> > to pull headers instead? I mean - if we agree that this is where we'll
> > end up - we should just do it now. It's the long standing kernel policy
> > to "fix things right" instead of creating temporary fixes which then
> > have to be reworked in -next
>
> I may be the one missing things. You main concern is with this:
> +       /*
> +        * If the skb has shared frags the user is likely using zero-copy
> +        * (e.g. sendfile).  Those page frags may point to page-cache pag=
es;
> +        * writing into them would silently corrupt the page cache.
> +        * Linearize so pedit operates on a private copy.
> +        * TL;DR: if you want zero-copy, don't use pedit.
> +        */
> +       if (skb_has_shared_frag(skb)) {
> +               if (__skb_linearize(skb))
> +                       goto bad;
> +       }
> +
>
> i.e you want that gone, correct?
> And my concern was whether removing this still exposes things to
> exploit even if temporarily.
> Likely it wont. I have time, let me test the exploit with that code
> ifdef'ed out.

Ok, it fixes the issue even i ifdef that out.
We still need the little patchlet i sent ...

cheers,
jamal


> I didnt get the "pull headers instead" part.
>
> cheers,
> jamal

