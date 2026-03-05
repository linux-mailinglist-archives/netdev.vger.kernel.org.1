Return-Path: <netdev+bounces-264242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCiUMB9MqWk14AAAu9opvQ
	(envelope-from <netdev+bounces-264242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:25:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DD20E576
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD22D303225D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2463783D0;
	Thu,  5 Mar 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZdkbqenW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A842378819
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702744; cv=pass; b=nvOL+LLCL1GmV3N3tQXVHXMUcc9NY4hlD0FSWvo1HfJIZjWiuiCCheswJJmqifEgCKsggvjpwQhqHp+gNtD4lvOThMuoRqqhnDUaDHhLk170f7TI30fBtED+TY/H8RD6mJY2q/3z7M9Xi2/U31TTua9y3PrCcFanP0nLZwbTAdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702744; c=relaxed/simple;
	bh=irVUMqwparnMf8IefxsOwq4285n4NoeANstVlkr1N6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXpP2hdD3719DJOdbmktsujuSJIX562uE1qW5RTpMFOLDEKPK00rgiZjFZpym+IXI1Y94Ltla7EDUwvuUneQaeC86AlfH8C15EvY8RqTM3Vd2QMIp9jyKgkrKzGUOQAzJQVqLmPKP5CjQ5gdIT2X7CPlxEpWrEibSn9r8AgILYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZdkbqenW; arc=pass smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-40f387a688dso2291609fac.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702742; x=1773307542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xICsYpHdVQ+7oYtPbLtwbCS+HkCosggcskmGjhgsFA=;
        b=ZiMfqzoMBO6IFZPTO+Kj1qwyX5n7OhehjPElnqQNxo40OjmyxkNQdVMMA3uZGk1oz0
         m9PlDtkzsSPL9EEsQicQ0k4DDdmLZGEiLeTswFvRkHrexMs8ynktSeWaEFo4IjBpdLpF
         8h+xUNE8RHbsmQNC1HrJckOcGbsHJ+Cp4VRMfGfYTG1DUtoauXmuMcvNgRZn2F9O/f6h
         L1291SbR/ewrVWctljCX/m2y2dHMLhdOMHn/C01I8gdAVwslDecq0feQq3JBCMix/UCh
         A/RHUVJcz1eS5+q0ZJ84I/zxckZ8M63dXzGenpZkRVbRRWXAuQbTd7wflGjh9dKD7a4F
         49Ew==
X-Forwarded-Encrypted: i=2; AJvYcCWuDo5VM/GiZNAqNRnX5uBxzrSjK/dm/iVfI6xAZAXGaXfQNgrUNKLyL2EmuSUD8FN7nLVCSqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpwkQt/9G00bN1ExnirFXj7H50x3mDPCKfWqWikk0bfooAqjTb
	GBPGfXGs6Tc6251dh+QlDpWVQaiTQaKg5eOSY2qVA5snbYMBwpOdhP8SsJIWWGaVPDQR3WXAk/n
	Mrh+VMeI4H5xlCipoLntqXUCABaJgQY0L6Y78RYwBsni1amy/dsZaBfJ9gjsQDcVH+sF1UzD18P
	1idgQe4UAk38cpxnZtcUTvoWsGJGsQhRIb/JC3UnxWUg75WpA9yp1iHhEc1ZEVmUs3nPlk7X/l0
	K5vjbgY5VY=
X-Gm-Gg: ATEYQzz8zoa2F0AfTJGDZP5AtbjKiK8tLRSh9gaN/2Go1dNBSXjgZVQ8k2wNo/528bv
	Z+dVT/mE9RYh26SOJTqsPALtHSSxDp7y/nzFjSSiCZOR5hJ025zwsC8mTW7Ppm0f+fE9YLo4o5T
	HdkxpZ8PORK62mG/gVP1yIH+Wao9OcK2D/D6XA3LR26c/nxfKdXJmY7dnhdFZBWQbtHNDHiDPWL
	smfNjQVnJ4nv7mbw/lnIuUuXKnVL/Owi+Lj8CuOurAS2568XQ3D8ft2nx5ZTWGCteQOO4EocnKZ
	TaZyLXwIC8pIHu4nRXagGQLQv2VQ3lda4vemWkckVjDqWN4tWQEKlxr13hI0MB1kwpX95LIvKDS
	A8EFUhF0MF2w2GXbvA9KhRpRPUhe+fSV1NRn3uqAIyGZ3F/DrfLSUD1YtByFJQKgMuyO3SC64d6
	eGHvZo09K8Ipxem5uXVtb7hFl9BikDWJE24Mg9sTZSUucFo8E12c8YNyZe
X-Received: by 2002:a05:6871:2b86:b0:416:b429:28e with SMTP id 586e51a60fabf-416b4290b37mr2477065fac.20.1772702742006;
        Thu, 05 Mar 2026 01:25:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4160d27d3a2sm2975898fac.13.2026.03.05.01.25.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:25:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8297d261a67so492545b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772702740; cv=none;
        d=google.com; s=arc-20240605;
        b=e1qimCtow4FiVuLdj8VVwPnWjZiXMkKCQnRO0zUn03ku+l5vMqU95H6VwbyxbYAIT+
         kgM43BndyqPz+MiEas15ZdOPrdFbzG8GjJ0mY+F6s+rGGVBnnNDiwiVJs0NdCpmGfF00
         efXnbMxQa//7rBXGR5azXKNtQ0kHFjdm42ilFoPUf/7NlVcvI28JElzBLups5jd6TyQ0
         SOLi+ZFX1lmxG2b6iOBoExKgtCMi0u9O707W/0avmg2PwqX28IZ9aBBKS+tvgyslpXc+
         dYlsO+DVeqFF0UZfhWwIksHMCpw8vxBxcgwF6ePSn57rjuTztZTblqTF5oae3OMnPjPl
         Lo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2xICsYpHdVQ+7oYtPbLtwbCS+HkCosggcskmGjhgsFA=;
        fh=fzvCL/R+9wlsKdh1IOk4mG0PGmzGLX2GccgbHrsyyNg=;
        b=Im+bcmpTdnnhwOnzWkj+c0JroESs5Dd4aRqN51MS6NxZdJ1oilbhECUzVFlOhlTz7H
         wQeGNxEOJaSzRF+P9ns/sUeD3/JANBq4OJ6YWH9qu1xFZ4mXc7X+7aXUZJIAPt9kS6SP
         Zpv7Y4a2PHdlonv40DSX5LgfgGckcsAeB4/JzI1yaxIyZc+433QzWarDiaIK1XMmnGrR
         N3BgvDZ3qKXfWc+itst+bJATOC547aOt5GxNfLwGe92knCBp5FwMuLyJXjrE/yJgE5oO
         Hf4BBQAxyWAACfHpep6n051hbAFdFkcuCp9TZhFWCNhcI6EnBxJrhNyHvegIZUAc6dEi
         NeVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772702740; x=1773307540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2xICsYpHdVQ+7oYtPbLtwbCS+HkCosggcskmGjhgsFA=;
        b=ZdkbqenWKRzisn7aOui7aLb5FaUZejy6OksuIK72LXiwU6d/CEtqCzLpt0u4tTKFS9
         5R5sf+scwaD5hApUkfZ3lB/XkyKwNwg1kP4XO9CvtNSAJo/fq0EyN8XTQgmbdjRPYbr3
         1zeG6JPdS/e7kkU1p/MDPQqE9nvXrLwWxnzQk=
X-Forwarded-Encrypted: i=1; AJvYcCW4zBexmpBWZLPBQMrjONiG56YhXYP8xyfG21UWaq3y6+vyRWnZQLLfpsj1GLF9yDu5VYZe10Q=@vger.kernel.org
X-Received: by 2002:a05:6a00:2e1f:b0:7fb:cf05:93cb with SMTP id d2e1a72fcca58-82972b7df71mr4082450b3a.1.1772702740291;
        Thu, 05 Mar 2026 01:25:40 -0800 (PST)
X-Received: by 2002:a05:6a00:2e1f:b0:7fb:cf05:93cb with SMTP id
 d2e1a72fcca58-82972b7df71mr4082439b3a.1.1772702739818; Thu, 05 Mar 2026
 01:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304131855.3225539-1-bjorn@kernel.org>
In-Reply-To: <20260304131855.3225539-1-bjorn@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 5 Mar 2026 14:55:27 +0530
X-Gm-Features: AaiRm52Y89lYHjruwmeefdiVUQxLjY5nBghjtlkES1yuGch-T7ZOXwwZ_yXSG7w
Message-ID: <CALs4sv1ndtPm0bu9hZ5tNHQYUDG63V_A61zAFOiqW1eR5+3_qg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] ethtool: Dynamic RSS context indirection
 table resizing
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000026326a064c4385ef"
X-Rspamd-Queue-Id: 847DD20E576
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264242-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Action: no action

