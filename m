Return-Path: <netdev+bounces-305290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GGX5NXmbTGrsmwEAu9opvQ
	(envelope-from <netdev+bounces-305290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8A717EA1
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:23:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=eHbunGvN;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305290-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305290-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CE553035B4A
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D16F376A09;
	Tue,  7 Jul 2026 06:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C89346AE3
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:23:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405429; cv=none; b=FA2psHmk1XPP4hnJX+fN7L/2qH3Ois00lbYWGhXJ5rACQWs0kZB7FfxW+sB6Wr1sHZwY7waw4sbrY8+r/53TueHook7+F8R1a52O4ssjCBdwWl3b4MqpByeSG125WABk/P18v/PGVrbpss2EvESuAK80cMGORHZy6ptqg0OoH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405429; c=relaxed/simple;
	bh=gzzRKQPexiqiuTZP98Gc8eWrVrvXrcprZ+p01J3WmBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsAtTUO6R9O5LA15pE/E974/80aiUIUkbfgw34jvdjvCMgT1QCCRhkz6EWE0xGtTAmZyhbMQgI3VwzxbADJ3pd68/WO2RJtmjSCMw1sWaNoV/s4tC3in3Ja6lXSRsA4y+26FYIDi/3mKQKBxdsuE2Od1qq3HKeRorBcc1X2lNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eHbunGvN; arc=none smtp.client-ip=209.85.214.227
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2c7c61b5292so55270195ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 23:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783405426; x=1784010226;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mwooe25NiDRO5Rjh5QQY/tGrxskvTV4STWTd9GgpLng=;
        b=iQM4IMWAzNCG6/3oRMbvAzOQw1CuPmQNeIwfc5ej4/EEnQPv7/Tcu/+oT6KZDTvSuG
         wKKDxbERwvUlExUekIX1E0e3MhAjvAkVAGit4SJO6Ajsh9urwvxzH8WKi1YrfuCUKp15
         0xW7vitGgPvMl2lYKG8L2AIDEXY1giNdoxoR6Vo90Ly/XaLwnEQjYdIwjtiM90lKgYt2
         TUh0EjcSxOs8tfNzPjuvmP6UR6v64xOrzy5B5pvVWEgtNDqASADxze2YWvJgEcUAPVBs
         pmQ7dw6agGhhQO6KC9BUrXZVLRXpIzTHExG/dogFUN5RQhLM3MCP2o36fRGflZXq00h/
         53Ag==
X-Forwarded-Encrypted: i=1; AHgh+Rq2ZjdQsaYV2jJiMCZSAxpHb3VzVzRHGhEPDLhLx/oGGytsYcZVm21JKlxP9Pijuok3QGuS/dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCc8oipOir0IJKxXTejqcqrSrAMOtaKbYrwm/fQpjlXlyNOFo4
	9SepkVnMZiqkw+pAhObQg8mti7yBPMC/apXRsKJd3B7UTJvgGhSsXwf/exj9K0+QKtLlQHZFgW8
	UOa/9G9mWxWEkDDMAI9buWyHmdMfsnshZ2bjEnATfGGQDkRuZAFec2Zl6qCwDfa+kFY2z2LkuwW
	EXEa2jCNn2y9is/xGBoBbsiKmVRV4UMKdvules8Fx+V6twZ41X6gaJGluaEgnZ4t7zTAN71jLBK
	LYszaZW+A==
X-Gm-Gg: AfdE7cnf8EltF0S7aGdLhyoCMoh9BBbcbFTidhYaup4oSnt44E8leEYk+RqLvuazrec
	r/UhAYeuuXKFodSGJozYAPuF8v8grxOfwEHPfwAwB628c86BxSlN2txg4772QOU73McgBOlIyj9
	/JGFRmB/tZPo3Rx/nbG0xBFGyUiPQupzLDQI2OLgIB/XvtNU7qsibqKws1K4RJx5OpBuWG8dPPb
	0DMLiyYBX8CRega9SsEdUJl/rzJS0XuhPT9gm9njLSMPIAfPaP7+8aNEQLxG8764RHvfpDTBJmE
	ju6HxCLjqjfbFXdA92WlMliOm3Top16W+XJ43kXTMl1SB0uPrmDzlib5KrH861WZU3a4JS5TCGI
	8FDl8jZBeozPIDCW7LsGUDZsKLR37aA/QkORcDimeb7IOhjEhYzEnX9cWHXto8WrAb2KMjYrnFL
	UN6vGwRKEhvp87aSNxwYMVdeVYqcByrWlui2ks8Dux96gn
X-Received: by 2002:a17:903:28c:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2ccbe607251mr42864845ad.3.1783405426384;
        Mon, 06 Jul 2026 23:23:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9cdcb5bsm1184905ad.43.2026.07.06.23.23.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 23:23:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845df469a26so10298260b3a.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783405424; x=1784010224; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwooe25NiDRO5Rjh5QQY/tGrxskvTV4STWTd9GgpLng=;
        b=eHbunGvNYEvs9Llif+C0/4WWXm+nkAIAbgxXuM25O1dASniTPku3We1CMBq3M7vEfA
         9/tA+zkXPn83/UaRRkQkkksw1CPsWdvczbodpAvGKB9uB8TwteUbJDawr4X/0xCUwsi4
         p2RHHv8zYPu1WAW3JPVir//gOYzCVbsMTOIvI=
X-Forwarded-Encrypted: i=1; AHgh+RpY73JqDNpP4NrA/t2XQz/HbhC50x/Z5UpqwyCvL2Basku8kXAteyHda8d+AEVdoYU+yFhrEYQ=@vger.kernel.org
X-Received: by 2002:aa7:88cd:0:b0:845:c6c3:5e79 with SMTP id d2e1a72fcca58-84826dae10fmr3762062b3a.40.1783405424660;
        Mon, 06 Jul 2026 23:23:44 -0700 (PDT)
X-Received: by 2002:aa7:88cd:0:b0:845:c6c3:5e79 with SMTP id
 d2e1a72fcca58-84826dae10fmr3762035b3a.40.1783405424196; Mon, 06 Jul 2026
 23:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703112431.2860506-1-kiran.kella@broadcom.com> <c2f1e433-99bf-4712-a31b-6b2360f8fb6e@gmail.com>
In-Reply-To: <c2f1e433-99bf-4712-a31b-6b2360f8fb6e@gmail.com>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Tue, 7 Jul 2026 11:53:05 +0530
X-Gm-Features: AVVi8Cdu7posF_ERMGiTWWl1bGAabeWlUHgpg74RE2Pr9n-DkBAD09HUCJicyS8
Message-ID: <CAPHeo3dA53xHumyocNMRrLqDeL1+imaCn-LY2dSTnwRxAX9RYw@mail.gmail.com>
Subject: Re: [PATCH net] psp: fix NULL genl_sock deref race with concurrent
 netns teardown
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, weibunny@fb.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	akhilesh.samineni@broadcom.com, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d81d850655ff6e8a"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.zahka@gmail.com,m:kuba@kernel.org,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jayakrishnan.udayavarma@broadcom.com,m:ajit.khaparde@broadcom.com,m:akhilesh.samineni@broadcom.com,m:vikas.gupta@broadcom.com,m:bhargava.marreddy@broadcom.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,fb.com,vger.kernel.org,broadcom.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38F8A717EA1

--000000000000d81d850655ff6e8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 7:16=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
>
> On 7/3/26 7:24 AM, Kiran Kella wrote:
> > The race occurs between network namespace removal and PSP device
> > unregistration.  When a netns is deleted while a PSP device associated
> > with that netns is concurrently being removed, psp_dev_unregister()

>
>
> Thanks. I was able to repro myself by inserting a delay after the old:
>
> main_net =3D dev_net(psd->main_netdev);
>
> and then executing nsim_psp_rereg_write() in parallel with destroying
> the netns that I placed a netdevsim dev into.
>
> Tested-by: Daniel Zahka <daniel.zahka@gmail.com>
>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

Thanks Daniel for reviewing and validating the fix.

>
> > ---
> >   net/psp/psp_nl.c | 33 +++++++++++++++++++++------------
> >   1 file changed, 21 insertions(+), 12 deletions(-)

> > +             ntf =3D build_ntf(psd, net, ctx);
> > +             if (ntf)
> > +                     genlmsg_multicast_netns(&psp_nl_family, net, ntf,=
 0,
> > +                                             group, GFP_KERNEL);
> > +             put_net(net);
> >       }
>
> some optional nits if you wanted to respin:
>
> You could eliminate the extra struct net *net, by just doing something
> like if (!maybe_get_net(assoc_net)) directly.
>
> You could get away with a single put_net(net); call site, if you reorder
> the ops that could fail so that maybe_get_net(assoc_net) happens last
> before the build_ntf(psd, net, ctx)
>

