Return-Path: <netdev+bounces-268256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID6cHmZTuGmKcAEAu9opvQ
	(envelope-from <netdev+bounces-268256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:00:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9129F6FE
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E38E300382E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300533ECBF2;
	Mon, 16 Mar 2026 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KCdIpRsU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B883E869B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687651; cv=pass; b=hLNwXc4oxAAjBu2C+PuKxUmELCkUMmN41XpXIsAtlvnSFi2No3CpQ8T5WZU3vQ/aWJ1qm4Hlu7w7lAdZp0H6iVQqNdoFdNNcyj/jU3Fk0O17begNoN/+UX4ss+882bRrf8yMsSBS+qEc+OqQ/Vxe7DP2KDlMlsOtaHzp/lT4qD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687651; c=relaxed/simple;
	bh=NZdHgJSdMYMbLaEMIoqKT7gnzOljwHUJrAl10ezNtcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSX4TcBf5d6SfL+PHxLb3EYL/um7jfTjiYeenGZcZ1xtMJniVYbzAyLUkIDl8sjYFV90ouobZxNJ3z30w+Ne1trlKjUyLbEm9mphKY3SS1uE3Wpwi/1OB4/fjxTp7zDcgl7mshcJMqqDj5SMGdy1DxjtW+oELkoE1fCAJ2I1seA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KCdIpRsU; arc=pass smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8cd80f56b27so435104585a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773687647; x=1774292447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kATm3gxYRyXbjGExyL+TAOrMJtNcRlTUcYnmp34L1Ek=;
        b=eRRZ2U5z8Y3LiQ2jq5UaC3scVyVJT8H+NedseIAli8H6+hqCrtM6Td/SQyHxw1f5kW
         IyeQaB9a+1DXV4eFjBn+hXPQUly9WggxmUAoCIYnvTO+fPimDkB82YFwJG/8RZZHKQXe
         MZo+jldgHFzpAROJC+wP0VK4Wg+y1vFsB1eda7zMjhvHN447bY7M+RV5rqPwAuGr/HDC
         ZVD+NlnGyVyuyY7awsev20yvPC0xrJfI9rHTN3F3V4u8LCw3KoRf2Tsty2DAR1jAbiqq
         hNA1HImKa2/NQ+ui65emX69HgSkEsS3xp/fHFnvVn+KvCEP5T45fMMfHET3c7Y/B/MGs
         vwHw==
X-Forwarded-Encrypted: i=2; AJvYcCVjujECNF/q4n1oxOXVMWhddNnzsX+wImznwPO04q0iaFVKdrLkM1LpSPQpswVe/THe74DAniw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTkNst310ujESAny4uh1wlZkzl7k2u1mVg0pZ0Ba3gW9ek4VJ
	qn+iMRFTNpKoEp/MSqXrus/4IrJOG1OH8tlMrBjydcqeFu9gieTk1BGajUXeXz8Lh/r3/My4H+D
	q+JYFrUa1Lg5zuTKyTFIKMhcr3LfkbfeCtsZr7rFwSK0O+UBeVeJ1ERzgtEgReQImNNtu5XeVHk
	ntKideetbOvldH2omFVyi092KpMnoSF+5KNIZNRS5PGzBHs+4zkQTBxGwrcVPe6zXHtQfkRP/YU
	t5v/JXJFbE=
X-Gm-Gg: ATEYQzz/yxwEhUB5BWRaHlqxclt/NLBnSA4wIy8+YqhQ5oXHR9JZJVcC0B75xotUgtM
	lsQMpqeM5VlYZZi9JuY35S43e5XlXbi0Wkpqk8hC3SOM9LILd/Dhw2mifVCKPUAXUAwApwJOmmT
	WnYBGU+GugonMDZZ+2JZtTYERDUxMr30iQc37GOw2dWfioY7gpvUwjom8JkLfSLDilGJPRlDJRU
	MKe3HabaPrboNnfR57WBhYRUnmluaojQ+YGkD1gnGDn2BDZDjDk3kg5x3yYgks7IF2NS764/Fc2
	hUL6+d9jh0BL2Idqk4izJ2WWJ2G69/QU/CM7EraSzzSS7+UmBt2ZIKruSdtvhLsHs/+sXX9x1Ru
	BdaUjlHbQJVPNCtMYR7RZxZnVZ4mUyO/vvR3UIcMjX2T2wX27UT6USXqQVny/Gq4k5kpJUgtXWE
	AaQpVKNPQEzkf0xsf25f/d26w6Kke9IrvdAWMBt8u5OHSIgwaRqUCeu8fU
X-Received: by 2002:a05:620a:2549:b0:8b2:d56a:f2f1 with SMTP id af79cd13be357-8cdb5a0c364mr1855089585a.12.1773687646522;
        Mon, 16 Mar 2026 12:00:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8cda207418esm161796685a.4.2026.03.16.12.00.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:00:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-666d0b4acfcso1166198a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773687645; cv=none;
        d=google.com; s=arc-20240605;
        b=CqRqxbNbgDcHrJtpJHomV9TkjnuBSgdExPAGK+BrJuVKjNtRSncNRP+oMuWEL/guir
         crJH9Gm1fLoYIrpaPA5GEM6hSnMCOJoqx/MWVZ/5Xs2W3LBaSMjL3w0v1x8gOOQq6e64
         efN6wj9sQkeocWRMU4i44owzx/VgRTp7ryZsITbR4ekaCzUbKModBqIwtDZq2B814SGW
         1Xr2kv7zlphnznKg2LxtScYYomFPVgzhZtyCwsj5IIYhPS8JBHnG/IXNdGCbLFzqadW2
         Mj7v9FlsL6GoHV6P8DOiy/bbPGKED2chNr0/vKg3rgev+RLoEJvQC/DtWArdUqPq8RH8
         8LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kATm3gxYRyXbjGExyL+TAOrMJtNcRlTUcYnmp34L1Ek=;
        fh=cUn9BKSeegZjzEwUxemw6INa+TmTPNH00ArYTbabbq8=;
        b=YM1KvVriwjD7JMExX5BfEWdwR20lABrkoJccaroAeqDlR4E2PhOdJWD7NQF6BSygcI
         tWrA3XL/C5Lqar3ox9eg1oerdqjBeXCcHj4aY6rm+nkeXlB7Ud+1j/U8wmcvls7MfxBZ
         iQ1A4MvZpUX4lyg29ocAP9y41XIiPtgZKaNtYNDVKda/gFZhQfQABuntjuDdwbaTL7/Q
         35vUfoK9c+RWGiw3Nxv2czgF6pWj64b+rt9rhpz6IlATBzTjctkXqXYRBDpWEcUacWBU
         Lb2HUQ/2swLL3T5KjT9nOcagVvzn4T8Zy/juWjTntoJ6QqJj8rmrcLRunmrvqtJmMXRp
         8ayg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773687645; x=1774292445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kATm3gxYRyXbjGExyL+TAOrMJtNcRlTUcYnmp34L1Ek=;
        b=KCdIpRsULS2pA03CGqrHGYv0hwPnxgqE2M2/d1UYqViZz4NUu0695hnr3jT5RLJaRi
         e+N8dhxiUmeRbIAcW3fMznKJC05ck/umCUox0pvGDzXGkO+J0KjDjtMHWkNX/ClXB5tB
         l8br1JfWlmjq2c2TEL+ilxOZgElbleJqTl0sc=
X-Forwarded-Encrypted: i=1; AJvYcCUrYSE8+kkfq271CLlOd/W6SvERZAYDigeAVE5SF44J90KBf70Gp8wXt75nWv6yirqUfkpr0dI=@vger.kernel.org
X-Received: by 2002:a05:6402:40d6:b0:665:57ca:9033 with SMTP id 4fb4d7f45d1cf-66557ca94f2mr2579400a12.28.1773687644786;
        Mon, 16 Mar 2026 12:00:44 -0700 (PDT)
X-Received: by 2002:a05:6402:40d6:b0:665:57ca:9033 with SMTP id
 4fb4d7f45d1cf-66557ca94f2mr2579362a12.28.1773687644234; Mon, 16 Mar 2026
 12:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314215432.3589-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260314215432.3589-1-atharvatiwarilinuxdev@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 16 Mar 2026 12:00:32 -0700
X-Gm-Features: AaiRm51UYwJi3wulnI6mLrKrhNUI851xCQWoskq_LwW2USB9XjEUyKQlAfaHdXM
Message-ID: <CACKFLind4_9g0d=ztUYuzbtQdmcDZ7fds12xvaBHY3+9nC2+WQ@mail.gmail.com>
Subject: Re: [PATCH v4] tg3: replace placeholder MAC address with device property
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Rishon Jonathan R <mithicalaviator85@gmail.com>, Vincent MORVAN <vinc@42.fr>, Paul SAGE <paul.sage@42.fr>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000008ec29064d28d68c"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268256-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,42.fr,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email,42.fr:email]
X-Rspamd-Queue-Id: 1CA9129F6FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000008ec29064d28d68c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 2:54=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> From: Paul SAGE <paul.sage@42.fr>
>
> On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads
> a default placeholder mac address (00:10:18:00:00:00) from the
> mailbox. The correct value on those systems are stored in the
> 'local-mac-address' property.
>
> This patch, detect the default value and tries to retrieve
> the correct address from the device_get_mac_address
> function instead.
>
> The patch has been tested on two different systems:
> - iMac 20,1 (BCM57766) model which use the local-mac-address property
> - iMac 13,2 (BCM57766) model which can use the mailbox,
>     NVRAM or MAC control registers
>
> Tested-by: Rishon Jonathan R <mithicalaviator85@gmail.com>
>
> Co-developed-by: Vincent MORVAN <vinc@42.fr>
> Signed-off-by: Vincent MORVAN <vinc@42.fr>
> Signed-off-by: Paul SAGE <paul.sage@42.fr>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--00000000000008ec29064d28d68c
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBRPOS/
IgBzlm836/YDpbh8y9N6tfnSMAT0zURnG6yc1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTYxOTAwNDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB6YMf+eZv01LeqRASIJp2wMEXAPeA24WPAeXxfLtdJ
iSYK/O619p4qT+LmMwcMyIsggkiV1MHD10MHe+ttfsJC3u7rkN+cf06bedkEcj1Mgsm6EuDRKVt2
azqLtylBaOZocjRkVJy1y4zdDcJMDLI2AwgvNvMgp/YhXZD16S+Y6+20iisxwIBvFPL0hDWcVn2M
dyCOx32lHuTd8/bux0P+Leb26GhymBcHZk9pZHAbFmJb9WuFkpqcg/wC6SSBCqC18vTq2fkVQZfs
jWDv0ZStatNnC/MGa8Mal74XJOWzmeevsdQGIrx1/bitBaGRC22dGmFx22WrYOfCJYga7aDQ
--00000000000008ec29064d28d68c--

