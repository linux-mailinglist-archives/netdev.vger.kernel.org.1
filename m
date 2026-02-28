Return-Path: <netdev+bounces-262180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOkWLKIko2kC+AQAu9opvQ
	(envelope-from <netdev+bounces-262180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:23:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 315AE1C4E01
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8279E302E7F1
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762C326D73;
	Sat, 28 Feb 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlpYdH5L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32C3246E1
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299421; cv=pass; b=O0f7C3VoApSnPnsh5ehHihW4dfuCqCyz7ONWosTP8in6Ukt/pTRY6Naj9V8l9EPdLaBe7oti9vcfkltVk1WY2oQ9sVUqRXkPUEjclMB7mH4ZW02xhIRRIc0JI633bSGhNqV4NElf7kcd23TgTFXapRmxIVf47v1Yk0jStNkBjyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299421; c=relaxed/simple;
	bh=SYL/RglKWV222F8qNl6faChb38xRGOantLcpNv7GtJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BweSUIZsxggW1VmxRGCzkwYoGtAIDxbA19/fmBIh0/xdkejCUMzF23JDt4Rtba1UvbDnY3S9+oc4DVvaIHcr5xravEbk+aW0VEC0TOn9gYJuhYIigPabUpQg0SShKXxfrkUAAPdaXIj7YFsyLelphMQFLcHeJcKHZqs1moRLn8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlpYdH5L; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fdf6ad2517so1901475137.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772299419; cv=none;
        d=google.com; s=arc-20240605;
        b=jfsD4AgnT//peKAUtQL21j+1dhgKS89+1WAl8LV0Re7EC33oHBgfvKfnfQpDiqs1tQ
         SB8VdWzwdRc4p/2aH+T4MdROHNe7fm16+AFVHLKYepQhcOmThxZp1z+5lsnAR8KpVKH0
         5yrN7TKHeZpTmDDkK1NVCA5TwDiQnO6nL70m1nPHAJ76TkwPVtZwZieWgfhRLtdbSUTE
         cqpbmaALgd8etnk7mFYkl1qfqUTcEnnVYz7GO6ijIhzxhXA7TJbyBzu3CwEgyVRP8Vk9
         yV9mrG+8vnakS4lCd0tdNd8l4FfQgExs1ppxwi6cL0TpOZKDuyhYMmrIkQFIJKH/J53A
         OZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FRd7a/R2xosKdBV4aMY7VY/BHvwASNNHg8EMXb+3ATA=;
        fh=e5JYNwWcWBufpRXt8g0OOq65l+5EufoElUTccuZts/I=;
        b=JscWOvAEx7v/lbwLeF8/e4qrg2EL1xQQoYfhMoRKm89tJkb4x12BVdrc98h6KC7MWD
         E2Vfmh27QX5nlVf5pa0uPdLh2q3NUh0iqRZs+tUTmZHhsjKnSiCaM27s+KDhI5Be9/2v
         2FMbzIwxW5VwZYyk7W9RCf+9VwfbPSGmGFk7K7cCtYlSvZmEPowkxgP3gxu5O0+mFFR2
         DKSyHpzlklLtvGxp183WIqBfnnmgRogCAi4fPiXLE0m4tf5ZORjo5ohP/hI1hIdAXd2u
         C+beYZW1VERuLhANrxaFM4T1UpSbw144ZZcCUyZDuUUl57xVkFFu4ZZQWfRAYcmdwDDa
         i/kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772299419; x=1772904219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRd7a/R2xosKdBV4aMY7VY/BHvwASNNHg8EMXb+3ATA=;
        b=AlpYdH5LKpF3Xx9Hsm3RtNR+WvMdK11rGzluOxBH3qrfXRB5yP6b65jirPZ8ChKe2E
         UdRdRomrcg99X+RkxWhxsgFRxWG0ybnnE70UR3isbWx/suyKI7sz+4HmNcN/OYTIzRAO
         ep8JiFr44MH59BlORpQHCEDX+KP/du3A6KpxYL64SI4uBQlut4DuWfobT0N/QYOjmo38
         EsON6+rLn6MFLNPV2EPqMmJejniKn4MAosSz2LKEzxQXMGXKM5yZer2Slf0q0hMfaGgw
         ADBSQ68y4UzlI7b69GPdUZnQOPH9GOuX3c+P1INGUOOZFIR97U15ZINOl784fVbcYUeG
         JRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299419; x=1772904219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRd7a/R2xosKdBV4aMY7VY/BHvwASNNHg8EMXb+3ATA=;
        b=sIjEEUP2Gi2RkHcyTfrVwWoo3pn0G9M1qpcEblHFO3tdji6/9GyQvsxNI7si/suHaH
         oKqA0nIwZbzI3hnbmWv52tKjJaLZ5uSlnWGQ3bxEMVGDijfT+3ynf4hh/IvpgbRwMmNl
         rSsuph5wN9Tq9/ZceLmQXNeZWBlbDCrHKxmkQqR3pVxSvhsWUntdF9oVPGhylVJp7glP
         aJ+ZC0fIyYeAZofU+hwvC7YKWyIvzKM6kfaQhtBGMO9NKaNK8CS6m8871tL/NZFc5O38
         x3rw6WTs5yau1zlXnSul0CRGA/EdE+RhjvS0UELn1Pkjxw2YqRE+NYONuiD16mPC2J8V
         ElyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4DmU+INxh9E/o+g1bdfuvFazdhrGdeaMcvmhwQ0b1w11Y0iMj7YTuebae0jHI/cjV0J2+Z3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWxHUJAt1Kdvk0BSW5OTZcx2YvmGLLUXDlrASQFynxVMMtId8
	RrGPSZlHBKT1t2or7e4gEkDLyffnbhP5mNFPjFI0dVbrTAmf8rrjdMCGn+EOGPeTvq2ytm3vbgF
	a2pczjTlhPvUgAoW8Grh4np7MIk3iYeU=
X-Gm-Gg: ATEYQzz0P3GxBny34y3s8tlySqfCea1S1aIHIS0U8ZPemjt/Bh61adF0hRB0w8ue0Pa
	7ilUsPTrQaJcCDp5gRT7epFndBpCgoGQnv59fE8OfgGURd8kS8C5jTwxGQL2vA8dlTq712JKy68
	ewerpu8agbl+h88TQrBhcqFYaJaxsplMVp2FaPecc6dMmmQNyiExffJoDUjJP9XjCaeHJNDzS4y
	rJTjTzYBP9FTO1yL2C96E7tmzkmEh4AHMhbpeS8Zsz7H+u0Z3OI7txZRlL6QmHXW/XVgDiscOlc
	a1UWIQ==
X-Received: by 2002:a05:6102:5090:b0:5ef:8ad:a3bb with SMTP id
 ada2fe7eead31-5ff322f7f5amr3963126137.9.1772299418955; Sat, 28 Feb 2026
 09:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com> <20260227173814.2f928556@pumpkin>
 <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch> <20260227181532.1616f720@pumpkin>
 <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
In-Reply-To: <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sun, 1 Mar 2026 01:23:27 +0800
X-Gm-Features: AaiRm50VBcRdPfE6amFF7ZVmf4vOPPq5wbRY4fA2Mz6Mrs3dKMFEYBG--9g-jPI
Message-ID: <CAAb=EJVCA-xxqiXqy1oNgvEhv48ecDxd=OicFpFrtqrHCvhmiA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262180-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 315AE1C4E01
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 10:56=E2=80=AFPM Sean Chang <seanwascoding@gmail.co=
m> wrote:
>
> On Sat, Feb 28, 2026 at 2:15=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 27 Feb 2026 18:57:33 +0100
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > >  # define ifdebug(fac)            if (0)
> > > > > -# define dfprintk(fac, fmt, ...) do {} while (0)
> > > > > -# define dfprintk_rcu(fac, fmt, ...)     do {} while (0)
> > > > > +# define dfprintk(fac, fmt, ...) no_printk(fmt, ##__VA_ARGS__)
> > > > > +# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_A=
RGS__)
> > > >
> > > > You can omit fmt, then you don't need the ##
> > > > #define dfprintk(fac, ...)  no_printk(__VA_ARGS__)
> > >
> > > /*
> > >  * Dummy printk for disabled debugging statements to use whilst maint=
aining
> > >  * gcc's format checking.
> > >  */
> > > #define no_printk(fmt, ...)                           \
> > > ({                                                    \
> > >       if (0)                                          \
> > >               _printk(fmt, ##__VA_ARGS__);            \
> > >       0;                                              \
> > > })
> > >
> > > Without fmt, gcc cannot do format checking. Or worse, it takes the
> > > first member of __VA_ARGS__ as the format, and gives spurious errors?
> >
> > By the time the compiler looks at it the pre-processor has expanded
> > __VA_ARGS__.
> > So it doesn't matter that the format string is in the __VA_ARGS__
> > list rather than preceding it.
> >
>
> Hi David,
> Thanks for the explanation. I agree that since __VA_ARGS__ will
> always contain the format string in this context, the ## and explicit
> fmt are indeed redundant. Since no_printk itself already handles
> the ##__VA_ARGS__ logic internally, there's no need to duplicate
> it in the dfprintk definition.
>
> I'll switch to the simpler in v5:
> -# define dfprintk(fac, fmt, ...)            no_printk(fmt, ##__VA_ARGS__=
)
> -# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_ARGS__)
> +#define dfprintk(fac, ...)                   no_printk(__VA_ARGS__)
> +# define dfprintk_rcu(fac, ...)           no_printk(__VA_ARGS__)
>

