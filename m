Return-Path: <netdev+bounces-253966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE1+FvX8eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:59:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E0098B37
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D561D300D6B7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB7319601;
	Tue, 27 Jan 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q+a956HV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FE31E0F0
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536745; cv=pass; b=aKzGTeSa/eptKOJjD+Sar6bjtFfUX2u4EiesSMxl4fGQj+mR+DJ7lcbAMvhmnQlaFnXZaWSkThp9iyseNHKIneIS1ujH/RvIjLH5Gu5luy41Rt35cbRb8wBpyQfQlcGYA5AyikC5Jf3eIGhtz5vvnth/LRx3Qa6JlSKSOCYz+Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536745; c=relaxed/simple;
	bh=jKnVQq115QMVYio1YJHItVJdwEil7txhNLSOpUGw0RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzdirVJ6EJmGKrotnrhF6y/O6LGt3KQLwW9xW1FarT0BKBgZAdJBMhJATN9+Z8xIkgdl2eT3IXrKr96ookRp2CR7QEF1vopkRH97ZqmnfzbHuNWltMkmdZeKh5ramkoAq31kU3I2KlWZ8WlnECmsrVLKty+aR020pENDHcEuHtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q+a956HV; arc=pass smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-5014db8e268so95457611cf.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536743; x=1770141543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cif/3V7hoX63fpk2kh+7GO1ld1DSDnNFPzWl54O5QgA=;
        b=W5dk2DntpAxeH7OGjsFksdW4lPeDuxwFQOoFl9fhEbOrnuh5bgDNJbJL9bOL/3HNOn
         I/lytW7c1KLNBNMxeAolEt/Rc6YyZ1KCcKKoREJLm42hZo4/GyuFnJwgxeKq2my5gjjk
         rylCQXZ3J2v4F6nU9+OaySLGxyBrvueZZm8qgBwQJpQvvSx5lF97vcCP4N7xl6IMWWuO
         rFb96SL79zmLYpSSowI6WcAcRgqL97TFAoQHcvCSVFEHqOqkBDssp8HqN1NKwS3DAoz0
         k3izWCIIxiwbQThDk7OllD0OHRyfPUPrGUIPhlvokDPdfRD4l6WAgc9EgYdJYWo7RU2E
         ueeQ==
X-Forwarded-Encrypted: i=2; AJvYcCW8C6a/X6b2vp60FJGTzsmHh4TpcTdcntxw9R+TOJPDfrmT7zjMOWEE+c5IhqvRx9givPz7OOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KQR3O3djnMMF8+GpQTj0r2bfO/ujoPlL1O9N9OhSlcX82dgv
	YLM6XeDe37AE4OvAOLUMwXbPdlui+diyIER+yZED7jXxCKrhHiWxwqopI1h82HkccBor49Pxim9
	EGYnKMltWsjoFOqvH1Vcqj8qLEInP59IIM149+KApzX6S8AMyEj5MGiWtGRhlzhMiZtDtWvuJTe
	ZQ/8Yi6JZ1OYj7lI1wMSNASh5SQlemN4xC7j43r69ztzYW9dDL2SH63C/KBtXZMn6TD4T26D8yQ
	QAltgmIUhySk8bC6Q==
X-Gm-Gg: AZuq6aL1HeBiQ0/wWa2djiKI5tw5tfEERIiBsYS0roBL/OgLXCUyeq0SsBgeo91rfe9
	9B7PB3zTr8edBFna7dL5rBLbE4PnRM43PhEZrIwLEHfCZrIbfPM9zml75SXHbx2P3AdnQSgzMs0
	26RXDIbjOfRYgLvmHhph30BtQAISo5IGe6oOESkWYfaicyDjQjQ1TCC9i/N5ft7a5b/+RKpTHRc
	ccC/j9MnqI+ApCgBu7oONDOK6xm1p4YUcEL060XMMqF188vpJJdev5cYhpa3hOT8/a0At2FCz3h
	i4gzzr7y50hVRy5viQmmyq4itdHSemaXpgjyj6vFnTU0mQG2m8X44bFCHcO090lVwl+MJlFjbuO
	by42DriOKEbTjduUyHEf1HCHooERbae1tVweeKv5giXzwvRuqPlEbkz7D5TDQxugj66IiflJkkA
	k0LeIV+GWWUCENHVACDet/+M5fanxMb0mu2+sBRr+Ip5ZLgT/u
