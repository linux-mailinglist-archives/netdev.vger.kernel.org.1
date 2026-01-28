Return-Path: <netdev+bounces-254500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDrYNDeXemku8QEAu9opvQ
	(envelope-from <netdev+bounces-254500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 00:09:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D1EA9D93
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 00:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA9523002D18
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDC326D62;
	Wed, 28 Jan 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="batnflJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D12FFDD8
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641778; cv=pass; b=R7aPwDsmOprVb9Drw0P2WUOTaLoaHsQivNz8ZZi6GZMIo/Oi6B9bedSwRb5l4GHgsW9Ns0r4cuQDuJ0u04hz9tSghvVTGC9D/yzja8rEx1ZNK8WiBjegTSEyAwBtIawP2AzitYwt1BUrqHUjTCs9+8+GoNYV8XhV+zYsxwygueg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641778; c=relaxed/simple;
	bh=FlcHcfBAveDODZSkbiXqV4lwgzwW7VrVTJParzuYhTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsXL/sK2tpS2ZkFGOM6/N6ssRXvbOj8+LuIM2bl3eYaBSs8x+82UHukOzTNLsig0jNPaBtqr4LMeoZSivQw6hOB8fBCW08GTCZpQVAP4MJZAf7UyXikAKlWX5wiqzqxysx5b9ap9bCjWnhBMZeYsAtkySVUR9f5amA9CqRrtlAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=batnflJh; arc=pass smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8887ac841e2so3359096d6.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 15:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769641775; x=1770246575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7QzeCuJMo3KlAU4nscK/9FNrTEXxo6cuRnuYVU/CcQ=;
        b=GrHkKAmTbJVz3xlf9lBhAKLeFUt2nPSXrKrbYQpAM+pI5hDRQ9C3gSCq6eHVa77ZVU
         pYpkAvWIUgrwzNaFpX//SvMf2K95XJAKguG630NJizcqccezfbXs4tsMQqPiZwXBkntL
         XoRtG+lHDVSLUFwHaumBKiu0tc3pl3iPPEsOvxi2pIsQq0WVyD6P6aoOwjCyp2eQN+Xy
         9wvZES3NeMH5ADaxfrodz8T5JMAo/2EB2ybv41gc+9MSwYSKeIVQMKO2pcRkrXJr6N3C
         QZrvkvQhgIJxPdtFZAzI1xPt/rubG+giozRCMsf8P6jg4H1eGsOmodoqJnYnptWpwu2g
         oqAA==
X-Gm-Message-State: AOJu0Yy9hjxLxnIYlqPJT1BVNCfY4aI0J8Pq8zT1AqJllahN07rWDqPS
	3/c8K71/a2TfU0h6+unJ0Bd9t9pCm9dKQYDGd9xrGkMRPPv6FeCwXf8ppAV3vaR3zLlkMbj8+ik
	oa7icrrmMbSyI4OCJS0tgHBGQyea2cTTwazomMKiwytGxZCzMpWud0B0bBKgIXj6BDFAEgSZxWB
	s3bjboZaxHqjMUQzT7SrZ/dsAk+9ZOddXrPtCTKczXrFyHjDZgHUTMGBij+ksNJoNrcyLuogJtG
	s51CElUqLQ=
X-Gm-Gg: AZuq6aJYbcsSbPnjxnRgzMWdGGNrZ1uXOufTb8Mt/fbdLET9gpvVcgY5lxsJUPhWEUo
	dFq6PcQObA8o5TjDcbn8jbBVo/MZ6p6CPPeOc4jQKYcvjwqUiwLbBtGjVlGN1+qYHn1PkVZEFXS
	/3HMzZBGn+mr0Baxi/hgXlIED10qnN3RYud91obGueAiEAD7o0YJ1qTvj3Nu003N2pVYTWSERag
	j7GJ8zA5yBwuGWWmv7o3Q0jFpKUW75mBUr67nLdV+4xaRW5JlaGEqTnBbA58Pw4ZV5bii52ECXr
	phvtlpfU+Tn1FJiz7jKcHwmQpYix53MFO5lenAq80nHpPYmf2s6SgAOLziyQoOyxDpcCToxlaPf
	y1Emm3mx055zYBrtP3jbnY9lUqfo2d4NzS94d9UESeYmEeFQVOwavddZ+tgg7/6qmF7dFb9MJ0n
	e8bpc8uFKv9mqDHlaz97YOVXS16UXSxN6zXzSC5zhSvns+
X-Received: by 2002:a05:6214:f05:b0:894:6db2:ed06 with SMTP id 6a1803df08f44-894cc98a051mr95904426d6.71.1769641775392;
        Wed, 28 Jan 2026 15:09:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d373f745sm4840866d6.26.2026.01.28.15.09.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 15:09:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-658c1f00a09so540293a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 15:09:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769641774; cv=none;
        d=google.com; s=arc-20240605;
        b=EZIuDmQ84/5qxKyU4SdDZ+7X53unQHuRln//g7XnIkZxMPjnUS81APl+IDZaqVQqBB
         fY4UOCS4pSFaQjy/EXZZFJNv/ilTPHIoVnu8TEOy33bSStZKLq8o2Kf75JexxAFWh+Pc
         2DEUhr2ZEyKwHCuLp2jRLFdJvkbOyM/RE24WyDZH0JvzN/2P/gJZawd/pNPKqP60F5GS
         XtrE10jncYhbkeRs30FnT7EwQwx091NPK71SfQKy7MepecEBAULl2C7q9/u62Uiv8Z5q
         3VBJVxZAv2NaJX91dBTWHmwieBkRJhtNMv5zW6mcGxTwzefocfmt1zwQS4+XNIuG7dI2
         iXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m7QzeCuJMo3KlAU4nscK/9FNrTEXxo6cuRnuYVU/CcQ=;
        fh=c37j7FzMCWiGJp9gaXNVZT++tFj1kQIjYDEvbPylJbk=;
        b=VGnTrl0yVNU0LE5jnuHSDwGVV1DsSP6nOYp8kfv9b2WsxUv4w1iehVwPlteOy8aHfX
         U/U7/p6+Mveb5a5YqtqN3JhLj/2Kid8jcZ8yHtr2Y6cffs5TL1YLIDr9YVuMZV6Q2U1v
         zIdjyGNGhLTScBf29VdMQifZygf6gEnnqCDvrIApxXFuTVgU/hMsdGT+0GdyEKXPKmw+
         RScP87jOi0o2M4Ei0/5gduey2maKWCrP19ZIIgHU2AG+kIt9VliIeJhDnNQSJyD9al1R
         Uz3hRzDBhAuCvIcSWsafdLp3Yvt+rArYqjY0xUs9Kvazc6gTM1qXzjOng9gKWxKY75we
         PP6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769641774; x=1770246574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7QzeCuJMo3KlAU4nscK/9FNrTEXxo6cuRnuYVU/CcQ=;
        b=batnflJhe0cyFjRxRjIY05dIN/u5m51zHjp5T+3wm9An9nc+lTnqjCB7T6NCT5utHT
         Ch8Hvxe2sjGLaR0WNCZtXuJzFd8KBZLESMHHleGS9Ev3P/Mre4bk3iUmS5yoiJbmIy7V
         WFVpF6TUg4kbpqR1hredClzQb71vuNEVf7B/c=
X-Received: by 2002:a17:907:2d23:b0:b83:95c7:f87b with SMTP id a640c23a62f3a-b8dab33b49dmr440769566b.37.1769641773679;
        Wed, 28 Jan 2026 15:09:33 -0800 (PST)
X-Received: by 2002:a17:907:2d23:b0:b83:95c7:f87b with SMTP id
 a640c23a62f3a-b8dab33b49dmr440768866b.37.1769641773302; Wed, 28 Jan 2026
 15:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128222718.1679581-1-joe@dama.to>
In-Reply-To: <20260128222718.1679581-1-joe@dama.to>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 28 Jan 2026 15:09:21 -0800
X-Gm-Features: AZwV_QjmZjX6l6uxQyPk_Haey6gU8dW42lJtPE0xprb0td_3-PghXeTpQjbajvI
Message-ID: <CACKFLimN+AOBeesHaiHPZM-OFUtLNeL-3GFtLUDCdv6_RGkEJg@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Allow ntuple filters for drops
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, shruti.parab@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005398a406497ad581"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-254500-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 07D1EA9D93
X-Rspamd-Action: no action

--0000000000005398a406497ad581
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 2:27=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> It appears that in commit 7efd79c0e689 ("bnxt_en: Add drop action
> support for ntuple"), bnxt gained support for ntuple filters for packet
> drops.
>
> However, support for this does not seem to work in recent kernels or
> against net-next:
>
>   % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
>     rmgr: Cannot insert RX class rule: Operation not supported
>     Cannot insert classification rule
>
> The issue is that the existing code uses ethtool_get_flow_spec_ring_vf,
> which will return a non-zero value if the ring_cookie is set to
> RX_CLS_FLOW_DISC, which then causes bnxt_add_ntuple_cls_rule to return
> -EOPNOTSUPP because it thinks the user is trying to set an ntuple filter
> for a vf.
>
> Fix this by first checking that the ring_cookie is not RX_CLS_FLOW_DISC.

Please add the Fixes tag.  It looks like the drop action never worked
properly because of the vf check.

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 6b15fedbb16f..fd32231bf8e0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1353,10 +1353,12 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *=
bp,
>         if (!bp->vnic_info)
>                 return -EAGAIN;
>
> -       vf =3D ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
> -       ring =3D ethtool_get_flow_spec_ring(fs->ring_cookie);
> -       if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
> -               return -EOPNOTSUPP;
> +       if (fs->ring_cookie !=3D RX_CLS_FLOW_DISC) {
> +               vf =3D ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
> +               ring =3D ethtool_get_flow_spec_ring(fs->ring_cookie);
> +               if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)

I think the FLOW_MAC_EXT and FLOW_EXT checks should be done unconditionally=
.

Alternatively, we can also change ethtool_get_flow_spec_ring_vf() to
check that the cookie is not RX_CLS_FLOW_DISC or RX_CLS_FLOW_WAKE.

Thanks.

> +                       return -EOPNOTSUPP;
> +       }

--0000000000005398a406497ad581
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAsRGkd
mbZtKzhSfHvyq92jCIWw/kHLilhNE70MJwUOPTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMjgyMzA5MzRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA9XsOmCg6n9dN0/6J8f9DAaoH+0+LBZIlJIo3AQu2w
1vinuNXp6WmkP3DxTOAZ03/U0GTfe7OUNxePMN3pekCDaKQlnnDFXTBKy6R4gtrAbvANBmnGkiTH
Z7n+SqdyBpdA/mfe30O8zR1CxQFpdhIno6HA3Spk7jdkBhLrrinlSknFn+FtESTXYWWa8Y1eVBW6
gfphl5xmC+rI6zPLNs96CJaQpEXLN2O9CCUYs7StxI+qvx5jE3ithN8Unn+8XRN1boilHtdJ4OeK
o9rEc1w6nmPb3lCg6oQQokp+vwXVoV6dtmsBFPRmg87dodUupyBIJ1AhsQ3w+fQGCsNDh1De
--0000000000005398a406497ad581--

