Return-Path: <netdev+bounces-265372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL8EDZZPrmnICAIAu9opvQ
	(envelope-from <netdev+bounces-265372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 05:41:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BE1233B59
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 05:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E8A3019517
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936D2BE7BA;
	Mon,  9 Mar 2026 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WINP3bum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24729D26E
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 04:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773031312; cv=pass; b=OTW59oJM8lJP6yanCxa7AD+UawKu7RL8OCCqMCmQZWg7T917lTvhFOdT2VFgSzvg8qFHQ6DgILhu/fWj+Uk7qqU+GInm9yS0TmDlvjxNKPQZrgXQTwhWnfxO/aObNBiks+lNWF9NUHg9BObsMANlNrOGwUqaVgdnNb6U9csDr/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773031312; c=relaxed/simple;
	bh=ITC94ZSLhKO0hlv3UWj18zIIotmqgk+gdhCwc3QPR9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIB+oSjdV77YuYH9aA38RNzzJ5fHCQeD1GRfonre2Tl569JhlNvuqQL6gXMHRjVISGr3uzGUJFqnfNjTFYjydpmdFq55LadsMUHgDFyo7IaFkVsoHr8ui4FPXNyfWMkQorVaK6/mmJmWw2OIwVjdGuBLKSCM+4H8aHq+PHbF3U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WINP3bum; arc=pass smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-359a5d8b3f8so3254354a91.3
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 21:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773031310; x=1773636110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28xL22z2CceYYpWRbfG7i0rdFYDL41h6RZRC4qHDWMo=;
        b=Bf4eva2anM56SDXwdnLMTupBCFDNO7z1EivDadazAnrl6VY7DP01UjpDD8eYb+0oeO
         bvJrA5YVz6YqQw2WXRn2JUHD6RRDcbzT+wtH+hJmGqF7MALf6YZ09kRcNrvKaUzv+LWw
         wTKcMTS1IoIoWx/PnttUyjbe7X5SfvO+W+TqHqOOyLrGM7rpmJkL9Sip9Ra+qwVCdrHr
         Q7Pq2cxzAaCDOSRd2hdtOfWVG7YTBSJB8TQmEI8Un4n9gxbc6Kc2+VaX9p7sRkrjpOWX
         7q7wULfeqTxoF2QgzkoGvHsAtkyRyLSae9ghfhrLlqIK2ZqNLZNdJ7XwhlfmuNtVNPMQ
         dHJA==
X-Forwarded-Encrypted: i=2; AJvYcCX5JO8pdI00qTybWTftsUN436vnIeV9cm5p1pHHfXXi89T5qyGiQb6rfdNhJ/lLhDYKiTrtAV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx406Bi2f5e4NnhE1BmFhTautf1emVm7pvzpcq8alJJmMA5Lsvg
	VKc3qJWWiVAQBwGlYHGZ+yGU0Ey7NEoZKmXJfmZhDOqAF+84lv5RQGkIvZpWTgaXp/tBDRxyBtB
	/L5b1XXw9A44VvuiNLw/PL/FF2A+UQswIsMB+JucbRvtTS9AEL51t61m93rcliNJBwWI2Io60G4
	ZcDPgbRD50jt8Uj6vuuJs9M6dD61+/Y4qF6uOkbHCflw71nPNd+Dbdeb2BwMsLierLv1Luh47iq
	SPl1vhEXTU=
X-Gm-Gg: ATEYQzzSFudjzZE5mTN0IOxp19TS+C/uwTZ3ZMGFShtjI42bvVMUVfh6Ct8LD7j4aTj
	QTzMVLb/MS7qH2JnoU1Ba3bVCljLmd5f+oJxPoy85Zj+72YPLsZc7RNuwJPs4HxXk/dPTvpCWhc
	GtIU5G2eTGtSTWTSHJY8S+7WOVcO9XDaQ7+pn3IwdLZ05GAnvz4573/FhkfjdwhY3Wb9gRe1aol
	hBEeE5v95bxDpFNwlBaRX8YnBT/mFfpsxameAag/rof+CVBjfghieboDPp5Usmikq9s6SapRllP
	3/8uDA6HrWwVIVFwV6SwFHMtFiSKQe6Vtf2Melgiq6ljIa0DP/LnzVasWsEmPtVMYeY0ULDNd9E
	/+RsQq+3wBGGVibIoKRLLZ55cz1KiRLqsterm4tTTVZ6+/JmzfRjLsnQE0phmbdqM3bJRPhrKCV
	7dXTwdlGs67ZnIBNE/YlgEmnPQSXG97//snikWXbrrqJ6GhZWNI+EKxzzf57k=
X-Received: by 2002:a17:90b:33c4:b0:359:806c:7a94 with SMTP id 98e67ed59e1d1-359be233997mr9461630a91.7.1773031310044;
        Sun, 08 Mar 2026 21:41:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359c010a0e0sm1135185a91.3.2026.03.08.21.41.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2026 21:41:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b96e8e87061so83079466b.1
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 21:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773031308; cv=none;
        d=google.com; s=arc-20240605;
        b=IeREzFtkLzDddb4C9jBYZ7XscjYB5pcHKUOOaQqxS1GuIUnX97k+j+AMUdhk1Rof63
         qQOvvd3WGUKj8vEkH1GbCUEGqhXIEhifXzUpASxNabavwzvb+pLJ289GZQ/2BlSKqXFS
         IUHS20xOb1KcW23D/8bhEeXcC3PENKz519mpu6+NCAakXO9LfsM3JCquYKRw1vfKhoKw
         FUcVRPUp/gx0Y1bhwAjdQ4XVs7rR4zoO6P2a9RDmTTeJFQQLU5fXqRcFseNJQQ8YScXK
         MjqHVii9IB2dAX66ru5IN+3n4zLn7dapUJ+07/i10BoUFHLw0WR3bSPKmlbLIseOiTH7
         zuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=28xL22z2CceYYpWRbfG7i0rdFYDL41h6RZRC4qHDWMo=;
        fh=OMC+1neagcP9zLwiL7tXmlvcLkUIc8dm7ABigwBPxHA=;
        b=XQeBahO0JPK7+uFYjodmfVhAwRNClGv0oOd/DwQkiFYVwJa/zCLRRpvw0WK2eyrMyA
         IHNgSQ1jat/gP7zoSzJVYVj+cXmKeAK5Tc8CD2CTF4hRArxj1Rc391epBsj/H6J/dzyr
         Y9WRPUfspU9jnhoUZqkc1GVCqdUrMIlvrfjD8Iqd0W2KtbUXnm7L9kJukdeJvhUI2uoT
         seR24Es7QyheUba4u5R2pEaVujcpdfwlikPucoStI3GZ8bHLb9fCDqclGuGB4Obos1dC
         6alnnJAagvyg8IuQgbtaevWmMhQ/5mq55reMdg83fsIa69JStxVkSrjKCVqafwLfH8rA
         mTXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773031308; x=1773636108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28xL22z2CceYYpWRbfG7i0rdFYDL41h6RZRC4qHDWMo=;
        b=WINP3bumbNYrdbAYE1p0k7Z/nd6fxWGPhC82eekEo8Vtpmaeu3i5X+cbkRy2j/x8ME
         02HMlTLZqA1yJ1OoDUfixgSAg12fCxpx2QI6+wGbhsvIfN4vGiWSqlkVDBUV06+2ZPLp
         jpg0Ue96a6aKYiBTcSpDA8s1dRASlo+p+1j/4=
X-Forwarded-Encrypted: i=1; AJvYcCXsFtAid5+IwKp8AFZJ0lHaTIv9GkvSzaty0AGId4YJ0DgNFC1+/Ov5NKSS9H1KZxQrCqQpOkI=@vger.kernel.org
X-Received: by 2002:a17:907:9707:b0:b93:5fa8:d7f9 with SMTP id a640c23a62f3a-b942e00cf9emr541643666b.56.1773031307779;
        Sun, 08 Mar 2026 21:41:47 -0700 (PDT)
X-Received: by 2002:a17:907:9707:b0:b93:5fa8:d7f9 with SMTP id
 a640c23a62f3a-b942e00cf9emr541642266b.56.1773031307288; Sun, 08 Mar 2026
 21:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308131218.3172332-1-bjorn@kernel.org> <20260308131218.3172332-3-bjorn@kernel.org>
In-Reply-To: <20260308131218.3172332-3-bjorn@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 8 Mar 2026 21:41:35 -0700
X-Gm-Features: AaiRm503lfVLpZqfzxaAPrYnjOW6YNGPCNY-JemZHgI02Hdz3NgCY17c9t63DZE
Message-ID: <CACKFLim+0tUdjJxU=XXSKPMbVz7hn9uS2a7e1eySCZo6BJ76uA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] bnxt_en: Resize RSS contexts on channel
 count change
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004c1683064c900590"
X-Rspamd-Queue-Id: 88BE1233B59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265372-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Action: no action