X-Received: by 2002:a05:622a:1195:b0:4ee:1f24:8c43 with SMTP id d75a77b69052e-5032f7809dcmr32355261cf.31.1769536743036;
        Tue, 27 Jan 2026 09:59:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d372eb70sm241856d6.17.2026.01.27.09.59.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 09:59:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b704019c98so6182876eec.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769536741; cv=none;
        d=google.com; s=arc-20240605;
        b=TwKkKEPG9TxIcagddUhk+5P/9zU+gKQOmqLMfADiSZcVEkJZr0JmEw9qzbX2pBr4b+
         N1GBU+MsmIYBekNyquQX/skugjbT6+fxWRfq0NR5N8WVuNKrRQWyCkxN+xsEvveVmOzD
         k5YDjRHZHwDS1Nj3ta1BCQHX61UOWna6C6NbvNix7OdevEcH5xKJyUOwgtoL9Pff/KD0
         z4tSlCW0XslF8ii6t4mjkfcDKGFUAMRbXUsRAxXPGbm13D17hDDRGPn05ZTBtZIlUsDn
         /e0CbnB4ful/n88Wb58ll/Co8iW664PvQ+nwfLRKySb0Ijzk9wZYcuc+JN0NTMq5PNGs
         pctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cif/3V7hoX63fpk2kh+7GO1ld1DSDnNFPzWl54O5QgA=;
        fh=lFXtxlh9PPC/uhrgc0aDs0wg5e8Ag7XeGAoX7BsdRD0=;
        b=MBKdVp8f0gIOVSRvPlZ9bDoHKQ6rz5qoiJ2Mmm4MQz1fcnQgeenaeQmIwcTLTmjX9f
         pg95d8vB5G+CuObnLf1vycVjiPqujG0V5fG2A0+korHVDojEEtRcP7M4UgqsY9Vgz3y2
         JT8mn3BHCmihj1O2RcobqCXoAgbSUFYHIonECgUV2s6JRQ+2duE6s9NBW/cLMGffJdMb
         4WQkBC/O7l3wk1M8FwVEHwGP5NGU8QjCC9XiYqlBxfaHXoNA+/+AaF+UZYPqhNgiQy0i
         2491bsxxCcmuDVe/YJgyvvz65LCi5kqA1lCFYhcL/7rooF8w3CjMsgcJAnIhMZTQ5dRq
         3NGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769536741; x=1770141541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cif/3V7hoX63fpk2kh+7GO1ld1DSDnNFPzWl54O5QgA=;
        b=Q+a956HVt8Bg0nTXbFY5/w8cg2r6B59id2miir+GWw0DUi5ne9XegGd2pBH+GlHJHe
         jRczivHooSCycYrXkwzX+iRicNfgqoxQZ+srmBL0OYcFPaV97CIL1suauAAVBnW8Prs9
         VdjG2v/tGBxAgtVzsktPqdQJlEP10wlAbkI04=
X-Forwarded-Encrypted: i=1; AJvYcCUJx6MdI2XXoqhDyZJe+XijfLDwgNKi1K6Lv9iO5+s5tWxwjntHlgQbIRN4keibbS/txPFD4Gc=@vger.kernel.org
X-Received: by 2002:a05:7300:ad09:b0:2ae:5dc2:3b11 with SMTP id 5a478bee46e88-2b78d8ccedbmr1503552eec.2.1769536741393;
        Tue, 27 Jan 2026 09:59:01 -0800 (PST)