--00000000000026326a064c4385ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:49=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Hi!
>
> Some NICs (e.g. bnxt) change their RSS indirection table size based on
> the queue count, because the hardware table is a shared resource. The
> ethtool core locks ctx->indir_size at context creation, so drivers
> have to reject channel changes when RSS contexts exist.
>
> This series adds resize helpers and wires them up in bnxt.

Tested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>


>
> Patch 1 adds core helpers:
>   ethtool_rxfh_can_resize() - read-only validation
>   ethtool_rxfh_resize() - fold/unfold a raw table in place
>   ethtool_rxfh_ctxs_can_resize() - validate all non-default contexts
>   ethtool_rxfh_ctxs_resize() - resize all non-default contexts,
>     with locking and RSS_NTF notifications
>
> Patch 2 uses them in bnxt_set_channels(). Validation runs before
> bnxt_close_nic(); actual resize is deferred until after. RSS table
> size only changes on P5 chips with older firmware.
>
> Patch 3 adds HW tests in rss_drv.py (devices without dynamic table
> sizing are skipped):
>   resize_periodic - fold/unfold with a non-default [3,2,1,0]xN
>     pattern, verifying exact content preservation (main + ctx)
>   resize_nonperiodic_reject - non-periodic table blocks channel
>     reduction, with an extra periodic context to exercise
>     multi-context validation (main + ctx)
>   resize_nonperiodic_no_corruption - failed resize leaves table
>     contents and channel count unchanged (main + ctx)
>
> Running the tests:
>
>   # On real hardware
>   sudo NETIF=3Deth0 ./rss_drv.py
>
> Changes v1 -> v2:
>
>  - Dropped netdevsim support and netdevsim selftest (Jakub)
>  - Split ethtool_rxfh_contexts_resize_all() into separate validate
>    (ethtool_rxfh_ctxs_can_resize) and apply (ethtool_rxfh_ctxs_resize)
>    so drivers can validate before closing the device (Jakub)
>  - Shortened helper names (Jakub)
>  - Replaced scoped_guard(mutex) with explicit mutex_lock/unlock
>    (Jakub)
>  - Removed defensive zero-size check, bare expressions instead of !=3D 0
>    comparisons, ! instead of =3D=3D 0 (Jakub)
>  - In bnxt, moved bnxt_check_rings() before RSS validation and
>    deferred actual resize to after bnxt_close_nic() (Jakub, Michael)
>  - Added comment that RSS table size only changes on P5 chips with
>    older firmware (Michael)
>  - Use non-default [3,2,1,0]xN pattern set via netlink to distinguish
>    correct fold from driver resetting to defaults (Jakub)
>  - Check exact indirection table pattern, not just set(indir) (Jakub)
>  - Use ksft_raises() instead of try/except/else (Jakub)
>  - Removed queue_count=3D8 from NetDrvEnv (Jakub)
>  - Added ksft_variants to resize_nonperiodic_reject for ctx coverage
>  - Added extra periodic context in reject test for multi-context
>    validation coverage
>  - Added resize_nonperiodic_no_corruption test
>
> Open items:
>
>  - No user-controlled minimum table size yet. The plan is to record
>    the user-provided indirection table length in the context (e.g.
>    ctx->user_indir_size) and use it as a floor when folding: reject if
>    new_size < user_indir_size. This way the user's original table size
>    serves as an implicit minimum, preventing the driver from shrinking
>    below what the user intended. Left for a follow-up.
>
>
> Bj=C3=B6rn T=C3=B6pel (3):
>   ethtool: Add RSS indirection table resize helpers
>   bnxt_en: Resize RSS contexts on channel count change
>   selftests: rss_drv: Add RSS indirection table resize tests
>
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  36 +++-
>  include/linux/ethtool.h                       |   4 +
>  net/ethtool/common.c                          | 146 ++++++++++++++++
>  .../selftests/drivers/net/hw/rss_drv.py       | 163 +++++++++++++++++-
>  4 files changed, 338 insertions(+), 11 deletions(-)
>
>
> base-commit: ed0abfe93fd135dac223e87a3c945017b1fa8bfc
> --
> 2.53.0
>

--00000000000026326a064c4385ef
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAiesSE
ZRmQQYIkNATb8cMxa5Dnqk0gDKq2ueJE1i/W5zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMDUwOTI1NDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCg2z1wKPzXxwcA60IkqsNdSS36leg8HPknWz8EwNTD
+poaKT/s2wcCiSGWPwsj0nZVACg/ER4PUW6nVIy64xzUVHzEZpOJ5CGx/y1Q7DV+YFuWV855e/wk
rKx570WT4LTsw8RooRmROHEM38ejpEYUeW7I5S4Z1FQhORdGcSyevAmm6xyvOAAXjMiMVPy10Uqi
/tOYHiCaEzIx39o4M+bAwFaRLelgTSVYSEgdJVZ+/ARPbLxAwv5ceBO0Nmsm1N4WzG00QoNN8MvL
lfONerXuk6w4bRI540uFYbJNle9RUWDu5bMIJ95k+u6El2aRyUKukJDcuhxKlzhS816pOIBv
--00000000000026326a064c4385ef--

