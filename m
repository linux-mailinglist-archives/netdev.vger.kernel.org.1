Return-Path: <netdev+bounces-289141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDxQCGpOC2o7FQUAu9opvQ
	(envelope-from <netdev+bounces-289141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:37:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B5571B13
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BB97300BCA0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F6480DC6;
	Mon, 18 May 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcY3k3e1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011821E091
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125860; cv=pass; b=IuqBINaGH2Vw7McPHzS3/yuzv42dVRNeB9I9MLI8XU3l37aXsQZfJVPuyjVe7ErZCTPufymug/gASV2AlOI+QxtBRkxKHIFez+k48C5U1L1XIHudNPozwYLRv9jpBp9Nq4MdGMIRfyP/FbWUcpGKudIXF7AcLPZEkjxCNRtDMcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125860; c=relaxed/simple;
	bh=/+eYJXH7gN4r65YNa1ZSXuRYVlMzoV2VqXvUAVRKLoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlR5VQbRVY+o22yjbj74S4J6w1rbIASeZt3X3OA5rxQnqwWKbDIF903+90p7AP4pdtrDhwyEw5JahAg2gqSztUah++7lfQbkej2gVZ3QlSCGrZ5pTHhO3RktFxM/RIB48v5HCqVa5B5SU8kk2/67+/sscF27RM+Vh0M8XRra/uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcY3k3e1; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4042905015cso2217900fac.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125859; cv=none;
        d=google.com; s=arc-20240605;
        b=O0B4J0RQXW/Nycl02xDo9fgrUC3yulWF0N3iV4PZAGUPCnvbJFlBdKkS3GUfv+w0DK
         DjeGKnVaUmojpFq37ZFYvMSFAuNYUSQi8GW6o5DjFkjLkx7eYRRIiRZp+FqAN0e1V5Cm
         lGwNBVZNsSfPYiKv5nVcR3wtLWaCtW7wVbnbk7G/7m2SP0yTw3y/lynQ/8fm0r8HIdlT
         gGlDaRAAT5LbWo2/DSz+63Lrxe8v8L+wO8iy698uF4YS3iCiYa6nMBzaemQXy1SXYVNA
         9XkR2YI9Bk1YOBygJ8u3VuWOZ3etjx7S/bkulpv8zW5W3cPp40HYoefq76lF7b0M1vmd
         F6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9hWrHG+EnJK1J/mM03YaROFyv2LHSAJiWvpkEvHUvW8=;
        fh=DL4WyA5RiQzm2OQC7RnpQrlj05+2hfrzNdEBn9LU3gI=;
        b=j97DEk5ZLm5FVF1JobvicitB4m0g39zDasOr4ZmLOG+t1OTg3enYtSKYyY9tupY+pr
         U/o3vT9gu6+RfJhmy+jgDReYBb2JSGL3r5l6dHDd0eJjraZuKGrVJ40UsRtyBEheKfi6
         f7RglCKsT5+UqPj+EFj1tWWdrcbePng+HYPmHRWriwQqyrXi9Ahoa4iQjmy0dZcL62mp
         oo9fxqZUwjKVn9XXv6nNr+7Awipca0Rt8tHKdO9LeDbT21nSNFW1Q0VvcTWHhcAcysue
         E+mBgY1iUJGWxA7Qjr1AGaTNu7TCW0aTxZ8aHwDXxMCcY0HuhY1O5GBMl83YmDA9ld5+
         fMyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125859; x=1779730659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hWrHG+EnJK1J/mM03YaROFyv2LHSAJiWvpkEvHUvW8=;
        b=FcY3k3e1hOQU/GOumeuL9KDWzexXSdoFAYuI9S86/EfhgvwtJ8JTQZCg/CO6qP1VsC
         McOufRaFq1lE42lpDebyJRLkLKtkO3eCBi5g5i3soj9VVvOF9T2fD78oV4K0yYtoio6n
         Xodz/1qZZzCm4cX7l6S2mI8DtM3zirDBGIiS3hT2PLJYiq2LqeYNhLyxjZUr6laocU9I
         DPPwcpXSk/cP7TR4w6hpYoppRrnCWaoBD0opuwaDSskpq4nzlLhzEx1UdijHAatUVX8Y
         GswQQljZZs7y5efCxag9rnovnPpGkWGB1E5w0+qQpJ9JuXE1p2xBrnQIvPZDEwbVmEfU
         Fusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125859; x=1779730659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hWrHG+EnJK1J/mM03YaROFyv2LHSAJiWvpkEvHUvW8=;
        b=jLoL0loN827+DkPeefaBjSosGqVt1zrEC+8WbfKAmLvsNpDxq4VM6JDs0ezLp0Zu9I
         QrK72wd9bbOjniJ5rlrEHEmfINpq+UQyzCUtQYUzrcpUFQ9eLiDnNVplxXtOaY7GTsma
         k5lrb8rxzqbTJ1Y1CmUKZnSUx18ME7CF2xzoWZb2HWt8r3f/hSKOsYhKxKRhYC9fbmbX
         XG902YvOytkbUdsdANGDTR/JScVRUF2S+VK/JOfKIi0uajGAZr4Gfz4KNiVt/H/55/1/
         KBytdGqpPlznUL/3lVSDU8Qg/6UHEkb9MVieATIMOU4qeZ2UcrVBrcYd66J5N3aDUhRi
         EirQ==
X-Gm-Message-State: AOJu0YyCWzMtKCUgGRmlfhaeHAyMJcN8exjY/tfTfZFleCnBNoLbXua4
	L8Q5emg94g/4UJ6W4/PCjt3SPvbtBaSxAJDFCcMb5SDrJq6TKxbvA1b0XOX8v/F63evrlKqjX8K
	fTmoB1bmtRy8mSw2KMKo7af3sogDfHAs=
X-Gm-Gg: Acq92OHG5YWAQqeGuRYusM9ndhQwS/3QoWnpp9v0KW3128RrjyEjR89XHpDMkSPPFVw
	Lfs8srywF9hrcp/PssWWxOMk5V0DWZGWSCSEgXSXPZ6eb/HtLw+22/5+33Ixio71YXYLQetMt/o
	aj07+RpjIEuIFx6qeyHBpdB7MoIFuFdVhIrdgjo2htYfDql7C+FLx9+y+oAo1J2340fxye89c/9
	GNsZvLKsINO+Inx9Gw0icHF2s1j13SiwEy+NRMYgGudX3W5gtNJhxj7+vMGoMy9VU2ZqrvSkdwX
	qGAcpEj8QjNXIBUa4fn5lfuR+pVenf4b88SkGA==
X-Received: by 2002:a05:6820:1625:b0:69b:544f:b2e1 with SMTP id
 006d021491bc7-69c942ae156mr10711381eaf.2.1779125858555; Mon, 18 May 2026
 10:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517201814.222563-1-devnexen@gmail.com> <agsu4MoBYWPFEmpZ@devvm7509.cco0.facebook.com>
In-Reply-To: <agsu4MoBYWPFEmpZ@devvm7509.cco0.facebook.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 18 May 2026 18:37:27 +0100
X-Gm-Features: AVHnY4KnGBZIa09cahFXfBDEftiTT5hR2qvTT-rV9LDxP_wZ2F78wgLrb5sFiVE
Message-ID: <CA+XhMqzBHE5_zzqRhWnjo5K32S6rK78RgF_YvM-ut9O+XYbFig@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: reject TX dma-buf with non-page-aligned
 size or SG length
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-289141-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 322B5571B13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > If the real exported already export page-aligned, why does it need
  > to go into net/stable?

  That sentence was meant as "this won't break legit callers", not
  "the OOB is unreachable" =E2=80=94 sorry, badly phrased. The reachability
  doesn't depend on the exporter: bind accepts any dmabuf->size,
  allocates tx_vec sized size / PAGE_SIZE, and net_devmem_get_niov_at()
  indexes tx_vec[virt_addr / PAGE_SIZE] with only "virt_addr <
  dmabuf->size" as the check. size =3D N*PAGE_SIZE + r lets iov_base
  =3D N*PAGE_SIZE pass the bound check and read tx_vec[N]. dma-buf
  itself doesn't require dmabuf->size to be page-aligned; rejecting
  that layout is the bind path's job, not the exporter's. I'll rewrite
  the commit message around that.

  > why not do this check on both rx and tx?

  You're right on the SG-length check =E2=80=94 RX runs the same
  num_niovs =3D len / PAGE_SIZE with gen_pool covering the full byte
  len, so a non-page-multiple non-final SG entry is malformed there
  too (no OOB, but still wrong). v2 will hoist it out of the TX
  branch. The size-multiple check stays TX-only =E2=80=94 tx_vec is the onl=
y
  allocation sized off dmabuf->size / PAGE_SIZE.

  Also taking Bobby's nit, dropping the bool todevice.

Cheers

