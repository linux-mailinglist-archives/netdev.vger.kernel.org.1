Return-Path: <netdev+bounces-265630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JaFBTr0rmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:24:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59623CA96
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25EEF305020E
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5613E1200;
	Mon,  9 Mar 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UoCtfRZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B12765ED
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073168; cv=pass; b=W4xqDelmubRG8n7TrhE4mE0IBy9E3V13/dA/fNxLhSo7LWeO7RTqCM0HM13lStQycIjGVQgUKtkExSYPtIaBPNHOZos1xlNYu/pkht8HIy0otcKJ+3D8zSQg2R5COzFQNwPLdkETsyTJGKfMbbRkkoHDzIkfIlDEh9x5OeXqz9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073168; c=relaxed/simple;
	bh=npjQ4dJEtN2ZM/ygoYX33pzfdCh2ReaDCN5TkbeMZPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkDMgTWqA0YRSs2rXf/PXtpFWfAI0GK37ly4e32+zRcNY4dYhsmlOC8XdgpsdUrkEuTeqpim6cS5CNJUY0tN3AJr8W+1CZWPZyhd2xbWPxUvu6+Bzx99UHS0C3lLdQT+52ja4VpAdSOdwfLum5mm4X4RJWUZGzhkVcugfiaj0ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UoCtfRZ2; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so2637434b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 09:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773073165; cv=none;
        d=google.com; s=arc-20240605;
        b=ROeoqJ8or19xPyvV1iWaDBDI3CMnlZeJ6ihm+LdIU2tvAbUGq2/UJc3B0K3lE5qhGe
         ftjXbUWeNDXt+UrXEYzUCsEeQUlANygf8VTLb1GQV27nHTxkvg0QAdwDRCsQztp81Iku
         D8yuXI+9XWse6hoKgxuZjpyhfiVMPmCl6Sv0uBe4M/TNvu5yfE+HNPLcR1efp0PGL4ey
         BhqdfBqwC23epeYqS7QPQdMgcobZ77H5nVE8krmMPo5ntfMy/npgGN23E+mICLg4I7rN
         0Ut/luHQFvW23ivvdrdE9u4fHB0RU7fbRNwduvdrAw5lUgyKUdPM5pmQl8NLlfHw1KXl
         Lhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=04/3nkAw3QYcCQXa/GCi4vzcFPBnDNpm2cIJ7650XQs=;
        fh=Fz1jHJhz2j/DIMoUWGw1oz9gzLHnORdoMNc6GA2LNvQ=;
        b=KaZ/TXsjYEQ8xZ3h+b7OHX4UL/SJ4hdLWIiDtheW6bDkW9Qtek0OF4UCoV3U8GjfBU
         A63TeDQUCryI2UUtIjfyrTxRLN/F2a7FHlULwPvZYL9tO4Tpx2lPTr9NVNChmfMksJpx
         /FKxPdcBN+w52EnnO9QcuWb+IPkQpk5Xrl2hqOR2hzIdMj0dPcDBCn2njysmndJuxE+W
         nI2MaXlAbsjiuLBD9RUcnhz0YnJ+fDroL18ZwpnfvLrWFMFK9yNAwIhVBPaoQbvjFc/C
         49rZOMMi30r6cZcPWwrdCOFI6Y3bI+lN0IXrTYvIwFIZXTWAqojKH7Mo8gnmjxgOLpnd
         3UzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773073165; x=1773677965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04/3nkAw3QYcCQXa/GCi4vzcFPBnDNpm2cIJ7650XQs=;
        b=UoCtfRZ2G9WNNgZ9dZzLvCEUfn3vTQViDGMAFjrbcQgtU3NkNGncRHkBBOwjjSh17r
         H4o3WDK7S3P1CFYMjILINUCA/7bL0vbpbVffx3kwccoarkbY1FatrfMAmQzP+F9uCsEl
         BZcke8U50X8yzEUVDZLj9cVELBYwdHyoqUGwxCS95a9zZXbndG+sXcSg/PdtXQFP9UVA
         39uMUn9c7go524ei3PdMfoxww/jWaNLH+knotLyDe0b27E4hoKYSNGJdZgHRJNqTHsj+
         MWkHVOd0BFtH6H8aQAT3TFfd3L9IeEkYlLhBwBbadmqOPC4N8rBCdjXKZLaPGvF4aapP
         9Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073165; x=1773677965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=04/3nkAw3QYcCQXa/GCi4vzcFPBnDNpm2cIJ7650XQs=;
        b=Kdmd+EwoArpR2bGdvrC/oCM7RreOQrGhy1X8kf2wgPQSOZxGh1leK0fNwZkf3PA3yB
         05n4y7bLamCYnws47ydnv6rrh604l4XBI8SKrVFIiZeYkVeTQlrFFCK72uf2W3GLBk6I
         ksJMzenjcNQyKY9Xxav18vxKkVSH+lIiL0tygbRg/KBtdCRHn2/UqZd6w2p6U695lJHe
         SMJwSFr77luqlpt+oWLT+ZpdEpACccGe3iDZlNaw6G2D5aCrZ6xAAQsthV2JGrl5JMOF
         kW0HgplEMD/fy1ocpsCKM3AHNllm2gQ07MoKDUm/RGPOUEC4urVcvomUBpRXd8wPNkUt
         cP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYLbhof6/ov/sx5t+Hyqmo5N09XocwJZmQ0ayShfRErSTTmd7PkrhEKB+ea/buSxq23kphyvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+OPil8sErmZoMKZ8z3hCUQpOhcMEXe+ZbewVtKXbwrRsdl1R
	Mfa4HNOjCH9VaVZzrvKMjPRgmbO6HlbFmlVqjdg+oUUgralYFHwmTq4rVl/ldqVgeIef029IxtD
	uwLXRFYCSZ1xbhR/C0XLBmIefab2XNMIBemMy/oWA
