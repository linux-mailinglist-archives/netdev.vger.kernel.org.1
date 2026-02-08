Return-Path: <netdev+bounces-257851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yORfB1O5iGnLvAQAu9opvQ
	(envelope-from <netdev+bounces-257851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:26:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2851096EC
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6715C30088A3
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636335A92B;
	Sun,  8 Feb 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WY3ZSOmR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE647264619
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770568016; cv=pass; b=h9aTg0MNdIs/+I5msJWhbhVHbEtbNJPmd91iW5LuuuqUbiImByWdHRO3v4VtCG3KDYgh8LFbpMeCQwInUMUY2gxiabek3Zbsr7N/rJoRUY/JcnoYK899QL11LDi5tk4fF2G6cUTo3VtihQ9cExOCZN/23ffFx4cfqJAi/Sjhnkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770568016; c=relaxed/simple;
	bh=xN8xnuN9/K6Ucv9eZ3/nMCH6osS2Vomj5ArOp+A5CDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftu/QmXY1E5VyrFqXfYklEVh17Uwzxesb91tOfqjHQTajQ52swqD88PnF3MPbGQfrIHqc1lUQSMzKd2VStgL3TBEj8KM5Y3JcK0Pb04GRnZj9fCruuX1RBn2YBQXUyZ2ktdFF3FqDd6zSNGF0tkMqst/XcfrMt/CGIBkYtVjuXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WY3ZSOmR; arc=pass smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-66a4780b4abso682907eaf.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 08:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770568014; x=1771172814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYEC9rYsC5nKei4OOj8ijdr3SmYANZ5C0QeGEAfdNk8=;
        b=dSxttUxCSMwN8e5eO2qmw43ORXORFA3fgFGI8MVwt9i4ZelELl5NzhSbvsJ8vxSJnj
         QCGG4co78SF2sfsAdKmKfraw0CqCyQ0YLAqSoIfUbmlRtgHgm6hiNFEonNjYXREiWe7V
         J/dd4MkvRiMvpdliedEvkkCcWAZ+rxMOZ3UMrCQeKUS5/EW+tB28FoO3O77/tzMgT2Ia
         DPBwn7wTLliq/D+dgnA2g4/DwfecNJnWSJLXX8HaATf6IvbrKDQCvRNX8ywyIpA5ExML
         WUmg8JD6Tb9KeNAJ+Vk9xygcI1Oq/dR9VvVIOAeRJdFe3jKJ2on3a6GyqV3nQtPG6yIz
         bf0g==
X-Forwarded-Encrypted: i=2; AJvYcCWQMHMY/Hmh5Gy2VQneO0tZ2E1mGo7Yzn81IS7cYplsRb9hu+3FxGp/lhqRhyFujF6aY0tbv+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOiYNjyCWlJTmg1YhPkQm/7j6uWHhQ0ZwPQqAWi3l17Lt/YCL
	PLbbBuRBobICKmAn7RdDoVlkVzSzj2gO+k7+Z/Ffo6n8NJ3qCnubQ9HUPIhrvuQPR/rmUtbZmke
	o3HwaoJ75z6qPNVQEyRWLeoyghZOx3luWYFrbmPivwbq0F61wNHvTrIJSuwZdR995n7a7Fw5pFw
	I4RXOYzuG3p+/F/ueVdtx+K9qPylYoMoOR+2xWeKCR5UVXbpu2P3LZ64b59ypwAjuGUfC/P0fzW
	ee7H8cOGos=
X-Gm-Gg: AZuq6aKKm5OHJJJa8t+MhAMcfGGb4c8RcjCjrDeFb/tqXesfdK87BTXmETCAbrafnWh
	pwRFPKvmo/yUrQOOmwXzzPiSQnoFaAchV0wm2hbwnOBFyo+ob9zlSu7fZ3hvqdPbQ7wuiW5OEd4
	CLJtSNBrLxRtw7YrJTG7EjAZa4EJ9D4rT8LIgHHif1/orTEaMcD1sXSCglNOIymUIz5MNIkllaY
	PRXisUTNzn8M7kl91MFeLBsnas/LqfAKW9pRFHPYQosLy5vmQJkYWsl2X2sHeH1glHHIUMge371
	dOn9eA6WmCYQsUZpwsNoWLaP8Ao9WIHLx1P1OMhGmn/ODjJqZOLCX75NpClqQILpDJs+MGic0JW
	08HNOejy/99gJQz5HJTnDYrnl6OCCL01swmk2joyfNEsXZnIfsIQZT1KSWj+xoisVvNJ4xbXwqk
	BoyTfRG7ZbVAClo+WuAIQGRBCkux2Dgcl1bnuwQ0BAfm437Rs=
X-Received: by 2002:a05:6820:f00e:b0:662:fa52:9331 with SMTP id 006d021491bc7-66d0a477d01mr3804558eaf.26.1770568014422;
        Sun, 08 Feb 2026 08:26:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40a996412c8sm1205710fac.12.2026.02.08.08.26.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2026 08:26:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aae0d40a47so18756255ad.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 08:26:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770568013; cv=none;
        d=google.com; s=arc-20240605;
        b=QHtl9OUprhEYf9JzsJQjktTOMFxU2ZhJ76eoZjd0J2FAxCIn9Mu6CxqGvrtz0/Rqh5
         MMR93lKII65Pqeo1/kxqE1zoe6g9UtesF8HBpCI1fpWoxC+UGCt2yrhyJDi/MPhCoExg
         1rimS2s56rSIV2rrGk3o7QSaOmeutxL73rDgYdvZ1rkDluWnhahabDAp+Q1Uz98RpEe8
         508ZcbwHgzn8ap5CSCxxKqAe1KiV4blMQ0xov27wZNfTuuddtFcFG+oS9HVuEE/a5Tor
         TPP/Lxy4ESXBxxolpmYyMQ+zGhAULnJywjTBSEDH2LImszOm+uvZb8z+OAcRoFRlqmzy
         9zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lYEC9rYsC5nKei4OOj8ijdr3SmYANZ5C0QeGEAfdNk8=;
        fh=y+TKFWPAq/xa/qL0PXJz0hVhlcGfQS2ep2BALj8Abks=;
        b=AIANp0ot4QtANaMdaMVtQjw5Pm4PqqBuuDUKEj1LlirI7zq+F3zL7ohjkovM/48ZNw
         rjpfoBPK6FVveoYdMdOp8TLhFM+uOWLisNmIrbZrB1kYuy6qFMtHSPGGX4cnqGBmY531
         861JvpEaoU7IwCXlLRnUEcL9fGZBbY3auAsxwNogSdWqZuwx2JulnkSBEdgrD2xfzqrb
         2KXcsjbstBwjcof7P0H8m1FBeE5NkfXACRfFl/eMpAmSpvf/IkBsh8JO6CaHKhcX+H9Y
         fm71fIbtu40FZeoOyn6PwVLNhu5oQgLUtdkUZP/gp84To64tc+6dlVrQ3NZkOuisd7gr
         XxsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770568013; x=1771172813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lYEC9rYsC5nKei4OOj8ijdr3SmYANZ5C0QeGEAfdNk8=;
        b=WY3ZSOmRooxsoEK0Al0Jc1y7RdUtOnE3wzS1PYglnUenpJLuPtCz487hnN5sBiiXeI
         Rril1JdGjd6/Dbaw8kU8WyZiPx3mpnNjOG42foOKfa2vSJ3f0QsHtoIu3mCEjxKTOuFb
         Xrxy8gBIKFDF/5xPwvfn6Cxncv/LsONGeF9p4=
X-Forwarded-Encrypted: i=1; AJvYcCUmZX0OsB0NLbRU4CTYtWOB0T7ZOK7c7ISCq5fVYbdICGC743h3JvXkEBT4V1+wfj+H0D3mMQo=@vger.kernel.org
X-Received: by 2002:a17:902:cccf:b0:2a0:acf6:3de9 with SMTP id d9443c01a7336-2a9519ba4c2mr93652015ad.58.1770568012705;
        Sun, 08 Feb 2026 08:26:52 -0800 (PST)
X-Received: by 2002:a17:902:cccf:b0:2a0:acf6:3de9 with SMTP id
 d9443c01a7336-2a9519ba4c2mr93651905ad.58.1770568012290; Sun, 08 Feb 2026
 08:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
 <20260206052930.1882740-5-michael.chan@broadcom.com> <aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
In-Reply-To: <aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sun, 8 Feb 2026 21:56:39 +0530
X-Gm-Features: AZwV_QhyFrbDgTwYJ6Jl2gS-UzyRiRBoXvr_I1iTB04eWUAgxysSHny07ugcmYk
Message-ID: <CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007782f5064a527daa"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257851-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8F2851096EC
X-Rspamd-Action: no action

--0000000000007782f5064a527daa
Content-Type: text/plain; charset="UTF-8"

> > +
> > +    import subprocess
> > +    max_wait = 10
> > +    ping_success = False
> > +    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]
> > +    for attempt in range(max_wait):
> > +        try:
> > +            result = subprocess.run(['ping', '-c', '1', '-W', '1', remote_addr],
> > +                                  capture_output=True, timeout=2)
> > +            if result.returncode == 0:
> > +                ping_success = True
> > +                break
>
> This might be wanting to use utils.py's cmd()?

