Return-Path: <netdev+bounces-261644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8w6iMGLqoGkBoAQAu9opvQ
	(envelope-from <netdev+bounces-261644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:50:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559D1B14FB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB50D301B791
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E5285CAD;
	Fri, 27 Feb 2026 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDQZhGuR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4728150F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153439; cv=pass; b=ZlPxPSJvlriPtwMdCGB8VKgpD2o80X9AX3x9uDzOg498IVOZAbuylGNz1kP1xrAj4cdHX7mbtLKZiLiT+gtq5RZUYoOsS24GHQqV81qRO8ujhw+bHWYIzcjCnv+75v2mAT1hjHVDwdzbEeKh094xCgszSrlHPoYgB6SJvk0tqlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153439; c=relaxed/simple;
	bh=Uf+sscOR+yuFgtYwpJVpmYCu25jcP+Fzfo2M5z6qkJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHcJHy70j7SoLvCIVCDof7Zcg2Oa96VFJDNRQO0GkD0kP7D/vuvk6HkNjMZCot3mlTx0/sfFsocUssWpvW9oH5zrGN62PNVSVf3hgeaRepIfBLymNLi0E2uJwv6eokarFM9osBvSqY+iWZeuwzot7XkDIfwXraNwBFothUfgGsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDQZhGuR; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65f771c6b89so2280782a12.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:50:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772153435; cv=none;
        d=google.com; s=arc-20240605;
        b=CLQFAH17hjm24k6O7Cxpq+KOMnQWb/WTJhGUAo+GvoQr7bsxrbzo+9d/50/dZb5x+f
         lar5krkwDEZwAVzpLmcH6zxdnqz1VvbUkb6Cy6gE895h+Qlzgp12abZAcXBsZU4i93Dn
         DZ6T0JBgsL0OiadqsdRpJtA3IabhvV4r1DIn9DH6VBLl152lKrxadmRVEOiaC+bYP4Cm
         S7VVZFcSTzppCE3wr0UFee7I9EEBZuHiaoHMvZKok5cO642GBRibxCbGucI3HLBsHqFk
         IHsJJpFtEufavY46r5LhjAkUiUf2wGQx188QO7XqNq9UGuLVYPCecYl3huQ5B6HZv1TC
         p3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XL+FmmWPFy+JjiNeiu6vxWROsh3ZKDuEY/7VIpcd5Cc=;
        fh=T5J1L/XqrWXxRrPtThwTY6Mkjp2kQpFIuh19nYxZ2AY=;
        b=fV3obmsH31sLRz7Romq4hOREz/Ezih1q/VnvwsRtnoFhO+f3UvZ9oIf+OPGesi5HtT
         Iu/qtKlWAGmYjMT5gr5qLccvE1iUxX4p9IrKrN1sxo5k/q0By0EMMjIetg7mavjhpN/c
         YGEI10InsybMJAFBahw48NXDp+8cUwJFQUZQVluk1GFzPR+91QiZurcsu+7bVIiPvorQ
         9SyhI7BgL5sjMAeWab7YF7hCy8eHd431nUrhQxDQ7/+v5xG0rwgVAid3VaGM9zuvhSnw
         pzrwWS1Q4Znl3QqyXOzg6oq9ju5u8OkLs/Ebb7kWrbVXvVkeePYoaI6aZq2txHYWTthn
         Aq3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772153435; x=1772758235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL+FmmWPFy+JjiNeiu6vxWROsh3ZKDuEY/7VIpcd5Cc=;
        b=cDQZhGuRlrDPL2edlRfqqpl45u42Q4/nqem+vDxFCZ7u9B/282b2hvcJKT9JoZ54A2
         XZ+dqBElwhhkKkQXjQY0MthBNpS0/rJobgNQWoCaF+O7ejgDDnlomcPbEVZEd7juzk/Y
         rjlGmH6x5V6MtKAJmkxEPF+flpYzRYJV6SYImqfTJBDr6mwxtD+3fELJC+Nqdmhy6FoW
         J5e6hB9ValdG7hCFVa4MnnowsaDJ4ziNsCTUaGkvvD8ju1w4z/qUXkrmEOeZRlFkRkqx
         UB82Edz/UMlgyOecEL9ViFBOWX9wP3+DiPCOqgYODQcdl+bO8UtmrsrV1azsUXp4xe39
         oKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153435; x=1772758235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XL+FmmWPFy+JjiNeiu6vxWROsh3ZKDuEY/7VIpcd5Cc=;
        b=pZk73b7D2/JVoTWClEjD9U++a8KWRHRwq4pum0avnlvi/KfRQQsRxWob0pTDM9QM1V
         CEi4NZ5kx/j+8TzS0ujANf+c3+fzu1tbC/5TvE4Q/6CjcuhCeKdEkb1PH8X36OEKafw+
         e1zQjzhNMfHyi3l7kbikfFOzn0+dN9asPAXoemNqIgvY2ripc4wN1Cl7VF9/Uxg9V3se
         4Ooy1MupiXzk3QDMBmGnjFN1gdfnj9IaimhNgQzVX3E1u2zOHvdSXvgDDvkVMIyJ7OGA
         nillWThsZ48FQ6oUPGluddjWRWOVIaMv531Y0mqB0tszjZpgXZCHPEB6R67oHeNI0CLm
         1kfg==
X-Forwarded-Encrypted: i=1; AJvYcCUAxU7EaMFpH4QchKq5hSW6yYJFXjDQe6wSekOmuOU80Z7EkD8eTyHKSVfMFbYXwacKWTBFnk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+A92KUDgRFOx56h01oaLzIZMbBK4yrYMpgvt0iSvfyU8J9seq
	kTk1BhMXDOKCOWpGrCzZ3qQH5hhSSXyNozqoR0C1Sy1VnYZ2myPsVyy2PAA7OlIyaNwsqKqrqXE
	G06t0IiFsebmGoC/dqN+/OBDvkoo9LUQ=
X-Gm-Gg: ATEYQzx85iZk5Zrlsdi0r3hicV6XH5CJdrNDqlyy6zt7fOA5WzE2cG8rsLpwoqQyEKi
	4NUsKn16F3gaROzp8c8gCwtuWZhrloSH0AELdVnZ8XwiGl+/kvHpQDcTjMp79uLV23kSgKoUYvc
	TBikS9xdknT6gVIMWLWT9pONVYpAYD/Rc1g1E2WpX2FEUUAV0Kmpj7Mwqa+IBwiGXfw6O3HE/g0
	upyTLjdzHof/bniP2ml0fvo6GYj1XrD2U3VS1JMqg6KE3apfVrHbLIOUUBpTjgkhDNscIk4YvAN
	0MRLI8OHkfgBXH355zr4bqpKErHp2GZmOXmg7Q==
X-Received: by 2002:a05:6402:146f:b0:65f:a428:e008 with SMTP id
 4fb4d7f45d1cf-65fdd4cb0c4mr709096a12.5.1772153435063; Thu, 26 Feb 2026
 16:50:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227001151.41610-1-leon.j.kral@protonmail.com>
In-Reply-To: <20260227001151.41610-1-leon.j.kral@protonmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Feb 2026 10:50:08 +1000
X-Gm-Features: AaiRm50jOH2clR6j9tf_ctr7L0PK_VdWJqSq13o2tmjs5iaKJMGoWPOcsuwangw
Message-ID: <CAKmqyKMxnBkBeKwA0qevmNH2m9WOjOHRV6DiUOTjyz48SBwYtA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/handshake: Fixed grammar mistake
To: Leon Kral <leon.j.kral@protonmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net, 
	chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, netdev@vger.kernel.org, 
	kernel-tls-handshake@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261644-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 5559D1B14FB
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:08=E2=80=AFAM Leon Kral <leon.j.kral@protonmail.=
com> wrote:
>
> The word "a" was used instead of "an" which is grammatically incorrect.
> Fixed by changing from "a" to "an". This improves readability of the
> documentation.
>
> Signed-off-by: Leon Kral <leon.j.kral@protonmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  Documentation/networking/tls-handshake.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/n=
etworking/tls-handshake.rst
> index 6f5ea1646a47..4f7bc1087df9 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -7,7 +7,7 @@ In-Kernel TLS Handshake
>  Overview
>  =3D=3D=3D=3D=3D=3D=3D=3D
>
> -Transport Layer Security (TLS) is a Upper Layer Protocol (ULP) that runs
> +Transport Layer Security (TLS) is an Upper Layer Protocol (ULP) that run=
s
>  over TCP. TLS provides end-to-end data integrity and confidentiality in
>  addition to peer authentication.
>
> --
> 2.53.0
> v2:
> v1: https://lore.kernel.org/netdev/20260226000915.27898-1-leon.j.kral@pro=
tonmail.com/
>
>

