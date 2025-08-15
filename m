Return-Path: <netdev+bounces-214121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC925B28514
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB87B5625DE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D431158F;
	Fri, 15 Aug 2025 17:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEEB310659;
	Fri, 15 Aug 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278946; cv=none; b=gGwZI1sz8+UWE488VhoxwjGHEmNXz8B3bRXHse7aN0V8DATWTpHZexbE85Dn48OAIuVRro9I81vyn0Px7Hwa6B1cJI5M7UHpa86zrpvA9EbnF7tPJuxpw67Rta9dWt4sJpLjslsotWPQXeH04pNeTfHC93K46FvfioCO7Q1AuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278946; c=relaxed/simple;
	bh=zPE0BwiWcsCBLDGiGu9+tzW5QyV0y6NSps2QWgJakeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiPXkckEBiNfAUCPkPsWJBfndfQ792fagiiuTcvMzfQRDli48WKEeNbMijpgBHiHYEFII1YWps2+yQpcCWsMfEz4ZT9UiKs5FUfQS+8p7UB0Ay8S66EJi9ZMdZfOg9A/cSZxux54ByNOmprS1yuf4r/ZG42rwaN4iZh31ajqToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b7949f6so4282755a12.3;
        Fri, 15 Aug 2025 10:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755278943; x=1755883743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZgPCKk/G6zEWeVJtk/ASmzqqce4JADX4N70XQavqkQ=;
        b=EqjyFie3xQrCL9ERZPpCrTCGYWJ3Cl5bMHP4wsSL5o85Xr2Urj4sO7XD/Xu2DqTsly
         2XdacnoixXhfpikepnjOCqCPxftdN2CadAqwaF3rBmmxjVURvZnBAVfin+/1V79B7LHt
         SGHLswpvYPMntYbwS9Ihm1ZKxtfUtBTnB+y2WvaR5LMSXWEq5WVwIRslXSe2ZBULmYqh
         R8sxQIA62ZBO/poRwSPrJOXlCkIhnNcfhJUXktrEvKfwRGbj6MXAnmbLUJ37aWg1f53T
         miD53WRshoTRbinhDbQC/PGj8uqwnUj1r2wcd5YURVhMGR/ZT3ntXon4nGt39jUHIoul
         pCYw==
X-Forwarded-Encrypted: i=1; AJvYcCVmBQLe89cOgxPAqhBJtHbmUBq84QaatRg4IkXJJ7EOukYjnWJzFGW19SF8i87czGihjOea68o8@vger.kernel.org, AJvYcCW+p4xTFwwkfR/i780bqXTb8hKgCbVzaEYU/5PRFaVtuG4vpBCW1x5TjckcRSXItxVTgr75SuQZ45Ajs24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBs1TUE1o4sS6ld8AHqbY5IHVTSZes+hY5TVBVHBkePzZ1Xm6
	w3uG8gakanAGqmE1+xpR2xKFid059T6qPfHKvZyo/G7dGOSB8wore9qb
X-Gm-Gg: ASbGncvaj4PPFAQfTGpzwcxQ7KVLZtZmyfIpe+N8ghGwWYtEHDkAWNWD2Iz0/ORKwsd
	1bWo7oBne34G5LgQPMAzpRUYN6R7uvtSAbXUkl9Pxz4ATHe1sZvr/lK7fRFJ5hcZmUpn30kA4gX
	wHi8YgEXJC5O/8rO+x6j9KMN+Mdp3S5TdWeMUbc9xSmD775oyrhUcHaK1yvz3rEemNPh3Nvvpmu
	2GpUH2mdCcerDCVE7S7wIUvgYWRr8cZyPOIURB3g/7cyYW27Upc1Tqcyr5/m3fy1rfC0FFjZ9cW
	JrAVApP10XIXSfCpsvmjLS3S+0OOwR7WVOkAoSbmhMssb+Q1WGbLhdvdvMAbzSB7f6NgD0SyFbA
	fJF3QDd/nnZoA3pScCcItZIjRx2zKkXX6Pg==
X-Google-Smtp-Source: AGHT+IGvVHQ5IvbO8v1pTkOOvzQo0J6+0Wz1rwsusVD8gUeMNY/qKMdX3C6J4YCERD/lwhmm91QQ9Q==
X-Received: by 2002:a05:6402:5111:b0:615:6a10:f048 with SMTP id 4fb4d7f45d1cf-618b0752bbamr2178239a12.33.1755278942972;
        Fri, 15 Aug 2025 10:29:02 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae6b1sm1787874a12.33.2025.08.15.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:29:02 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:29:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Mike Galbraith <efault@gmx.de>, paulmck@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815094217.1cce7116@kernel.org>

On Fri, Aug 15, 2025 at 09:42:17AM -0700, Jakub Kicinski wrote:
> On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
> > On 8/15/25 01:23, Jakub Kicinski wrote:
> 
> I suspect disabling netconsole over WiFi may be the most sensible way out.

I believe we might be facing a similar issue with virtio-net.
Specifically, any network adapter where TX is not safe to use in IRQ
context encounters this problem.

If we want to keep netconsole enabled on all TX paths, a possible
solution is to defer the transmission work when netconsole is called
inside an IRQ.

The idea is that netconsole first checks if it is running in an IRQ
context using in_irq(). If so, it queues the skb without transmitting it
immediately and schedules deferred work to handle the transmission
later.

A rough implementation could be:

static void send_udp(struct netconsole_target *nt, const char *msg, int len) {

	/* get the SKB that is already populated, with all the headers
	 * and ready to be sent
	 */
	struct sk_buff = netpoll_get_skb(&nt->np, msg, len);

	if (in_irq()) {
		skb_queue_tail(&np->delayed_queue, skb);
		schedule_delayed_work(flush_delayed_queue, 0);
		return;
	}

	return __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
}

This approach does not require additional memory or extra data copying,
since copying from the printk buffer to the skb must be performed
regardless.

The main drawback is a slight delay for messages sent from within an IRQ
context, though I believe such cases are infrequent.

We could potentially also perform the flush from softirq context, which
would help reduce this latency further.

