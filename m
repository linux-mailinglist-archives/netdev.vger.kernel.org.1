Return-Path: <netdev+bounces-296427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CqxnHdGDJmp2XwIAu9opvQ
	(envelope-from <netdev+bounces-296427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:56:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D7D654463
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:56:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KL1rQxHO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296427-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBC773053570
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567B53B27FA;
	Mon,  8 Jun 2026 08:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77D3B3BF0
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:52:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908724; cv=pass; b=TNTaK2WujV3MspRZYbD91zA2iE0t5ToZPOVV4I5a6+bKljOA7ksAdCrgMQdhGJLfRjOugzBAqJpDtE+R1SRbEaEOc0A1vIQQbqAHc/814qWcvI8Fk4z/uDdRDk8p91AQNq38+b8UQ845cqrEQ/0AbSA9p7kkPBKDKSkfXgymvL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908724; c=relaxed/simple;
	bh=6YtLyDztB8FexsePtPBCq/mwirV33JvBQM+DpZgauTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NleqneilHcAnDm1VxhyZtumfhiOi2txTE+Yd1lo05EZ5X4HlemKQiXJX35l1tfp9ansVfITXmWJh9RdxLkJW5zNXHnDcqmOgRounyLMPBWk0EMD5N4zpskC9aKtWmO8saRQqKMnFqOwjfn9oAj7B/RxvW0ogNCirJIno5P8LjPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KL1rQxHO; arc=pass smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce9df31840so30113816d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 01:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780908722; cv=none;
        d=google.com; s=arc-20240605;
        b=K0+Vc9i0GjyKI9HrEdrSHYB7eRmd+knN3M0nPWrAXOvQnDuinf4SgrLD2ZPfQWN+0H
         eAQG3PQsmaBZhMVvlcAuvCPUcYCPvmyNex5/ZbfKOQZB4EXVzSrznIWn1xZMDmH+iMSJ
         DQlJCPwJHx/hHgj770TB0lDl6ijf/o6c9IKzC5ghjekNiWaxIKydlAIHygFmVB0Vte4h
         6I3XJDE27A2K0OwHAAPX7i4jz2LsAF1tq6DMzf1NmW92O8pxqGoo0+ynjhU2F4tfCN3W
         qUsCv4Z3o9aovl4n6vQMfpcp7UZBV88zGBG0ib0vCIsaluTtjj4Bo+UIghjBxNEMovwE
         gClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGvqNjA1PU+NdIHJT2ngGT1SBc5g4y3GxISXztS2aXI=;
        fh=ij3q//sKmMH5O6X/c7mx+lmZnHdiD69xY7zgxXYzImY=;
        b=Q8OMexxnR/geGaFTz33Fi8ANedr1ZJppPNPIYeqhfG8GrHkBtDcj/6N2JJXdfDjYXc
         MtLoIilP7XIMDLBM/NUoVLVRsvG6Ty3muO6yzBw5B1uQCGt2wj+1/TOLlKeOeMqMfrwL
         LIs6SYWdtk3UEYVVxFKT9h3ZyhHol+pKH4IwUqySmipAPFYLa37HeYuV+zvjUmtp5o0O
         2H53liMXJfNkwZ4yGlo1CX7LKK9VBzfR6czUFicQzPFBnmmgu9Zq71n7rFOa1YB+IWBq
         wt3pIiOxgPouyLaf/jFSXkpiZZxtXhXCkUrebitfgmoCuOoKJT0Lk2MO5PrYk1cU35y8
         A2xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780908722; x=1781513522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGvqNjA1PU+NdIHJT2ngGT1SBc5g4y3GxISXztS2aXI=;
        b=KL1rQxHOtECe4gmKZ6QiWwVY9/842GE3oosM/mwb9bLTSOLEnQE8cES7pwFob/kghr
         2xLcmRBoJNaZUgsBlAYD37KN5iP2GrjcOf21Gz7essNZexVMtKsn6EGVZmS+guCaCigz
         u+fiNjukChsPEJ94Ye3TChGimrG45fHsMDTPKLm0WMBPzDuit82anPiT6LmAsTvwKFcR
         dvnCz3soHKhBC989Vxk1CaCsIhR7P30Hp/pDZ32YeYOqsi2ojtErJQ6l6C3tvxqts77y
         Qe4hgvtUmI4esheRXs3qkeseQXNDE03EvWjb+WzR1hH2elEvw2IrpO8hYVuSjeckLWJ+
         m2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908722; x=1781513522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGvqNjA1PU+NdIHJT2ngGT1SBc5g4y3GxISXztS2aXI=;
        b=E4PY2B8ENY3iuu8VaGuieC0/DJTwQDyBtr5JTyVJgMWwlBGi66N0IxuKq7QEGDH+hs
         NY8SXUfYYzZ0i4JdDx+tF0F3XOFl41t4NLxXs3+qdb/kokVSoLd2XYXzp4k1ChLa1EQt
         odlzZyTnF1hxEAhv6BFhkgTRQTK3q9xn960qjjdoSM6COvhaEysw8sj43Dftion6VcRX
         0e52THetUocyD44tS12m6uR72cyj1MJgV2fSP4gBVfc+VBFx1Cz8gl6nWVW9bkr0w1KV
         VRyXFjL6aT51k16kb5uXWv6ZgVq/5tb2gVwv0SVLP6qrXNQ+d6U2JjTXk5v7zO0xgQFL
         3x7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8EmiEt0LqAbLIvFjKM85gJpXY/d+1wveMLl8UBActGod0ksKT0zad3yZajr4l5SXvB5UcvnXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywycxh98QLkJruSYB1F/PlM/Sz25u6guTC9OTsGvwlxWvEa8JRI
	LHxexE78S7r2A8AtY276ualHsSaT/NRbNYdsf/ujReN0Sm/+fjMgHrmY717N5QhHaldd32PrXET
	b04TlkFlNaFa5g/7J3pivaIe96U+QyRLhrzvDkLR0
X-Gm-Gg: Acq92OGrxsCC0X+r9k+vwr6Ne/aL17Be9pfMLsMsikxoX7k2LpQl3IHHqAQ2782Gy7K
	oS/wdngsXqhqI+W+/ZSo6P5GQSkFFABhsxUrnYRB9uAtmTHW9g+fvuzB1A8HbMWfWbArA6KqQ5H
	ZAttjX6CPF5U4CK4GHCrif4MUhJ0GTLJJMEHPW11qBuiW3uHrrSKguGsJrIpgxnPbyNQPhf+c31
	vo08B+c1+5WeHVqg0M+JlYVEWx3Af9dpESg6gMsHju/jeOA3yKMe0LjNrDTLZsvxvlph6h64eat
	W8qoD5Czw9F1QJeuI3NX6zun3SOadnK8rMFF8qd+366sSLEvAyXp5lOD6Bd7dl4NDJ4Zkxlxu3b
	st8cqjgdFLaSm7lXFf1X1XwMOCTw=
X-Received: by 2002:ac8:7f4f:0:b0:50e:6139:492b with SMTP id
 d75a77b69052e-51795b21524mr210459921cf.23.1780908721050; Mon, 08 Jun 2026
 01:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302205527.1982836-1-edumazet@google.com> <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
In-Reply-To: <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 01:51:49 -0700
X-Gm-Features: AVVi8CdsPFGP6LvWmf180viXopgvBlIYxUawqbPsvScbkqA0C8VERHckRp7cBqE
Message-ID: <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
To: xietangxin <xietangxin@yeah.net>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Zhouyan Deng <dengzhouyan_nwpu@163.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URL_NUMERIC_IP(1.50)[10.0.0.1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xietangxin@yeah.net,m:pablo@netfilter.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:w@1wt.eu,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:dengzhouyan_nwpu@163.com,m:fw@strlen.de,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yeah.net,netfilter.org];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-296427-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,1wt.eu,vger.kernel.org,gmail.com,163.com,strlen.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,yeah.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12D7D654463

On Sat, Jun 6, 2026 at 4:06=E2=80=AFAM xietangxin <xietangxin@yeah.net> wro=
te:
>
>

> Hi Eric and netdev,
>
> I noticed a significant TCP performance regression (QPS drop) when using
> iptables MASQUERADE with the `--random-fully` option, and I have bisected
> it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
> (tcp: secure_seq: add back ports to TS offset).
>
> Here is the benchmark environment and test results.
> Environment:
> - Client & Server: 2 VMs
> - Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
> - Benchmark tool: wrk (short-lived connections with "Connection: close")
>
> Test Commands
> 1. With random-fully:
>    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQ=
UERADE --random-fully
>    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1=
:80
> 2. Without random-fully:
>    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQ=
UERADE
>    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1=
:80
>
> Test Results (QPS):
> 1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
>    - with random-fully:    18145.74, 15006.39, 15716.67
>    - without random-fully: 18556.36, 16339.22, 21506.02
>
> 2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
>    - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)
>    - without random-fully: 17310.75, 20279.85, 18399.48
>
> Is this performance degradation an expected side-effect of the security f=
ix,
> or is there any sysctl param we should tune when `--random-fully` is
> required for high-concurrency short connections?

Hi Tangxin

I do not know why that patch would affect MASQUERADE performance.

Pablo, Florian, do you have an idea?

Thanks.

>
> Looking forward to your insights.
>
>
> --
> Best regards,
> Tangxin Xie
>

