Return-Path: <netdev+bounces-266218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCmgKNw/sGkehgIAu9opvQ
	(envelope-from <netdev+bounces-266218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:59:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0182542B8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C1B31ED229
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4331AAB8;
	Tue, 10 Mar 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQHs/yr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0D30AD05
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156343; cv=pass; b=FOoHQsfHWsZjg4wqwzIE7G/IDnK9XA/4RoSi3A0gLEUQUVg+8RGA3pOmxZw8R0lacJf4spWbd09ZX+6zClCmMYqgNYZsRBXfHyG8EwVpBPTporNhZv4mRwgjLiETwGGNbMUKBc0ujk8DiYL/YyfLn/QDd0btEJFs3s7HuU7m28g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156343; c=relaxed/simple;
	bh=GFx5yp5C5pnYLv7xRJ3Ffwa6mKYbZQnZ2HP/JE3CkCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvnHALXaDouDqr9W3ToXByAia9Mz2msknNVT9Pg3S2kmIPVK9rTSryhrF6LVexK2D6ff8t/XXteBk2y0E4WImEla1iTINBVXsgCh8QJskYHn80ThAb+mxzFUUhRerXS6mhP4Ofz3Bna0ukEhqSIrGIJaBS2o9wx3rtYPbgwYyjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQHs/yr7; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509064418a8so37668521cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773156342; cv=none;
        d=google.com; s=arc-20240605;
        b=DISJKkuYCxQ1A/h8eFQzQJ5O//M1EFL+pgvrqxFHGJlTQZwWKzifuEhiOSmDfBiaji
         9QCNPF6UBpTPVpgxAHgHdVHgY2L8W9WYHHC3BVKwwcuhv3DBMgErR4DAPf4BNPbu1PfW
         5RB01WPmqK0QwhsVxJsDXHBjJ1b62SnBThR0EdbUMDcv67eIjjm56yV6L4zISwPfYxPP
         t3AJK+751wkBwZh0jKwyT0r5FnT8cIvxjaO6C9zW3ghD1SK4RoW9X9CjwLMQaGZgHT+6
         1K6oJknu2hHAdNNALWXq42Nbs3bX1Iv1C4+7TfqPCpiftd8HNHhZ78p0M6KQ5HMAUzHK
         PUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qdCpZGVa/V+5p0O179Xw74ZYNlsySsblEen64ng3edI=;
        fh=mK+DTs/Bg0SotNI/0fsRvMkpcQXcDi1pSGR6iiIQVVI=;
        b=hE1lQi4+vwyG30alcTDLr4PPQRK+Ex8NLtHE5lbCgT7QstcwnSqqCxKin4bngkl1pR
         E5RQ5RH3VSWAea75U5m4YGK/NvltHVWsjhOxuAVTxLlo9u8HcAADAgUeWkuE5YyM7hEo
         Fb5CBxizSJm0m7LT1zPEVHQW6xMrfImc/0GamsYr8e/gCQxQmQJa+65CZ4TCGdgE7R+B
         K9HEpNZmdxtFDWoIYouYmbpt/xoIoxv31iSUwAFS2InePoUcnjxwg+Qgw/gF4BgAwkKF
         HpX+3EPJP/fOlxfTup2GB36jq/7lJLwkc/G/PRtcMQDAru6vmcMf3FoPl7sZJ18sEP2q
         lQtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773156342; x=1773761142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdCpZGVa/V+5p0O179Xw74ZYNlsySsblEen64ng3edI=;
        b=AQHs/yr7Gvha4WeeSLnWSMlooVzJGo6GAU7UhekNH07V+/520QYqL1byWRSaDp51B/
         d9hHwCr4bDru0nUCVMsIPmp56fW/n5xj3Y99eHbj2NKzOCdaPCLJ47VfwHGYiLAfNwwa
         oPuz1da3kALubqjorkJ7JO56SjNRqB0aU+uqOdcQhvgN33lIHQiAQpO4+PPwkz6xanug
         aIn5YLCE7qlo27kUYVLjV8Sc6FTYhDGS91XswwN5t2U7P4ekvOuXVmLHcqt6LSLI/g9X
         Iesn/8K6G8pek2dqIO7BLC+r7/1VlYfpgMbhtNJS6lg5aNRUlznPsFDSRpTAiDb9mGfI
         eFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773156342; x=1773761142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdCpZGVa/V+5p0O179Xw74ZYNlsySsblEen64ng3edI=;
        b=aD9wbmF68FF/xy3+xBfB/cTP5hkhGKTQGxY42A7OtEFxDuMs5Hn2k4rd/1oOA044cw
         dgN3aB4AHTHV27zB7LvUUf3pjtlybLmkyvJe+qPVw2OfTEa68o32ypBcM36vKc8p2O3A
         vrSOOG3CYajahLeyJ3UywyZBmI08KwKgHehyrFOkL9kRM5NNqMEDDBKfguOzhJEDG6R9
         8Yr6PskZ29eI0FFIeZy5bJRv5PYVv3+hy9hjktdNGI3dQSVyGbL585dT2t3CjgNJSjQ3
         qdr7FxBPv8Cy08xOthnEx/L1E7pS70CiggMkbZ4LRoipis+NVYLeIU+hSXXIFcXFwxI7
         S6Xg==
X-Gm-Message-State: AOJu0YyQ+rMDz9fpiw8ilgogxTHxrEfu85BrRwwMy9EcB5NOExN+UjWv
	FyhsbCboTLhnk64kZy6A29NgdbxP+/VG9i+fKXwjw0k/bFsHZs17bbTp29KSu0iJvpO3UNyytH3
	yNtdGPEaB5ES2McyRW1kDZV2Amf/+wAiYrQWGgnla
X-Gm-Gg: ATEYQzxUDhxH25N7MY6XiTaRIRhvCc02Hh5bA8gtFDKHNY9j7N4sFaL4aiLLlWL3sla
	Nx9MeoHALM7cTPyimFaHLZykFYAHOezgjUZNWNTpKdsJaP44PF2FcJNRHxJg3DnYlOE06hngMak
	qieGW51t425kfZDETjIqRodCDpPlkGBLXCYovMyS98e0MMhVv/fzYmj9Hyk+GRESivCXiSS2M16
	o6LdnDWKCk7mnXtTV48P6wN3pbSplvi8oVKW30KZo/iPFSWXmlxYABgxRFMHr+OqOhxg9Jtf7iI
	Rr2p0ds=
X-Received: by 2002:a05:622a:4d2:b0:509:1ffc:c538 with SMTP id
 d75a77b69052e-5091ffcc7demr69849831cf.19.1773156341020; Tue, 10 Mar 2026
 08:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
 <a4686348-ad60-481b-8898-9c68e9c27a50@cybernetics.com> <CANn89iJziPq9Au9A8DK8Um6Nn2F-xTcG3+r5x0tVMf+7TUJEMg@mail.gmail.com>
 <cb925a24-c4a2-46cd-98e8-2be5e2aa2152@cybernetics.com> <CANn89iKVarorgFqxpCp9C5r1_ntRDcz7Xn-kXxpfwWLQkN++BQ@mail.gmail.com>
 <146f94cd-e8c1-423c-8ca7-1f849b684785@cybernetics.com> <62aa08ff-16a0-4672-8e70-00b9081369df@cybernetics.com>
In-Reply-To: <62aa08ff-16a0-4672-8e70-00b9081369df@cybernetics.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 16:25:29 +0100
X-Gm-Features: AaiRm50HG9WJWpUEPI5YYSq3IEMZ8J-QW64Yg0VXFJtbTjYG3Ikh2rEvM9WKrVY
Message-ID: <CANn89iJpgABfLzXOFVzh0rjnZUvHhyqYuNTvP6_EegHgcjuY1w@mail.gmail.com>
Subject: Re: Long delay in freeing skbs
To: Tony Battersby <tonyb@cybernetics.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4A0182542B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,gmail.com,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-266218-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cybernetics.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 3:49=E2=80=AFPM Tony Battersby <tonyb@cybernetics.c=
om> wrote:
>
> On 3/9/26 17:47, Tony Battersby wrote:
> > On 3/9/26 17:24, Eric Dumazet wrote:
> >> On Mon, Mar 9, 2026 at 10:18=E2=80=AFPM Tony Battersby <tonyb@cybernet=
ics.com> wrote:
> >>> On 3/9/26 17:07, Eric Dumazet wrote:
> >>>> On Mon, Mar 9, 2026 at 10:00=E2=80=AFPM Tony Battersby <tonyb@cybern=
etics.com> wrote:
> >>>>> I have some out-of-tree code that was broken by commit e20dfbad8aab
> >>>>> ("net: fix napi_consume_skb() with alien skbs") in kernel 6.19.  I
> >>>>> retested with 7.0-rc3 with the same results.  I'm not sure if the c=
hange
> >>>>> in behavior that I am seeing is expected or if it is a bug, so I th=
ought
> >>>>> I would ask.  Omitting irrelevant details, my kernel code does the
> >>>>> following:
> >>>>>
> >>>>> 1) allocate a buffer
> >>>>> 2) perform some network I/O using the buffer (cmd over iscsi_tcp)
> >>>>> 3) wait for the I/O to complete
> >>>>> 4) wait for the buffer page refcounts to drop back to their values =
for
> >>>>> idle I/O
> >>>>> 5) reuse the buffer for more I/O
> >>>>>
> >>>>> Step 4 is necessary in this case due to some of those irrelevant de=
tails
> >>>>> that I omitted, and that is where it trips up.  Commit e20dfbad8aab
> >>>>> seems to keep the page refcounts elevated long after the I/O has
> >>>>> completed (hours or longer), presumably because the deferred skb fr=
ee
> >>>>> isn't happening for a long time.  So:
> >>>>>
> >>>>> 1) Is this long delay expected, or is this a bug?
> >>>>>
> >>>>> 2) If the delay is expected, is there a way for me to force the net=
work
> >>>>> system to process the deferred skb frees on request?  e.g. write to=
 a
