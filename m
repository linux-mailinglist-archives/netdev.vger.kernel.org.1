Return-Path: <netdev+bounces-254465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGCoAUh9emlN7AEAu9opvQ
	(envelope-from <netdev+bounces-254465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:19:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CBBA90CD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3767F30166E6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1E3385A0;
	Wed, 28 Jan 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H6/Pt2QS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F832571F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635139; cv=none; b=Kxunrl6VwD4Far1kMr9t0Lv+1eR622ncmqUsOz/sTyYM6cNw5i5uQFYiiH8bgrQ/NBNHQRZ6El5eJDNf6UzEGY2EnOVYln2X8T2mdR6AmjCb5/DWKv8vVNdey8+ZYlt8qnMQmTx7boYO9WC5nUL5Q781Dsb/G9vGXEMg5bkQadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635139; c=relaxed/simple;
	bh=R26B82zxPcid0PkRJfA5J9VLBvvgfckzt4BZtC2Buu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr9NlOcJWzZFMLG8pdA3WenpTN07NNCAABeuFLG53f5i/8fSJpDDyJ7/ssSDdcgFMYBG0VgbSqyxV61wjoLGN/oBpN6SuWS4E0KRWWzyyfPjgmlzF49/mTnhNeyEMRbF65lgVUgtqvS0j8HYv+B8WDM7m7jI1C+6pEKTsVKQOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H6/Pt2QS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so2550905e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769635136; x=1770239936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW1Mn8hE3xrcR5j18KDZNCCnIS+/tf2Xt9JxG670/6k=;
        b=H6/Pt2QSJL40tHRjCnqTJlyeIJBSCnr6XIoN79q068X0MJU9XhocPvQi3HFIkZymOP
         p8kxmgBVkKuyGCdOTB6i9edsgCbEngNrTzpB+fJmWfV0QD5weM0n/jRnTPjP7dR8i0fd
         XPcJli/57tpaiplIsRRfu/P7GpWnWHZ7UOuoOtvXdjd8lOWeFXblOPmGyTJgQGpUDdVX
         TjBp17TAhFz4dhaYtX7FHH3TO+d7uWcui8ah2wAxjnHEdJf2DAaU243XGNDazfe4iT80
         ZPl523HaMWYMdHiUL4T38lxBoNV59O7P5kaPK3MmoGwSuq7gWlGhXbmGHaRcqptdF3co
         lYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635136; x=1770239936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW1Mn8hE3xrcR5j18KDZNCCnIS+/tf2Xt9JxG670/6k=;
        b=lO80bZjVLE+ECUAbqoabkOL7Rjuwq73GTwxXUMkbt5rgm95JYC7tDg45OknpWJAsZi
         vsyAJ9jBjwp32081B2qM+niiL5c1tEMihlFh9hpyi11SOqc6wae3k7aCqDMJVlxmJ4vp
         kbvl6CxNL3/FZ3zKjwxtSPTyVPM3aHKhcFHjLfjBt+RnIQ2F4/Dm9jgY9QPk3JTjAFx+
         XMu48kZmJEHZ+K9YwNkZH3uYZ1EVbbtmyYMrcd+LUaJzyiIAkHPxCilO6kOma5o8V9PM
         pBxPookXGc6hjFW/czfvlmDbUtvVYmEaS9WkpDdfNRVPMTGnbSbpEwEZVUf3zEdyI+VQ
         Dz/w==
X-Forwarded-Encrypted: i=1; AJvYcCVk4qZnJXcryla9o2S6S00p9JJ25Y4SsVgKGvAWnXNkodU6SmcRzYO6s9Yzt7Zwf35ETmjlSJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QGNajeoDMUzRakKf94ROFfQYsmwRul2saO9tAlAGgGt/f9oo
	irXP/RMQqfRro2Zw5gAb0V2HYHrACOBWc+UdJgU8zVLxJH+SAnu2I/e0NRWcaQa6AbM=
X-Gm-Gg: AZuq6aKsTzLn5THrOcp4oH8sgPfY5W3uOKnfhbGd35iW3Wp29z6dtqjY3v/w1wioDNl
	QGbBr43WDbj5+6oKT8m3gPRdfXSkWUCsWfDm5Rm1bSndhNxiuUTULfhJxhZLZXeyOCzHMqKyu8t
	8KQt4VkGGeOgTva0Lt1xVCF/YcMgSow3+hrvDlFpCscKw9T81ebfb1wS9J2ser77II3TSENcFmS
	ydY5JeYcX5+jGvKaDy1nOIgQ0zURLzu3PXUe8+JV6wAJtEjaze05AtkoYdkyA4duoULNC2s8WlS
	wMrl6Z0OqRtqX16qZSnq4xs1Lo8wyzw0cSo5ft9zNGGzJGICPsCibaggntRf/SUYyw1GenFVoze
	qsEpZtBsSRbG0/iIaMwbVgggCPezY5VMqCNlmqhME17Sk5Dd02AB1Ou83cBY3NK31wpUROfYtoB
	qkflUtacR9qhNcKwue1T3spArb
X-Received: by 2002:a05:600c:3e16:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-48069c10f78mr74663935e9.8.1769635136165;
        Wed, 28 Jan 2026 13:18:56 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d78cb6csm3510525e9.2.2026.01.28.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:18:55 -0800 (PST)
Date: Wed, 28 Jan 2026 22:18:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 04/33] mm: vmstat: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXp9Pp4YvlbJumeY@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125224541.50226-5-frederic@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254465-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67CBBA90CD
X-Rspamd-Action: no action

On Sun 25-01-26 23:45:11, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against vmstat workqueue to make sure
> that no asynchronous vmstat work is pending or executing on a newly made
> isolated CPU, target and queue a vmstat work under the same RCU read
> side critical section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmstat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 65de88cdf40e..ed19c0d42de6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2144,11 +2144,13 @@ static void vmstat_shepherd(struct work_struct *w)
>  		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
>  		 * for all isolated CPUs to avoid interference with the isolated workload.
>  		 */
> -		if (cpu_is_isolated(cpu))
> -			continue;
> +		scoped_guard(rcu) {
> +			if (cpu_is_isolated(cpu))
> +				continue;
>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> -			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +			if (!delayed_work_pending(dw) && need_update(cpu))
> +				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +		}
>  
>  		cond_resched();
>  	}
> -- 
> 2.51.1
> 

-- 
Michal Hocko
SUSE Labs

