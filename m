Return-Path: <netdev+bounces-248145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7AD0472D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39B393034301
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AC1F09A8;
	Thu,  8 Jan 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1gFAGZg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15151A9F94
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888407; cv=none; b=kg/1jEAUpEip17LLVsyNDQOBXwWU51XAIt1pn2hS/zIOQ1HcshgJMq5lUnzikLzicNxSHYYM3QTOQzJFSNkvGNpLFdbjW7VYfbGYUKshC6mPAIHBWY3BXLXriBQZZPDkoSesFw8wKdZBaKU8I0l2KnEUrQMig2eDzVGIcyE8ptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888407; c=relaxed/simple;
	bh=UegVCAwQ78YZhR1Wz6KfLUbuIxrTsfzJgNqJKWnP9uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCMMUlJfv7Px2I6S6+DOHkXn3rV20f3dlnaeQJKNSTSJAmQvrY0mBizMwJrdWc5CtbK6VmHj+o5AX/q4OoKZWlKNDBaRrf7gomTECbIF6a8JAuel1bRvbP1iHwQATgappfpubypEw7oZ1ycP8bEm/A6cQ1sJ6yhgB03RJXyk14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1gFAGZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0680FC116D0;
	Thu,  8 Jan 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888407;
	bh=UegVCAwQ78YZhR1Wz6KfLUbuIxrTsfzJgNqJKWnP9uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1gFAGZg8yRnN6ZmzH/jh5NecSqz7ZNHclabTB23bv6uw+m3zvT3Sz5v+uqEQuJ6Y
	 ZwuWRDkV3IKcwFZU28WtTENJ0+sqAuZUXjfKJgNQdXLuxhS6lK8YbXxjSNlnxtGMZw
	 ksbywVGyGn5hg3+JbrUn/reQZaNjmv2WjLjrABd9U0RY6daeLAOpufR4923R63V/S9
	 2fKQpSQ8FIVxtaDIys3r+mpT6YNJ9P2HDvl5vLT5BoCwSyTrNRDfjgW3UGUVs2niEY
	 LNHirU/FS3uqJ3fVvQfeeC7c6Eq5B/KNqOiFMQ3v6H2iHTwrYAltb33WQx57NVhYFi
	 wUvI1NdLXuAAw==
Date: Thu, 8 Jan 2026 08:06:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Message-ID: <20260108080646.14fb7d95@kernel.org>
In-Reply-To: <20260107192511.23d8e404@kernel.org>
References: <20260107110521.1aab55e9@kernel.org>
	<willemdebruijn.kernel.276cd2b2b0063@gmail.com>
	<20260107192511.23d8e404@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 19:25:11 -0800 Jakub Kicinski wrote:
> On Wed, 07 Jan 2026 19:19:53 -0500 Willem de Bruijn wrote:
> > 17 out of 20 happen in the first SND-USR calculation.
> > One representative example:
> > 
> >     # 7.11 [+0.00] test SND
> >     # 7.11 [+0.00]     USR: 1767443466 s 155019 us (seq=0, len=0)
> >     # 7.19 [+0.08] ERROR: 18600 us expected between 10000 and 18000
> >     # 7.19 [+0.00]     SND: 1767443466 s 173619 us (seq=0, len=10)  (USR +18599 us)
> >     # 7.20 [+0.00]     USR: 1767443466 s 243683 us (seq=0, len=0)
> >     # 7.27 [+0.07]     SND: 1767443466 s 253690 us (seq=1, len=10)  (USR +10006 us)
> >     # 7.27 [+0.00]     USR: 1767443466 s 323746 us (seq=0, len=0)
> >     # 7.35 [+0.08]     SND: 1767443466 s 333752 us (seq=2, len=10)  (USR +10006 us)
> >     # 7.35 [+0.00]     USR: 1767443466 s 403811 us (seq=0, len=0)
> >     # 7.43 [+0.08]     SND: 1767443466 s 413817 us (seq=3, len=10)  (USR +10006 us)
> >     # 7.43 [+0.00]     USR-SND: count=4, avg=12154 us, min=10006 us, max=18599 us  
> 
> Hm, that's the first kernel timestamp vs the timestamp in user space?
> I wonder if we could catch this by re-taking the user stamp after
> sendmsg() returns, if >1msec elapsed something is probably wrong 
> (we got scheduled out before having a chance to complete the send?)

How about:

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index 4b4bbc2ce5c9..abcec47ec2e6 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -215,6 +215,24 @@ static void print_timestamp_usr(void)
 	__print_timestamp("  USR", &ts_usr, 0, 0);
 }
 
+static void check_timestamp_usr(void)
+{
+	long long unsigned ts_delta_usec;
+	struct timespec now;
+
+	if (clock_gettime(CLOCK_REALTIME, &now))
+		error(1, errno, "clock_gettime");
+
+	ts_delta_usec = timespec_to_ns64(&now) - timespec_to_ns64(&ts_usr);
+	ts_delta_usec /= 1000;
+	if (ts_delta_usec > cfg_delay_tolerance_usec / 2) {
+		cfg_delay_tolerance_usec =
+			ts_delta_usec + cfg_delay_tolerance_usec / 2;
+		fprintf(stderr, "WARN: sendmsg() took %llu us, increasing delay tolerance to %d us\n",
+			ts_delta_usec, cfg_delay_tolerance_usec);
+	}
+}
+
 static void print_timestamp(struct scm_timestamping *tss, int tstype,
 			    int tskey, int payload_len)
 {
@@ -678,6 +696,8 @@ static void do_test(int family, unsigned int report_opt)
 		if (val != total_len)
 			error(1, errno, "send");
 
+		check_timestamp_usr();
+
 		/* wait for all errors to be queued, else ACKs arrive OOO */
 		if (cfg_sleep_usec)
 			usleep(cfg_sleep_usec);
-- 
2.52.0


