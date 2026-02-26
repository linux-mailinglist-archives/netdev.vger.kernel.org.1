Return-Path: <netdev+bounces-261383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DY7FD9aoGlPigQAu9opvQ
	(envelope-from <netdev+bounces-261383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:35:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E91A7A90
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF694311BE7F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8F13B8BB0;
	Thu, 26 Feb 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mr01GooK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069439A7EE
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115874; cv=pass; b=KWOPqmet7m7aGtUPMQnpOZhVakEInchYwt+2cxmOGouHdL92zFVo55kufoOXooxOpvfnqdzzKO/b07y0zjVre5OFQeet0olsVXZNZCbJD+YSP2l/9ipbET+VvG3ZNktA/SmkAGMC7f+fEHPTGGjmyoh6h7vL1vfcb9A169Qsz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115874; c=relaxed/simple;
	bh=yVkT4+AyVCAIAVRxAj/148LxnW2wFoVl7tbElk8W8rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHigdnBSGtxW9NBlPjtfolnSecPrUB9o9n28CxjCLrzB49wnjw+9h2UzQcgeQQ7Zoqoktf8RzEZefIlqr/TFvngroHCjjSgdSgMPHvZpX7K1XYkDS5Qv28vW0GAEHq3gpfOiUR/MFIAUehIc2fH9LKUox1ZzKROsHp/crh8lUPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mr01GooK; arc=pass smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso398251a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 06:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115872; x=1772720672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc8Xg3wyUL/NCuRWWMQJFv2qNgAEeirzz5wDqCBCnj0=;
        b=NGzYZqtFzb2C9t+FPvU1aYtIBX9A+ioalNFkvLaCHjhUHZJakglKVApej4BZhI3AJz
         KZi0A3T/T09yJudVgvS977otjN3WDPEGWw2QH1fy9kwEissm1dQ3xRKHljW8+8WtNdGY
         ukM8UNXhr0FEVTnSl357lC7jwnJHEObXxeG0xfJ+g3HARnqVCjo2LNB4W1u6afDcGVTK
         dL8zN1YoZk80pIT9BAgu21sRF/wNhTm0QsYb2DKZh5BJv3YJ7KQdZsxxojIdDjNoTHeg
         wlWBxhMb4mUbJF0c72vP4l1cmYjJKvtBMseiGz9QyLwxIwiYV8UhXUAc8LvP90LNUm2b
         b2kQ==
X-Forwarded-Encrypted: i=2; AJvYcCXFRiObrhVRxgrXt3zNl5Pdq0AQHdtvWprWZHtNxVlB0wqQFOQlgOCkDEoLr7rHrIgVc9Hyk6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvgWde1v7GYuWK3MtpdGBfoJ9imYgP34DMvu/I1E23NRjdNsG
	A29hWbBgbjiS/zxD/JJMGXfF11/0TfoZdkBl8C9yFE42tooWkT/Djm8UMXAQMAaet7BT0IJObMc
	/mDBEdKly66Dd93o60WQlHWqyAAsivQOdEBtz9WJzP/vuQaTftR7WMDAkLfb1ln/HMpbvX4ED0M
	1MDqwBybd6btcoryPjo5qTfJhz1lSvKb/hzeTVSwPyatbdkLwI1IXaEaEqgsSxf7z8fgmyeG9BN
	xEJQ+tCU3XqSyvzYw==
X-Gm-Gg: ATEYQzwbuaK2xwXi/iV/Q0+dcIL7W9a8aUgCjz8x46qKJv3mhbZHkT0gDmZC2zroy/I
	CrY3YjL7UoPDd01ytFFavp5gpEFPxtCXPFEWT3bUgZ+LoekDX8LtIjUVybVVKuoV7WLlyPhpZmJ
	3QuqWZ5NeTel6uXtNkKrLhwpfbMnSSs6fNvRVybIgF1wqxsLdBghG/3B3PdTArG3bwh4/4BTVn1
	fCUPiJZjZf8Gjc2zcIkqoQ7jhZV7dBnqo/HefqBhGlkhiiGfkhsUzZVutF2+Oe083Us/fHcNMJc
	f9vyxosmo21h/j5hxBq+3xheu8xz8uHACtvH+bMpqIiAVwUoCh5eAUmjjLJTb4n4kTFXLtcrWeq
	JvLJUOVMbEFP8YKRI79DBdB5RchGfq3M8GpdhJ335Iq1QcXkre2H3PkHpb5RLajixfjhn5PBVu+
	bk46lySltSHYD+fgVBV1gg604uibyzKRH8n1seUim8gErLJwfu3sOTneVA3e0gX+dHxQ==
X-Received: by 2002:a17:903:2a8c:b0:2aa:f43d:7c4b with SMTP id d9443c01a7336-2ae02e5e16amr21753785ad.19.1772115872125;
        Thu, 26 Feb 2026 06:24:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5dbaf3sm2670785ad.27.2026.02.26.06.24.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:24:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12721cd1a2aso21070490c88.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 06:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772115870; cv=none;
        d=google.com; s=arc-20240605;
        b=HagfvXVAbYSjeQdHeJXpHQWCsqGbjkLRJhWdJ3O2OT4GeJuoDdUWykhqV7ZF1nJyCo
         tYqjwuBQB3GF3HtwL8zV0IGQ0oJfMv0yCuE5qE4TORbgajkLoE9cLgZER0R9Iyf2KY4h
         fewaU18zje0a+bdobvQf3rK8odUyLxUj9bOnYHKtG9UN+5Pk28epwlUWP7wnOkLU8ZNh
         s5VldaOdjpkQ4+DLLf03bCRtX8zkprYWanGbi0gdM3X7Hxd0hTKf0+SohV1lWeHSGNOA
         AJjqDC5/UN3C30Y7SUayT2P/L156Fi1ghDt97RQMmM4dL3JMbFb2LpphJBjWbyGGMNb9
         H/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kc8Xg3wyUL/NCuRWWMQJFv2qNgAEeirzz5wDqCBCnj0=;
        fh=T0YyQoKBh+/t7ck4vIvGW+fC9huMhQ04DWHykAYJZFY=;
        b=KLWLaaw3WO0Ap96QCD/Xy6+C5kw6bqdc0ZK6sdKWXnVAQb6ltUOGlUaJKc7TrXxreY
         ETB0S0MxUOvbAL4X/5l2HIl0jMqATZ8QfGTLjrRq+bwXqPgZDd/qWddNiKgjp7qd1G80
         RLW4K3atiYZGVmHYUj5lim/nalCjaHvdGcAC9Ak3F3TtmGMw0p9DMlXSPoxlMMgn0Kah
         kBFE0HGMYEKuY/IYwyW+TJ0i8UzGA8gsICuTmSCU+jgkHGmPp9xfO2Hf6nLV3P96hb34
         /3f5AAawccEOaj/phLNMKVkCeetUNgjbnc1qAA80gAIORPAN33XdZGqtDrtUrD4fNPk9
         J1iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772115870; x=1772720670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kc8Xg3wyUL/NCuRWWMQJFv2qNgAEeirzz5wDqCBCnj0=;
        b=Mr01GooK6R8htmXP/EwOyIT11umLOiwqSWpUy/JQAFeVpMieSmg1M2Fz4KHtLw17lS
         C/ROZNCy1D3/ZVFLJkdDzz0ORzWyDuKLnN0FD2jz4/gzCjAhD59qlT0CyxDeKZPElk9m
         Q9sTYzOrGp6hNQguerBpTZO7MvQRl7Qx9RDIg=
X-Forwarded-Encrypted: i=1; AJvYcCVHf6mx2Pm/xXDxZjADf917LiTESFDDw7MFh9EWuRHxO/YEmW07zhL43VwDxctcFzlDnoyw7UE=@vger.kernel.org
X-Received: by 2002:a05:7300:80cb:b0:2bd:c883:5f8c with SMTP id 5a478bee46e88-2bdd305a53fmr1127818eec.36.1772115869583;
        Thu, 26 Feb 2026 06:24:29 -0800 (PST)
X-Received: by 2002:a05:7300:80cb:b0:2bd:c883:5f8c with SMTP id
 5a478bee46e88-2bdd305a53fmr1127798eec.36.1772115869004; Thu, 26 Feb 2026
 06:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-3-bhargava.marreddy@broadcom.com> <20260224183528.757e1174@kernel.org>
In-Reply-To: <20260224183528.757e1174@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 26 Feb 2026 19:54:15 +0530
X-Gm-Features: AaiRm53Hr-Dtx3wIVlyIWxjzjGii4324zFHcs0pzeKO5eU_PgmwPVgoXdcLPXNs
Message-ID: <CANXQDtb0gMxywZ5G+csVtJy2DVvB0t0PLQzPmiQPoXfzZ+KPQw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] bng_en: query PHY capabilities and report
 link status
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, 
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ef9161064bbae0bd"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261383-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC6E91A7A90
X-Rspamd-Action: no action

