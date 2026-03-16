Return-Path: <netdev+bounces-268228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHfgJ6A/uGnSawEAu9opvQ
	(envelope-from <netdev+bounces-268228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:36:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F829E5CB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59793003635
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530E333A03A;
	Mon, 16 Mar 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LVafWzLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593B3264C1
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682410; cv=pass; b=hiP0Q5U1vP+RYOh5za1DB1TkDytAx+jDoYewUSWmpg4Ff7BDBnQwxAVO8jGbt0oXmetx45u9kCDRMDp4TjsmrHJZATeZ91ilQA9HlU3IZW89j8pPRC1sW16++Xy2/BsZlaQwRodknBgekKsTILzPw9lbx7NgVm9Egf+JOCZtvOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682410; c=relaxed/simple;
	bh=InD0QJyJFN7ikdF/3iL9D/xg+zohjCZQg/A0LCp3+/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZ1Wzef+pTDiXVVb1Fk0lQljIbKVMssYcPEiCZZFJ5HqRVpEztOQ4CnhQYDi4NNCDnGnUp5Unf29oR7oAPMuA2KjrFJVDlBaZmN5Rm8jczstHdCdHwUrjeeW+QYHIxB8b3xwok6uPbz++69Rnq0Fw8lCnGfnKgT04b+nSfuQlZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LVafWzLC; arc=pass smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-67ba6e63922so2869308eaf.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682408; x=1774287208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StG8plrI6HMmFy2YSda85SCR2O/5uzJ9jP4GODrTyqQ=;
        b=XyEEZzCZti/GX/jk9DXWxa3GNjmq9iEIBxqk4ExKjRl7B+2fa44BK0aHXsLEzO2bxU
         znl4+kxo/WiprWiSlqOEADnllswY70SwgrmCvycg7m6IpZ2Hp0kvcQDP8go7uRWDmEiI
         WBk3/CIYyAe9E8ryGPc23xYN4bOKMlfCnLPaFZT8KnToaaS18EPJdJN0NRFM/MsxrHcB
         TGmFXVhOzRzUY6ytcHf7V93tQEp7p2kFF/tNK0B2YnvRVCWQBk24cKIR4FAdxGpFSwUl
         G6ZyodWMeCvyoxHmeWk5hoj2hO1ChhXyvNRvkJWbqq5MsJFVaHiMiczOfpiDfJxgfEze
         bXQA==
X-Forwarded-Encrypted: i=2; AJvYcCWU1DNj3njkOtW2ziY0BMhlO6tEAUA3hB8qRNcMlhQFHl2Fl/E2+jg/p2mcdgT/lK1dufANk7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3+BO5vKnLU5vD+QGj3/5YobWvCk6N7RCy0FXFG1TUdBgNlwO
	Nq0gU68GvFugJLJidTrSjs0HLPyNQMcV08YxjM5t/O+DXhs3Z7ZiEyWDnxW3YH29Oyqf+Clqpji
	5rRhz2po1K2jFRbi0Tw+koknp4eFy9GFRAhLr50n/D5b+FcxXQQCO/OK+jVGZnIR/GeEdB3QsRv
	HJARvnwZ9/rmSlcbTkEPulw4gMCSfOOdXq9tUqHsfMYZpNIfUIlUb74eOg9Mq8k11kJDUhK9sX0
	LMlUeuk+/g=
X-Gm-Gg: ATEYQzyxf0fVtk1ESrV2Qxj6Tgw4xceeA41+YMD8Mf3MHXHBDZTUeok8SNqSf/tDeQM
	yP+35xSZ96/BWm+i2ES6KBIO5q1GuNsloiChPMJOxTwbzuWtYI8KOd5SVCuuiaR7RbBXqrB7FKI
	vE+RKd+NZ7p4qs5VSZN8o61/vyhLz/IHNuVWxmQPvwI/P3vtaL6OI2oFc0BlNGJy666YNww7km2
	9USn5gPU0DVjjuvBOEKesU56MJnRIAqmu89LEUckfQF9LioZ63bjWg/QU7seeMiJfjXI7lGhGXK
	9pfm2ELmqa5AWm3JZcLzWATFq2MH3GEvAibgF57cfw79cSG1enkQJh66GgHaimx1SB0IqiQd91t
	7OObZHpIHnucvigR3+aVVeOi2lts+XEedK9oNi/h3AkDCuuDEK+jMROgyISRcBthDAPDF5w1kJF
	1EI0uBc+I+Y4TB7hKUNY1ySUzkoNaGG6dwbOD3qoO/eu8SvP5fLeONrAVp
X-Received: by 2002:a05:6820:480d:b0:67b:ab43:7776 with SMTP id 006d021491bc7-67bdaa68bd1mr7616735eaf.54.1773682407584;
        Mon, 16 Mar 2026 10:33:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-67bc92ec7desm1242741eaf.7.2026.03.16.10.33.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:33:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-661cd3c9c0eso5155607a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773682406; cv=none;
        d=google.com; s=arc-20240605;
        b=KywvswZLIIoRa5iS/Qj2cW1BflCCRmb8D/Shx4D41PMMuSa4BRRyKtQVrMLL62wLSz
         eZ06Icrldv1F7OrA3UBx+uLownAvWTE8AuZ0Nwh3XMgRPca6bNU+APNztvbiG01a5Mju
         eMB9IgbzBsMEiggw2oEBGgI+Tif2gfjgrB4Hb/n+UrHcCjC9UZ+0HXIvMpkJ9+D8d3qF
         nbu8QoSXMgmzj1Ny0y6iNyy9cuTAu2JWah2hjCsi3Uh92HXt5rvprwhfp0+7usCdwqso
         pR4Xph9AJnFBIf59FpWT+cRqUBZyukOBE/162B1j6noy3rL6xzY7TVm8inLh/G87zRok
         m3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=StG8plrI6HMmFy2YSda85SCR2O/5uzJ9jP4GODrTyqQ=;
        fh=v8/ZfaWZ0QhD8FM+r4z5JIEicb2gr//Vr4MEIzmlQF4=;
        b=UThC8ZT+vFpBjFBYuqsaPh/QHsc5xIS3Zr1uySaTXapYHdtKrOGcTeLZXxvf81o7Ti
         PnDnDwFj836dIWvFuu3n4NxjaEoYWK8zigZrChL1d0EbaJ+L7TZ9CGf25g6HX8wHXMHf
         b4L6wYzOjQWbLIjYcY4rRcD8/RyrQz7POUDuSKd+QDO0722KiOjJpzr3RIZ0s6UnWx1Y
         9gdwRAwHdpUU7lmA26PpNB/9eLDnArkSFnnWjiUXzlN1rV7KaGciANtnqx6criVI5W4F
         C1U9LjCPBhjYXrI+gD4AILIkvO9bKArO/wTtmGhqY2sOMJ/FTBSZ49AbRHxp+SNRXUhU
         4Ksw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773682406; x=1774287206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StG8plrI6HMmFy2YSda85SCR2O/5uzJ9jP4GODrTyqQ=;
        b=LVafWzLCdwRZloEDR+74Xbsrwq92e9MLlGJzVAX4w0szmNXWA0/zjO6ut3aequ0L1f
         yPHklrsX9PyJnhkNabU6XE3lAT5tcJ2A7qlhZsxJa12GSfm4WzB5O2sLSLvhPjRTF17E
         SaMP9EOiQfDbmyAG3Q0dp4kqZO1h48ZPwrVZA=
X-Forwarded-Encrypted: i=1; AJvYcCUbInR+a9U9pjgVUD1HUhRJ9RqRiU07iYWFL/XVprftJ9TXMWlWNS8Lz6ER6n/DLiSSSejlddo=@vger.kernel.org
X-Received: by 2002:a05:6402:51d3:b0:665:5c2c:6855 with SMTP id 4fb4d7f45d1cf-6655c2c6f34mr2448393a12.21.1773682405720;
        Mon, 16 Mar 2026 10:33:25 -0700 (PDT)
X-Received: by 2002:a05:6402:51d3:b0:665:5c2c:6855 with SMTP id
 4fb4d7f45d1cf-6655c2c6f34mr2448365a12.21.1773682405221; Mon, 16 Mar 2026
 10:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313145113.1424442-1-sdf@fomichev.me> <20260313145113.1424442-7-sdf@fomichev.me>
 <CACKFLi=WRRnJqBqenwkFb+gjrpR6Y=+sz6qWbWcjAyX4tQvj3g@mail.gmail.com> <abgmzFReIY8m-NHy@mini-arch>
In-Reply-To: <abgmzFReIY8m-NHy@mini-arch>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 16 Mar 2026 10:33:13 -0700
X-Gm-Features: AaiRm52EDmEg2iSvP0S9gbA8iSSPo0RCassZDi5M_uKTDWpjqZ0cPnGptD-wXyI
Message-ID: <CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/11] bnxt: convert to ndo_set_rx_mode_async
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c2e7e3064d279d12"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268228-lists,netdev=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 025F829E5CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000c2e7e3064d279d12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 8:50=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/13, Michael Chan wrote:
> > We should now be able to call bnxt_cfg_rx_mode() directly from
> > ndo_set_rx_mode_async() without deferring it, right?
>
> I was not sure about bnxt_timer->bnxt_queue_sp_work(BNXT_RX_MASK_SP_EVENT=
)
> path. If we call bnxt_cfg_rx_mode here directly, it can race with
> bnxt_cfg_rx_mode from bnxt_sp_task. So I did bare minimum amount
> of changes to support ndo_set_rx_mode_async.
>
> For v2, I can do the following:
> 1. call bnxt_cfg_rx_mode here directly
> 2. add netdev_lock around bnxt_cfg_rx_mode in bnxt_sp_task
>
> Do you see any issues with that?

