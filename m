Return-Path: <netdev+bounces-271938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFKEJrr6xGny5QQAu9opvQ
	(envelope-from <netdev+bounces-271938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:22:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C407D332350
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6B42301B859
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654A3B893B;
	Thu, 26 Mar 2026 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egxOrybp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EA3AC0FA
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516145; cv=pass; b=oKp3R3tqjbMvfKxpYom3BtjGb2SayFOOKuo0wgVsoB8gozHI+sZ48A7elNBDDSMrWwx/xs1fhyNal1j+UlEQyKTtLqfTmCeWaR8N6BaO/G+BkTFLDUf6m1bt0RtPTr1VY9IfN4730YfceTTeL6qsgotuvx7vm2+4yGKisMxxt7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516145; c=relaxed/simple;
	bh=uA25o5lpi6eVBSrg/N1K6ROoeMRwYMOMW3SOAr/2gF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtUODbRvI/AdnbyTxbSP52s/XsFMtU7VeSR5bnbAEQ2K/pJE3uZP5g/VrOK9tdvyRulXO5GpvKTr6vVhScZcdB88YjqR0peJ7RUeZzxrW/ELhQO7IMhTLfTx2jLIU4OaL+1zK/v+3sk8fjmdCyr0ax5tF6v12S38j2gdG5kr3To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egxOrybp; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7986e538decso6571297b3.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774516143; cv=none;
        d=google.com; s=arc-20240605;
        b=GP9jRRFROIwlQhtSQxM9+69UcSZ+pfyDAhW0TxQM2Jw6s+4y54BXMJbvFXpppyihoX
         /4c7CcwR/pVAOA4IutUlavsB+EvILErZFSVINCsLsmy70/nvVxraOgcYj1kE7KHb/keA
         +prA5jcUiUlmriGJhYd4cHpP+yuLGudTEZnlcRtd3X6BDZ1zEYYltXRunhQBIokBjNMh
         h5NpHyNko0yqM1Mj4hAX4ESAlsHb/peM0sslkdfpAqtUyGnwXQ6uvzx7zj8I85vC7b3K
         cAqyM/dBBscZpvuo6HEQ/DjtCHMOOZ/vsn3AK1gLG4zZFk6Cy8oxueoaSvoFhOh4z2XJ
         2jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uA25o5lpi6eVBSrg/N1K6ROoeMRwYMOMW3SOAr/2gF0=;
        fh=3vrntfd5hH25oSqoE5N3A54ysyp2x4qXVO67fQLwmZA=;
        b=DFES28NOF74Kn8GeneG8tCJWWiwOzjNm19fXfXynBqEtOZ97npre9h6TH2nz7Hbro9
         LD62iR832rRmDcg+JB9FItWf6bVfiRmee0mcSVcsjonrMoqlVBIJvVj9cAZaBbbXssUJ
         lS2XUFQgeYKN8/oT9ZgMgHkc7i3IlEhQpbt2ZNg3TG+Fw77SsVleS5HSEw2a7BZITfjM
         rjS+rDDVyUBNR//nL5bh7pOEJDx5jk9O6HSiRPdnKeeJsf30i3X4J+C40P17MLw4EhYp
         x2ZBCOmVcUDKc8CB2+gtjJXe6jHCscO39GtCARUDyfAMm3k/smn+XF8euergWCDjKfqO
         zS6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516143; x=1775120943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA25o5lpi6eVBSrg/N1K6ROoeMRwYMOMW3SOAr/2gF0=;
        b=egxOrybplSlmvCycHtCuGYbW1A5P5oNITAlKux98JNdH32W3gd7FvITIugTC40APEq
         Nf/gdQIFAgV2ksdsLd7vNMwXcKGMK9ojGYEyh87o8SKjGvdQp1cq332eGVhJ96pus4y0
         3t13kiyljwG+ATCz/fWGN/CqRtf5GPblFfgMNE+jXRdHUs+9j+6mYLoDppfXgKQr51xt
         u8Bu+X9v6yx/7TYZq0lXHgnTrkhf6d4cpVuv3d6D8YAtR0lqGSKu6klwi2djtA/SuIc5
         ecpDDEaouBk6qPRzoWTlsMeKegO8HRjY2SFUb6fs+HqAbuKrEk+c0z3ZkmsO9RK0eD/s
         SLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516143; x=1775120943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uA25o5lpi6eVBSrg/N1K6ROoeMRwYMOMW3SOAr/2gF0=;
        b=qZLbpO4L7I1cobLboXkiglQizyyhEmsycwoT3BhKs7A36Uy2FsKnI2pf55lp4z4IJT
         yil2jn7ZV4grS4P3DUvdiQVlDS7XY3H/wnlQPnqEIVCofHo+JnvPXuXzUQ5xJOJlY63n
         pXQ7r0eNZBhAeWp2zNTYa3uuSgK5QECS5ike+2yJGR+2cNvxfbReRWS9newe3SrcvAzG
         Cev2URciQ6OsjscjkCxT0YBAFx6L0k+A1Q+2uNodlwuL8wQXGSDFFG8ipn8CJoEJDAAl
         25OYvOXKFIQRCdsdaWSyKxnRPqYaa5UvfvBaKpPiW4vlAyZiGaVxK9jsnDpB3zp4eUmQ
         d4eg==
X-Forwarded-Encrypted: i=1; AJvYcCU79W2+W/WzW8raErBjV0y5w23VO9OaV8atZaM9HFeneEKfFaysVefUVsaQigs8kBP1fR6n9Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8M0RCSm7dglgwMHkAUQV6kJl7GoIyItUhyc7lp/Vws9R7C9z
	zXSmxZKmhf96SNJxS8DIGJ+c3ZZH9pptTYoLwjJkyxxS4K/CeEPme9cq1RAWRUCiAXgLgaO+ZE4
	Kb0DkJ729ddNl/YttuLsJoJ49T2g0JEg=
X-Gm-Gg: ATEYQzzq5zemb50nnXsYv1Ml/qh/30g2dqv2hG5YqNRPD2C7rmbJHBzTgBm/Y5sehXX
	4QmAq6bd0eUJ2NMmbQoZIy2jacMZrMKfWQQklUgLl8A4s6Jzb+1ZlzXXbYa8H07mlFZcnNn0gV3
	WOBdzXgpYwDUTKn5FPpMAfR2jFGY9UV3d3OnqcMojlClHKwFx/fgNtg/NQ8DywA9KpgfaLGJvXo
	ttnk/11ll4CfhGjGFlGFtkT6as7guDFLAUnJdQ+LHhAouYReL5zTBTZm4Nb2b44eKA5q+Lvqc2/
	Ym47QZtprWEYT0rX
X-Received: by 2002:a05:690c:46c4:b0:799:3a3:2f25 with SMTP id
 00721157ae682-79acf67c2cfmr77450957b3.38.1774516142930; Thu, 26 Mar 2026
 02:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326021642.29170-1-dqfext@gmail.com> <20260326081304.xKa7-s_1@linutronix.de>
 <CALW65jYdzn_rZWa2zwYd5J+Gd=kyaGMsVFyX0fMJfKfgULMO6w@mail.gmail.com> <20260326083020.2fOQj5br@linutronix.de>
In-Reply-To: <20260326083020.2fOQj5br@linutronix.de>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 26 Mar 2026 17:08:50 +0800
X-Gm-Features: AQROBzAFY5MiCnvJ2DMtdJfFsNq_yFZ6iw3jGYwdcM9wBpkBnMh9AY45ZZy5_aw
Message-ID: <CALW65jY48_cq7tZR2S_b+Y1zJw90PGtQcM9JzK1wDako4yUaWg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] selftests: net: add tests for PPP
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>, 
	Antonio Quartulli <antonio@openvpn.net>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, 
	Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271938-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C407D332350
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 4:30=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> > AFAIK, this can only happen with PPTP or L2TP, which were not included
> > in this patch.
>
> Yeah, that one. I was sort of looking into but gave up after a while
> digging through code, since I had no idea how to setup that up=E2=80=A6

I used Google's Antigravity to generate the skeleton of the test, and
the rest was some manual tweak and trial and error.

Regards,
Qingfang

