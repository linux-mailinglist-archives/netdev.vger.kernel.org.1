Return-Path: <netdev+bounces-253430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBQaBD1Pd2n0dwEAu9opvQ
	(envelope-from <netdev+bounces-253430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:25:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E106879E8
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 336CB306B0A9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C433291C;
	Mon, 26 Jan 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6rga3it"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B93314CB
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426577; cv=pass; b=fc22E8AH4+lqYQEBe/Hxx+9y4zYNJoAvTLXnGxNwSrTlj+4C+6syzr9yAMm18gyd8Y+S1C1YYEP8KrLLJQum6e+nhNbRKGC7dEq3kf5F7ByFU6Pf3HRwARgjNoSpxA8Gz0hOpJ62WjdzlL/xr16LMfc0av3FmnDbSVCrZ2G/i7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426577; c=relaxed/simple;
	bh=H08K/Q4mLGJFDb0dLvVH0RYvoZFNzQJ0kikRAyeFFBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JloZOZEI1Ele+r8Vh6eqA5CcnglG0DNIe0FxMyH5+nRHhp3eAe4yjWNTCMrR3tuF6YTCK7S7zErxj4wOkxlRLDvj2SjMwdg4V7xfZSFvEDW+SmxalM6gJD+WOJDi5j2tAqrU4meJ/GfRRQSMXD+y0Npsk6nicMC86XbxaSS1gvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6rga3it; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88fca7bce90so72767656d6.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 03:22:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769426575; cv=none;
        d=google.com; s=arc-20240605;
        b=kL1fD/jq5XvfnPbUL1/xBV1hRxLzYJTx2s6VNcos74fSHW7TjfmGB6URZ8BeBd5k4N
         FoxyAWrx8CVq5scvjSPpPOHAgB+3ayLsrHqAjS5/bBz0qcWzSEsveUyuH/u+Uwo1zi+5
         F/uVgO0ppdp/LK1F6CdZxsTs4ZyTZo0oFQm/dZtFX99yI4ROG6qYY/BYedkZmjIaYNbn
         Z3KfPFiUdUXU183lcy2U92IIi35Nx465EsYsIHl4V5sWAqdLTqfDc4wj0SJtSj0VkCye
         zo8fi60NF9A6VgR043j+TU/+31Cr+UYWA1mtJC08fEW+LcISNV/tMSOpMbL4TlH2c3hm
         wRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5mrgXSG7Cpi2kaE+WTLz6q4c7vQN+hSQgdmVwIZ5IA=;
        fh=AU4KIO+qxw+mS+hhYQqjG6S4ievnGSCmct5AXmOOb8A=;
        b=aC0wupPjMx5XBrdyrm7ZUf+VRXpfuRRS/qgKfzqL67PIbOAEP1cCa6rzM2s6m1DQGH
         xe4twaKBXOOidifo5a8QUiPry9gqdJx3kpdtqSWsGaswLgqxrOd5OggQfA6ygMKthqU9
         bvsMr4/ONDIhmScxP+K+7hBsK08qbhfgjDOT8Igf8zte4/9r65osRjGSOoaJM4U/vj/9
         B6VReieP2FPZIHx7vLtzPkFNV9KHvzIH4GgdD8XwnWKhHbwxqHpj5mxVpg4EdFqynxLF
         6dVdQ7BF6yrWYSCs1jijOWu3picYS9p66rTnCjW5yhqEWcNawZE5HTzLnYnWsp3uM7ck
         8enw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769426575; x=1770031375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5mrgXSG7Cpi2kaE+WTLz6q4c7vQN+hSQgdmVwIZ5IA=;
        b=R6rga3it2C61GQlF42Cdg3iEd5fOxXL2YuEKjHnrchGouiVpAU+eWUu+9ihUx9b/Tw
         WGUgvgcCWYGWlRHnyA7g3OUtbZdZ+GXMMugpExtwmXJ5KgbeC0qB2+kjT+ayS/9vALh5
         n/xf4+gqXymh1qZt6PL4+ZGjAWsYpdHVHLKY/FybnnmnITB0hFpzgYZPwGqe21hBc20W
         RSjWwUgAyYozSSxMKgHilKqHSXHluX+8pjjizJ/aoI8kXKWQTKR6tCEc1aJLMitIgUWo
         UrELAZHWhk5VtCKjAQeTvNw8YVN3miLvfLAcs8eWGPv49/IoAz1Eq7agwMgqcj2JHxhS
         6fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426575; x=1770031375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5mrgXSG7Cpi2kaE+WTLz6q4c7vQN+hSQgdmVwIZ5IA=;
        b=MKU3awMaxwGir0zCMb3zdgICxwG1rytDQm0iQ2sc4U/eG36qaUT5xePt2PzuVZnE4b
         z0PGWXZg2aHfoiXuGpAiXoibOTJM94qh/LROwoTjD/2NQemA27i1YKoBChWSjPq80Rru
         oiaw5610Myd10pAKU8Bs8tIXy6TmekV1fQpjYgbPul9WiDKtYJcm1yYTtcPPPRnKWl/H
         vb3+UkTaOimc1DueFiCCmos7JuJhPj5hG65wjTJrhDrnseIm1jGO9Fbi2ZsMyTO2CwMx
         Hj2/DVTp7mMCJvEhW58y3wVHKfwD/TgYHaTAidgMICNwEgi9nQBnh/kqspq2NymJ5atH
         C36Q==
X-Forwarded-Encrypted: i=1; AJvYcCWh0fGPA02uMx45giRf6RI1g5sq9IylgZCvgjlCSRMPGTDhGUj9qjsyAMJwzGY68WAU6ZaO8K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLouQqhW8pJM2PBVCI8MyVRyLQGUDZdJGLl0o5fTSuQth9KZyD
	dXwnMz6hJhYGC8RZGnYvroxQqg6WvXS/opgOVmEoKvDJXfaNSq5df3mpyPVIoyO8JflP7odQSho
	/PXiRlecWmt1KPP+6rzil2zAEgNaf/OrKLqW9KaBp
X-Gm-Gg: AZuq6aJyIqJ/bilzEMzOBlWHObIhPwrgqcfOxI06SNktkNqCCx0Zu6lLR/4XuxTTsSk
	iUORrfXjkS4EUAdRR9P1V3xSUbPC9MDKwex/QErqtxSxDLwmelj/Nt2Zt7L7ZKaHpKNfA4yEXwc
	RzjG9gi5QiqdaDGlQZKdpPQg6pDDHMUAJK5SKUfyXn7YX0SXHh2zhHMuz0VKE7mJVgvRhUMIFuy
	URRJ69dnLEATcY7pqXWCJsNhAH1U/vMn0TjiZvKQK2JePtX1/PLhJRXj35tOUppd8OoUgiCHMiu
	T5PwK1Q=
X-Received: by 2002:a05:6214:491:b0:894:64c6:b5f6 with SMTP id
 6a1803df08f44-894b06b5da3mr51128786d6.4.1769426570388; Mon, 26 Jan 2026
 03:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
 <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com> <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com>
In-Reply-To: <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 12:22:39 +0100
X-Gm-Features: AZwV_QjTOyMbUQTjtB80TT8rUbxVKo79-AoKGsZcXaKwD62vPbAkjdp-rBlSZZk
Message-ID: <CANn89iJvj8YXtuMNTh1cQOjVctBsMs88FHx-xLn+rCzyBGn-og@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Cc: davem@davemloft.net, Jamal Hadi Salim <jhs@mojatatu.com>, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, horms@kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253430-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,mojatatu.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,gmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6E106879E8
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:51=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Jan 26, 2026 at 5:30=E2=80=AFAM =EA=B9=80=EA=B0=95=EB=AF=BC <km.k=
im1503@gmail.com> wrote:
> >
> > Apologies, I set the wrong title and KASAN report. The root cause is
> > out-of-bounds, not use-after-free. Please find the correct KASAN
> > report below.
>
> This is great, do you have a patch to fix the issue and get full
> credit on the resolution ?
>
> Thank you

Brute force patch is a bit expensive.

 I think we should instead add new helpers when the offset can be user
controlled.

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d4a8452e90fe78adcdcfdefb79169..1ad8a3e17b995f5b934dfa21448=
580de4f201acd
100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4285,8 +4285,13 @@ static inline void * __must_check
 __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
                     const void *data, int hlen, void *buffer)
 {
-       if (likely(hlen - offset >=3D len))
-               return (void *)data + offset;
+       if (likely(hlen - offset >=3D len)) {
+               unsigned char *ptr =3D (unsigned char *)data + offset;
+
+               if (skb && unlikely(ptr < skb->head))
+                       return NULL;
+               return ptr;
+       }


scripts/bloat-o-meter -t vmlinux.old vmlinux
add/remove: 2/0 grow/shrink: 56/1 up/down: 2539/-6 (2533)
Function                                     old     new   delta
__skb_flow_dissect                          7661    8315    +654
ipv6_find_hdr                               1005    1127    +122
br_multicast_rcv                            7973    8077    +104
ip_tunnel_xmit                              2635    2719     +84
__skb_header_pointer                           -      82     +82
ipv6_skip_exthdr                             428     505     +77


        if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
                return NULL;

