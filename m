Return-Path: <netdev+bounces-277672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nV/RHGXs2WmQvwgAu9opvQ
	(envelope-from <netdev+bounces-277672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:38:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B69873DE8B0
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F4C30252BF
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D69311C1D;
	Sat, 11 Apr 2026 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr27Lt6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB3E573
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775889503; cv=pass; b=UiCKWV5fzb1wrT1JZDGullKQ9D4aboJauoe0wV2PJ5Bna8FaECJ0ma5/B27dfiUKNbsoQiFf7vQC7KVxyAgt2S/s0SFYLoo+r0vy9vVAYO378mjL3J8+Lfdpo13yR00DwASzSk2FptfPmlszNqNrZ7QwStOHClLePc4BPqQjARI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775889503; c=relaxed/simple;
	bh=Pjw5m9j2ub87LrSGTrnu78rE36tfGV3z59ZAy8/DTHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOP0LQYhIKHMuDVftss/BbhkbXn9MgngIgrzOqxtSRWa+eJ4oMGuCkzRnP47BxboiBSQdW4r+MK7RdNBb7WMpTrLbU794VMBL4lEz/SoCR544EjhajeukYWG6spqMyEUDOoK2xHhHUhLQs3JrVWqCK/pOPQdrYA5plde+1+S+Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mr27Lt6n; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50bbc41677dso37789251cf.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 23:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775889501; cv=none;
        d=google.com; s=arc-20240605;
        b=ZTuDgoKd7ylukUHLBvCTGZy76HrqEHfoULCtA0TDrAf99WSkZvPhT5teT017ljiQ1S
         cEk1yadRC39gkzUbgz3Bta+L3F5dR0iucDulPdgSZUPiiIBkV5417rXWeHpz898syOTg
         Ud88OuWB14sv/3Ymw556A46+OCB4/yUPRTC8Uxfw9YQCboS0+EoP6ZymowfDw9RTExOZ
         Nfa2QYFYlrFwqz3uaLa8uvX7KVqyJJbUSAS5CvS4zxGwHsNtw8P0aJoeN5MCEMhYdxuj
         9qzQQY8yauN9Stceo6aOdMJy7ai3l2SmgSyvwJuiV+19i4GHj6PewbtCTK3EQhJPgeEi
         Tt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pjw5m9j2ub87LrSGTrnu78rE36tfGV3z59ZAy8/DTHQ=;
        fh=3JaD3hmW7QDlgL2w/ixcWzpc8M9PUB0lf92LTafPEaA=;
        b=T7Q3dg4TKrzbt3+WCy8/4tDjwdxOQbgu03y7CbqZciGAt1PqfFfJb7yftSjS3Xv4Es
         JGfFzWffYqyGBUu26a+kh+8tAERZ3szzWxzu/Ws++WnN5EsDbGLYhgH7Jb21oiGH/HPw
         UBh/SyIkef8tsLZ/pyRxKKPEMAn+zGNdMi5N2WOgaQzz4Nm11goxSZLC3ZlLI9uB9WAU
         BNR4E2Cr3KFnbHdHsU0Eh3gdpYOl+tePZKrZmxmqlPz61ZIInnW+c66xjKWNYcWpZO9C
         aJoini4Mv4Wb9gVS++hkLQyij0dmBi2d3ZIS9CI913aqt23Q8+zuvhY+8AiMYhRz4IhO
         mlbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775889501; x=1776494301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pjw5m9j2ub87LrSGTrnu78rE36tfGV3z59ZAy8/DTHQ=;
        b=Mr27Lt6nEIrvjsqd48T27S0lzz67zCtksPB0gRVMYnFcDkXaXA7q9hE/sEesMXKIYz
         OSXBqp+ywyZBVMBJEB1uCsn/rDW2CjNaC6HEbf1vcGfeO3jzlL3GdgO5Su6EFtogXDM+
         mPYGxS2OEII49Bjrtr2dw568nq+KcPAEXovClGDfLM80tktbsFUOQ8pDF9r4hEcyqTr/
         KpijzJAI4HbtQm0xb03NwL4taUUXLb7KQM63BWBRX0f3JAAiH2rld6mpGT++SuzAjsIm
         gE6/gmUUzDXoTmuGNMQl4fMXVFhckP0j5L/hBmCa4Arxo5iBs/cYo9KaqIvKanYIrCc2
         Zqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775889501; x=1776494301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pjw5m9j2ub87LrSGTrnu78rE36tfGV3z59ZAy8/DTHQ=;
        b=TUz53fL3MGb01xqz+TyPZZHgDmUnd7RNakTtj0xK07DBK/a6iYy5PTHFj7hFKFgqS+
         mxR+ab+YE6K4YLAjXtyJL8qtE0WklDYrOC56IISxX48gMLRdq20RyOCxbOunsy43LKER
         aKz4gAXqEoU1ojBV/uK2qKEC2CHyaeSC/l4G3HQTG9l1nfCKZU1c9aI8P3HWPAntXol7
         yA+XcsJcMR63iJnaXgK5sX7SJFoFpFHXL3aDlJThJrCr+YrTomZXjkZawq4t0ARAXV4Y
         809qYt79HaAY2MyPGBowVuLw25yXiSYfg35QnB8/UIr9jd3doFK6Hyr+HGm0uCXS50TS
         XGpA==
X-Gm-Message-State: AOJu0YzQ7I7YAAL35Tx6Nm+vcqjTjz+wgum9MK2q0bfq+FbDa5UU2jtb
	KFgGKJu3fJ8PChMqjkS0ECnYnRr4fmhbmOacczsybXUFc6qRrkyPPHX+LL8cWzbnCUoblJsYYdL
	7WZIl6mxvXWa3vvyEISXjmw1Mf9KWmszSBRtSvpDV
X-Gm-Gg: AeBDievFUBqIQYyzoeULI4oRyvFyyUktJK7s+PgInxKaaflQ2s/KYNoM1c3Z2e+nprz
	Mb6lH8QsdsLryYgc4T7vut2jZI7+rlh7Ah4MAFTqC/mmVw6ksCm17jJo73JaXWkXrdrCz5X8Mnp
	2brJ+ZUyy/bpW+A8ankHUJE4x6qvKmroZG0V/vrht7ZCPSTmhwA/V6m1clOpnfT/dWH11nuLIqk
	zFxaQei/N/bpU6hI5TEONeQULPvUthog2lwOvzOx+MJk+OYJ0apRRUj6H8EryW/fVFD+xXy7aQh
	EYjcYWoUGGODelUSX72RPwhMLZijYY3JkbQwCoAuxcthPnFBGvOjZPtPgHua9pLokOTgx8zC0w=
	=
X-Received: by 2002:ac8:5e11:0:b0:50d:ea46:7eb3 with SMTP id
 d75a77b69052e-50dea468559mr5982521cf.26.1775889500839; Fri, 10 Apr 2026
 23:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411051700.311679-1-stephen@networkplumber.org> <20260411051700.311679-7-stephen@networkplumber.org>
In-Reply-To: <20260411051700.311679-7-stephen@networkplumber.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Apr 2026 23:38:08 -0700
X-Gm-Features: AQROBzDr27eodvQwHkvJKqi2dRn0dX6KmFpM8dVgLo0Xj_zabiQieGJWrAj39Qc
Message-ID: <CANn89iJeS-Hw7NNouSWYw6BZvTUG=-grVxAiYzg8a8pEO_LJXQ@mail.gmail.com>
Subject: Re: [PATTCH net v5 6/8] net/sched: netem: null-terminate tfifo linear
 queue tail
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Oskolkov <posk@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277672-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B69873DE8B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:17=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> When tfifo_enqueue() appends a packet to the linear queue tail,
> nskb->next is never set to NULL. The list terminates correctly
> only by accident if the skb arrived with next already NULL.
>
> Explicitly null-terminate the tail to prevent list corruption.
>
> Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Simon Horman <horms@kernel.org>

Can you explain how skb->next could be not NULL ?

This would be a bug in the upper stack.

Only TCQ_F_NOLOCK qdiscs (pfifo_fast) can possibly get such skbs, and
it would not care.

Other qdiscs already get skbs with skb_mark_not_on_list(skb).