ACK. Will fix in v2.
Thanks,
Kiran

> >       xa_destroy(&sent_nets);
> >

--000000000000d81d850655ff6e8a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ksPFF8lRQaSHMJFFWI2usTUpS9gKxRAuJyHc0xlNKy4vK2ZEic8RWs34T6LcL98JR51RaKtE0Dw9
7F/uUf87z+/74aOyyxrTl58LlkxL/+1yMEHZhyn6z30LHQuA52TSp7uD3au8gu0YN+hKIsPBKVbs
dzf/bW6eDpGSwgwRzqF2BcDBOUA9U2mB2cxinBxOxCVbYRy//Q46OuAx0pXw8trIkPDdp8kHAoWD
7JxJ70nrdMy8VRmC02NQp185/6szeMFYLA0CAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYa2lyYW4ua2VsbGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBS/iTArBeV9hFyyktvkwzGbaKne3zAN
BgkqhkiG9w0BAQsFAAOCAgEAdavxLwcm6Kj3S7/bA/IO6B6MTHIndKyB630T3CTPeOeuHV7ZS4wr
rDZbrSjERD36308lnaXSESlcu8LX2SKJ0KqNM3VQNTawSKS4wMXlyTzOBfaslsjtFiT4jQW9Py6u
6nf1EVoQ6YTCGJ+htyKqFgIljJIdBBOvXY+gECh/DC+VbLUVK9CgZLKkFJ5udhYvw1tOc3zOXGOd
kwaK7AtwRSLgNt5RSAaikL6bvU1kUWgITNKKhBK5F3CNUbR0hD/i7yG6Afdh27V1T7FEdV07fBbu
3+AVnAdbZmHfnB2T8lHTaR9GbgkF6lG/a8I+eUG5NPrDEM+afXT7/+zOTjf799qoyhMdfgp90DEW
9ukfyqfUq37ctBG4TdnDlxtkwy9XYw0Avotf2lrYy+6MYjt3cZFF+AF/F6ANk+Gx9zH5gyeUlruJ
+aqmP1U1lX/n2YEXAfiLJulbb3Jfi8lvyYzHXpHLIFtLfyVOzUXdGdj3dVxxFSPJ4uXmpk2SLExM
W7+cvJ+PxSJyWK723U609whQmqbVRz5B49CjNt/exjWtBGGjCwLPMGNWbHbwtDVWcoZzE0KoL7EK
VPB0t6uom5ElZ+qieZghO80tR/MW2eL8i+EiVMwq5GF1Ni3D6uypwZYqgdicI0YGj7JCgrIzr1kC
xwtQkw5ij2CCUWXxadt/C9gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
AgxbhXTUwXZ3dIWSpigwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKRUNQzPhfLb
c8DN87hJniU+wM52ConmgnKAlffpE2ttMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDcwNzA2MjM0NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAB36UlW3Y3IdX7IbHxqXlB1hpUMnrujQ2UfWu9YnQhO9Gbue
i3Ej7vOOcsoKg3xCt24AbE/u88igTInk65Mi3d9CIxZljQI2g1XYK7pP05iztVFIYfdTIpyyhqoO
J9/t0Jrr+7vnwR4s57HwI6dAm6KlfHJYmVQCdlcJ7Safu4n+w0CNnpGtpEA91e8cXUWFK74rRApX
e6bV9H0FkeobWdOixtNhqV32+3dNu+f40MprO845r0uoRGr8+mSDPMMBRcByjENgleJdL8rePjvG
PFi1LhZT2PURkNF78xIyhnqxnMJSvlEOViM3LzhhddlHcBArO532XarqZuy0boiODNo=
--000000000000d81d850655ff6e8a--

