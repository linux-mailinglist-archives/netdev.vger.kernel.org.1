Return-Path: <netdev+bounces-255031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGTrGbpAfGlOLgIAu9opvQ
	(envelope-from <netdev+bounces-255031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:25:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76CB74C2
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDBFE30143F2
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A5366DB6;
	Fri, 30 Jan 2026 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MoTqYTX3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584743090D5
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750710; cv=pass; b=rhpceuH4quXbVNEcHrsAB0/gnLpX+7jcgynJyLl2H7HS72Fpl+LxsHER9oRy/FAbmx2VFJWzy4/FMw/zd9tkUXcQ/YnRLHSMQpwpGbJsh/riRheGzb8NJ1pUWx5KXTfz3uIbzT+JnwQld3LyspsW4Oj+hxuAan/dU+ZGvbeJ+FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750710; c=relaxed/simple;
	bh=q4QZMmG9Io41MY6i9PGihDecAC4I41X8ZdaW0sU4zf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/dMdTB/BqqYoKyoj5KZpQkOM6171v4EeNzjW7Uj505nJkBOIpTTTH2ygKe+Qaf6674GdFl0MgUKCa4JkvOMurWpiNkhr/UTcxwZhpQ3hYrDSbbWu1C9lY/1Eu85boTXHMdbnNoFePHI8Yi/HJPj6heyW8udQoD+xEKxMeAiI0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MoTqYTX3; arc=pass smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-79478ec4cf1so17270077b3.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 21:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769750708; x=1770355508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUIa8wNV/kngDe6PKBUlVulgIneUkp32y+R6OWHJrmM=;
        b=YcqFBG6XM4+u8VKeqkm1PFl7LTMVtjRrr+QhM+ILxTndytEtTBRNwjKy0Q9E4kzfgg
         O35G3TI9/s4oWGlK/JiLM8jGr7+lanrjr5IfSyasv+qlzSmUlG5Jthji/Uo3U+Wo/h56
         o2g7zPcve2NBTAG/8Nha656+z97TUzvbtTlFV2tbvK/u98FI/lBECo5mYmNU7GYDBeOb
         4s/YYh+JKLH0WxXnvWF6tPqsyytnYfdDl/pWtVrBzGS0u0rt0ZLDwSRBha3HJotLAJgT
         xbML/2ixMEIrRSlp0xzV1lJv9dh4kfnFJfmvu9fmD/gvQLoTbaI7jsEyYbtzHWtrODYH
         D6hw==
X-Forwarded-Encrypted: i=2; AJvYcCWLTcxO2d4EuIzR3fGCc7Le2yhFbRZf8xVRlVvXePTJcfOXnMYAbzRp/Q9dpKAtRaSZWSpOsjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40AHq8hPWKYeFpZcbpgxP+fF6oQe/qlS7Z/IxAj6bTxFxqeaT
	8vorgzpwQAnCcDl2AVTpIpvAqRAdI0SQB5Euqoe3zJN3lTkaGmgGtNHsO+K30Z/qOsSOJ7Yazhz
	PfOXPC5k1vTl+AnUepe9uoT5BGCmG5nAK7e+lpFEpqQ7bqqzEJd8qMntbsYpiZgF/AqsjfHswJL
	SFejoxWwMynkwmCQhI2hQHttCMW07VbvNaG9UXqDVNGsdFbrks/J8Q7m15bfaU70n7HTMWS89qq
	+rBlRtopRI=
X-Gm-Gg: AZuq6aK4TzWvDrkaK3ilyoRW4iAnS8D1Y8DSGMiNysz9Gr5um592J8UjO9OppQzjGUA
	/fcodEiTQe92Bzw/k3+JG3xUBtr9kmGwBrW+jVjKQEFthmNopsH3FWdc02CNBVnaeWyJ1npd6J8
	rrtNyLHIXXhJdOVTN+qKMijnkU+d1CxPX1BJtCtpLgFRMQyOZ4/0ycDS632hDu+J2+bLrik+6Pf
	lOmhg7BqUAWuUhXdLXJrMvjc7JGdtNYoI6In/jTaOQ3XYVoyTirSWERJDYM7EUoCfLcxbkTE2/4
	/4qGCcPWzDsWvjHRZfG++wruxe3nWC7bSHi8gXCz1HYbFlC1grTdHA8jacJNtjOJ1Zuw7u7NtLd
	ppqnHdwCpYUmWreZwHbG4DujDpMgimNp4nCh229qPBht0xSH/6oqCPcDYIUj/IaHqAfcCZS7X8C
	IVOx7JtlTRI45Jdstnc+SlQTDQ+SM02htWxoBnJ4zR1kp0
X-Received: by 2002:a05:690c:e3e4:b0:794:9d24:76b0 with SMTP id 00721157ae682-7949e025932mr19231127b3.54.1769750708185;
        Thu, 29 Jan 2026 21:25:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7948279f005sm3966347b3.9.2026.01.29.21.25.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 21:25:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so1540075a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 21:25:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769750707; cv=none;
        d=google.com; s=arc-20240605;
        b=DtSKSpgCLBLQfpUHJpmiM4k8YPQ0WV795D7pZp2szLQJQpZ3zWwb1QwUjtj68DQXyU
         OL7qflQwTGzH6Y0w+oohmf3gLhZ8/QMLguPxszgTGuIj3hNs4uwBAIDy0A6GAPCzJdlJ
         XjYjNXnz4DVzqik+1G5Kmdq9MrDNEhxQQOvxc4pzLW+HjUZ4iNejQJti77t6/XoC9noa
         RHvfGZLwxpvZAn/oWCS0u0KW4Kup16DcX0PheF6ylYIb8t5PMWH1z85ZswfjGt/azYdI
         kensNrx7kHD1jG2yFKWDoH7Hskanff1RgK8AbXRBAPqN6tKKazoZ5zpyc9onzwLKnwLZ
         7+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fUIa8wNV/kngDe6PKBUlVulgIneUkp32y+R6OWHJrmM=;
        fh=V35OqsFF9JpZdA9yV6JoMMNtss4ehY+VPhoQLkwNxkQ=;
        b=OE7Aq5uCbDh5AtJUo/4gmC1Z6v10u9P1QVyDe0U4aeK0PejYaiMErmPrbCh5tFRXUN
         SmzBtgcappJubpeQQGe8ZxI+fV0Bwf/h2fM7dF10+hd3UClQXzNZqBpP8zAPl+TPKYs3
         3lb9CSFYp8LgnzHibE1YVahWWjXWA+/aeJNEBko4lS5O5uL8x35nbrOs37LFx0WoDSob
         m4aT/X+7FsROh8HJhj5gk3xSdTT9ZYdUBXu6DoF+6SkSuP6cBUJR611IkQU3JsFlAc2u
         gSk8NChDeU8aV1dlJCG8Fu1glalxOcIUpLTnkbJMEf3Qo/ewmw/QXq6ULaI6olKlSne+
         aADw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769750707; x=1770355507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fUIa8wNV/kngDe6PKBUlVulgIneUkp32y+R6OWHJrmM=;
        b=MoTqYTX3se6PMonnlqkCO+qdDbA8ioNSQo8MsnDOy7RjjZDxdYu8qW+k769tv7Q9kV
         d8ONtIF5uUUNRpDOjzbxlCzHG/6Y2858qKe4o8z6t6axYknTzKUvuDN9qk+56OZY53l5
         y4PW1Y6INGhXRixjFfztG1z70k0/SRR/Txx8M=
X-Forwarded-Encrypted: i=1; AJvYcCUmbQ42fc0aUKP6X41Utwjjsh5qCcSPGCKFoGAZNWMSCS/Lgg9GXBCB3QA+hgXeMYnTGNrc578=@vger.kernel.org
X-Received: by 2002:a17:90b:2b8e:b0:34c:c514:ee1f with SMTP id 98e67ed59e1d1-3543b310da1mr1704607a91.11.1769750706934;
        Thu, 29 Jan 2026 21:25:06 -0800 (PST)
X-Received: by 2002:a17:90b:2b8e:b0:34c:c514:ee1f with SMTP id
 98e67ed59e1d1-3543b310da1mr1704258a91.11.1769750695237; Thu, 29 Jan 2026
 21:24:55 -0800 (PST)
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
Date: Fri, 30 Jan 2026 10:54:42 +0530
X-Gm-Features: AZwV_QiA4PNVtJHMV3eMH1pvLwv6DcDT8IYvNIUdPTVFYGUsNlbibRaOe-KsTk0
Message-ID: <CALs4sv0ri0zrdM+qeRP3OZbcgBdvNTh+C8a6=VTtGTEex49W+w@mail.gmail.com>
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003f40df0649943240"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255031-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: DA76CB74C2
X-Rspamd-Action: no action

--0000000000003f40df0649943240
Content-Type: text/plain; charset="UTF-8"

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

BTW, bnxt won't support adding contexts when if is down. I could still
add the test..

>  - add a n-tuple filter to one of the context
>  - ifup
>  - check contexts and filters are there
>  - run some traffic to make sure it flows right
>
> You can probably have one shared implementation and pass a param to
> it  to tell it whether to "pre-down" the interface.
> --
> pw-bot: cr

--0000000000003f40df0649943240
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC9CcJ3
a5DuE1D2tTCx4tjkYbTDrj7TdSKXcV5K3xb98zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMzAwNTI1MDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCsp9Y4Jx5XX2OJqUGEOUEJ52Io529lmgvX9cU3g9Yy
AtD9Tawto50Bpf1XeMMBEwQSlig8RtkB7o1MVaFGwHo4XcbEW8Fam80viOVs7jyYFHH4hXLPXMUi
ugOodwHkPgXe9k/s/mexxauAE4BCyb5Nhn05pNIK2sT0jeyYFZVlWmeOswcdHBdUH+E/R7JnV2sl
AB/yibev1BtBAJOxVGvwlZzTOdsyZqF9VnU7ldQQj/HlwdEcEaYBNOlg07NwEGVCNs+NkaqtYkOU
BLBCnJxsOiDSlCtD4usHOs60NTXSo8Q2kGxCUeu0UK8COfnp6zTUPqsEmkZD8iEH7s3I0h5o
--0000000000003f40df0649943240--

