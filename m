Return-Path: <netdev+bounces-268817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN7zEqzluWmGPQIAu9opvQ
	(envelope-from <netdev+bounces-268817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:37:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A767B2B465A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DDF30B9819
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50B36F43F;
	Tue, 17 Mar 2026 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QE2/4gne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65B342507
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790598; cv=none; b=mgHfqf9arhDlzLeXdddvSRM5MTfwQlO6vlaX0MIUbTk0cJ8CKihD9MtTJYJtLd8wW8zXAP1kp1SVxAZP5XZQ3a/80EK1P7D95xazJAfpZ4ZM1YKNz/yAwUAlVHW2nFAWxRqTFkIET3y/QfX8uGNtRD+wLFwp3CiCTtTob1GwGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790598; c=relaxed/simple;
	bh=6jqn84C3I1xS9hYln6RFJBoBXM5nsg0aRS2EDcst6rE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUSz8zKnHjRH5eE0ApverOcsCdASKBr1VFoUNfSGN57SEP9Cl1aiDb0VWQXPoSdKXhvob0LE7Ddn9b27Cy1+ZcAzn2C9A+EFzTGkoW41B2APxFbxn1h2KZvWzrmex/XivpIsWdYyyvTK+F8fre5J2h7xhp7KWlFi0ol0wcUJvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QE2/4gne; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35ba749f441so2032767a91.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773790596; x=1774395396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iH05ViREyCs+DsWWLoifY70z/jz0ZC0NFfF6KW8NUc=;
        b=QE2/4gneN35pSe3KT4LcFn4nW1xkQjhM23sbw47LEuYe5OHE5HVl3k6aqeMN3mg0VY
         VicgdcMINW1UXShqJfUwnaPCTASoiqkJTKiXzlEGFv3DZFw9cK5kJnx6fXTfQOfjJaRp
         GyclpwV3qSxem/vuJyGi41BM//Ye8kAfl/yo2NUY37780KJ6+7NhFJBRnP3zkIw8qHuW
         9dObGwadQH4soNSv2JtY750ZZSCnKOu8Ao4jIrXtY6+23w4OXnTCAYgDwEjcz29jmjI9
         7WwSYqEBZZGq1jFzbg6eYMwprY0tECH41Q7JiBewF0sFKWj4XHOq51L9c8M+ljYDiSij
         23BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790596; x=1774395396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iH05ViREyCs+DsWWLoifY70z/jz0ZC0NFfF6KW8NUc=;
        b=UCcnYnspooBxgreYv6Q7vh/aVPK6jyXOlSyLiSMK/rlMI6OAoXL9X/+oXkRRfXGiSd
         dNb8NVTevc3Ue76KQiob3RFpXVPWlW9+y2kxrFlsvxITVSKl+bP66B076JCc8gvthK0H
         aIXCMHG7jrvXb9LaL85K5R/uVYtdOAXDR2RxPxGNrL97lhJE7COuKvVGtDCLN9+lvtrr
         PLjj8IzvTnWsTPbV0XfOTbp40B0DMpJWRZgJTosox6nAzokqZjp/3xG1j5IDr4/HUXZ7
         4qm09K4jDlI6RhQzGfWakBB2cqv1ZJQ7Remx6aE6YCWde0EGGIhmJaPfks2Y8e5y35oS
         po6w==
X-Gm-Message-State: AOJu0YwMjhy4DDiHuj4WfOXu+PSiJYKZZXFkKK0JMa3w04HuUW5NMJe5
	LCEKHUqRSDvJAThcWGPAHqEgJzrW7LioqfUkpg6ZMIQUJu0DpW/kfRhUQV8WBDaCDm8=
X-Gm-Gg: ATEYQzyCQ8C2M+Yh8xLGLrBIXj2ujr6S5EGKfj7M8odNiHVAqcBo+578lScM8ViOolw
	K+v8VT0jzYW282K8HfNP3/oHEHrNNHA28gKsxJsN+Pqx5B0isvRcdLnmnTQNXPbfIbpa8rDdD5X
	H+O+TWmlUs4phn7KWWGiWNdMKWmaW7ruQhj7/J1XalUbm9gA/A6AQK7VvCCNZwNiTZRfbemc7a4
	o3gxfcBBclRo9KmBzWNaiz0fVDMh3ChlqTuQXEEGiEMWcpN0AlNoCOe72kOghBid0OKSNoKHeP2
	1t7iXuX3lH0SxP0TcoB6IXqHoo/d3CBNBDM7Frn6dyyQqyEf+sd6juV2WO7DQcYEyjHxG3GScVf
	s50Y6EL1wCrgoNZGEaG/lDnHr0xP7G7DM+Xpay4rF8SHURXjGXaeLkIfUwBWE9o+l4bMCVaBJ5h
	LbHX1Dc/VFhfljs4gu0Q9RpPyjJKtG5QU9MEiE2Gh2gj+BfRdQD26qmi3jyoAloRwxDMDzhFdiA
	HcdNtkuZ8NK0LzM7R61rQ==
X-Received: by 2002:a17:90a:d604:b0:35b:a656:a60a with SMTP id 98e67ed59e1d1-35bb9e51941mr1131667a91.8.1773790596578;
        Tue, 17 Mar 2026 16:36:36 -0700 (PDT)
Received: from stephen-xps.local (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bba2175dfsm586697a91.0.2026.03.17.16.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:36:36 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:36:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu,
 pctammela@mojatatu.com, savy@syst3mfailure.io, kuniyu@google.com,
 toke@toke.dkus, willemdebruijnkernel@gmail.com
Subject: Re: [PATCH net v2 0/6] net/sched: Fix packet loops in mirred and
 netem
Message-ID: <20260317163633.0c69db62@stephen-xps.local>
In-Reply-To: <20260316211052.332383-1-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268817-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dkus,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,networkplumber-org.20230601.gappssmtp.com:dkim,stephen-xps.local:mid]
X-Rspamd-Queue-Id: A767B2B465A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 17:10:46 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> We introduce a 2-bit global skb->ttl counter. Patch #1 describes how we put
> together those bits. Patches #2 and patch #5 use these bits.
> I added Fixes tags to patch #1 in case it is useful for backporting.
> Patch #3 and #4 revert William's earlier netem commits. Patch #6 introduces
> tdc test cases.
> 
> Changes in v2:
> Do not reuse skb->from_ingress (which was move skb->cb)
> 
> Jamal Hadi Salim (5):
>   net: Introduce skb ttl field to track packet loops
>   net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
>   Revert "net/sched: Restrict conditions for adding duplicating netems
>     to qdisc tree"
>   Revert "selftests/tc-testing: Add tests for restrictions on netem
>     duplication"
>   net/sched: fix packet loop on netem when duplicate is on
> 
> Victor Nogueira (1):
>   selftests/tc-testing: Add netem/mirred test cases exercising loops
> 
>  include/linux/skbuff.h                        |   2 +
>  net/sched/act_mirred.c                        |  45 +-
>  net/sched/sch_netem.c                         |  47 +-
>  .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
>  .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
>  .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
>  6 files changed, 674 insertions(+), 137 deletions(-)
> 

I would also like to add additional guard rails here for netem, and you
might consider the same for mirred.

 1. Do not allow duplicate option outside of root namespace.
 2. Cap the duplicate fraction at some rationale lower bound like 25%

