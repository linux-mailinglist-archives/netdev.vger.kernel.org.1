Return-Path: <netdev+bounces-264869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI8kJQX4qmlxZAEAu9opvQ
	(envelope-from <netdev+bounces-264869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF86224401
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE16B301A7D4
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8923EBF28;
	Fri,  6 Mar 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DiTRCaeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F43E9F9B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812270; cv=pass; b=AO1dxSRy+0ZQrHurzt8tJ++0aniNXsaY0m42nHwXM4kEAtXPVoyFh3TsnOBXSkvFGQ4UZLekJQLtve+ouOwDsUR6qk3B7t5Ighre6PpYmD+8KcodIiMcalhGy9URAQMBtsrgf+LDj+rdaRKiUobHGlvizROcS/A7QtXEDTFoUy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812270; c=relaxed/simple;
	bh=5YD5mH+TJVSIdflOqB8NdJVYJniqFHttN17dc5kSsUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmyod7WHJAqRAuada6wgM1vO3AJ5e0vf4PVEA50A3sMpVIOU/lwPqdnmu6XYREBSTqa0MT+iZEf99QjIgsu6KwBGzD+fE9E4j+8V/z9C6JbZCnynmiLRzquPbqv4EwBU9WUYl+pLCOzSn8crRIj38S3CWdQN4/ykRXIChbhQzcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DiTRCaeF; arc=pass smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c7388dd6ae9so1014945a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812269; x=1773417069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YD5mH+TJVSIdflOqB8NdJVYJniqFHttN17dc5kSsUY=;
        b=ULh2dxinfiBO0a54HhKCEMfAzE6aPvXlkLUoHU+OJBS7EVP5SW7c2jRI6BD7IdAAmm
         2iymMXFYMco+ddfCg6+WP+1H2M3esAZs7L6NX7XG26B8mfsEylSu/NhoIBG9xNzxEvN5
         gIrmYyAx3NDxKFKnQEBwA68tm7q/Du9J0Me+wHiwCOhFDlXJUOubI0LOGjOLuazjl2pv
         l6UYa1wP9O3Srn0KhtFeAFr1GOjpEv1UYCBBcxZZPvDjh4RD6URpr4dcn6J7MJmj5nwt
         Ncs1TPXYQ5VxZiXLAxtuLO6qmuiT6/Lx/XPExxS4GQGkxiVOIvTR1uU7ASuJKKWn5rhr
         qHaw==
X-Forwarded-Encrypted: i=2; AJvYcCVdQsHplE8V0EMPwoEYWvLeNlnahIVvI8wAQZ95X14WR9r9BGQwOEUg9X5Asg6JbmSYNk5i56o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLg21LT5JnZqonyQpHmQSkB1XtX6FUQSYkBcSzHWsHNo18dck
	c5/VqM8HciCm54A781+aYitQD48em9xIUqUuJ4WIcQNCcCC1CUy9MbywflYe89k8FCtKROGIIL5
	XUmL5JLAe1zz4y5ea3op1zLj96ywKrzJGLKXEoS9t9nln1eYpmp72TYQII3wltujPHig2F8Mb6Y
	NnfkuNmCAuK99B8YCUOZWrj2Qowkd0RkxtPJSoX9foMvfitz/mJMtHlTxSu74G8SEZ/mKmuHtuU
	xIoZ9xwIGJlEmP8Hw==
X-Gm-Gg: ATEYQzzdHExHWcUDD8DxA1his4WfWFcARuvfzYReY53pxjFXNn/iXLpPJ7e8jphbExq
	ayPT8wZUuL6sHaIhTk1Kmr1BgzDuxW34NoIMMe5SHmkbuntpo/sdAW7WzbV3xkZP3g5AnmPMRAW
	Q3U/WcMZTV3DP7BjUjVdWpsu5dfBOaYjrSMMvDEo2MRtA6EJmNpPGtOHGViZPFfiXQDUG9UQTA/
	YLi2QZFl5/QzDwiPNy5l+cUOVGmtlYLuwHTS20kGyPrI+fqo3JCEChUcO0ndMmxQld2fRfePFQV
	hBFwC9AwKIFI2IuMrYsr0BiTkR9S7pREf3bfjy2v2yMGZ7djYA35FZFJJJ5iXaRa4hS2yJF8Bdw
	gYLGdOCwv0eQtii5mrCqXOJmmcf7vx3zEvSjyu1zgXhUiTGfPYUhVe/8iMF2FDOaSKLXoBR83SX
	jRRlT5kNWwwfxb4gcsLykEkhnRZevaNfzCyi/KjLDk2DbtxuYG+X8wJLFknuGrUVg=
X-Received: by 2002:a05:6a20:3d02:b0:33b:5a3f:3cbe with SMTP id adf61e73a8af0-398590b4146mr2594785637.54.1772812268782;
        Fri, 06 Mar 2026 07:51:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c739e182f1csm148726a12.11.2026.03.06.07.51.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:51:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-798656130b0so136965337b3.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:51:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812268; cv=none;
        d=google.com; s=arc-20240605;
        b=Ukgc35oHWXY/bj6pe8n4qGUf6jUnOZRufiF0Ui29k+TH7LFjky33EFsDpD3OagOE+p
         gx5H4lOjRWouyiYDQ+Q663NGKax/+OWf4qQ37UE949SWK8gnvuyOyE5HDbFaLQUva9vI
         EWOsQwPQ8MZP2sxla208zTNhvjU+urnMci90aHVz09zgGwHcK0/4x3xhNqW7JBSeb3R4
         4HsFElSfDh6yd27BkbLf0x4XwLbUWbWa66QUxH9a4mjtlI8wf2ZMu8iceQKYeruy5gKG
         A1bJt+oJfHwxL1/NZKafHYC9hZQPKEaPR5xTJxFmytq8reTH9piz3HIXi6bGGKd5xx/N
         dnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5YD5mH+TJVSIdflOqB8NdJVYJniqFHttN17dc5kSsUY=;
        fh=KkmAL0yIL0cbFr1F1epC95LQLLyFsrykFugHAtX29ko=;
        b=IKVFHMeIfesZtPqUXixUvXFzESocOB14nvatv263VgKFwE1VgWD1eTyP9s2YGA8bWa
         kjEdSlauOfU1Wl6bliQwG54gnKX3zt2c9GurH31+7dSW1SXVCAxTxy7/vuoN3lsGEtFM
         4vzJBKQtmW887+phJh6vBizs9666RWdYkwCqapCUI5VYJ9AxDUGX7WFZHJSjwIG6Fg1z
         nHfHlOuIWI0XD6jpPbPiSdMSUHbAhO53QXSQO3H86+5b3fIne9r5+T1Y14BZSTvmajQo
         s5ZUA9GTGV7LpBG0yZNmBNRxFSaI0z64uI7ZRPNS71x+yOgSG68i0HIGYjKjV6aBmBox
         TPlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772812268; x=1773417068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5YD5mH+TJVSIdflOqB8NdJVYJniqFHttN17dc5kSsUY=;
        b=DiTRCaeF3/+requft0x4i97R3Qg41/JzwAa+yKq5ju2gVxhzIcyyo0VSM9le1RKEbC
         1mGzjsSNMUXMqumBC5Z3IBCAAWTua4G818JKXECPhHyJ/ZKdsSpvyfM/l1w6c6MnxF0C
         h7b3aw7Ab9TF30Y6pHJLf5lWqN8bzQgrJ9PpM=
X-Forwarded-Encrypted: i=1; AJvYcCWuVfIONs1U/+diLITy7KpUG/iqLem5hz30ZfYpp70vaIbStl/1piLvrvCJxxDu0o2h9gamcvc=@vger.kernel.org
X-Received: by 2002:a05:690c:25c9:b0:796:357a:9ae7 with SMTP id 00721157ae682-798dd79adedmr22257507b3.51.1772812267808;
        Fri, 06 Mar 2026 07:51:07 -0800 (PST)
X-Received: by 2002:a05:690c:25c9:b0:796:357a:9ae7 with SMTP id
 00721157ae682-798dd79adedmr22257217b3.51.1772812267354; Fri, 06 Mar 2026
 07:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
 <20260302195352.1015990-2-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.270f71617ce0@gmail.com>
 <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com> <willemdebruijn.kernel.128851f8834b9@gmail.com>
In-Reply-To: <willemdebruijn.kernel.128851f8834b9@gmail.com>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Fri, 6 Mar 2026 21:20:54 +0530
X-Gm-Features: AaiRm53BNeabU5E3adVbnWdu7KWNUDlep0M2GR8ScHFuwOy0tkkg9bH_GcG-mbo
Message-ID: <CANQF7iA6y7MDR6KfESUnDqFZLOBsgvkUqzAx_3GboF=c9TkDoQ@mail.gmail.com>
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemb@google.com, daniel.zahka@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com, 
	ajit.khaparde@broadcom.com, kiran.kella@broadcom.com, 
	sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007df6e3064c5d05a9"
X-Rspamd-Queue-Id: 0BF86224401
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,broadcom.com];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Action: no action

