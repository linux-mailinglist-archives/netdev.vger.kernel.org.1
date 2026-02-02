Return-Path: <netdev+bounces-255956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPOlGFXcgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:18:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B85DCF7DB
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E6D43002910
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621353815EF;
	Mon,  2 Feb 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hr+l1ifk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D2239086
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052301; cv=pass; b=DSD6mwuvS3rkJkUWKcq+FAKGb51Teu2iRhW9N+DoSnkzU/RP2zA2EiNceoscUj8LtnnNL5I1ZXXh4vvDKgLdwl3Krmf8qenwMWr9gcHw+omL3aSgb2LUrSZ/Tvs3xPm8bjmtuPHP28Vs06MaT2O/PkMsPt8oYgFVBdbee0qAd/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052301; c=relaxed/simple;
	bh=5tdaA9mbInyE7lSzXuoItIXNxRipUEMsM2MOyx9QNDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbqTg9LXZXiUBk1zB1hO8CtoUMNinD3HKAe/uSFHRv7H/W8yKxOhHQIRQxojy7Nbf80NshPeZtQ8uMUwhSdTyioZOxlfNTcPdDYQOFzJm/6fDqdAWSeTBkQLa55vK0CEBwG8J8K4JOAWVu4CFi0bYbvHv1a40uNijb/qHSDWWp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hr+l1ifk; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50145d27b4cso51676641cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 09:11:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770052299; cv=none;
        d=google.com; s=arc-20240605;
        b=AApZ4aqViW/jsrLeG1Y3Loph/CnvTVhLMEPfDpWst86lCmfaBgO/QaH2PeZ+tuUH8N
         MqLl336uge27qOzRMjJcQ3UofDPQWCUh+SygPFFQKA9mfNu5bGdv0rqOzAbkE4wAVHfe
         WMtT+11v4bvM3LBnAHXPv2ZRAK4/puiprtY9IOy7qxGsiOQPS0twcQMQHrze0JQT20gq
         fdjKW89eq7HP9OqtlyiDlZ7AHS7tzubAB0IA6O8fCkzvXqsqooJmnBFmYl3VACGmIoZj
         SLUpR5G17oLzePSVJqBiOwKMI9S6+fyfO74yuySaX3nuVLegbS3yQ3EfUPTTJ7O6SC0u
         +4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cfJX/aRPoy6PZQ1T5RXrd9yoDPla7R52CDpMZ5aJtzs=;
        fh=9sJ8AfartyeKYNj52yTscbQ9vjiGyOn8TBRIlD8bJKs=;
        b=jJE+/37wIRbAjR+RU5PYT1YyuccjCRMwyROXcmqJbS5OJ34HiYrFG9EX6QqfQ+Jnia
         9avqFtuAMCrnorYalnwz6q1rR4nDm+7vounbdYCqrOGxeer58qgYFBCmy0770utNSzcb
         u5A0oijDcKOVE9soj73MBr6g/yKE3OEEzzzJhfhaaMM9tGWFFdmQx5Y2V9dbsohnpOiH
         JG8LspqMc99dwpocY9nveEQtOP7GZ1D+pGoid7iGpgXJGNfBt3lYohotIlWqp4UHWmaE
         9XpY38dE0bAVxUm/5/gfstLWyzp8qs4ckZ0qPd/V5JTJ4i7m6mglLj82jxgCA956hrQY
         UtYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770052299; x=1770657099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfJX/aRPoy6PZQ1T5RXrd9yoDPla7R52CDpMZ5aJtzs=;
        b=hr+l1ifk/P+52mrSn6zz12nZkfISuELGcCJrvFqr8lcZN53AXZ+hjn6hRYqfJ3sjKk
         REDVvOcmlSYZXfHbHGIHXU213rIgP11u1mseMW+poP/D14jTLQfRPuP5HXmmYw+L6p73
         MnSwMuxRRoHssZjFoYLx0paPC4Gr7l8x/qT6wJ/aLXgDQ2eARgIrEyBW9PxwffWqQC7R
         vScDgPCucXRvNF0/U8WxBv9RFG5CJy2F2r3A7e4KhP8N3JBGRK+rnkMaFJYJBbNGLMpE
         NV8kzorhDGbUgjFvQnnD1c9aMRqO5G6uoCQubuv3SWZvEVSt/o9dWPg/zmLCxr/tI0r3
         t/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770052299; x=1770657099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfJX/aRPoy6PZQ1T5RXrd9yoDPla7R52CDpMZ5aJtzs=;
        b=XOe+ppuKFkxSkfa/fZJr/cBAz4tzUl4zBUBof3lDthvOF2BDlNF0Wy/fz5udjQZCWY
         bEHeyJ0juEq8Lg6r1CzikzMEuzhujTlHni9OnqPlWY9AkPUa1G2QZ4awUVJM6HK1pGUh
         2uYU/vLLXSlBk64X+MDChtujc8jDP0vALvX1zOvG3AwdPnAiZwLl3COxI0SJPMr6biPu
         J5jW6XXTOcs/BAJQ+vEZkznRyzEpScH3OM/ahKZIVWxcmsLECppAYgCFwbMuUdofPXcA
         A0pCas+5drd4M5C44mXbGEmgwNUdgRG2WRKa1vZgTBFR0utH+KBKsSBaco08FgUSr4sy
         Nesg==