--0000000000004c1683064c900590
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 6:12=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> bnxt_set_channels() rejects channel changes that alter the RSS table
> size when IFF_RXFH_CONFIGURED is set, because non-default context
> sizes were locked at creation.
>
> Replace the rejection with the new resize helpers. All validation runs
> before the device is closed; actual resize is deferred until after
> bnxt_close_nic():
>
>  1. ethtool_rxfh_can_resize() checks context 0.
>  2. ethtool_rxfh_ctxs_can_resize() validates all non-default contexts.
>  3. After bnxt_close_nic(), ethtool_rxfh_resize() applies context 0
>     changes, and ethtool_rxfh_ctxs_resize() resizes non-default
>     contexts.
>
> RSS table size only changes on P5 chips with older firmware; newer
> firmware always uses the largest table size.
>
> When context 0 uses defaults (!IFF_RXFH_CONFIGURED), steps 1 and 3 are
> skipped; the driver regenerates the table via
> bnxt_set_dflt_rss_indir_tbl().
>
> Tested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000004c1683064c900590
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCK6bEi
QJqaUf4mcLjB1IRaaK6bSIc47cMXXCWkWpE3ZDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMDkwNDQxNDhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBdbXudUpddczzrEPMf8SbJ7D58nwyVVkEMFlxTWnc+
lywHoniQu+4TQseepmSnUYQuIAP7L2FgKf7DQueVvDC1wSFykGTFRbBQHVVIur5Canr+T7BZ22hk
eBKvNiSSvRy7gwJ4bJh2X6PkPZqBRbJ2WIeeTipK0hj9iMad4DUBjRHwatoZdiDAH/tNUCZfQG0r
k4e2pw8GEBY8Z0yafgF5vNIE3d6jH3XskXj1GXhc0xVzV6PrLKMYJlfkjQY+I55gC7pKv2XXgTpi
lMFt7U4o3AvdoKleRO3gawafNRIA/pSJaTWdugpPQdOyGEPaVvs+mVV03L3R+NSqKcPY0EMY
--0000000000004c1683064c900590--

