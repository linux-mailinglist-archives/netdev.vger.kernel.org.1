Return-Path: <netdev+bounces-283654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAbxGIGZ92n0jQIAu9opvQ
	(envelope-from <netdev+bounces-283654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:52:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B24B70B8
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA95C300CBDD
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D93A1680;
	Sun,  3 May 2026 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8aqr2FT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658FF29BD9A
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834350; cv=pass; b=DQS43TgbwxCYmRWKDbTD8UFUQqHjajb327cpr5AC63el2Xuf4NPSwY3Ze5asx45dadv9NymOoymM4UG/43L9BqLTfLN6Fb4xbg2Jy1Hy6gE7hmdsYccUDaWfo6afVY0XnbF03nFBt3fe8xVsE1+ijmuxOX/7GzwcjVTVRIxv75Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834350; c=relaxed/simple;
	bh=yv7CerahI2NVEknYv+y638IgLoJgpJBRXjcNyiCscRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7XXbc+j47vVrOtk700EKVKbtLvxB4AfQySK8iQNyj9gfQBRHSv9MpmZeEerKnCuMHAbp7OXi9xoefUhKg/MhBo/ToCxfVHu8oaMP8cC50NOlHmeO2o9bBRwNk5BmrPSHj75NJtDwAJLCd9Xt/WVznUFzmej2eaMHz8tAl8NYIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8aqr2FT; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so2482428c88.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 11:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777834348; cv=none;
        d=google.com; s=arc-20240605;
        b=emlLbWN6GFTGb8xlzFINFVsRwyAIRBXIg+m61A9eDI4uD7/HUK6YV4TpZSEhpkKhN2
         bxysa/5xhZR0xe6cZtRgvbdQyJPWktN21LNZUy88a8Kj0t/S+0YHsA4UGKGhQcnrCF6r
         M23To08OzSzEUHg7TotcnEJ6j083Gxfoktx3uDHeId4ZnChw3yROTuJF2HKGdJ4NHo02
         y684lcO0zh4Dj8PwOtTXDOgOZXAiZBUlJAAjYUaTGzTJZQ445uAMc9EncTw8/20ThkYc
         LjvP+dy0P/my04zzgYATGiEGPso4Iv/+Fl7+Edw0sbju0CaDHed+v/WTAy66X0trj3oF
         YtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HixNSdA1lTgSWzXNH0ZNwJ+uxbB5bM5LXSF1sK/o5KQ=;
        fh=GFImalOxwlWw4Ril+6/S8lBPYnUCjXLsKUCbTXX3U1Q=;
        b=dO7RvAfKLW/rdcvsj06MetKHUlr+Ykgl0RbLxwCqgPBqaH23dUcf6+llnmHtH4ovhd
         y0I4o5EdSEnXNDn1L52MV8OGx7uzaMsKWJsC+Rij2oRRjTnZkcKBmDnOaxfnl0jQKCab
         3SVh2dwbUSxmWdFrNB8bWkL/yPzqOkLQS/bPrH8aY0C5G1PiMGRvN07wP0ujXGPvYz0F
         TQpZYS0lfJ6czYeYcKinr57HS43AMsroKXUK6Vatv/o87j1g8OSwRZX1DtG9OWMENRzk
         G4d9Z//h4ifqHmKRCd5HFQWG1gSeW+A3276lVa5Gwzn5/IgNFnnKoQJyphe0kQkmVC7A
         sp4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777834348; x=1778439148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HixNSdA1lTgSWzXNH0ZNwJ+uxbB5bM5LXSF1sK/o5KQ=;
        b=Z8aqr2FTrHrZJAFMqnZQXpldwxho3QZ363gbftb/ABlFK0vmaDc0RudNjxtbPMFMTI
         KpJNuqX7m87b2k5h5BzKiLPxzU55oXdQd3+G4tVfdNoFzcT3dbsJMrsOyJsx3NIuX4q7
         iqCGoox7+y2Det+n3bW+TTvVR9OlAQBOuep/JXEgFfKjmbtqxhyBesxP1SkpoBXvvV6O
         PCP4SluGjL+UNZVByoWgUeDTpM0KIABHqdaeVGgS/6U9h6wH36jwRPmieloKBg9A9t3r
         x0EmF/rzVg9gWKmkMHlVA6hTA7Qb03j2m1GsBnx8qD40XiWmvYZjQB8O2Or7alTHPC1U
         u5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777834348; x=1778439148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HixNSdA1lTgSWzXNH0ZNwJ+uxbB5bM5LXSF1sK/o5KQ=;
        b=mocndR0zH0OcX6+94q/2QSmcCswgC0ajPpQHeA610AjQyWJsEsuHgy3OWwNrJ8dBTz
         xlOG0kiZ8k+jtF+vs7Ek3QsGjRTQUbmUO8J8cBFTlr1Vixbx0GqlFzuBmqIfcbOxFOX1
         kl2irxLwGMPjlkDd+r5+QXAqTcnFDk61h2viVK/NR4N2CtVphH3j9e5/EsPPHGaD63t8
         cNvcmDpxdvTHBk3kqx8crUR6GOXBPTAPRLk5ST29A3GWYWpAQv13uVhgYIC1z1WQPLw/
         zo0EKUj+RYD/I46gSHPeY45vOAAeEEZfEwcuxfpbMWKiUdaYuOoVsBnTHJJMA66gOUQq
         31og==
X-Forwarded-Encrypted: i=1; AFNElJ/khXRSb9ldk8HQ02V3HTn2h8jej0Y5Qe7a6H0W2F7qLIw6/8c4iyotfDDNKwBQqYv66UxeY1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHtvYs7oSSDPZotLxxo1yRdb9IK7tAmkFQyQmXS/86Ea+UQ3+i
	09O+U5IVzpqUBV4NepdNova5weCJgBassPbf7PMLcvFxxVPO551efV8rt3RbblUVs0yLeVbDXB5
	1wk7Fdoyu5Few4qoRNhjCz19buWZUYlEsZDCZZxW2
X-Gm-Gg: AeBDietTQLyiAHpNMUWyj+2zSAH+D9Lyy/xZuqeBw7eozsG8qQkHLr1AS+CynC+w8Nv
	C2ajU0tkQBBVIPm4hmNKsxoDVwIew9QOmbg5woR4tU8Wal0t+2A6PrH15+p7Dxs/rTRH4mAxIcL
	Gtdo6QPTSEgux1g0T69Lj6J2Cw5ACEw3hM4spTJN9ewj4X4AU6u1gV15LNhOe+0hT1HlREsYrjf
	LNSitP/ngB3pIy9IO7IuCpnCj0C0gEH3ns0wfB3eK6acDZG7Y/rmowbb1+Rr5IAd+PDAzYSKEet
	ECs3rO+AncGc7fPwIKV6M7X04s7FJVCfzHjagdJDJ6gw89TU76UzuAj7c07uw3KCvQwywbPfrtq
	KnI1r1zlasCd+xKRIZM4pb1kuVI893nELLHHw/0LkMncW/CH7ZneOpR3fZuo1cyT6gOvU515mNA
	==
X-Received: by 2002:a05:7022:f102:b0:12c:6ec9:3f1 with SMTP id
 a92af1059eb24-12dece2f0c0mr5185578c88.21.1777834347944; Sun, 03 May 2026
 11:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com> <20260502031401.3557229-12-kuniyu@google.com>
In-Reply-To: <20260502031401.3557229-12-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 3 May 2026 11:52:16 -0700
X-Gm-Features: AVHnY4LY6IxmS5jL_u1Msumub94NsoJLD6tAYponslxUbncus39uB3FJf6p0kdU
Message-ID: <CAAVpQUDg+ex-mKUKEEVtMHqOVnxHMoNp8XryU2oE8FRTwKrFbw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 11/15] fou: Store struct sock in struct fou.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D24B24B70B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283654-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]

For Sashiko review:

On Fri, May 1, 2026 at 8:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> fou does not need to access struct socket itself in the fast
> path; it only reads struct sock, and struct socket is only used
> for tunnel setup and teardown.
>
> Let's store struct sock directly in struct fou.
>
> fou_release() frees struct fou with kfree_rcu(), so fou no
> longer needs synchronize_rcu() in udp_tunnel_sock_release().
>
> Note that the error path in fou_create() looks buggy; once the
> tunnel is set up and fou_add_to_port_list() fails, struct fou
> should be freed with kfree_rcu() _after_ udp_tunnel_sock_release().

---8<---
If this error path is known to be buggy, should it be fixed in this
patch or in a preceding patch to avoid a use-after-free?
...
Could this be updated to fix the RCU removal ordering?
---8<---

Yes, but in a separate patch for net.  This simple change
doesn't even touch the fou_create() error path.

