Return-Path: <netdev+bounces-277527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGreFj1R2WmooQgAu9opvQ
	(envelope-from <netdev+bounces-277527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:36:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5523DC087
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311523004C79
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6972363C40;
	Fri, 10 Apr 2026 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q2P+NXWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91312D23A4
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849785; cv=none; b=pr+cwZm3c97eUu7F9qgkzvz77zNE3e04ld4vea5vJ/0oADpeWP/MpSEvfA76nmlaQmbtTElbC33iSqFIFkQMfSqKLWiTN8KbtNEbRFf36GK+ar+MMJpdNoIR881tNge2HS9K9pgczt5LeJX2/r8JAICNudQCdTIN/16f0Dj4gTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849785; c=relaxed/simple;
	bh=dDlD0ekMk0ItB2FaL/tmdZegA8Fk/8GLGu2VhDw/rQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1+vo1MveUiXHEMG50lhAaoW8SqgeRy9J7xKoXNKlXP4cQILPKuSujCtmnaNNJFNNcbjB+Zy88VfsJ0NyK7vEfOEYEmtG+hceJjadlME8T9dvk1QypcaCtxn4BFjBtsfJtGRZGSCB91F0mTxXejXJeZHBlraI9t1OvdXtNEW0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q2P+NXWY; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6507a7d2eccso2541521d50.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849781; x=1776454581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2ljyW6OPnEiB9mquya6D4czdB/tly6I+iISG80bbGU=;
        b=RPoQOYNOV7sv7BktWm2Kf9Wvl9IaqOFlyUTxS2GOqH4O/Hz190ELYIrLGWBi1FTf/5
         fvwEPajpAAeXggqiZtiTSIMmfqTc1bvcJMUfVVt+dKE22AxvOc5SoruRH0VSRVclciGn
         gZWGN7zPvSwsH1nXMD49RedWMy1FSLjte3eFqifbhgRuIi39Aceftbv0cuTnN5OOEYPV
         SpOYljRmJQg3rZlT3gMgBUTI6yrmOiUgGK3INl8bEr2NPpfF/LoNN5Pu3EI+K/KNBatC
         5SO94IgMtmp52WgL0/1kfA/i69zdoqDCuT7tt0utfTXOdQwrOVf5HtyvouM04nziTBXI
         u4tg==
X-Forwarded-Encrypted: i=1; AJvYcCVE1nKRmBF/8929VzUx5oGORAehm2C39u3i1jMTM+NrcqId/HJrQOheyypiBp2g4+tMr7QsQBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqJ6z0gVBjl29JmQu2ygeY7QPGMaeF4NTgdvRfEJ6BWrHObRD
	/C0In3ceq5sBRpN7V2d0zw0uYSNJEKFLqn3z3RQ91IEpJEbNOrjaQhedJhDp9k5+C+yAjXAXJRW
	cmOKTkPfqbWEEGiAJ7Ttu4MqNWpmOIwTzTE329p9e+cs13QnkQQN0MXe8u4spBH4TcnkrsRC3lJ
	gc3mlT/8f8h+LgWGctYAtIFotvl4N7QJl9o4Uxi0/EPKuIZ/UBpArLzIFUMhECmo0lSQi1xWRH8
	QUT7y3REtCXmPLeYg==
X-Gm-Gg: AeBDietlEd2PDZAgr2R/aGZBL98bhF/ioHy/XPp5f5lpqzs1/JRm0rzBtlvfjkQnVgB
	pkqK5RwUDpiVIsHZQZT2Ios6EZtC/w5YI+JFwsGaGC810CYSk4zAtz1jbK1DttKLnYv+tMZI17R
	UIqtErpac4hXAEOvozgEUDIhF7TklnKOD7oXPkLZQFpqIYGF5JVHuqb4zVSHrrZWNOCLipK8NjB
	N9lQ89lVpWFpnL/0wIFogRUqQfj8YRTbVZjsZpvMk8nzk+tS5S5YpAzorMIdicfslKEjtBrAxKH
	fY4CtRr+cPJZ/W3e4ribNNsLKRw2bSvmNQ10ThN6ItYmniBaf8Hvc5ajCTaiAnm9Mi1yDdS2zNi
	nAs12G3oryhzTrsj3vkZrpQPlY/M7FCbMRQGhSslR2O976+YB6VTjTVe7M8rxC+SjKMvPHWCeIZ
	imcwBDceAV5oUVDHMMFZaIfCJFlt1u9kOguiUEJQNA6n63FzYKI0C1IT6U9t7gQHM=
X-Received: by 2002:a05:690e:480d:b0:64d:568b:bcc1 with SMTP id 956f58d0204a3-65198a2bdd1mr3049546d50.3.1775849781262;
        Fri, 10 Apr 2026 12:36:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65197c6cadfsm242873d50.27.2026.04.10.12.36.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:36:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7949310b90cso53599787b3.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775849780; x=1776454580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2ljyW6OPnEiB9mquya6D4czdB/tly6I+iISG80bbGU=;
        b=Q2P+NXWYJA7jL/HPlnQMoM0onvea0hTLPntB20puSSTUDjgaLiGfJ/77cNaszj757n
         AmJlzvsDVZ2m9+taPY3dXUCHfy6WaRVoBiu4zVkd4QmbRc0S8M4kcy2vtqrC2QSma2Tv
         6nYw/O1iq8tJuWTM7Vb30z6E9cSLwCStGX6Gc=
X-Forwarded-Encrypted: i=1; AJvYcCUdcBb3ALwdIZ969eVoPM73AWV6l1zxqKtKIxluqh9Nrl/N/eIj/lUs3Q4/LK1QaRp/WWZvSZw=@vger.kernel.org
X-Received: by 2002:a05:690c:dc3:b0:79a:d32c:790 with SMTP id 00721157ae682-7af724326d7mr52630767b3.48.1775849780574;
        Fri, 10 Apr 2026 12:36:20 -0700 (PDT)
X-Received: by 2002:a05:690c:dc3:b0:79a:d32c:790 with SMTP id
 00721157ae682-7af724326d7mr52630427b3.48.1775849780182; Fri, 10 Apr 2026
 12:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-2-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
 <20260407180432.102073cf@kernel.org>
In-Reply-To: <20260407180432.102073cf@kernel.org>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Sat, 11 Apr 2026 01:06:06 +0530
X-Gm-Features: AQROBzCIozj4hBJgBy-QH_tlL2EHdp435jZupUh_xCe3Eak5lGeRPb2LU0YRva8
Message-ID: <CANQF7iDj1E6=3pod078-++5wbweyMg0H7gpeq0kbGFZHNytDdA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	kiran.kella@broadcom.com, sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005e09dd064f203fe9"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AD5523DC087
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000005e09dd064f203fe9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 6:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 07 Apr 2026 17:37:41 -0400 Willem de Bruijn wrote:
> > > +   if (info->attrs[PSP_A_DEV_CRYPT_OFFSET])
> > > +           new_config.crypt_offset =3D
> > > +                   nla_get_u8(info->attrs[PSP_A_DEV_CRYPT_OFFSET]);
> >
> > PSP defines a 6-bit field in 4 octet units. Does this need bounds check=
ing?
>
> More fundamentally, were we to support this -- is it a device property
> or an assoc property?

It's a device property. All associations under the device will share
the same crypt-offset.

--0000000000005e09dd064f203fe9
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
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIIPeRqr2mAn5
UZbhZv7Wzmw7zs0OVDu+3D0HUmsXV2/LMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxMDE5MzYyMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAE1Em/4U84fNbMFwuLxP0zGWMbJryfiDvu7ryg6MDaMaGFUS
51AnzxNbCAtaWr/GRYlDGt+zToMZECy968S8PI610iWOjnuOyY5AmIdKNzhnWXw6owArOZJmf9Q6
hKnB5SziExw1BXPv3kcIXawGDwWEasLk6tIPZnlHsoEHyKpgKrs+PRwbwCzkW6DRXeqK4+0Wz38W
3K6tG1w/tOy5iud+7EpBMujkBr4Yb1WWwZqwgoSTj7pPRdlOqISLLYplUeN0/eBy76ViRWdUit86
PQXVdxQvGFNM0f2hEVGQqvGvD0S7M4TsK7DxAqInlT2Ja+MXRqnDF/ZfuvoDgY3zx+c=
--0000000000005e09dd064f203fe9--

