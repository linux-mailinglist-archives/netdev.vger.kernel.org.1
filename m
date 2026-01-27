Return-Path: <netdev+bounces-253679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDnjEeUweGk2owEAu9opvQ
	(envelope-from <netdev+bounces-253679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:28:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D78F96F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 098AB3003810
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3030594E;
	Tue, 27 Jan 2026 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCTCTH5m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231230AD10
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484511; cv=pass; b=QOIh3gL3X/rrlhHxgphCYQQrdU/5OWnEypbR7irxAUh8ArU7vsn2QOuaFB7E4eb0PVOHI68gkHLUdJhbfZ00jfE+AbYf49RHktJm5//v9wh0DQZoDL3LLmSt6+k9YvEymz5ZDYRsP0TOZhSCvDySeLwE7rwElFVy5FNTtDpHE8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484511; c=relaxed/simple;
	bh=2YTOcweGzqf8tPc9zYj/MJ9x/xKiPFJ6R8zKdhLEwRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB4ACQbaEKtuynDPfrXMfhWkLAPlbzF3cDJwmVaZSV5auPvKaPzSTpz8rTeoaKbKa+xXnZ2ngOdyRRMPSCKkYCmkWg8CBfHe8iMlVYKaheyAGTu301QXYpySWSrZ+6jNCGbtHOy5xppG529l7q+WR3nlTbsSJzI2U6oKB9AGwng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCTCTH5m; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124566b6693so11619754c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:28:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769484509; cv=none;
        d=google.com; s=arc-20240605;
        b=PvnOT3Uvm0J5wLv87kwuNIyR14HfubpzNpeLGdmyGMOWhAFIEUdg1GhGcuasSCJk0H
         lpNOt8uikZ7KXC5cS7NxFudEI2KW9DOTDRcDiZNC5YmAvmT7zKLWmB9Tm9GsOZOGyOY0
         hyzZjCdzkC73UzShP/G5N4UtDP7Ixvu7+s+6jO4gIGD+bEs5UiOZq4ussaq1pLAjA6V0
         JUuOpo9WKO3ZQYAEiHxl3ZDoDq6nrtdpXklameWprQxT3h7kdMpos51UeYRU3Kw6acNy
         nigEfB1ljdKDaqPvdR5TQRNqUxMrWsXsxpUeZUZL4I6sOV1Rk2+9HW+qRyYreE444ORk
         F0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JhLsMu8V1t0Puy+ufgBbog3g5/kM7/pCl69wzp4LWlw=;
        fh=MAffpZjgJfpvPQCTWQZHirVrQvmAn9vhT12mQu98aYM=;
        b=kqDYIxN+s1JyNRUP8SWUPKEmkxaE2VkQsxEEzd/U7RULDO0WayX+pGQUoTKGcUxWUQ
         Le8gSPtaRz6zcC7NQqPuRz2Z8nS56G5ohTIAs0xIKiYkbs6RxAtnHn3dlOnx3Vk9UT2B
         EAqYyPEVVfefrjnp6U3UxA7oCA12Gmn0XkaR0+XuwcY34VcAkGQS03vM9LhNIxSbZqZK
         ZE4NkSpulpmikbeSGV0N6saRRKE2LM+jDSUORmpUcekZfH02WzLhOLyeDUcmKooszLzC
         uq6KnCetMRZfyqNSRd056vfUutKFAAKp0aLReKPfTfI950LQ3SApPq1wykKyF5rJfal+
         3tGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769484509; x=1770089309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhLsMu8V1t0Puy+ufgBbog3g5/kM7/pCl69wzp4LWlw=;
        b=lCTCTH5m7kuKKT5u1somll5A6moxr0juel/qUG7cdg9Ie0rAczczSdUJAaHZiA8b4I
         a+DZ25lJqmXGI4Cr4TUEdLjDWb6JiZx38Dgs18LH/4Gm94Wyr3ry4z53KzRWk0x7JZ9A
         9s0TVfnd6armBC4TP8nniQGcx113G7bMZ8jNY/29DOW03nMLf7Re8EevY2EYB5Dd6P4e
         zEcyyuwNF+iEaQ92srA4aCEtSoEfvh+KT/POnAKs6ljUbki7wnpBncXZLygwqUVrXfBN
         36ORG+GteFz2k+g31ewwCaljxchZsvsvzT5bCG1TVV82FSIgknWs57DDmy2FOrL9tkZ0
         hJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484509; x=1770089309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JhLsMu8V1t0Puy+ufgBbog3g5/kM7/pCl69wzp4LWlw=;
        b=GOY4GdHiis89eZspDOqJlZ4FJ68gX7vsOhsA5vocIFP6Cr4+tckn0fsMCN/GYzi6ME
         3hLPnvUdCWbJQDHwBvO0CxGZAI8ae2PMe4F7K67ETFdkBOh9h9Vq3Y7CoBtYPIw/9Ts7
         71v7Nl/Rgk9J56ZQm6+mYTx+xvImnl2gswJU+t4cjczie2HupBr9ntoYSqW6slYt1zAb
         KkVRhCLoUJXZrRoIoIK//hkX8xJ2YUqRDpP8z9OiMuSj4oqbyBujkIzygbQ4Wx0BTQhJ
         oNgjzZNcAjGCMuOd1SYGmB+CWWYnR3yz6334rTb+eMHJ40EloZkeCwCXQ8BbkQ6hHtp2
         BiAg==
X-Forwarded-Encrypted: i=1; AJvYcCX9d1RcWgHaDUvfDqYwNX8Kr9na1BqFLj7efMSZR2/VZVXqznNXlUagKVq3caHCRFWRIfgPbaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztCG7Q9H15PPW6ooLSb9MELrannqRnliwgcAZJDifGDoPHYoUs
	7NCNHympfHuqiNURl4TbQ80MptrFX2Jl3M/+FhMLONTtT/P6K+Y+atH3II6ySoqbKSCj9OeELnt
	PZGLPQLk/dhena28Ujbzh49xEy1iy8sGRXIBBcB5C
X-Gm-Gg: AZuq6aIUYlWFHbYox91VSESmIt0WmJpvUoa1eL6BIGk9w3KDHevSok6ItxLtW2ldJVT
	BHX+OWZWiN8QrWfNoT9GdsL3kZG9rGUqUgOJAFwJM2I2B7NxNp46wpX4jPzenehfP5Jbdh314yh
	lXnEAszosScTEThUb6aSjyJO0kLcBXmVAG3Q93HKkcdH2qna2lL4T+Z1yjs81uEfc13mg2wPEd0
	Hi5OPoGlkYTB/Jzt9BH0+PHnPFsEzwOSDD3smTnvizuuq4eW7FC971LTgNr/eJtcJ2xGjev1DN9
	TZZdTuuWR8XCWXMxTiZ+dU83uy/s5IVsCRXet5yYYc5PH5HzyNhkJPwt6SuG
X-Received: by 2002:a05:701a:c96e:b0:119:e569:f279 with SMTP id
 a92af1059eb24-124a010924emr194226c88.34.1769484508381; Mon, 26 Jan 2026
 19:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127032147.3498272-1-edumazet@google.com> <20260127032147.3498272-3-edumazet@google.com>
In-Reply-To: <20260127032147.3498272-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 26 Jan 2026 19:28:17 -0800
X-Gm-Features: AZwV_Qg_xIBQSsirCWqJE0B8LNrqFOZVMnbNv7IC23NipFp4Ky1jjUgXB0fNM18
Message-ID: <CAAVpQUDQCgr1agsXm73pZLwWg24MgDVYrDmuj3tu4ZO-XZ0=Zg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: move tcp_rack_update_reo_wnd() to tcp_input.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253679-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 6F2D78F96F
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 7:21=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_rack_update_reo_wnd() is called only once from tcp_ack()
>
> Move it to tcp_input.c so that it can be inlined by the compiler
> to save space and cpu cycles.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 1/0 up/down: 110/-153 (-43)
> Function                                     old     new   delta
> tcp_ack                                     5631    5741    +110
> __pfx_tcp_rack_update_reo_wnd                 16       -     -16
> tcp_rack_update_reo_wnd                      137       -    -137
> Total: Before=3D22572723, After=3D22572680, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