--0000000000007df6e3064c5d05a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 7:55=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Akhilesh Samineni wrote:
> > On Tue, Mar 3, 2026 at 2:45=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Akhilesh Samineni wrote:
> > > > Drivers may need to reset per-device PSP statistics to zero.
> > >
> > > The series does not include rationale why this may be needed.
> > >
> > > What makes PSP counters special in this regard?
> > >
> >
> > The PSP supports dynamic administrative states, allowing it to be
> > enabled or disabled during runtime. Currently, statistics are
> > persistent across these state transitions, which can lead to baseline
> > drift and complicate telemetry analysis.
>
> How is this dynamic enable/disable configured, and can stats reset be
> part of that, rather than a separate API?
>

Instead of bundling the statistics reset with the transition to the
disabled mode, we considered providing a separate reset operation to
give users the flexibility to clear counters without toggling the PSP
state.

> > This patch introduces a statistics reset mechanism to allow userspace
> > to clear accumulated counters. This is essential for establishing a
> > deterministic baseline when re-enabling the device, ensuring that
> > performance metrics and error counters reflect only the current device
> > state.

--0000000000007df6e3064c5d05a9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbwYJKoZIhvcNAQcCoIIQYDCCEFwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDCI38VoeiWHImjdPjDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMzA1MjIwODU3NDhaFw0yNjA1MjIwODU3NDhaMIGY
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGjAYBgNVBAMTEUFraGlsZXNoIFNhbWluZW5pMS0wKwYJKoZI
hvcNAQkBFh5ha2hpbGVzaC5zYW1pbmVuaUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDAO001ZnYPXmhKsI+E+ksMK/hc9m3qLeGDkvGAIpfLyKfdk2C4d6tsRhM8
4xrNQmMMM+f5wF271rTc0O+CTfIIIayklTmjzksl5CwimtzjGpPZRcLeABJk4Z8VdCU+TW0gSDgU
UGsHqEkCW3ifD8UhO+1xsg2k1ER9gbJ5HfkiiRjtx/jG0Eik3rXjcrxyU4CSTJeFrMsRfHBINs1b
XQiZIKEA2v9ryzZcqBG67oV2mIMYV0PyoO5ccmjophMLX5I6d9LmhVG+o7Fb8fYE43v1Gmx1cF3/
HLCRJ9lVtOZNrDg8Tx5LaODYomcqd8Jym3+vbToQ+O0SQyV9WNR9n6OnAgMBAAGjggHfMIIB2zAO
BgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQw
QQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczov
L3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8
oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3JsMCkGA1UdEQQiMCCBHmFraGlsZXNoLnNhbWluZW5pQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU7Bc6
vjugq1VNABQ8AiT04kX10IgwDQYJKoZIhvcNAQELBQADggEBAELCFtU20SHhQMZA0lekkhYfBuuc
/5XYCUX21R6IQyTnqwWwOQ4xNOiq5rC7P2bOGpEKMcMBcHB/VDqpT7Cs0PXecOkC+0cWvmZoxCjx
Hk+3d71Ie1w8r5QiYuGOgGhNWbfhc5aVZUENjC+zlYStnReq3uZcf/oziznbvTX38pyuhVsuHFSo
+SP9KHflLUYGQLmToaPGlRjPh+LJmpbiZ0NRrRXz883+dlADC7tW3fUlrqdeLN9xsoTh7CoWxLUl
xSAQfSnXdfTNfF36dQxm8Az8xhjNmD04jilAg+UVGs7xWqnIkFChNe8pykTtDwdrkjzaaISKeUDj
4fW8f5qx0B4xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIIIJLUVAR9jT
VypP6QPl0B6Ndxj4/EcIk0pcQT7/BUM1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDMwNjE1NTEwOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAV4c0CwJ4mw8r/2PJ2u+PFwXaNqJBITLcRqBo2A+sAyXo36
7zDJyKhIlYM7pzbsGCYUNH5AA+q/z0s77j7vARkbjY3C5MllSYqPd55jW83l3zvcA4gBOeJamRVx
abd8ueeu7dOHsY7DP1esQdxyCWeAwzGLN/iwEgThZcdWFjXu3ZkmMssU0CiAhryCSDZLk7mrevcO
wI4Weg4IcxhvRGgzFCL9+//shepllzmpEsBy8O0H3JjewmOaTtdMIQmQReOigf2BnPQfvcBt15bp
q97zUE1ZXwH/ScMu5hQ2Z8hlQmWYWUJhwkeqeVIYVC3BO1soAG5nG3XjrL0faLCTjE8=
--0000000000007df6e3064c5d05a9--

