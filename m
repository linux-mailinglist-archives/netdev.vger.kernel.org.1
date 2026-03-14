Return-Path: <netdev+bounces-267756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aj2oFQeEtWlv1QAAu9opvQ
	(envelope-from <netdev+bounces-267756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:51:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A349F28DBF3
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D56301FFAA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A71DD525;
	Sat, 14 Mar 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="g59SS0Tl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081CD8C1F
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773503492; cv=none; b=hHZSKoGccBRcxsO821lp6PRgSDdaeT4+Ca8QN+cWuTqdIHT+Au34GrQEYODr5fy1U/w+w8T4kC+/OKSHYLbrJ38j8YIDQb3jgwIRpKKk/JR9AV/NggVZXZ0gzUD4paV+oebIVILgQPQlG+asChaNHlHrIyyRz8k0gwVRzQ5d48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773503492; c=relaxed/simple;
	bh=Vz4KBAKp7S2fgkbp+iIuHclARYluKXtjq8ntt2mtgaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qINPCHu5JotSKhytqfwfIw2qpPAhtrmC1JXYBU1SxHbIekKmIx44L/svl4XjKvtwXdsLRkK4NuAgXKgDWbULOZV8gpYz2LfDec1LNX4m4VraxOF/DJ4nFirljUu0ajGbhvuMX9gaDPUnQ+e73XdDwxGD0KmIEZhVICf3iUvVUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=g59SS0Tl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c73fbdd9b53so69486a12.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773503490; x=1774108290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D07Z7V9MNfYO2AzIv9EBrR5rP0cZnLiLY3ziDWX26PQ=;
        b=g59SS0TlW2mJlSyD7M98eK0dI8niF/5l6HEwXDtT73NpsIlsKL+CnkEHBnzPZiptd8
         5yiiBIvHTY8pkWsuP7mx/7lz9ulHosLUlEMcEPgSjpTK9TndebYKpBoPSYpHtjhsqV1F
         rhyewrYyxfhljwU/Zj+xWvlP9OXh82V2hqgO32xL1kFgPuMJdIMpqNL2RjjpwXeYhNZH
         4cYhrufVBhDxm55THziR34/SBmpPpih1j72KXhv8+TOLFZAR2YEUe10F7qYWa6vpHWKW
         HbQyk1Uy46p4HegnDMeeASSnKKcaICmp93g3HcwWKdRu7rbE1znIFt6hVv8vdZvEWWti
         CyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773503490; x=1774108290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D07Z7V9MNfYO2AzIv9EBrR5rP0cZnLiLY3ziDWX26PQ=;
        b=ULRwmF8rP4rwQEv0titNvLYaPAUjeE0ZVIvGWAXUp3yi3abpBMJLasaUKJoMJ7fUOX
         s0IAPuKKqJT204StIPhtQvzskSjZXL+8bg7Y4QYfLdzwrbqzmTTetZTNyI+v3jHZKTz9
         oarU8qTArIzvPHC4Q23SU7eBalO7KgXN/7DMj3mJy4B19J+QQVeIsZ7U8q6ZNJwYjnHi
         snZAttERI6Iqx3jmB/xhvqsJwAWGC4RZPxFEI6z2hYPKIM/fJxfEvafpX6vbK4edIjrS
         f0zT1o4tRcPouMUYKKYibBwHSYOb883yUcbcuCNHRxigHZujwp+V0NOQPhj48jPQQJxF
         0/mA==
X-Gm-Message-State: AOJu0YxecJKxEIcIadmwc+eTUGFYuXEAveuWlU5RTMfraUOMR22pThIa
	0wmjyhBLtyyHRPX0+9U3lKLhy+/4gejxbv6gfrqb0t1nXcrr0KixcxCK2yW5aZGS7JWgDy9kcW2
	AD6zp
X-Gm-Gg: ATEYQzxI9LrcXC02IPNI2WVjfr3cSlPB8DxmF1Araj8/tCaK+bzYpn0Jj2Vqc3IxusC
	gNbOdh2hj7/aDEIoBFVhvR+PKZTTn4joP+o1lrHyqIL94QupeGBMAJfekUX+I5LbPt5cooA0joE
	IZkr5MXamYd+tLkg5xVuUYIWzdFvymSk2EWx3nQPtPwkmUH9IDCYNL2CJEOJwxiR82tdil5b95W
	R5YavtAtmOcHYfv29Hfi9n8BzjenYB18e41RkaO/BGGLutUQ4OiwMpkjXxH8cwWDjznSVmuSvOY
	nB/owApEYpVgTfk94m8NwHhyfiwScu0xo7tR3LCiNv+ca/rLV150S1NDPEXxlCO7CK6fXkBhfj9
	nt8RAAviMz/kovM0kd9uUmgPBMzDjJscja6Q4LLlD5wmDrvX2CUbqYxFASiHMwQyKh41uOY6KIn
	Ztd92hg/OrkmKrbBn8pJFqRz1ZRyLI+lq+xzY=
X-Received: by 2002:a17:902:ebcd:b0:2ae:4d93:ba36 with SMTP id d9443c01a7336-2aeca95946fmr71163845ad.11.1773503490276;
        Sat, 14 Mar 2026 08:51:30 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece838d3fsm76466955ad.77.2026.03.14.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 08:51:30 -0700 (PDT)
Date: Sat, 14 Mar 2026 08:51:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] netem: fixes, cleanup, and selftest
Message-ID: <20260314085123.52203ca4@phoenix.local>
In-Reply-To: <20260314070902.4025c388@kernel.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
	<20260314070902.4025c388@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267756-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim,phoenix.local:mid]
X-Rspamd-Queue-Id: A349F28DBF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 07:09:02 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 13 Mar 2026 14:15:00 -0700 Stephen Hemminger wrote:
> > The netem packet scheduler is widely used for network emulation but
> > has not gotten enough of my attention lately.  
> 
> There's a few tests in tdcs which need adjusting:
> 
> # not ok 363 d34d - NETEM test qdisc duplication restriction in qdisc tree in netem_change root
> # Command exited with 0, expected 2
> # 
> # not ok 364 b33f - NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root
> # Command exited with 0, expected 2
> # 
> # not ok 365 cafe - NETEM test qdisc duplication restriction in qdisc tree
> # Command exited with 0, expected 2
> # 
> # not ok 366 1337 - NETEM test qdisc duplication restriction in qdisc tree across branches
> # Command exited with 0, expected 2

I have a basic infrastructure question about testing.
Some of the new tests can just go in tdc they are just equivalent
functional test in different format.

But some of the traffic tests where it wants to make sure
that delay, clobber, etc are working don't really fit into tdc
which is API test.

And lastly some of the new tests are designed to ensure that
there is no regression from recursion bugs. Is it ok to have
a test which might lock up the SUT. I assume syszbot does that
all the time.

How about I move the the basic "can you run these tc commands"
into netem.json and leave the shell script for the traffic and
regression tests?

