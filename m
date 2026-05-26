Return-Path: <netdev+bounces-291709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOvINUmrFWpuXgcAu9opvQ
	(envelope-from <netdev+bounces-291709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:16:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB7C5D7479
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D00F3017E9C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0780E3FE348;
	Tue, 26 May 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXJGWyn/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644993F5BF5
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804807; cv=pass; b=HrzUMsHdjDtkX8otkcXug6XTH8rdgfw+nyJ80gXfnNnHlvSuFnHygG+5SveHY/6TXDk2moy2xq/rCO6vczwp04LxtOIcfwVHN7UBcqEysrD/fWRjFQ8/Jg3jjm3Ovz6f8q7Q+ssbl8qty2CxcrQO9bnewn1ySD9sHPXi+Nxhlc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804807; c=relaxed/simple;
	bh=szMB5rJIZwyDr8Co1iszMrMWL6CuTDsrGcSVaie+nAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StXrGRL5mlMuq+STWM3byKFjVBVtuRSp8X+95f8G6AkKXce8oG3pISsVQxMVgEGxSvnE0Z5uUfVxvqXR5M3qKDa5fqS4rpv6CeBKsAosKXtNTr3oblZirRAmi7OOfP+6Y3H96pejckqA+oE7UyGmPa9+95haF96vzyZxiTmx7e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXJGWyn/; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51306c9f2e1so125867231cf.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804805; cv=none;
        d=google.com; s=arc-20240605;
        b=F9h3yE5E+V7wTGKnFo+gBGDLMPgOaVR2Xv5u33m8loJssMPDszELjVfh7PoEfO5fkF
         QGSbqTcsl0blds4hg5ZqB1jiXI6jBbUNE9wt2xBOvUaAWMk23AfcsX9jqRn7S917ONbW
         HZwEzsQHnyld6hybEQMmsbBV5QKTvn25C989Rtt7FJE+Mni44q7JtehXGsuZXsGaJBO/
         Cja29RY/SS+7DvDvSAme6XxDdBhY9ag2TA0ALYDeMBAP3rU/iLn7e39e/SQj1oPFSCod
         aarB4FK687fW4e5H2zT3pcqlerRQOtisKpSq8AaiVllkuLC94NKniHY6ZX1dMkoYv03R
         vDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aL/4GbBmhemP4ITHOZqu5kMdGwyvnVCuB/ahWK9Tni0=;
        fh=NoLVXJuS1x4ZE683FNE3t0+No8sraQUzMSowQd2Bm1s=;
        b=czF53cSB6h4QNui3Lw7A4SXNhrGT+DvWNLeSfO7U6/JObpOYkpAXcZ9hk9lqBOzn5w
         6LqO/b5n6L9OfHsihRuYUpvMUgiIHb1Fca5jKG8JFEkr2o2h/1E/EA0zJ4ri8rdyjNXQ
         I+UzWm5RI0qnKSpp7tlNL6+8pz8bpOPQmySDUE1MZNT/0rdFnYHtr9/ZfzhAb1/L8/Ys
         tIAC151hpcwX/RJ99DmsQA+RG/1IxlMv1vuraZasWHEMulNb7aKqi3YkycdlximkjEFf
         rp1OdbhtXih9Dq6HGp0QQCR3L4mDWY8O4TePbhxfPPaoaJbduisMP3WmkZiWECtzC0RH
         MPcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779804805; x=1780409605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL/4GbBmhemP4ITHOZqu5kMdGwyvnVCuB/ahWK9Tni0=;
        b=gXJGWyn/JgGOdkqhr2uX4MLFEt6+yIbIlDIwLdCB6jlw63zRCYC9RQr66pgBKlOwCG
         dkKWFb3onwaXK5o4jv/Q1ZKfbsgYVlJPfqjKI+Onn39hYxgCO5bG3Cj1xmYJGZBGRKQf
         yS3+/67LPv6TDnVfI9GMSCWOo+lolKNflenhEPrSk+sEcWauuU22xvqggxTQGvkw7/tz
         YnKIYqgtboqL6d9wkYKBzo4oHFGGILa2+xWOrqMFgXSlk7EBOhppaMiGaoHuznmahwWn
         jI/zHEy5pACP9mc1xSbtAeWPu47ps9vDj0dfQ5Dqph/rlMiYreKJzmDkTDWxC2JHVjF9
         FlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804805; x=1780409605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aL/4GbBmhemP4ITHOZqu5kMdGwyvnVCuB/ahWK9Tni0=;
        b=dIBh+nBWOgEVRMZbpSJkYA9eTYHD3aTfY6wfMeTWMvh+bqaDp+3/PfIG9wEbMy5Shu
         x5pQrR+rkwJ9ES8kG6GtoVRNjGbdY3LsbW9dh5fMLCQZmr/LRuvpyW8zjCkJ+kmACYnz
         XQleNiVVLZCEmyyqrYVaYzpqmnfJdQTxCEaU2pyca7WRMxcLgOdfrqnT3FOnstPH7EA6
         1VydFZTX+40Bq/3VIropTQsyGzHJOWgDwannJnrXozL4sbzY0smu+8owr5Y+DZOoT+EQ
         A2P4MA3uHuDQhDv5kbEkEKQwUJ2dTvEyMArJEWQ9Ksb1aHsPbKlKH/XBriAhLgEP/rR0
         AUIw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qq6tsVau1R09NOmGr6wF8WB0+02UXrfH6CbrRChBm7fSOUIWFNbqgNG+1Ao+sEy1q7D4ksdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4HIASKqyS0rksyKdUmcM71F6tmrZ2PQ2eHc+rPyjSzuPfWC+
	eWsIlV5UBjTVPIFJkFtYKb/hTNf8QYlvt6uGbvQ81IluwXbNVCBfd6AVoemQWkLCnRn/hOfAczc
	OOx2AG2YhF+4ESf1vHUwsvjw0ncKPspBZ3wA0Vx5M
X-Gm-Gg: Acq92OFoNODeM/cKQMcwQGjwLxqVWw1gz4YYevGZXosp1oPYsEPUEbIEgdEXV8Q8/ye
	KCY+CDZl2aky/FPuQ7XPLJgD8/QavYNtJ+YGrIB+HYGBlxQv8ROCot01t7QrkDR65FsxnJeXHae
	8BHpODtxhaTARSzR/SMS1SdXPWNfPdGGkVZztjufNneJy2GMvjexK7WiGQ/LZsKjUplJ1Z+KqHD
	LsN1vmh05EKDQ2eWhpz7kK7Ja/G6AlDHK14MnHj82LMFFOY/TxAWv1jdsEhxONEZ6nDfYtsdwDe
	KvglEkXQ1O9P9Yen9pLgXB5gOl2a43sVyj5pcAZOhICLv32aZfvHbh7z58jYuRo+sPdJIKtY1du
	MAjM5UPnlhF1HBqEJPCiHbWw0BqMzm8vQezQtK4FWQEXA7e8zx59f4euAe5v0bp8=
X-Received: by 2002:a05:622a:410d:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-516d43cb2f2mr241460991cf.32.1779804804276; Tue, 26 May 2026
 07:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525082510.1554447-1-edumazet@google.com>
In-Reply-To: <20260525082510.1554447-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 May 2026 07:13:12 -0700
X-Gm-Features: AVHnY4I7fof_CPcJ3XmtxWlzZc4qPBB3VhSZzBNfqI65xRDpIFjzvX5ENYi5afw
Message-ID: <CANn89i+x3-u_H5favLmR5OFn_3nPE3GPMV9iBFpSMVWek09Jvw@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: ifrags: cleanup __IP6_INC_STATS() confusion
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291709-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: DCB7C5D7479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 1:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> After commits e1ae5c2ea478 ("vrf: Increment Icmp6InMsgs on the original
> netdev") and bdb7cc643fc9 ("ipv6: Count interface receive statistics
> on the ingress netdev") net/ipv6/reassembly.c uses three different
> ways to reach idev in various __IP6_INC_STATS() calls.
>
> - ip6_dst_idev(skb_dst(skb))
> - __in6_dev_get_safely(skb->dev)
> - __in6_dev_stats_get(skb->dev)
>
> Lets centralize this from ipv6_frag_rcv() and use __in6_dev_stats_get().
>
> Note that ipv6_frag_rcv() tests if skb->dev could be NULL already, so
> I chose to also guard against NULL, but we probably can remove the
> tests in a followup patch, because I do not think skb->dev could be NULL.
>
> iif =3D skb->dev ? skb->dev->ifindex : 0;
>
> idev can be NULL, __IP6_INC_STATS() deals with this possibility.
>
> Small code size reduction as a bonus.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-116 (-116)
> Function                                     old     new   delta
> ipv6_frag_rcv                               2492    2474     -18
> ip6_frag_reasm                               807     709     -98
> Total: Before=3D24655281, After=3D24655165, chg -0.00%
>
> Fixes: e1ae5c2ea478 ("vrf: Increment Icmp6InMsgs on the original netdev")
> Fixes: bdb7cc643fc9 ("ipv6: Count interface receive statistics on the ing=
ress netdev")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Sashiko says:

This is a pre-existing issue, but could this cause a NULL pointer dereferen=
ce
if the physical interface was concurrently unregistered?
If skb->dev is a VRF master device, __in6_dev_stats_get() will attempt to
resolve the original physical interface via dev_get_by_index_rcu().
If the interface is unregistered, dev_get_by_index_rcu() returns NULL.
__in6_dev_stats_get() passes this result directly to __in6_dev_get(dev)
without checking for NULL. __in6_dev_get() blindly dereferences dev->ip6_pt=
r,
leading to a kernel panic.
While this existed in __in6_dev_stats_get() prior to this patch,
evaluating it unconditionally at the start of ipv6_frag_rcv() before any

I will add tests to __in6_dev_stats_get() in V2

pw-bot: cr

