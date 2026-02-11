Return-Path: <netdev+bounces-258331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBa7E2XBjGkmswAAu9opvQ
	(envelope-from <netdev+bounces-258331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:50:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD0126B7D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D528300E3AF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6277261B92;
	Wed, 11 Feb 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NW3lLhgn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com [209.85.167.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88321256C
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832226; cv=pass; b=cHUiDPOmxfJE82vChPfM+1KCUrD/Mg7D0kkW2R3lHjZK9K+LDN6ZVaaziYMCtwA80hvNpkuLICnYvSCNOE+hD5O3/zEKpF6W6FWoTjTzu2/QsR1o18lFUUkTX9JxiM/00BJ7Cs6IZ1DYd61m1RtJcujv22zvA73BW2z4Hg2o0t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832226; c=relaxed/simple;
	bh=Pn0lFmn9WCeVJ7pOe0x/xa2TNiljPATw35KKu0Gb8hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2C6idpwgD5JTGyWoDJRQ+AYc0ExbXxZ2QeUtdynWYoOerSrCWIFsfCR5cZPYdza8CTEpI+11e4Item8pzItuA9PHluVVW4/PDKg4z4c9nEHm5vx5NRh8sdLVeQaXiugZLUrlUIZOvDBInjqgeUccNC8hdLFaQqggdoG0naQfeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NW3lLhgn; arc=pass smtp.client-ip=209.85.167.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f228.google.com with SMTP id 5614622812f47-45c733ccc32so1395644b6e.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770832224; x=1771437024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn0lFmn9WCeVJ7pOe0x/xa2TNiljPATw35KKu0Gb8hQ=;
        b=n7NjrdL1Tm/2z9tGYUy5HzFtW6ihfCxyFmrG0ntQeMvKHsu0j+1TasllQRQevA5FTJ
         IduHi6L5KYNlW+L2tbGKAK+67R0ZTIAvIj4EbKXkAIUgtQuwQSemdcBjR3L1FcE2npNY
         s7xDtp3VT/f4zz5JtQFi4+WYaPWNsL7iCSEjj2yyJ5Jb22XSahYmVCHc5EO6+XpP6Fpr
         TNwI/Cp5Om4X55N2YRbGtW9ljgm2KCDt9tvuHnEMXPuL1o+TNO4SqSRoDUGHE/WsCpzn
         73cKDCKQOoR6ag2gbcHz2dIMnQfMwQvLQY0K/Ds4AMzoZZg3SpB5kkoUO+0ACfTtGQKA
         R3TQ==
X-Forwarded-Encrypted: i=2; AJvYcCUaTJgX+wEl/JRUJPBlvnCd2BkZSIdFN0bHFc7sZ1YBJ5UivoBXH9GsiPoMx3b+NkVEJSojtcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjeVVvOg+BWAJcLCmAK+veSIw65fdaEG6xQD+Y8L6QlpVS2Nu
	6r8YFDYNoLm28ykoUnulQDHjZoufJKFNdP9SrUdRmwiz5AfQnI91uToU8I64YyxEYcDyAskepFz
	9VJ7oQdU/VC2i2VUgtaJpQBhAvfjM+jXmF6VDVNdxo8JWs7aRAmH3sXbd5aqGIaY81Q9uyyY0dB
	2hc/prs3AgrLqYJmkA8+FiyGqeTuQxtXpKk47Evh1nvti9PFATFmAb2KxII/0QCTdIAFROAS/G1
	so2TInuRfA=
X-Gm-Gg: AZuq6aIUvBV+IHIYCj0TyHuN+wxt+k9eVdq7a4UTYXJgMSPfj1NoqJLIBM36oMmQiJM
	qkp0JnzIDxymPtB0pcvy3PxoK6tfHX2SQWoa6sbtH8Hz1uVHKRDQg2PYD4R1ObWe9bSChMm9F3X
	PotMjNnT/AKs7E25zX59EFid4YCdAv6MK/fzHHLvUH7nYfCYGmsaWSiMPmuFGdmTaRgNUgD4iqu
	nml1pTswvjwPSkpR8Wg3uws197IQP5eFKm0dTq3SRPlh/sIdbyUNTn4B0BZOtJBdNxYQJNIM301
	R6BFMwma3STJd9RuogJkbTMxY8cnDLE+uhzG+Y5ZMuho0varMkhv/MO0hSStNU5BX6O1h8y00kb
	/gYMXEHd3yGOQXz4C2J14l1Ri4WIMhpA0xIn+gBMjWL+oo1o6ePW7e4qGie+tZMFpB9aGWm/jwi
	0tPzPEO9jR8S9u55yEFLGuf3eM/c4FOgFUhKf/lMcsbNQa7Me5zUISur/JlIM=
X-Received: by 2002:a05:6808:2e4f:b0:460:fa3c:31cc with SMTP id 5614622812f47-4637b8a7c0emr56506b6e.49.1770832224141;
        Wed, 11 Feb 2026 09:50:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40eaeead4casm354535fac.5.2026.02.11.09.50.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 09:50:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a92a3f5de9so14703705ad.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770832222; cv=none;
        d=google.com; s=arc-20240605;
        b=KtcsArQrKrI4o2dmXjk1HhHBptAh/Vuhp9NFO5Ez9Y12Kza5EyLkiOLqQvK8B8/w1h
         Me6/8rlxWamzP9Yr7ECqwHg1P06kETHM9AUF1qNrYR7d+n2tfJLCtrZu2TK0P/RtUF7b
         CfcuR3fBkkkHdPS8EhvuPUzvNUEGaamrVDKOyksJb2u+3JmZuaqHPPuwSFyHQYyKVNmA
         BCLNyhGALuBy6TeiE9L3GD4Hs/sgLsI6r/bl2kMp/TUXR3JwGseYrQFebTGXOGY4t6vX
         WVEUQmczWshYzAztXR0TYoOd/bU93/6vu0aXppPsASu7ylhCUzUYLipzDQSyFDAt2E1e
         awFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pn0lFmn9WCeVJ7pOe0x/xa2TNiljPATw35KKu0Gb8hQ=;
        fh=fwGP61CavBVtrAK+mVo63mWzw3+O4P9kpioJtoWVHcw=;
        b=blGFQhAyuf4OSJwrUcVxnGg4YCaiKQrrTAV+n/VViJBBhRaIaqZJRGa9LUzRkr+l6H
         3ID37U+D8OusSCTvXyK2RgA8OyEZ4u5G+uDRjDxw6QzIK2/azy1fKt93v3hgpW2D+3K8
         VAzfKb5WNnbARw2raNMNSGExZlV2wGUR16LVGdMRRgWDekF0PKEjuOdIXM9LnWkFTWXU
         cmMad5A6HMDSNAH8CibBcxn1FA5Q9rrYO47USreTBDPFWjejlJs0q8mdPqpZeA3u1uZQ
         qPxOIwC9qIsVMzoDQlbzrlxbZ8kJnQ+mcBsX492UThH9TtaYyjM9uuJlBD6ls02HzKi9
         sfSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770832222; x=1771437022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pn0lFmn9WCeVJ7pOe0x/xa2TNiljPATw35KKu0Gb8hQ=;
        b=NW3lLhgnEkPEQkkRM4DytJgeztWRUEf6k4gEmRuJM5Uy4ruf26FX6KX5hO/69xXTij
         viRWZjCISMDhV4Ak3ZRFSexYSq9/rVlqAzfn3NnUYDQJKkLR/gbG79YND1WAAw2tCHVe
         fWry9qxXnzvVl9lObY0LgWuGuj6vYdsm4ZiDk=
X-Forwarded-Encrypted: i=1; AJvYcCV6we5qdK9zk+VbJP/UjLaKIUaTgp7iUh7V1hSG52rR/JfR/v5qOTt4v55w9ZkTSExat6dK3gc=@vger.kernel.org
X-Received: by 2002:a17:902:f687:b0:2a7:d5c0:c659 with SMTP id d9443c01a7336-2a95160bfa3mr203234945ad.5.1770832222552;
        Wed, 11 Feb 2026 09:50:22 -0800 (PST)
X-Received: by 2002:a17:902:f687:b0:2a7:d5c0:c659 with SMTP id
 d9443c01a7336-2a95160bfa3mr203234775ad.5.1770832222196; Wed, 11 Feb 2026
 09:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
 <20260206052930.1882740-5-michael.chan@broadcom.com> <aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
 <CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
 <20260210174627.2360a03c@kernel.org> <CALs4sv3hca2N=+w9A81ZLMz9QCHqA7OzGFOzKGswd2sy+9zt7w@mail.gmail.com>
 <20260210201706.1da13881@kernel.org> <CALs4sv09qKxtHri6ydEh9QGAcZ=aET3ttkZue88O+X44BA-N0Q@mail.gmail.com>
 <CALs4sv3kG8kTt=VipR-=SzrLvK4ke3qj9Fe8pF=Mo3agd4X1=g@mail.gmail.com>
 <20260211083132.15b15870@kernel.org> <CALs4sv1GtqdhGLkcJC1RFbr_bi3n_Hk2A2qahhAg38hrcmRznQ@mail.gmail.com>
 <20260211085822.184f85c2@kernel.org> <CALs4sv1SQNKhxJV34w26+VLL98kK4teu0RhXEqk8xM98Q=8N4w@mail.gmail.com>
In-Reply-To: <CALs4sv1SQNKhxJV34w26+VLL98kK4teu0RhXEqk8xM98Q=8N4w@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 11 Feb 2026 23:20:09 +0530
X-Gm-Features: AZwV_Qh10hOfKSeW46E5e9lPQdgLkFMhYcMfkBJE5LgwmPvqqSp7XWfrebsqV_g
Message-ID: <CALs4sv3DGZJeDJKAcx3VXLjsLey=WzXer1xHGcX-xznOV_V8Ng@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S . Miller" <davem@davemloft.net>, Linux Netdev List <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009a1082064a900192"
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-258331-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: C4DD0126B7D
X-Rspamd-Action: no action

--0000000000009a1082064a900192
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:53=E2=80=AFPM Pavan Chebbi <pavan.chebbi@broadco=
m.com> wrote:
>
> On Wed, Feb 11, 2026 at 10:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Wed, 11 Feb 2026 22:08:39 +0530 Pavan Chebbi wrote:
> > > > > My experiments are pointing to 'self.cancel()' sometimes taking a=
 lot
> > > > > of time as part of the exec().
> > > > > I don't know but I feel the new test code itself should be OK. I =
can
> > > > > send a v3 and you can run it once too?
> > > >
> > > > Could you reply to this thread with what the version of the patch w=
here
> > > > you see defer() takes a long time? We use defer all over the place.=
.
> > >
> > > Oh it is still in my sandbox. It's after I incorporate the comments I
> > > received on the v2.
> > > You should see it in v3. Let me ask Michael to send it.
> >
> > I'm asking for the version that doesn't work / causes trouble.
>

Ok, I now get what you are asking for. I will send the reply here with
the patch soon. thanks.

> It's not in the list yet. v2, which is the latest version, does not
> use exec/defer to bring the interface back up.
>
> > Presumably that's not the version you want Michael to submit?
>
> My submission is that the test code that will come in v3 is going to
> be correct, except that sometimes I see a delay in getting the
> interface back up, specifically when I use exec() or defer() for if
> up. And I am being certain that the delay is not caused because of any
> mistake I have made in the new tests..

--0000000000009a1082064a900192
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBkFPTS
7nJhFG97wH4JFvm+LJDFNDXBTOld77HEsW/WzDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTExNzUwMjJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB4ntgMakaUPQ/QQRRVqXJ5xQmInVqaM+COCJqL1mNr
DgF7ZA7GRLzSFvVLcuZstRWv5DP1x80IOLizFjkU5PMRIkHdnXHNuwIwKfYez/8h1v8Cwb/0znAR
+aIHbyUms0zSAAZVTkqHn2AZttRJsI5VzF7Yohc4kBr3O7Xx2Qz7EnTOWK3jW6DgZE4XPoWn+zDR
MlCehpqTA1PMMx5efZy9PtJ5X4XyVOlp1aWSPDRpimiFv6vFcZVcB71/os2fhUYan9xL6PQteXIX
TBCu+ktZoZzMaaXN3SXSOjkV4Q7VcF80RgxmwVXGr2LefabW8k1pT1UFEmfjzU7nA2PBm9VM
--0000000000009a1082064a900192--

