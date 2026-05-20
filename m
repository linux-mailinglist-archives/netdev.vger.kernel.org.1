Return-Path: <netdev+bounces-289725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMGbNVsdDWrZtQUAu9opvQ
	(envelope-from <netdev+bounces-289725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:32:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7504A586DD0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248AF300737A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30913093A6;
	Wed, 20 May 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIBqx0lB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE4308F23
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244221; cv=pass; b=W+Z+qKkFPX6aqfJeK24AVoAAWMOzeGAH65WmZr3/g1sqj2LgBN/cKEWrDItE5GH9uhjGdN202/AejnaGMG+KGGJ47lVmy6OQIjE3Yn7dgAtklx0d7FWlVMqIU1uRg+K6LuD7KFZNukHztCI8GWD1PNi9x20/15IHMKe9FF6Eqwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244221; c=relaxed/simple;
	bh=H2/5Mi0JEOVCVouNDzMmbA0sHScjrWiolgl9AbbbL+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdtH15ysIZ6CWZJM753qyZl3ymbthLyIZrJWObsUr8yOCHJl+w6XEHUEiIskVjO91XY90onFJnbZa0dEXftwZql1tNMN4qzhLVNwWHQnH5PVfBs4JSHr/J6mdVp0WllGi3svGKJ/d3WUqzak/Db1ycnLGOpaudjgKJWfXB43LXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIBqx0lB; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-133466cf955so15188996c88.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779244219; cv=none;
        d=google.com; s=arc-20240605;
        b=GgCjgduTnkHhf3vEM+D+1MA1GmCG22j3bMKl97CtlQsjnTi6s8QFpbEn3jEZ45OlJL
         hkB9zjzdS49uZPTCzy8at1sYFRoA42mJSNp73qDqfUrKKQT1DRUjBXBzzpadBpNHTiVU
         XYlvokwavBdFfcd8UMnURwSsVUBNDz84o2laltkYuD1bG9mHUjjY4HEhDBIHlXgWghil
         GFc+NUIdbaRWVKHdOvcwCMtdtlhL5C5pAcsAjDS1Jvn2CaKQnM59ql9/0ez/G+w1Eumq
         kzAIoK2vynUO6ttLCdI7fZdvhsT6NojBaZ9Vco2N2ZtKX1pbjcukAetXf+dlXfsl3teK
         oAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7IdQEhWwPCpVw1bi2peGtCzo0AK4OeVuwJXm3Whg5A=;
        fh=mf5sHxakTwYYRAcNGdhv6/VLKjMTa+PisafHgRd15Ts=;
        b=BaDVGT/TaHj5W4wu4fVnQWjVO64wqHoLZi7vhdOvP2/2Y9MQxBV8Q6Bpiqz2C/MtSr
         y5qI3gb8FxmhDN9BI6jzA/8vGz8m9C5tfY7ghdb2+p1OnvAX/pNQMuXejJqluqgxwQ44
         gfxdcznk8Iz7/qbzMpotnCUIfVWWIrgI+J9iFCvQMrRuA93z40lAohMKBeD/rd4mLXqx
         paGuxDSETRLwjKOVTbbwSUrGWRgF6Aw2Aq2CuFYCf6IBI6Z46x8E+5Ljkt/wuiZsRtjB
         BXYx2c2JO/h2OW9/U+7zYk6lznJKIO4e7TzisKjOWc4FdHleK5A8mu2tmQQw6SW+2T+r
         QF8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779244219; x=1779849019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7IdQEhWwPCpVw1bi2peGtCzo0AK4OeVuwJXm3Whg5A=;
        b=CIBqx0lBMoQsZnONnhpF9F+pqWbotqKluRT2rva9CQS/w5sF0Qu9LClgFwpheKqhb6
         FIJj12Av1xZ5KfR7c50fvMYluYpjUe6z/uSbU+GrQi+3LCdK5grw70dQoh6l3TmJHyri
         XSCBHEanjKy+sPkoA7/BSHZTkrH5SzcOGi6lWpbUHLnY6so9OA/tvcmYhkToLhhui2qK
         BQVjVs1/l9wK5v7GInUePzl2bovG+LB6YyOa0VgwMYgsEAa+cuzCzBsi1pBuj8hbjERL
         gXiIAvopU/4zTQeRvuIr2fV6El7Eu0+GWkfL796LThlgC91gvxsphtFmqJ8atCm8mls/
         fPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779244219; x=1779849019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7IdQEhWwPCpVw1bi2peGtCzo0AK4OeVuwJXm3Whg5A=;
        b=CMkeLNzQzdki1w86fMN4pCHy4MCSLxREL//vMCh6uwj5NRIJXf9KUmEAykHaF+/pNq
         s9nq7ANPAYRJuYVdUU5/W3AiVSMG9vEftnM0kiebH35YA0RU7J4kPXTA6g+OrvzDRInu
         h4weZVE9CnDE611lwyKn1YIGf8y5r+D8N27lnJkCgctIn5bbX33YDJ0XGHpJaBRvmWaD
         onH+TNlxF5PEeoBDs3DZlBDkzNRjfIpBWtASaM3Tqbo3uq9DvRYJFRXhCWZCUnxJtRE7
         WV8wpL+EoYZ35LN61iCs9vODL+0vgNF9VwYgOc/k97GgOQqVlZ3YBtOC2JhupuEV2epk
         BJAw==
X-Forwarded-Encrypted: i=1; AFNElJ/re2g4CHUtyJOmiyUhcnHwxODohyHjtANCRka4ax5WYdz54Fv7aQ6t7vAT7wwR2uSvLnbDYeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq91QSmneIx9nWZ32noVr4jaD3p3t58yYOsaceD54pV7qmrQba
	sm09eVUE1oYFi3raXyUEpFhh2jzhNlD0K4/Py34SgybCENLmGri6aU833wnyEIIl5+TMX74d2HG
	KavKBz72QZJ9JDDRRk13WmB6xOTkvI4DYsaVChG2J
X-Gm-Gg: Acq92OE8VYe6KknnYBFH9jeb0B7jGXET0lmQZOKKFEka7oS2Ld+aBJ01yW6sqnADdk1
	ZyRLS8lxj3kQCkLAYRfet6TYjtIC1T3EAHhjeuSg2XFwJ+S+QNyBVWIKtQ+9yzffjA1K6HNDYw5
	zXSkcCLybliVfB/Z0RbaUxbHIcV97sR6IbDM8Myuy+I/QtR/RTtw4sIng4HuoGQCXgdNO3SBNB8
	/znG2EQS7c/VfVGKUHvChCekGD3DFcc4333UTymLMyUzE6u4vYU4Vnii2UP+hgIfyXZOVLlxnwT
	s/Bs0D41bgoOcD/sjtL0mcgK4WIIv9jrS5A5MHuIvsDFimVRr7W9kjheL49GR/eRLR3Kgbg7fZf
	AY21t2kpYfpNh9WSloVb9JFWsHEXn
X-Received: by 2002:a05:7023:b87:b0:12d:ea4f:99de with SMTP id
 a92af1059eb24-13503decf1dmr9907509c88.0.1779244218787; Tue, 19 May 2026
 19:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com> <20260518050726.318824-3-kuniyu@google.com>
In-Reply-To: <20260518050726.318824-3-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 19 May 2026 19:30:07 -0700
X-Gm-Features: AVHnY4KkGWpFUM0IUCGRMsbhFh46guUBXnvBnwvH8n3Q9DUygGC_xILj0oz3QME
Message-ID: <CAAVpQUDeQ4p5fDOXuWy6fqFA=y58UfB3h7F5V1jvMYg9_p_TmA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/5] geneve: Remove synchronize_net() in geneve_sock_release().
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289725-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7504A586DD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For Sashiko review:

On Sun, May 17, 2026 at 10:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> vxlan previously had an issue where the fast path could access
> stale pointers, which was fixed by commit c6fcc4fc5f8b ("vxlan:
> avoid using stale vxlan socket.").
>
> geneve later followed the same pattern, and commit fceb9c3e3825
> ("geneve: avoid using stale geneve socket.") copied synchronize_net()
> from vxlan_sock_release() into geneve_sock_release().
>
> However, that change occurred after commit ca065d0cf80f ("udp: no
> longer use SLAB_DESTROY_BY_RCU"), and geneve had already been
> using kfree_rcu() to free geneve_sock.
>
> Therefore, the synchronize_net() was never actually needed there.
>
> Let's remove the redundant synchronize_net() in geneve_sock_release().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/geneve.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index b36fad833724..4e5d0a09a82d 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -1032,7 +1032,6 @@ static void geneve_sock_release(struct geneve_dev *=
geneve)
>  #endif
>
>         rcu_assign_pointer(geneve->sock4, NULL);
> -       synchronize_net();
>
>         __geneve_sock_release(gs4);

---8<---
Does this function leave the device's hlist node linked in the socket's
vni_list?
In geneve_open(), if the IPv6 socket setup succeeds, the device's hlist6
node is linked into the IPv6 socket's vni_list via hlist_add_head_rcu().
If the subsequent IPv4 socket setup fails, it calls geneve_sock_release()
and returns an error.
While geneve_sock_release() drops the socket refcount, it doesn't remove
the hlist node. Because geneve_open() failed, the interface never gets the
IFF_UP flag. When the interface is subsequently deleted, dev_close()
bypasses ndo_stop (geneve_stop()), which is where the hlist removal is
normally handled.
If the IPv6 socket is shared and remains active, can concurrent RX traffic
trigger a use-after-free when geneve6_lookup() iterates the vni_list and
accesses the freed geneve_dev?
---8<---

pre-existing issue in geneve_open(), so orthogonal to
this patch.  I'll follow up on net.git separately.

