Return-Path: <netdev+bounces-263382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM8dOYg1p2k9fwAAu9opvQ
	(envelope-from <netdev+bounces-263382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:24:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 493BD1F5F0B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF3530177B3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569C396575;
	Tue,  3 Mar 2026 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GLcsZPVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20539656A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565637; cv=pass; b=aET3xmNxKHWZJiw3UzkwHXj9Ke5bys8bmaauHBThsoRz1kNhfmtz4P3I53B2T+QquxUKMY+PexbKRqyAFM++KCBOqucN7oyHnaFDzvn7sl00cEkI8KSeEe8GXi5ObZKAz1NexKeBrbUwb5j2HlLZsdIR+scKbCaCqTXJYHbZcq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565637; c=relaxed/simple;
	bh=OU/2GymgGJ4QgEJz6rxsS2B7KqapFYHoZeuTRsvrGUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfPRiGilbfCrhOh/ChBFpdmbCW4iDv484242azEURq9+quVpOJ9pxXc7GbMONajsjRpi6CrIqfaIJSB5CoekYJ8RCGBUoNPwVvkDqFW2c1wjO2rE7NAdDhOt79q9S/pEZmrzv1EhtAuHQthNVHNt9wfx+OHkvx9UCpEBHpKAz5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GLcsZPVo; arc=pass smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-79885f4a8ffso43609717b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772565635; x=1773170435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ral0D7g3++I9dkn0Anf7piGt8svnedQaxcZV/112nA=;
        b=qArn9FQVVXVXTxr+2y06qTyqYpVhTbIcTkRN9zWCHabZSERIht2/gWDGrKzXNoHHz2
         LD4HufYl7qNjVke8TkTmD+VFNZ8jijU2JZHScTpCDuBbfzJsTtS78dCpG4e/L31gwZuj
         tAsFHOu4Gn5BHsfSeOrEGoG4qDqNdm/lu6VnHsgRRlXa7DLrWl9ROSyVMvFYNx6yZxH+
         WOuRegY1JH3BUJGnP9EzWQeYepnEJw7RTmpYr3dYno2byY7eh3wsM9CWlEpGAiZjG32k
         uBod0Sh0k46VG0wNTqoWZ8uK90eMEiG+GrjdyBI7x1i+RydHssndDffAb5ynlF1sHFG3
         iOQg==
X-Forwarded-Encrypted: i=2; AJvYcCWdiNW1RgCii0xW1QUCssoBoF5C6myib5nOYlLi+aGSKFCIycbnoMAmbhWkWdyeuCajyElMwQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjfh6dmnsyM9+zSvHOrXhBqIYMwfNGVa0KJI31VsDqDLUzeCIv
	DJoayPdVu9KxNue5RsA8r5SnOQ1aA/6IUBC/jCdQSin/3DbglGaZStnv5KO+gaQeSMRXHLow6/s
	xtiBi2C1HCQkzVk25m9dCWbacJL1nDSaeSVsGfSLRe/8eeb+KJDQpAkYYpiZbDnioJjaICFHgXU
	4b6/0/e+aBGXBN0Rpdm81If7r2vITtvuEQ25YuwegzrB6PV6/RUPDiRF5guFahcvnvNfQiicaME
	c0lswRwMjc=
X-Gm-Gg: ATEYQzyXs1WDvq8d+8ON4reruMue+I41LvuG7bkVmKVzvrWAyWjsPoIgX3Sj8cjllnE
	yiOWDznqqrKCzopDZGMbEQ7v/TPrO6v4dkwEvukaQ6G/nzoDCxqLapmn2Ool3aDdkIv0cuoWpVe
	tQ/MhuvZrSc74sPV5p02iarWS9XjpIiNtKeQ8685zQm7UX2Q7HeAHNW8KuXSN3MFy+tTKbiaY+o
	ukNAUYlaul2ItmCc93NyHjpTGRKwqGm6Pzcs1vDlRf6s1nXx7ZPVbsV5WVcpDhXj3hM2+GJs7ee
	suYV1fs+tPeA8uJjbu0UzTkwwcIo6TgqNJXL6qIGtTplcXvBUMIxqDHkL2DXB6+XF8KwR22Rrr7
	SZOiFu9H+Xu/6BhpoSkMk2X1hkEsw5k3dX+yn6NXijFTa6SpW0i7VoEqFOKy0b4b9x3x+yMFAYq
	jMy0oo8Gov6Yy+MTuFLN13V1W0tOaiN+fR0cvwk9GK8mHsI/dGaQIPozXUGmY=
X-Received: by 2002:a05:690c:c01:b0:798:6cdc:b629 with SMTP id 00721157ae682-798855a5f8cmr165353707b3.39.1772565634522;
        Tue, 03 Mar 2026 11:20:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876bf91f7sm22675847b3.14.2026.03.03.11.20.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:20:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8fbf8701e3so609824966b.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772565633; cv=none;
        d=google.com; s=arc-20240605;
        b=WOe85y9hA80w2B7BsDiA2V8i0LINU3HvwxXNqJVJP0+aHYzF2IeKkCCzaBwup74U9S
         X9uYqP4H7ihU4PhPX5qRdwi7vegs8NHRDbGanRzsUDothowj7vLdutRbwYsHqaBxDeZy
         HVKLSb5ew7Kxa8tBApG5iUiCGbJ8ciZnYMJp7ZK0Zas2eu32f4JYuo2WsJ8JNVxB4U/K
         w0jn9beth39CMTASJSpqj3Ue4gpgHriDRAookUheAObQ9MoTYURbY6+7wRhON1yuwXBf
         mBfRgFyKzpwmNgxpl/+22P4t5Z3ULyp+PGI1JW2tYeltsh5Ls3Nl4AziATCC3G2iwwFg
         r3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9ral0D7g3++I9dkn0Anf7piGt8svnedQaxcZV/112nA=;
        fh=lb/HaELtFADTN+skjMvGwcRBR70+zeXlfP2sa8vgmnE=;
        b=JReHghBw1IDf0wnrGf0UCfcVAi8yzAJAsUA9kM/8ANdmS+cLSjgpWMAdxjdj9hjxZA
         5mSvPKyRO+F3NssJURkZiVNiE99P77CsNDqqP8Pif6MzyVlnqRDZJa5Ezc6lWA/jwBRA
         yxSD1Ac+lAgWXidHNtdUXOPIEjFhkKR5zcQcJjr3dDYT8GGJ2aC7/ZIZHF5CgOMjrMIn
         fe2X4HXv+jwIVPUIqMd4EaIWuD0bXrJPso5/hkDGUVULGEuIRfnyO4hglvJKyBWjID2i
         92gvKS3DrGCj10fGlnxWv3IWtT96lzGnTAio/u4Ddjt6J4eJRRLl76byQg6sUZ0YawtZ
         zr/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772565633; x=1773170433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ral0D7g3++I9dkn0Anf7piGt8svnedQaxcZV/112nA=;
        b=GLcsZPVosDHS7z9axOi/TbnoCjGRYcf+IONl7ENt5JnXUJ4YrIiP3am40V2wGLccEs
         bfbBBmG1ifi8NspQiwB/5X6gcQfUurxHN1tnBV6eZXHzW88jRlN0wlGKp8so2YTOoax4
         yLp+KxLW9pBOTFIyqy/Fx0Z5Z7/U3zPhb5crY=
X-Forwarded-Encrypted: i=1; AJvYcCUQcI7LUoK4z0Aj4zzjcyOL/Rw6j1JdNUbwza3UMpEZWAo79aQXnzaOmRDtXoeFhymLrL+6IBM=@vger.kernel.org
X-Received: by 2002:a17:907:3c8e:b0:b93:8ebd:c4a0 with SMTP id a640c23a62f3a-b938ebdd3c3mr842787166b.30.1772565632907;
        Tue, 03 Mar 2026 11:20:32 -0800 (PST)
X-Received: by 2002:a17:907:3c8e:b0:b93:8ebd:c4a0 with SMTP id
 a640c23a62f3a-b938ebdd3c3mr842785166b.30.1772565632412; Tue, 03 Mar 2026
 11:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303181535.2671734-1-bjorn@kernel.org> <20260303181535.2671734-3-bjorn@kernel.org>
In-Reply-To: <20260303181535.2671734-3-bjorn@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 3 Mar 2026 11:20:20 -0800
X-Gm-Features: AaiRm51c9gA2W39YfKe23CAZ2vcrInosW9Ph4W1-mArYEt7MkCkns5D6poe59Ds
Message-ID: <CACKFLimMxnahfcGgWqknzEcyDjFLPo0zqYL6OBTDZT8AHOGe=g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] bnxt_en: Resize RSS contexts on channel
 count change
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e9754d064c2398a3"
X-Rspamd-Queue-Id: 493BD1F5F0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263382-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Action: no action

