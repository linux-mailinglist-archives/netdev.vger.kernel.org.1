Return-Path: <netdev+bounces-257799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEonADzUh2m+dgQAu9opvQ
	(envelope-from <netdev+bounces-257799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 01:09:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACF107712
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 01:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BB030160C1
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 00:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F720DE3;
	Sun,  8 Feb 2026 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WvfbdVSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1FE573
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770509369; cv=pass; b=Uox9jmCXB513btUmffuQCYwt9SCNe5+EnTMvvZ5W12MF3NR/xZwyvtj3hqHVn3+NUhQN0ns5sA7HPTaMMJHC7KERb2dqf9ERQz6WkDsZh3f6Oxww63MBg1uxS6aQV52ALWYftZBH4WiaEwoTd1MM/IMkbBf4jJp5E37uxRfBw3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770509369; c=relaxed/simple;
	bh=AruqLJWt0LZS+iFai35TOkz2pYCFZ6l1oHQTKwznUCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvNPCcOVK3jEBiliM4p7FjE2GeuXdmjQfuenO4zOer3oozwWsxj2Dm75NZCD97ZhEOqUx/EgStfJu6PIVyS3bcAeZSq2pEL3urHkp0m0fekUgOjpUAOiFZL6py1BxhXaSdNqxZ62H/BS8JQLKxTaNPHf8iDOsyU2Z0L+3Cl5mmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WvfbdVSY; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so32804015ad.2
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 16:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770509369; x=1771114169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzcFbrSZ9zH78/YyMNOoj4Mv40J0QVDLHsLoitGf7GQ=;
        b=nk/0UV/419RWlUSAzZONs4BWfjtf/XJ758nmcvuN44pD6Ljd25a/iSyzfdmEbUAnfe
         v0pGBzM4v4cr9WizT+MGw6gSqp6Zclejmybi1CfZ/jDhxlStT1CV6add3D03GSob7QxV
         cDZGhnfQUKO3ExFnvCELxtVJsFDwowUKYPt/ysmyWSMKiWvyqlmpZAn1tfpYfZXuE6nG
         kTd6ce4EIjqSTMXYzimms+kgYQQm/Zol/y0Rhp6uD/jrxnAEhoDmbMLTo0059RjPpwTv
         seltac8GSTLqOYX53/INy+4Px+zysPxcCb0x5RnxYi1judaVlEzmmxpjvYtcnCixT/Nv
         5U3g==
X-Forwarded-Encrypted: i=2; AJvYcCU2XrRZH8enjk0v/Ffiz188gtG+Phu3QeIygq85Rf8GE/aNSepiXDuIWcW9NdqWWCe1Lit86zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYx9RORVLqmbvF5LhpB57l1vg6tlrBfO5897v70UbWSKkNeAbL
	rFqrTRIkNBZeNgVa8B6qyujBIGzeyJMuKZoF8TvT2ABiM+Y4Vls5MmAvW/C4QjbwBpFT9KQNE6b
	vy5gP4WjU2I9VU14tzR3b8TXa76UtaMXeBrUFdn5CqbmzCDembitS5kZ4t0phk2yrUDw1ZHSgmv
	0klIKOJuX7QiEW1jN2Ul+6+hHszIcU8AecJ8tXXIsA1ZZY3Im4/4cCCIThFBzo56uII19iPYPtx
	RZIN1gnlLA=
X-Gm-Gg: AZuq6aIhJ6Et+T7ws+1Gkz9gwVRMy2OKCjsG6KkhHwJXmtqoSyJsmOfCJqW5q17hf+F
	2ZDxnWo9R63Z1ZyH0PN3feF+kCLceQvHtVZo0WjGwMZt7x/mopRM2uQJvw3JOSEFJj1PBqr2BhU
	KgzRTUYNZMSbb9pROjO8u3kZrWicNvisiK9qgbbfMvMlFe3C96hxCsFb1Ct4+Thp3dbPH2tSCjl
	lgwnIRHt75UZaUwoKKbc6VqyhmDYKXHe6XyZNkfaTIGxdYrTo3fCXodTOZaf3yJ374HbcjZx1B7
	bR6k2SNGA52CwNfmMJasIavwIZtToQDomR3nenrFrQyImCX6rg8SdvIMiTzIzkfkqM6dD3puemy
	M4lkahJrlTdzhgpPnuewW5NBQGcHmoWOW5UYBSe0HyVCiNbAacIdnIkB9/emnCs499FeOVK1Lbb
	wbBHtcnQdNjYn4KNQ1K0PKLqtlYeA5B1IPMD8x9eBuby7cPT4=
X-Received: by 2002:a17:903:2984:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a9519bcc43mr72001675ad.52.1770509368806;
        Sat, 07 Feb 2026 16:09:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a9521a91fasm9481215ad.52.2026.02.07.16.09.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Feb 2026 16:09:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8720608e53so412783566b.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 16:09:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770509365; cv=none;
        d=google.com; s=arc-20240605;
        b=fyCEdwedxrWKPkNsXLVd5pa8fJOIsMGUPodGt96tFVEY+dQlgbW6y4JZMNHEVQJxmS
         gmdpAwgPcgLLjiHSket3AiyZ/Zye1udEwa8Cgio0izbGggfSzqrHdm773FJniJAsEJvg
         M9HXQof43WL9rgBXsP7lkesg2H6M+T8SglI9uBUHwHQgtmxwIkXqa5Qxr3aMNc7LrOxN
         ydFaoP5qR3unUXyYo1a9eZ42LRx3Q0CwIN+q+GetJQ4Vwum5/CPLjuyDFF0bOxfUuSvP
         lkhIopoqD6Ylqe67GVhxivK1Xn+DkMISd1EHZ17KstpNraqbk/uZGjUAi9ZSbYez6VVl
         enUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QzcFbrSZ9zH78/YyMNOoj4Mv40J0QVDLHsLoitGf7GQ=;
        fh=1QHSCso+iAexti0YVOdd1o0ssqMoFSViw/KsVzhrMLE=;
        b=Fw8W5Tedd4TKwrNHYoN4y5S16+/4X/RadbuRl/Ud9EN6k44sJ3e9mrQ5lxVtO9FBa6
         klV0q9u1yFR2QDoG5VLkGmsa+PXJQLRVFjqEjdDwpehgfzQtDm2dK7CmJYrQ7GWxEpPC
         UKV6vGJE0qlwwT+VmLs3LRseSFDYmTp3WOVHAVKnE1I3AKU++ZkMdqYGOJ3cft9KeeUt
         vB0dAMaQkE/uXVAQgvAuYYi5tychOJcW4PJnJEu9XPo/7s6P7T8uTyoOwqcvg5Iacpf9
         ijx+vnB4OF9Cw80VGv/iL/2uTJBFjXcZgbmVfGKE6hUNaMA/O5bHGPzP6gy4/ejFzkhE
         9xGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770509365; x=1771114165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzcFbrSZ9zH78/YyMNOoj4Mv40J0QVDLHsLoitGf7GQ=;
        b=WvfbdVSYkuiqQF9u2kfv8+r1obZyodzo+G7RrmqTCJmWNOMjhkQfdy98zBvJNeVIQr
         7oAPk49BwiYAdpHWPiiavj8uvMRdVfI+ChmqZh7G7oGTYBiLuOvb7JxrSejtHb/QPbON
         Sb17VmP8+0I5EfVvqTDB7GbPg7wluPQtMZ3c0=
X-Forwarded-Encrypted: i=1; AJvYcCVHDcD62X+P9VWkCZP5wCUmSFyHaP+gkdSzdV9b+Z0NnEyMsRyGFaE68h2ZgvxDkPEnVrZ/cqk=@vger.kernel.org
X-Received: by 2002:a17:907:e110:b0:b8e:6d3:ecf9 with SMTP id a640c23a62f3a-b8edf378304mr348557566b.40.1770509365676;
        Sat, 07 Feb 2026 16:09:25 -0800 (PST)
X-Received: by 2002:a17:907:e110:b0:b8e:6d3:ecf9 with SMTP id
 a640c23a62f3a-b8edf378304mr348556666b.40.1770509365086; Sat, 07 Feb 2026
 16:09:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207003509.3927744-1-kuba@kernel.org> <20260207003509.3927744-2-kuba@kernel.org>
In-Reply-To: <20260207003509.3927744-2-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 7 Feb 2026 16:09:13 -0800
X-Gm-Features: AZwV_QiVnDOczpDbKbBAc6A5JSDdEF-0VRVdTxHPGf70ETh5DGzzFcZF4Dj2bU8
Message-ID: <CACKFLimgibJ0qkM1AacZVh8MKKy-pE_AAc4KPKZ7GUqebmXW9A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/9] eth: bnxt: gather and report HW-GRO stats
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	willemb@google.com, petrm@nvidia.com, donald.hunter@gmail.com, 
	pavan.chebbi@broadcom.com, linux-kselftest@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d4a2a0064a44d5ce"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257799-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 56ACF107712
