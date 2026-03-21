Return-Path: <netdev+bounces-270176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BcyOMVIvmmpLgMAu9opvQ
	(envelope-from <netdev+bounces-270176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:29:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 444AA2E3F54
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649213015E2B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206D34750C;
	Sat, 21 Mar 2026 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KlOLcNUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA62D94A0
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078106; cv=pass; b=lOwya/w4MfXng6C8Q8cyb+mslpn8/XYubpy43FmXrAfZ/kTRPAgxznnmuBtTmCieKZs4vzhGoBYd6hHf0To2hAwvrR3Oy6du8QRQiaaQk40Kziz3CYXt/ygCi+TlWkaoKCbBmrI5uVMb3bGcG7SqCU1bMgovbiyXLQaebumPfJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078106; c=relaxed/simple;
	bh=iWbqHSBkV7zZ/FwVT70HdWFaN+bOGK9oO0rlLwJu+JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ID24bAvBsROO5OykKFfwCeIDceE8SV5bP3rTWCqCAAfmjVZuXbs59OXQOuQJOlslouyOmsWDWcD0j/nN/P651G1x7zH3NiOyjDVqe6517/54hwxBTyOwk59GLPOsN+uSOZCb1e/5HP7/kDfeEykG+3bqbEQT+t+08/vxsDkcFl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KlOLcNUi; arc=pass smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-89c4feaaeb4so30194596d6.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774078104; x=1774682904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsLHEMU0vhkcq4PTg/LMZLH7vWc2Xqf/7LPKwIySZoQ=;
        b=skpkNA/cH11P4nFcDSyI7dZVcWeSigHtbtZThAEv95nr4z4Ki0D3ncsZNZjmWOz1dl
         9ttjwhQhr5JbrOl5wc0A7ODB485rN7PMl55Vc2lc0xPXowJpxPhOq3j6q3vW+k/y5Ayw
         qMrw8g9SPUhdsqwA71axrKOuyl9cZ3V31dzgiqWCFWnLgOC7sxr4eATeT3jxPB/pqW7L
         GWpuJLOEsxsPpx3GCifEmUJ55tU8mWtx4260RwnF1OnNI6u0jRPqVZjOBXhM1/cFZsSI
         3RWaG5XlcqE82Tr6WBS7FFlFu8Zak9VCOM21Ws0uEPgp7bQULvczUqMjKjy5SqOa4AKW
         n/Ww==
X-Gm-Message-State: AOJu0YxG98roIrlNwp0VbEaKo4yBXbqM3XWzKMhV3ld3Ax9SZ6pTUO5q
	p8Lpdwns3DPuVqqb2jy591OCor0WIl/NK5sbPR0AOroklEVcS+vIcN4F7N1ZqlkmSC9yqVt8F+H
	4eakmlA8GYaKEulUrVd5en0qoDb4HE6OkeIImaeTGSUg3+Z3ruPJb9jFCXn8FfbMrsfCbWFh9TE
	aZhfGa81TA9efAr1KrZxI17cfZYTygHZZoQXCl2oJJ50S1s9dZV9Ycj9NpinxiNrl9RNrXcZl5o
	PRxmFGgJLw=
X-Gm-Gg: ATEYQzxpmQJ210ntaAybNWlQuuZdZLAspgc6Vxf5ir4uJezCGZWkdlg39yhhxi4+Pg1
	kXQFlYSrtdjgagUx7QG9cThLNBzcoKHtJPW0EUeP0RZU8IlW7FPTrU18a9ebchhtmY9YdvNQ+UE
	wct2DCCBT7fu8zczdKifnrvnukBDtrHAE2Eu8zujvo4TmDIiMd6ACf9FJ3ggr8MWkvDBkaySdR5
	ImII/hCAgJs59xBOCQkMbzLaIScybxHhJFtB4fqHU4VFSkWM4GikbXtLHbErRSsDRfbeA2CIbE+
	iffIoRUzLRX5dzydouBtRXWJnvgX+XXvB5APV/G2niwsq1PIR1qUPqSbnaMr+Iqx2+EDo+gvSNB
	nyF7aabotkyCe0ilZpWl5CH8CJo3BP6jtjxZnOKYqa4WemS4PLSJRJ5N+oIuXXZhibhFBR0/DOr
	9b2hs8yTxXq/oEiEQehioTJPkIf9p/HY6FVo7xUXFA9ACZELy8ToaR4RNB
X-Received: by 2002:a05:6214:3216:b0:89a:125f:37db with SMTP id 6a1803df08f44-89c85a9ca61mr87421446d6.51.1774078103955;
        Sat, 21 Mar 2026 00:28:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c8520bdafsm4604826d6.1.2026.03.21.00.28.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2026 00:28:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a84f21bf2so7231751b3a.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774078102; cv=none;
        d=google.com; s=arc-20240605;
        b=iULtgFep3yq0acsJJpDKFg6u4IAQYhbx4FjgAXbeLk9YqPD+DYSg1EtoMRm5ONl2vh
         axP81Gb6IWAfF0Z5aKs9+79AUCt8AxLX8gM0ZPMc8DrrArWUMqodyifKp9vZYVjXJ1rv
         zfOq2QnLO0IuUrP1UViFli0hVMyrxdw1HLE7HDBGVQtMSHsw+CAVftBvpBHLGh/eNKy/
         DXfbdjMtDTSoDX8p8P+oO/G/fiEkPNxSgaU2WDQXbzNhviFuJjOD1sB1bXvQoQ3IGYxj
         bFDiYyGum07whYAEVZ3sxApUTkjza3NC3MI30aE21ScrVclhb1CquH/pnUEA74frKR8V
         upbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RsLHEMU0vhkcq4PTg/LMZLH7vWc2Xqf/7LPKwIySZoQ=;
        fh=bMBE+MSReAfoCPh3UBcPHh7lN5u8wbKiHoT9t9q9230=;
        b=Llof1SI0pY6LA2cgVvGtMfoIqbLQlMlswcfxAAKSQnZuuI+pZT0lHJevVke0RV7YpP
         3DCdo7zIhlwMFDt/28101brDHbBGNWXFmDt6dDABg9XtOcar1VUufV01dW+rPS7m44tF
         Ao6isLoYtC8e0W6mbPt3gmYy2EK5dcFa0MyI7j/9JqiL0WjJ6Y2rIJKcK/puGUn5Sjrx
         rwq5bSG2zgwuh7Kt056Y0a3gtSRGu6wbV6KS2H5f7SiaXFcipMdoEN5llJy/QFW1gLrt
         /D41l33z4EPipWrH8FBTFVKmhIYfkQRsO9eqrA0/D1LW+2ozJTz0YFDlsn338FRdoSv7
         bX0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774078102; x=1774682902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RsLHEMU0vhkcq4PTg/LMZLH7vWc2Xqf/7LPKwIySZoQ=;
        b=KlOLcNUiokFuUzZlxMqdxJeAI1qLEGGqFQ19cH7fQIDdxoM3aAZxwG9spHW/8uYdW0
         BcKtTJrJuw09prBJ72U56igYu41dSVwfYaslEkKDTyw43bcenDo9XVUeH3d+Yf1xFIuz
         qqKSWFbiOkINnwEMhHAatPqi5/1EkdfrEQZbw=
X-Received: by 2002:a05:6a00:3c8b:b0:82a:768c:9a2c with SMTP id d2e1a72fcca58-82a8c23e434mr4905192b3a.22.1774078102712;
        Sat, 21 Mar 2026 00:28:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8b:b0:82a:768c:9a2c with SMTP id
 d2e1a72fcca58-82a8c23e434mr4905176b3a.22.1774078102289; Sat, 21 Mar 2026
 00:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320144141.260246-1-joe@dama.to> <20260320144141.260246-8-joe@dama.to>
In-Reply-To: <20260320144141.260246-8-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 21 Mar 2026 12:58:10 +0530
X-Gm-Features: AaiRm53Rp_qWSdKnYSpHlYzwg-PjWNa0UV4sEdOBZnMtlZjnJmeKZAnUP2gIb9g
Message-ID: <CALs4sv1UwG4bKxFwD5kcSCvsO3qOjctdOfDoeoiaydZSoRLVdA@mail.gmail.com>
Subject: Re: [net-next v4 07/12] net: bnxt: Add boilerplate GSO code
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, horms@kernel.org, 
	linux-kernel@vger.kernel.org, leon@kernel.org, bpf@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000219464064d83bf08"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 444AA2E3F54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000219464064d83bf08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:12=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Add bnxt_gso.c and bnxt_gso.h with a stub bnxt_sw_udp_gso_xmit()
> function, SW USO constants (BNXT_SW_USO_MAX_SEGS,
> BNXT_SW_USO_MAX_DESCS), and the is_sw_gso field in bnxt_sw_tx_bd
> with BNXT_SW_GSO_MID/LAST markers.
>
> The full SW USO implementation will be added in a future commit.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 30 ++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 31 +++++++++++++++++++
>  4 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000219464064d83bf08
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC3m2CN
NB2beMhk0YUU96ZHW0cyTKuhCLfzDHmLQGy3lDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjEwNzI4MjJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBpOVSSvhix0HHYnjD5VmNixmMCvoioLA4Kd1jGBf++
UkhcBXLYtk+LAbVkd6q8hCIrP/K/kWvfS8PX2+AF6XadpHKXQY1KXCRx0XZMKazWPglO8M7J4IBl
1R4D4m4T60Zu63KtgNqa9NbvQd+/lms7f9z9Uq1M4y7+I3JhYL7aZCL/4rCiSUh/cA1AuCu4toI8
pApinDMsGZEGLQvRFGk7kie7KPzRqlh+34Q+vS6TnChntICYWuLxCgPQpcZ6Auj2YvTOlZZ2R4oS
aEP/YblyPuyrMe/PlJAdyHbZacuIlxY/hbzAQk/Wn9G0FsxgQrctBvqHAHkgT7439TsRv0Qi
--000000000000219464064d83bf08--

