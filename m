Return-Path: <netdev+bounces-253125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIA9OpZ7dWlVFgEAu9opvQ
	(envelope-from <netdev+bounces-253125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 03:10:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E57F815
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 03:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 305BB3004CAE
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715991E0E14;
	Sun, 25 Jan 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUjbdJwH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E93EBF18
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769307017; cv=pass; b=BX4IeT8nuYImyEGqEUJtR0kB6HcqNzrWdosv/TeeBGk5te1xYd8g3kDh/PpulVtpgAcD1W5yqL4Jm5hHof9/hRerDcNhi/cWCFS+5BaPexFum/dxaox/+lVY4/KA5TGqv0IoR6B6r86+PwXHAh4Il/eRlP49QyFE19hhdAYAejs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769307017; c=relaxed/simple;
	bh=XLZyAyp5UIrnE16IaKCD9XtL/eqE6lBlGhHJnAAFVHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDP8b53kBLUjyEq6zKjSaWKekEp5LDtkaqpsU3LjUHnwP3ea9/dP873nCt6H5yW1Vgw8fmBMiednBoTCshJM/SFkk3eEpgaBg+zrZoQRC3Z4e0JjjyxusFnmuCnYd7fhAkYO47Uxz/cXra+OoUCBruknVW6JeSsjxQ82Z7xFNR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUjbdJwH; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso39004625e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 18:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769307013; cv=none;
        d=google.com; s=arc-20240605;
        b=evIOsMj5qIMQJkpSHPAwqeNUMvo5Naqb5rzs0aAvV6QFIHB6xpjC8+2AFTpF7nl6iG
         iIOBik6LPMv2+sk3puvPbywZoXmOFxAu/hs5boP3u1sCE1OYuKfFLOn+rwrKTfSmYeZJ
         aCCz4OVPmJM7J+oxnbseBmAE+a0zC1qEhZ1r51oj0Az2nE2KjMRl1kkb6XT3hoUOZiCH
         jMRwpkMilxiOQe6sFg+TMDoLxnimDVAMCTVwmdtUpbTiaHNDMjQRERCLRfnV3Oop1I1T
         nc0TLPz7BgaomRN0LhjvynBtAgArDDH/xgtSedoCbt2V0WkfMsRR9LIpU2t3A9+rhhia
         POyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rgZwVVbLFRja+NPlNhTLut3FqFbwxjNQ1zZe8RLLWeI=;
        fh=K2jgdk3Sh5OgFsc7G0h84k4uZayosSM+CDZPyeZR7a8=;
        b=FRZSWbF/6iGIqy/tbvBTsTW4wo3dcIj4chDSWHtQzfewBPf3N9nnUGgeyodCghNL6o
         iL+aGVr2OON1+uN0LxS2Ektt6ZGfbYFPJrSup4agrZ7O0JBka2Lr4KDwLrjX6OEMKtNl
         hLBlEnalWg2piFk5qmyJJSsNR4wpY+KVkpcRFRvHPipb3LsoNRrAys8+s+fjY5B7Y0IK
         vOpH5qav1SL+gn45HA2TMR3jkMecMoMFmb6XRHkdXOlSZap6CTyoEVUGyvIbWsvGLFBG
         DPyfQVT6LSARtTSIBVoOh/+FgBFtVcelBokiWZpH8zTPbuYh9cxcJcp0uvsw6p90cDfS
         nzfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769307013; x=1769911813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgZwVVbLFRja+NPlNhTLut3FqFbwxjNQ1zZe8RLLWeI=;
        b=SUjbdJwHyDUnyCgfDnC/proUrN8BT2d7uSQd2AcybskPpAS6dHhVlW9UNsCrCpjo+L
         Gui/lz+XR9VeAz1KAd9SoEdWdCmdOLCSHpMT4F/QajAEyOQqLxXqZNtdJWGX0cgHMUdI
         WlikwMA1Bsvsw8BT0LLEJjGU9iRCxNC3ZTEF/lCLZRhpV31WF3m7PHFbEakXZLOMuOEk
         bT8Hd87kRe2pI/2X8sE0H1fxDSB0HnIfP/f8jQNzjAy3Okjo6tNvvC0a7wHccW1UrWwS
         kF70mjkx7f0XPJpL0g2eCJldUjJomCPVBkqwNdfuQXbmKCV0NW3HSDYvTv6SqO0TbhKZ
         xYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769307013; x=1769911813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rgZwVVbLFRja+NPlNhTLut3FqFbwxjNQ1zZe8RLLWeI=;
        b=IJRSA0TW0kyVKaSwqQprKqHyA26XQXRtEIYkn43uR8mxAOr7rVFIGt9I81IJOIqvB2
         kc1wmcM0Mg1E8KLwk9qZE/tm9GwU5O6yyPDtf3SxpKlpmMDKJj+a5dxSHW/twZaYJZUm
         pgBetofQyWYkPOs0pEYxgfNej/sZ/ORENhdBpK60vz8RkZ9hPDwWCSl87uXhtMgXz8Rh
         XKs58TLByK3SOBT1de7EIaxU2A4RH4bUUCckDX6tDxmG0riirh4enpgH1z887NRZSOj6
         TDYJg0CqTH6h47jrKLQiRnQsVLa5ggmRcPYNhR6LhfI8BUwWyX/ABu/XsvW5MLFZv76c
         k4HA==
X-Forwarded-Encrypted: i=1; AJvYcCVUNVq2Jx8Xl0nWitvCf7T+o9p3Gq2DPL4qfWsTmRSwig2zssdDHsS94Z2jnGxEl+codiUcdf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAlyFD2YTZ7hDwha8it8Lna80epTiUnk+UZiZ/aSn0h3EJyuf
	EIdoBdS9trmnbjT6US9vIlY5FNPCP3LpO+WibixBiVzFOPj9uc7gMc18PMwirUtqPva6fNPi9HZ
	sYinBaJrD8S+DAmc0rDnVpmOMiWjMtJY=
X-Gm-Gg: AZuq6aKJj95wOESP5b3r+FIeONjUFu172UmaDBHTHVI2ViU6YBF7sC936uSORRxiGSj
	Pou46ebEcZysDnUgVNptvbjy0r7ADRRePP7XsBmd7bP8IyOehoUpSSjyCE9SdDat3TYqhpliusl
	f0QVRs3QdGbs+yf8gALtglaf4sM1Gwt2C3QycNP/A8TMjt4I7H67kC648BikqZ4jk76xaorzYlH
	U3fg1mGNZecPiofBqvaIaFsIrnxafYHiTydTuyJQ1m3++wgqrIQv2TpVQB6ckC1ceHGJEcYEYDF
	0L6xet9pR2QO/BMFsE+0uMZFPgQtOIvmzegnTERFrgDWgGmz9xPd+LDYuQfwqNeLHQwYUt6eR9q
	9z43gtqhA2348Tw==
X-Received: by 2002:a05:600c:530e:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-4805ce4e67amr6595865e9.10.1769307012798; Sat, 24 Jan 2026
 18:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124113314.113584-1-jiayuan.chen@linux.dev> <20260124113314.113584-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260124113314.113584-3-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 24 Jan 2026 18:10:01 -0800
X-Gm-Features: AZwV_QjbA50cTkj4c5-gGI9H_-Xy1D3AWqQcM96i4DXaFF0Q5FjjiG99twxjLXM
Message-ID: <CAADnVQ+TGhrAhUfbhCtnN-EEWF=Vb3AHVqs=Vd7xoSJoptKcwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/3] bpf, sockmap: Fix FIONREAD for sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Michal Luczaj <mhal@rbox.co>, Cong Wang <cong.wang@bytedance.com>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253125-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 153E57F815
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 3:34=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> A socket using sockmap has its own independent receive queue: ingress_msg=
.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> Therefore, for sockmap, relying solely on copied_seq and rcv_nxt to
> calculate FIONREAD is not enough.
>
> This patch adds a new msg_tot_len field in the psock structure to record
> the data length in ingress_msg. Additionally, we implement new ioctl
> interfaces for TCP and UDP to intercept FIONREAD operations.
>
> Note that we intentionally do not include sk_receive_queue data in the
> FIONREAD result. Data in sk_receive_queue has not yet been processed by
> the BPF verdict program, and may be redirected to other sockets or
> dropped. Including it would create semantic ambiguity since this data
> may never be readable by the user.
>
> Unix and VSOCK sockets have similar issues, but fixing them is outside
> the scope of this patch as it would require more intrusive changes.
>
> Previous work by John Fastabend made some efforts towards FIONREAD suppor=
t:
> commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Although the current patch is based on the previous work by John Fastaben=
d,
> it is acceptable for our Fixes tag to point to the same commit.
>
>                                                       FD1:read()
>                                                       --  FD1->copied_seq=
++
>                                                           |  [read data]
>                                                           |
>                                    [enqueue data]         v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data=
]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Jakub, John,
pls take another look at it and ack?

