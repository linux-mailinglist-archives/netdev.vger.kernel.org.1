Return-Path: <netdev+bounces-274393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNc+LXcQzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:45:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B926384A3B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695E43092560
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F2F31E821;
	Thu,  2 Apr 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXmIDmr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D619EED3
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111875; cv=pass; b=U5F6QER8PgQ4WNb4s8DziGvbBe1lx2+ryYn5rjYKh1GwxM+ArVEZBrhDkbK/6G9MKaR3j3OxiyD7tN+LkuKXvh8ez6ipl0zRjF8i2Gvef3ANiEgVKJFbSvBWN8evQUH1WHrnvFC35DxSbAU7NnWLIopHBnLF2u1HYmUTzkjMT1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111875; c=relaxed/simple;
	bh=NK7siyIJ/eEsJlUJu8OEqOJN6vumMIlBfcJjglJJkhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpXGXYAKisLAXEuluov9bLhZKcEI5E5AJIOBJBh4AyAfXXzzx0uHtnjC7WBA5t00kpDfpsEbtOj9QafKIz6tNt9G/43b4usWepH/Ey2MEQEK/bylWWvcSjcojWJ3ibmc4uc15Jk2dxW2XqvhUoPuJvhuWqjItzyAmkggA7nvKcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXmIDmr/; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986e0553bdso4972427b3.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 23:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775111873; cv=none;
        d=google.com; s=arc-20240605;
        b=TaQjAU2PbqNVHbFgndT3UzcqjYwiWW52HxSfS7wol/eWrdRG5U6Yg+9g4GcjzQ+5UZ
         fzs0RD2l07dcnG3hx/R77cCscwBEu4KZafbimBeSneB0EvOWlN/G2kJ43bcatVRcx0WR
         sl8DmlmuswloJZxv08xi0o5BnI63Z9Ktrq5rwPahnF25Tf+0/brVPXbNvKK7ccQi/tk9
         CTWJLLfZBtNtj93SOH/GLnxjpEXzCSqYX6mB7STP2tBnIdTkSwk57XPUHFgLbe9rMLi1
         +7OYJkWMwTepiTY2DttiMMZvRG592zW67yE6HdJJcisz/Cgej7yE3gos7OpGQ/AZS9mv
         UAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t+BrHQX+EQN9KTa01wtx2/XOg8PJ5fXoG4b7oExFqpc=;
        fh=Ojv7bICNgdC1BaAswyFDSJk3ZtGH7SOmRfAzeqpjpbc=;
        b=bMoc33XHjbYbO88nsSSijoaVyRauoOVymYiPuL59zfICmDEkSng3YEgpbkYhs6PkSB
         COcAf8ro4A13oiItsgUz/PfoFKYIJ9fUx9XaTYVsKWwqJQbKCIkzXjterUnZ498u0whU
         /RXwto/s1qZxaHJs8OTuNOqsgf1FpNsH1Y9TWY9NMKBvyUurC5jDlM5O/HMCe7JtSAwO
         QAzyfrKv8jHJPVOgblg13zgbGGxxLSfhf+O2CW/nVynVG3hIya3q6CMZ9AzJAI7Lp6cA
         Bw23QvCMUQF9oSaRQQghZeyK/86Hs9qoDE3D2KPoCcPsfC8UF7dylx/DF/5Qbgh1ySN9
         0mRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775111873; x=1775716673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+BrHQX+EQN9KTa01wtx2/XOg8PJ5fXoG4b7oExFqpc=;
        b=JXmIDmr/ELI/+iZecR5P2fGyW6zXm6pbMV2bFtt+59katsugdzNq7OANBRu7Whg/mr
         PMR3jwfPOFdlnCoLhSI8PtKfXFaOMgkCn9ca4PnLG0KDcMPqLjlJnUs4q2knUtEfL1OV
         TX92A5LlLpnjjl373IqR7lDaSg10A/sDI0dQ9/sO1kBFSQTlTRERK+Xk64OzC0uckHnq
         pTkl34ICmj2GF//WVKORnyUGi8i09apgATUQgjO09TQCmUSbeO5ospSBt00exd/NzhaP
         6q7AqYT6Mey8xzgO7hLDV6BifF6d5iFVxAZTVGHGbpVovRuYbCYwxktc7yv2zTCydupl
         17dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111873; x=1775716673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+BrHQX+EQN9KTa01wtx2/XOg8PJ5fXoG4b7oExFqpc=;
        b=p+JWyD71pLwgwlOMGmOBQn21KIckPTEONk5ZffybKLnfb0zmQOvH8XDfIQXspHW8Rp
         6KeBiTaiN/2wM65HNTOh/PmJSbjC8eUrpLrvWUJsVcXoxKXL+uA8jxLCu5bHXFQLrTcD
         6Kj1SFVartwnwNMtGW7HkNsVpSm+4oB4XAHgZMzJntucdCvyxj8EBKwsyFGX/lfAoWvE
         gCVsbmnGNv7Wkp0jsgWg521GaEfhZO0kX/72rU8u54MbOBRwmi0+qPH71CWMl9kBRC0E
         SHFFEOBgk7yfx6zmEYTfehsHiupvC+WjOEmu3FW9ee14+ZLz+jLGXN+MYxEMBhJcgTt6
         0UAg==
