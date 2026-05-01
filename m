Return-Path: <netdev+bounces-283211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3kU5MWjC9Gm+EQIAu9opvQ
	(envelope-from <netdev+bounces-283211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:10:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C794AD829
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D7413014132
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFEC3CBE6D;
	Fri,  1 May 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="KGKrAtau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA413CAE60
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648229; cv=none; b=d9dUNC7FD41orajwK2OtB+p0PJPulql7r3XZAjkUH+TQO8fHPLFU+2qukOu+Jn/UfDCf03pmBhBkFkTldYwotiut0yzwb+WzJTWcea9mIAM1Ctb04y7NsYKOX30YfbXQh9uXjpEl6sTkCz/ADwqQcESLwa8N2mvbFu/ZYfm9VUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648229; c=relaxed/simple;
	bh=PJdNdnWvDDluh7UHBD80CPUJ3FSZdmDldbqnzO2EGv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn7khKs5c/56wR3E+SkKxr3Ky46XX7L1Qld5RkpQNOyuDycWT+pAclehpefOxyS79wHzNplKqUc3vqZvIBxvFx/pBxIpW94/oSLv2FDaKvodJM6T5533oDj6ZlZjDUMjI7Ti2myzv8cTXih2bQB/3hj5tbH4n4CAWuIMgzm0nU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=KGKrAtau; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67c250805ccso822288eaf.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777648227; x=1778253027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiSLDt0k6mWQuRILOKEajMVcrvzNv9JTk+B5NWaEkIQ=;
        b=KGKrAtauoXmvAzCbPna2Ngh5UGvIuxlTvXKqm+VKS9lKZgVtRMOB0rjQiRb1wOSXR2
         yhcjMrThjkkDrdXz9A0ViX2dRiTUgiN2LyCgtr6Ni4ZZkg9CRFnLvDa7gjpPZnyJmh8c
         3pi+U2ZnFZZkl3HCXpdqmxgkNeSVy2iYOlBMWC7tzvXr3AtuKD2+q41LdCPUV82rdi5+
         qSzQ6KOzlnhJvebQ20oYVZJL4MX1hRqhVzUgdWTGe3hk2zgSgsqtcNAShi8L5GW4JYAu
         W/bDudzsZ7Rg5n/CesmL4Dbzx/tKt9d2l1iiFTXK/NwIfhtViOb2pYVbZme68vjji5ML
         OjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777648227; x=1778253027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GiSLDt0k6mWQuRILOKEajMVcrvzNv9JTk+B5NWaEkIQ=;
        b=ik0hZhgj8PsSfOINgL035yvA4EYT+ZksBTarvbCbGlSRBRGyQFx4GVadzTDh4SYRwB
         9zzXKtW6uRXDpckd+VOwVlx71C8xB9z2neX/C8U+SnA45sMG6Va9yQDTyPSr35qHnN9B
         LeAfm+/XENQHpg4BkwCZjxddqgHF/J0eg4ydJr+nyoIm1sN8zW151ig6m8MouiNRZ3+4
         fxCI23yeee38To2KFMXVEjgLNu6CcpwkPWAlOKAhyYoxM7eSVfM5gc3sl4TuafxrSFGl
         xPSVzzKL/mYtPQ3DzXg0Y1KVN0d6ATusznxacgsJLqjBtRyBBgWiZwSmZjkUD0Xlqj+5
         1DFw==
X-Forwarded-Encrypted: i=1; AFNElJ/eOLALqIL2HtePmWBe/2vgTZkDwMIC1kRa01cc8LZLd70dZ0bksfbItvL5bk8CSFkrMLxB6PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHDiQKPRAoJdAZPRdQoRhDMr7OcOtNBa/JIksdTwuyFSNUGfs
	CCmKhO3RC+MJR40vmWfXOlgz9RycYtm7eI0Pv0hsvyqmHbhIxG2nHX3aqqBsQnMKy+g=
X-Gm-Gg: AeBDietvStc4pTU0Y2As+bbR+YWBjBHsU4DsqHdgP0n/cFWy8UN5ics7j9EfiVUHVVZ
	OCSVJ7O/AP5p2PXXl/igfytPJPCuAO/JSZpQs2U1Ai4c6C9iNGbvdiUTj3AUQCBfR6jmvRKVYtt
	wCrz5vGFcHl55cjKJhhV8OS8QmRg/H7QhjSfOTfgha5kLkNHpenaIO+sw4RAKy3yvuPOTr0gzaC
	W8OG1sO/VMNz4M8qwOe5IGuZXfHInXk2876RRHEpL0jlNJNLr92AzPgzHbeMOZzRmZQHS8/DZN8
	ROnHAjHkglSLt5CvTZytbQv1wCkvWom+xNOLVtxqUSh61tGNNl/chZgvgdatG/EOrS05dYWbS6W
	A0tXmuk+E4klOkqlxWWcX/lHOAt9suekzAtPywmvsi8sdHghq9no7zT2YEKXQZfwvMp229qR6Wo
	GI60PEiWM0EzeaGYL8OqYiGmcoGLEHiR0BiNf2oYuqFRYFLg==
X-Received: by 2002:a05:6820:2226:b0:694:97b4:58ff with SMTP id 006d021491bc7-6967a532c78mr3578019eaf.26.1777648226629;
        Fri, 01 May 2026 08:10:26 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548d9decsm3116639fac.3.2026.05.01.08.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:10:26 -0700 (PDT)
Date: Fri, 1 May 2026 08:10:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 iproute2-next] utils: add fflush_monitor() helper
Message-ID: <20260501081022.3f297100@phoenix.local>
In-Reply-To: <6e00eaa5-a4d7-45dd-9d90-fb319b76c9fa@kernel.org>
References: <20260427081953.364819-1-edumazet@google.com>
	<6e00eaa5-a4d7-45dd-9d90-fb319b76c9fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02C794AD829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid,networkplumber-org.20251104.gappssmtp.com:dkim]

On Thu, 30 Apr 2026 09:35:08 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 4/27/26 2:19 AM, Eric Dumazet wrote:
> > Some fflush() calls only make sense for monitor programs.
> > 
> > For other cases, forcing a flush is expensive.
> > 
> > After this patch, ip, tc and ss are correctly buffering most of their
> > output when redirected to a file.
> > 
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/utils.h  |  7 +++++++
> >  ip/ipaddress.c   | 12 +++++++-----
> >  ip/iplink.c      |  4 ++--
> >  ip/ipmonitor.c   |  1 +
> >  ip/ipmptcp.c     | 10 +++++-----
> >  ip/ipneigh.c     |  4 ++--
> >  ip/ipnetconf.c   |  2 +-
> >  ip/ipnetns.c     |  2 +-
> >  ip/ipnexthop.c   | 12 ++++++------
> >  ip/iproute.c     |  4 ++--
> >  ip/iprule.c      |  2 +-
> >  ip/iptoken.c     |  2 +-
> >  ip/tcp_metrics.c |  2 +-
> >  lib/utils.c      |  1 +
> >  misc/ss.c        |  3 ++-
> >  tc/tc_class.c    |  2 +-
> >  tc/tc_filter.c   |  2 +-
> >  tc/tc_monitor.c  |  1 +
> >  tc/tc_qdisc.c    |  2 +-
> >  19 files changed, 44 insertions(+), 31 deletions(-)
> >   
> 
> no longer applies after merging main to next.
> 

I put the other version in iproute2 since wanted to test and it
did not depend on any later kernel changes

