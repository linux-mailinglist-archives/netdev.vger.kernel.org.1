Return-Path: <netdev+bounces-248264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F304CD061FF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 453FC30188D9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75F330B3E;
	Thu,  8 Jan 2026 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfE19sPz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7E330B3B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904727; cv=none; b=CfjXEgypzzNwn6XH8WEF8KMeijUfgAcOKjfOBSzdBgwhzsz5HFlTar3XJ3NgfU90xX56AksfG9sFIB9UkQT+kIBvoTwDVxenrtCKgcRu7CBM4KxB2U8oPhsKc2enlID7/BnWD/dQ7YO327I9R2ewhATT0GM8R13Kiq6P3uUKYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904727; c=relaxed/simple;
	bh=5ZjvxkDLvPhcooWqFEYQ21cLCVc2ABU79CWDYm9N1I0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1tSc+J+hv4eBg+PuMtxu7o/3Kx8RFoq3rIMZY5IH4gpKzEfSETt7UYN/Sug/aZihRY0VkZzlpf45l2TzVsUOmRvMEWPMh7druQMKMrcCzJYvLU/BR51dsg/WRG77Ci9XNZBF9IGT/IXBqckFW9qs7VZZGLx19STX0qw8mWnVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfE19sPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBC0C16AAE;
	Thu,  8 Jan 2026 20:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767904726;
	bh=5ZjvxkDLvPhcooWqFEYQ21cLCVc2ABU79CWDYm9N1I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RfE19sPzUKt5MKzusTUf3VDtshiRGEr1OGsPo9vzsVIIEf9mmAK/idyKJMzZ2QLAg
	 GWo/Od7jn8pGsOiAv20TIMwRSopAYwqP3H087ULqbBo1Lx7Y4yOzoszAFuax5kby0K
	 NgU09BWQ7Csh8/46AMnWd4sqBeWyU9N8yQKywqzWpjGswDFztyT/XOjAugSaU3Kwnj
	 8yLbyl9KJggU02X7/g4nDbSUHESm/ciEHY3IVH5WGr1jvOnwiCEqrhGCVOmkOHPqcv
	 +5N35Hf2a3XjalEC4XuIVfHUz7kpDYXcS0AeAowZ1I48O6rF8y+vXllqT0vzbK+Ohz
	 q3lLeATQSF4Wg==
Date: Thu, 8 Jan 2026 12:38:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Message-ID: <20260108123845.7868cec4@kernel.org>
In-Reply-To: <willemdebruijn.kernel.58a32e438c@gmail.com>
References: <20260107110521.1aab55e9@kernel.org>
	<willemdebruijn.kernel.276cd2b2b0063@gmail.com>
	<20260107192511.23d8e404@kernel.org>
	<20260108080646.14fb7d95@kernel.org>
	<willemdebruijn.kernel.58a32e438c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 Jan 2026 14:02:15 -0500 Willem de Bruijn wrote:
> Increasing tolerance should work.
> 
> The current values are pragmatic choices to be so low as to minimize
> total test runtime, but high enough to avoid flakes. Well..
> 
> If increasing tolerance, we also need to increase the time the test
> waits for all notifications to arrive, cfg_sleep_usec.

To be clear the theory is that we got scheduled out between taking the
USR timestamp and sending the packet. But once the packet is in the
kernel it seems to flow, so AFAIU cfg_sleep_usec can remain untouched.

Thinking about it more - maybe what blocks us is the print? Maybe under
vng there's a non-trivial chance that a print to stderr ends up
blocking on serial and schedules us out? I mean maybe we should:

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index abcec47ec2e6..e2273fdff495 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -207,12 +207,10 @@ static void __print_timestamp(const char *name, struct timespec *cur,
        fprintf(stderr, "\n");
 }
 
-static void print_timestamp_usr(void)
+static void record_timestamp_usr(void)
 {
        if (clock_gettime(CLOCK_REALTIME, &ts_usr))
                error(1, errno, "clock_gettime");
-
-       __print_timestamp("  USR", &ts_usr, 0, 0);
 }
 
 static void check_timestamp_usr(void)
@@ -636,8 +634,6 @@ static void do_test(int family, unsigned int report_opt)
                        fill_header_udp(buf + off, family == PF_INET);
                }
 
-               print_timestamp_usr();
-
                iov.iov_base = buf;
                iov.iov_len = total_len;
 
@@ -692,10 +688,14 @@ static void do_test(int family, unsigned int report_opt)
 
                }
 
+               record_timestamp_usr();
                val = sendmsg(fd, &msg, 0);
                if (val != total_len)
                        error(1, errno, "send");
 
+               /* Avoid I/O between taking ts_usr and sendmsg() */
+               __print_timestamp("  USR", &ts_usr, 0, 0);
+
                check_timestamp_usr();
 
                /* wait for all errors to be queued, else ACKs arrive OOO */

> Since the majority of errors happen on the first measurement, I was
> thinking of a different approach of just taking that as a warm up
> measurement.
> 
> But I'd also like to poke some more to understand what makes that
> run stand out.

