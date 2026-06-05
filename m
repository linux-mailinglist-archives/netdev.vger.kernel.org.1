Return-Path: <netdev+bounces-295954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M/JeBpkjI2pUjQEAu9opvQ
	(envelope-from <netdev+bounces-295954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:29:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A799D64AF1F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:29:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mRr+J0LC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295954-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295954-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B89993045D31
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A931A062;
	Fri,  5 Jun 2026 19:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4B309EFA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 19:27:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687635; cv=pass; b=Z3xaC/Gxublu4ZJgK+UcT8IKebqk+qXRBV2DmRbinzoes8GIUCTtML5q0h4SHcMTNzThFUv/1qZ9dv0NVn64ZdABBC2j2NkBv9PeXFPFLwKs/mFbkOVWaiLXc1gMfcduvNfFm1L9ZoXgsqV7Y2GBWQmzVRAR/FYKjHZ7udHYHmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687635; c=relaxed/simple;
	bh=sET2Cu+uPqHEIbk8OY9oWDYq3ONF9LsOWbPfzIkUylU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJwONwwQlZ3cIZbOGgpFhmCSR+US88RmzCl7ImCvMDEA4ACvMaMv01F0dwenSY0lmrlmiI8Ss2DmXp/Wsv+O+kBJHyE+3M7Ize8/7Ol/vCMGNV7ykxRHYFCL75aVSXxY2gBQL4Tz3oU/j39ptOXIH49EGlDclx+9r/suLQqs77c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRr+J0LC; arc=pass smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec449cf976so313007666b.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 12:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780687633; cv=none;
        d=google.com; s=arc-20240605;
        b=NkJXt4JB22XKka7c4F1Cn+TAN6IoEEaKQzld69XINnHu2vIxPrFB14jr8bUoZvTdge
         IixdNM1JIiP1C8HsTOWXE3qzj4hPcwdT4yXXvmr9Dl5/KN5n6qknYHSagxRlnMNGRctX
         ZRipsYl6Lk94Y8hACM8i8MCNzHvs9UM6qomMa8Yt1zL2yL1X9SSCA92DrNk2f0J3doZW
         rBHHjYNaTo896xZenIGbUlHCGOgleg3cHKrxRBFkCFzDM6IYlN4bpb1cb/Aoyuzz1Hyv
         ucnBmWD2sMEkpiczQntW6CWdUJR+yx0bRbQLNt4h5RwDQpaI/YCrV2zos6euSqts0Qdw
         ygNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=89nKy2XbyQl4JdCmrh46SA8bEmFJQUXNkmlGYRWO+Bo=;
        fh=sTLk7zzgyMSzdX1qgGYHC5BA/eRsZEbY89Te1YCzIQI=;
        b=gnOfHj4pquJqu9rYGEqNaJgc7OSwkL4sGp5pT8TrJ2CQhNtGOxL/NsHXVXvYk9ix+N
         Lsmaz27o2e8UK6KwQnCfBe0iP6t9tcfBOoTPEXLlZfH0SuAn/czYK+LDv1k7uiAZDoEe
         eqygXyK8zg4d9gmc0dVDb53z/vw/H3tdQZsam3q0uz10fnGzxH19W9WypNzpPVLLGtOM
         cmZ1ZhP4Wtd/jDjrohG51yOAbnCE4+R5JKZKKItwo1rMZY4cLTp8BiOF4D1ANOrrvMrv
         vIdomE4A7BjMwb7+HlV7n0YDMY90rsWjF/hoTxHe+4rZj9tnjI0BYGAUj6v97nYM1MV1
         JC2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780687633; x=1781292433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=89nKy2XbyQl4JdCmrh46SA8bEmFJQUXNkmlGYRWO+Bo=;
        b=mRr+J0LCbyC9D3fteBKMpxMInTW9XOo9mctb8nsjASd0DgG8yV1Hx7+qPIFdER2cVh
         gF4sswNxLie2EwtQsy0CLYLbzEEGZqQ+V5xjDeXX/bJUi/O6+kK2zHtK/jjknbPc2UZQ
         QQd+xoD67N1FQxAGJhq7qeZs0FD780JD1xjI2AzehGbTrQZIhyncroWM80NrYJLIIvpP
         b1bfXGifWLo54eCe0R/O62/s1TEMkLyYDbcsQUUIFfJzmk/FpNGPfsw3G+8SBH4ijO5j
         ul5v0k08e6WnmpU4DpgW/okkhKmD+DmpCaBR0ih4X8xDPFk2sIGQEoLK1k58snnG4y/c
         cWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687633; x=1781292433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89nKy2XbyQl4JdCmrh46SA8bEmFJQUXNkmlGYRWO+Bo=;
        b=EIzX3v+k6UYj+NNrnSOTJfOv9OxKRi56sDhQdj2MsY8OXwq9KE4WNjXAhWgLLMbQli
         fwb1vKJz1gaixEEXEFhtInO8m+S0G7NC8Dko0ULrk2kth5MqTT62XpfmIxKhlOj4ppBU
         Z8P9xoJX7wbwRrdH3rgRXmDvTZf1Yvl+PsWl1gBGrGh0YzGMWH/E0KWS3gxiZ0sgAaOr
         NG4v4Iw30eeL9k4Sj/zkQ/IaL9lCjScM4unqUIYxHJwIeagaaUkC6W3uFoi5D6+FbulE
         DoMX5zQrYBQxFm7tuzoWnPCTK3mS0z9eC15pUcfit829d3QVjJdbmfMyG/6fDVysyvW0
         aViQ==
X-Forwarded-Encrypted: i=1; AFNElJ+f2LYhA7OCD5wnTN4deP2HaU7aPDwa2MRX8XfrrGX9uEC+Ujf8zfmhrc9AgIj0XRFTSRt8Qh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7keih9eKL1xcu8/ahGuOL+6MrBRsAFDZo1F1WsIM/szwImpv
	98n3zd85079M3uzb1YEh1MIZByj6IuyXOXzbgArGgsOK/pvpbReSMLgzFItwrZ9gv45UeHdhyYm
	aM28C353vPAkclP8XK9XINcuBvvcH1NQ=
X-Gm-Gg: Acq92OFPIgWjWtYAKDp3H6PrvV29PYO/sM1kjiao7hg2X9ERq9yQO3W7pDnHLw9JtsT
	rzP2UPKHk2xrZXEtroCJZe6fPZAeI5Z8hFK+siYDb066pNEOl7WUSl6ytCbdsk/J4JDgilqP+PA
	F1NtdQ0QJVp4dS3MAxQT3ixl0AcWLcLklB0ZM/rry9Sc9+qzsFII3tnMlLRlLA3XvQX5CJSxWxd
	sEKTXEe9VEh/X+6SRe62L9ai7699mnzRbu7Dm8S3PVG2OA0jPIe4J7Cy4qnUVz9T7ecfo7q05X6
	xnWKNVAPRgiSJoDIbck2Rhjm3Ons+u+Rqg/aA49V+mjBhvlQLEw=
X-Received: by 2002:a17:907:6e87:b0:bd4:6da5:d5b2 with SMTP id
 a640c23a62f3a-bf3703794a5mr261577666b.1.1780687632539; Fri, 05 Jun 2026
 12:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
 <20260531-realtek_forward-v11-6-50d60f5717e8@gmail.com> <20260603175617.7cc4f660@kernel.org>
In-Reply-To: <20260603175617.7cc4f660@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 5 Jun 2026 16:26:59 -0300
X-Gm-Features: AVVi8Cc3rq4mDjZzvyC1vg7M0o1kTHdJi7oCkI5OvRPFn9f7AzL4I3YFfUiJi8w
Message-ID: <CAJq09z5v_8y=t13cMtCMfpW9LPNFnRuHiy+qONPNknm4tXTZWQ@mail.gmail.com>
Subject: Re: [net-next PATCH v11 6/9] net: dsa: realtek: rtl8365mb: add VLAN support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yury Norov <ynorov@nvidia.com>, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ynorov@nvidia.com,m:abdulkader.alrezej@gmail.com,m:namiltd@yahoo.com,m:yurynorov@gmail.com,m:abdulkaderalrezej@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com,yahoo.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A799D64AF1F

> On Sun, 31 May 2026 23:53:21 -0300 Luiz Angelo Daros de Luca wrote:
> > +#define RTL_VLAN_ERR(msg)                                            \
> > +     do {                                                            \
> > +             const char *__msg = (msg);                              \
> > +                                                                     \
> > +             if (extack)                                             \
> > +                     NL_SET_ERR_MSG_FMT_MOD(extack, "%s", __msg);    \
> > +             dev_err(priv->dev, "%s", __msg);                        \
> > +     } while (0)
>
> Please don't duplicate errors. The errors are either due to something
> being wrong / unsupported in the request in which case they should go
> via extack. Or they are unexpected system errors (IO errors, timeouts
> and such) in which case just return errno and print to the logs
> so that the admin has a permanent record.
>
> There's a tracepoint in NL_SET_ERR_MSG() if you want to sniff
> user errors.

Hi Jakub,

Apologies, I missed your review comment just before hitting send on
v12. I will spin a v13 shortly to address this.

You are entirely right. The macro was originally a crude way to
channel all errors into a single source for automated testing.
However, separating user validation (extack) from actual
hardware/system logs (dev_err) makes much more sense. I will remove
the macro and split the error paths properly in the next revision.

Thanks,

Regards,

Luiz

