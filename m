Return-Path: <netdev+bounces-258311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFFNG92wjGkvsQAAu9opvQ
	(envelope-from <netdev+bounces-258311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:39:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E2F1263AC
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A556F30495C2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377834321F;
	Wed, 11 Feb 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zf15raRP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FC341056
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827936; cv=pass; b=XnrdHEd1D9/Reik+2ZA9eIfaD6Q94u2Tr98kwM58swFtuqhZ3FHNkgTsWfDBcFOB7MJ6M11s97CEWecVwV0y8Ol0kNe08nX1Z55ilOOnaWqGLNrsj9GPzEjV4ZK2Bxp3BKvzi+zqyO580P75KNOsoKrIDJYYV6g8G56Ky4aeZdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827936; c=relaxed/simple;
	bh=WjbA5GtdJ67N51IoMiXXHImx4lj73yHPOb55bTm68do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctom4VP55Li/p49mxLbv66TSMsOssIJWTylzOqyqthtNDyaCztYdEhyZk2/V7vBO1Z146Qts0bl0j/5YusKCOT86KNG3qLN4T+ISagORhYIJHdrEYMjSHhILknjImfz0kRRhF8nYJJRpf4d2f4poAGe2DXxmMO6PF33OUy0Lpm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zf15raRP; arc=pass smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2ba895adfeaso2210127eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827934; x=1771432734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjbA5GtdJ67N51IoMiXXHImx4lj73yHPOb55bTm68do=;
        b=F3aREm9LjIYlH1nguo2Qxea0e1U+rKK3NGqm+ZZQMSsue/8Qh6LtNcVDs69hRfQubo
         D/oFvN1Wwa3u7u5I6zw9FXqvvM8OU/y94vgyeEK0g8ph5TgnvDXKsV2ICB+j6w6WjjbE
         BfWQyXdYkMnImwikENWgALr3apLiT3qSwHNCRigBHEV3PUrn1PKGmC0lvcDKeq0NTkwJ
         BXiSJOht9Pwq6jDddDzlimDfyoK/sCTjiLT122eUgcfhp6bBKHjjvANxxjUR0c5l9m7k
         //55977mWNLUbFZjek9vHnoA57r0B2GJEWaezaLKQcXSU9pV2PEiWsoEWyKAsNJYr133
         yfGA==
X-Forwarded-Encrypted: i=2; AJvYcCVr8152gImRaQpemvcO1ltU0Cyuo0wJ4+N3hFKPQYM539Pw8+z7j43RZDYppny2qDJ/zWzFmAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCYRwsN8MFHXFkZESFxOlZX10gZTA+u+SuHokHziHwt2le4wPs
	qrVDcLdvsu0rGk6Eb3FzBTx5cuuNWBz+//Pp7gUfQq64gTZF31S+hqbS2fsQaSniyNNhZYj/53W
	xh+qV09o9o+hlwSn7z1bemZNU02EKqfpPXAyMq1lhoHkw0WW6x9cTnDVSdZnfoBlA8rFaHiT3Xm
	6JsnpYshTLNgPoNakaJezkgnalO5i0i4EYE0gzDXBzes5F1R2iw/Edzxpnsme4ky2O8dMGMKMtE
	dGqBYv93EQ=
X-Gm-Gg: AZuq6aIfxCjTuafSsFq7Prh/npzId9Q0vdRoRIvyz+tRyXpJz/3RvAecwMA473nToAb
	JDZjNVFcqDA4Kjq8piOMAOCxyIDRBOY0tgfLgwD9Lvifg9k2kK/x7PtwJ3Yha3T9Vo3gV0gW+Jc
	/1p6sOEBmQQHoUDG00vcsEP90EBiZsMa4zjpYDWKZaAyGU1x9+Tlahf3AlvmY79Q3qiThNuJEqF
	cvnUKq9kCk+UNwnnKsg7IxpFJq56poJ1uWWnkbNp+ESt/5UjFMUgWGDWcvqo5mOnytmx7V4TDHh
	zQLtnV+nnjJqAIL4Y2qo5dwPSBPfqFd9/XnvuWyD5SAXZS1KFr4MJzzNxIrkSBFnZbLZ/cn2oLx
	jekuCMyWaJ78Ptdw9Ka7ECCCAha/CuOn2Ltp5BkZwBdqcC9aTxRrWIm8rxQZXNlkv5r2jUtg6Kd
	oLKm3wXZQ2USYphvjwzLHdXBa26jxWHEBcre0zqZUzW3KZlUaLoN6cWymUsSw=
X-Received: by 2002:a05:693c:2c8d:b0:2ba:8018:cc65 with SMTP id 5a478bee46e88-2ba8018dec5mr3604923eec.18.1770827933645;
        Wed, 11 Feb 2026 08:38:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ba9dcfdddcsm192856eec.6.2026.02.11.08.38.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 08:38:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3561f5bd22eso1836482a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770827932; cv=none;
        d=google.com; s=arc-20240605;
        b=PxnLZtmMo+o2ns05ySr66ZUKJa9XaSKPDt889xc+LtWYjnVEkHKg5GNom4puVrdL7+
         TwfSdmR6fCe7Vq/d7Uo2UAzIQvIneT3HPpxwp0gKIXBJb/9S7+NztZHbxLJHPrtKwxQF
         mGF6lsmWevnnX8T7uDMxwsefCj3BEb91KQHUlfHe0E84hfptsCVD6IgL10viwnrAZotO
         Wyc1f7MvxdCTZxCFUySnopK/dvF1or4NKswuTeOIl941E1fHfqoVghd2Hq67EzPFOfrB
         hx29SU40TdNE/xq1JJcm7UoAsleWhYQhgldkBEfoEJXA6oLPnm39jue3GtRImebvpmjW
         BLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WjbA5GtdJ67N51IoMiXXHImx4lj73yHPOb55bTm68do=;
        fh=vOePlJTZkUrfVo6fgxjoYk+Fu+WvzCpoq7yno9xUOtM=;
        b=g9R+vqHIBOSfarn9xDqXgQjOFTNiwBWYX8Iop910IOcg0pIXKBlGpnyuzYR6Qir7BF
         OAcd4VR7H5gcSNkfChzZIjsupA5HYXG4/2hYSSB2o//Pot+a29W9vaKvuGaFv6rYQ+FZ
         1wq4gPCzxc9Sa83nM2NnY6ftavRX/VdD7QUPhyd1QhZWjrI58IVn7mvX1C63vBD05Kv4
         BbQaTG3CFAFPFymcT+R68PVmwWst4m9npHZYG+vvXUwIhHN8p9x3iq2iV7IsEdM8Dwbd
         6QipgAmrOPdDozzHWVofPuVbrK83UEfUTp37ZZfgTD+24D46pJoCWhpGKNLaItDkOCRl
         IQIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770827932; x=1771432732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WjbA5GtdJ67N51IoMiXXHImx4lj73yHPOb55bTm68do=;
        b=Zf15raRP7Dt3gnqvyRDJIXRb7XXXQBXFMVZPL2oReeCB89gURNHmjpINY6IGAajC8Y
         tsNj1uNTEsG5DgkXzrn5jVGk5RSWVibBTZFT5wCPwvNff+2yQO8l7eN2w7khrHVdSDBF
         2XksPNvamPRNzrkwFWaCIjHGwiVgKORnK9K1o=
X-Forwarded-Encrypted: i=1; AJvYcCVUn1slEAhiXwWqn9vl07X/e1MXntU0z9qlzxJH2+5pHmV2m5pCe8P31pJCMJ/hSFHkdtbbjPA=@vger.kernel.org
X-Received: by 2002:a17:90b:6c8:b0:356:2872:9c50 with SMTP id 98e67ed59e1d1-35628729fb0mr11363778a91.35.1770827931849;
        Wed, 11 Feb 2026 08:38:51 -0800 (PST)
X-Received: by 2002:a17:90b:6c8:b0:356:2872:9c50 with SMTP id
 98e67ed59e1d1-35628729fb0mr11363761a91.35.1770827931416; Wed, 11 Feb 2026
 08:38:51 -0800 (PST)
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
 <CALs4sv3kG8kTt=VipR-=SzrLvK4ke3qj9Fe8pF=Mo3agd4X1=g@mail.gmail.com> <20260211083132.15b15870@kernel.org>
In-Reply-To: <20260211083132.15b15870@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 11 Feb 2026 22:08:39 +0530
X-Gm-Features: AZwV_Qj0hbdWRCWjxJPXJS2Zyi-3d9TLmJtoAjzL2EJi9xPCNqjRZ7Y2_nT9JGk
Message-ID: <CALs4sv1GtqdhGLkcJC1RFbr_bi3n_Hk2A2qahhAg38hrcmRznQ@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S . Miller" <davem@davemloft.net>, Linux Netdev List <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dbe18b064a8f01d5"
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
	TAGGED_FROM(0.00)[bounces-258311-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D4E2F1263AC
X-Rspamd-Action: no action

--000000000000dbe18b064a8f01d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 11 Feb 2026 13:29:06 +0530 Pavan Chebbi wrote:
> > > > If you check the carrier manually in a second terminal while it's
> > > > running -- do you see it go to 1? The helper keeps the file open
> > >
> > > Thanks for the nudge. I think I get the real issue now. It's not the
> > > cmd() but ifup.exec()
> > > I am using :
> > > ifup =3D defer(ip, f"link set dev {cfg.ifname} up")
> > > and later
> > > ifup.exec()
> > >
> > > I see that exec() takes unusually long time for carrier to go to 1.
> > > Upto 20s and sometimes still fails.
> > > Same with both direct exec or deferred. And this explains why I canno=
t
> > > ping for long time after suite exists. Thats because I rely on defer(=
)
> > > to bring the interface up after bnxt exits with carrier 0 for the
> > > second test.
> > > If replace the exec with direct call to ip(f"link set dev {cfg.ifname=
}
> > > up") I see it works reliably.
> >
> > My experiments are pointing to 'self.cancel()' sometimes taking a lot
> > of time as part of the exec().
> > I don't know but I feel the new test code itself should be OK. I can
> > send a v3 and you can run it once too?
>
> Could you reply to this thread with what the version of the patch where
> you see defer() takes a long time? We use defer all over the place..

Oh it is still in my sandbox. It's after I incorporate the comments I
received on the v2.
You should see it in v3. Let me ask Michael to send it.

--000000000000dbe18b064a8f01d5
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAA+GbK
9HG5BkRrDn3fwfN1CIkGAVNkcJ/jbhS1WCfs8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTExNjM4NTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAOTvHRNPpEr27H+AFmElyQvOQU6iyz+S4JaczyGzY8
obU8UxjA/3O4VmQJVrir6xKVdQmWHmPxs5ls15KWp4d3XrzY0CfVwcpDPVK1IAgCNN8MV7CuyHK4
oF7Jz9AI4u1VbDCwCoIzlYpR6y2E7sY0+503T1vy75AhagjFvRl+IhdfMmsxoNIfXaaMNGLzOVac
BEqM/jDoETZxtixC9shwy3fh1wcUuKZjVQa/Vnp1vlFwYGG3VdwF0TQU6zJLBRHxguiOsyvdqEEZ
PyZV4aIivJEfzKu9FX/1CBCgsNF4gekajfA78qh9BYKsGCWnJPo1XSJv26JhPMbIuOrBJ6T4
--000000000000dbe18b064a8f01d5--