HI all,
I've also identified the cause of the build error in fs/nfsd/nfsfh.c
reported by syzbot [1]. The "use of undeclared identifier 'buf'" occurs
because buf is only declared within the RPC_IFDEBUG macro,
which is removed when CONFIG_SUNRPC_DEBUG is disabled.
To fix this, I will follow the pattern used in net/sunrpc/xprtrdma/
svc_rdma_transport.c by wrapping the dprintk call that references
buf within an #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) block.

static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
{
....
RPC_IFDEBUG(struct sockaddr *sap);
...
#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
sap =3D (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
dprintk(" local address : %pIS:%u\n", sap, rpc_get_port(sap));
sap =3D (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
dprintk(" remote address : %pIS:%u\n", sap, rpc_get_port(sap));
dprintk(" max_sge : %d\n", newxprt->sc_max_send_sges);
dprintk(" sq_depth : %d\n", newxprt->sc_sq_depth);
dprintk(" rdma_rw_ctxs : %d\n", ctxts);
dprintk(" max_requests : %d\n", newxprt->sc_max_requests);
dprintk(" ord : %d\n", conn_param.initiator_depth);
#endif
...
}

The refactor in fs/nfsd/nfsfh.c will look like this:

static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
struct svc_cred *cred,
struct svc_export *exp)
{
    /* Check if the request originated from a secure port. */
    if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
       RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
+#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
       dprintk("nfsd: request from insecure port %s!\n",
       svc_print_addr(rqstp, buf, sizeof(buf)));
+#endif
       return nfserr_perm;
    }

    /* Set user creds for this exportpoint */
    return nfserrno(nfsd_setuser(cred, exp));
}

This fix, along with the macro simplification suggested by David, will
be included in v5.

[1] https://lore.kernel.org/all/69a2e269.050a0220.3a55be.003e.GAE@google.co=
m/

Best regards,
Sean

