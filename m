Return-Path: <netdev+bounces-262154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FcuBNkCo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:59:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C43C1C3C53
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D23C1308E330
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CBF44BCAD;
	Sat, 28 Feb 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRFZjUr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4644BCA8
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290600; cv=pass; b=tTmkRpihv/el+oxSDVdIxbZM/1uAxzao5ysdo2m5II+A3tFcBfarqdfC++NeT4byfClLpys/FCB31XNyB827C9RoMfH5HxzCSEWKp8HdSOXWcYrKhTfzJtA2j2ZnFAx9ak+ytjq85xec8eDnqcN8H6UCWSPpT4KT2Ae4z2K3MK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290600; c=relaxed/simple;
	bh=l+nc2CFJi1IXeWZ82OvdasY9ZeRciIOALxG7YyaSEV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnIJksNf5sXR5ThgeI2sqbzZOElJHqAWLq9w8beW2BMe90AOdiBOYjsDp0QWmQr+IegADqQmSET71gssnG44UOyNvym0kS7OhKikKGFCZ+d5Za7WWpHuerz85ympahCNoZig2jajozX6RoIdVZcVArurQ6hHg8OdjhiZUMZKiYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRFZjUr3; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94dd06a96easo2103856241.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:56:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772290598; cv=none;
        d=google.com; s=arc-20240605;
        b=PYJqL/BrUxJ2Co5F2zatAOEXWzeOac5h32nhkeFBde///Ze+tUt+81ad415bhPWTIH
         1OhzSxklROrax932cc2R5NpQSUXIGiVfdAhMVUA8Dy+896vVHeG6hJv7pysOu5WFdJFZ
         4gw8Fpr2He5UpkLxKnN4B1e27drOPg5PkFjVBbS5xSZKJN17FNW+JTIvY0ikPT0wlYna
         m6+tVHVA4s6MPPYkPq8Vw6bkvA006mUTs+h6dD/ZrVY9JTWMDM07aL+VJlax9Jm4glNq
         H8CGC3x1Z8it3ytuBfg6L+vHUSK5Zgtzehbq1orc7OZ+vACtpWrPviAxVqIPtqsXzdf6
         vUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pqk9COadEgvOBFb/23CErHBEu+433fHexiL/qnBiq1I=;
        fh=42dmxN0es2/DxfF1cJpd7kUwRMTQunApkAFKOE4zRtY=;
        b=fd2AH3XLy1TbJw2hIxUD5wrNWmM4qVXqC6wNggPwW8Wtqs92maQWmvhmx0uj8+d1hk
         UWr99A9vfHK9ZKkZ7qHzPR3P+YPFVztHQH3efEkVlB2I+K3nPjTlWvpwwwhVgFTkZrhg
         /cb3xci1HuShOrRTc56ri6vfyQXJqWc70zfUPA4JXMkZU2tyc2j9Fi7RZrS7djlSmlgr
         wnC5M/r8EESLCNp+WzHpu8hZWqZv6P2TtmJmrbKUHArh0RoM2uw2TNBuc1LmoXh2Qtm5
         Pmv0s0/wtrS4A3ZwT7sNySBILjJDjC9yxVxzEqHoljaX7DqzVYfnSsihRIyEF0AH040Q
         32jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772290598; x=1772895398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqk9COadEgvOBFb/23CErHBEu+433fHexiL/qnBiq1I=;
        b=MRFZjUr3stHeSFDAbiTg0Xlo3O0DuoW4Bu+UxZ8lnhYtsJM2ziWUwXy3Giswwxz7xI
         6YBqfla6tTbQmNlrYLK9xWjq9Wh8gdhcH6OsGJVYPwOyTcldrylYDe83RaPDCNAWB4HX
         fsTui7m1ovYKB3+RCLZOTZwcG1BomY3Rv2rJVfTe2dbKwOt1ztaX4JW1tufW/SHTDeRd
         XKmr10DKK8f0C19v25eZA4HURRMadl7GE2xAklIity+yOCGb2eO/7kFl0JspfcOxo+JN
         9YSysGwlA6deblgiQDke/uxRQPR0ggQtapMtLZ/isNFB7sNBgsmq1W3LNQR2w/c0Sg2N
         vl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290598; x=1772895398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pqk9COadEgvOBFb/23CErHBEu+433fHexiL/qnBiq1I=;
        b=OLeyic7dYFNpy6J+HZD+C4vxI53AoB3VQHYBlbm8sVuD++oKXfC5236qelj7qJeI4e
         TmDkPnMQYF/+vLaz6iNno63i93oLi//19VuJfF+BIrwf1nN22e9sHB3lTD3tPVCqYA0z
         82kcSwqZKfCZ27hP/SLEOxo9NMHclUI4BY+Xx4SBZUDAWknj/tfD8t+66o5BEHLF9bCU
         AozsBS8HucPodvatq9qBPm9D/MXrxVAqNiMZK5yDSYlhQFOI/X9tb2a6VQ/Gl0lCyrW8
         gsluHEHD24dWMdvufrVRlDRDfB1N2JZB8dplcDB/VlnoO0J+lfgk4U/LzjBzTGgo0jmz
         maZg==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ/GLR83Jbv0n6tyRrFHwJTByuYCZ//NofRw0IJ0s5TbB8HbLOfrS8fHaNeJVO2uCXJLca6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAiLs01YDwT/8JxUvMpkmGTJ8jtbIZDD05keAJZdUlcrhbIdH
	6WAWsGWc+RxoYR3+INUhsGLtB69l0eCkmbnl3wSlHDmgLtXBooBKUQSSoFev7UwlfgH+1/nt67h
	Kb6A/7mEi2/NtvmbXEqadhNzkAOJ88jw=