I checked and tried using the cmd() and it indeed eliminates a lot of
lines here. But the test itself becomes a little unreliable.
I often see TimeoutError: [Errno Wait for file contents failed]
/sys/class/net/ens2f0np0/carrier from the wait_file (Jakub asked me to
use wait_file)
Also, even when the test succeeds, after the suite exits, I cannot
ping the remote host for a long time. In contrast, my manual loop
worked 100pc of the times I tested.
I am using the command like below:

   for _ in range(10):
        if cmd(f"ping -c 1 -W 1 {remote_addr}", fail=False, timeout=2).ret == 0:
            break
        time.sleep(1)
    else:
        raise KsftSkipEx("Cannot reach remote host after interface up")

I am not a py expert so is there something I am missing?

--0000000000007782f5064a527daa
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC1rxAS
eSNF/f8Ows9j1M69zzuwKCgci+cJ0KzIxeMzHzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMDgxNjI2NTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBVL0Q/fdUGOEMrI706TbolpK9wvaR6gLYj480tIMTM
cxjDFO1uyrAJEiwp6d1jOLtAmPB80LKUENa7TTqrENOyNmwRmWnkWWarVHvfZ4MK39Jn++dZSRXn
z+4ZG5oPpJM+kYMx/HAZi9vDFfm16N9Xzw13kgSB254jFeiVbbFw4EgGC0sTXt+GSp+66CL98Qdq
jUFfvIch0RSncyV8LayTTDKWRfvp/IWIqDvf3LSnyT4I7MkNjnVOygxr+jJQNqqQMLjG6/eGRN8Y
Ar3EU/cnM7AtHkf8W/Npz/oEioQ9jLjglRaQSCYyclngeMSDTZmQ7k4pl08zmHSeqEVvJcrO
--0000000000007782f5064a527daa--

