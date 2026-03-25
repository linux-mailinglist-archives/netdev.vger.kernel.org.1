Return-Path: <netdev+bounces-271734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJvjGv9ExGm1xwQAu9opvQ
	(envelope-from <netdev+bounces-271734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:26:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164F32BCAC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 493EC3003738
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7026F371CFF;
	Wed, 25 Mar 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PC3b3b3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F671EA7DF
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470325; cv=pass; b=kwWHoIOgyQTi/ASZxBHFx02BDCMb2uRqn79be7/nJwgqxTV0BV05Ca8h+EVkEZqPKbgpbherS9IukkSL0WoCeWMitqT897koiu2IMF7Fd92NLqSeYhKLKDhJ/8qnJ1xQ7cqb0Vxzn+Nd7x3Tc+v5NyZQvBON4EZPfzhuPNBszaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470325; c=relaxed/simple;
	bh=mUI5YsOQJLWdrtVRY6B2zhamtTXpf0WAXVHqpWOjKEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8RbFi2lilDS7956Frvm6cALI6+9r51nyXikQyYryw8ZWuFvDfJKqlF3la/8k2jcikHDc0zmAPHRls2vJJ2BnKCpGW1rumUlhEA77GysemuiiXl9hTTFa+vmwUb5WO8PD1aYyKyCpw0lRnND90tkisJGCvgU0IU/1f10Y6116rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PC3b3b3i; arc=pass smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-829afe24fb5so189383b3a.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470323; x=1775075123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk208XZxfi8ysgtsQOdgMPlBbyHrq3ws0v1TgFKpNr8=;
        b=hrhI3NH8e6zeEES3tQDiED57QV019Xa6EDVUCAAYKjwH/K9zobbVD0Ko1JJRPn1dXQ
         UrLZMUmyUzrrOgEjFBm/JLb8kdl7+t1QL8GmXARYKq/oTXYvUWcEmWRNHYtH6sre4hcg
         PELNrdooMDPrrdjm6BTuyjUb6AfWv+JYoLEu1J5JGrH4VEDhNMfwAGxdJXqyJl/RG3Xq
         I2ssiycT93n4QcWiA5yMrkFRQtruSP/sJLn7Fga1r5wDFGLy/8n+gzUIpzl5RvDjFKlH
         0LLfDvl/0LKpH8ZA3H34P0+KDig1HSbKG9s9PBtjnrzEYG/LVdjdzwLEdCCJctRHUVo6
         hyag==
X-Gm-Message-State: AOJu0YzEWH/7cjv2vBqHubaksV2WVXm1q9TaKiLPDuttfuVoV6iaaSH0
	JUpWgVJQ20HMDOkNNsLSQfaMjb0I6+WA1aHOMcJq8q4/Smsjfjh/PLGXAePEZTP3b42oZK8IZrO
	gVgGAO1IYGWRWp2R2SfO9XnU5QTQyozcbAjS8tWf2H+JGpey4RcOFMI4x+D6+HKF72kp9M4fZFW
	xwMi9gkisr2iEw0GGoDCsaEgJaNyPt2jGJS0d1W8yzV4DNvNCGaY2lhmraYhnbZ5PtiXSR6v0LG
	y+nInCAcJrmTC1sMQ==
X-Gm-Gg: ATEYQzzVPPW3pIpjQB7jDCnsUx07R9EQrHT9IYTismZ8CWTjZHtoaI+1q1R3J33QE/6
	DmUFCqHjzdVjgwm6fooRgjz7QpnBQgc+cpV7uXiVEgFmtLbANK92Qvg2tz09nv816XULYmRkXXr
	on79pASxtwuPzvy/VVB9mWId0ERHA1abG/e7ubkCwaxjjbyJiAOhR0w+KmOCRYIQCZHSTSbQf7Y
	FU0KPxZF1xzUWq9FKnHc0StgYuCgewysu9s11V36s/7CbzV2K2chJwPIwCIfBzesTvi6sXy45RT
	pyW+WXmIal4odFzQGJytHzWnKwxWut1IURhfywmPukq91bnn/UfadeLHpOYrjdW+lUTf1l1C4kF
	0reZfmIAxYxBnP1wYd2NCpApXSRkHhsu31ckxTIZjbAkf/pHEkzPph2Vx1E17zZe3Q0fcauRH91
	v0ywNJ9IxHGp0rvqEvE9qZyy4NmD9Hi7VnuZlzQ3D9VKc44hYKNqeJiH3jU5eK+O0=
X-Received: by 2002:a05:6a00:180d:b0:82a:6de8:fa4f with SMTP id d2e1a72fcca58-82c6deea9cbmr4583323b3a.27.1774470323247;
        Wed, 25 Mar 2026 13:25:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82c7d30492esm84002b3a.4.2026.03.25.13.25.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2026 13:25:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b912aea0fso115440f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774470321; cv=none;
        d=google.com; s=arc-20240605;
        b=brIEJTIzogT8zbob3yxjmEc8VnzbNmLaimy/o/erEzNDGVp9CHCchy8xnvyOlHEW+A
         je3wPrWdqZa+/R7Sa5bUAISqSukXBNlGluW3LMx8EH6bBu+rapDxX/lyA/PrMzNV013j
         J591v10Izy8eDr2twqRhK2HYbaQsS5UZIN6F7NqCbAiPcslyGSWs+hrRwU5ZbL3WrGCj
         TsY9F6Rrul1nDwPCC3PUkhPF864NUPI9z93Bs5RX7zTpo97EwMkJdwCrllXfNWuV64T1
         6Rn/vKArJZkVwEG+aokt8IvOMVspJ132k7uVcl4lNMBcnYDgG2O/P2Y/EIwjuhv7hMdM
         gHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fk208XZxfi8ysgtsQOdgMPlBbyHrq3ws0v1TgFKpNr8=;
        fh=OPy/GQo7kJyTmWip5hbAXQfsyW/IFgksf07tbis91fY=;
        b=ThURUAqEJ5msPqflpHC2GYDCy8tOTNgba191PHO85WD2suYYOyf6weAVP4QbOWcxT6
         6eOk0qNxg3BhrUBicmc5IJNK5Jqe3px8VmRWjKZze3tnfZGWPvYy6yAyWnLKG9HWiVvi
         y4vLAGGU5r/+6yS702QwIkPmy02gtr5f55apYbw6G9s8WrNEzBzy3gD6oBG+neStZkUJ
         vYFfmYBbb+Ce717+6ND+4mQkglihqSTSCM31TB6rKEOW6omZgIuan0T+z3yD6R/UHmFu
         gtE/lziqcLUV3LQRPyc72mqXQtYj6WJBMy2IEdJb8teHTG2W1/jsap1P4kuCk9nlaMwC
         UFAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774470321; x=1775075121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk208XZxfi8ysgtsQOdgMPlBbyHrq3ws0v1TgFKpNr8=;
        b=PC3b3b3iHiASlVqnLFmgQShbPLo7rz8IFiqHToZZeE8uvgutEyQY7RLfJAJ9XzFzo8
         DmQ0GqORASad6VYtdQsMH4newMXOzdclOjzLeTjA5DPt6iqxs8wC8yMHIlH5Jix27JeV
         1b1NdqsF5eWBdpysk2tMSN0Og2mmc+76sQeHQ=
X-Received: by 2002:a05:6000:41cf:b0:43b:8c38:af5 with SMTP id ffacd0b85a97d-43b8c380c31mr5878386f8f.7.1774470320944;
        Wed, 25 Mar 2026 13:25:20 -0700 (PDT)
X-Received: by 2002:a05:6000:41cf:b0:43b:8c38:af5 with SMTP id
 ffacd0b85a97d-43b8c380c31mr5878304f8f.7.1774470320307; Wed, 25 Mar 2026
 13:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
 <20260320211921.1202058-2-jitendra.vegiraju@broadcom.com> <20260323145526.GA94382@horms.kernel.org>
In-Reply-To: <20260323145526.GA94382@horms.kernel.org>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Wed, 25 Mar 2026 13:25:07 -0700
X-Gm-Features: AQROBzA16J4anSqm7wOXJytEvkhPZKS03MWGUPseXmEIzG_Tefn_QYdtHUTKtnA
Message-ID: <CAMdnO-L4A_QXc-uVn=HHYKmFunYbjXHELAm7MrOnk9WVnD+PyA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/6] Add 25GMAC core type to dwmac_core_type enum
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, 
	rohan.g.thomas@altera.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, sdf@fomichev.me, me@ziyao.cc, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002c0460064ddf11f6"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271734-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 8164F32BCAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000002c0460064ddf11f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:55=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Mar 20, 2026 at 02:19:16PM -0700, Jitendra Vegiraju wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > The DW25GMAC is a newer ethernet MAC IP block from Synopsys that introd=
