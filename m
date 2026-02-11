Return-Path: <netdev+bounces-258327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPIgOxy7jGlgsgAAu9opvQ
	(envelope-from <netdev+bounces-258327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:23:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15812692A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2E483010D9E
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C23212550;
	Wed, 11 Feb 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aIX2fesM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E051DF74F
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830618; cv=pass; b=jsNCzEE9yJc9C8/rS1PYv/hn7FM1pXlQHvmms5fqeMZl/NWg60Fz8T1eOohvLaNZg51M1wXDM39KDObUgzXxWq0lOnWbUrcpa5wI4hvrmKHjWPjSVJwybrwtf79IgCf3xzIOOr4GQ93jZI7HNN/ZL72tRYvV5zpH39Y2n8/ji1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830618; c=relaxed/simple;
	bh=hszNxm5xY2wz8UaYosE2R0qGs1GAMQmijtDF7T73km0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXRzhmtKyUkfYi98xdrIr9SeRX7fMifAIuCUJaoiz7uc6AePHiqF/rM+8PDmqsSeeiWJSyww06JsZFO/daky4T+tgyGC0z+Ozl1iK1kIuRCgRJmXUGsgCLUsbdcIoZ7iYZZTY+x44Gw1DAFW944XY0AMyfe/eHtNBhPt9NZ+IFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aIX2fesM; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2aaed195901so17913715ad.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770830617; x=1771435417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hszNxm5xY2wz8UaYosE2R0qGs1GAMQmijtDF7T73km0=;
        b=h01JuCTjyKCRqPwZsxjzUR7k2s+6STZppLAufCjhG+0yww/OuFJSanGd8c2CNqYwhX
         3vLZf+BZhwJ7c51RpdHTYilIprLeLgiHbRbGYK8seEkfgLL+F25I8pHjhO7z+sHUqd5d
         8bQzj+sSVXVjG1+DEkkFEm4Kqwz1pHf/lXvkSFfZwnSelDn1agQj3DQT21iaHPVohjy6
         YrilPNoEUHoFeR1hMEiUlzcFkC0DlFezaiXdBwFQ1nroNnlfcAMtx4pgVIz/4oQgLyXc
         mNu14Cc3ZcIG5uyPmlfS04dSE+SHSageJXkRdV5kaRc0AF/CafzmQ6znCk+zckK5oqp5
         YqiQ==
X-Forwarded-Encrypted: i=2; AJvYcCU7U4YRbRYjpFYN+RTxOVk2itr0ySor2/HwGAmYt82OMzrdpbgxKKOvY715hdDN4ctBBRWcdNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaur0LDAS3ZMtEI3XcD8kukXJr2fUvdrrI804zsCec6k8rEh9W
	3Kt2MIwNMJ5v9AgQb64f464qwEw1hOXebcHmyUlcWA1Bf9ZtZZ+q+3gBkOnTBBwQeDuML4hqpbn
	ejQ67bOofvVd03b4zMdh5n13hoBsZc9Rvj8u8HNVVREUTMhe4/E8gaXBUA4nX5gWKv0gliEHx7U
	dPH/9vE0mkpZe1ubaFKIRL9hXziV9p8W67URuITTYQ4mUkFZM0ETj24E2df7+LMp70rmxN2sOWd
	96APkbp8wg=
X-Gm-Gg: AZuq6aLm85nRfMBN+selbUKg9vgY6fM46k0ThBksxVUGg0KS0VR7XXcfw/peDgq5pkB
	Yb11WBFfG8+FXGl0KOfYm/QvEgCCdzRd4a62i23U9peDG79E34hz8krkWirs1+ragreBbJbnrT1
	MrUNoPoeDInCYhzmlNrxHJGZ2bTZ++ODLMKh9krO1X0HOpvzEu7QWXzoZ1FznhncK5uhIAZFK+t
	wmOz94DAeNW05vDBdXji0jJYnboYny3rkYAYL7HHAxOfLjiypK2QSEh5LGbm5Ls0dLGe/fv8+ex
	VoxSR7H/GqgDHuUgfvQd5D91sTp2hA1VovFpn+lwaZtOBCnMRE4evpHIcbgj6X8iU+jIrnvWJZH
	99nrDTw4VAUUyaVcSZ9+aNmUVqGA1XjXTK/Uz5lyNh4Ns92LfKeUeCRqUHRVx35xp44IoKdJ0U6
	iYIBI2LGlkKYoepxwyDrLEGxBrfP0omYM8JFftFasiAgA+OmhFe6kMwg==
X-Received: by 2002:a17:903:1ad0:b0:2aa:de7e:efae with SMTP id d9443c01a7336-2ab10c5842emr67360415ad.53.1770830616570;
        Wed, 11 Feb 2026 09:23:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ab299b00a4sm2967655ad.37.2026.02.11.09.23.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 09:23:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3562171b56dso4893352a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770830615; cv=none;
        d=google.com; s=arc-20240605;
        b=EBUTc36TbJT1IQa6tpA7NY7XEa6w43Lwt28YedMeq9P2nbxqkoAPObnHrIWkRfd4SS
         eB34cNgVIz3F78wX+48+7mXW8+ykolW3jxBQVUCTwB4b5NnUJu2QDPfz38d+2JqiJgqk
         +eu9Cu00TufR4eN4Iacrz2I0ADBTvp/WFIhn/HvN09V4e9hO1fTNlfICTDDGL0akEUiH
         ahsfjG7ztW+Fvp9fieTVJCPiZhAebTmXNMuZIj7sTGHzey5AEkz1sX3XtwmAWu0IHokv
         Q/tju+535qbY8sxN8fnFlfHfcnEPU8SOZpi8z9Vu1mg61J55kUoBBhg57QPpswbb4dxt
         kkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hszNxm5xY2wz8UaYosE2R0qGs1GAMQmijtDF7T73km0=;
        fh=IidZhzbJJBt8qMct+7Ms0vCiQ9jeSpLylUCTTfzfrRA=;
        b=AFQIbVFISlYGVGxIDhmpsnQNBI9V6Cmdkt7hyaP1ETU03zCc2Z1I7iAGiJr3N85SUL
         B+Kgemw2JsgrUDnrEuLPAd9YcauBZIZIufLVXZzNt72C4+4anpQuheuF5cbyb2niGab7
         u04DNbakMqqrGRwvq96quAC/qBn/9sOje+Jf5AXhAYotzVub7AhvTMnEToYjED/yjFXd
         DbQRxXzQM/ro8hB9BsDM6ZhtgkjBD1EWKTcmJbIlyBWWOiriq5QHBuxRE/gPnehoqgPH
         OtSN6EoeHq9p9ZgqiKCSbKiIQUOM/bN6F0jBagHtFZGBcwTJdhEwg3vUG4WRqybdgQqe
         4hkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770830615; x=1771435415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hszNxm5xY2wz8UaYosE2R0qGs1GAMQmijtDF7T73km0=;
        b=aIX2fesMZf2QbXZ8sCvfDSJWk5puogzLOtrcPxLxPhKeAcqhfb/O4yGfv8ZyJTkNvo
         +wLVA12/eYgZIXUX82v9kToSlV0zWi1EHIobGCNc9TvIMkBH3Kv9OuP6RhH/rDMg/pLm
         Y01qVaSsxkSvH4Zk6mPxTNcEM9tQFHWe+o7OU=
X-Forwarded-Encrypted: i=1; AJvYcCWGX3ZVHQLvqTl+RVGkq8Tn+ZCzgmeb6D144gmfNS74N0Vu+TtLr4Oj2dRIsbH2ywfIEtjJThQ=@vger.kernel.org
X-Received: by 2002:a17:90b:3845:b0:356:1edc:b31 with SMTP id 98e67ed59e1d1-3568f3deb20mr129598a91.20.1770830614773;
        Wed, 11 Feb 2026 09:23:34 -0800 (PST)
X-Received: by 2002:a17:90b:3845:b0:356:1edc:b31 with SMTP id
 98e67ed59e1d1-3568f3deb20mr129581a91.20.1770830614337; Wed, 11 Feb 2026
 09:23:34 -0800 (PST)
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
 <20260211085822.184f85c2@kernel.org>
In-Reply-To: <20260211085822.184f85c2@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 11 Feb 2026 22:53:18 +0530
X-Gm-Features: AZwV_Qgqf89LeWcSKxQuwwrT8yeW8_xi8q2c-v9upaIjn_0mAAmfF5B07pbHGXw
Message-ID: <CALs4sv1SQNKhxJV34w26+VLL98kK4teu0RhXEqk8xM98Q=8N4w@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S . Miller" <davem@davemloft.net>, Linux Netdev List <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c5d8e1064a8fa175"
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
	TAGGED_FROM(0.00)[bounces-258327-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E15812692A
X-Rspamd-Action: no action

--000000000000c5d8e1064a8fa175
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 11 Feb 2026 22:08:39 +0530 Pavan Chebbi wrote:
> > > > My experiments are pointing to 'self.cancel()' sometimes taking a l=
ot
> > > > of time as part of the exec().
> > > > I don't know but I feel the new test code itself should be OK. I ca=
n
> > > > send a v3 and you can run it once too?
> > >
> > > Could you reply to this thread with what the version of the patch whe=
re
> > > you see defer() takes a long time? We use defer all over the place..
> >
> > Oh it is still in my sandbox. It's after I incorporate the comments I
> > received on the v2.
> > You should see it in v3. Let me ask Michael to send it.
>
> I'm asking for the version that doesn't work / causes trouble.

It's not in the list yet. v2, which is the latest version, does not
use exec/defer to bring the interface back up.

> Presumably that's not the version you want Michael to submit?

My submission is that the test code that will come in v3 is going to
be correct, except that sometimes I see a delay in getting the
interface back up, specifically when I use exec() or defer() for if
up. And I am being certain that the delay is not caused because of any
mistake I have made in the new tests..

--000000000000c5d8e1064a8fa175
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBQPqUZ
8p7xnih7WNCRUoyee09vLjdNeJTslPZ8ggULbTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTExNzIzMzVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCW0nDK87mPsbu5h2y/p4xaXBTsGgcZqOB/4zkwF8JD
esxhN8LUXO4XFsO2v+Y4uLgNIhokUDfDOSVzynd4fSZZ1NXPJP//+ZcB9uOKFEzMYq5QAlwZ/lRA
A6/+FJz9BHESYGpLZGq/2N4daO0krjXgXIlsV263DG6vM2LGRD1visDJ/jJxa8Egt7h5l+Ub9m1j
7qAYWPucfMCZtIYC3vOxZYZqYoQ0UYqvcbdEw1MNHMLTlSktEhxGTZSEzuau65K9lhHdR05LBPAL
XxvNyN6berB0cAxSXh5RyL/jAnytZgZKed/XOnuLN9gwwqVXHkJe8J53o05sfAjv2d/kj9eN
--000000000000c5d8e1064a8fa175--

