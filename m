Return-Path: <netdev+bounces-281460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GTwFZ+172mFEAEAu9opvQ
	(envelope-from <netdev+bounces-281460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBE147925E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19FA03071C74
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377F3EF0D1;
	Mon, 27 Apr 2026 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLZiLVWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD13EE1DD
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316958; cv=pass; b=rANCZTriIiMdDpbfd5xycv1fejyfX/L95ieTPH2+wlT8+uzmGShRMrXOcrne7j8mpomAUkMwW50gV88jbLU/4X6Oqcet7/CXBcGCMj8/1kgSS/QIS45oKkV4jdCyyABdAg6VQx+n8ue/+HgFe5wuXZcSoH846R22jQ7R0iiG+4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316958; c=relaxed/simple;
	bh=p/vF9FXJAY2FJjUaiQjVVoGdbPVUxh18dW+tUAsV5TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hpo37l/EXJXTbkxChDkSihhbQG3NPjAgczftG7rei40QRpRTuNbPzbIZIgE401Rd8IBDxqDybYfYlFNcEKipsuivguls96okFaUm2JIwF3ewDX8+731zu0OdpQwaEB/tetxfLeSoLyXOUo/+Ogvib16KOGd5mj65yaPMh1kO0Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLZiLVWJ; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2de831d2b20so1580875eec.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 12:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777316956; cv=none;
        d=google.com; s=arc-20240605;
        b=k3p67g31yd/BcsuAzrP2qCa1dupKFW6ntMw3W5HMczI6VWW5F7PiPdvWMy3AIMuAVk
         YJPAgQLMB/0hX+4S5S8yQ7S7cJKdhUsi3AJ+213sd7JKLZt13Fc+NfeFAz2Yj2AS/e+Z
         O5AsYnF7PjzWmMZihy/VYPpcMKRUJRiaLmuR2ysctB1xX2qFcL+4RDodAmlvZBj1f2WN
         ucadhg1r8R5I7UPRnMDCii7mfyftqpw6BChPug3ILep5C8olSuxgDl8+w8iGJ3hn51oo
         4NBdBIpyl74A1IJWHICzQ56HiThCXRNID4UGOFWA9pEagYoONKkUQCUD1RFTaqmW+V17
         yQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gh4OLudKU7A0KCBedauzIRRUsQHgWNMMPIUWXm1xatw=;
        fh=A2Il7AtDqOgJExIayxcnpe4r2ZD413k2i9ojkuK/4f4=;
        b=Q07fChpbMtM/9bZtyMoDC5+C2SX5mC3njSNLJSX1cboZPfzAtxtZrQ1mEyrsW1fCRk
         SNhDrY4z8JhL4VG1hmxZRGxubVKO6gqMkQHyRDHwHli2Vqbo+1USJnmYHYY2L9tMcfJ8
         zanIWaFqH/FQaVxpSQ1DOgrnflNMvLBfnMXzc8ekM6TxXCkn3hJ9G3DSND+tg4mEjAcj
         6Rc3NkjqHHBp1+6DVw1Yshjoq0jHDB58EJ/akamfyCSO0lfC08+Qurkdd6P+OXp4N8At
         twWy9paYgntaYBf/Z2QzIWhuZFGGNTolLt5u9KmhB7dXxTeazpF6RnmxfjA0QBZRqWUy
         9CYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777316956; x=1777921756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gh4OLudKU7A0KCBedauzIRRUsQHgWNMMPIUWXm1xatw=;
        b=VLZiLVWJ9Uvn+JTdQghPX5qdyhD+36nGwrmTSgCAqHg24MOC6ku2+dngC2hU116Xrm
         xeO0MHwg0ZIYhqSw/Hslcze1d3GgjTqnbff3D4omHQoZaxcRICJgPunj/5vtPFCgxmqo
         fjfW31mtLwxxlfCocqf8SulgB0KcigHEbZ1W4jr3kTTnAlHWzeGimGVxQA5IZBTwiAIe
         pAUwYyw8ar7dlPC/QlloD8K7VMQ+AxgGPbYH/jv82RZzQMfSTQAu2JWQDr2x8SLCfbKf
         BeJQWpw8QOSo6naUTPa3hHtnj072lfDV/fu5WYbPaaQW3wx9vsWFOCApZrFASrjL0C0W
         WwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777316956; x=1777921756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh4OLudKU7A0KCBedauzIRRUsQHgWNMMPIUWXm1xatw=;
        b=W7ZYa39gt+eYNBxMTTNbn8WdAo7MKVMY4BW9tK14PcDmPNOMONJd+EfGk+PY4R8FUT
         xLBCadJ+akUS1DsX325SQCKIL/j2tP1inmSc3P11KcqsomRm6J0SvWAie/T2vTK9DbwS
         v1hvY9rMYrwkxgxnzN7I4hC3qBLmHVTiCG7/WYt2guKl5GeNMkh+38H2W+S/laH09j+X
         TOinchKnzTQTxRLlTiA+J9vSqlgyOZjodLpNzKGg3ja4jQqiXC5KbwIVNi7M9pJcpW3s
         ikhHCcQxyLiMi67NhSENRBFJd8T8aMn9CAY1j0Gor3/6viZxbEeNZd3VRlMA6lhFvmnd
         D5bQ==
X-Gm-Message-State: AOJu0YzRWz6NMbKv4qpiNeKDHXSs+U0WB+1i0wJdMYwuAtNKlinfcbbh
	XvyX7nJlYesRneXggw3+SlPTyHX9JQDecQOrS8taSBhP9N5Nt94mV/eRmUvhLelpDhQOZqhlbRa
	5V+gubLF/BbTGU2eW3GsSlT0YbfFc2JA=
X-Gm-Gg: AeBDieunO5ql1rgDoitVPQe8B9LXBdAUKoCkfs1WD4ZF5mr/HU+ItkaGsAuERBR4dV+
	lS5ZwOb6RI4uKc6XqcwS7bWztEwyQkkekmCtI4wTKqWpZjgUs0oslal7gaOevXrp9T7vL7UqhZ5
	tDijYdDt0RB9m4m6YgZBgy3/GqPZ59uTqwEuQYtxfJKdgzfP9G+4LeglpuuuZxaN/cK4G1C7HKK
	NVTYH/YHvS4u+5TJZPy49AdTTMAiaDbXE+xY5OGe8AcxVubma08wy95Y0xcP33nNs2KImht4rb6
	GiFO1IKlolMNIsSZf5Xn/jPzyBrAYMnwgld0suPizqV5yWY5fcf3zycZgb0CyEEZe2iNATDpYWm
	f8bPO0PNJxa7ujcQ3l3lB9XDXw8PeGjc=
X-Received: by 2002:a05:7300:6144:b0:2de:cc07:e99 with SMTP id
 5a478bee46e88-2ed0a013aacmr84460eec.7.1777316956086; Mon, 27 Apr 2026
 12:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427172727.9310-1-ebiggers@kernel.org>
In-Reply-To: <20260427172727.9310-1-ebiggers@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 27 Apr 2026 20:09:05 +0100
X-Gm-Features: AVHnY4JJWvpg7bTU7jYNNN2GruZova4uBYsRbdJTLdmZD4F02zLyOKtxs4yCOJQ
Message-ID: <CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] Reimplement TCP-AO using crypto library
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AEBE147925E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281460-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url,mail.gmail.com:mid]

