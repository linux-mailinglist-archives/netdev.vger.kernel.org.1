Return-Path: <netdev+bounces-277926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPr3DEEZ3GnGMgkAu9opvQ
	(envelope-from <netdev+bounces-277926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:14:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4FF3E6427
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B14B30088B6
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688C31B100;
	Sun, 12 Apr 2026 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFZH5yAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DED31E855
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776032059; cv=pass; b=JqeZ+aW12KZ0D/wwy73lmJs860MfdHZ/klolTkEFWqNa7YMQm0DoRlYJvpqdUP9fr/utglMEfbFIjT85n9ql9V0b9QhmOtjnr1jWz8HZyYALq1jVVIv0rsOhkX7TCenTYhNFP6t4haXFpl0WvjLB7c2b6cN4W8EdzdAS6qxTnZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776032059; c=relaxed/simple;
	bh=ua1eW6P8yj6Zh6kqOovi+2VXUQXhW9tuGX1glOg/AQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRUO61KJrc17rrr/syUq871GKTrLErpHziKZBvN+5L3HUY32/IA/5Fb12BiBkAYPe3CK/XbyAEIKFOv5NwNz5oYiWMFLJlK041KMMBL99SKCCrRc4PJQoIdPwERUq5+y+iG3cLhXjBiZ/PAjyuXxj5kEPNXLXIluyqkgGCSB3B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFZH5yAk; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128b9b7e3edso4751797c88.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776032056; cv=none;
        d=google.com; s=arc-20240605;
        b=AuAfqKXNSfr5rgMoIy88vTOMLj76lgM7HIEfSqyglRdEDdvbSSideJVvwwWGOhCYYo
         jOcZ5unWCqpddmhhA3YHQuLjMhaF9DQyeP20fccnbpeOgMmbZIuJL34P1NoS01lJJm1b
         4+otC474DQLT+p90sr315YodMbmM9Vs7LiJE+OOH3orH4B+ajqWZcsviYAckJk5Nje/X
         LjqphCW8jXgo8APfm1gByybMRUY6kQk+DCF/56mIeKuoN+hwrhgaQPe0tidhoOJ2ztP7
         VrwxnEQwySmMlRnstDiWy7v3KlSf0Wd7pYgHPCxF95oV6TMSqG3ssi9GXbz2YUHV6XQ2
         /gyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FHXjeZEm1riCXUyZhi8I+U5hLWJ6p0h8w/beC7sNdrU=;
        fh=pTv6Lh5doUFDJ97mm9suBjxxJejgJWlh1cZFaLHtpC0=;
        b=BttSo1I/Vcc9J2FrXR6EFg50q+eXbQSm6UMOTyE5Z8QJMiYW+3ytQsRfeMnCWXZLPh
         j71Lldo4m/UWK/2IFDpEMkCwWU0rH0g3L6b69jYe0dwy4DL8elF6lCqSNhPOI4vpyfKo
         cfd1N0yPmq+dC998ex74HD1xYi4ozzP6V/be3Cri7qnhTDJ6NgN0421sHc8Bi/yeXQGB
         6e/yoFAt2BMkBEyWbQ9sSwF4lvM2Ut58A3uffsEAeHhryEBRaaRbUtvS4fkOrZFbEWet
         mldFoHuOTdx2eR7wfP24jbmONDyLSTjKx4zViMszqoCCuqfD5jaKzRuztjwq9XyX9JxH
         irNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776032056; x=1776636856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHXjeZEm1riCXUyZhi8I+U5hLWJ6p0h8w/beC7sNdrU=;
        b=dFZH5yAkPQvnCxnGJJ8E0bZax/7Cta3yB7X+jC4JHcRgQR42Ka+0WehJQ3z2SfHZum
         zczKAMMuuiAUDgjShNnzFfaz1bs5UeYSyKBQaY8kQcSiggcx3WpmTXvJuY7a3NC6igJB
         1nmH/DGQ/G/5p42x1YLuzAxZvg5L5NI4xUTbYJp8njk/feXG5xq6RrwtygXBw97kdYSH
         KQ6Z4fzTe9Ys8FduLl4gk3PHYQYaWQtxv2hxvZbRqOCxxpyIbVntF7ri+UZj48l0STAf
         hIc2l5ZQh/OSITGtw+S9xKHd9KF3QpZ057ak4xU07uXccQsPATZdXexecaL3m7aHiNOv
         be+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776032056; x=1776636856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FHXjeZEm1riCXUyZhi8I+U5hLWJ6p0h8w/beC7sNdrU=;
        b=nh7Pj8owb5k1dwGHl6/Tg5E1yUwF2rgQfVOoM9FuFzEXAMy+rTgYgq5Nc6UIuG0INt
         E9GRmdOMZCRF3kc8gf0+0RBoK+dAnYypNB6VlevQbRqWYYP5MCJfAsmBXeLxhmH2f8hN
         7cslfbW6f//Zx3E+ANorazLJcpU63esAXg80c4fL9RJIodnEPWDyeR1t/SaAR/vXH19p
         P2R7koBxOcQ8ZGwaZAvtK88L2GuhAJDBYP2NH1rWiVgQRuwg0c3+3DT2K9S6wd52rI1O
         XZebHKp1zy0gvNwukSozhDpk3+vzoNp/IByInYTOF/BfNxZTylBk7OVkvF1c4BYs4pc1
         SXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGrY7R4RSx6LcrQaOsICNGsvWl/TfwW3j8HBGkolMPW3/aEwO/I9ZOF/9NGSjbqoX3YrSgo6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pVh6ev4qcMtzLouPIM/75CR4vjGyXNL5TyoF4nu+WRyOY+yT
	wbB//TNbLpF6OQKgvTdyP21Q1ITozTIjx+POf/5EMOUKX+Pt1QFhob+FLH9l6aRyYD6IViUmzOg
	1uPO/USFO5dzXhkgm7TCUnD24iWgKy95jCrYI0krF
X-Gm-Gg: AeBDievUg6xTdMzuzHHlSy9alREscFpf8z6kz9n6JiSZfuh/EGWWM1ImnYsYqwN5IJ0
	QaC5Ml+ia6ZTDbayFovULHWwDqbdSwLPwpAFQ/xqNr92R1TaOUlp1x5wU/QvmtrqyVPpbODVHQ6
	9kUVt1xWH02g2aFi0GX1imC11FfFTJpOXgWCQM8pDTDWNUDTVI5uaSsG8DwPBHcX/FnTumyWqcS
	s4sBm2M4MQIeWjMXe8zJ9PYBr2qkQ6nFlXVzBJrqwPX5n1Z6cDP15mU++q13fRCOIIaJeeYk2xz
	Jv2YaDluomto3AgOOXMdg39wvpDDioyxaot6o2gSl50nqWQpIcfgT3xXlLIsdhdZhER/WzSbtpC
	i7WTwWYwYLaw7Tm/ipuwmRZrCMajnkltg/HLmo0kJodz7oDFRmGmdVcem6udhY6Y=
X-Received: by 2002:a05:7022:419f:b0:12a:b39a:3215 with SMTP id
 a92af1059eb24-12c34efc031mr5719051c88.36.1776032055863; Sun, 12 Apr 2026
 15:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com> <20260412075856.68f37eb6@kernel.org>
 <CAAVpQUAnpk+A2M=Or=0C=ksbTMo0zuBst3aKC3wpAdP8AKpRzg@mail.gmail.com> <20260412141114.143d0858@kernel.org>
In-Reply-To: <20260412141114.143d0858@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 12 Apr 2026 15:14:04 -0700
X-Gm-Features: AQROBzB0p9xjpWPJDkK-2hsSw9rpTwCz0e3AkWabiGyInx149ARZ_gXK-Dul9TI
Message-ID: <CAAVpQUDrJZ4A6Xncjza3x_yV_vR4Ua2K7HahSWK0bJYjgpCTAA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR rtnetlink.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277926-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9E4FF3E6427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 2:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 12 Apr 2026 13:50:59 -0700 Kuniyuki Iwashima wrote:
> > > Hitting a bunch of:
> > >
> > >   SKIP      no netlink MFC interface
> > >
> > > on the new test here. Do we need to add something to .../config ?
> >
> > No, I used SKIP() intentionally becuase only IPv4 has the MFC
> > netlink interface and IPv6 does not have the corresponding one.
> >
> > Should I just return 0 in this case instead of SKIP() ?
>
> XFAIL

Will use XFAIL_ADD().

Thanks !

