Return-Path: <netdev+bounces-277152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I5RM38j2Gm9YggAu9opvQ
	(envelope-from <netdev+bounces-277152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:09:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5D33D01E2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7DBD301490B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A43387594;
	Thu,  9 Apr 2026 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hhan/GPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC02387371
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772533; cv=pass; b=g/y1e/0iVfeXQwCGx3bQ6Z7KMrQKvvVAFgg6ZCzzjvwW2fruWw2TOXRzorL6aKz1IsjOvoT2ws5GRABvI/G8+9qfktq6QGMky0V1fiyKQrxSaKUoa7QhQrtwuYfgl3eoh+VSChHX0Ob7celFAacKQfa8li41tMWsOklRGVBGkrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772533; c=relaxed/simple;
	bh=feUmTjwQ/HO68r0baYJsuQ1ftG7WA2uuZ2lIRwp68zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9MnyGRqzG+tWozCkW15sP5jhB1NykNuBv/PuMP7nYXm/+rtVrmM1zkZX9h5zoEjufKHd9cTxu3Ax2yKVUSV+l9rIwCmJBc7npP35EZyYnxei7c4WBH6NTSvN6sQREzj+IwqB/YF2enfbcOPpcuWNolo0ob5tNXkCC+Lmzbl4Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hhan/GPO; arc=pass smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8cb5c9ba82bso188237985a.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 15:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772531; x=1776377331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feUmTjwQ/HO68r0baYJsuQ1ftG7WA2uuZ2lIRwp68zc=;
        b=s2IRks7JYqnvfimUaj5R5lYk1ug3VbpWhTwYetSSpTiGK7Ki3f8F2XsERsHef0t4zl
         qypFi98+kh449hmGYWoI/OpLN9kPspV1FIcI7GFrRMBskq3Ri+TzKOfq02yZMzQptIJD
         gVRS6zu2nsClKTBzxkCB6VH5Aeo0q2ElN5XVoRlY7ggg4RENvqKEEUdnp6UZYRVSbBGN
         MVV1VuEj7aaFsuVBJgEwaN52bCVUERviQIHtV/AqnWH3WnDK9f5me23um4FsMkaRe6Qk
         hs0iO5+JyJ6tpBu6AZFSrMMv2FHLHxLKZlA8kgdfSHmOcaPa0EhRtoHishwJaqtTYle0
         tTgQ==
X-Gm-Message-State: AOJu0Yw+K5QugBiuDZAbBRiryRO9htjEptTTryi2ViXs99+1AHOOwQrR
	sGNIU3Q5YZ38DzzWKiB8rbuHFrYzdOI7kf7usSg2O0d/NlaRb8fcXHxiknCQt9HCgTzyK09SbDZ
	YbChIvu9JdQnKYdnTTykcUcVthdmUCEotHaNsXJL31fRBzonJDntU7DykaBGU14nxXRtWDv75ja
	yUqnyS551ifYbZxv/JBryl+35T/sL1EwjHcab+5ig8Fd8Mj2e3242n9cOvpTtcTclZ28r0ElYGs
	duua062OWJ5fKSzVw==
X-Gm-Gg: AeBDiesZeAjJWpDk0tquzyRwn8HLYf4SqGVM7cbR8my1M6ALYQVf0657ofE9sym5omN
	RtbbMplUk45NrZCZHPYR12ut86OxL6Eh63qvLhtxEttv1+v8U0Uu+97tb7QvCowArCwJhh/2wvA
	kccJEIjW+9hBVXy14UWC0C68cJTbXvqcrF+pN6vHj23kdoSkUB+uXuw7UsFsB6s+WpbvBwd32Dr
	AwsSEwUbYgEmrBp3nv3s/AQwB1nIDvn8c0D8NnDTBHZRkjNSL2RxxVswPwtHEAzgso7VgMrgPBF
	LtP8NzxklsRp1M7w5Ew0bDKvQle3JrfBziOcD5gmjoJ3Jqv8q/JZuOUky+qMV8wufX3kAOF2NPA
	90nDCLpZMiz9n7RJo9dVgPrLPa/uRD7uYdcMj9J+MWqvRt62e1ZrWrWxgAFenUfD9qVRIzeHqOt
	HfjEMRdx2C21XBftSv+argGh/QQoO3XbX8P7+MtiS9+y9V9Zb+bKlkhZJDu845+e8=
X-Received: by 2002:a05:620a:2981:b0:8cf:ebd2:f8e1 with SMTP id af79cd13be357-8ddcf6b5bdamr102554785a.53.1775772531087;
        Thu, 09 Apr 2026 15:08:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8ddb8a7f997sm3394585a.5.2026.04.09.15.08.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 15:08:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cf6758644so702734f8f.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 15:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775772529; cv=none;
        d=google.com; s=arc-20240605;
        b=L4C5wuOUJNH+CAmvXnV4ONqvu9yCT16e+T7XGQfuL9SNY8tX/U4ZjA0Xhq6/UXcgGR
         4jSmP/nmhGLQGKC55OTyigiygAWzFFYPzR9CPtVxBEF1aRoI7Qkt0VeAbDAt/UgfUq3/
         AGtxhQxQ7pmBbTyMEIl0pGe23iFenZ/JTBE0fB3ot2nM8YRxqtK9LtWrsKyIiBDWUZwq
         3aYNWS+nZ0he7KfJl0uT60IvXfAlXjgwRW+BHVPpQPt7zFW+pgo/1RCpLX27gptBeUrX
         6p9afpxwj5JOury3BHJygWb+xal1oKZV+vhgCpIUffcKVfDGFH1irafcdiIoEuPirG47
         zmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=feUmTjwQ/HO68r0baYJsuQ1ftG7WA2uuZ2lIRwp68zc=;
        fh=H7QQv3OEFsD1HVpz+3uR6feknpwvlP3vBj6ioUlRm1Q=;
        b=FfJslTL16tT5Y0cJaw8GWpAPhXm/PkhWwJO+jNxV5R7liIq4OqTgKxZwT8iktINWTD
         32li7IIeaa/i5PW1ACVd3sSVwppMpJkRFiuz0isC2vCqMK6jwiLde62ldI/3YEh5xEgV
         UjqudWMGc9o/jDtitWo31pYSVWd3TGv2D7svx6S7qqaBHq12yKjiGmJqKLr+thzRapvb
         boRmJxAHv5c1t7Cpf+nlFRYAhtdHwKTjAQ7i97ATuoe+sfW1ndde0whXpQkyo1RvAMht
         86b35SsRTELCb5lxm7JVdDtt/qrJ6ySLGH6VOs5Arh7BWDrJsHgsA8RG2RSzfPrWJdOk
         SsOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775772529; x=1776377329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=feUmTjwQ/HO68r0baYJsuQ1ftG7WA2uuZ2lIRwp68zc=;
        b=hhan/GPOBNau+Pmp09TpHYbmg9N5JaFHhAFv7o1OO4G+A9YPrZ+P7y2ZBzK+XFw1f3
         zBULmpr9E14G+9zS1jJuzZEQwc2/H3SHT6daZFE4BoBtpWtEKCur1CUFql3cNIx8rv4s
         lX/P02E2k4K4AfKOaDcXi/U6rsPDag9t9PyMg=
X-Received: by 2002:a5d:5f87:0:b0:43b:4703:9de5 with SMTP id ffacd0b85a97d-43d642dccc3mr1022177f8f.44.1775772529246;
        Thu, 09 Apr 2026 15:08:49 -0700 (PDT)
X-Received: by 2002:a5d:5f87:0:b0:43b:4703:9de5 with SMTP id
 ffacd0b85a97d-43d642dccc3mr1022125f8f.44.1775772528655; Thu, 09 Apr 2026
 15:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com> <adSxQpAE0nY0ulfU@shell.armlinux.org.uk>
In-Reply-To: <adSxQpAE0nY0ulfU@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 9 Apr 2026 15:08:35 -0700
X-Gm-Features: AQROBzArt3I8bemRMGDxmah0OqjGLcvGglqY0L8HZtuxxXqb_QYUkXgoucoT5Fg
Message-ID: <CAMdnO-J0Ss=+sp+aJA2TOiNPvzAv37MN05gwVZTGJmh3L4n7sQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/4] net: stmmac: Add PCI driver support for BCM8958x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rohan.g.thomas@altera.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d7780b064f0e42c0"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277152-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: BF5D33D01E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000d7780b064f0e42c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Tue, Apr 7, 2026 at 12:25=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 02, 2026 at 02:36:25PM -0700, Jitendra Vegiraju wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > This patchset adds basic PCI ethernet device driver support for Broadco=
m
> > BCM8958x Automotive Ethernet switch SoC devices.
> >
> > The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> > MAC IP introduces new DMA architecture called Hyper-DMA for virtualizat=
ion
> > scalability.
> >
> > Driver functionality specific to new MAC (DW25GMAC) is implemented in
> > new file dw25gmac.c.
>
> Sorry for suggesting this rather late, but I recently came across
> another stmmac driver in the kernel - drivers/net/ethernet/synopsys.
> This is for XLGMAC, but I wonder whether it may be a better bet for
> this core. Have you looked at it?
>
I wasn't aware of this driver earlier. We are looking into this driver now.
Thanks
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--000000000000d7780b064f0e42c0
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
gccwLwYJKoZIhvcNAQkEMSIEILuLmSSO4fRKTPTuCUL9ZTZdoL2rS4KMUF6rJInr/XkbMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQwOTIyMDg0OVowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJjVU0MvI29h
uY7bvx9vWk/zixT5OP5qh07gQ9ZF9enzeLyx+PJ+FN8nDKF6+sRt2oK57Z/N+zupzhJ8rkQLg/ga
Vae5b8gm1TEdtKWoKjlVg15ODGKq0Yl9xpoE8z1FXc7jtzlszLRjxfDG9kpPtIV+fESaJ948mWM+
Dj+3E9D7GwmUERU4IRcd16s26H3vlHeIzlccQqYyitsy+gq8lArA1S1Xoub06MRPb1oGEnuzt2iV
DfacCXZyQpO1r7f6dLyk0DQdGseZS1qZBL+mvF8voTPWMvQCJcUgxDeBMBgRaIYCqiKAaf2M7jY7
PdVbSt7f6/FRFOnIQM6hwwFig08=
--000000000000d7780b064f0e42c0--

