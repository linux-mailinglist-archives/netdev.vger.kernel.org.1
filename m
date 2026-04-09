Return-Path: <netdev+bounces-276857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNXlFaRQ12nyMQgAu9opvQ
	(envelope-from <netdev+bounces-276857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:09:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314C3C6D84
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C87302494A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFC5371041;
	Thu,  9 Apr 2026 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkXwV87S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214E36EAAB
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718524; cv=pass; b=S+bGBmSBNdLwcQQci7WpfjT21vGbxM84qg1PvLvG3EhtfFpXRu1QP+8/26QuuGbCOvjY7/nKuXahWmfVg357M3DKlpbwSHeAe+su+aUjOil4HTnh/v0Na7CQQTaOf5uag6ywnJI3JzDrdM3ChvXKw9hAuLCK7GMKujt3F6k0OOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718524; c=relaxed/simple;
	bh=PRFayrKxPdZ1mTEyp14s0b1w0yWwkt+Ou1Wuz12o2xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi3Tu7miCTJhYq8G/wgeJvK0q8CDJm7brSmZGnvkzv60Kfuf+u3J48pBC35O/U6oq0ho+vCGRP5eRPt44G3/A1Tj3/meZkVqmiI8Ut+pnoTC47xQiw45haYlSlfU0oqsOt4PhSdbcl2DWCmPb2Ox5N5oz9PKiEVmGmeuOrHg2pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SkXwV87S; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a1e1817db6so4915036d6.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775718522; cv=none;
        d=google.com; s=arc-20240605;
        b=KPqvheu6TmnJtmeHWMq+CEdclDy7Yyl0DLf7n/XzifxZzdoMgjKxr8/TOA2d20+R5Y
         FPBtk0GmaUJj1olJISz57UwNX9l4QNZr+86LBfvGD/F4FrRZ8hJhlJ2YxSYNIYrZnA7a
         bbA8kq7z0lhvB/qBirL9xyy+Se4vfXMuXKHX0wuJDyjSRsN/btL7qK5EBnByWPW2XFPF
         hUKCPS7AeDoa6kOas3v+58J8fgrXvXq5XxgN4jaz9Ee0Epf47uZQE5bG9x1ZC+K5LIdl
         8JpA0+3Z7JT4OzvY+zCApT9VjYNWiRd9gAwJzlWX0UcPJNEmlOfLY/V4wEnnVJIdyHlc
         tLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G11Ctve6TNDq0sGTdIs3vggtNtTBmZS/FVmEfytylFI=;
        fh=RiyrFOGqRSbGf5FxcD64CKq9STLxTvT8waRJmqs3vT0=;
        b=jh8hGRoLsZc/S1Lf3ot3IHyNGlrcX+FYzcncKY7TsGAs0HPSIed1HnkqQXcBGoPK4p
         tovfBrL++JZPvh/JPSiLX3DiaBDzvqTjdOv+iEzl5LFRtw6q0YugyMQcDk2pRc4B55EJ
         SANhfE8oLna2UJoxvC+/IlNtoeVldgOT551w/wQICptGzVrI3hgG8GK7L+VsbVMi8bRc
         J0ckBEBLAYqzTSDlKw/G71WTByb/PAPHiLmUom0d5tjLMuihybF4i2isA4B7CxsYGHof
         h8r8qz+YEyj8ShdCp+c/3uc6o2wCj9zoYwneMVJdC5Ph1sCkxJtSH6RJIld3dclndH83
         zCdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775718522; x=1776323322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G11Ctve6TNDq0sGTdIs3vggtNtTBmZS/FVmEfytylFI=;
        b=SkXwV87SzkRVc316HffeN6yld2hUkvgQIU1HS0s7U/PKLvBX3doCUIVCiE7avZATQP
         rsBu8tsD72kB8jSXWGIBVVCTmoecZ/V+0/+ZBqw1Yo/B+ilFML8pqUuKR5sflqy/qtj5
         dtYqNjDGQd9MD5suBpCgmtsirK/8wFWvIFoxW5jW/r19ZhL42rzBjKTnmjwEGI9of1wl
         pVQStgEyYX2ZmDmyj4A0uA+XwRD9ziBDfdODSPbqyDqjeKS5HWEuzc6irrJXfnM504e6
         5vhnRgKkQoYmNp/Cy2bJpDCZPKt4z0v8BGsxTq72ot5jVcR6ZASaKp760XXsMQ6Pf0i/
         +BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775718522; x=1776323322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G11Ctve6TNDq0sGTdIs3vggtNtTBmZS/FVmEfytylFI=;
        b=gWFpreIDitoEKehLYEj4VUIsA7//iOGdi0uj3ntM1pBmRkq1U17G8kmJrtN09kW+G4
         1xbgKY4hZ8L+Q6eMiTuqmFXM+EQgOfhXcVLPqXGOiZFRa7OIBqq+cGBNZASy5Nmfxfag
         zlOzeOjMidKx28fiFwc+3i3xMZXlZHxReiiqanTnwENzgo4/oL5zj58W38MyZ0A9/bLF
         yFT0+a9QYLYCIHWWooa9zEvEuAeAidnx6KopgKeyL+/DsNpfpLWt+uxlU6E2W02PLoux
         6D7dOj4G/70Bc3baCwODFUgF2utg9cgzbf8UvLRF8WzGCH0bcWhTsnxYL/+mG76kb8n6
         1bSA==
X-Gm-Message-State: AOJu0YwGF9r7yHH4RjVJsJCo16BeEDUq6SjEcmhfLmTyNX5VhnPTwUd4
	g2IZ1LBYv7OmovlM8mo4B8tDmJJOuKGLOS/YA03NfVTV2HsnTC2iUhJoX1UXSzKheZQEQxZ6k2L
	yGg0t1RxtpSoy+JzXF23QgSucheAR2gcwnxvddQGO
X-Gm-Gg: AeBDietT0SIZBprPAIWNegATy0gQQ+HSRaU+FgJjUnMwKT4mGyUpwsjUBanpFjy1w4h
	7EInxWRSz0Lq5APppxR9bcV1gklCdSuePhJKfdiN4k0Z4vc0jSzm89CjSYHNctv4vOQJIUwMuOZ
	47PJJPJd514Ip0w7ZA/DM4qhuSKghb+8OQ1aSRqwx5z4yhQ876BBRj1ldV1fbPv9D+3mGe6v8nq
	Izw8Jn4lNS6KTDiei9rjWHPM6g4+r4s0DHR9dNIYfQR4tZpbYvIrbuRf6/cuXIitjwXOr7TPB1U
	4qEcsOs=
X-Received: by 2002:a05:6214:4985:b0:8a7:1745:c50a with SMTP id
 6a1803df08f44-8a71745c752mr399083816d6.41.1775718521778; Thu, 09 Apr 2026
 00:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409012235.2049389-1-ashutoshdesai993@gmail.com>
In-Reply-To: <20260409012235.2049389-1-ashutoshdesai993@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 00:08:29 -0700
X-Gm-Features: AQROBzCFLDmd8uWNsPBZtfGSuu8peKqgi5AWIUFx7ssHDeVE3xo0QX7B-xKT5B0
Message-ID: <CANn89iK7bzV0VpPsP5nu0mV3GCsN5MOZJgc_s8a3B2X6Ui6mxg@mail.gmail.com>
Subject: Re: [PATCH] ax25: fix OOB read after address header strip in ax25_rcv().
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276857-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6314C3C6D84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 6:22=E2=80=AFPM Ashutosh Desai
<ashutoshdesai993@gmail.com> wrote:
>
> ax25_rcv() calls skb_pull(skb, ax25_addr_size(&dp)) to strip the
> address header, then immediately reads skb->data[0] and skb->data[1]
> without verifying the buffer still contains at least 2 bytes.
>
> A crafted 15-byte KISS frame (1 KISS byte + 14 address bytes with
> EBIT set in the source address, no control/PID bytes) passes
> ax25_addr_parse() which only requires len >=3D 14, and passes the KISS
> byte check (low nibble =3D=3D 0). After skb_pull(1) in ax25_kiss_rcv()
> and skb_pull(14) in ax25_rcv(), skb->len is 0 and the subsequent
> reads of skb->data[0] (control byte) and skb->data[1] (PID byte)
> are out of bounds.
>
> Add a check that at least 2 bytes remain after stripping the address
> header, freeing the skb and returning on malformed input.
>
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
>  net/ax25/ax25_in.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
> index d75b3e9ed..92baac77f 100644
> --- a/net/ax25/ax25_in.c
> +++ b/net/ax25/ax25_in.c
> @@ -217,6 +217,11 @@ static int ax25_rcv(struct sk_buff *skb, struct net_=
device *dev,
>          */
>         skb_pull(skb, ax25_addr_size(&dp));
>
> +       if (skb->len < 2) {
> +               kfree_skb(skb);
> +               return 0;
> +       }
> +

Are you aware of pskb_may_pull() ?

Testing skb->len is not enough.

I suspect all net/ax25 is expecting linear skbs and never considered fragme=
nts.