> >>>>> file in /sys, or call a kernel function to flush the deferred frees=
?
> >>>>>
> >>>>> Worst case is that I can redesign my code to kfree() the buffer if =
it is
> >>>>> busy and allocate a new one, and let the old buffer be freed
> >>>>> asynchronously when the skb is freed at some indeterminate time in =
the
> >>>>> future.
> >>>>>
> >>>>> Thanks,
> >>>>> Tony Battersby
> >>>> If you are using zero copy, please look at:
> >>>>
> >>>> Maybe you should make sure your code is compatible with it.
> >>>>
> >>>> commit 0943404b1f3b178e1e54386dadcbf4f2729c7762
> >>>> Author: Eric Dumazet <edumazet@google.com>
> >>>> Date:   Mon Feb 16 19:36:53 2026 +0000
> >>>>
> >>>>     net: do not delay zero-copy skbs in skb_attempt_defer_free()
> >>>>
> >>>>     After the blamed commit, TCP tx zero copy notifications could be
> >>>>     arbitrarily delayed and cause regressions in applications waitin=
g
> >>>>     for them.
> >>>>
> >>> The I/O is being sent by a userspace program via the SCSI generic dri=
ver
> >>> (drivers/scsi/sg.c) over iSCSI (drivers/scsi/iscsi_tcp.c).  I don't s=
ee
> >>> any mention of zero copy in iscsi_tcp.c.
> >> Set /proc/sys/net/core/skb_defer_max to 0 ?
> > Thanks; I should have grepped the docs harder.
> >
> > That seems to work if I do it before sending the I/O but not after the
> > I/O has completed.  So I presume it would decrease performance?
> >
> > Tony
> >
> I found a workable solution.  When my code finds an elevated page
> refcount, it does the following:
>
> for_each_online_cpu(cpu) {
>         kick_defer_list_purge(cpu);
> }
>
> And that seems to take care of it, and it pushes the extra overhead to
> the slow path.
>
> Thanks for your help!

You probably could send packets over loopback interface, this should trigge=
r
net_rx_action() from one cpu only, this might be less disruptive, but maybe
a bit more complicated to get it right.

Another way is to setup RFS on your NIC.

Documentation/networking/scaling.rst

Thanks.

