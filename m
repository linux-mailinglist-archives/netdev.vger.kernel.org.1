Return-Path: <netdev+bounces-112385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D1938C70
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CF72845DC
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DDF16D301;
	Mon, 22 Jul 2024 09:45:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ADB16CD1C;
	Mon, 22 Jul 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641505; cv=none; b=THrzRZMZ0xi7k/HfXxeJ0G1p1nc0FobQjyWC9O6D9a6eYI9V8M4vvtVSxVG1BiAF4dfhi5LtcFO1h1nq9rklME24BgVk8oy9CSmH9HyBlfeHZNV4pj4SQh6BUAOwLMjZffwsCpcK+yT/gPsxNI+X+/keAQV+pqVG0qv+9KjCH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641505; c=relaxed/simple;
	bh=1g2d5q1Q7bi70ZFX/boaMrq4aTqtzniQBGMEhshUuWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsVT7PjBx1fzUUhC13lQd30+mAu9TDqhZlXxQ/I8tklV9+OeyxPux4C6QPUco2UJ4E5MHmIWdAfhk0lGNrN0swe4HOWcX0RQHF7eKB4d4KrLRyfCoGDaiip+yBhlyrLRQfOkfhLIGtH889IQA6GjRc2wVIT8t9QjE9E1Bdcsn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so1135258e87.0;
        Mon, 22 Jul 2024 02:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721641501; x=1722246301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqSAPXeU7//xQzF5D3KvNuPxtZjwj+8S9xO2DCeCvNQ=;
        b=jiLzaJOqJK0srlCJhTHLe/zhpI3XwHTEEPE1QNksGPM1Ca5OsoWP/wjRt0JlupCd5q
         HklvX3BPxMpUAZlMU67br13N0mQDvUDIXvDQIsz3RW/9QseU/3kBRQuTuy6szuTpOE02
         E2E7KS49N0OasBD4ydXfsfWu7zvFZEOuek4fVpCXYfimsOn9DFM6Cfpkola4vMKzlP0B
         EEFs3rrknJUDMEW+ZX3+zxZwC2EMRkPadVTPnfpDtHvrKdG+4eszWtRYIDaRzxLUl9gl
         K9BeCDZEA9WnIAKw9rF/3rsXpBGcWeLt3wE/j5FLy1JkSqc3SD5QFBJ1ZzBMtSdlylhR
         LGdg==
X-Forwarded-Encrypted: i=1; AJvYcCUhUD65Ja/n1J8YGZaMYanJsJyn535gNfQweUzJRBzcRxZicAJdwezKj0bKWQ8l2DZzxQYmcKG1Gq13lsan3kHrPNH1e+Pufd1keCkN1TgSBo9OpD8G5BDTDjx6gEiPIUeXCoY+
X-Gm-Message-State: AOJu0YxnD6lqu9tgG8AJhAlDEo9SvHLyE/4toZPR3fuq876W/9uiRKev
	QypJ2QJImbcz+lCOZ4zjsEHYv96I5VcZl4/0VRYR4iy2X/Gq6MJ+
X-Google-Smtp-Source: AGHT+IGK+uXHXqFkBqoNCUoaMd5o2qIhNCPmbjmyQLSs9GFkgwdEOtcvBDBx1xDF9P5TVdSlKYR3pA==
X-Received: by 2002:a05:6512:3409:b0:52e:976a:b34b with SMTP id 2adb3069b0e04-52efb53bcc4mr4181809e87.15.1721641500332;
        Mon, 22 Jul 2024 02:45:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c951212sm397529766b.208.2024.07.22.02.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:45:00 -0700 (PDT)
Date: Mon, 22 Jul 2024 02:44:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Rik van Riel <riel@surriel.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, davej@codemonkey.org.uk
Subject: Re: [RFC PATCH 2/2] netconsole: Defer netpoll cleanup to avoid lock
 release during list traversal
Message-ID: <Zp4qGdGk7vLJaCPs@gmail.com>
References: <20240718184311.3950526-1-leitao@debian.org>
 <20240718184311.3950526-3-leitao@debian.org>
 <5145c46c47d98d917c8ef1401cdac15fc5f8b638.camel@surriel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5145c46c47d98d917c8ef1401cdac15fc5f8b638.camel@surriel.com>

Hello Rik,

On Thu, Jul 18, 2024 at 03:53:54PM -0400, Rik van Riel wrote:
> On Thu, 2024-07-18 at 11:43 -0700, Breno Leitao wrote:
> > 
> > +/* Clean up every target in the cleanup_list and move the clean
> > targets back to the
> > + * main target_list.
> > + */
> > +static void netconsole_process_cleanups_core(void)
> > +{
> > +	struct netconsole_target *nt, *tmp;
> > +	unsigned long flags;
> > +
> > +	/* The cleanup needs RTNL locked */
> > +	ASSERT_RTNL();
> > +
> > +	mutex_lock(&target_cleanup_list_lock);
> > +	list_for_each_entry_safe(nt, tmp, &target_cleanup_list,
> > list) {
> > +		/* all entries in the cleanup_list needs to be
> > disabled */
> > +		WARN_ON_ONCE(nt->enabled);
> > +		do_netpoll_cleanup(&nt->np);
> > +		/* moved the cleaned target to target_list. Need to
> > hold both locks */
> > +		spin_lock_irqsave(&target_list_lock, flags);
> > +		list_move(&nt->list, &target_list);
> > +		spin_unlock_irqrestore(&target_list_lock, flags);
> > +	}
> > +	WARN_ON_ONCE(!list_empty(&target_cleanup_list));
> > +	mutex_unlock(&target_cleanup_list_lock);
> > +}
> > +
> > +/* Do the list cleanup with the rtnl lock hold */
> > +static void netconsole_process_cleanups(void)
> > +{
> > +	rtnl_lock();
> > +	netconsole_process_cleanups_core();
> > +	rtnl_unlock();
> > +}
> > 

First of all, thanks for reviewing this patch.

> I've got what may be a dumb question.
> 
> If the traversal of the target_cleanup_list happens under
> the rtnl_lock, why do you need a new lock.

Because the lock protect the target_cleanup_list list, and in some
cases, the list is accessed outside of the region that holds the `rtnl`
locks.

For instance, enabled_store() is a function that is called from
user space (through confifs). This function needs to populate
target_cleanup_list (for targets that are being disabled). This
code path does NOT has rtnl at all.

> and why is there
> a wrapper function that only takes this one lock, and then
> calls the other function?

I assume that the network cleanup needs to hold rtnl, since  it is going
to release a network interface. Thus, __netpoll_cleanup() needs to be
called protected by rtnl lock.

That said, netconsole calls `__netpoll_cleanup()` indirectly through 2
different code paths.

	1) From enabled_store() -- userspace disabling the interface from
	   configfs.
		* This code path does not have `rtnl` held, thus, it needs
		  to be held along the way.

	2) From netconsole_netdev_event() -- A network event callback
		* This function is called with `rtnl` held, thus, no
		  need to acquire it anymore.


> Are you planning a user of netconsole_process_cleanups_core()
> that already holds the rtnl_lock and should not use this
> wrapper?

In fact, this patch is already using it today. See its invocation from
netconsole_netdev_event().

> Also, the comment does not explain why the rtnl_lock is held.
> We can see that it grabs it, but not why. It would be nice to
> have that in the comment.

Agree. I will add this comment in my changes.

Thank you!
--breno