X-Rspamd-Action: no action

--000000000000d4a2a0064a44d5ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 4:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Count and report HW-GRO stats as seen by the kernel.
> The device stats for GRO seem to not reflect the reality,
> perhaps they count sessions which did not actually result
> in any aggregation. Also they count wire packets, so we
> have to count super-frames, anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

I'm suggesting a minor naming change below if you need to do v3.

> @@ -13492,6 +13497,8 @@ static void bnxt_get_one_ring_err_stats(struct bn=
xt *bp,

With the new GRO counters, this function is no longer limited to error
stats.  So maybe rename it to something like
bnxt_get_one_ring_misc_stats()?

>         stats->rx_total_netpoll_discards +=3D sw_stats->rx.rx_netpoll_dis=
cards;
>         stats->rx_total_ring_discards +=3D
>                 BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
> +       stats->rx_total_hw_gro_packets +=3D sw_stats->rx.rx_hw_gro_packet=
s;
> +       stats->rx_total_hw_gro_wire_packets +=3D sw_stats->rx.rx_hw_gro_w=
ire_packets;
>         stats->tx_total_resets +=3D sw_stats->tx.tx_resets;
>         stats->tx_total_ring_discards +=3D
>                 BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);

--000000000000d4a2a0064a44d5ce
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCxl8eN
HjL6zTRwphkj5TnP7mRocRQrc36nB1N79W0vvjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMDgwMDA5MjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCoC88+RkGYbgIbfEE+sAtHBEupC1cywbeXWXfN2WOr
NammAEBMD/HvzvaPyqtdHHrvJGCNXB1V4a5iRN8PH/jgc4fBkwJkYRJzyApnnpab33UAAFG0Hukf
vylrwZdQhru17BWzC1YG12/CYr2UBaum184gJF/MQHOnzkbUYwI1yOcnp3RocEy6mGI3cBQD8qzN
7ujiR6g9p0NjkKn1R6UjrgK/igHpF09IJWh7E6aeHLc7Vha8/ZsTrJJVNKBy7hrzLpPFuk36t9zd
beZSHIGOT+kpPaOjAoZiOV75TXEoYm300WmqqbqFPJWk6p9yYheek7uxDeRjEz8bavtCFjXP
--000000000000d4a2a0064a44d5ce--

