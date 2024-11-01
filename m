Return-Path: <netdev+bounces-141091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176169B9742
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEFFB211E4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB21CDA27;
	Fri,  1 Nov 2024 18:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F314F132;
	Fri,  1 Nov 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485117; cv=none; b=URv+aEQR/hWtVuRcGC89GwKYMiWg6QeUNg2DNyuHI+fRr/4zDgazTaaSQDAIgc/NgSmTZCARfkfKmMZdW7hq2Ais/1fRD0VU84qeLPWgD8pSNDQ9HLTE/kBjNGxSRdA6FFnLR6rp9KqO9DMHUFSZFqo4AvkjOaOY5bdoyc4Cxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485117; c=relaxed/simple;
	bh=rp5ZouIQfP4PRaaX4NYqHmAXKb3TRtFuzfWpt6SAQX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ7XrGyfNL5W2SzgO82ys6WJq/rWFKfhpGb0zqcF9bnzVnMVCEzJPoABhKcl1sTIBdWyZES7E5EZ3aEVpomarIA8TDpqObBsGCz1Nlp1uEc1AdKCeYf8LKHwzfbSbYQErsxZ/c13Tmi3zdy/s7MrVs1iG1VCZaPQk4HWM3zSjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f8490856so2416426e87.2;
        Fri, 01 Nov 2024 11:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485113; x=1731089913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+x+swhfU93hRI3h78UCPOELgbvo7wYFfk9WP+jVDLo=;
        b=rX9mpieMeNiY6AMf/ZveDK7/cwD063Bc+ebBtgj30YZOG3pGDigtxpXT72k2b091C+
         itZxwsHcQWQ+lOPWellmW8oqdpixETbjVhZs1QFHTM/KX1MMRT+Tnvm21DcBKua99D2T
         1LS5lnj5m8ttiTp2F7hVTJ0iPIeB5GLsrZzSXjI63J0yC6MXbFtd/gtlJGnhtYk4OL7F
         TcRgrqtAltPWpF+wjXn5m9Xo6KUzpEgs+04qSDFj2lQ9dyf0ZPAKq94KMg6/rHgUP2Jd
         fBRopWIUDNyCO8k8GzFX8xY1+93yi7fRbx4H2FGCx3PorZGO/6heWVYJagSitWbNYRTB
         OfKA==
X-Forwarded-Encrypted: i=1; AJvYcCVplyqQ51m4f0Pk1bzWnXbNGThQkJNakJ6OzG424QMo2RnUjLNrJoGoU+NDMrZYSc4g7bqYCURMpB078+8=@vger.kernel.org, AJvYcCW9KCtZkCjHJKDsjQUgNXulA9Kdk2SggBF8xR1DajadZ2c7Xmw4E/c2fS9LSKM6EF1ZKzlsgNAi@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0WCutjiN3PnUm5o7RSKjFFF+PgZkaSWAYrO7UlM9uPiAKqZI
	iIDRckNqnxCpbTMJKrEJOi3dr93c00FeFJw93RnVRcqNuTP+SN8+CIgB0g==
X-Google-Smtp-Source: AGHT+IETR8aBiN9iNaZpomelbXjCefG6qFLHlS1al0g1ANZBI4bV0KDJkCjwpkxenHshVzq74uSK2g==
X-Received: by 2002:a05:6512:b84:b0:536:55a9:4b6c with SMTP id 2adb3069b0e04-53c79e2f90amr4457731e87.13.1730485112611;
        Fri, 01 Nov 2024 11:18:32 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565dfaaasm212059066b.106.2024.11.01.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:18:32 -0700 (PDT)
Date: Fri, 1 Nov 2024 11:18:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	jiri@resnulli.us, jv@jvosburgh.net, andy@greyhouse.net,
	aehkn@xenhub.one, Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241101-prompt-carrot-hare-ff2aaa@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
 <20241025142025.3558051-2-leitao@debian.org>
 <20241031182647.3fbb2ac4@kernel.org>
 <20241101-cheerful-pretty-wapiti-d5f69e@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-cheerful-pretty-wapiti-d5f69e@leitao>