Hi Eric,

On Mon, 27 Apr 2026 at 18:27, Eric Biggers <ebiggers@kernel.org> wrote:
[..]
> To make this simplification and optimization possible, this series also
> updates the TCP-AO code to support a specific set of algorithms, rather
> than arbitrary algorithms that don't make sense and are very likely not
> being used, e.g. CRC-32 and HMAC-MD5.
>
> Specifically, this series retains the support for AES-128-CMAC,
> HMAC-SHA1, and HMAC-SHA256.  AES-128-CMAC and HMAC-SHA1 are the only
> algorithms that are actually standardized for use in TCP-AO, while
> HMAC-SHA256 makes sense to continue supporting as a Linux extension.  Of
> course, other algorithms can still be (re-)added later if ever needed.
> It's worth noting that TCP-AO MACs are limited to 20 bytes by the TCP
> options space, which limits the benefit of further algorithm upgrades.
>
> This series passes the tcp_ao selftests
> (sudo make -C tools/testing/selftests/net/tcp_ao/ run_tests).
>
> To get a sense for how much more efficient this makes the TCP-AO code,
> here's a microbenchmark for tcp_ao_hash_skb() with skb->len == 128:
>
>         Algorithm       Avg cycles (before)     Avg cycles (after)
>         ---------       -------------------     ------------------
>         HMAC-SHA1       3319                    1256
>         HMAC-SHA256     3311                    1344
>         AES-128-CMAC    2720                    1107


I do like these numbers quite much! Yet, as I mentioned in version 1,
removing a fallback for other algorithms' support does not sound good
to me. There are two reasons:
- Ronald P. Bonica (the original RFC5925 author), together with Tony
Li do have an active RFC draft to support the additional algorithms
[1], potentially in addition to TCP Extended Options [2]
- There is at least one open-source BGP implementation (BIRD) that
allows using the algorithms that you are removing [3]. Without a
deprecation period and communication with at least known open source
users, it implies intentionally breaking them, which I can't agree
with.

I don't feel like Naking as we don't have any customers using anything
other than the 3 algorithms above (and BGP implementation is
[unfortunately] closed-source, so that would not feel appropriate even
if we had such customers), yet I do feel like it's worth and
appropriate to express my thoughts/concerns.

[1] https://www.ietf.org/archive/id/draft-bonica-tcpm-tcp-ao-algs-00.html
[2] https://www.ietf.org/archive/id/draft-bonica-tcpm-extended-options-00.html
[3] https://github.com/CZ-NIC/bird/blob/master/sysdep/linux/sysio.h#L246

Thanks,
             Dmitry

