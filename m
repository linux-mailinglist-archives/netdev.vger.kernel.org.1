Return-Path: <netdev+bounces-264301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NY0E5tiqWmB6gAAu9opvQ
	(envelope-from <netdev+bounces-264301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:01:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BCB210393
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2FC63083F9C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839E37AA84;
	Thu,  5 Mar 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UlpbgYZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AC364EA7
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708169; cv=pass; b=QpUQifPZDps/n5fKYXUs/ATkb47cV6knok6pWN0lab1qGN1OJjd24VaUiBssyn3ZIruS+JeKwcqqj5qKhiGA5/1saiw1TPkoc6Hy6BLrrP4pD90YmQBDk4XND78t+zGmUPcNA5MBqGM1Xwyt0mIZ7+RXjjnYadgXNja8aZG0YDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708169; c=relaxed/simple;
	bh=NvR7/WhlJ9lxMJ2ov6IU1iTy/OgwVO6gbMuxJFiEVko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEtfir/zyxLHd9++yi/gKcy2j2HKxqozo4XTp5BY+GbeebeymYv625WnwdEWtN6GdaZKBdAByeoKxjIY0xU1lYcmx943L2D/8o6AexMT4y5H55JNJf/nvGKtY6NqwRp7OFzgsxVhpf8MJn83qgf45j4n7zPu6JL7/XmSoN8i7sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UlpbgYZb; arc=pass smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso4076904eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708167; x=1773312967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9ZZNMaAWHL4CdGNcDYMcQQekbgcDZhqMlIhbGpRhMo=;
        b=ZIJgGtw8ibhsXm+brmHrOxZJFw+ahGaEw6GQC6AaqXU6u4F9Oq+xYhDbcX3a2tdVnn
         9hmT6ghMemZYG0+jve+9hLlQQYhXehWmfuS5UuJU2lz8L7qe7fHe7FaBZdFi9CZ2ZEST
         3JncyMZb7tS2F3wu1QFREtUnQr8KkIXyRp3W7AzoB1ULP76Y6K0VG6mi1jqG1IlZS4Uy
         g5Fdc8SIymXny4YeyXXcuvGckKb4IP8tUDJ1mt2tFK6CuDMaQsP7ZAtgL14Rh+hNutiw
         4q4NkAcrQtNTPJ2j1bwGQfqHgxtyDfrjYhmrFtp35U9rqAhnJWiknTHcdjODR9Uq2nVi
         O0Qg==
X-Forwarded-Encrypted: i=2; AJvYcCUdec3h2DOBK+IIg4ZvJuiPqmzFfYa9ZGDEJvr7C80qNgMrC3lENDVMXzN3UBaTwEME7VSFiq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+mLPg5xrJpI9nJjDBAkt9Xs64/pZR3HgVpR9zs07dvoWFUNy
	QH466UNtlzDXsuZXsO84PjKtzzZXVzf1oZh/zCadlhjzp0kcU+qfHReNytZFdGPbqocIvC93ANh
	cRD3SGE69Lg/gyJBMEuMBt1jlw/ZGuFWT1MHGkrehTeX3mQ/P9pK+EvYFuq6cMCtbGIy1bzOv+o
	BnVZJa2a2AZo6rLwWQmoBiwYBl7h9tXu9VwIXim1Ac33yB6re5Nwo7oSofF/kJZ6H5ko5gCvCTn
	NU6vo849R4gi6tW5w==
X-Gm-Gg: ATEYQzzTeTSnX6Oo42FKIZmcdJ4J7Q/ODR3IdvTQqjqV5k2uqvmavcYTUWk45q6UtpO
	l6eaYabT5qBzMrrMESpw4B2J03PjKux6ypI3DyeeWuz8jbPoimlpdsqw5q9uUR4cmd8KHckW+ja
	OT9kMuTXK1pLDePIf5IzRSUFSWoCpStYglofFmDDkmTGPTwhwgDqPObdUN6x2GG36evS/8MBf0Q
	nMwdLozx5JVmJHugwUbruiu09KDHwY9KUFlZzNXM7wyZhadV687cpVo0w73/Ya/StHtWaToCZ4/
	ZIP693O0ZFe5Zj4+VAdnUPbczRB8U/WrY3DgLwswnGqdQVHcj50ZvIoCMpQA+kVBUyOMdgGTgF2
	bGzr9TdYMszlttg4oL3hsb4KFCnqNkZAbOrgNXcAkT/lL1CLFLfBDj6oQeFutDWoE1STsUiabQ0
	UsEH+F9Y5Wj0CvDZzr76wou/cO43O3ydwwr+rptGD/WYeoPCLe+2D3i0H03xd/ra7LoQ==
X-Received: by 2002:a05:7301:128a:b0:2be:8da:3207 with SMTP id 5a478bee46e88-2be30fd3614mr2139255eec.6.1772708167183;
        Thu, 05 Mar 2026 02:56:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12789a1486dsm3302848c88.3.2026.03.05.02.56.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:56:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7982c466ee1so154453577b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772708166; cv=none;
        d=google.com; s=arc-20240605;
        b=iUnkiA/BLZXqyTFIPfWEVPQnzoCnJPcjUvKVmPlHkFneiFv8XCQ+Ff1HjRh6NIR36P
         weKFzBSLMQjWAPIzAt2rJ0eQzb/MoHLPtpM5kCU5fJ592p3uKeYb5VT7OWw83YWk62uT
         uarVXV+QfR664iNdRICUELIQYomxw5LdGNX9e0+UlXH6Ua80pbxZ0cFOwmKzMQJ/dc+h
         0e97w2b5Zl/Z7P8wK20yK0wFUPEwQEiZksHdbM44vH1N75aUP7dlA2AAAi3yVuVBGtqw
         aN9/GpUurdIxUgN2S7hZtWKUGTnl5WPHzsP5ktFCYwDzyLASXu3tUXv1jyvytjfGeFsz
         mPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y9ZZNMaAWHL4CdGNcDYMcQQekbgcDZhqMlIhbGpRhMo=;
        fh=jl9pUs6xZJJoVE0Ht5+kao7qMfQM1KcyyZrRBNJzN0o=;
        b=h5NDmbHyqV8rUZpPSSDV/OtobFLikiEkzYQZOdoQkYQkLaJxNDuwbLHpAsTnt6zuNG
         e9d9IDWiE+6AKCaSFU9GE4kWD2SkQ/2dGGUH0OlYes5mxTmOtyRL9gjTKQAYKdOmqhKH
         tObRqxZ1Aj2TLQfrNwMEM7ge1FOglcvEBd/WjiKdvf+G8qcTOVtDXACBrE0Jxpo71KCY
         j0x7jUWkYtbilWWmUUfitHnu+Q7J0fvCSCoU7NhYHRu4TqFyKa8Yjdmi8UB3cDxHwqZD
         7J1nSmQFUobF7jWBlTRs932VxjZ5cWiEcwhiweP3URG1drTqJBWWbqCAzelC1psSt9OU
         dIpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772708166; x=1773312966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ZZNMaAWHL4CdGNcDYMcQQekbgcDZhqMlIhbGpRhMo=;
        b=UlpbgYZbJg7ho92FjG8p4jxNVaGW8DnPW7DtqpEuq90jefqKrA8lm/E5XVnLJnOC+J
         vT5I/C/vUWaHItZNGN+R9QlO+IiS92wgNEWtlSRhpzCzvpAU2iuB5oJPx2esp5bXTx0B
         40YY9FE8TgTwp+yo0T2FChNn9Ahqr9eIEfT2Y=
X-Forwarded-Encrypted: i=1; AJvYcCWyBejbcLQ+U/eo7GR551RakN8ciiCVoy4U092A54Q0UxOttHB9E+vvxESTJpPK9uMbkOBT3mA=@vger.kernel.org
X-Received: by 2002:a05:690c:4588:b0:794:cf56:5bc1 with SMTP id 00721157ae682-798c6c88188mr42405877b3.33.1772708165879;
        Thu, 05 Mar 2026 02:56:05 -0800 (PST)
X-Received: by 2002:a05:690c:4588:b0:794:cf56:5bc1 with SMTP id
 00721157ae682-798c6c88188mr42405647b3.33.1772708165385; Thu, 05 Mar 2026
 02:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
 <20260302195352.1015990-4-akhilesh.samineni@broadcom.com> <20260302150537.3c2d11b1@kernel.org>
In-Reply-To: <20260302150537.3c2d11b1@kernel.org>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Thu, 5 Mar 2026 16:25:51 +0530
X-Gm-Features: AaiRm50osgtHQlYZoE3wYVd140l2I3tCWAXgnWSb5mLJwk7jnkRj4K2mB59o4YU
Message-ID: <CANQF7iCTYojP79JPLNHQHiiyWXUyOv7KTFERToB_GQbC-J013A@mail.gmail.com>
Subject: Re: [net-next 3/3] selftests: drv-net: psp: add reset statistics test
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com, 
	daniel.zahka@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	kiran.kella@broadcom.com, sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008a52a6064c44c815"
X-Rspamd-Queue-Id: B8BCB210393
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264301-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Action: no action

--0000000000008a52a6064c44c815
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 4:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  2 Mar 2026 11:53:52 -0800 Akhilesh Samineni wrote:
> > Add get stats and reset stats verification within _data_basic_send()
> > to exercise the reset-stats netlink command in the data path test.
>
> Please make this a new/separate test.
> (of course definite +1 to Willem's question)

Ack. Will push in the next version.

--0000000000008a52a6064c44c815
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
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIITr9lG1Eq2X
LHc3mmLXz/EO+Wkm/YsQr2WT0WAdbwTaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDMwNTEwNTYwNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAFkNYJaDrvQS4h1rFdKChPCCO3u5KEvsc7elptfeVLxlWr9d
N79a5lDFv+KhH9RN7OMpff3qUgByVENXNIEYTwABXU3K6nI/7oQgXs/tkjLmGmTtZYnJqBsXAiUV
vmrMZ+hPQ1VNtm1CZAw5lMQGHQtVx4MKaRmnHHhBPc8Pi1yXE6GPPg0+ErFHcDQ9u0cijMLmYQFx
zL8W3qRfTPTdUKMR3h8wQlW2JkfAZ3bTCk6G8UVlN2kAhS1y8wgaTF6cK9/dt1aJjh5n1EbEGRiI
QZ0wa622ChqTZWTRPJrGzB8xIf1zzJpLCaxKfwmR31Hp39bHcdfgM0nYoauEcPiYfcY=
--0000000000008a52a6064c44c815--

