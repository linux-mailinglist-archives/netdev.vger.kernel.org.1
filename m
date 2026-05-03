Return-Path: <netdev+bounces-283655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S1C3MTma92k6jgIAu9opvQ
	(envelope-from <netdev+bounces-283655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:55:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21B4B70C9
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4D03002B41
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67339A079;
	Sun,  3 May 2026 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qS4L0ALF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8F3033FF
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834550; cv=pass; b=usiVUS0Pdg1NMCe9Ww4Sk9lLXmwWOn0R7Q4NTV1km92A3Bsn1VT0lE9PEvTFH12A0U2h8ge3d0ifY6KUeTROFMImD/n8gTmSMmoS25FFGjUJ4u8ENvvMOH4z8FfPk2A8g3PVtKJVqUGdir1sVJf2iPI1nc0pI2Cw+808lmL2qWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834550; c=relaxed/simple;
	bh=O7VlWVnxuLlTsL4eCDO/+eEDKo+L2TbPWmlSPqAU97Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe5t6a67xCqT7uk1yn3mVAS9z+65VHwIIVmljqI1zBBZHiZA/kS1aB9lwoeL+NDPsRFJByplzIggGlCmorlh8s0lByj6jrJFeZwXjWh8pOuRLZ2bL+eTc9cguPa3W5kdsDfUJKQp4qQoCwwUbCcngGS0rA9BsXR79rCK/KloM0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qS4L0ALF; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so2483174c88.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 11:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777834548; cv=none;
        d=google.com; s=arc-20240605;
        b=TakiliJJKRhqcSqD02uO3jJ5CA9Yz+dD8DDsXZkTAVvmPIqgIGjOjKa1+pMVt3A/FC
         cHJIUMgrbnkDqv3VE7e1ruWMV0wm9y88uFyFC3SAK4D+JX17ULgqKUM+360U8Neq1UA+
         TvM+xP1XFBPNwW874dV4tCT0Pax63QiKNhAG19bSovFwn3IOSW0UeIN3qqP/soYQLAsD
         huhVUjjm84auyes/2r/NXdB7rcwpmkAgTxF0FSA/T26oUS3Hd5Ltlb82vbrnAJYpAMxy
         mwI/CFwMsqFFD1Dydj7A+VT9FBMxr1qQ9GjvbDA64HSIvtFaqAC9I4086SdUBjtvecvX
         Pneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pg1krCn4gAhktq+DPCKQ7dqJ7I1jR8bDMb+KVw8IUNc=;
        fh=h/qQVQG405s7Zle+KE3qn4/B5b8Ydv404xzNk4MsFvg=;
        b=Ki9ZKDCiM8W9+4GlXkf+SR0rdMghhxLowo7bzzJktaYGD5pVq+PNlpr+r7KSaWSmBN
         Kki72Ld8+zcfJcbetCQKpDrc9oYOcLkZhxUcjV+BjfZnQwv5i4U3O3BezDVMoTmg376V
         E+k9CK0vT2X+9A6ID4uU7XsGt6AYMFDqRTKH3lsWfv47yi8iz68Uo+uMnQpf9a/vnrkk
         C3FVccYCJfEXBgkGDjK/MByW80KIbm8KHjlvlIYhJqQ//x/o2X3x8EGva9WAbljnhitb
         z/bw2lUqbSze3ioa4nlZ9PDkSVftNQ61CdRLVvLtcGWa6LYL8A1nTjpkmT9Ovpy4R2qF
         CNow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777834548; x=1778439348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pg1krCn4gAhktq+DPCKQ7dqJ7I1jR8bDMb+KVw8IUNc=;
        b=qS4L0ALFHFlaulGvBPwGRuKJRpahtX8esH9rUTs0ajkpwyhs/UkCv9qwrxYcGNXsGN
         wXX8swi4yY1MXf++AcDOWPlVbAOeIzTC9iUhmjEsl1z+ZQje96LvyJOjIhn5blhz2skR
         bLbb7IOBz2MgTUYiK2Ne8oW+sYlmC20kixBhYLXhF9lzBTGfClyLgl6Okr/xKyDi6ONz
         fJadGWz7/Q3FRcQzM0+vQ8rJEGLVru+fNqy5ZefWegrDSdzHOPTVs/7F69eviRUWT+Ta
         JGbNyX6MONbkcubGm9xtdGphfPRrXC8AYH9taWFiqf9X5LbiTkugunMwI+r4+sPGSkgl
         rmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777834548; x=1778439348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pg1krCn4gAhktq+DPCKQ7dqJ7I1jR8bDMb+KVw8IUNc=;
        b=promV8CcqJUTK5+xbyhn5lrt/xw3RXRBkan28pC+wwWpFhRAIj2/g5qUBJhNxszsdQ
         tsFHc688LUtyzgccMCGAuBo3cnHDLkdDpVMDTd284rqpQiiQcNir1QSjAzZM/Mk8TXn8
         HsX095scdGJz9gGd41WepMMvzSLtzvBJdp/A6jDqGQl2oxDZPqSx2zPtYVAXNZfc62lE
         oj8GFjm42pjzd/6XLgM4Mx+B1EYYZfWZhMrgMjlE89eoXVLydakC5D+0J8xXvxbnCnaP
         vl01jIAG0DWf/Fua16KPas3SlJHuh0E9bntIpWekJXzuHIcidSo1RjMm4qgTRsOGFOFk
         HO+w==
X-Forwarded-Encrypted: i=1; AFNElJ+glVNfS24QdFasiYdkXD1SL9e5gT3Mwe4p1qzp+caNcEJv5kmZKoqumM2PRpwHTzUQFvSGilk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCYQ7491tvtfYEET6hM37wK24i3XT8QRdGI7uF02YEzvfFUUl
	7iNVj/MqSq6YadNW8B2k/HY97NiIX0T2ySKtX95TVBaY5tICvLA1EmKS0dsJZB4nrmYPB3ueZMG
	3gXRc2mWOLprsUJN+zB0MD+oKuhJoJpucTsAJqHIG
X-Gm-Gg: AeBDietZkrHL72M3MSDE2/wUHwL5KpsCRkp8ayfsRt5FVDNpTLP9IHu4vglyeLnAePf
	DmhBx2vWPK3Hg7sGayoQK84RUSTakJV0+dnzC7bfTTXeU9waVZZw2MvBsYOKIlz78Nrhy+Sne6D
	G9+8tLP2wCurUgyVo+qmBOF2IyDbvfe71hTUVavtoxcJILPO3hpHMG2yd3f1oawkzQBqo/t59y+
	WeV7/lPlsHen1n8XO4RYyl0ANVQnLTFNcdMlRSRJdNJkAJz07kV2CwTxMDv26GlD52lc0n9jkUs
	5/BX8ljwpNTns/dGIsiV44srRgAUVw3fAHkJwp4kdChESJOIQ7KckJtX70LhAVKpmNkOFvuc8x2
	v5Nx4BfYHUFf0pE0s9ZmPGelrxZbKfbrxN8p3F9plLI/3X7agVU4lAHQISrx8/3kRd9HRhJnJag
	==
X-Received: by 2002:a05:7022:e1e:b0:12d:31cb:b806 with SMTP id
 a92af1059eb24-12decf3d924mr6760243c88.26.1777834547499; Sun, 03 May 2026
 11:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com> <20260502031401.3557229-13-kuniyu@google.com>
In-Reply-To: <20260502031401.3557229-13-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 3 May 2026 11:55:35 -0700
X-Gm-Features: AVHnY4Lf2zcN20ykBKjYDD76pJzZlphw5l2NGLsRqFQQTVGWlgvfYR5dYvgt0wg
Message-ID: <CAAVpQUBgZPHdpEUxXsUzhbFpETnoD21ujms61HUdDRfJNDpKPA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 12/15] amt: Store struct sock in struct amt_dev.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2C21B4B70C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283655-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

