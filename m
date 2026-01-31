Return-Path: <netdev+bounces-255342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJPrOTeKfWlBSgIAu9opvQ
	(envelope-from <netdev+bounces-255342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:51:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8055DC0A82
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28F923004900
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA42F616B;
	Sat, 31 Jan 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="BSdd+J4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C6275AEB
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769835059; cv=pass; b=NaCUHjqtEAwltqXLrCtJQ7EdheJaKlmm0tSikRDxw0si7IFimWhWw6mRpIr34Swxn+BsHW97mzSON3QojpbQs0trtpyhGxUYqBxr4sDyE37eOo8IRM58OEsb5SiA20lGcQRI4bqv7v5YP5+MSU7NECOW+9M6w3tzQkJmHFsvaAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769835059; c=relaxed/simple;
	bh=cC+tfHjgALp+ChLoCVME0aiSmjvXs3eC0RPWqKp+Trk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrrLmir5TIZl0ZUPK+c1PhMVC4rbdg4e9wQLgHchkWxKw2Cl3IUGQUeEvnN4nu7+8gDc0PjpxnlbE+Qf2K1pcna3ShKL2Wjur4vkWY3BInn1aB4oZPwBxWOFmw/pxSnM+vBdR3i5hE4AapevuOcMZDEFHqtFspudVeq4KSBWoSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=BSdd+J4g; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfd8ca8191so1111779a34.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769835057; cv=none;
        d=google.com; s=arc-20240605;
        b=gWwCoGswLQ9UMFjA4h8S/NbjJOU2+6lI+orDEzZ64DHIiMC5DvXxqmdsxCOP78mEUv
         3e3KXUZMQIoPojw/I+c5uzMAsPPTE2sKtIXZ2wsAK9tEEBpPfGN+rOiY/k34Zjk4jorC
         l0VqYzK3J2l+FvYeqk15n6HCvJvy8KNAXHO4oMxXQEQb7LvGtGlIO3Jz4p+50CxgG5gx
         itopgDfzHMLF9DKVqEwaN45empxeGu99BvDbt2Bj09IkiVy+xlkvJDjWGe4Cbb4Iw7jm
         SzYuH9nsztllTsXjTFLrra/5l7irKAzOzTa/3diadlLCtlZSLrLkXt+MtG5WUfbi3loC
         vwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cC+tfHjgALp+ChLoCVME0aiSmjvXs3eC0RPWqKp+Trk=;
        fh=kexyvIdZQS1eTRP+yYPa97E3SI3jOhsCitY6M+DkJ/Y=;
        b=LTlT9L+NLqezUQ3g81UqcSAK/4/uZk9/3uQuqgiLrhKnhF5MbY8c6lslRL+wGKPNDB
         4ljIbvA6F7eohJkQ7uwvg+8wvOcqJnEQFl/7oiPTs/cmyCzIUHs5WSuJ3lh9LukhtQfl
         aRJBNhwITTuJNn0RwNUnX5IJ4Zh03+JKNolXxYKymVhGmqqXerXQgtjBMNL4D+R9aE9W
         iBoVbrt2YRRpOW2NBeqJHYA+45B8HPrjfQ/wt1eNObQmt+ONOzxBc6SpdG3Kf27LQbdF
         NmN4FHOrJ1JlHTbjs9p0svq47oGR2HWhcSoPLVdnPq8OHDeWIiclxHy7hka+UD5fBktX
         J5ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769835057; x=1770439857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC+tfHjgALp+ChLoCVME0aiSmjvXs3eC0RPWqKp+Trk=;
        b=BSdd+J4gQLdaXPgrOySKGofA13joxicpgS1QnymttQFw8lww1c1DMHt8iE2b1Gy8d5
         xxATttQ0KBiEvWaCufslrhV1p7g+vYYVp8Av2v0JPodUfBmSuyj5smASQgqUBB50rW4k
         yC//4RVpa65C69Yw4u9kQEqzkdF0HmBeV6Bb2YG9MP85ALGArvvTvKBVwWVvGctK9uHv
         4LDUxxGqO807MuejasX0pzWMBWrAJO07qOzc0KgQk2P7yMYYEqCsvw6baKxDCwX3tdWA
         vxyc+TFJW8kDeIRnmtLuTzRp26y1VzoNUCzOBCPiOGoSHPl1L9A8+X/XUuFpWTd0/IyC
         k0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769835057; x=1770439857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cC+tfHjgALp+ChLoCVME0aiSmjvXs3eC0RPWqKp+Trk=;
        b=VgOwW8sdRUYuhhbzReyP9NMmVcHyR762r59Jj3a48myfEQKC7WmvuGG/GOd1ots6v0
         AQ8aVHh1oCpehox3pbem+IqSQvOnoj8RZfgjSKg/SMKp4y/fdh/q0RpTxmoqZFAXAYIo
         ycjiSA2ZlLQtjKK3DZHGbwJDl0hT3fYtdh7GhrI3+L3nFYf1cSUExqtbtNcXHrbj72OL
         +uwavJoEKxAzK7o8bhTQ3So0Jb6qehMw/y8TuItkHC5aQ0hcQLpGwTe+4wZ7BDrydtvK
         SZsA5c4BXY7tsdv7RGiItfKg/7drMxeO5QE3QcrMXep5vRsQgaZpdeR+jbWmMjr/G8Z5
         DiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5fwDQ+6FRWD3pEfzIIYUYVrAKd1lTVHEvISrXYSrEXGdD3KjomaIDf6wwY6H0X2kvGFuUCBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHCHgWjuMgjudLI7Fq85SclXJvWHLd9lmDdjx+LOwa2yp0+oi
	YmN4dILxwNG3EmEQOhOXgylP3P0j2BnPC5pudUH1Pea6Kv4RmlqJaNqp0q2Aa4emutkbf1siMHJ
	CpREBZWT/e56WyoU6+yPa7FxUCN0gflQBOxkLDpBX9w==
X-Gm-Gg: AZuq6aLm8Su2fREqJmgNoocX3UcChDepjmZ6NIjnheuaOC+LIn2Nz57BhoaGgxFPM74
	hdLvA5OBTCV13EeZmVFFkU/OAfcLh4mEwWB3rb66QX/GdpduSyIvmFox6OzLwUv6lYGytIlLP/B
	TO3tjCz7sPmAKO99K2sea1+z6w8e3iLzw/R37W/qrbGUFZiaIOBIpLLzAEErb9ZJZdYkR2M9xoP
	voI9t+6P76RxX1tAjBTag6GKLuyc4jGsnecjMUosTbyF3Ci6lOUgQFEhMJIeKD9KQhGkb303R35
	wDp40Dz8h0GO37JzV0u7ZdD64WkNJthlt+g/hu4l1HcOpZlswVv1ZLXiHNO8l+RxeNyQtuZy
X-Received: by 2002:a05:6830:650b:b0:7c7:5458:75f8 with SMTP id
 46e09a7af769-7d1a53284e5mr2493436a34.29.1769835057234; Fri, 30 Jan 2026
 20:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130021258.95045-1-n7l8m4@u.northwestern.edu> <20260130173912.33ac6c54@kernel.org>
In-Reply-To: <20260130173912.33ac6c54@kernel.org>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Fri, 30 Jan 2026 23:50:46 -0500
X-Gm-Features: AZwV_Qin7yUqg9jGHoj9wR4HkUPrh560kZfN7pUbw8YW39_n-C2fwvScnof66cw
Message-ID: <CAMFT1=Z8gc-F7LDpCN45Zuf-OX-qkhu61J=8d5vj_PWu90yRUg@mail.gmail.com>
Subject: Re: [PATCH] net: mscc: ocelot: add missing lock protection in ocelot_port_xmit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[u-northwestern-edu.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8055DC0A82
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Please add an appropriate Fixes tag and repost.

Thank you for your time, I've added the Fixes tag and sent a v2 patch.