X-Gm-Gg: ATEYQzx1AiKpLNRkwv2RwIT6lqDT/QwQrmr8jI3pSVbLGSObGaUroThilJY6N0Crpcb
	xXzDgZ+20Qw0L8hoHOGkfnY2g2tPoll/WK17tFwVfKMrPildERv4Cc1gw1buZIz5fo8DNE55ERT
	kmnjwWv+AfKfhjgfU5RWJOGMiwgKwz+ZT+dwcTN6xtCZy9OVRivHOITHSwxSiKR7o3lmzXHQNJF
	hNcyQBkXTMyQu95Cz1dfgwvleMRAncb6daB6sXnKLIjoTbIiGrUyIlL/hbJKMjWWE5QeCYBkWn1
	sc9a0XxSGycUhIoP4watt4orrA==
X-Received: by 2002:a05:6a00:4fd5:b0:827:4372:dd15 with SMTP id
 d2e1a72fcca58-829a2ea9d06mr10995054b3a.40.1773073165604; Mon, 09 Mar 2026
 09:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307133601.3863071-1-edumazet@google.com> <CAM0EoMmEaXQO5YbLvmty0rcpe3=P9ckbNtskiXZ_vvHeVVk9cg@mail.gmail.com>
 <CANn89iLKXBAiPkdh3SsBLD=_JheoNwhz=V4EqHM4bddJVyEYug@mail.gmail.com>
In-Reply-To: <CANn89iLKXBAiPkdh3SsBLD=_JheoNwhz=V4EqHM4bddJVyEYug@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Mar 2026 12:19:14 -0400
X-Gm-Features: AaiRm52MrfGUktdtPa-S4-6og_YtqcNNFt5jRFZsmdMv1qYZ_QZXXj2gsqFa02k
Message-ID: <CAM0EoM=9CfXbQmUiPTLP+ojL0mrsbsF7bfM9ENqqDzsBvYe47w@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: refine indirect call mitigation in tc_wrapper.h
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Victor Noguiera <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5B59623CA96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265630-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com,mojatatu.com,mojatatu.ai];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 6:54=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sat, Mar 7, 2026 at 10:44=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sat, Mar 7, 2026 at 8:36=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > Some modern cpus disable X86_FEATURE_RETPOLINE feature,
> > > even if a direct call can still be beneficial.
> > >
> > > Even when IBRS is present, an indirect call is more expensive
> > > than a direct one:
> > >
> > > Direct Calls:
> > >   Compilers can perform powerful optimizations like inlining,
> > >   where the function body is directly inserted at the call site,
> > >   eliminating call overhead entirely.
> > >
> > > Indirect Calls:
> > >   Inlining is much harder, if not impossible, because the compiler
> > >   doesn't know the target function at compile time.
> > >   Techniques like Indirect Call Promotion can help by using
> > >   profile-guided optimization to turn frequently taken indirect calls
> > >   into conditional direct calls, but they still add complexity
> > >   and potential overhead compared to a truly direct call.
> > >
> > > In this patch, I split tc_skip_wrapper in two different
> > > static keys, one for tc_act() (tc_skip_wrapper_act)
> > > and one for tc_classify() (tc_skip_wrapper_cls).
> > >
> > > Then I enable the tc_skip_wrapper_cls only if the count
> > > of builtin classifiers is above one.
> > >
> > > I enable tc_skip_wrapper_act only it the count of builtin
> > > actions is above one.
> > >
> >
> > Sorry, not clear from reading the patch - why "above one"?
> >
>
> Rationale of the code before my patch is :
>
> For platforms with IBRS, it is not worth having many tests that could hav=
e bad
> branch predictions, only to avoid one indirect branch which is okay.
>
> My patch refines the logic to still allow _one_ conditional to allow
> one direct call,
> because we know this construct is better, even with IBRS.
>
> This is the reason we do not have static keys guarding many INDIRECT_CALL=
()
> in networking stack. Only TC seemed to care about that.
>
> Our use case is only having CLS_BPF as a builtin, I will let people
> needing 2 or 3 builtins
> amend the code with their performance numbers.
>

Thanks. I was initially worried it was highly workload-specific.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

