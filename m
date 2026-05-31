Return-Path: <netdev+bounces-293384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOVuIjMBHGqiIQkAu9opvQ
	(envelope-from <netdev+bounces-293384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 11:36:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B3D6156B2
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF4330125E1
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB130C354;
	Sun, 31 May 2026 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWcDM5xW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700226B764
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220180; cv=pass; b=KZawaF3cyZnLkE1IagGyM1eHvHtFEGKf40DxGH9wRGJ9MbFLzAIP8lHLw7xOZzJOzPmNq2Z/GylWb6+OMnKAFX9Qpy1Tg9BpN2aBxje/i2hzifcGlYwseOKiq5LHS0+HuiTZ5uap+oeM80uIUJeXBgWqfsGrYqnLuNauVVCfxcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220180; c=relaxed/simple;
	bh=lEtBWhQ7Bonf5ydGExukV2fu6HwJrOExp4gUdXOLy6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFOaO/0VZ4oTUyzvALijWj6tsRAquHX2BF58AzyQpZHERxESBUpMQPH+tN6kb6rJAfjFpns3rlnfCf8xUySXeVkNggqxURqru4pju+8V6M+yFlWiT8fS1pcAhRxJ1/ihCvw29JKlzFS7Y3UxI9gOrJg36n7/ehUFUoCuK/69Wqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWcDM5xW; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso5203606d6.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 02:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780220177; cv=none;
        d=google.com; s=arc-20240605;
        b=hFPNdbtFXBoHXSkUm42XIKrYnFOld1y+tJNZ1XlLGBHrKxWwr4cTmXtmW0HoTwbHXw
         JmnqouMXAvtZE2lfr/x46geN3zVYgx5GoPMPwyOHhLMtMOpqj6Gkku3YJXMpqHA9Z/DL
         l1wjv3wKL3E1hdDoHrLgQQ4IfNaIeFDfo7MutOK3BFGF9kvGOhpBliY1ewVc1kzQdqkz
         4gsHQcy6RIgdv/kTGkv+QTqKGSE8G9NsEuqrS+dcAJdnLxUAa90GCCRf1zbwNJ5K6E1L
         eMKCIEMrH/7hcVSwt3M1cZ9NmFW5Rah3e2WH5/yPLTVqirAMQRf3A2KYUw9L0RX9ADEu
         d5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ad5+oOqOx9FzqllxfC4DexBRHNYEFIBHIX8/6EhJnEU=;
        fh=kGUJ7VHi2/KIlyYMu8qGqYH/5Nx3jehx0QKhf4v/I4A=;
        b=LOSycdR45EO9PRFkg0Ji1+cwxpeFZdx2JmLDYUQe6vLJLxlFFgPlFooe9dqtXVMZZY
         0c6lMWD9mEXVlIpHrIE556Q6EnNUuoD0w1Hg510iV0OGwBBpSgdB2Wb2MlBnxKMtYR1t
         39LWFoEJCGQdZr43E4pKpS3pAyY7r9BndANhPlXEt4aIVhZEGpY6eySweyjtEbCxV5sT
         v3XD+Xn0S/PLFp4DHgWJdxr5opKPmg9RTFEo8CIjAWTSccsfiRFYTTXFvgdAt6tszYlO
         wx/9RHYYjpHbgnEeA31/IcFPftBUE8ptzrrfh1LS9y6fgvvwhoC5UCT0DHDgqBj1c8VY
         TfGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780220177; x=1780824977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad5+oOqOx9FzqllxfC4DexBRHNYEFIBHIX8/6EhJnEU=;
        b=BWcDM5xWWcrAMYoyQ15+uauZHNoeWlVOeWfKiu2xu5Pp1gF+Gmcr2iNRZVzUX5GVlw
         1bI7cwxyARHMhGgxg8lW/9+0TG8T0gMeY+dak5WunhlTXHhrnwHCK82tiNUcSHo58lyv
         5fF1sX9fS7P/gpEpIURb4FrEwk1qMM5ybCWJO0GT1KRxYn6qqfdxNqJSsg6uc3kVVN/P
         06m2HPzTWNgUs7L7whmsSta1iJW0QrxiTUjfJ3slL/vZ9ycFEVCAeu8QqEPy5KMKyGRU
         4j4WdnxC/r2sKOSezoRbpQiaL37g5S9NpF48GnpOxGBjjQc1n+loSAWHtAMJySOjAGkI
         agvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780220177; x=1780824977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ad5+oOqOx9FzqllxfC4DexBRHNYEFIBHIX8/6EhJnEU=;
        b=jvKRnRnB8EKycTm1KaijK9plYmXwDiqWKXImtDdhq6qJory9AFa1E2RZx9MepuEKQW
         UJxpb7yoatEVLoTZVmRMueU1HVwhpN3c/AQs/1S6yKPwucdNNYC8Py5G4GmxP1OWj5FV
         AZ1emPdiTuggTuF3EEQjr57zu/ZwgUXdAf9spdUL8v++YIs89pEeei+98YNU9DG9t+6b
         DsZDIciFQ2/Ici5S0rzIR8odvZknKSfQvrbtWk/72f+NJVwWLELr5R8p8zxLvGiukwy1
         xKpZIQ8/vXFP0oinqaFkfe//vu6RZTOcHyOkxmAwG7a5qCAFonUbt++Q/FPIMLtn21vE
         QKrg==
X-Forwarded-Encrypted: i=1; AFNElJ9AjV05lrWZ77DmWei8EYQng9qM8Qr+sKUwejr+WcblxAmIBhf8lv8VYAqOoBcZhZ7IB5bV2ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMbG5S5yTeYb33UHdV0Vr5LcIW3jmNT739H0Or5TdOnygROtG
	47wH5wiyR01D9L402xJwaAg4q2NXC2a6PYP3DbFC7THIvjiBKDt2KkE979qHou8wn0eB80wmCtl
	dlgwLWMeno/cVtB23xT2kO6aFK7Zdtio=
X-Gm-Gg: Acq92OE9G7h7D06u7jxT2xHzCAYiAW5jYnOrt/MG0jnlKpr8dfNgSth2DfzuhrtD2sC
	Wr14+SeCZz6Rvc9D2/W3XofxnNWJOOcEk4kiaxNRZo4Y4ZbnawI7lRpIFbDpvmngFAh1b+B9gRm
	IFsDgTbDn5eMLO8hvGfvpjLV5/0YhbbjKt0sy5Mx/J8QjdX0k7iThL6je+wtBhgvL6I3+voidUP
	+XilSAfyNAmhuPJBzeULOtl+X+fLkksf0GxC1r3dK7ltQQVFoJPXtcOTXSvdkUhVBTotLfYYYBs
	DvbXJTEkbml/ly7s1aFKONDCKYKnyVyCBoWT6YKA76GBaDVFTlq6CuIez30i
X-Received: by 2002:a05:6214:54c7:b0:8ca:b44:ebf2 with SMTP id
 6a1803df08f44-8ccefda10bbmr106641536d6.33.1780220177173; Sun, 31 May 2026
 02:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530224646.160777-1-manishbaing2789@gmail.com> <20260531101237.13c5580d@pumpkin>
In-Reply-To: <20260531101237.13c5580d@pumpkin>
From: Manish Baing <manishbaing2789@gmail.com>
Date: Sun, 31 May 2026 15:06:06 +0530
X-Gm-Features: AVHnY4IWT1AIV40_nIAy0HlI41YN0FTAcCmU1TUBf-uuHGJOfqDwp-a-wimXkrQ
Message-ID: <CAJvdc_fwRc8QH=DHPtTNiWEg3bm0qqs_-jOwDQ4frUJLLfCQPQ@mail.gmail.com>
Subject: Re: [PATCH v2] mctp: serial: replace memset with zero-initialization
To: David Laight <david.laight.linux@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293384-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E5B3D6156B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

I understand that this might just be unnecessary churn for the
networking subsystem, and I am perfectly fine dropping the patch if
that is the case.

However, for my own learning, I would love to get your perspective on
this. I was carrying over a pattern from recent cleanups in the IIO
subsystem [1],
as empty brace initialization was noted as the preferred approach in
those discussions (including by Kees Cook [2]).

Is the reasoning behind that recommendation just not applicable to
netdev,or is the policy here strictly against code churn unless it
fixes a tangible bug?

Thanks for the guidance.

[1]: https://lore.kernel.org/all/20250611-iio-zero-init-stack-with-instead-=
of-memset-v1-0-ebb2d0a24302@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/202505090942.48EBF01B@keescook/

Regards,
Manish


On Sun, May 31, 2026 at 2:42=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 30 May 2026 22:46:46 +0000
> Manish Baing <manishbaing2789@gmail.com> wrote:
>
> > Use empty brace initialization (=3D {}) instead of explicit memset()
> > to zero-initialize stack memory to simplify the code.
> >
> > No functional change.
>
> Isn't it also entirely pointless?
>
> -- David
>
> >
> > Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> > ---
> > Changes in v2:
> > - Fixed a compilation error caused by a duplicate variable declaration =
caught
> >   by the kernel test robot.
> >
> >  drivers/net/mctp/mctp-serial.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-ser=
ial.c
> > index 26c9a33fd636..df721ca4e07b 100644
> > --- a/drivers/net/mctp/mctp-serial.c
> > +++ b/drivers/net/mctp/mctp-serial.c
> > @@ -536,13 +536,12 @@ struct test_chunk_tx {
> >
> >  static void test_next_chunk_len(struct kunit *test)
> >  {
> > -     struct mctp_serial devx;
> > +     struct mctp_serial devx =3D { };
> >       struct mctp_serial *dev =3D &devx;
> >       int next;
> >
> >       const struct test_chunk_tx *params =3D test->param_value;
> >
> > -     memset(dev, 0x0, sizeof(*dev));
> >       memcpy(dev->txbuf, params->input, params->input_len);
> >       dev->txlen =3D params->input_len;
> >
>

