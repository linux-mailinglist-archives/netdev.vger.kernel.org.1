Return-Path: <netdev+bounces-305139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z6hXM5PyS2ogdgEAu9opvQ
	(envelope-from <netdev+bounces-305139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:23:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CCC714745
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:23:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wA7f+Gau;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305139-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C69430488F6
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47ED3ADBB4;
	Mon,  6 Jul 2026 16:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57E2F7F1D
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:24:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355047; cv=pass; b=ii1KYhoMZPMD1YVyD50y/uQG9kghWTpYF0nkKsctug12YTsZwlJxTrbCkZ9duW8fQHUzgSnSIH4iu5UG2pEx4nMFL6JAmX62ByKBVkOD4da/PwXGZ1jWz0IkxTL0JaN4MCRIC3xtWBxA2CKdyW3YaBeKR4L2yqbqTxz4dqTUpPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355047; c=relaxed/simple;
	bh=FMDBvm0dOfzz0RGwh/k/CGByG4JDEkReDRHnvzTWF7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKUPecXUiLcVya0vqoWKQUZTjh24NN2B4uXA3NzmLrGjYwIL5uIdMw3YF5sPCngDykYLk/fKkLcNkCgShg1V2BBfMMdDoUyBLN13HiCJ9JbLytaX1G5259BCPj6/Q0UnWhIx7bhw4iG9v6JaLbnc/1pEybvt6MK7lyW3FafQ3yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wA7f+Gau; arc=pass smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845ea8924a2so3192260b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355045; cv=none;
        d=google.com; s=arc-20260327;
        b=qq2+fOCVKj7yBfAueZcEuuOiR3ujVEu6rhrh2gGF4v0oxR+lulu57LYfO+N52Wgk04
         YiIHcH9z17vqR1Q8imKj6KedT58ZgWuubigXU2jVVpynhG6G3L5HH3QMiA8rAXBL1+1r
         puj3ePiShHaM8Au4TaUDz3nNwJTM+1gqCakG0Hse00ZDjGWhvZc7lQGLyRIIiD6Vgd55
         RfVYvSNvIJNJV7EuuQ2MWVWQ5Ahj9HUy+ZmgBdB3I5uGF0homQ/B/5TPky4YmXqEGXoK
         DzH8N2gCcat1KoClHVx8a6Km3Aps+UAcfw7htnO3vBA4dmkDsJfH7s8G8oMfBlYeRtcm
         GzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=94OR4mvqby7LsUvfQFf1/PWpVlTzd2ChItQ2/m5xfts=;
        fh=CnCrumGY3cVI71Y7R9BUlETn6PQA6Lsl9eY/zkxgbY8=;
        b=kaPh22Q8ulNDiIiem8Xk2a4gXrxENUaj7FeZwLdvtx5rdvK3mlnTvGJUDzN+ossJyP
         Gz/nJCzsUlh5zHB9wypfj/Zl5PYwZSC3Y7C70wmv0lqknSqBme1w6hM1/D87Vaff/LrF
         NchxlCmmkFxrVJl57vk2uAgSCGrbpdCbnajUQvUZCnjJ3K//2/63to4KyCz5RObPsDv0
         W3NTBCAtW6xtN9Fy2k5PMbglXZ4p+KuKFrkjBxb5ujDYeQ6rPu6P+aQAEQV8aYyLzY5N
         pqRQjPMWwiG9MspMo3NlUPnN0HNiCu/Op9zb945cNjY8IoAxUEvfaUTv1F0Wd2HaoPTf
         t7aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355045; x=1783959845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94OR4mvqby7LsUvfQFf1/PWpVlTzd2ChItQ2/m5xfts=;
        b=wA7f+Gau88E839nSz8USyoDWfjAqqYrdFZrbDPqUXjLYBWWDCZJdpNPc7iM3OFjrB0
         5e+s+F3uRn+oVuSZGzUKIijE/LQbZ4/IbZi67QIzzHa8Fp0X9Os5omoUseKwngpvGwyg
         WEglcw4NNOabQKRMb26MkoVlOdEXV7m/ujTJEXs9JF6OPgGb3nuhlKY/2x6xvkjE/NMl
         x0lrCMLqHU2zz6sCRCmJrl0E8b53RSIAxoZSYmDZCxnj+ioXGyKTvfMu6XZ7tmpaEItO
         /xMrrH0RYw5h7YbCVu6boROTQJoewSuJ7Qlg1g/shOL/MWdmBGO8KSle6awCVQiMu3BN
         jOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355045; x=1783959845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94OR4mvqby7LsUvfQFf1/PWpVlTzd2ChItQ2/m5xfts=;
        b=UuQHinHjEQ9Xkp3eWxgQqaIsYDnhBdmrlTXsQq2BJ+klrsfMTiPxFHhSt/JppwY+AL
         mIF2IXBZ3yzsdg6j2ybuQxVxzW8UZ26b1vaD9mJqCL2m/HuDRpFzA+gG+eQja+gBxgf/
         b4zeLfwuYZyDbPxUf2mEy2bjo2yPWzgPsAKRWPnEmiWLJ3jjYCk5VZlS/3J3xT6YFmEG
         9LlmKu2lvVMYn2I468ZGYwnistmDjh1kecrCv4eWSrkryz1v6hClqiEdVgKAsnuPjbVL
         Ve4xLbFDfsn/CF+lCeofoMVXiQ/4hkWty99EHSBJl+aP6qeoaGlueeTHQiO7aefiEyaG
         pYhA==
X-Forwarded-Encrypted: i=1; AHgh+Rob+ix5jGgHvbba1jZd6H/qldMYZ3Ujb5J5qAQq0pDIwGpEbEUP/Q5iVju1ZrjixDAd/xjHLfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqklm3YDWy5mSES1JbHZK/wb292PbC9FmVEMcZGH36OxLtEa0Y
	z0NhrP85KUzsG4DTmIomWq1snJE/7eRCjtNFytrue9AYU1vwMv1vMs46R7TD39H33YDnHZiFEEA
	j5nE7EL1zMfIpf076yAanmL6Ov/DeCFG5SfzuE6Nx99IIXSU2gzGILfxgBzw=
X-Gm-Gg: AfdE7cmqaY68L6TRexXi2sNlNY+H0ZQtQh9+5k/6B2MaCZfSNzALiTq2BnFOetu3vFD
	RLd2YErBOmWMaQVg78K/PVkwrJBwKqa0+T2PSWpPcTVGkyXKVzlKDiGCEZgpkL9F/ozn54hKVPz
	Cw35eSve8eR828QZ1Zm8p14jSriafsQPWKMWQFnFHAnYW25+zxbpnTQ4JulJZ6yIOZfuYEopLfG
	CYlb8XbpqwVIKYrRcqCl8LTctN8lppJd1mx3sS+Gstqp8JMwrYoqqKJiFiQTsI83CHg2M40ADP7
	gIZwwiEa6b3dsV3d6ILx17LCiuMqQf3vdFmQXR5wJ/nPWLU7uSAxV/7PMCC/e0zY0x+hJ/Sh8Fy
	HRqGJ4F2FPjfLz4Z+UC+/SVWS6Wn6ojEBpnbiFNI=
X-Received: by 2002:a05:6a20:d70a:b0:3bf:ba89:5236 with SMTP id
 adf61e73a8af0-3c08eee4ab0mr1658104637.33.1783355044508; Mon, 06 Jul 2026
 09:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com> <20260703001009.1572444-4-kuniyu@google.com>
In-Reply-To: <20260703001009.1572444-4-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 09:23:53 -0700
X-Gm-Features: AVVi8CdcNh5h8WMErAxmW7KPiR4Wqn3UVtsUnxwvc0NBhIvdgtC2iw1TEqVxDeY
Message-ID: <CAAVpQUAag2bMXG7O9vCfbz-zNqZBXFS-1JJGMqhkyVnyqb6=Cg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/14] rtnetlink: Add per-netns rtnl_work.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305139-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34CCC714745

Replying to Sashiko review,

On Thu, Jul 2, 2026 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 7207da002fb5..7959519e7375 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -273,6 +273,26 @@ bool lockdep_rtnl_net_is_held(struct net *net)
>         return lockdep_rtnl_is_held() && lockdep_is_held(&net->rtnl_mutex=
);
>  }
>  EXPORT_SYMBOL(lockdep_rtnl_net_is_held);
> +
> +static struct workqueue_struct *rtnl_net_wq;
> +
> +void rtnl_net_queue_work(struct net *net)
> +{
> +       queue_work(rtnl_net_wq, &net->rtnl_work);
> +}

---8<---
> + queue_work(rtnl_net_wq, &net->rtnl_work);
Can this queue work on a freed struct net object, leading to a
use-after-free?
If a thread in netns B deletes a cross-netns device (such as veth) whose pe=
er
is in netns A, it can nullify the cross-reference pointers (e.g., in
veth_dellink()) but get preempted just before calling
unregister_netdevice_queue_net() for netns A.
---8<---

No, the concerned veth will get a new netdev_hold() in patch 8
to prevent peer (and its netns) from being freed.

