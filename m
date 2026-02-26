Return-Path: <netdev+bounces-261376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFy1Im1XoGkNigQAu9opvQ
	(envelope-from <netdev+bounces-261376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:23:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E01A773A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 967F4300AC97
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DDA364056;
	Thu, 26 Feb 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WOnoF9nZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9530FC2E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114762; cv=pass; b=tnUCDwUStlDfC+i3chNib3D/hWtCcYa8g4cjwTBrrv4bktXSbzBgs7Kr4F5y0vFRaCRN98O5fyWR6n7iKxhdurS4cApMHstASMJR88AIpg3sAKGPhIfk7b8yGnsAuUjykJmhEy6FKfEnhFXWV8+09nGsbJWgPpNH9SF5N2OjPAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114762; c=relaxed/simple;
	bh=UfvYR+XjwsW97pzU3APLt2wd6I7dCOPior0yo7ZKgnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzgpeMIHAjxWESKGQlxDffi02Mw1U8CaTpvzfwieF2Ei6rVrKjO9V1RD4bwjLJ3VlqqIqTEwJiHwP+f10qarW5YwY5VXyhwTSQpuRHIxcnM0txX08+T/YWqBi8LO84XuyH7U88eaxbG9pZuyuwLYXjYWB3LSx9AZ4M1yuXY30Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WOnoF9nZ; arc=pass smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7986a347d4bso8946877b3.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 06:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114760; x=1772719560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g88OwiVHI4K6xVPYqOY13ZAGnNP8KsZ0hXY07Phx+FU=;
        b=D4DNkG7AVV+mtBsghyNI5aAX/VsJ7UvvMVeMgyF0eyaapP6bs/YTf9dKQENubcUXEQ
         4exM2AzmN0+aFU06WmLuUxJLY6lyod8htdYtzlcTO1AJBcALq+7XYiHfeY3fG8TdANR1
         Ub3uUrnLDj/7x6vdRpPirITX7ojVzvUyvMM3QM44YvuM/G+ctoz6iZo+hUzu/+VQNUrx
         b/t6ulf4zXtVgk0r4wW2Mdbr8FUhvTcbYdUA0g84UWoN6NJ1GQvxC+xlQe2wB0+/FeaS
         vb3sKAo/mOZTlpgnlL/+pxZu9NdIfGqOCgEWOUii6yXkSaaq8cr31ac74x1NM5XgEXUr
         12TQ==
X-Forwarded-Encrypted: i=2; AJvYcCWS57VFzPFby7vXRfs3tO8lngOEl5BG5SPEsPK4lih52yytb4R2kM8ls1XoQrBC/I1KGw8GBJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zcQ89t7cuNOY7bML0/SS7auHcjhE96EmnlByd6meidvcB15e
	PRumlZihZ6VLsgv7FKmlLKTAvynn9EhXIe2KRH3Qy06QRwzVD2rwLrkh7bPr1r51EIQ5Ucv1/rk
	VFBLepEvX0NEGsENVywR5JP7rdqZGMCQsSc5ugDaDUCQaXf+pF03PFpZgpTufVRxAcG+t2moHiy
	jZs1As6+a4V2Bez7/X0hdC4z5iFeA7zZLxZo4gJYeTd4ZqxhoX9ewr9/xVOa0XVMAMmlEZk/xIC
	YG2V/ChXFDx2itu3A==
X-Gm-Gg: ATEYQzwH+Vvk0W+DIfvoG2tDpeVHI32p5+RabGCTuLs0/tLkRQZiR3lbACR5ilujyH/
	ltHQETL8X7NmEI/Xu0AkHQ2q+2boxxpCRxJ0OrPsp3xwm45eH40eA2yWsHFBVAuL1gZg6jjXgG1
	acqTNh4s+3iwraMZNhcs0UfpFYsAwPKqQUF7vS1EsZKRWjjgMybgj7YKBnP136FKY/79xki58nX
	DfZLRHe7HD6Pb7nrrtRgPW+6vdFBlu4BipvGu42rWrb1jL2J472uGkoCQW4FE8IN5j/oheOpmmR
	PsjRzY6bQFRP8/HudN1E899uArcEU6AyH8DRni7OAUFvgndcV8UvIgWKmksgZb3LoqspMjpcjoQ
	AyMkjDSLlG39y7XMWrr3PvMdfn44HGnOAXi90l1v/uhHce/SmA12xVA0gcGOXiPrTYAVE/vN8GD
	P3sZcKFFW4WjC4n9zXBNItzfQ1zbW3Q/6NQ/63iAJcpOFLN0YOQxWu+dVA0jxPdCAUDg==
X-Received: by 2002:a05:690c:f09:b0:798:6542:3112 with SMTP id 00721157ae682-79876e409d6mr19318507b3.65.1772114760273;
        Thu, 26 Feb 2026 06:06:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876bf33absm2354097b3.18.2026.02.26.06.05.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:06:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdbf9bb128so12684497eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 06:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772114759; cv=none;
        d=google.com; s=arc-20240605;
        b=cjsKSkHZxFEkj/B1LGGId0KQ7aLVkPhCuE9arkHG9THgFfgx5koyoQwzioEb9rHBlr
         /fihIn1q49oliRUN0VDeQgpks1p+Fsh++IG5r++VZNgjHtmmC5rOGB41+Y9+xCxdWwgh
         2xThRCeIz4mI2fvyQ4ujsYxcjql7yxvvm+voPxmPHVoj4xdyektPyqheEepBNGyH1nZl
         1yCwR4BiPPsyUF9jhMew3RHOmKtW9PvLXPujpC53bLBvGwMrfQkno7Ih98w0L7EM3sL+
         LxqsDO9gaHT1SEBjogc0l63ar6xle1pmWEeIrcQH2mNmN1Ah7Jhf6lmxKkPckMs02Pn2
         kyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g88OwiVHI4K6xVPYqOY13ZAGnNP8KsZ0hXY07Phx+FU=;
        fh=6wfr0DouRQId3xP+aWxFf1tvRbG/FrpZuNxDgRNBOtI=;
        b=f9ckPDMGpNVHcdM2Q9gnqfegD36oChIld7BSlEtuWdIY5DVmrxNYb2WmOOObJEG1o1
         3VpGYNKwt+OPkFc3/RSWGKtDeth6qBwtEPNhRoE7OWq96dj6WHCj2fh9ZcZPpuvIE8kV
         nu67HtBdhYM7n2W/Nn2/gi/f9ufY2yUEWOWE3HcCgXNrjYpWxhz+a8Xcl9hfsSMUORvY
         LNdwiglUUfJ3UCnvbwItwJxBd7D4g0u9uQftxWjYKBjTpH14hzoAJNumTE4EquHtfnRu
         aK2Yw+hWM4Q4V9PGlzRlTP+1Cz0y90dY/M1Y6fqS7WURp9pGq2+llAf/JLWbDloOW34t
         aYKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772114759; x=1772719559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g88OwiVHI4K6xVPYqOY13ZAGnNP8KsZ0hXY07Phx+FU=;
        b=WOnoF9nZmw6tVNAo1kHEToTCCrsG5zpomQ3IrHFwB73WXGTfdICyuP9tOeZ522fxh+
         WlwRFIVOBCg5lcEED4ibFhrAMDFB5dP3AZFFn2C1OBB/62o72pCYkEQMHuDLQaJv9xB4
         /WKHxRxITe0jDYfPYNvJz/5VfBW5jb1fMWrZM=
X-Forwarded-Encrypted: i=1; AJvYcCXeYmPk9R0XPOACqgiJwb7Jq0n9xjfZdDEeOPbu9+GxfgllEpG+STs9Xxr6cvWYK6Akf8Wwv4E=@vger.kernel.org
X-Received: by 2002:a05:7301:578d:b0:2bd:d157:6786 with SMTP id 5a478bee46e88-2bdd2feb50fmr974453eec.25.1772114758890;
        Thu, 26 Feb 2026 06:05:58 -0800 (PST)
X-Received: by 2002:a05:7301:578d:b0:2bd:d157:6786 with SMTP id
 5a478bee46e88-2bdd2feb50fmr974419eec.25.1772114758231; Thu, 26 Feb 2026
 06:05:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-2-bhargava.marreddy@broadcom.com> <20260224183253.23143628@kernel.org>
In-Reply-To: <20260224183253.23143628@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 26 Feb 2026 19:35:43 +0530
X-Gm-Features: AaiRm52VERYNb12AKnNPJf2iC7IQ8fiF2o9vtIzVsCa80tfwn-si3LfrtnnkFJY
Message-ID: <CANXQDtYqrZTQen8PMj2AfOZjowpowPwGLsSzwLs5B3bKs+vtXg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] bng_en: add per-PF workqueue, timer, and
 slow-path task
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bcd33a064bba9e8e"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261376-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: 4D6E01A773A
X-Rspamd-Action: no action

