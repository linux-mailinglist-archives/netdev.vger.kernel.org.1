Return-Path: <netdev+bounces-264296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNsMEKdhqWli6gAAu9opvQ
	(envelope-from <netdev+bounces-264296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:57:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD762102C7
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D25A30D6F63
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A123859E8;
	Thu,  5 Mar 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aKKB+wxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035C383C7A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707888; cv=pass; b=Ze+2s8Y+JWe6JZ0ns7tZpcl3QFGhuE0hLA5Kk07qNwn4sHrv7m0aCCBLkkmK1WjuVaRMDsNU6N9eOqYG8eF2p1DzunDbA9uHifD4VaSlARsbUGWYbRWpJ8h5fIt796BTZrADbBnc3R/s5J2B9CLboMGKXWF/cXEWycYUz9s79is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707888; c=relaxed/simple;
	bh=KOjKwLOwleVP5tMdf27Q9IUu03448Pg27iSMuH5/9Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANJAvjXN5O5qbnDf4l/AYPxQYKzD52I83z+Guw2lY7cXDSjXporkwabAo2g1x/yANc4xVod/ACaEq84uSPweynsE7NCNixtQ7sUDiHI+R1kjWCllHes9Pw2VW2TVN4m5dgK1LsUiLjmD1ACVjhYMW0XMLWf9P/fP01LxfJQ2XxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aKKB+wxV; arc=pass smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-79868eae536so80767257b3.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772707886; x=1773312686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOjKwLOwleVP5tMdf27Q9IUu03448Pg27iSMuH5/9Jg=;
        b=O1qpEN9j6sr7FjdpURNz+eKLb4/VS7uiNK9s7ut+GajPFoNELfc9W3nrcwXd46PT0h
         Ym6p+u1kIbUlWbBPAjgM3j7s1Pv2kriZQtqKY5VEWTVwuiNnhs5c5rEdQQ/Sh1doDTA2
         mVapQjSMF4Gc3XTpBEU6MPeQB3/rSa+x+g7Jqh8flhYfr09nGNx01pskx/Adol8uln/3
         kWPvLizovT8owQ2wNKapWHQbVZGIcemDria0GfYaX6mwBHv+l9PVP8DQaeblhn4fK5qF
         kzr1+I5bx0RPD8xDUh2F/zbdCZ3hYJ55/wQrZpPM1e2+0y9l0cRew3zczMoUIoMaGfeO
         fTrw==
X-Forwarded-Encrypted: i=2; AJvYcCUDPaXrOS3nDIITBDcIeZBFS9lhWdK46TnasAoeRtA1iSuqVd8zlDBbDhSJCLB3XvYMt64pJBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeNT5tc/BABpWE8fnzzBZo5OZlFZxtOw8Z9JXgr6it3bwogS+
	ZADhajEIZMIZwpxNyMO1Gza8FdP6SQtrXzm3DfwJ+se33eApup6hTucEqfaPKaSNIIL7xAL9T2C
	+GW/RriW513hldbG9tGTYt9Jvd2qD9hYwZf6rOejMBB6fw5YaUepGlGV7B22RVx6V7wAV4C6Xae
	DyI2EWuQ3jRxqdXrxPhU0kKULBwUGTbbCGOfQ59ddGKVhJG1T16OcK1DRY48dW8YCQSmfMabQWn
	X95Iy2bFwsSWgzbUw==
X-Gm-Gg: ATEYQzy6lw6V+HLIKDdNMKalfpYKscqG8YDgFR8gbWoLJp/TLekFoua8ODqIP1SS0a9
	o3T7wrb4YDXgq4+Tdu+XFy25oGY4iyzvc+cAAsiLKmwYNqvbmoLd3JAbSv+TD5rOFLPr7lF5VkG
	H1FQa7jTluwYKj50y2JhVsaOA9KL9syDlGl6l6VZq4sL9lcSUm0qZ3I0/+Nq5oVdG/W8vrvfw6p
	4s3G2rHFGjvUvuQFtUMk2TS/3Lu8TxBM/HhT9j1EKXmAO97bLQu+jb8U/fZo06UQEktC7Qy4Qq0
	Rl7Kd5aYsf1hlbGgTryoBEabCySX1No5PXnNUQ8U+hamlamm31qWP/pZ8Qoiu7c+T8i6gbtaCYJ
	U6OFdXGWO/t9zcGVOItvAbYZczq1fgfJXxufjkYvlZmuJD+goFhrd5CPkbaYdB3h9t7SLzlqtL5
	mzPCCvpt1EQZ6AEVBumMqph4sg1N6fUVNO31awWtF2YrHsVTbNdk8n+yEyGFMjPdA=
X-Received: by 2002:a05:690c:6612:b0:798:7039:eebb with SMTP id 00721157ae682-798c6cb3050mr43597587b3.45.1772707886110;
        Thu, 05 Mar 2026 02:51:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-798ac64f778sm16462897b3.6.2026.03.05.02.51.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:51:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5339555eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:51:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772707884; cv=none;
        d=google.com; s=arc-20240605;
        b=PwRJXPNeNjChE58q79Mrm0+a9HuoO0j9pCyNBPhEMV8/FlxLpBZgbYWt8ddgVhN0t7
         fhyiRnFoGZ7o2fDZKXpEAeu+c7IwnXqOi30+No633UGPON9JE32Hai3q92bqiokVoaW9
         yXrutvSBaUflU9WUOOoGl6Oo82/w9O7z8NZjCkw+0IcMJBwhGYODEtls0p8ABXyfD27S
         3Lhy6U21W2tI54Zjp4vWkEtWRGgUZyQfjrDmd0TKCspAnpqujgrtmtBeYcEavBHn87kO
         4W9w5oMvf1aqC/a7spv+gD4o230KViNuOdthdCzUve8WrWN2+eK0ApUWD6+cvg8Ro6vB
         4sWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KOjKwLOwleVP5tMdf27Q9IUu03448Pg27iSMuH5/9Jg=;
        fh=YN4EJkvTorJE0+L7MAGMTpYR8NqWO7F0eBc/aVI00U8=;
        b=clREkhatmDlXnjXZ4Lg0yZSzWRRsOEIoyRG0YNcxVyf6xYXana4mkeSKyoeMpPeU9T
         iCBMSLaWMq3EM6/qrjf3fx8+tt0KmnX0KNIkE+lXxdQhaknrE3mvWGxSpcfpxSihvQlW
         LvF3cEc2RkRNm3rsJQiWFMz+AJBPHoRXG37f5SsHukOOSWyCV9ARqogLsZRnvFhgTO4w
         3BXo4LxjtuFO/oJU3l15CBdmHMdW7wTB/yBpDid3oZaxa7J84e4i/0RkNLK7AbwznIwV
         JICNWBS+JtFSkJfFrnkjqaW7e+ytHO1BRA8r1tTod/PSGUO05fik9BEoS4rgVzVu4lCP
         SQZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772707884; x=1773312684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KOjKwLOwleVP5tMdf27Q9IUu03448Pg27iSMuH5/9Jg=;
        b=aKKB+wxVO2r2XpMRlVYVPCPXYPb9PLCyc7qrvEVbswhLIkVdDEnolFio9bFzxSqtYh
         7XgUTbBGNvvCwSMzyZl1K3shT9EbM11ngsCyS7FDx0txd9H6WrOZ3A+PxRl6BlFw6pmg
         1IPmIcyEVZRH3kqbAlvlLCpE8uz4Cgsctld4U=
X-Forwarded-Encrypted: i=1; AJvYcCVrYE6Skr6dlpI6Nc3vLzt/b4Knb5B5vWzxyujiFIhiySnR8we8RW454UsL7bHQD/qrvik+KLc=@vger.kernel.org
X-Received: by 2002:a05:7301:d17:b0:2ba:a4dc:5c06 with SMTP id 5a478bee46e88-2be3108189bmr2104327eec.20.1772707884537;
        Thu, 05 Mar 2026 02:51:24 -0800 (PST)
X-Received: by 2002:a05:7301:d17:b0:2ba:a4dc:5c06 with SMTP id
 5a478bee46e88-2be3108189bmr2104313eec.20.1772707883996; Thu, 05 Mar 2026
 02:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228072715.1632280-4-bhargava.marreddy@broadcom.com>
 <20260303030029.1884718-1-kuba@kernel.org> <CANXQDtZZTmh1axG3AnM0WH4FgDh0b9Mm5JqdUd+41CqdMg7Zjg@mail.gmail.com>
 <20260304101735.41b247eb@kernel.org>
In-Reply-To: <20260304101735.41b247eb@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 5 Mar 2026 16:21:10 +0530
X-Gm-Features: AaiRm50r1SRqpL_E0eV8KOpnLlM_UZS0rlmnUbMsCzrB92ZBaQgaGATGUO4fhGs
Message-ID: <CANXQDtbeYSTiKkEt5Avt04USwH9_Gh12EfUUBbodFW=KCsENRw@mail.gmail.com>
Subject: Re: [net-next,v3,3/8] bng_en: add ethtool link settings, get_link,
 and nway_reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, andrew+netdev@lunn.ch, ajit.khaparde@broadcom.com, 
	horms@kernel.org, pabeni@redhat.com, michael.chan@broadcom.com, 
	linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com, 
	davem@davemloft.net, netdev@vger.kernel.org, rajashekar.hudumula@broadcom.com, 
	vikas.gupta@broadcom.com, pavan.chebbi@broadcom.com, 
	rahul-rg.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c5bdf9064c44b78f"
X-Rspamd-Queue-Id: ABD762102C7
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
	TAGGED_FROM(0.00)[bounces-264296-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Action: no action

--000000000000c5bdf9064c44b78f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 4 Mar 2026 16:07:09 +0530 Bhargava Chenna Marreddy wrote:
> > The code was functionally safe, but I agree the inconsistency in the
> > array patterns was not ideal.
>
> Well TBH I think AI is being generous in how it phrases it's feedback.
> Assuming an arbitrary value in an enum is and always will be the last
> one is asking for bugs.

Point taken. I=E2=80=99ll switch to explicit sizing to avoid the enum fragi=
lity.

Thanks,
Bhargava

--000000000000c5bdf9064c44b78f
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB4DTfrTfe8ZuOzRwcQnXiPFmY/gBLgjXuVgJ9EKhqK4TAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDUxMDUxMjRaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBQ/rx2
jr6KTUUJDZ5s8kSj8Xfei7SnsOMGmxXEsLGJHlfuh80QiMpiDNWT3PrfxMLvSJa+Ve5kkEQXR5Rv
agCygxyg9ArSvXOWI5RbnSPzyXSwwU/s5FwXOFDw9LjXFge4gcvINVuZ9YPwHLVnVvRc81xg4t/N
4DUGdglB8WOvyNLYPN54bFJHN6RF7TmgG7z4MNDXPNbG60tu4gkEiHNxHhe7nJfLxTx1yYBAfkmC
Wt2I+URYLDqYRfN/IHlemkexCGJ/KbvCH9Z/Gxu/UWwjy+EUpMh4G3/5YxiqcQw+WVC7C/pvsVEW
IeN3uGtON7xzChBbl7rxYUsQltZR479M
--000000000000c5bdf9064c44b78f--