For Sashiko review:

On Fri, May 1, 2026 at 8:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> amt does not need to access struct socket itself in the fast path;
> it only reads struct sock, and struct socket is only used for tunnel
> setup and teardown.
>
> Let's store struct sock directly in struct amt.
>
> amt_dev_stop() is called as dev->netdev_ops->ndo_stop().
> synchronize_net() in unregister_netdevice_many_notify() ensures
> that inflight amt RX fast paths finish before amt_dev is freed.
>
> amt no longer needs synchronize_rcu() in udp_tunnel_sock_release().
>
> Note that amt_dev_stop() looks buggy; cancel_delayed_work_sync()
> should be called after udp_tunnel_sock_release().

---8<---
This isn't a regression introduced by this patch, but if leaving this
documented issue unfixed is problematic, should it be addressed here?
---8<---

Pre-existing issue and orthogonal to this series change.


>  2 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index c03aa7c207e6..724a8163a514 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -614,24 +614,24 @@ static void amt_send_discovery(struct amt_dev *amt)
>  {
>         struct amt_header_discovery *amtd;
>         int hlen, tlen, offset;
> -       struct socket *sock;
>         struct udphdr *udph;
>         struct sk_buff *skb;
>         struct iphdr *iph;
>         struct rtable *rt;
>         struct flowi4 fl4;
> +       struct sock *sk;

---8<---
This isn't a regression introduced by this patch, but does this code miss a=
n
SKB headroom reservation here and in multiple other transmit paths?
...
---8<---

Pre-existing issue, and completely unrelated to this series.

