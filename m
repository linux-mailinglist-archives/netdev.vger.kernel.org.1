Return-Path: <netdev+bounces-255778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QITOCGZfgGlj7AIAu9opvQ
	(envelope-from <netdev+bounces-255778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:25:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775EC9A89
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829C0300363C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32A34FF55;
	Mon,  2 Feb 2026 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0wjohOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C27350A2F
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020594; cv=pass; b=CsQx2qvNuYHc7rm9gyhdYUZvkQicvFDNi+ynb7ILM7X2V82gWQYKByoqtKx02s34bT76zsVRY36e7TjN/kzCsimMnI7E4NC9cWqn9p8UPAAQVX+XuIOMbyiKlX8iWrOl+IEKQq6AUf3JIKeAB55XiQxV5P3FtO9lZZYrSGd2B/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020594; c=relaxed/simple;
	bh=Xb8ycnICOBUVm6SbnueUDP5FWyrKE9M/i2fo2QgfUtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7u3Nvqa7HG3W3vKJJnUqd997o89PyZY/XoESPqQ6hKX+/zwrzW8JLO7eQ9mzotX5sPO3Ioc8tz5MNMWYHql6mS6BGf2H7nZEPUph83mJINFZntsx46VGVdFRnNnWLwkbeXrk/+KJE9PycigCwMhaHLC/eAVapA6q91DDR+4mrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0wjohOX; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c655e0ee70so456813885a.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 00:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770020586; cv=none;
        d=google.com; s=arc-20240605;
        b=dEZVPpV0l3XbRFanqyyVAbcYYua7Gy079u9PaFT4PnsSR37Zbyt342AfPJ0oPjyc/b
         9VHKwONWZ+YXF9QHuxjHRY2oNEWWrRO14CdSx4C8VDDd5SIbKf4ZLj4UlPoMRyahFF05
         03NKHKtjt5jQS89Pd+rDzu3V+GFLFFRWsTHbfCvw/Vlwh8kAe9baPVI8rvLTR/6R7XzF
         G8RXVRI0mPjAIffqghe47lopzupIa42geH2ep15t+jy3VfnxxFWKe5umhuVBkVy/RnsP
         rV6eqIdg+iK67IoR8gLavWocZ6B1n+52I0BD0uanZEoDynz6ZQjcxLO0vohbr+Q8+8y0
         mNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xD0tXzCBUd9HZNxUnh+N0JTGf22f7HfA0H4YN5OlBDo=;
        fh=fHG20/kL6kimtbiRLp+qZTWBbP52sjDSgvBui/c4T2E=;
        b=hbtAhWOabuktIOycPq5DeGMiaXEn/aM2fhO1KUo6mG7/vhFC+WKWcwicwQ8cnbh3+W
         PeDopxjgS0H1VggrgAFHD5DQE+8xt02wdY1XFYKfkTAzqBB06Xzmi+IflRXL35j0PtyD
         qMpKM8mrfxHNsbBNJvpq7w2BtXoRbrlF4bqYyEKbsZroYFGn74BtU0698Zkxaw4P5nIl
         z1TVZelGVBKy89tkS/5lNX9krjZFdHmEjSdRgJEzqC9SASfnVYSfg4NRZ8PwPB4MpErz
         1i8lMccKBn3qxZ5037dggqZ3QIRxU39jF3gQH9JYx/B5mUIFRdS3iwgdEMB0T60XSSgq
         TXoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770020586; x=1770625386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD0tXzCBUd9HZNxUnh+N0JTGf22f7HfA0H4YN5OlBDo=;
        b=h0wjohOXYM6EhZJ36qDDTZfVcXtLs63pWvZLxHJG25y2ZDk6w8GE5aTAIhHW9+xzVU
         2n2reuvJ+n77nNYQsU99d3pV3ndJgAW7DcnlOWTv8qynY1wKTQvDSo9eErmioePHbgYs
         ObhCmG03vHd1TiokNKmomVt+P+oEZ2rNsuwBij9ZPeBB+U3e+Wt+7CtB+JNGw+qf85+c
         EMknUKvst6iXoJ86VY1KKeV3G/h7kOQMzDy/Hd3NlgJLuDC/H0SBL3iviAZ0S43iydJ8
         MsXVrELng1z3iJtljCo/0baJXJ3nTCGuKuonbfZzWK//Uf3VkUXqRcE9lrDjOY45W+8H
         NH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770020586; x=1770625386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xD0tXzCBUd9HZNxUnh+N0JTGf22f7HfA0H4YN5OlBDo=;
        b=LmujlJzjnB2Pv/Vj7w6gF+D0lZzrlXendxCZYIRTVoNKIkHUWVptSEA0GVH6vNNSFQ
         7GyMb3By1r41apMUChiTIGt9aBDhSjOnZ5LRCyJP9X+JOVAbQLnW38hc41RhVYDV6/L3
         orDQyFBKqKkWr5dcxqwTKIOZUIypkE0S3avjqVWDnEJ4saECQYtg+Facp6oyTqZduAI5
         KWJ4qlV/+bqCB29+lxQDZtIx8ivzx/sAvjrbg/FfVenr8tRanZgfap8spkUu30NPOUmp
         KcMFAhG7fBvZaXg9/ABpfSZws7ZwGZTtHQWhiqUe+a+jDbAVRdbaVF1tLG6soDxP4RwC
         n1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/B+Lcz3hXd2VbrO8lxzsI+yaij/oNdApwXvh/X8CSgaXbJgfUECLmkJg2g0jb79x3Z+yvSPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEz1x9Z8j1ibRV0TmDD2qt90DJ6ETdnsrYBF8UuXax2YSGm1a
	FhMBU5RJksJHPDF7WWQUW/qNPUq6hGx1yMMfArCGi79AAT7uZX+SIOhYt6Qs2XeCAmkUQLY6Fv1
	6KVnXUOrxLi4V9qOUt0T9pjK8XgNqimW0KPlsEmtq
X-Gm-Gg: AZuq6aLI/J71QNFZlAWpU0fd/qZQ9ighybwfViQ0eJ0bjIz9IzBXpBTRjT+0ZgA+DLN
	JLvlrX+51SCYxz7xcUtSdPM9WgVxCZJZFD08HKyi9Do4Ha9KhWgurltkwoiU1vfJzO6QB/A4xmO
	AInxkO3LFtfkFn0s+d59IOfJSK07ylzhJ592V9xHbHh7K8Put5sMBwRcYtY25GlW1iQXeUjTsVe
	HuHv88qvwj9tr07lFkSdAHoCitWAk9BQCjDR79hT4RJxOmTKf9Lo6pE+F6BSLBj+/11xKs=
X-Received: by 2002:ac8:5a0d:0:b0:503:36fa:4398 with SMTP id
 d75a77b69052e-505d21848f3mr160774991cf.32.1770020585573; Mon, 02 Feb 2026
 00:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131212934.2547995-1-edumazet@google.com> <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
 <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com> <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com>
In-Reply-To: <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 09:22:54 +0100
X-Gm-Features: AZwV_QgefbQqgzdk2wfsCED4etmSyW8QPUusxNmVu-a97oIBAAD_3jMUlF4C07Q
Message-ID: <CANn89iJ=2pFqfepmK94aydxr1s18PK6PN9gMkqBjPw4Ss=V0_Q@mail.gmail.com>
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	fengwei_yin@linux.alibaba.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-255778-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,mail.gmail.com:mid,prot_hook.dev:url,alibaba.com:email]
X-Rspamd-Queue-Id: 6775EC9A89
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:21=E2=80=AFAM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
> > On Mon, Feb 2, 2026 at 4:16=E2=80=AFAM YinFengwei <fengwei_yin@linux.al=
ibaba.com> wrote:
> >> + Chenchen as he hit the exact same issue.
> >>
> >> Hi Eric,
> >>
> >>> Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a =
patch.
> >>>
> >>> Real issue is that (struct packet_type)->dev needs RCU protection:
> >>>
> >>> ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> >>> to get device name without any barrier.
> >>>
> >>> At the same time, concurrent writer can remove a packet_type structur=
e
> >>> (which is correctly freed after an RCU grace period) _and_ clear pt->=
dev
> >>> without an RCU grace period.
> >>>
> >>> Fix this issue by using proper RCU on pt->dev pointer.
> >> Still can hit this issue with same backtrace even with this fixing pat=
ch.
> >>
> >> Look at the __dev_remove_pack(), the pt->list is protected by ptype_lo=
ck
> >> while prot_hook.dev is protected by bind_lock. Could it make sure the
> >> procfs interface see either the list element with prot_hook.dev not NU=
LL
> >> or can't see the list element with NULL prot_hook.dev?
> >>
> >> Regards
> >> Yin, Fengwei
> > Please share the new stack trace (with the symbols), or the repro, than=
ks !
>
> Hi, Eric.
> I encountered a similar issue.
> https://lore.kernel.org/all/20260128112348.3950437-1-dongchenchen2@huawei=
.com/
> we can reproduce it using the following method[1][2][3].
>
> I think the reason why using only rcu to protect dev cannot fix this prob=
lem
> is that pt->head.nxt is not protected by rcu.
>
> list_del_rcu
> __list_del
>      next->prev =3D prev;
>      WRITE_ONCE(prev->next, next);
>
> While traversing the ptype sequence, once the nxt pointer is obtained,
> pt can be concurrently deleted or modified. When pt->dev does not corresp=
ond
> to the list that pt is currently in, the list head detection will no long=
er
> work correctly.
>
> CPU1                            CPU2
> ptype_seq_next
>      nxt =3D pt->list.next;
>      //nxt =3D ptype_head(pt) =3D dev->ptype_all
>                                 packet_release/packet_notifier
>                                     unregister_prot_hook(sk, false);
>                                     //no sync wait, pt->list.next not cha=
nge
>                                     rcu_assign_pointer(po->prot_hook.dev,=
 NULL);
>      dev =3D rcu_dereference(pt->dev);
>      if (pt->dev) //check fail
>          if (nxt !=3D &pt->dev->ptype_all)
>              goto found;
>      if (nxt !=3D &ptype_all) //check success
>          goto found;
> found:
>      return list_entry(nxt, struct packet_type, list);
>      //return list head to seq traversal
>
> -----
> Best Regards,
> Dong Chenchen

Thanks a lot, I will take a look.

