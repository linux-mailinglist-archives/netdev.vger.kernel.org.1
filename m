Return-Path: <netdev+bounces-293385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j1QuIHEGHGpHIgkAu9opvQ
	(envelope-from <netdev+bounces-293385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 11:59:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76E6157ED
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 11:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44AEC30166EA
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F426738C;
	Sun, 31 May 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NDknGI1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DE156661
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780221550; cv=pass; b=Nuu3GcBasEIKYdm7WEecFVkeKvqI3s2wg96nh7F3EzhCB8VXnUPfMfMQ2Ym/zxI1qQUV1R5tz1n5XtWw2mTC+Gxmipzns7p2ERiXRViC6JjpkxgZ60SswWfovwLsksAqENn0N+OuhNf+7fk3RECmG46FiFNa244lFhoM+m5ylsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780221550; c=relaxed/simple;
	bh=7UH+KBnFuUqxZeQ65ccn77UK03Xi3cLc8YaYX5Bu/LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpmy6QmyVGHThcjLFYmDmrHqKwTgH1FKK4FU6df6KGFEoK+9WhDOyXJRZttdbqYSK1/0zmwYmAFHKmODLnVKwhc30YL8Mlhc+bhjz/UavkiZeD95rtqBYMPgS6x6vEiyZ2yrDsreDnl6k5u9k+VPfYs3ZpqYjBx9Nn6uWOZ0w0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NDknGI1K; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8584e80d59so415786a12.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 02:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780221548; cv=none;
        d=google.com; s=arc-20240605;
        b=SlNEjT1ox04Jd1z4Nw08md4iwBPAle+sv8VPK8quuItV1sYXnbA3VzL1b0zZygOT3b
         ZXJhzqY1/NN4DKfynfw69cs3ui11pJbe3gkjVn++6fLpmZZBuHw36mUsw1HY1b8qTkka
         yOJ1CZiQHKjkPZPcsbwW6F+lnbjHMrnE8xtFMyBWD2Q/7/yW1IoOTCdO3AIQFfUzzxkR
         trSbI4w3+QWani2xTKEdW5kQfcC17ATlptKklGoG1H3P0MsZURYELYqeqOPgQtr7KUd2
         t8RuIveMbA2cRVmGpeBaeHsBE0Zr5okPXe8Zh6l1aymDANl+FB/IqEC33JN34knKwJJx
         OqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QEzPzpPCqly3IhocPXOtN++L84baWX+2FzK/vbs1MtU=;
        fh=CZlqreM5+7+5mMHP6qPd1TfrehY9udzjmsxD3tzPdVA=;
        b=hKx4xT9pGnHHiicJOhejoTgIW0IMV1tK5suTJvSDX2fCAygvhjU8/rpj1/WU/RhLXZ
         0kOy1f7sx3I3ljo+Os34EyfF/SGnYSGrUZ5WJcNvqPi7YlnbtLMDpyb49zpG6mMQKeFQ
         2AEm1VLQie2VPoAuZ4BfHgIBE4wuPu2uFEa1Q/ZJWd42XqDLjEGcDrJlJK0Idb5WF73M
         QjGXxxpVECCzcl6+9cf/Gv2VVLBmxKheQfPJMJ5BDm+EekAmKqnCI0vF7XC7tCK2yuYj
         uizRAZbhiIithO9BEgy8pDtNPlRTpoJFyRkRk/Oyd/Pv1SH0SrAbtu+NKONigBzMxsf4
         0+Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780221548; x=1780826348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEzPzpPCqly3IhocPXOtN++L84baWX+2FzK/vbs1MtU=;
        b=NDknGI1K9M3sdKwENp32bIbrKEz2pTaNbxdMQfu+YwS8GMx5UYYb0Wgl+OJflVKWw2
         C9BjepdX9KjvPTFLN4xZ9h7QJgQMsBJFZ82Zqr5tQGktUcF9AnlqMVnRZg7+8JAmIIUf
         k8xbUW/ejEM9SfAY73R+n358tezGRX4DU7c5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780221548; x=1780826348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QEzPzpPCqly3IhocPXOtN++L84baWX+2FzK/vbs1MtU=;
        b=SyFCh0uifNAQQiqhUpZYZ2DuLdvo3J14eKNt9jrcNv/mhdNXx24zDnUs9L9USBEktN
         5MnnafTxKc3QYcjQt6obXwFpGrIbRpuOvaDh/jB40is0xQ16y6NtZ0yvP68bR/Zt0O4a
         jnl7O2Fd0+qtAV5Hti3wQMTEwrotsHg6aqsLYzR7HMS+vnkDej4ySz02YTCDiFX8psMc
         qgL2tnamODPseEh+/C9lE6bMobqt8QojpxbylhQQngSze3saP2wo4aZeBWnBF6T3gMZT
         PcaVxTCpWqJl8bOgwKWSsKOmYJFeq0uW8kMohsKUa+MBZA8h/15vPcs1BzbkENITS455
         wA9Q==
X-Gm-Message-State: AOJu0YwjvmGGv+emDa7R2X2KtxyDKARM0qwh9I45KFufvyQWIT/KxQHb
	8EHK/SxfP7VUOlY0oSIrYjVfURnIvd3Ro3dbcePB+k0WoA+y9lDK6J4z6EJnW7Pzn2vy1c36PwY
	FljPIKB1Te83uDswqJr87sRqT1FQTldLa4LhVnBzF
X-Gm-Gg: Acq92OGE4+ys2K5xcewVjwOsM+datVBx+9cgMsaV63W/P7X/kB4jFREYCElHRUocdQ+
	eY4iP4Pzxf7CVxiKUa+PZ76OwLjWUsDAlg2xVipXPdTOzV4Zw6x2st2PyWrNQRWJuXzUtozAyaV
	2q3IOapNBGDoZ4cQY3OxCQPsxzurDKr+55dUtmr9meArbbTTF/s2qsXZ3Goh4Gx/cOW0f6NppDw
	D6nYNwJxfBVLRcHJwYSvrgAKx4s3SMYBv098J4SPtq18z4WyQOgMTodrWTkoN7rmRIcQwQJxxKc
	nOtxmnRN4NRLf26ZnaVjDOeKg0cYBg==
X-Received: by 2002:a05:6a21:9f17:b0:399:12d:41f with SMTP id
 adf61e73a8af0-3b427be7b60mr7238209637.7.1780221548100; Sun, 31 May 2026
 02:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530080643.1345521-1-jhs@mojatatu.com> <87bjdx2ads.fsf@toke.dk>
 <CAM0EoMmAs6N3xemJEcsKpG8OJZcxyB=U3nRa3vGwo+kbk8azfQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmAs6N3xemJEcsKpG8OJZcxyB=U3nRa3vGwo+kbk8azfQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 31 May 2026 05:58:56 -0400
X-Gm-Features: AVHnY4KH0_gVbqsCWSOnPfdA1ol_eUc57krGpvm3ILPfTjHNKQywXg0oP3rw0BI
Message-ID: <CAM0EoMnJ7fjVKP+i8u9NpNZiPP8AQ-RdAbG14jUu8oMsBxhy_w@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, david.laight.linux@gmail.com, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293385-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8E76E6157ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"

On Sat, May 30, 2026 at 12:15=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Sat, May 30, 2026 at 11:19=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >
> > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >

[..]

> > Re-tested and LGTM. Let's hope this is the last one ;)
> >
>
> Fingers crossed ;-> Let's see what our new overlords say tomorrow morning=
.
>

Sigh. Now both sashikos are complaining about the min() macro.

Sashiko 1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D

 + if (write_offset < 0) {
 + if (skb_cow(skb, -write_offset))
 + goto bad;
 + if (write_offset + (int)sizeof(*ptr) > 0) {
 + if (skb_ensure_writable(skb,
 + min(skb->len,
 +     write_offset + (int)sizeof(*ptr))))

Could this min() macro trigger a build failure?
skb->len is an unsigned int, but write_offset + (int)sizeof(*ptr) evaluates
to a signed int.
The min() macro enforces strict type checking and usually triggers a static
assertion failure when mixing signed and unsigned variables.
--------

And Sashiko 2, on the same issue
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Will this build?  In the negative-offset arm the call is
min(skb->len, write_offset + (int)sizeof(*ptr))
skb->len is unsigned int and write_offset is a runtime int local, so
the two arguments differ in signedness.  The min() macro in
include/linux/minmax.h enforces signedness compatibility:
#define __careful_cmp(op, x, y) \
__cmp_once_check(op, x, y, ...)
with
BUILD_BUG_ON_MSG(!__types_ok(ux, uy), #op "(" #x ", " #y ") signedness erro=
r")
__is_nonneg() relies on __builtin_constant_p(), which returns 0 for a
runtime int such as write_offset, so the int side ends up signed-only
while skb->len is unsigned-only and __types_ok() is 0.
The matching positive-offset arm in the same hunk already uses
skb_ensure_writable(skb, min_t(int, skb->len, write_len))
and existing call sites such as those in net/core/skbuff.c and
net/ipv4/tcp_output.c likewise use min_t(int, skb->len, ...).  Should
the negative-offset arm use min_t(int, ...) for consistency and to
avoid the signedness BUILD_BUG_ON?
------------

So i looked at why this thing compiles despite the statements above...
I could be wrong but I think the compiler optimizes away with -O2
because under that if statement  "if (write_offset + (int)sizeof(*ptr)
> 0)" IOW, the compiler already knows this is a positive outcome.

David, this is what i had asked in the earlier discussion. It dos feel
like it is safe as is,  I suppose given the compiler I am using but is
it possible that older compilers may not do this optimization? It will
also very likely fail at lower optimizations..
Shall i restore to min_t()?

cheers,
jamal





David, I am going back to min_t.