X-Forwarded-Encrypted: i=1; AJvYcCUjum4a/DaW511Wom2XJjiRzHWBPEExpgEohRM9uhXgxA7GcfrQIgmUf3e72k+rEJ8bpBEMLNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8abU9hRxDtE2OP/loH4dN1u/7TE9gDoEPFgIcnQR+SpUTvF7
	7/4M+icY2K7X+AJNhLccXXY7EPSzO8XkY85TOru0Ti49tfTmpLJufAQVUcmbOi4pCNBpmkZqeOa
	FSNZnHk6wu5O9sUtPnQpBKHGQUajiJxUz62RpGGQ/
X-Gm-Gg: AZuq6aJ3l88flKXEUY9VfhxErPsg2HVOVz8LAegy/ZSv5WkbUTIljlf+YJlygMizUo8
	FI5kgZIiEsnkumWtRByBNoawD0i2cktqSqI2z4QDCCj00qx2zOHJA3gOeh6OEcQNWRA3xIXo/2s
	EJfaXQ9iNY+k7yb9hgj86mi59DsoygqEDuBUddDTlTRkzmLClIsfO7SeYJ0gWbi5/nzXdTRxS/7
	mSD5GRm9dlhaCJB+nDtkGTUCIGXw/6E93QXp6j9kao2WHiHA23hqMdU+ZW7pCE/gkie1yU=
X-Received: by 2002:a05:622a:282:b0:501:4807:6162 with SMTP id
 d75a77b69052e-505d2297becmr154490271cf.72.1770052298513; Mon, 02 Feb 2026
 09:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
 <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
 <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
 <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com>
 <CANn89iL8FnPG9bD6zW0eHmeSNzc33SJgrUR7Aab4PFG-O4nfTw@mail.gmail.com>
 <CAA3_GnpijQeBNVOqy6QtUMDjhy_ku_b54uf30zfEq=etMTqKrA@mail.gmail.com>
 <CANn89iK-Ojmi4kCZwXhFq-pG5PacLs=m71Jtw4zRpxaPEbJdhg@mail.gmail.com> <CAA3_GnpJ-RV=1xaf4DKRd30RgH0HoAxXJA1tx0cvBCX05OcYuA@mail.gmail.com>
In-Reply-To: <CAA3_GnpJ-RV=1xaf4DKRd30RgH0HoAxXJA1tx0cvBCX05OcYuA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 18:11:26 +0100
X-Gm-Features: AZwV_Qi5HFFMPVx5ILjN-D4qYqBYalcMJjpsT99MatUnx0HCyn5BRa-cmbfqMBE
Message-ID: <CANn89iLVEJKoBtYNbAdLgxsPr03Fkgi9CJmTh1a0y0L5fV-HNA@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255956-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B85DCF7DB
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:46=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
>
> Here is the patch with the barriers added, based on v6.12.67.
>
> However, as Yuki said, we are wondering if this would be considered an
> acceptable change
> from the perspective of the maintainers (or in terms of Linux kernel
> culture). This is because
> the patch adds `READ_ONCE` to several locations outside of bonding subsys=
tem.
> Please let me know if you have any concerns regarding this point.
>
> >  Also, please clarify what happens with stacks of two or more bonding d=
evices ?
>
> To clarify, currently the `header_ops` of the bottom-most
> interface are used regardless of the number of bonding layers.
> This patch changes it so that `&bond->bond_header_ops` is used
> as the bond device's `header_ops`, regardless of the stack depth.

Could you try to cook a patch series perhaps ?

The READ_ONCE()/WRITE_ONCE() on dev->header_ops->cache could be done separa=
tely.

Thanks.

