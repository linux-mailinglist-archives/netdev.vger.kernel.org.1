Return-Path: <netdev+bounces-265775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKtFBTk8r2mDSgIAu9opvQ
	(envelope-from <netdev+bounces-265775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:31:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8E241B7C
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E663C3039333
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681336C588;
	Mon,  9 Mar 2026 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+Yw+vFS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71036894A
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091878; cv=pass; b=gTdSVkXAdGlKiin/y6qD4UGu7Cm+HYaPBif13fClweG+JVn9+gbPIZRqo0jpVYMaxhpmEPyPIFqD/zGiu2WoGo9QZQHmtVw6ckjtTol4O7JwGhOnKzYJH8DFNqqAe67Evf2NonXBAswBsvjtuHv7fChP5M+0tZWNB2h2EGX+6+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091878; c=relaxed/simple;
	bh=Yjk1Su9f7wkHPA1x3k3+sZsOQ7QNNL3djAaVaukh/8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmXE0zGUrJladMx6/Ew3+J2w5YMkaB506fj2hbytAiN9c2ISMS4wNt3XkBzuqcxLBOGfKydFmOnYGMcvRb2EHeEHarkSY2ObKzSL8UGyAiIIFEBKGXHrvq3v67sJe80wyeKBrWDPryfmGW/lP6Ekw5f4hqzvj8erPDWRezA2aJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+Yw+vFS; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so5628774a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 14:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773091877; cv=none;
        d=google.com; s=arc-20240605;
        b=TFA4YR4LqjnFHbzmIn4JkTB9u62sLLFr9kqPkLN5xlXklH7/MoSXzLZhYF9vYk6Ltk
         nuc3kDlY5K8K3rWZ+k4N5wcTzHYZpWyy5hx4rKna2WC5WsNhUOqMtsmaFj7x5nQ8p9k5
         aO/z7t1SYHH57gvjEX8DRmZVux26jaDCPa1q7PvMnAA/h+xdHBlUYq3EA4D7ACTcsVmr
         QpHfCskIGlVac+0+A9Q0TVkdXy2/4A2WzwpHJfXixSglaoxlONEJZEmhicCk6HgserW/
         Zj5jV/08Qm13Ll6d+OyMgGCXtxJRQLH68tNjIkKgV0ka/a448akQxZEyTbMPFB2EJ5wr
         p63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H3TheL4W1iw0p8kyPxb2cds2DNsPVWaMZ6dSVOyXqlg=;
        fh=mK+DTs/Bg0SotNI/0fsRvMkpcQXcDi1pSGR6iiIQVVI=;
        b=QdfE3yh7FOhgz9E8/Lf0zjIpa+bmMT4JZgJlF3PFb95G2XHOUBPla5t4HzhAi+y3zy
         /g+e06G+cAHXjtm5Iog+7fGNMKRIAPsd/a5bXpoYombpKkT5QojUc+A7UwnwnQu955F8
         XYFmjYJga93wKGTGuoshkTNuOTnTSyfZzZuUMNh9OuJovRs6k/Mnz6adDRCsESlawAWp
         DMnAACsOoDhANveiqS40sWke2PFVV4MVCeN7d4GFuyx7Ez6L8P0FIcH3xjMjCUWz+0gb
         bMsfuTVhxqQQMkS7Nt64FFJlBPd76cSqB1AdoOVT5tIUd7l5IrpvGDBTUQFavHtBC84V
         8WVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773091877; x=1773696677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3TheL4W1iw0p8kyPxb2cds2DNsPVWaMZ6dSVOyXqlg=;
        b=1+Yw+vFSXkh+IFe0Jfft1MggsEdKW7T8+vNZFK+znpbrzqfdYy1UD3Bd/ylFmDR9cK
         w/NiGqCFEDKdqah2e2YdbUEHl+xjEs/x/a4w4fJtagnyNFrcW5ylPvX8i8YvFf3dEH0b
         zUnPeCAOG2EW6jlS+PbOP9CtOIyxU1pP9dT8++HnOlDeo4JE8IOmitW9IaDsbFacqO6O
         KmxkwmNlbmte6xZCML4y87OlBXo9izBGbqLtdkLQIhMf4EjJn7BOCHQQoQOZUQguuv7+
         DL470f8zSvH1M07kBQBytvbtFkXNWjyVW9CiVFgQiLj+PrngF4vXicGRK75ZE60m6zRH
         RT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091877; x=1773696677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H3TheL4W1iw0p8kyPxb2cds2DNsPVWaMZ6dSVOyXqlg=;
        b=XNRVeWXGaE2Eo4RAQgrceBgI3ZzqZCX/R9j/Vjhaptdbw5uwqDSM1Jv88XiU/2cYmC
         ApXLdkM5JbicgK+uv7HWQuQGhMYumLc8QcL6WSti+CV85VV7dgTnRIv9kyqXojYqPxnH
         O0ApsZ6CMbFt1pfNooV97WZ55+Nm0eXAjUhpnf8iB+OgLqiuN2gz1qQJZhcDhv9A/VVY
         8RgenLClDkeVuPCgulKQhcwQB/ng4mmtjnD6hMdthykFpPES04cIxUst7ZPZlcu90fxr
         xWBex+bQE5BS3G4WxQ7x6fL8PWHMjXFpqBv5hyI2ak+J+fxADR16BeHKL8eu2V3IsOol
         ofWw==
X-Gm-Message-State: AOJu0YyEMQ132ANQAdIb00ZeScc6zilQwujFLOFh9fZk3f8a2IxgwixL
	wQsBVuf9Y/yAriSMAXuROHgqHaDoZ74Bp3RKhQrDrVoCJ/nWcUQmpggqF5/8Lmkuvc9j1k9jxcx
	Uin7+nTrWlCTa/alRkQ10SVIkxETDnLHeQOvKkSxGicbKBvPXwcZMZ3COu+w=
X-Gm-Gg: ATEYQzwLJbiZ500AsSrxUBYoVLi8rv4JkWDFA6zt7XpOO1CPg8tb0Ji9x9KBAzpAwsh
	7FuQP8XPH66oCSUQqJ1gkgNf73gn3xxaEv2wW08AibjrewPbrFgNEhI6td/GfcMYa5ugvgdWt3Y
	tAonj9WCFnZ6csdtoZW5BRtXXt8IfE3LUBh+rzft4qxxIGN1l2/Zcuv+gy1k94Zjg6mJSIMioIA
	0TUr6tn5grovAS8I3+KcL6dtb5bxpDqQkBzHqqXiJtNflFoUyRWpJQRofzkmOl130hYojTHjIPX
	a+mxyr7PHUp1DAT2zmA=
X-Received: by 2002:ac8:5d48:0:b0:506:a624:1939 with SMTP id
 d75a77b69052e-508f4969e31mr154104911cf.51.1773091509650; Mon, 09 Mar 2026
 14:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
 <a4686348-ad60-481b-8898-9c68e9c27a50@cybernetics.com> <CANn89iJziPq9Au9A8DK8Um6Nn2F-xTcG3+r5x0tVMf+7TUJEMg@mail.gmail.com>
 <cb925a24-c4a2-46cd-98e8-2be5e2aa2152@cybernetics.com>
In-Reply-To: <cb925a24-c4a2-46cd-98e8-2be5e2aa2152@cybernetics.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 22:24:58 +0100
X-Gm-Features: AaiRm517z663BEYAtI0W3SeK_AGGIyIAOg7mLtVOnsKuoRRxiNvGwgQVi7C93KM
Message-ID: <CANn89iKVarorgFqxpCp9C5r1_ntRDcz7Xn-kXxpfwWLQkN++BQ@mail.gmail.com>
Subject: Re: Long delay in freeing skbs
To: Tony Battersby <tonyb@cybernetics.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 82B8E241B7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,gmail.com,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-265775-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,cybernetics.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 10:18=E2=80=AFPM Tony Battersby <tonyb@cybernetics.c=
om> wrote:
>
> On 3/9/26 17:07, Eric Dumazet wrote:
> > On Mon, Mar 9, 2026 at 10:00=E2=80=AFPM Tony Battersby <tonyb@cyberneti=
cs.com> wrote:
> >> I have some out-of-tree code that was broken by commit e20dfbad8aab
> >> ("net: fix napi_consume_skb() with alien skbs") in kernel 6.19.  I
> >> retested with 7.0-rc3 with the same results.  I'm not sure if the chan=
ge
> >> in behavior that I am seeing is expected or if it is a bug, so I thoug=
ht
> >> I would ask.  Omitting irrelevant details, my kernel code does the
> >> following:
> >>
> >> 1) allocate a buffer
> >> 2) perform some network I/O using the buffer (cmd over iscsi_tcp)
> >> 3) wait for the I/O to complete
> >> 4) wait for the buffer page refcounts to drop back to their values for
> >> idle I/O
> >> 5) reuse the buffer for more I/O
> >>
> >> Step 4 is necessary in this case due to some of those irrelevant detai=
ls
> >> that I omitted, and that is where it trips up.  Commit e20dfbad8aab
> >> seems to keep the page refcounts elevated long after the I/O has
> >> completed (hours or longer), presumably because the deferred skb free
> >> isn't happening for a long time.  So:
> >>
> >> 1) Is this long delay expected, or is this a bug?
> >>
> >> 2) If the delay is expected, is there a way for me to force the networ=
k
> >> system to process the deferred skb frees on request?  e.g. write to a
> >> file in /sys, or call a kernel function to flush the deferred frees?
> >>
> >> Worst case is that I can redesign my code to kfree() the buffer if it =
is
> >> busy and allocate a new one, and let the old buffer be freed
> >> asynchronously when the skb is freed at some indeterminate time in the
> >> future.
> >>
> >> Thanks,
> >> Tony Battersby
> >
> > If you are using zero copy, please look at:
> >
> > Maybe you should make sure your code is compatible with it.
> >
> > commit 0943404b1f3b178e1e54386dadcbf4f2729c7762
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Mon Feb 16 19:36:53 2026 +0000
> >
> >     net: do not delay zero-copy skbs in skb_attempt_defer_free()
> >
> >     After the blamed commit, TCP tx zero copy notifications could be
> >     arbitrarily delayed and cause regressions in applications waiting
> >     for them.
> >
> The I/O is being sent by a userspace program via the SCSI generic driver
> (drivers/scsi/sg.c) over iSCSI (drivers/scsi/iscsi_tcp.c).  I don't see
> any mention of zero copy in iscsi_tcp.c.

Set /proc/sys/net/core/skb_defer_max to 0 ?

