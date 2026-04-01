Return-Path: <netdev+bounces-273884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBlFFV+gzGl8UgYAu9opvQ
	(envelope-from <netdev+bounces-273884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:34:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E5374AE9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C4273034235
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A8E318B85;
	Wed,  1 Apr 2026 04:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uav7LtzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C951D7E5C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775018076; cv=pass; b=TreQzRU8YmOfb79gcAaSNiT4a/jY1Jz/lh6qTTDdjNOeLx0oXDNk17hmHSZd5V0aNtPVcyCQHVJEqUATde36HuEdSW2LzzZBbj1OxHQmHXD462vdsLDw49kAySUkHXioHDZeidSfYMieQCqHtCwafHHYqmnRKXw4q+xfBhL2afw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775018076; c=relaxed/simple;
	bh=buuGG0Aq0nfFOsn6Pd2+7JAQ0RNyNxLEzVMe+w1Mc/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AGsjdq2MnSP/eA7zW/Orcv0JGZkKwBK/WTlU6i1t4KdRSmjwj8e4kESCIqod6k8BygI6eaF/54dYSBaOvfOyPZRLHtXNiQbP8k4FKGDxqDmQIvpGaCb8elMttWOrLLPlOMhkSawS9clujjjWtHl20qRy6i8aqBaOks81nPZxCZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uav7LtzT; arc=pass smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-67de15e8452so358794eaf.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775018074; x=1775622874;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCxdJZYBBGWT2A6B8c4WGrVGt6wI3ZvmK54iR5jpDp4=;
        b=p1hYB3qRGeA6Pa7mwYqPgEX785ZbHvxRnJlzcZ9TaXh8w8Kr+YlNxr+tYdFH19yGkF
         sfIHjhyvo7Pe8jcMdXo7yM1cJYLa2l7BUuIGvFXKp7s3FjgaoYrqjsNohnvYMt4mDvCu
         W2234EMxKW/ICMMcxHhpaGxg2I3Z6MljmUcT8RBE5ZTewxw7ttudwqhP/Y4Zy2ZE+tZK
         CQ6H1zIcrO7ZcFu3o1VhL0hzPxilKkvtk2Dc7XOLA+PKpi3m+Hkzf/kQELqU1ogp5jI1
         Bx2jXlQ6+X413G/LgIlEnfpFvaYeBKpCEi7oQ8A0I2N+OgCqDvaAUSGpRSkl+VpC4bIa
         0WIA==
X-Forwarded-Encrypted: i=2; AJvYcCWwIWCPLVTvanpHOabyLFQKJtplOb6aDsrWDJmta+Y9xXUW+KAzlZTcLCotXHtlwIsW65SuFZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3P8u2a2DlNJxTpyI3aZVMfsv+9mgiyHquCIK4WWqAkU/iSw2J
	R4I/vxD91R7kYLdXu4mqqQSKJD+Vxbi3NZgDjVZeSiMc7PCHe86P5aucAwFImKfWlvWi4ypAgLf
	OjtBORc71ULHYW21QTYmbcdFQJQhU32dJZ6znKEr5igvjzTulLJKhpL+AttMs2Jv9d3NAa38yHB
	KzCPx+t7H4EdZUSmOWE4JWVQdGfv8zLVCW4mQAjTv2GZGhwWvhCJKxvLSMz1v6RRIoCxiDcD3hj
	LFlJ0ZCQhk=
X-Gm-Gg: ATEYQzyCXqfj1/eXLfLDULGvE02pYZ5fw98OHdF9KlWK3dmqXjtNqwVVLfytmQL5Q3I
	4V8miKWJMLhKDfhr8L+0xPQZ8em9hnps6K6RRhuUm+/NVGu/khnx1yz5JacjcsTlhsYcoFWLMG9
	LlsBzpdoglL3O9OosTDofxdAsNZe5AtTMG4jYdF59lhT4RnsWkimyvNxLyZLYt9GZt2s6d8/MLb
	RTP/JQfh4qXtzbU/0XGp96PXUrdIqbT017yhJv7AC06s0yWo4bjCU+hmJzm5fnNG0BrWln5KjQ8
	0U6wrFjRETu4NGISEt2Ek2tuey1LeCyysRLYjPpUuqoci3+NRV7Jub2VtGspO8CF1g1TZmAHt9T
	IFXlDpQnhuqA2q3KFUu47Ct1ZdGdMN7UHSQt17p4qZggb+GGXQXHn0Vr1Jm56WZ6lcY0ksQ3zk3
	fx3G6Y/kPgYiETtGd513lGsIXXIVsbsrfxSON5s2RR10unFyH5bkuDDuK1sfY=
X-Received: by 2002:a05:6820:3006:b0:67f:ecf8:8fbc with SMTP id 006d021491bc7-67fecf89d99mr35709eaf.34.1775018074075;
        Tue, 31 Mar 2026 21:34:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-67fad259794sm46811eaf.12.2026.03.31.21.34.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 21:34:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so381813b3a.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775018072; cv=none;
        d=google.com; s=arc-20240605;
        b=Ff2ITSd2HLuHC/iFGEKvinPoB0ZhSRK+xWNDrxveyFg1238WfBCrh5GeiuZXIvTl9C
         AA5x8nwREhaMubvvKlpbLZx7ISlGoMkE2jIvd4akPIQtr3AzSJRrH1oW5EBC3OVcTLim
         Mq5Qm1tEwo+xgwQCfKpAZpBq0xX3WlxCKi6euyBPM3tH0wcRJoVE6HvJW8uJHp50dGUv
         IKD4CeyNVTf09ZE+x3vrFhCHpSaeyBA8n6yTHW9HKWBq1lrPe0s2YVRGWlcMDEqO3u+f
         T0BsCXCN/1HA/U0vPiglyHYj8o9Ji9SF3FqrmJsu4Sgx1a5pVUQd996Qsvvd+FsN3sTN
         bVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=bCxdJZYBBGWT2A6B8c4WGrVGt6wI3ZvmK54iR5jpDp4=;
        fh=nNndI+eIuJO4ZvvR2mlLQfNcZSiGq+9U6m+R3pTh2ww=;
        b=Fa42vHhrjgLBO+azheY1H0HtUt3J3J/Ydx7/eITq5WNrgK4whBcCYq6Zdz/1V3gmKb
         854A1KoAb+oeua9tmNHt6DXttxaHF4ZLOTNWoQWoDLp/qRxKpiICtfov+p7hLLznDClX
         eL9a8z+mzUuS/xMkkO+SCbGWCkup/ZYMNSm9XA2fCIdahrA1TWi2lsLeUKA6iCXbwTuB
         wEGVAydRpW1JyMFy3ib2YNbxO0TXlYZucEBhyUn2ZgEWasdQoekQelZXIOB1hvCBOCz4
         i4rXkVVKdaaix8huoY0HyCbhH7+Z3THdL7CW54clndB8NEgI4XteGkDHcbE3ZxIgsTY7
         u8XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775018072; x=1775622872; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCxdJZYBBGWT2A6B8c4WGrVGt6wI3ZvmK54iR5jpDp4=;
        b=Uav7LtzTKOyhi1R7oSc5Zpy2xLZf2HHv11cWCA7k7HVefjqd1WP5rwARDFzsin7u0X
         IO3CzaHqGUY0IT7b0QkDl26yWDGzi03CnkJyte/ed13IrvvdDSoLiQGkaQLLT89DcgLx
         ZZXVNRUBJXlEkAX2gYqL1Jk1Nnfv6qHXIIqVY=
X-Forwarded-Encrypted: i=1; AJvYcCXPZ56T5JYVIdikJb00WFMZhsZJnIJzKt1prIDQly23RJ+Q7a4DfCHpJ2KcvrPMrNRabZlYXOM=@vger.kernel.org
X-Received: by 2002:a05:6a00:3388:b0:829:7b30:92f4 with SMTP id d2e1a72fcca58-82ceaa56d25mr1741366b3a.16.1775018072122;
        Tue, 31 Mar 2026 21:34:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:3388:b0:829:7b30:92f4 with SMTP id
 d2e1a72fcca58-82ceaa56d25mr1741341b3a.16.1775018071612; Tue, 31 Mar 2026
 21:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326235238.2940471-1-joe@dama.to> <20260326235238.2940471-9-joe@dama.to>
 <20260329152016.27646fab@kernel.org> <acqqjfzDK04j2APz@devvm20253.cco0.facebook.com>
 <20260330165357.31a30b68@kernel.org> <acw4hWuS4xt/bCwJ@devvm20253.cco0.facebook.com>
In-Reply-To: <acw4hWuS4xt/bCwJ@devvm20253.cco0.facebook.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 1 Apr 2026 10:04:19 +0530
X-Gm-Features: AQROBzCiT1ygMyd-FOmzIAMBZTps0zdG3snCsuVPw_LaR11MDR_g7t779nlj51A
Message-ID: <CALs4sv2puSGkQMJMr_VHaEJQVEU0APptZYSBUWLOp7eMkhJiLg@mail.gmail.com>
Subject: Re: [net-next v6 08/12] net: bnxt: Implement software USO
To: Joe Damato <joe@dama.to>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	horms@kernel.org, pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, 
	leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ae1087064e5e9911"
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273884-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: E68E5374AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000ae1087064e5e9911
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:41=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Mon, Mar 30, 2026 at 04:53:57PM -0700, Jakub Kicinski wrote:
> > On Mon, 30 Mar 2026 09:53:33 -0700 Joe Damato wrote:
> > > > > +                                  bp->tx_wake_thresh);
> > > >
> > > > Is tx_wake_thresh larger than the max USO even for smallest ring si=
ze?
> > >
> > > Yes, it is.
> > >
> > > Maybe its worth adding a comment in the code somewhere to make
> > > this more clear? Not sure where would be an appropriate place, but ma=
ybe
> > > bnxt_init_tx_rings?
> >
> > Hm, as long as BNXT_MIN_TX_DESC_CNT is updated I don't think we need
> > any bespoke comments
>
> I am hesitant to update BNXT_MIN_TX_DESC_CNT because it affects all hardw=
are,
> including devices that do USO in hardware.
>
> It may not matter in practice since I would be bumping it from 19 to 210,=
 but
