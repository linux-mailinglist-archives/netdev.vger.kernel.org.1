Return-Path: <netdev+bounces-274880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z6plABBGz2lIuwYAu9opvQ
	(envelope-from <netdev+bounces-274880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D960390F61
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58998302198B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E63590AE;
	Fri,  3 Apr 2026 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DidQGWOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D92358368
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191563; cv=pass; b=Q0XNEwWZL6KjqtKLXbvU4v6w4PxB6aCFkJ2acoe7MG7N7XUOpDcsrMa4hrEstaEW2e0A34ODHwuJ2AvuwbAREsgygoVlzxg2foej19uKER6IQGOln5Yh4Kx406THjl270ZT+KAgh5GCPuZTwpSMUjSPvN6ySSw3y/ZR3VzDkeBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191563; c=relaxed/simple;
	bh=groc3VAnH15CVUVhNhE5OtlEsDNXM/uA7VeW8vaOMTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACKaTnYAYBS/uu9YyUTU+ecdfLe7YBKDq3PjSyb2EROa0xzcLAq3phmJ13Nq6Pxux0f45eHXaOf3kHY3vG/nauUOxQ5vrO9PmQzMHvDfTPFboLV+v9GxpMopFBdHxozB+H5EvvWu/whn4l+13uYk2nLQeF7pB7ejVcEXaej8I5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DidQGWOK; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a46260385so14859687b3.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775191561; cv=none;
        d=google.com; s=arc-20240605;
        b=lfFDMp8q2Z9SxAZoYzh9swhsPcnGukmX8A+GrkjZubunm912pAEXv22O2VmBzYD1GG
         A82X9NHEMtPkyalVVJN0TonfjB5JIxhFrWWu/vLh5KGXdU9rB8GlIDqb6GbKYgFKcjaI
         LyuRiWSRrv+R/zEG3kzUwXFVraHVYlJ/wxDl56rBBEFpUyxdGhonBOCOlAB//CRbutc7
         UPIZB+A8tU77zyfKRBzdgApQ6hjlBl2xATezTPXFxDveoMna5lAl33/kvmRXQfx6WPwf
         bu38N0sSO2s2ZcrUHM7xCwZBrJIo0iTXgm49d0mujrngc+iTU7VcbcVYwtc0+Nj7hoGo
         k8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        fh=+eIyyynhWa7uX+A9KpQQ0PIuWX/Ntv/Yavd8iaGUFog=;
        b=b3pedy5iKA4Exra8p0QDrTESQ0fgusJpfjyfoANPyxDEthdbimNVqig9cfjpjv0Ngk
         RbwZZ1R9vcvrtM+ZwvSqkgGCDkOaA+jS78uWF4/p5l883QZ0zLUlxC+MBR7TXh2w+ILp
         DUQhl/lAQ8INWsG2/ZoSQ1aqQumCPaFsu7h+dGE0zUe79S27lKpQe3+3rYhtaGq01jWJ
         aTj0B5nj38N+70CYMbl7s9PD9OpX9nmuvkpexNH2nfOlBPJm5Tacm5Hnx3YiSQVuXb7y
         GqPTw5Nlln1d7GFIwIincGtzbQWheVOWF83lzTS8iYyv+vRMfc61lw2r5OexPKKNSTD2
         L6gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775191561; x=1775796361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        b=DidQGWOKrm72zYGNfTnKQ9IcnJWZNioKN73o236MElVFzyQKQ8qb/l+soctZqFpFYR
         KhdKkKO4KWfPBZssLoFqJJaoQDXfr0ubxMRtcYnbkp4Aw6n+hEGhzMD/e6M1vs9Vctn7
         F7uzUA9y1Hc8Am0AiyTcsudzX2bQmqDVaIRAHRwR1H1Mdwqeulzb+nkNolrXNE6n+lnA
         5zZ6mhLg+931xo6+ZY56HBf57G3FpKAkbPbK1guAlEH/oool84UFse8KKG4/MulU3zjW
         kOZ0D+JZfXdmrH7t4ojZVoyu6NPL6R7//xVc/4ow33xoSCayriKVfXDNF+A2xeU4fM2L
         OvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775191561; x=1775796361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        b=FdD9ZuMsPz/is5/ngOJHg58GF/yhd7eq1pINcZpIYmySQb50ljZ8nCAsuhqcxBcy3d
         4uLugxBXfdwU0SJstouuJD5tCeyI3Sp4nGr/FDxUCD5d0ThKkhfz6nCJq9olKH1VywdX
         m5xbWlP3yu+irl/4kSO9AgzWfHa0WM+cpBbrj4Vjqant4R7AWJz71ptw4SG/cuagXmGv
         GPt2a0YAUt9HwBGbk2wmDnLBWom7kejP7E/kAKO+hLkjnwTsCXAq246N6kmAZx9OL0/I
         fGOboF7pUqWyx72lvjUq62Y6e7UAuDqyz1SHkvwmwrmrmq0nS8NeNiGrCiGOWGCX3jEX
         pyAA==
X-Forwarded-Encrypted: i=1; AJvYcCX5K9420Rmat7Yh3M83PBa9NGxU9SK3pBrNBGmIQYWdNAhrnHel/fsTV4vDr23lJClICV9yDDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWR/NtwfKbOx5Ts5ewJaHqa43LAQ52X25klzHKY0ntDrS18P1
	4CfW6/x1qb5kyY0AJh7dWlQ3v/VnPGJdQ85Rkn4lVgPt+Euoxms4bAJNO3N7JP1nCpw3nv8nSgW
	86R1uhcupmT4tr2LBUImOhltj8Cn9HGNLa976
X-Gm-Gg: AeBDieuTKVrp37PuAAMDLjCYHMmP/tZRm3OOVvmSZJHnmXAwF3zbZFR4AlWIY5J2X9Y
	Xy5owB/18p/nHR+hpCr4OfAjlM08Zw9h7cQx4Ju8kaKqUKPML7dG9nLzEmjhRXw27TjQUqKcOHc
	jB0gqUSv9uJZDvqicZh91vnTtzUnrE0j2RUAxcGlrvJ0vbO9sWH7X7fIhOdM9u77CPqUavYQKVb
	r8oU3GrNlvZUBtP0yMfBWShTsynmlaDOjwaL6yQr4ncBLjYoPDGF7MjpC8RtArwNJ+d35BK3/e5
	TRxtJQ==
X-Received: by 2002:a05:690c:6987:b0:799:198d:8c5a with SMTP id
 00721157ae682-7a4d585f69dmr19958067b3.34.1775191561252; Thu, 02 Apr 2026
 21:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402051442.1426672-1-a0282524688@gmail.com>
 <20260402051442.1426672-3-a0282524688@gmail.com> <20260402-warping-chameleon-of-prowess-9df780-mkl@pengutronix.de>
In-Reply-To: <20260402-warping-chameleon-of-prowess-9df780-mkl@pengutronix.de>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 3 Apr 2026 12:46:22 +0800
X-Gm-Features: AQROBzC_c6Pz91vTEwJZ5AXR_5dXzfojiP7V5Wmo6LnqG_6F9RBzJL09w08myjU
Message-ID: <CAOoeyxVp2dY=XrujkCbWHjX4bVu4-H2=k0JHxL6akC6KwY+rVA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: Add Host Interface (HIF) support for Nuvoton NCT6694
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: tmyu0@nuvoton.com, linusw@kernel.org, brgl@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274880-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5D960390F61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Marc,

Thanks for the review.

Marc Kleine-Budde <mkl@pengutronix.de> =E6=96=BC 2026=E5=B9=B44=E6=9C=882=
=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> > +struct nct6694_sio_data {
> > +     enum nct6694_chips chip;
> > +     int sioreg;     /* Super-I/O index port */
> > +
> > +     /* Super-I/O access functions */
> > +     int (*sio_enter)(struct nct6694_sio_data *sio_data);
> > +     void (*sio_exit)(struct nct6694_sio_data *sio_data);
> > +     void (*sio_select)(struct nct6694_sio_data *sio_data, int ld);
> > +     int (*sio_inb)(struct nct6694_sio_data *sio_data, int reg);
> > +     int (*sio_inw)(struct nct6694_sio_data *sio_data, int reg);
> > +     void (*sio_outb)(struct nct6694_sio_data *sio_data, int reg, int =
val);
>
> The signatures of the function look a bit strange. I expect functions
> reading/writing bytes use u8 not int, register offsets should probably
> be an unsigned int.
>
> Why do you have pointers to the access functions? Why not use them
> directly?
>

These helpers were originally meant to be used by sub-drivers for SIO
access, but the implementation later converged so that all SIO access
is done in the MFD driver itself. In the next version, I will remove
the function pointers and simplify the interface accordingly.

I will also adjust the types as suggested.


Regards,
Ming