X-Gm-Gg: ATEYQzwUVoe5ZcR/mHbDYFISw3PjBnPTqnYYQcjnkQNI6NQYdZJMZMF5YxqYYy/8DQx
	AOP0iOq4Edj91074Z5Ww4EMTa1oq1bqg4Ozn+wBYWn7j4SnITdARiFjQepYOofUCLhrL3l1BB1r
	c5FcmDGWARUgZsQdNfh0EUYOMKBE84kNLXlty+1kRlvzPK8glPY4ajJ2U+Aa56L9UYRcZOEPfMo
	bys4Z8picGg1bPbIWgJYRJdgBdgQ8QzP9/uWiild4R6LHBw8mC6qoIXUmTmDBSACq5TlxkASJP+
	Wn6KGQ==
X-Received: by 2002:a05:6102:2ad5:b0:5ff:8b8:9f8c with SMTP id
 ada2fe7eead31-5ff324b0b90mr3953066137.26.1772290598463; Sat, 28 Feb 2026
 06:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com> <20260227173814.2f928556@pumpkin>
 <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch> <20260227181532.1616f720@pumpkin>
In-Reply-To: <20260227181532.1616f720@pumpkin>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sat, 28 Feb 2026 22:56:26 +0800
X-Gm-Features: AaiRm53ag-1hfVVtgj1u_FKTnMnX_cLLjpCwm7mRUL74ZPqZKwszjpRVlGXEPTY
Message-ID: <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using no_printk
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262154-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7C43C1C3C53
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 2:15=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 27 Feb 2026 18:57:33 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > >  # define ifdebug(fac)            if (0)
> > > > -# define dfprintk(fac, fmt, ...) do {} while (0)
> > > > -# define dfprintk_rcu(fac, fmt, ...)     do {} while (0)
> > > > +# define dfprintk(fac, fmt, ...) no_printk(fmt, ##__VA_ARGS__)
> > > > +# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_ARG=
S__)
> > >
> > > You can omit fmt, then you don't need the ##
> > > #define dfprintk(fac, ...)  no_printk(__VA_ARGS__)
> >
> > /*
> >  * Dummy printk for disabled debugging statements to use whilst maintai=
ning
> >  * gcc's format checking.
> >  */
> > #define no_printk(fmt, ...)                           \
> > ({                                                    \
> >       if (0)                                          \
> >               _printk(fmt, ##__VA_ARGS__);            \
> >       0;                                              \
> > })
> >
> > Without fmt, gcc cannot do format checking. Or worse, it takes the
> > first member of __VA_ARGS__ as the format, and gives spurious errors?
>
> By the time the compiler looks at it the pre-processor has expanded
> __VA_ARGS__.
> So it doesn't matter that the format string is in the __VA_ARGS__
> list rather than preceding it.
>

Hi David,
Thanks for the explanation. I agree that since __VA_ARGS__ will
always contain the format string in this context, the ## and explicit
fmt are indeed redundant. Since no_printk itself already handles
the ##__VA_ARGS__ logic internally, there's no need to duplicate
it in the dfprintk definition.

I'll switch to the simpler in v5:
-# define dfprintk(fac, fmt, ...)            no_printk(fmt, ##__VA_ARGS__)
-# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_ARGS__)
+#define dfprintk(fac, ...)                   no_printk(__VA_ARGS__)
+# define dfprintk_rcu(fac, ...)           no_printk(__VA_ARGS__)

Best regards,
Sean

