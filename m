Return-Path: <netdev+bounces-279672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJvIKkLU5WmmoQEAu9opvQ
	(envelope-from <netdev+bounces-279672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA4427AF3
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81FB13001321
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49898382F18;
	Mon, 20 Apr 2026 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBFHCkDw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CC2D738A
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669759; cv=pass; b=Go4wvf++fakJCQ7NTbbII6PdLg76eoTO9jR3Fun66xb619wbVLGCIbxWvPM7iF1C0+v6r9co6D2rmdR/BKdGMbrLwOkyyoE8EklF83ZmW4cfh4cinQkIT6tM4DQcveaeCvEqZ8GROjjd5ukpcGf8QdvzJu6sJUG9l/Wp38Teomg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669759; c=relaxed/simple;
	bh=z6RjGPSiK8r0oWXY5W6DEUzXSooC04ggiIIVzrIwlyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZThx/msKoEs1fwCz3PJheAiRpzzJN12uiX5WQfOpJG7IpJ7zPvWeUW3gvXP2UGDbIfBXhrMj4FX4PJRCpeq9in+xByHH2gJSP2MhiqXCjkRKWmYtwckeFHjl13cXKRx+dqJOIFVrfdVcUk732HL9xuln0+enlVNuHMJ2os8oJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBFHCkDw; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d75bfb259so20363251cf.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 00:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776669757; cv=none;
        d=google.com; s=arc-20240605;
        b=DNEMKYGSMwyxSTQEGs+FuxM6BSfPdYwG+MGOIEHsGjrXMLu/d5UvBsLrMt2CBXTwD3
         gkCo4J2sw3Abr7v6RGJfIxcucCfHi79i4AwoygeX7YAH5dlMU4vKgULdlEn7HiI57WCI
         W9nUAhcFpuEDM6Kkkkti36fjJuF2ZcRM7PMbHAZ6fy1khsSkwsQcRAQ70VPh6EE+F1SM
         QjZ8q0ewKeRTi5lOT8uHq/Cw0p+7ge29YnPCw7VPFMF0AQYt+4/nEjGuixnxocUr1r8Z
         5+smmrccbtyhtf5nE/7HQaZQzH7VdkYCFG/ZflN/CUordAPKEYdG38tU6LGuRGGSHgki
         Sevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KVOChXZq0zoMztJw+hJ88VSw+ye8042PpZuah7BunBU=;
        fh=lWxYg71sBwlmJGiZ/9eG/kV0juEdXfosdQwBgDF0kzk=;
        b=NhTRv3FocImPS50M86RWid7poiYvGxFi3GaN03pnw/LsQUVUY7MV4oYiJq+SJr05T2
         3rq8HGPm/KpxWX6khg0+XcxRnF1kywDPUJnwqJwDKykkmhw82yQMDVxL6QkjViFrQoxZ
         3S2GhIGGNn0OeSttehCrxNSJ1RWkfyGNh2qEGnnoL4t5l1qU2OPmljXKgxzdDxZO23a6
         fPfyHnpbBA5+z8R+wbLqZY2jZRvYWNGgwkTMIAfDNBzGdbfzTPtTSgVGXtacfdovv+vS
         BIUNQexwx79wNw4h+KFwJaEAcnbeAAPku5fIOhx2wcSI5iRDKzExpN4nJTsl0/gtBv1p
         UdMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776669757; x=1777274557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVOChXZq0zoMztJw+hJ88VSw+ye8042PpZuah7BunBU=;
        b=UBFHCkDwTHXb/dR8rzW28LgFTvbprdGUXDCFAdiGBymsgYRkIfpHE1C3RrCXLshQ96
         G73xr/Az/0nFi5t6WERBEFRG9uWqGnGRhQfisGFwn/oPmd95cxStLzX0m4wpcqo+Dy1s
         l14CrJ7CSHpDMPiUY+YVURsSfDATuIXQMIwzMx2djpIXP+sZCPJ7QvvgOb3/2O0lNK2p
         LoaKPPbfae3GJr/5VAxpMOEMvT6U62+uasKkQwbSpfEQzoa0DUUpnpYsoJqeIZV4SnhV
         Pe670EKs7HkgLatZKlLBXLArtQWYoSrSaiAe1irIJ0lIqgLGwfbY6jHhwXnXNbz0A5up
         f0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776669757; x=1777274557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KVOChXZq0zoMztJw+hJ88VSw+ye8042PpZuah7BunBU=;
        b=CPMFVll16xRrO4NgReHJTQN8+9tSPHC8DH0J72nmzcwjAPV4T140HCg/bRE1dBquII
         YlzoJrJuKjJnue23DyZ8PpDRND8V62QyueK0qJbBl2KcaYl7PVyZjwPo0DeRVa+eA0QS
         0Y0mGrD44AlLZvZ1QIgkl/8vec5/5Gci8n7qvJwrmp9ZO9PtkzIVfkwhucUVrKSl5/j0
         C6OCxj4gD7kaxKoVjhZgeHTWK0MhGklDoGrMq0VcnlvB3gPYC0Hejj9VEslCtOqftqd5
         ow9BdVR0rxC6oUOh0HXREu26madK43DY767+K1jnpgMOOd0y+D5SYmNEfjLhdmC49FH9
         gsVw==
X-Gm-Message-State: AOJu0YxMj7hyNpLjtCexeNCs7AYVnJ3JjFVCPEobIIWxqJ/6j35FKvSv
	NLV6nkOppJ8VrcNV5QAecbPKjS9dsDRUkoklxH5zJzIkI/gUEHdprX3eejY40Y0ol3+s+47pP5x
	uPbR4owJkz3TGx6wStrYId1OABIUu5Lu4G3u0YNnZ
X-Gm-Gg: AeBDieuhbJ8gVn6agYZxPqrdNkyFdk1m5w98GRfoz3XxZLdsV8LWIQwKtdVTTcV/1Ez
	uq3hVNLPWtSNv5VXePR9KGzK+Gp4sqDb7fFqJSZSpwy/nBzNDNQStY03hVW+QHc6uGizJcb5kGL
	5EnEm4SfZdmea9hYYgRvlMvikAkGt4tIaNKpKBOt0qVzCGM4X0vX/K60lfiYu+G10zoadNQrL3i
	CVvnPQOgvk/REzrmARHJzfQs0W16y3C2toZk4hmlGmkxMBMAzLgg7xo1rrL9Coy4VIVmf5XTMMw
	nKqOma+wndzuHxztsN+ZTtZ8dNL+3mEoYEVlD6P/EjsfbBaVDr0N4pqMGRSdj/mHoqycex27mXc
	6QDXD0jog
X-Received: by 2002:a05:622a:13ca:b0:509:1470:d3b2 with SMTP id
 d75a77b69052e-50e36ca15abmr179564361cf.60.1776669756390; Mon, 20 Apr 2026
 00:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420025428.101192-1-jiayuan.chen@linux.dev> <20260420025428.101192-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260420025428.101192-3-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Apr 2026 00:22:25 -0700
X-Gm-Features: AQROBzDC74EX5M4Dk7Jdn6RBQi37Kbrc-y7UEen5QduIBRs6mrCuXqesYzBzsmw
Message-ID: <CANn89iJhHZH69ShAS5_V5RdgPgvfz19dZn7wsb_N3EAScVoR2w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/net: packetdrill: cover challenge ACK
 on SEG.ACK > SND.NXT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279672-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ABA4427AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 7:55=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Exercise the RFC 5961 Section 5.2 / RFC 793 Section 3.9 requirement
> on the upper edge of the acceptable ACK range, mirroring the existing
> coverage of the SEG.ACK < SND.UNA - MAX.SND.WND case.
>
> After the peer ACKs data the receiver has never sent, the receiver
> must respond with <SEQ =3D SND.NXT, ACK =3D RCV.NXT, CTL =3D ACK> and dro=
p
> the offending segment.  The script validates this exact response.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>
Thanks!

