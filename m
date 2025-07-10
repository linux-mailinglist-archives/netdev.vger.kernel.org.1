Return-Path: <netdev+bounces-205824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69864B004BF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A7E48664F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D9270EB2;
	Thu, 10 Jul 2025 14:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FD27056D;
	Thu, 10 Jul 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156377; cv=none; b=LYUM5M6JpxxRA0tNRx9OFdeXcEldiGClT2qyky916FScc5oipH6xfImvpDKocJVJHt1Tw0XuN/QC3t9vDvnAXiwv1Aygbu+xc2MPWxfgrm950LS4l/1QZMvbATp5VpB7axvflRgDqmExqN8j6e0Y6lx6MKeu+V/I4zAGH4jlZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156377; c=relaxed/simple;
	bh=yA/I0gJM/OKVOhc8b6C9blaRbMv2JfyPFC62inigLKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDwrLKHHMH6IsmQmCckgNjgkywuVjlhiJlDQ+y88stPsYs/29sH1vUrgheL/zdXttr3weI/1U5a9ZL5QjvUDcSAMkE4xJKSYXMyjoUvbVBSFPr4sfOP4916CqF5QAQfOmrpKqzh+Qd0nmWdxSE7PfbUuBi/nsKHMqm0UM6hkOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so1611487a12.2;
        Thu, 10 Jul 2025 07:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752156374; x=1752761174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6racAcJNW4RKgIaC4lIcLewARYRmDGKH6RcAriCOozU=;
        b=lI5H0z10XAJ/q7X0MsktC3rlqEgbOc5zjkafj7tKtCg7byC9BUefysO4Y3Q+5LD1EZ
         O5VUWJoZO+cpUgYaasMfzpKlpwicNhihES9nT6d3uAAA/cWasgmrjevPXP4mIpdowRnH
         YDGzNanA6AxF4mg5HTN6dHdazGofhqM92gj9yUUFeD9uMYlsu2ra6rhQ/tHP76JKNahT
         k8GTLklqur4M8pmYa9YcL+U0xakqrtC0cQ5cdK32eNgXSXH6IROBT97+4eRBqPwUM92j
         E2V9DXfVL034NoFNRvZsFkoEbL+7904DqgqobwuAhS7KFZ779wARXak8tNfVsyrKcVCZ
         goeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvdf0Fw6Ytv3wk1jvBB2XVqHPQ9I/VKg8fT285tZQGikrfYLh6L/C1HyIMfOGDvwIidDSX@vger.kernel.org, AJvYcCW4qGq/vJH2T/UH5Y8JwbfdhTTTpIZlx0ddXnzQgQ8n4vTPMYKWNhXRWfpa9H5gK6nV0OaD2/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86B3UtI2tWRqAf/PQt8TisP6opqAjfMz8rcr6h51sRb0cWu3o
	9K9Cb/29rqRGcI85xJGlTy4uEHEpw24zJTO9pMgfjokvpYFjZ+Kch9qC
X-Gm-Gg: ASbGncv64aTezFhSrTGgAooBMKYkPnYlDtyzNeHQM0RaSvwnC5Y2Pp9ETPDYITC3jH4
	U8+Bp+796LU+AoBEWQus5mdVSBdbG8QmAEnRYlpOf03WNM62tt429QqPgSU59hAFCjkS2Q53xun
	v5A/B2vOdQehFny6VjRJHAWVqDE1nwS+JcG6VAA6GfzNMgyJYSlKINGrqur4VRQHNgOgIwKGIf0
	lKshlx8vFWk7v42EgiRaclKIqYzY9KqVWjvmO9jud/hgSiSAhCAItVIeCPceIqou3+rLSJDsiZJ
	rv5GzPWhXcZdptaLib3KtEIyHxficZYZh6z0wj9sBQEaSS4eTHT8
X-Google-Smtp-Source: AGHT+IFmVAxl1c+wDjcDDTe+BiajHbN+l+Z6s7GZDC3h8YpwVObUutZTnP3nnWaOqw2omJw6WNqiMQ==
X-Received: by 2002:a05:6402:1f46:b0:602:36ce:d0e7 with SMTP id 4fb4d7f45d1cf-611c84d65d3mr2307951a12.14.1752156373710;
        Thu, 10 Jul 2025 07:06:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9524072sm927420a12.20.2025.07.10.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:06:13 -0700 (PDT)
Date: Thu, 10 Jul 2025 07:06:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	lkmm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, aeh@meta.com, netdev@vger.kernel.org, edumazet@google.com, 
	jhs@mojatatu.com, kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 8/8] locking/lockdep: Use shazptr to protect the key
 hashlist
Message-ID: <i3mukc6vgwrp3cy5eis2inyms7f5b4a6pel4cvvdx6jlxrij2g@wgrnkstlifv3>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-9-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625031101.12555-9-boqun.feng@gmail.com>

Hello Boqun,

On Tue, Jun 24, 2025 at 08:11:01PM -0700, Boqun Feng wrote:
> Erik Lundgren and Breno Leitao reported [1] a case where
> lockdep_unregister_key() can be called from time critical code pathes
> where rntl_lock() may be held. And the synchronize_rcu() in it can slow
> down operations such as using tc to replace a qdisc in a network device.
> 
> In fact the synchronize_rcu() in lockdep_unregister_key() is to wait for
> all is_dynamic_key() callers to finish so that removing a key from the
> key hashlist, and we can use shazptr to protect the hashlist as well.
> 
> Compared to the proposed solution which replaces synchronize_rcu() with
> synchronize_rcu_expedited(), using shazptr here can achieve the
> same/better synchronization time without the need to send IPI. Hence use
> shazptr here.
> 
> Reported-by: Erik Lundgren <elundgren@meta.com>
> Reported-by: Breno Leitao <leitao@debian.org>
> Link: https://lore.kernel.org/all/20250321-lockdep-v1-1-78b732d195fb@debian.org/ [1]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

First of all, thanks for working to fix the origianl issue. I've been
able to test this in my host, and the gain is impressive.

Before:

         # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
         real    0m13.195s
         user    0m0.001s
         sys     0m2.746s
	
With your patch:

	#  time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
	real	0m0.135s
	user	0m0.002s
	sys	0m0.116s

	#  time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
	real	0m0.127s
	user	0m0.001s
	sys	0m0.112s

Please add the following to the series:

Tested-by: Breno Leitao <leitao@debian.org>

