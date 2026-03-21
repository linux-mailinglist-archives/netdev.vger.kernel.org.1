Return-Path: <netdev+bounces-270183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JQjE7hTvmkvMwMAu9opvQ
	(envelope-from <netdev+bounces-270183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:15:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D52E4215
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 182D63004F2C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213F346FB0;
	Sat, 21 Mar 2026 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QBrBJrZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936332E6CC7
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080949; cv=pass; b=i4QJwW++0iRwDUBEG9CpFvJp+SOaZDv0Pdewa4sswpzexcfIYOC6pHjtfey3J72EsWN7vCAmgDjEpC9vd1FZBB/ZtWdt7u/rhUabkdzpGHJD954eJcGUBQguWPE4v54aAcYGzgMlquGrTQqdHBM5flYvP4wMcr/p3SXhwu3kpqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080949; c=relaxed/simple;
	bh=2+vqg751V59LnNKwFwtnlFjfEu9OXzwWi5HLZqt6fIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYBVbKuwWaBW08Ue+1O0spuqMfEO/oeckcj2GKxUVUj3n7mKn4NU1/JqGDaYdgKKwnmEqpWGzvag9A45SY1p2Yq28WiBJ4fneHRUwyX1Loo1O/pSY4J0B7TsDMbHixTGioMJIwyqNVggjYKLbBhSmgc8eUj4IaFrn4TpCtScocs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QBrBJrZ3; arc=pass smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c742723c863so1590204a12.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 01:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774080948; x=1774685748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtIQtqCEWK2EW/S3a+9qSiMu3ro4eNbTkaRGcvXXtvs=;
        b=YD4hfD9yIEidDOZTzxWJ3UGhLUNSx7UalW7iZzO8MzYiAn9IaNvqJ2om9fYP0ChxnW
         V38INsUyAbXcOgA8zBxs9C0t+uqM+IVIFO2pbb+qfiPyf7irJ7EPN3xPPpO+hvIVniuk
         c+H4iHv8qUVLgE1idyygp18iEhuW7jlHlvwjPRbRbxzf8uBbz9p/DxgLzUaGSopuAnCp
         ZbjSOPB/TtwnJuz6nIcYcEDGQoXDvHJrBp7zHI/pDIuERd+AG1GDPUijnJ/EZq9LrC9L
         zAbhoZwJpHMDxqsRZ3jlvr4G/WAVl5zb0Y8W9tBneEFzknYFnohBfZT1JaQxPeoRgPZR
         Da3A==
X-Gm-Message-State: AOJu0YwyJsWikc2T/rmcZrAdFoBQXQPELgjAFc2KfjDHlHbI5YS1pYlK
	R5pFLsk4f6O7TsFnIOLiohg2cZJLf87b5+Sg4AZbUcBfQKBoOUk1ppXrJvJRshlVSQgIMTARipl
	jY9OyfDtTeQOIpWJ/cyTtQjN9y23WDsMc3s1o20hgRnYtmaPKx/z3j0FNDftGPSh8yzm+GWXScd
	buLRnrO18U/F8YUdvQZ7AYtYwXHE/C3+5MbLo+XWUwFtpxJPWd1FEmh7AgkBlpKn9WiQPD4gORM
	ZviNO2ox4Q=
X-Gm-Gg: ATEYQzxeTZb+TvT9jDWxriOcwuvEB3h9XUTAmONpgkz9v7DloAP55mmheMPDVVxqbHo
	BlQQRzIfGEHgZwiJ4iMMddwyf+iOszvpmPQ/EKgPVshyrd2YtUgUdJq+cXU2MOD4aPcnwuhP/+6
	sberc+wsnkrA4Tfp+U9r/ptgv38PI5flxduySBIRHw8jUC7cO6Lx8BvCH6wwnM46oST65t1XICb
	DWUAQ6ixYj3Atd4266eL8FAdv2wYi2Bk2/5mV+Je+9Y9bb8480E7YZh7VS9YU9dyL1S1cLPbEra
	7pjwljBQAEV2Gm012G/FAWsmA/g4gzHQTD/OZ4fXMdu4OTxZ+PPO6BAhSql6ld9fj3zcLY/X2pk
	MPO/+yu9d6llGCrTxYBSgBmYArCOAJcvEP1kOFfN9TFMbTe3Zam7Bu3D+PpuzED6hsg6BpbKTll
	p6hEh0LfRe1shDHL/725WWlh2suBIzt7NFq6mTf5tQdwB2zjUKu5sMY0tWl/c=
X-Received: by 2002:a17:902:e943:b0:2ae:80bc:9bfb with SMTP id d9443c01a7336-2b0827bc880mr56072705ad.40.1774080947771;
        Sat, 21 Mar 2026 01:15:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b08350b277sm5927065ad.16.2026.03.21.01.15.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2026 01:15:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so12279829a12.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 01:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774080946; cv=none;
        d=google.com; s=arc-20240605;
        b=DHpILuJMJHdKTZh82D7UoE/avEjstGHz1gUbJ2eReAB7xT9bA8cMCHf472kZK+Y+52
         AWThqAyf1lcFKRsT0omnDF35xv2XkE/y+nsuR+PCbYShCld7tjQbDieDZgV20hwZrFMI
         2Kwxgd6fXg7S++eVP+rtrIssYYBMoaI7zMi7biwgdcxKPQCx3BSoVCehQ+JCRiSAyOE9
         kR1i1BFMa+nkww2w264InRaPN/V6MFXJm/uCKb1DQb/VL+swdlVWZpn8FrZoT9qwbwpJ
         3Q5mBdPH/sVPICI7nA/35LGeIMotLbGGofbb/fS7FmtKCGKUb4rxS+QhsO0WFshYP3k7
         WNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DtIQtqCEWK2EW/S3a+9qSiMu3ro4eNbTkaRGcvXXtvs=;
        fh=t70SYQjR8w8ai03PF+/hof1nCkX++z1TbrHCQeariFc=;
        b=Oy2QTYWIP12DUV4Xxbki76fnJLNOhjfYTl9yw/uhLjAlp4WoDb5BynKs3uWWvU9dHm
         kmqCu4B1JlDL2hWoseSzPbcjcpSMnkV+p7VTSmyQkXLKW+YyFWJQJxj5zNj1grEAgH6u
         UOF5/KrCDEtFzeLyszndufL5c0cLpcgjMcRC+HJZ6NshhNwW+OwGw1Gm6E8fkSlF8OMa
         LzTeEn8eUwKb0S8j4MwHX6tV5R3vrzX2o2tFAXJelBhC9yGGnCnQZdf9NNXaWBhxbjYw
         ycMG5G4+cmRsycwn6fdpv1gZHndEXgtfcHF54NOoCtoo4yguHcuGLzhTLK2HJk3GR681
         lLqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774080946; x=1774685746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DtIQtqCEWK2EW/S3a+9qSiMu3ro4eNbTkaRGcvXXtvs=;
        b=QBrBJrZ3Ezi59anyn6UoRGscT66gpCnFmi2llzbd2GbdDLjpa3wGme0iVweje2sEmS
         K/Vx5AcSX32bp3oKvzyzwRYCHUgnidsm6G3mDLHbcV8aO3GKrAtey/B1A30JFUsSxMWJ
         Tty0w3PHcHNsm6tweW9kLD5Fh7qiRwD41s5eM=
X-Received: by 2002:a05:6a00:198d:b0:828:f1d9:22cc with SMTP id d2e1a72fcca58-82a8c234f59mr4753521b3a.20.1774080945800;
        Sat, 21 Mar 2026 01:15:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:198d:b0:828:f1d9:22cc with SMTP id
 d2e1a72fcca58-82a8c234f59mr4753497b3a.20.1774080945271; Sat, 21 Mar 2026
 01:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320144141.260246-1-joe@dama.to>
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 21 Mar 2026 13:45:33 +0530
X-Gm-Features: AaiRm52qmaxYHhsqjRp1zcNwOnIfBokHwscyyirrrALm68MF-IoTox0jm7zuqLA
Message-ID: <CALs4sv3FWTE_kmZhnnVa0Lxr4KYvSHKyF7PYtJ-Fh2JHmpwJmQ@mail.gmail.com>
Subject: Re: [net-next v4 00/12] Add TSO map-once DMA helpers and bnxt SW USO support
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	michael.chan@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000992caa064d846865"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270183-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: C68D52E4215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000992caa064d846865
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:11=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Greetings:
>
> This series extends net/tso to add a data structure and some helpers allo=
wing
> drivers to DMA map headers and packet payloads a single time. The helpers=
 can
> then be used to reference slices of shared mapping for each segment. This
> helps to avoid the cost of repeated DMA mappings, especially on systems w=
hich
> use an IOMMU. N per-packet DMA maps are replaced with a single map for th=
e
> entire GSO skb. As of v3, the series uses the DMA IOVA API (as suggested =
by
> Leon [1]) and provides a fallback path when an IOMMU is not in use. The D=
MA
> IOVA API provides even better efficiency than the v2; see below.
>
> The added helpers are then used in bnxt to add support for software UDP
> Segmentation Offloading (SW USO) for older bnxt devices which do not have
> support for USO in hardware. Since the helpers are generic, other drivers
> can be extended similarly.
>
> The v2 showed a ~4x reduction in DMA mapping calls at the same wire packe=
t
> rate on production traffic with a bnxt device. The v3, however, shows a l=
arger
> reduction of about ~6x at the same wire packet rate. This is thanks to Le=
on's
> suggestion of using the DMA IOVA API [1].
>
> Special care is taken to make bnxt ethtool operations work correctly: the=
 ring
> size cannot be reduced below a minimum threshold while USO is enabled and
> growing the ring automatically re-enables USO if it was previously blocke=
d.
>
> I've extended netdevsim to have support for SW USO, but I used
> tso_build_hdr/tso_build_data in netdevsim because I couldn't figure out i=
f
> there was a way to test the DMA helpers added by this series. If anyone h=
as
> suggestions, let me know. I think to test the DMA helpers you probably ne=
ed
> to use real hardware.
>
> Since this v4 made minor updates to the python test (see below and patch =
12
> changelog), I re-ran the test with both netdevsim and real bnxt hardware =
and
> the test passed.
>
> Thanks,
> Joe
>

Thanks Joe. Its nice work! I reviewed the series and added my Rb for
all patches except core changes (which btw also loog good to me, but I
think other experts may review)

> [1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/
>
> v4:
>   - Fixed kdoc issues in patch 2. No functional change.
>   - Added Pavan's Reviewed-by to patches 3, 4, and 5.
>   - Fixed the issue Pavan (and the AI review) pointed out in patch 8. See
>     patch changelog.
>   - Added parentheses around gso_type check in patch 11 for clarity. No
>     functional change.
>   - Fixed python linter issues in patch 12. No functional change.
>
> v3: https://lore.kernel.org/netdev/20260318191325.1819881-1-joe@dama.to/
>   - Converted from RFC to an actual submission.
>   - Updated based on Leon's feedback to use the DMA IOVA API. See individ=
ual
>     patches for update information.
>
> RFCv2: https://lore.kernel.org/netdev/20260312223457.1999489-1-joe@dama.t=
o/
>   - Some bugs were discovered shortly after sending: incorrect handling o=
f the
>     shared header space and a bug in the unmap path in the TX completion.
>     Sorry about that; I was more careful this time.
>   - On that note: this rfc includes a test.
>
> RFCv1: https://lore.kernel.org/netdev/20260310212209.2263939-1-joe@dama.t=
o/
>
> Joe Damato (12):
>   net: tso: Introduce tso_dma_map
>   net: tso: Add tso_dma_map helpers
>   net: bnxt: Export bnxt_xmit_get_cfa_action
>   net: bnxt: Add a helper for tx_bd_ext
>   net: bnxt: Use dma_unmap_len for TX completion unmapping
>   net: bnxt: Add TX inline buffer infrastructure
>   net: bnxt: Add boilerplate GSO code
>   net: bnxt: Implement software USO
>   net: bnxt: Add SW GSO completion and teardown support
>   net: bnxt: Dispatch to SW USO
>   net: netdevsim: Add support for SW USO
>   selftests: drv-net: Add USO test
>
>  drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 190 +++++++++---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  33 +++
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 236 +++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  31 ++
>  drivers/net/netdevsim/netdev.c                | 100 ++++++-
>  include/linux/skbuff.h                        |  11 +
>  include/net/tso.h                             |  61 ++++
>  net/core/tso.c                                | 273 ++++++++++++++++++
>  tools/testing/selftests/drivers/net/Makefile  |   1 +
>  tools/testing/selftests/drivers/net/uso.py    |  96 ++++++
>  12 files changed, 1013 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
>  create mode 100755 tools/testing/selftests/drivers/net/uso.py
>
>
> base-commit: 9f4960b94f1a044f76da98a765d6cbd294c22c92
> --
> 2.52.0
>

--000000000000992caa064d846865
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMClwVCDIzIfrgd31IMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTM1MloXDTI3MDYyMTEzNTM1MlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGQ2hlYmJpMQ4wDAYDVQQqEwVQYXZhbjEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANGpTISzTrmZguibdFYqGCCUbwwdtM+YnwrLTw7HCfW+biD/WfxA5JKBJm81QJINtFKEiB/AKz2a
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDabVCT
lcnJkOMJfise6X9s0TH8+StLO+Bam2cgrzvwjzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjEwODE1NDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCH+QTOJY41CTjgMgc0i6x+9GAXg3h0HtO5ZFBAu4ol
rxN/UmrOj3YLCgqGnvnoggrQ6hDLZET9vqfvTLR/NSEE5PUGY3QzhEgrgV0uZpFOhM80Bdu0Rehf
EnvZY2XxUqEf1GgCD5yINUeXoU6uOMggsuPD7yWw9PNwiYcQW6694LeHC5KA6bdVRNIcMP5s/YNb
AUJgF637CuQd/nE2KrX2oyPOFLCE0N3Y6+1olSNYzWmdapMxmR1yIUT3t+Nr2SqJVhwzwjbbMC/u
OhSAKoyjXpQW98+n96C56MKGgXxVZvpkgIkt2A1kXEBrEuhK3lRbo/pST0PPj2e5GrZcLmTL
--000000000000992caa064d846865--