On Fri, Nov 01, 2024 at 03:51:59AM -0700, Breno Leitao wrote:
> Hello Jakub,
> 
> On Thu, Oct 31, 2024 at 06:26:47PM -0700, Jakub Kicinski wrote:
> > On Fri, 25 Oct 2024 07:20:18 -0700 Breno Leitao wrote:
> > > The current implementation has a flaw where it populates the skb_pool
> > > with 32 SKBs before calling __netpoll_setup(). If the setup fails, the
> > > skb_pool buffer will persist indefinitely and never be cleaned up.
> > > 
> > > This change moves the skb_pool population to after the successful
> > > completion of __netpoll_setup(), ensuring that the buffers are not
> > > unnecessarily retained. Additionally, this modification alleviates rtnl
> > > lock pressure by allowing the buffer filling to occur outside of the
> > > lock.
> > 
> > arguably if the setup succeeds there would now be a window of time
> > where np is active but pool is empty.
> 
> I am not convinced this is a problem. Given that netpoll_setup() is only
> called from netconsole.
> 
> In netconsole, a target is not enabled (as in sending packets) until the
> netconsole target is, in fact, enabled. (nt->enabled = true). Enabling
> the target(nt) only happen after netpoll_setup() returns successfully.
> 
> Example:
> 
> 	static void write_ext_msg(struct console *con, const char *msg,
> 				  unsigned int len)
> 	{
> 		...
> 		list_for_each_entry(nt, &target_list, list)
> 			if (nt->extended && nt->enabled && netif_running(nt->np.dev))
> 				send_ext_msg_udp(nt, msg, len);
> 
> So, back to your point, the netpoll interface will be up, but, not used
> at all.
> 
> On top of that, two other considerations:
> 
>  * If the netpoll target is used without the buffer, it is not a big
> deal, since refill_skbs() is called, independently if the pool is full
> or not. (Which is not ideal and I eventually want to improve it).
> 
> Anyway, this is how the code works today:
> 
> 
> 	void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
> 	{
> 		...
> 		skb = find_skb(np, total_len + np->dev->needed_tailroom,...
> 		// transmit the skb
> 		
> 
> 	static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
> 	{
> 		...
> 		refill_skbs(np);
> 		skb = alloc_skb(len, GFP_ATOMIC);
> 		if (!skb)
> 			skb = skb_dequeue(&np->skb_pool);
> 		...
> 		// return the skb
> 
> So, even in there is a transmission in-between enabling the netpoll
> target and not populating the pool (which is NOT the case in the code
> today), it would not be a problem, given that netpoll_send_udp() will
> call refill_skbs() anyway.
> 
> I have an in-development patch to improve it, by deferring this to a
> workthread, mainly because this whole allocation dance is done with a
> bunch of locks held, including printk/console lock.
> 
> I think that a best mechanism might be something like:
> 
>  * If find_skb() needs to consume from the pool (which is rare, only
> when alloc_skb() fails), raise workthread that tries to repopulate the
> pool in the background. 
> 
>  * Eventually avoid alloc_skb() first, and getting directly from the
>    pool first, if the pool is depleted, try to alloc_skb(GPF_ATOMIC).
>    This might make the code faster, but, I don't have data yet.

I've hacked this case (getting the skb from the pool first and refilling
it on a workqueue) today, and the performance is expressive.

I've tested sending 2k messages, and meassured the time it takes to
run `netpoll_send_udp`, which is the critical function in netpoll.

Actual code (with this patchset applied), where the index is
nanoseconds:

	[14K, 16K)           107 |@@@                                                 |
	[16K, 20K)          1757 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
	[20K, 24K)            59 |@                                                   |
	[24K, 28K)            35 |@                                                   |
	[28K, 32K)            35 |@                                                   |
	[32K, 40K)             5 |                                                    |
	[40K, 48K)             0 |                                                    |
	[48K, 56K)             0 |                                                    |
	[56K, 64K)             0 |                                                    |
	[64K, 80K)             1 |                                                    |
	[80K, 96K)             0 |                                                    |
	[96K, 112K)            1 |                                                    |


With the optimization applied, I get a solid win:

	[8K, 10K)             32 |@                                                   |
	[10K, 12K)           514 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
	[12K, 14K)           932 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
	[14K, 16K)           367 |@@@@@@@@@@@@@@@@@@@@                                |
	[16K, 20K)           102 |@@@@@                                               |
	[20K, 24K)            29 |@                                                   |
	[24K, 28K)            17 |                                                    |
	[28K, 32K)             1 |                                                    |
	[32K, 40K)             3 |                                                    |
	[40K, 48K)             0 |                                                    |
	[48K, 56K)             0 |                                                    |
	[56K, 64K)             1 |                                                    |
	[64K, 80K)             0 |                                                    |
	[80K, 96K)             1 |                                                    |
	[96K, 112K)            1 |                                                    |

That was captured this simple bpftrace script:

	kprobe:netpoll_send_udp {
	    @start[tid] = nsecs;
	}

	kretprobe:netpoll_send_udp /@start[tid]/ {
	    $duration = nsecs - @start[tid];
	    delete(@start[tid]);
	    @ = hist($duration, 2)
	}

	END
	{
		clear(@start);
		print(@);
	}

And this is the patch I am testing right now:


	commit 262de00e439e0708fadf5e4c2896837c046a325b
	Author: Breno Leitao <leitao@debian.org>
	Date:   Fri Nov 1 10:03:58 2024 -0700

	    netpoll: prioritize the skb from the pool.

	    Prioritize allocating SKBs from the pool over alloc_skb() to reduce
	    overhead in the critical path.

	    Move the pool refill operation to a worktask, allowing it to run
	    outside of the printk/console lock.

	    This change improves performance by minimizing the time spent in the
	    critical path filling and allocating skbs, reducing contention on the
	    printk/console lock.

	    Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
	index 77635b885c18..c81dc9cc0139 100644
	--- a/include/linux/netpoll.h
	+++ b/include/linux/netpoll.h
	@@ -33,6 +33,7 @@ struct netpoll {
		u16 local_port, remote_port;
		u8 remote_mac[ETH_ALEN];
		struct sk_buff_head skb_pool;
	+	struct work_struct work;
	 };

	 struct netpoll_info {
	diff --git a/net/core/netpoll.c b/net/core/netpoll.c
	index bf2064d689d5..657100393489 100644
	--- a/net/core/netpoll.c
	+++ b/net/core/netpoll.c
	@@ -278,18 +278,24 @@ static void zap_completion_queue(void)
		put_cpu_var(softnet_data);
	 }

	+
	+static void refill_skbs_wt(struct work_struct *work)
	+{
	+	struct netpoll *np = container_of(work, struct netpoll, work);
	+
	+	refill_skbs(np);
	+}
	+
	 static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
	 {
		int count = 0;
		struct sk_buff *skb;

		zap_completion_queue();
	-	refill_skbs(np);
	 repeat:
	-
	-	skb = alloc_skb(len, GFP_ATOMIC);
	+	skb = skb_dequeue(&np->skb_pool);
		if (!skb)
	-		skb = skb_dequeue(&np->skb_pool);
	+		skb = alloc_skb(len, GFP_ATOMIC);

		if (!skb) {
			if (++count < 10) {
	@@ -301,6 +307,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)

		refcount_set(&skb->users, 1);
		skb_reserve(skb, reserve);
	+	schedule_work(&np->work);
		return skb;
	 }

	@@ -780,6 +787,7 @@ int netpoll_setup(struct netpoll *np)

		/* fill up the skb queue */
		refill_skbs(np);
	+	INIT_WORK(&np->work, refill_skbs_wt);
		return 0;

	 put:



