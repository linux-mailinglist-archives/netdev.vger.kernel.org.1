Return-Path: <netdev+bounces-279903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u7sGFQJ55mkHxAEAu9opvQ
	(envelope-from <netdev+bounces-279903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:05:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C39433266
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B783029266
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10433BE65C;
	Mon, 20 Apr 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfKPRzWB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1123BE659
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711613; cv=pass; b=QH8GabaLU3O2c9Tz6OM5lEYZNHLNZXhjYdRST2r8ycvRpl1ZzV6YQ81FTAO2Q2yho8CNwtoIXHQ63yTLFLeuIjT47ZQIr6ax/u80+nk4ydOiTAj4DMwqupya0+fu+HmjwI1VtQLws5hW/JAgYMjkGks6zehM/8/fQrzCB+0psCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711613; c=relaxed/simple;
	bh=1KRYYbOyUpMPEhs9FYDn2NwMRvQwpIj4t0lvICMQsqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1/i9SbGpS3lUFNm2gaXu/ChWo8+bu8/UtxcKpwMF34ly+n0/6eEDmeut/HXetSAZr+1eq8bBiy2yr40Xl+VzLwmfMWBDAWdOIm0whwaWBtfvDLZyghGVSUsv3FZbHmWl7PJR0UZO+R6iuAuzFIKY3Q6nLz1sDsxp9YbYw1SKGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfKPRzWB; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46fab5f4f59so109870b6e.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776711611; cv=none;
        d=google.com; s=arc-20240605;
        b=cF0WV7NtHPR03rFLym+9YypQN2l37Ay7uxmbvkGr7KfGmMDfQbQfqbHhiGJ7FeBZPN
         Fx+kl3qAVirkVBw6s9LEyj69+vHIMIcazbBSFki25x5iaojGtxSIT1oiuXM0JVrx+AlL
         zHzky6SDjyavgFe+jZ8LE6eaeP1S+Wzstc0U3MhdIPDz256wm2RzZ4h+qgU5jADt3WBD
         nlGxL0LYsr53Zk8/Z6RdvhCXHmY6lb6EkrRAZsCfdDpWda0zok9sp8SbzfChj/E+zoNS
         MDz51XyCCh0HWhhiXMh45jp2aOW4TX25n5PbeHqThGXfYZ4myr80JOJm3TWWsHJnek1r
         UxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGQ8S6eo0NCGebeSoGAIcjWHTqx/TmEDZ0tG8HBGPxs=;
        fh=Gs+7fzZc+0p8MBQsgfGBlx8FtEZkxEtlrHhLYDNtNlI=;
        b=Fz3cgDbrjK30W+S/iCPNuLV3gASex7P4UcZlMwUZwbA4OgGW76/ZclqelE/JhnbKlY
         9JsNtkPf5mLTXcMKCroD3B9oQnk33UhnlT0CmMiLZTEOCOmawktHXTZnbnAieaEwqjF/
         kP0XXtZZdo1mdmZ2pe5sCb2hlisDOqFWG9ZI8Jmo4azv1XPij0Yx99uHiPdyETcahb7G
         dKSOp3BQeO/rC8XIpY9tVVuGGfX2+icYYqSkLzNQoeJLJqwwaG59h/dEtyVrdAQaLi31
         K5t629FTeYwX65UvnP2N88ClenPEuhn6rr6RhsWPdqXo23w113if4RD8PJTsBIGVuf09
         iZkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776711611; x=1777316411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGQ8S6eo0NCGebeSoGAIcjWHTqx/TmEDZ0tG8HBGPxs=;
        b=gfKPRzWBunsMh1EzMsH+FddpymT4E5HWqSGB9twTNQ5iCi1oJS/nbILC4fUiz8/9fr
         afaapayoVzhx0E+MAw+zyntHxudgQKDu0w8uCd5FWpwgLutz/zvOsw7zQTfkjipby9Lt
         16/8miW0U9xytFmLwIkJQYGoWAOrvc60CsqquVtTEvsFlp+qbvCtr9+VU2JPwyzjRJLg
         JjQUw3uStuBa5/HkPDehGHseP/tmPr7F+zw4yopXQAlQw/u7fpGnWCA57Mc3sgivFht0
         XY3A22E5X48NQO/n58qYvurOi94QyFQfhjhEoH9NtzexZbQlnMDNBuY2knIMdRyed+9C
         F+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776711611; x=1777316411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGQ8S6eo0NCGebeSoGAIcjWHTqx/TmEDZ0tG8HBGPxs=;
        b=HahoWI3SzZncxDkH9oeXPFBj3Kdi2o03B2UkPzT4k3zZf5GUi7xVvXmr3H7tjIINL7
         hG/eY/3MpU/A15yrbtBZHgzIlbWOLntkhzt4S6+bw4g+6TkUnnMu3/27ayoa8l3O1P4j
         MpyAWUTsRQzKoTW3qe934BcPbqBHl1aUaJB7kKvDRrjGUP3lKe9irliIZ03hc9D+XTKZ
         zzcmYldwOtucH0pB7OC++1klbhSGTq+z0fCGFlXaHB6lq+zsJQDzZO/p0jFQWpmf9t1F
         MFQRPE3QsPIZxb+9WAxGH9ndnvmsA7Ay2GjEDhTOCRntCoQu4JfHCyX//6HG4/hM0hiV
         TGQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GAPyzqxSwZm0/Xzy2ynTCiNJ0MxVsqSO8oSOdebhkfLJjMHJAdPDl+lq0+IqMI8oz84nxh70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjxhOqqRyeYC3ldKSsGANMqWCl46nHphKgAQ1OxnS8qItCuKN
	lmHOnUVIFiqoi0k3l9iBIBw6vv4S3RGWwEE/0OV/BnnzV0dd3t0UKasefNGaVkP5uDE5SCKJhQX
	6wVO2/5ZhCKxy9DVPA0bs2Jr5Kc3cziU=
X-Gm-Gg: AeBDievTBrl2zhlb9TTM0UWU87iZDBccZj7fn9iNStD+V9x0+f4KK5nDYenagwGrja1
	9MLTBAnZk1j4UGzLV+xDJcM1Xs97Od3l7EJkk9n/4xLwN1eCTaK79s3QvnNiHUMzCufBk2lnPvc
	GLlrNbhRQYy9FgYy0oXmY3QatjhGvMx+VYMkXiwQksmHJgp/zByq4EEryFhcdr+j+/QBlC6rFDb
	cD3n0Ey4F10RrNUTK33uveujkWlq3JrXZTjuqafBkylUWRefiiVJ1yOKbEgD5yY63rCVHP+6G9D
	FyJi7uEDqD8GxkAq9rxzJVmgnE/9uzI5MD0VrZFBr2LI
X-Received: by 2002:a05:6808:14c1:b0:479:dcb1:dcf7 with SMTP id
 5614622812f47-479dcb1ee58mr1165616b6e.7.1776711611034; Mon, 20 Apr 2026
 12:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
In-Reply-To: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 20 Apr 2026 19:59:59 +0100
X-Gm-Features: AQROBzC3Lo9dnnOH6fFmHSHn2qbQoBO1-4MGQQR1nIwU16VR4n-FB33Ywvch5Ms
Message-ID: <CAGSyskVWo7C9K1k1nCjfiyUR4vz41uXMfjidVYfW8Gq72OT9CQ@mail.gmail.com>
Subject: Re: [PATCH net] netconsole: avoid out-of-bounds access on empty
 string in trim_newline()
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthew Wood <thepacketgeek@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-279903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavold@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9C39433266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:34=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> trim_newline() unconditionally dereferences s[len - 1] after computing
> len =3D strnlen(s, maxlen). When the string is empty, len is 0 and the
> expression underflows to s[(size_t)-1], reading (and potentially
> writing) one byte before the buffer.
>
> The two callers feed trim_newline() with the result of strscpy() from
> configfs store callbacks (dev_name_store, userdatum_value_store).
> configfs guarantees count >=3D 1 reaches the callback, but the byte
> itself can be NUL: a userspace write(fd, "\0", 1) leaves the
> destination empty after strscpy() and triggers the underflow. The OOB
> write only fires if the adjacent byte happens to be '\n', so this is
> not a security issue, but the access is undefined behaviour either way.
>
> This pattern is commonly flagged by LLM-based code reviewers. While it
> is not a security fix, the underlying access is undefined behaviour and
> the change is small and self-contained, so it is a reasonable candidate
> for the stable trees.
>
> Guard the dereference on a non-zero length.
>
> Fixes: ae001dc67907 ("net: netconsole: move newline trimming to function"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>

> ---
>  drivers/net/netconsole.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 3c9acd6e49e86..205384dab89a6 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -497,6 +497,8 @@ static void trim_newline(char *s, size_t maxlen)
>         size_t len;
>
>         len =3D strnlen(s, maxlen);
> +       if (!len)
> +               return;
>         if (s[len - 1] =3D=3D '\n')
>                 s[len - 1] =3D '\0';
>  }
>
> ---
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> change-id: 20260420-netcons_trim_newline-36f6ec3b9820
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
>