--000000000000bcd33a064bba9e8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 23 Feb 2026 22:06:35 +0530 Bhargava Marreddy wrote:
> > +     if (atomic_read(&bn->intr_sem) !=3D 0)
> > +             goto bnge_restart_timer;
> > +
> > +     /* Periodic work added by later patches */
> > +
> > +bnge_restart_timer:
> > +     mod_timer(&bn->timer, jiffies + bn->current_interval);
>
> This intr_sem thing looks highly questionable.
>
> It provides no synchronization guarantee since the state of intr_sem
> may change immediately after the read. Please use normal locking
> primitives and/or cancel the timer _sync() if you want to make sure
> it's not running.

Hi Jakub,

Agreed. The intr_sem will be removed in v2. The timer already checks
BNGE_STATE_OPEN, which is cleared before del_timer_sync() in the
close path. This ensures the timer either exits early upon seeing the
cleared bit or is synchronized by the cancel call.

Thanks,
Bhargava Marreddy

--000000000000bcd33a064bba9e8e
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCwL0TYM0rqI4W2V5CgHkmYZWjNuAW/JnMk29vhNGVTlDAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjYxNDA1NTlaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAl2awI
DSAjKtwIuqwphuKBfSOS4yD4NphV/1Z5Gl+MVJmcFw/Ph1nAXBSx2L0HmBRM84EpP5ewKtZ/laZi
Sr5PfotwW9WknVOG6nQ+IUuDNUjfozblmL2gHLDlWua73eTjKvHrOkKQr/Mdrhp9lKfphpPLyVeQ
Kf00DTpdLpGFpKUFbSbTFJSlg0cd3QWFzcpq2Hn0/Bv5jC/qMtkKrornY9b7AX+nmD7nS2Idcgai
/CBjg0cbfvph+Ua1RSHlKK07ot69IQoiqBXbv8Ybm4m6S0Skr7e40P78KUVxH5X94lHvHtJVnXrX
hkPLJwInJgBzVfP2YL/lXi9Q1S6KaR5U
--000000000000bcd33a064bba9e8e--

