Return-Path: <netdev+bounces-255010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LPYL5srfGkYLAIAu9opvQ
	(envelope-from <netdev+bounces-255010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:55:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761CB6F06
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F44F300EFBC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA402E88B6;
	Fri, 30 Jan 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QQIaTvB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916C03128B2
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745153; cv=pass; b=jkiRz7Jo+TiTEJpB/Dk8Uf2xx7ybLx1XoT0pIZfGJ9PAnQg2msoLy5mQdqKU9h34kJErIzT5qjBbhbH5uubRP4ug5CF6iD+CyATQdimjH4lna32JC0qgptrqU0gxFfCnxnNNEpiumMbzS1pjzduT7hhv6rwNBbM9IJIxkWwDXDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745153; c=relaxed/simple;
	bh=IdcI8Y/6prW72TAhE0nsY2298XNKGlRNkUG55hLr+/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNf1ZSkYCttgV4UzG/ogUl8CPUyRhK/ielR7+wvO6oDeJi5uFod0SsDCR2F79UmftCuDWHr1S8hKQ0TmxqRnnEYNb9EQcHIq8EI8nj/Ua7Asp7vyhDCVYfqKpdjTK9omv7YopuzCWOMtz+69m16lf7gDmZ59+0J9aYFeS9YwBQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QQIaTvB+; arc=pass smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0fe77d141so10036835ad.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769745152; x=1770349952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAFQvk2+trOVGIbboRG2vaO/Y0gS9UXAkycZG8VlFz0=;
        b=QiMF9FnXTz8zJ1moJ13agNpLvrMgssxgalYrO/Qu4ys1uDoWrYLORU+8J4kF5V6FM9
         jVddXskjv7i8P+ZvjeW4JilIjio/YqyjwlO9UppCTXKB+ni5+buKGPb3UrGaNQWkZSWF
         6qoKguoatyw9T9R51hBcnuw7tSTNZjsbfuHiwpVyFcNIeg+9mxfrqDDewkqipfWPwVF/
         ndmaJWRywOTWCMYY+HkIxZ56jw2Ge7qa2aS0cQXAur2IgDqxtlaI7hyyCIahS/99QGVj
         utEOvI+vUdGhXjeIBg1nSRsYMCWtA6zNlGxyugVd1mXBq/vRKg22NfHoyJoGuoSPWljT
         BNBw==
X-Forwarded-Encrypted: i=2; AJvYcCWq2LxDoDT0fOZBz9yAWL3EaBE9rExWGKUlFuHJTlydSVXKAlc/kD5qco/gWSzzX6DrxO6Da0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAhvhTJa3qxGkHkflulWGRZ3Hq303FjV8ehX+KbOaUWBfEKKp
	F71pvwU9xNMho1+tmFCWWrxMOZh+dVI0yhmP94H988TFjTi9rI/dGwr2B/Wb7SE94yc2g5OKADn
	kOZuwJ/j+VunFaIBwA9FW/7AW6CHWBuUC8zGt+NA1VBGzdfO/5IbzTM/RJLL8qTf/Kdwa83q+1q
	iR1j4ySIDCnFGvzE8qPyvhbN1pVB3/xaYnlk8wfd7FjzwJwBpjuVz6NMrd7Im+n1s/lExEXwZWM
	dW7NC7RT48=
X-Gm-Gg: AZuq6aJNQARtpLnB3MYLLncGKbTXwadlCKTEYHVjQjuDCnzF9Ct5uEP13buV289oaFS
	PpkmwcMlEadypiIqBxlOdXg0Nb/KnFIEoZ7xgcAjqGtQ1kzgs+3JZE2Kj/uPTbJ5935L1yFP5cq
	kZ66Qab1xqXIvC6TUGsv1Xn+Z/nI9KvYvmPvl9+ANq6+crIquwWuNxsVHB9HieABco2rx3CMM2a
	vQOT/MbngKL8uejhV5jEEnhTziiQrS/8bmXMUJlm/coubIWE7WCoS+Z11FmImRL5nWC/W/tiJin
	hsH+uoVOEg2ojdXPoNU1IjqWanWwT9njrnoBxAQBAU3f29dQqXq1LUZ7T0yPfJo0cxAEurp3uum
	JvtijPwn9oDR7qDXncqC/Su5jY3cRDTw1LKdMLlOUggvHx2ssogOyXfrgf8t4krMKw6/f/ms7Hm
	X1S8U6VPg38Ic/zcYuB4e1qYMveOXrcN4U9nc+NRDC/A==
X-Received: by 2002:a17:902:d58e:b0:2a7:5a8b:fa53 with SMTP id d9443c01a7336-2a8d994277dmr12777525ad.50.1769745151515;
        Thu, 29 Jan 2026 19:52:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b3eef13sm9445335ad.13.2026.01.29.19.52.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 19:52:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c38781efcso1719333a91.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:52:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769745150; cv=none;
        d=google.com; s=arc-20240605;
        b=aAa7wOcmGWs4n5naQAmEA8e7raKs8akm4rqFt+ququrZhnpvsYA4ncVFzYDEbMNTNL
         oulvZuRhEmPj5YzY7f7gwv7hqt/E9A2qvPik7+HmlHXCgV66/ajOynJl9NXfw4jWXtpT
         XxOUPyNgZOLc0UlahFC6DheVXoZf4jOUdklrv1t9IY6PSAMdpWje4UvW6Qo4mKTqkve2
         Tp6KmrVsKMtpozttbqQnvc3dmFjaUR9hxe3VXr+Zliy3Z0JEWnzbgT58qJ+40pnWtyWA
         YX0GkBHTSIhrzdgbQ5kHqEBVbIoFrMEgB7EfdkS/8pipl1czfjaWR2Cbr0giLw1V2xu1
         Z/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WAFQvk2+trOVGIbboRG2vaO/Y0gS9UXAkycZG8VlFz0=;
        fh=fTKtvpANnQpybvYY2XwLpPzEcGKX1xEFcyHL/iquI/4=;
        b=irkHr3jVDMZ0DlFdXMSrM4lbdKxqc+y/11KQan+Kho2g9bjv/4cDo4ofAS5dbkNyjl
         pOFQP7sA+BtZolFDkeckEAk1eh3MA08sfo8ycrUmlmLC7eG2Pum3qYoGJyBTXJvdxYK0
         PBw3+cpcbN3+OIpRPujnB5aBFngD+d56bSjh5cJhp3F80oP6E3b1BkwXTczdBqYC9bk9
         cX8HXlV1466gd99ipdlRsfdRHm32mQLbciRbK/+NxhWT6TmNUnI5zdTzaslsotSfnGIV
         gXq5Aoxd3t2zQLvYi9clqaozm5QmaCWZ4fKoa7Q0a4ajjLcoUVd/9Z/wB6yosr37Wzmz
         w/Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769745150; x=1770349950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WAFQvk2+trOVGIbboRG2vaO/Y0gS9UXAkycZG8VlFz0=;
        b=QQIaTvB+lGMKMnay0SCmiiJRWwDePvISGSfQp6GiW+9FG75uXE9X7Hl2pn3jjliSrS
         tCcCEOB2SmFLqNeK/0OXH3c2iZk22688QAgOo76tl9vh3Lkf9F+jIy0qlO9UrDC+K4j2
         Dhr31ZKOa1eliR8sHFryx4TZmlrp2WLK2FCk0=
X-Forwarded-Encrypted: i=1; AJvYcCWpeq+gLZ8lm8x30cfs09nzhvzl97FTzFWbjbbWJjmPQVxCukpOtYwUUWTl7FQE46gOATLNzO0=@vger.kernel.org
X-Received: by 2002:a17:90b:4a43:b0:352:c98e:5082 with SMTP id 98e67ed59e1d1-3543b305f3dmr1514691a91.6.1769745149707;
        Thu, 29 Jan 2026 19:52:29 -0800 (PST)
X-Received: by 2002:a17:90b:4a43:b0:352:c98e:5082 with SMTP id
 98e67ed59e1d1-3543b305f3dmr1514671a91.6.1769745149306; Thu, 29 Jan 2026
 19:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
 <20260129061646.1417185-5-michael.chan@broadcom.com> <20260129180320.1c69a0c4@kernel.org>
In-Reply-To: <20260129180320.1c69a0c4@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 30 Jan 2026 09:22:17 +0530
X-Gm-Features: AZwV_Qj6BbizRk1dEArryAVsBnAiztwV0pOqlCe8TWMLgZ7v1TPdR7L8HQ_K5W0
Message-ID: <CALs4sv1ixptJMvYn_=mhYwkxbBnLFW+TiDTxbZ3oyGbH71XTZw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000025215064992e747"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3761CB6F06
X-Rspamd-Action: no action

--000000000000025215064992e747
Content-Type: text/plain; charset="UTF-8"

> Not sure why this is a separate test, TBH. You can remove the test
> without the ntuple filters. The two cases I would have expected based
> on patches is:
>
> tests1:
>  - add a couple of contexts
>  - add a n-tuple filter to one of the context
>  - ifdown/ifup
>  - check contexts and filters are there
>  - run some traffic to make sure it flows right
>
> tests2:
>  - ifdown
>  - add a couple of contexts
>  - add a n-tuple filter to one of the context
>  - ifup
>  - check contexts and filters are there
>  - run some traffic to make sure it flows right
>

Very smart, thanks! When I see such beautiful solutions I curse myself
for not thinking about it in the first place.

> You can probably have one shared implementation and pass a param to
> it  to tell it whether to "pre-down" the interface.

Yes, Michael also did bring this point up that there is a lot of
shared code between the tests, but I tried to test my luck.
Will be back with a v2. Thanks.

> --
> pw-bot: cr

--000000000000025215064992e747
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMClwVCDIzIfrgd31IMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTM1MloXDTI3MDYyMTEzNTM1MlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGQ2hlYmJpMQ4wDAYDVQQqEwVQYXZhbjEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANGpTISzTrmZguibdFYqGCCUbwwdtM+YnwrLTw7HCfW+biD/WfxA5JKBJm81QJINtFKEiB/AKz2a
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBzNove
5ja3qGHVWlx+XEed6+w3woSMaFk8ZUL7GbfC/jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMzAwMzUyMzBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBpNfAUalqhyjsC+O2BZnkipsoGMOmnXPaSUz08poz9
i3LxEOI6287qlOdzaG7SGA6QJMVe3HS+XV7knMVnhB6nG/F+m9n5XN2rOnzecx0O2RNnqmmMKf6V
62YXAg2wDqUR+OLEOxUowPubrfis82LiwWe6EXeIAQ550Zp/c1KY6oALbM+fjXd/utiNUVzWbSKW
0zIyQAsVnuZTc5RXlm4dqabI3PgoLp/N4/aD0zrLbFgwIjI0uGypyTa1I3XH48jyKYEOYX0hal+Q
klGYN2Eit/PKMBg93VUs8N3nKQ8ifImewn3OTdFSkAPF+v+aQ3YigdE9jvF1bLVx9idfnG5S
--000000000000025215064992e747--

