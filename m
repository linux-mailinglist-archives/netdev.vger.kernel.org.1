Return-Path: <netdev+bounces-265755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBZbNec2r2kPQQIAu9opvQ
	(envelope-from <netdev+bounces-265755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:08:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A97241605
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7558301778A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9F34D395;
	Mon,  9 Mar 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaszhAmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE642344DA0
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090446; cv=pass; b=sR7JWmdvnjjYNHt6jEbsJLhYOxP1szH1ht2f16PtHEuL/Eh73EN46ljJIZxOpl3BxZPvRBPu01j343AkVhXHQ2R78QknDGKhLE1d5YGIG/RCOlatHbF5FSDiNKz4rBhb+kUfUsSw8apIgKHJTqF0UFCnGBfsF6X9KGpTAp8QP9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090446; c=relaxed/simple;
	bh=li5zRm0PCIdD9+rnwJEWNTPoNBVilP716lWSslWOnLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdzKV1K6CPlEwsvv6AaCN/yywPisqRn1NEQwIC2cFonCryE1hCzBU8ZYVWd+ccJ3cLvsP9mMMH3Ow8j8R1binxRqexmq5XxyxpZZ8TdhtsOdeuKALAKD4/bfgmSqN/SmFIis3Yp3wGfuCziKvipoa9GnuWkhrBp7kHhTQwe7Bs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaszhAmx; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a321cc53so135148411cf.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 14:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773090444; cv=none;
        d=google.com; s=arc-20240605;
        b=Z3dHMpZuDV3cUI0vYFMT/X015yapfS7YTBVzLzVHIDKGmoo3b+yG6jwVTr+/44N2E5
         ylMzc0DPmk3NTmzsGbQ1ux8Nv9SM9kSs99elqtngco/ZD37gJfyvL9JozUyWcj4C5RKD
         VucjS9gQWXN2Hoj3v0bWqePUpGvFRblk0VqA+hEvX1RwRFUPefjtTIsJo9DpFMdcE6nO
         IcHPr4sB7kX7xGhS5+bGvKSnJyCGQJ7VrDlI9m7zD82Km+Yc0BGic0TPYntU12lpSKtJ
         wMdLHB27My8quNDoPziUEHkHZwoNMphdUnsvkctHoaRK0AIUX3ij3AGuAwOggt8spuuO
         Donw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsTvWw67aOb0oOmOhkeZzyjLA633HBf89IElKjS1YC8=;
        fh=mK+DTs/Bg0SotNI/0fsRvMkpcQXcDi1pSGR6iiIQVVI=;
        b=BPWV+gzKWU688S01lgMOx9dGYn3M4K6eUrCAVXeTanImbgIXDI5aH7lxun3tBv79Zy
         /okY1RKLBEUhkVtQkGJADF4qj4GDm6bCN3CAPcBxv7oda0iNjmYfY+fPLSJUPh0TlHWM
         lsPkyCKzrAV1IoQ21vYPeluUJoW/abzJ6Fwk9H9E5x1TpSIlcdccxH9CV3k/D5z3Kddd
         vyvsg5oOeQCawIGqfIL+F1GeefkEKWHC5dpTsfzQK003cdfQAALirtmu3tf3iYHmUoBk
         gR69ct39sn38uCqOOa8zKmEyXoVbsY4eS3ElbPouKUxK8MYf1nImTULVy1b2u9wWJnws
         QTbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773090444; x=1773695244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsTvWw67aOb0oOmOhkeZzyjLA633HBf89IElKjS1YC8=;
        b=xaszhAmx9Ku1YaQ5/tSGcVJn7tJpjcmgSHf1aKcDTrWG1pNn9aCsN4QgQDoPDYjhKf
         3WX6Zv52WADxz+vjCKZai0n+nJkBgiRS2QUF/E4S5foeXTgL23fLjFAPGtwcMbWziLBf
         juMtBHB3owF38zyLWXb0JOCnlV1V8/ju9whbb0srT3+3LoLxrTsbvSgQfFeuV1tg8CkS
         wGy35/2N6eCnJFqmKnNEc11fjnxT0UI+8h8T6wmRq9EhmgV8/qpzd4nZx0SloPj1lOV0
         y7Nt/CetKYb5r3dyPxj9I0/PGYK6CYH/amsVgZpl5AgiZ0GoETH8ZMopAqlum8KwUbHx
         fS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773090444; x=1773695244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsTvWw67aOb0oOmOhkeZzyjLA633HBf89IElKjS1YC8=;
        b=fSyUloOeHbU5iu29Twv6ohkaduw0cjsFiH4bh+k9lZMmRER2BCktcIBgpEVti5K4oQ
         EPsJHqGwY728UyQ8u64EDVC9ZJYVY7fmqqH52oNcQDjSXrZ3a3uQJ7ty0dTHBenibvSa
         BDa6TZyoAHFNWhi1IZUFcBOUR6bKFWt/O9nLwyYy7jDhE/TKcJNgujWONupj/ePXePL9
         rjv9KzqUlFJ2r4w/evW/PbqGEXsk+PpQ4uDuVfibjgVuqMRYteVjMQvGeV+4+8tVSQO+
         0rj/Qvi4F9FM/aE+RDLIXqWQjCdGZVEqE8nxqLF2wbAnc3+1eQmhuEhFlSfbgLSz+WD7
         2Syg==
X-Gm-Message-State: AOJu0YyVv8EYTWno1g6CxhwKixQMMlyRq7plQxpjodQ5vhPalHEyfw26
	zmV6qH0tDQMN6BzGvnfUogqCpho4CRwy/FDaKE9F4rhVh1Mak8H06g7rCYV83vFbUIck+7CuCk2
	cNnjew/3Wtn7kkaftj6F3jiFdFfaJ5/xWHUIRE68Q
X-Gm-Gg: ATEYQzxlJiqwV712nJV6rMj/gz1N9xBtTyWmZ77tVmIqKwuoBuAjn3DQw+Dcmju891B
	nIQN5dcGbVBEOYfY8BlzKr/gKN7ga5et8OX150CcD5rgEPF86W0zQ/k3rfh03dz/jhJGehIb92e
	rr6tPZpc3/AREbzjxJ/LJiM+Uz+yI845+crR0+8Al89l5gFAm9TKY7zqIo54cHV5DJYtDEJYh2y
	s+bWBIOkGl3CwcoUiDUSougXT1cU1jg6/QFXJbFv4RpmSVifNlpctBYdEeiwQwKDtCfzMjEXltV
	V1w6y0lr
X-Received: by 2002:a05:622a:58e:b0:4ff:c0da:5a06 with SMTP id
 d75a77b69052e-508f46fa9famr156377851cf.20.1773090443382; Mon, 09 Mar 2026
 14:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
 <a4686348-ad60-481b-8898-9c68e9c27a50@cybernetics.com>
In-Reply-To: <a4686348-ad60-481b-8898-9c68e9c27a50@cybernetics.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 22:07:12 +0100
X-Gm-Features: AaiRm522fbFDh3HXv_2VmST3M28bKNoQ-2QhB6oqWRGhzDGsAr4W1LWp1rHyU2k
Message-ID: <CANn89iJziPq9Au9A8DK8Um6Nn2F-xTcG3+r5x0tVMf+7TUJEMg@mail.gmail.com>
Subject: Re: Long delay in freeing skbs
To: Tony Battersby <tonyb@cybernetics.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 27A97241605
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,gmail.com,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-265755-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cybernetics.com:email,msgid.link:url]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 10:00=E2=80=AFPM Tony Battersby <tonyb@cybernetics.c=
om> wrote:
>
> I have some out-of-tree code that was broken by commit e20dfbad8aab
> ("net: fix napi_consume_skb() with alien skbs") in kernel 6.19.  I
> retested with 7.0-rc3 with the same results.  I'm not sure if the change
> in behavior that I am seeing is expected or if it is a bug, so I thought
> I would ask.  Omitting irrelevant details, my kernel code does the
> following:
>
> 1) allocate a buffer
> 2) perform some network I/O using the buffer (cmd over iscsi_tcp)
> 3) wait for the I/O to complete
> 4) wait for the buffer page refcounts to drop back to their values for
> idle I/O
> 5) reuse the buffer for more I/O
>
> Step 4 is necessary in this case due to some of those irrelevant details
> that I omitted, and that is where it trips up.  Commit e20dfbad8aab
> seems to keep the page refcounts elevated long after the I/O has
> completed (hours or longer), presumably because the deferred skb free
> isn't happening for a long time.  So:
>
> 1) Is this long delay expected, or is this a bug?
>
> 2) If the delay is expected, is there a way for me to force the network
> system to process the deferred skb frees on request?  e.g. write to a
> file in /sys, or call a kernel function to flush the deferred frees?
>
> Worst case is that I can redesign my code to kfree() the buffer if it is
> busy and allocate a new one, and let the old buffer be freed
> asynchronously when the skb is freed at some indeterminate time in the
> future.
>
> Thanks,
> Tony Battersby


If you are using zero copy, please look at:

Maybe you should make sure your code is compatible with it.

commit 0943404b1f3b178e1e54386dadcbf4f2729c7762
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Feb 16 19:36:53 2026 +0000

    net: do not delay zero-copy skbs in skb_attempt_defer_free()

    After the blamed commit, TCP tx zero copy notifications could be
    arbitrarily delayed and cause regressions in applications waiting
    for them.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
    Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
    Reviewed-by: Willem de Bruijn <willemb@google.com>
    Link: https://patch.msgid.link/20260216193653.627617-1-edumazet@google.=
com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 699c401a5eae9c497a42b6bdd8593af7890529f4..dc47d3efc72ed86dce5e382d505=
eda7bc863669a
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7266,10 +7266,15 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 {
        struct skb_defer_node *sdn;
        unsigned long defer_count;
-       int cpu =3D skb->alloc_cpu;
        unsigned int defer_max;
        bool kick;
+       int cpu;

+       /* zero copy notifications should not be delayed. */
+       if (skb_zcopy(skb))
+               goto nodefer;
+
+       cpu =3D skb->alloc_cpu;
        if (cpu =3D=3D raw_smp_processor_id() ||
            WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
            !cpu_online(cpu)) {