Yes, that should work, but we need to use bnxt_lock_sp() to avoid
deadlock and the if statement in bnxt_sp_task() will need to be moved
to the end of the function.

The timer path is only used on the VF to retry.  It might be simpler
to change the retry logic to sleep for 1 second and retry one time.

--000000000000c2e7e3064d279d12
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA9eQhs
mZyJnsVLqa1DWbd91TQbOqy1KRQiLqiIDVnLIDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTYxNzMzMjZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCglqserixCU1FrtP2/Q9njCrezC+BUEHwWmKexoPPN
AvcSwiIwrIJ7GST621fJEMlmRI9gMgivh8s+xKqFvqKauVQx/lYJu8BkdhMzYUsPv+sWrYvg20la
ZdiFWC0UCaNPzia0io3eX44MU6jOkhwdYWLf2nfsJytrBa+1VLbqtvX00PgPTlOswzYhKzS2/G33
uUl0sB6fMr3jbfdJoVIqC5jb66MqIfCoydIjS9wBo4cSyES+8aFFQq6fUGeFziWREKJih3bK1H22
mhxxkMcqB9XZ0q3MmyhX28UxGBWK5+63AlWxs9waMiIOfhuQwjV0TQkDWLrg2Dtd4S+XIWWW
--000000000000c2e7e3064d279d12--