X-Forwarded-Encrypted: i=1; AJvYcCXZpTnnhuleGbbD/E6fIDe+p7ZfS4IE4e8UGYkJXbtGDDtJwLn68AWsJPWepIQfdvYhFs/YZ18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsL5m98cTdazuH8rB01PrSJDki+PtshQbn+nlxw2vjk/gQBnQ
	eehuI0KLiMratlk5IezeE6CRmbd2G86QA0rhR6plA+hoVtJdJOrjdzwCAJUv8NIzYoAyQoazity
	54eET+hyMzq+A3qIxYtvi3wytToqwX8o=
X-Gm-Gg: AeBDieuHYG7IofuT+lar1PoSTzLIHOL0PajsJDyJrbZwLjWixgC3rjo6l3Ee2LWZdv+
	aCgtqx8ifGj9jm3WuJLtnGvqCe2NPDa33LBmAt4SldWz+MMtCexHXZBxd9ZiXpVqvQrD8o69uZC
	wvsJXkVNLhBJZidMj/XmzAc+PbRbNtwUJdfa92rz31wLDQWhm8HjKnVTR/iKOsCKURqW/Rr8o4Q
	onKC7syvFOU7aICtbLQHoVtMs+dBGjpNDchs293exvj3vRs0hJvIBDnQyS7Q/aZh3t2ZKAGq0mc
	qNW0ap7G9wGVHsjOLcN1ur6BTa3Gqi6B6cpCiNDYlQUpEPB+XR7TaaRGEG2qH6+36S3yd597
X-Received: by 2002:a05:690c:e3e4:b0:79a:d393:f8c4 with SMTP id
 00721157ae682-7a21184ba85mr73520507b3.34.1775111873430; Wed, 01 Apr 2026
 23:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402050928.32946-1-kartikey406@gmail.com> <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
In-Reply-To: <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 2 Apr 2026 12:07:41 +0530
X-Gm-Features: AQROBzBOLHhkvCg28iOe4f7E1n0WRMLHW1eN8Xhts2J1WaN6Wst9NNUVwAWVyeU
Message-ID: <CADhLXY6-fto1jby-Hq4MgD5PkEQ7709V8+ivJ9oL=0iNZbmHmg@mail.gmail.com>
Subject: Re: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, ast@kernel.org, 
	cong.wang@bytedance.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274393-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,kernel.org,google.com,redhat.com,bytedance.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,431f9a9e3f5227fbb904];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B926384A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 11:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> Kuniyuki  is already working on this. Please see the
> existing discussion.
>
> https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/
>
>

I was not aware of it. Thanks for sharing.

Deepanshu