> we could just leave it as is and let fix_features and init_tx_rings deal =
with
> ring size (as they do now).
>
> IDK. Feels "safer" (but maybe less clear) to leave it as is. WDYT?

To me also, having a helper (like you showed in the next patch)
determine the min tx bds for use of the feature is better than
altering the entire default behaviour.

--000000000000ae1087064e5e9911
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA5+MgN
rTE7REfd7eliL+fjvQaa0921p9MXMh2rKMG79jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MDEwNDM0MzJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCNu3IrWvb0K7fhNekkTjb4DKNBVA53P+BpHgXn40Ne
SWwgKVeBosYR4ZLUqqN1rv52i7XMxzM8lZTMd/FxPgFcpK7P50v+Aary5NMOpP4XAZQuAINSTPsO
0bDU7ax5o+JmdRiIiQqczcJJlHSBHLQFxdDNZomI39V+occYfoL5FQwwjaL59dkr8OkmIrsaOB/V
/iEdqVg/p7YablZiRpgBhbMjto1pqhpHk+0gNzntlECGH6+WQZ4xuV3SE7Q17jfE80XWQnvhYa6d
ierYjWWhiz6y8eftH+hFTSjh8hOxRm1Nsr1LqfKYiBzbknk/80tBLVaDsYJtChs6fKYE5ksU
--000000000000ae1087064e5e9911--

