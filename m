Return-Path: <netdev+bounces-277575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFOSEPRl2Wk5pQgAu9opvQ
	(envelope-from <netdev+bounces-277575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:04:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BE3DCB30
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CC28300E02E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5D73A875D;
	Fri, 10 Apr 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GhzVshOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A813A872B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855090; cv=pass; b=njtyWdrhrnP8jsTmwbQGz5qiUtu09ze03hJkLz1Or68a7UGySncAsem/WPDaqFPhdN904lGV8T32DAsw7LnnKMWGKVGmLBWie2xOm4ZI2R3URBUp+/iyMyampP+eSQx/Nc3b5PHH2JBDQLROB1Jz5LYjFxGDwJYbT0+5WkcQ0Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855090; c=relaxed/simple;
	bh=YStzs6Fi37GPs5uij3oaiSL4lrGkoy5OMwPX3grHL9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq0cUY2YFPFy7sgslIzOX3hH4LrOH0sxE4poYak5md4hHNWZhX+TIDNAl89FTBY3WkxF4JxOyW3m1Q/W1kem/EVwhi+PzcfP7uyGd9evsYqOYFKhG9KofRwLZ4+f0LDpTUY3ZhAblOZAKVkSxz8pSBZKsOgGQkBDvn4YD3W2duc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GhzVshOC; arc=pass smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2ce102afb0aso3301935eec.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855088; x=1776459888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/sTH6sik8kYGv7FpoEN6SjPJ95IH7BD+VNumMxAg48=;
        b=Q61QtvAqT5UBwjqG7rg1hNaSu4M8fzUitXCe7UUMY5yyzjxSJ4y4dhYLnXTj+PC3TL
         uIHf1IgH8Y8xCohxYGdTie4grx5I4meWyfpBdS6eYlLU2WfB8o/b+bOQ62O+LKf/FGm/
         eRqaRU6gJwS80LPmqwSYljdReh4yEfzuX1NXYZKfkZ9JsRmh5yezfsHMyiX0sCAj/CiE
         9WcyA6sFXF/Jtc3DhTDC+Ra9m9nnSw2UjaAYaQQKAjkXmz9rHUZvNh1OZWZR1CwUSyZD
         CkYzO2JtYxvTyF1IqnMPtx+xBLDGD7ixKqmj74+/QvYGKq12PgBzUGaIi4gvCdRfk5lF
         YHvg==
X-Forwarded-Encrypted: i=2; AJvYcCU7CA6uiSb9jEhl/qwyJMwKqsrkF/6eSnouReP/mKIB8fOUfwO543/4TvpGHBlyvUdVF8ZkzZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTJ89EV/1J6rGlFzyk00glvVTWRqgqOmuillnKXOubeuEQ6JN
	qbUscKvAIIls/LhWYKUm5/8whKoVHHFsMCK6kZ+b+nn7TnBglAkFSUkWsSFvH/wICoYkZP0X4Ea
	X29EMQBAP0MCrNIz4maScPKrdmXOcqXRKZpp1RdJ3gEpM35pq3IjCxZFWgqLkhx3kHNuSbfvYTc
	qV9D9XDialDFAh2Y76Zatr0jE3PZowpw3Z/BGDZGrNs7fmzuEkQbAlvlet2cUKpA2No/JbEQ/0l
	U9chIJmValgjngPLg==
X-Gm-Gg: AeBDiesLYG3L7KXCyc2GG9MVU9dy8zYl3nVyDvL4zzTj4B6LR5553MoGls1+Hxwh0qw
	f0xMjp133kC4hhBrH+lOire8Z8P942vxihMTh7Gb6Sh4USHbpfHP8ATn1aolvXWJ/MPiN4BODFu
	IKXqByk865kMAg9cJZOtNwmheBHnpS2U0mPhD+3dyDt2Jz8YA+U2dSBCiakUcr/DHy4PqnMqd7D
	d7U+IzNtlZw8YQOAKbQ7YujmToHpJRdohxY2MRvVNZfOGHkXiwjJtzMCkX6OzxpcCfsbM2NqiBf
	zkK3Cq8FOESHRrs0ukrDa5Ms13ktA5FSvQhdxDEvHFDfmLxMhdETOlp4ZQtKRt81l3eRYaUbQXM
	gcU6Hx5AGdXLzOek4d7raFD8j5BChxbL5AdKwTkAze0T/yt99lCPT9P5YOZcqPdVTblex1lpHQs
	bslH9n7uPjpNHAl5WJy5aZYgpNVgqy6Y2hQs0py6jW1pfhr4gbWQqswvR1hlJgFhw=
X-Received: by 2002:a05:7300:724f:b0:2c0:f84b:2455 with SMTP id 5a478bee46e88-2d588e82bb0mr2591032eec.19.1775855087800;
        Fri, 10 Apr 2026 14:04:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2d55e902329sm305640eec.2.2026.04.10.14.04.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 14:04:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d03ae4f2aso1804272f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775855085; cv=none;
        d=google.com; s=arc-20240605;
        b=UMGyHJyLkkdT4pVmDn2VTsf+V/3mNP8xf0Tw0T/E7xTm6eWZwQj0lEb2W6Y6tIDENM
         fi0Xp6jqJWlobYCXeXhlPeNY4n7Kp306FyL2Dutz0oqjAk1JBBCgdMCxzxy+LPNivc/t
         rIbvSlVoN/aG24lNqY+Hy4Juq8cdldjleREq7ipaLZSgfzgg2kcUvTYx/mUXVuGtq1Cr
         uXte3jHjz3Ure+NzDmtbQmcv4uOj6qY3S2R04JyvYyixDVRXKzWoh3jZAZzmTWPulKgI
         ZfzGEAbJZuUfRBg3GVof5N+hpaekA6TQMKCp4nYDC88kNuPSTHpr2aghfioTgB2hnHNP
         ne3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L/sTH6sik8kYGv7FpoEN6SjPJ95IH7BD+VNumMxAg48=;
        fh=ggOyPaJi9FdnIrOQR4UVSTR2jOC5Tzt3xy1vmI6NO0w=;
        b=aNh5HufUkXfEV/fPLD6oUa+G4O4VyHyEntILQVA9YIqu2deenWOttTh+G8J/fpNZ+l
         wC7RZM/J83IUxlwajuGTUTmO7CjfRGSPTjOyjAxTYSAYWTenuMI1HqZPNdWSDkQ7TYoy
         iO1fhsZPp+ZSZE0oj6+irjGtnAyB/x6iIzxePYqE8C5tJSAjca3J+kLHcW0yYkd/ZWua
         n1FphF6a9sZjr7D/Zs0NeZ4tl+3sbSN48u+TadmoD5HwzmjLYSdTtM20BNAxFbkG5BN3
         e2o/cMuWH6nGkzvpF8Qzurcuk3gTnYwP4RgO44QmNLjMvDIGDcoLxZxo/0ykco8IdRqB
         +2IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775855085; x=1776459885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L/sTH6sik8kYGv7FpoEN6SjPJ95IH7BD+VNumMxAg48=;
        b=GhzVshOCR2d2JLP43yO7BWSyfrTlpdz+bBuHjzVxhA0za17goIhKdt6LsKqm3BqQvX
         f3QyERmOKJ3uygl3vESIXdovwaJ4I9Kr7kXppfaSvojDNvvpY3uBGI69a/lIhmX+4CnY
         fZk7uKbI4qayIAu4/mBnS/ENwKmMtku8ggXBE=
X-Forwarded-Encrypted: i=1; AJvYcCWuoDvtbw8YyQDdlteOOkMGc0RAJz0y4c2f7mEfj+mp3ofRNN4tH7c90jd+D48/+3P5SY2N/Po=@vger.kernel.org
X-Received: by 2002:a05:6000:2906:b0:439:fbbc:d593 with SMTP id ffacd0b85a97d-43d642c7a90mr6978473f8f.27.1775855085559;
        Fri, 10 Apr 2026 14:04:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2906:b0:439:fbbc:d593 with SMTP id
 ffacd0b85a97d-43d642c7a90mr6978440f8f.27.1775855085044; Fri, 10 Apr 2026
 14:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk> <E1wAPBR-0000000F7ju-1fD9@rmk-PC.armlinux.org.uk>
 <CAMdnO-+TK65AxjTsDd017Mhop+VC3Xf8jtfaTXYpE6wBNZOt4g@mail.gmail.com> <adi3Vks-N0a83ylE@shell.armlinux.org.uk>
In-Reply-To: <adi3Vks-N0a83ylE@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 10 Apr 2026 14:04:32 -0700
X-Gm-Features: AQROBzA8eu5WjtBEGnB0inAkAMz407HE65PW9MMqp4ETiWDYykwhH2trVnWL8Yg
Message-ID: <CAMdnO-KLJrbTxaXrfs_s1G=rn0PjSrQ3cdYHjrnmvXdPJ7=B9Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 02/10] net: stmmac: rename dev_id to userver
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Samuel Holland <samuel@sholland.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000928cea064f217b03"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277575-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: CE2BE3DCB30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000928cea064f217b03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 1:39=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 09, 2026 at 04:07:42PM -0700, Jitendra Vegiraju wrote:
> > Hi Russell,
> >
> > On Wed, Apr 8, 2026 at 2:27=E2=80=AFAM Russell King (Oracle)
> > <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > The Synopsys Databook and several implementation TRMs identify bits
> > > 15:8 of the version register in dwmac v3.xx and v4.xx as "userver".
> > > We even print its value with "User ID". Rather than using "dev_id",
> > > use "userver" instead.
> > >
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/hwif.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net=
/ethernet/stmicro/stmmac/hwif.c
> > > index 3774af66db48..830ff816ab4f 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > @@ -15,7 +15,7 @@
> > >
> > >  struct stmmac_version {
> > >         u8 snpsver;
> > > -       u8 dev_id;
> > > +       u8 userver;
> > >  };
> > From the XGMAC databook that I have access to bits(15:8) identify the
> > DEVID field of MAC_version register.
> > The userver field is from bits(23:16) of the same register. This is a
> > customer defined field (configured with coreConsultant).
> > Currently stmmac doesn't care about bits(23:16).
>
> Thanks for the additional information.
>
> I don't have any XGMAC documentation, but this indicates that it differs
> between XGMAC and previous cores - GMAC and GMAC4 cores, 15:8 are
> documented as userver, and 31:16 are marked as reserved.
>
> Note that the dev_info() also prints 15:8 as "User ID" not "Device ID".
>
> To confirm, is the XGMAC version register at offset 0x20 ? Later GMAC
> cores moved it to 0x110.
The XGMAC version register is at offset 0x110.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--000000000000928cea064f217b03
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGbTCCBFWg
AwIBAgIMGHX6KxYK3WW2YyprMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDkyNTEzNTAzMVoXDTI2MDkyNjEzNTAzMVowgbMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEaMBgGA1UEAxMRSml0ZW5kcmEgVmVnaXJhanUx
LTArBgkqhkiG9w0BCQEWHmppdGVuZHJhLnZlZ2lyYWp1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAKWV+9PYvG4njqRsbQas79f8Q46VL7b1ZxvWT6ik6VMbdRZx
tfpfZalVXksqcb02/N1H7UA9V04cV2q97FkSr/KxeFLMetPb3cVJZICg23IRO2NTPdmgPFzwkPTo
35h9h/OYLgh3/9a1nTsC2xqJa8GtohD5+42rsskGcI57U4n1r1L4R5IL9ypSqDxX/xVEAdGI5FTj
VgvoZC6iuEbnez+yO8TT3wun9b/PQowOB5P0CwIFv7ERW0S1s6B8yrbsoaTrz0vQaEA786k1pZkg
ykC1+zXq/iTyZuPP4B4RkzFd43Pw+GAH0Tt2nx5V4rNisJHeAVNU92Gj01cEg0I+FnsCAwEAAaOC
Ad8wggHbMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQw
OQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
MzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIw
ADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKQYDVR0RBCIwIIEeaml0ZW5kcmEudmVnaXJhanVAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1Ud
DgQWBBRq5Jlxz3MqC+zEgUxK566xEc2g3DANBgkqhkiG9w0BAQsFAAOCAgEARXrmeeWA31pp9Tr0
M6mOlMv+Pr2raES4GzPSyftvxf6tBQCBNaqi6LSbyusDYOj3mG9bp6VeVn+68OxNY9iNAk+ujtId
f3+30BlZOQ1v8z9u2peUOUtWI60y2MxhdH0X0n2H+BCGvUOFqs5z440jqqy1HsscZTXHB7FEZmVP
fyD+0Z6cxyh7WNC6+BgLiFwf8iqmAbu7Yb1sGTUGyS5gfYEjJbF2PJfwNUcJDd7eS4w5Ju5mK5y7
spgjH2/JmDgbkpSk9JyuWfjGZIg4ah/q2nb6UMd1XJb6gLQZuzPOI3SgXPvd8MHGjKZrX2BHOBSC
bJJ8rp4w4a9QMS6dde2MFObusxkZAft4tUnwo+ProchHs7iA85sL7sWEZhAmjmKKCpECpEfZm0+/
hpvKQV3AZp5vBstb4IVL8QmLj8beDVHYnNhEicsSiG1wW7zSYyBnmGbFRrFQIJnJDWPjTZOlVEyp
T1ShrXRCtqJpOt6rgg+rFEY3D8j6/bAkJXnmKnE2LZ0YyrrKk7eC6UfNNimx38w3NWchtcGY8zJn
Y/1/C9Jv/mWm/2lK8nvusOFxhKmbG83Hx8toQdZ5F1kYk6zAWjfB7lwXr/En9mCmLieJ18hen9EK
qbYyUkmCmuoLi5GXFMJy+iQv6DgMVQ7CACagybU6FUrmL9lVa+A6caBEEh4xggJXMIICUwIBATBi
MFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9i
YWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwYdforFgrdZbZjKmswDQYJYIZIAWUDBAIBBQCg
gccwLwYJKoZIhvcNAQkEMSIEIKxBtT0XlPEv1PRsOCxZHhJYg42Fs8dobavsL5g3SDEOMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQxMDIxMDQ0NVowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAILUmmdUnbCi
svOMN5GzRsAnnHC/ePzlXygRZO+Zdm7EmvwRDvIpqiEeUfmUntSdzpTaJGxv3FbR2YKwjStGOc/h
UOEMNsUETQ7SLyax3C3l7eCgP1DgiRyvU7cSB7mazCeT/J+OfR5EG8oYqH4yRg5P6VMcQgsxV7KC
wO95XWDE5HZNl4/EYGa5fafsCCFtio7ufT3jwkODFBEyDZN0/2pI2QXQWsa1nTmzhjGeErpSy30i
T6imGNcUTh1wowtePiB1rNMMDfU/OpfAV6FCxAopCR7Y8YiRvZAz0e0rwYyhfKny6dhnhWMIQ3a4
W2YQBOq/VgBhMd1VqWCwkU067y0=
--000000000000928cea064f217b03--

