Return-Path: <netdev+bounces-264299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH2CBh1hqWk96gAAu9opvQ
	(envelope-from <netdev+bounces-264299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:55:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B609C21020B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ABF43022997
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD55371D11;
	Thu,  5 Mar 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F3FBD9xE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF9364EA7
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708064; cv=pass; b=nHxsc08gj82zIQ82wVT3sOUqkl6F8So/505s8GHvF+2WuHVqn6cYcYTGFmeSXHA+1F0YqsxfDvHQYS6adYwG1TTcu+krVr7li+cEz5QDS7/GpgMIukxt27Mu0jqhXy8EiesGLZEco5YALjIruwA+L0MdngsXPUC35gUZn80VCeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708064; c=relaxed/simple;
	bh=KAA/FNmpCtZHZgSSQzeGkdS6YauC8WPz7ZbRthw2dNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDeIWMRyWgvw0C4JtzVHm4MvSeD8b2+Gc+sXJx38ZjRl1+IvpXtD9Qz85jsa4Km6E6vGqeEZnp2+Rsdp4jPe+AtN4rFVZqkZTaRn/WU6W0Wy/1XWxseevorfjbznuFrAjssvhUjNj2MsDt5Bene+4KHCXHvMFRhW1iJfpb/ttU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F3FBD9xE; arc=pass smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-4094b31a037so2038384fac.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708062; x=1773312862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAA/FNmpCtZHZgSSQzeGkdS6YauC8WPz7ZbRthw2dNU=;
        b=f9/bZtPLMzCijErjNsAb+YhA9yyqF8cl0CwmgUI+ZD7RvNYuLQH8V7RIcY1sL6Ltzp
         dNUt8rsjVrxm8Yr9AwMKZPg992sHqkNso2JJgeWxjnxgirYjgzSDchEzOTS61p+ghn3I
         8UiXMgFJfE4W5yKR1G9rf68xsXIiFS2zRrjpOeNMWXhTcTeIDrDdCbHh7+rEU3JQeupt
         DrpQk4oe1nSPHv37zLymlNqaeNijjI+x4kHPZFbUqCzR/dD3xnWI2csqvyjZIQ+Kk4+o
         kRI5JTwEWuolIn9Vm2i38XArN62F9p4IrDsn8PJwcH13HLEaqULoQ6jIlkFWg1vPHgH9
         sNNw==
X-Forwarded-Encrypted: i=2; AJvYcCXiWznbbriqTd6e7A6l1TAreZV3T0NweTNignvU8rhppDhYTpeSrwNeUMptCr8jw6WjUYzei9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBQqgqLwwb05YpnlRoapJRbs819REb2HnfKBVsz2pzkJqFtr8
	keCqHLp/jNLkdTt3BFa7ew084A7PmmisFEZeI5QknnDmM7W46nM7T5CpgHbfBig1/Rce+ej3eO6
	5G/yfotkNKGbJe1oTMcJ5nHDdFrUuY86DNp2aEfugcSPPletEXCvUBEG4g6XADwbffM4H6TTEhi
	DoCH04aoCfNwcHIDkreBbTFNUTIvUoCA+pLk7CSNwf2DO68SbHw4hjpASkxogeBsgfvP2HbTw9P
	RZYjLwScDwcf1bIpQ==
X-Gm-Gg: ATEYQzxYGDCjPTlJ1Kba7vcOsULu6jXfehCWOCr7/pYgi6WNmzRaqfY7iES800UTQ0E
	b0VtyiYONkrhbySkrmoYQWjLbCo83FszlBZVKsojSTlPYWF5KgUL71HpFi25f5HRsL41xpU0gbK
	DG4Uez/Ngb+gTNE6n5jTVU0yAJz1mG4lh1/uCYV7VOrV5Q1GBAZEzOfEaL+xuvYp8mPK+ldFxuf
	gEpou1zi9xj05Ijq7jXBcTwoyyhrdCVgahUzmzKOReYXGJYuppLd59bZ8ATEmjGTTBW103Ka8p+
	sOm6ubOwokx2XbIzGTPcGPkQuddUfkDmgyhrHwk7X6Ub6YPOq6enVeCW+emHa5Xo/8f+vJ6217E
	8ws/y4XoR26UlsIw9De47bvwUi+XGDQ2nIdu1SOxw2l+b9RfwjtlJ+2ULqhb1tN/ad4BQC2j9b8
	4wldXgFwEcEIDCegv4FpjIMhgC5MDjf5OScLGfEeOyarYep/1nsYOEzGGrWyql6+1WOA==
X-Received: by 2002:a05:6870:e3d5:b0:409:784b:cb6c with SMTP id 586e51a60fabf-416ab5b4428mr2762476fac.17.1772708062201;
        Thu, 05 Mar 2026 02:54:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4160d21f7aesm3051127fac.9.2026.03.05.02.54.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:54:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79874ae3e49so121914547b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772708061; cv=none;
        d=google.com; s=arc-20240605;
        b=li6yq6Bf/I7L966HEI3VYM84gS/MKFF9its9ZhdvreyW+u2lqdvJ61viSLU93p5PnI
         R1PYTjACudaDIll66Das2J9L/RMoQjLFSBEDf8+rjPvadAr/CaV8k6GhIw69VGJzeJgl
         GhYYlKA5J4e02Glzg/RHWGKhBgC2eYr3auysPA5kdvYtanCh/XiZfefr9JUVSDje09nD
         MkvMWajDr6Xt3W8HDsvgG3RZJaPkNRH8+BG8f6I0QlaaKXj3+gkOrR/fYWumZuxUZeTA
         G1BaNCIVHuzjzI2KG3FKIVGL4ppmphZVCUBiXUCTfs+nxZbZ4GvjEVppP3o9XyKfxmpi
         cKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KAA/FNmpCtZHZgSSQzeGkdS6YauC8WPz7ZbRthw2dNU=;
        fh=f9hTr6bRUJBljrrTcv7WWk2b+5CrsRZ30dD55Eime+k=;
        b=XO64Ljnkf/m+QhMBP+n3OHJV+ZZOiUAndy3puHjGTNmifn6JEH8phH2d2TJUYWyqh4
         MPIZz7zL7Y6BNC45zzhz9/exRW6IN32/eXLHc6967fqZPaqMJvywgP5RqbHafnOFJdpa
         ZT1bngeWUBM0KSZXlZoCRH8SJYb6KdXSZzwbUnoMqmDGwdWLnDpboombEAziPX3Ha9sy
         YTa63hfRFZHpBnZLqG0scM81QYEVRvr+TQIdw0N5yHWRc4g3d+EY+o69Thjzaij8tlcw
         mDYu5qsF3iozTxgk6azeVTjXkpyPSo4vdB24Tt4aUjExm+3BuYjMHLXQgoPGLbcy9GdR
         Ll5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772708061; x=1773312861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAA/FNmpCtZHZgSSQzeGkdS6YauC8WPz7ZbRthw2dNU=;
        b=F3FBD9xEnn1gHLTROaD5m1F9ox5+gUqcAc5V+w73bv9mKZIFqEC/tlQCjwpMtOZ/64
         zM3siXeGTuTXmW5qgqDP1+R53xkmjLAPDTxxXNu2hDqyHVhJldOLsZsdJK6K/TF9t7NX
         I8cDAX3AJp2Q7NrGGzD4SWF3Gic10Akntb0Sg=
X-Forwarded-Encrypted: i=1; AJvYcCVhpRVQFhUIU5uufjTuZDgYERPYmNW5klRR3kVwjBg5HEgzXmbmkMhgWpGW7tFwXBWmM2wFaD8=@vger.kernel.org
X-Received: by 2002:a05:690c:112:b0:796:3917:7291 with SMTP id 00721157ae682-798c6d1903cmr43067977b3.58.1772708061141;
        Thu, 05 Mar 2026 02:54:21 -0800 (PST)
X-Received: by 2002:a05:690c:112:b0:796:3917:7291 with SMTP id
 00721157ae682-798c6d1903cmr43067817b3.58.1772708060689; Thu, 05 Mar 2026
 02:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
 <20260302195352.1015990-2-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.270f71617ce0@gmail.com>
In-Reply-To: <willemdebruijn.kernel.270f71617ce0@gmail.com>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Thu, 5 Mar 2026 16:24:05 +0530
X-Gm-Features: AaiRm53ZlC4M4F-_GMf9yszDDxHDHH448SPju2ZdzomTuXi8ta1yZ2QByixcdTA
Message-ID: <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemb@google.com, daniel.zahka@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com, 
	ajit.khaparde@broadcom.com, kiran.kella@broadcom.com, 
	sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004bb19d064c44c210"
X-Rspamd-Queue-Id: B609C21020B
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
	TAGGED_FROM(0.00)[bounces-264299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,broadcom.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

--0000000000004bb19d064c44c210
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 2:45=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Akhilesh Samineni wrote:
> > Drivers may need to reset per-device PSP statistics to zero.
>
> The series does not include rationale why this may be needed.
>
> What makes PSP counters special in this regard?
>

The PSP supports dynamic administrative states, allowing it to be
enabled or disabled during runtime. Currently, statistics are
persistent across these state transitions, which can lead to baseline
drift and complicate telemetry analysis.

This patch introduces a statistics reset mechanism to allow userspace
to clear accumulated counters. This is essential for establishing a
deterministic baseline when re-enabling the device, ensuring that
performance metrics and error counters reflect only the current device
state.

> > Add a reset-stats netlink command and a corresponding optional
> > driver callback to support this.
> >
> > Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> > Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>

--0000000000004bb19d064c44c210
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDCI38VoeiWHImjdPjDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMzA1MjIwODU3NDhaFw0yNjA1MjIwODU3NDhaMIGY
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGjAYBgNVBAMTEUFraGlsZXNoIFNhbWluZW5pMS0wKwYJKoZI
hvcNAQkBFh5ha2hpbGVzaC5zYW1pbmVuaUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDAO001ZnYPXmhKsI+E+ksMK/hc9m3qLeGDkvGAIpfLyKfdk2C4d6tsRhM8
4xrNQmMMM+f5wF271rTc0O+CTfIIIayklTmjzksl5CwimtzjGpPZRcLeABJk4Z8VdCU+TW0gSDgU
UGsHqEkCW3ifD8UhO+1xsg2k1ER9gbJ5HfkiiRjtx/jG0Eik3rXjcrxyU4CSTJeFrMsRfHBINs1b
XQiZIKEA2v9ryzZcqBG67oV2mIMYV0PyoO5ccmjophMLX5I6d9LmhVG+o7Fb8fYE43v1Gmx1cF3/
HLCRJ9lVtOZNrDg8Tx5LaODYomcqd8Jym3+vbToQ+O0SQyV9WNR9n6OnAgMBAAGjggHfMIIB2zAO
BgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQw
QQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczov
L3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8
oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3JsMCkGA1UdEQQiMCCBHmFraGlsZXNoLnNhbWluZW5pQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU7Bc6
vjugq1VNABQ8AiT04kX10IgwDQYJKoZIhvcNAQELBQADggEBAELCFtU20SHhQMZA0lekkhYfBuuc
/5XYCUX21R6IQyTnqwWwOQ4xNOiq5rC7P2bOGpEKMcMBcHB/VDqpT7Cs0PXecOkC+0cWvmZoxCjx
Hk+3d71Ie1w8r5QiYuGOgGhNWbfhc5aVZUENjC+zlYStnReq3uZcf/oziznbvTX38pyuhVsuHFSo
+SP9KHflLUYGQLmToaPGlRjPh+LJmpbiZ0NRrRXz883+dlADC7tW3fUlrqdeLN9xsoTh7CoWxLUl
xSAQfSnXdfTNfF36dQxm8Az8xhjNmD04jilAg+UVGs7xWqnIkFChNe8pykTtDwdrkjzaaISKeUDj
4fW8f5qx0B4xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMzh1TfutKYY
JLL7R9lpkeMnH1Mkwf8j+/Jx6ZaDLeYDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDMwNTEwNTQyMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAKVDNS3GFEWRdxI8VrluO3qafLfANFVPpmH0ZmRofCOaVRTJ
GU+wYmoXNZT+S8IUr52GJtoVK+cIHqp/TLb5JjcMK1Z2E9yM22pC3GDVpBu/T1GcAE6URwpFa6J/
IbpeOV4vMubHy3dRKuYVexpYljQUCvNyvYIyNYxyCsrjG3XuDXBmGi6B9lfjvj6dW554pop90qok
j9byhh9lFeX1cli7RdZHV6Cl9K/Pb5cP0/aPlG5foXN5sCTsOJqCyrpimljGBRVvFCIUvXazc4g3
28iGPNeaDuJWk2w2wxou+mbNVYZ50PxGmQ3vD+abEr2FXWWddJPhtsySZBu7EANDopY=
--0000000000004bb19d064c44c210--

