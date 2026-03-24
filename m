Return-Path: <netdev+bounces-270829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEBjFYLhwWlhXgQAu9opvQ
	(envelope-from <netdev+bounces-270829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:57:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C249730014B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73FA7310D44C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30744365A1B;
	Tue, 24 Mar 2026 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gDVJuI0B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214634FF55
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313280; cv=pass; b=Z77vOMkTUvr8RsRybTbrabh2MYQRPGXHyQt3n1AJ6oieKfSct13rqX1DB1FzKRnGEiqcnS37niDE2rx0Uv4wcZWmOZgEoy2+6CqU3EGMk8B+dyXyll1Wzux3biAqGSRije0/WkKz4r3uRG7tyPdsX5cPrgfIq9z69n6W5wtM9y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313280; c=relaxed/simple;
	bh=fYORsdaZqq8CevjqHOe55w4Zj/MdF++Rya6TuwfztUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rANj83HL4BNzMvKbMskjcml0MA908JgIdqPzlkkjgPDQv9RJSEZguvYPQgsLFA45m2v6Ln3MTk9Qrgj6AxNBd75XZ39zEEsyfO4Wi/5g28ssaluYBcNtppkTTxZe/xp5/4U23KSEwSyIZeOwRTe4zD5Y/p18A2YSDyqegBsQH8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gDVJuI0B; arc=pass smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56ceded5a11so877940e0c.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774313278; x=1774918078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYORsdaZqq8CevjqHOe55w4Zj/MdF++Rya6TuwfztUw=;
        b=Pt2QNXGMHx5r1cjzEiJwIx88jkwW8F7BeiX4wd8hrbyBLecrzs9RPVFYJGDZogK+2I
         0CCJRsKvIb5dibNcwge9uB9v+gAxbH9UDyVTpvmuE4aFp2t+Q0XsO45VUgQdKDQwjQXU
         QYQzMb63nl/SU2mp7Cf4lVYMnad0M1FXZUYcTNVkTbcR3cOIDtJpKh0hqh/cVgxpTvHT
         +A81c9AcYG9M1lBBSSH1kOILdtfunKSThVRLucKjKKfZKnKSwVrMCE8da5Nn8q7N8UP2
         vTvxLHuzZT72d34Vej9a50b6HK+47xXT00OBJvGyyB0R4+N7glorJGwSR0JjB44uGnIT
         BEQQ==
X-Gm-Message-State: AOJu0YzAY5AE0dfiAJOhkjUMH/so1CJxjLN0XCI0KQqpspKCFA0M53GY
	2xqgqwqTgEK/7Q/cLso/snArofD2dVeZC4aDToEMRYvB72upMerEXSziW8ZcaAJlqICC5X3dZIU
	XEjCHbKdoRDNPWGtTK8CMQEKfC3VhypSXTXvp12Fw/aroCx7/MKx5aAN1tHVZNN+JkG8/hXi1J2
	QLUsDeOWuXyjSpGDgaWavxOMckhfJ68WfPfFkhmYcNnJ7A9Vlw8ANvc1epvwrjf8p6OY6C4D83a
	w7pRRQRCvA=
X-Gm-Gg: ATEYQzz/D6qWVwvOAvCKbTXiQLM1eqvY5zqR7Yk6VMbOkj/UyV+jKvw+ibgvYu94pwu
	HUHYhrqXpOVmAM0zdQ1E1xjV/Ung+NcK7GaSe4GsHVk3V/8l+hr3faW0m6qMZDBQp/EjVWrJI2G
	GjKm91054hZD+HPDQHYUVT+km+1rpOhSYWb8/1EWiymAyPaH2EApfCG3vYiMiiUx+YOI/dsnfnR
	QMHoGibjtQI9ynfvcmvlSES1Tw79miscWQDoYh8UWLpbg8KAFbgcGJO2PSEH8WiNs3GJ0RunK2y
	57XXqVnxYY1kbA3+I7ioF3wXwFr0+82nU42yU1a2/S339c9TuajRKdIdgVYotph92v6pybqQs1T
	ayEv5ysGbwekeMhi1CFlefb2hg3SmgOD0dBzHpuOo4tLU797vJJjgvJ2AVMb7ugLthLQxqI/EsZ
	+GMFB/UtJ3+Z1wQb8lHuvbzosZBNCGt38Y4/qQTzHPXyZxYDfOyERKyJm1gRA=
X-Received: by 2002:a05:6122:a22:b0:56c:d67a:64f1 with SMTP id 71dfb90a1353d-56cde323c29mr6814195e0c.3.1774313277375;
        Mon, 23 Mar 2026 17:47:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56cddb6e2basm1808938e0c.1.2026.03.23.17.47.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2026 17:47:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-66933f7d630so2477648a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774313276; cv=none;
        d=google.com; s=arc-20240605;
        b=CnHIfrusdbMRlxMgpAV2PCep0wzdWV3wctsQupd6NfO9M/T+M+TSRvffJVaFP7MTTh
         zCfh1hqbZzEiAvrTkdB3yF/0ERsnXWgVCQZmOxEKv0Od/+wu5wh26/jOhX9mhCcNBIye
         lW/v/AnKYIhhKC1Zvmr95635LZs0UlphtmhL0WCsouN/kLSTTbaNSxf0j2JN8CG6X6lE
         pesan+xPVK5PdtSZPCiBTis+PdJHf//yEuz1apzDoXKqigvkgINO1NRqr9Se5YMe1oRA
         Xd4w2SgqhPdEaVXLJ4SKvNT5/g72ZIvsdn3DVi1jK+6t4lGDHxywTINglQPUGpC5/7aD
         BSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fYORsdaZqq8CevjqHOe55w4Zj/MdF++Rya6TuwfztUw=;
        fh=/EEQG7VnFxFVbqpDxP/iqBgMbtnoUkvmBX4UHtJyAI8=;
        b=dU9kleS/A4cdU4TEamS3K3adv9amnDRwCatKhnbzLMerFU/amRk9a5btU9PggGBzlZ
         hTsNL/3L2OhNZpg70SMwy/xDbUZUdzS8ygV4kWVxb9K6RZvqRIu93/iT6WGixJOF+msk
         jRUZCNO99IEBeeDj4jvMcfVt6533bk3xbjAVkoiCRdWBQYMmxLDFT1D6163IYTWqleu8
         SX8KoNz63dFpW/xVGHy2ftP1HxI8p5wRNff5VTGYQPMZ48FUBar1FxyeMIigrYvhlPdt
         W2M4/VFgVG4MGQDkEsKJoQ+471jha3AER7Mn/G93Ot+fQKP4hTd4hl5uBx690AoZ97hs
         rL+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774313276; x=1774918076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fYORsdaZqq8CevjqHOe55w4Zj/MdF++Rya6TuwfztUw=;
        b=gDVJuI0BFVk9y/oiRsCVm+icGpEkn5Phnaw6UAwAaBlrmhUtu9blqx/R2WotteXuqp
         BjL95Lrln7+Fu3CEcU35GkQsEbQCE70lc3WfUi+rmpHaJFW5DZiFYkSXgsbujRwjpwcQ
         e3gI89mFTk3Y4SSiZ/fg7WJooWNNA+SBWP6eY=
X-Received: by 2002:a05:6402:4542:b0:667:ddf7:7d9d with SMTP id 4fb4d7f45d1cf-668c971954bmr7635455a12.10.1774313275848;
        Mon, 23 Mar 2026 17:47:55 -0700 (PDT)
X-Received: by 2002:a05:6402:4542:b0:667:ddf7:7d9d with SMTP id
 4fb4d7f45d1cf-668c971954bmr7635430a12.10.1774313275425; Mon, 23 Mar 2026
 17:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320012501.2033548-1-sdf@fomichev.me> <20260320012501.2033548-8-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-8-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Mar 2026 17:47:43 -0700
X-Gm-Features: AQROBzA-_AUUB6-xri1Ls7aYRImwmpFhYIiqzLVvcCXA93ChCnVc1sxi6-ZS8to
Message-ID: <CACKFLimO_K4qRb2Tnio-0xa6U1xmTEbz0Q-rzC7RqygQOBLnpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/13] bnxt: convert to ndo_set_rx_mode_async
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, alexanderduyck@fb.com, 
	kernel-team@meta.com, johannes@sipsolutions.net, sd@queasysnail.net, 
	jianbol@nvidia.com, dtatulea@nvidia.com, mohsin.bashr@gmail.com, 
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com, 
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008bcb32064dba80c7"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270829-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: C249730014B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000008bcb32064dba80c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 6:25=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
> bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
> now take explicit uc/mc list parameters and iterate with
> netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.
>
> The bnxt_cfg_rx_mode internal caller passes the real lists under
> netif_addr_lock_bh.
>
> BNXT_RX_MASK_SP_EVENT is still used here, next patch converts to
> the direct call.
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000008bcb32064dba80c7
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDQUe5+
MnF5gGNR7DKTscnoSulx7eb9g2hc5867TiEBijAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjQwMDQ3NTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA82A5a/zCgoE7aNYo3a3h9KK5gAHJbcIbIEKXP1UiO
YZ/CuT++ELFmS8Zm05ECPgmPyHK3wyVZjYXmQ17PNTPa+nbuXahezcvHv9lP5b/m/P6wQeQSGZ6W
g/y/XDzfd8yEtjX8KzuVGheMtfzbECTHWSXxhVSOn9AvHFu0OWrW+6Rna+1cuO1CP+5COvpsgUP7
/lknTSHSX8OcA52tbFKwgd8oOu1GiuaULHkEttX5HFrf00ux5IrQqatxpbAfV5avd7G5dY6qQn08
JDIiMsNE304h5G4QGxRzT6OPZ1hXKBMMLUb/aUhlU4wlQ+BptcoZhjgyXEP56fIuGgJGPwjL
--0000000000008bcb32064dba80c7--