--000000000000ef9161064bbae0bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 23 Feb 2026 22:06:36 +0530 Bhargava Marreddy wrote:
> > +     /* To protect link related settings during link changes and
> > +      * ethtool settings changes.
> > +      */
> > +     struct mutex            link_lock;
> > +     struct bnge_link_info   link_info;
>
> Why does link deserve its own lock? Are the operations slow?
>
> bnxt was written before the netdev instance lock existed, if you're
> just trying to avoid taking rtnl_lock the instance lock would do.

Hi Jakub, thanks for the feedback.

Agreed. I will replace link_lock with the netdev instance lock in the
next spin.

These link operations are relatively slow as they involve firmware HWRM
mailbox round-trips (PHY query/config). Since the firmware latency is
the main factor in hold time, the instance lock is sufficient and
avoids extra complexity.

Thanks,
Bhargava Marreddy

--000000000000ef9161064bbae0bd
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCxz6MU4F9d3i0j0GT1doHN0i+o0E2j1w7ZufuEf+2nbTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjYxNDI0MzBaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAIywLt
SHW0lNXta0WYeerlhje2+Vx0/oO93xopvdTN57GQ3TeRoDeTqXmclCfRWSNk64BSh72lEs7GrA4L
3HyjQFggpYZ+4We8+KnuiRolZZLwK6RlR/rKNWDImPueMheeB8x0ElCtiWEf8qzPqYRoD/sse5P1
nmemID9TUN2dToPt48SGrYrcgOokV/SM2twWNvdhtegUlIUGxcu9Y+GLtbhNuGqSUeGJR8Nqt6+E
Z3I2O4dVTigNyIDt5NFNIKKeOtBmWjZxAo4CuVjZIu6ITLdm83NM/wI/66PZ91brSFlNF3IhfkqI
zM+EoegMsigZyigwANONy23/UCmy2xQ9
--000000000000ef9161064bbae0bd--