--000000000000e9754d064c2398a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:15=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> bnxt_set_channels() rejects channel changes that alter the RSS table
> size when IFF_RXFH_CONFIGURED is set, because non-default context
> sizes were locked at creation.

Thanks for the patch.  I want to point out that when running newer FW,
the RSS table size will not change when the channel count changes.  If
FW supports it, we'll always use the largest RSS table size for better
traffic balance.  A few more comments below.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 26fcd52c8a61..7608e5d95630 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -977,11 +977,24 @@ static int bnxt_set_channels(struct net_device *dev=
,
>                 tx_xdp =3D req_rx_rings;
>         }
>
> -       if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=3D
> -           bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
> -           netif_is_rxfh_configured(dev)) {
> -               netdev_warn(dev, "RSS table size change required, RSS tab=
le entries must be default to proceed\n");
> -               return -EINVAL;
> +       if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=3D bnxt_get_nr_rss_c=
txs(bp, bp->rx_nr_rings)) {
> +               u32 new_size =3D bnxt_get_nr_rss_ctxs(bp, req_rx_rings) *=
 BNXT_RSS_TABLE_ENTRIES_P5;

If the table size changes, it must be a P5 chip (and running older
FW).  Addng a comment for this will be useful.

Also, this if statement should be moved below the bnxt_check_rings()
call.  We don't want to change the RSS table unless it is confirmed
that we have enough rings to satisfy the new channels count.

> +               u32 old_size =3D bnxt_get_rxfh_indir_size(dev);
> +
> +               /* Validate context 0 can be resized before mutating anyt=
hing */
> +               if (netif_is_rxfh_configured(dev) &&
> +                   ethtool_rxfh_indir_can_resize(bp->rss_indir_tbl, old_=
size, new_size)) {
> +                       netdev_warn(dev, "RSS table size change not suppo=
rted with current indirection table\n");
> +                       return -EINVAL;
> +               }
> +
> +               rc =3D ethtool_rxfh_contexts_resize_all(dev, new_size);
> +               if (rc)
> +                       return rc;
> +
> +               /* All validated; apply context 0 resize */
> +               if (netif_is_rxfh_configured(dev))
> +                       ethtool_rxfh_indir_resize(bp->rss_indir_tbl, old_=
size, new_size);
>         }
>
>         rc =3D bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, =
tx_xdp);
> --
> 2.53.0
>

--000000000000e9754d064c2398a3
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCdMoVs
Rg99jCHmDXWTWCUPMMLuhIUeB6dHhmgM9l8hVTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMDMxOTIwMzNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBkhty/fvGlfSt6l7Qc0M8sdNPwtHYxH0dOE6cyOebU
uJ3moXqY44FuJRWj6OAjMNzSk6PvoBGefakFwezcRkvgyrEF1HnRUhMHruLTfyIBxx0mlVZemsbz
TzPAXl3SIJDaSl6oGhrZ8mFipZZKi1iHIl8rItcrK3NbswE/gcALfF6ElMUaS96PO5lO0NtGmxZ5
06RBKWKk86qlruxS8Fpm5zutvEClbCJ/CjJROk0NJXTU+6Q93x4ZTw/gIrrOXMQ4CaeVRSMjZHJG
p76z/chC97KXUAJm1Bpdulaodn+7FaidSdUIHUDSB08fHt5vD6zZKgfvxxsnvJzqeApEwVcd
--000000000000e9754d064c2398a3--