uced
> > new DMA architecure called Hyper-DMA. Define a new dwmac_core_type
> > enum in include/linux/stmmac.h file.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > ---
> >  include/linux/stmmac.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 72febd246bdb..464f4f2e366a 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -197,6 +197,7 @@ enum dwmac_core_type {
> >       DWMAC_CORE_GMAC,
> >       DWMAC_CORE_GMAC4,
> >       DWMAC_CORE_XGMAC,
> > +     DWMAC_CORE_25GMAC,
> >  };
>
> Hi Jitendra,
>
> W=3D1 builds warn that this new enum value is not handled in
> the switch statement in stmmac_print_actphyif()
>
> This seems to be addressed in patch 2/6.
> And I would suggest squashing this patch into that one.
>
Hi Simon,
Thanks for the suggestion, I will squash patches 1/6 and 2/6.
> --
> pw-bot: changes-requested

--0000000000002c0460064ddf11f6
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
gccwLwYJKoZIhvcNAQkEMSIEIAC1zZTA2MQILmJE7ZMLPpAj62upRDIIMfPXV+HgVEQPMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMyNTIwMjUyMVowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGYv6zOtgOhq
PciT2md6+E9DTJsojJlKpcLWGtj5fHfY2U8ZErxqP1rTTgVuARORnc0NDlZUVeSE4MBvDOr8OL4t
CCVvutwQ12Z/z0rfLIGnqSAec6Z9G5fnCskG+LXgTfHE6IGMpaKoGDkZzKeP4xCoujhtoC2ybBxc
9OESHUugIgfLOnSZi9QuUMitN6wi0R/IHJ09jyGE9kugXXfLleFcDUld7E+w1/v1giWxh3eL6ZIH
nGTPxoA0392qxMUY/G5BUpwKICPo84lZLuWTAOiZX/Y/RYQM5Ht++QhLzFj/axDUicKCeL+DI/TH
M6wqP5klWm57j/zDpQDnPrMdMlc=
--0000000000002c0460064ddf11f6--