X-Received: by 2002:a05:7300:ad09:b0:2ae:5dc2:3b11 with SMTP id
 5a478bee46e88-2b78d8ccedbmr1503529eec.2.1769536740870; Tue, 27 Jan 2026
 09:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123193504.285573-9-bhargava.marreddy@broadcom.com> <20260127032255.3847218-2-kuba@kernel.org>
In-Reply-To: <20260127032255.3847218-2-kuba@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Tue, 27 Jan 2026 23:28:46 +0530
X-Gm-Features: AZwV_QgehhPUXQKoKxgkqYtHyiOjXW7--SsXEHi8-JQdhsnq4Xc3rjnyABAB7Y8
Message-ID: <CANXQDtZr8-_hVARZyt9xZR-ej8fTZNc-pvg4r3fAPB1ActM2fw@mail.gmail.com>
Subject: Re: [v6,net-next,8/8] bng_en: Add support for TPA events
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, pavan.chebbi@broadcom.com, rahul-rg.gupta@broadcom.com, 
	edumazet@google.com, ajit.khaparde@broadcom.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, vsrama-krishna.nemani@broadcom.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, davem@davemloft.net, 
	michael.chan@broadcom.com, rajashekar.hudumula@broadcom.com, 
	vikas.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e97bda0649626071"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253966-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: C4E0098B37
X-Rspamd-Action: no action

--000000000000e97bda0649626071
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bng_en: Add support for TPA events
>
> This commit enables TPA (Transport Protocol Aggregation) functionality
> in the VNIC and adds functions to handle TPA events for LRO/GRO
> processing.
>
> > +static void bnge_tpa_agg(struct bnge_net *bn, struct bnge_rx_ring_info=
 *rxr,
> > +                      struct rx_agg_cmp *rx_agg)
> > +{
> > +     u16 agg_id =3D TPA_AGG_AGG_ID(rx_agg);
> > +     struct bnge_tpa_info *tpa_info;
> > +
> > +     agg_id =3D bnge_lookup_agg_idx(rxr, agg_id);
> > +     tpa_info =3D &rxr->rx_tpa[agg_id];
> > +
> > +     tpa_info->agg_arr[tpa_info->agg_count++] =3D *rx_agg;
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The agg_arr is allocated with MAX_SKB_FRAGS entries, but there is no
> bounds check before writing to it. The bnxt driver has a BUG_ON guard
> at this location:
>
>     BUG_ON(tpa_info->agg_count >=3D MAX_SKB_FRAGS);
>
> Is there a reason this check was omitted? While the check in
> bnge_tpa_end() catches agg_bufs > MAX_SKB_FRAGS, that happens after
> the aggregation completions have already been stored. If hardware
> misbehaves and sends more aggregation completions than expected, could
> this overflow agg_arr[]?

We didn't include the BUG_ON as per this discussion,
https://lore.kernel.org/netdev/20251225125229.GL11869@unreal/

We plan to address this HW misbehavior using a recovery mechanism in a
follow-up patch series.
Please let me know if you agree with this plan.

Thanks,
Bhargava Marreddy

>
> > +}
> --
> pw-bot: cr

--000000000000e97bda0649626071
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCALQ8BWhNAYCNfIkDkny5uo05vojOIoaNlmbrBhO1HQYTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjcxNzU5MDFaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBmHgVZ
VJ4HjZHqlJO/IzNUnje8ZPJjeGDGHZDzLR+XVSZdZphZ4NQOrL1Lwn57kIUYgUGzDViuHcOkOLTP
Ymg4hkDANb9lZxgFBwjOxw6EvSaSGGiAtLA9o0RAcE+CQF7zGSppdP8wi8yBTljsB1MGnWtF6jhy
sHa9q8rTdHCC2YPhr64TQ5c5SkXEub19NwukCw7PtN1ej2RGrzl4zdr/cHB09UvVHyz/XoRVMtwP
rQizhuD0I04s7wWOnbdIfjKaUwmTCZA38Ogbmd77bDe26rUEtOB3NxvSA3lt43WKliZ4gzLxN5v8
JHgC5KZeSkHeQvl0UaaqION6rQzjoSOB
--000000000000e97bda0649626071--

