Return-Path: <netdev+bounces-67745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2730844D99
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D89E28EFBA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02292163;
	Thu,  1 Feb 2024 00:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F8E374
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746083; cv=none; b=hQ6EqLrBsSrMhJOlDlmva+kqsGOtuL6QbhuOjMgK7cPvJA7RIMEL7d8IPFGiq4N7Scw9is0FDaBi0hapvnzGf+tmuzGwZUOyaNb7q/fNuSLj+37vc9mH+8qzyA+VBW34mqdxXYvpTMeRm3NfXy6QoA3Izlm5NwU1ixdoPSHpfBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746083; c=relaxed/simple;
	bh=38P365134+J9VPA+zhc8aLgUCIaPw0JB4YMCk+7cmFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJE+hka1j4h9CXtcv1QuRMoB3jCdYHr1H7qjk6e15eumwq1sIuMgd42A6MLSLAhkSJdoncjCb4ur/6OmuUMhbCVapaQ7w/Qz3ZyKEZVQ186ncLpbc2K3S+tvWxBpxeVaZrEq94/DtqvZsoBfEbA8D+2zhHgN3odwK3ED3ZpgwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c431c6c91so1844386d6.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746081; x=1707350881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrs2I23dhH0mTURdgAb5k5EfiOmRT2De1cDkKW/nTGE=;
        b=ia4g2f4CqpbeRe8gpbm83cP00J6T2uI9p2/LQweOzF/SHUbTG/Pq7tu7O3TpXGNoDw
         YuTm6WEvUU5K7WNMXzao84nC/tIPb2fdJJ8OaNakUZkKU8Hcf/Cp++70OuWzW0815AVN
         cGc0gmkD9zl7oRgc+woSzOBbQiCxVDftEYDmRaPpHw7hWDiXN5d3MNKUhwZxQZBmfZ67
         HpRbnwk5C56KWlk1vhzbONa+XgYK8ZSMS0KwsiWFwDju60VjOykIFf9m/RY/dhNAAf8H
         /VF1jRr+2l44+AuRSSrBSz5JJaW2Oxp4/FpH0iUg3jauiU9KcHYRhgoP1+YQ6w1giMuL
         NuVA==
X-Gm-Message-State: AOJu0YyGy4Y7WIEYBg7V0y9ZZbQG6xljPusTK2RcDXuFo60I9Ob8EI6e
	5AidFDprhB0PeIUT5uS2HsRnAzSE5fTyB4lctXovdAZxlH9mRoCFoWcr1Abjfw==
X-Google-Smtp-Source: AGHT+IEe3YqJohRcAR1VwoxJkrEhnRReH5b/r+upsva+yD3zxs9J8V7tz0UiYmRaCPklzW0kkC04PA==
X-Received: by 2002:a05:6214:4105:b0:68c:5d76:2ed7 with SMTP id kc5-20020a056214410500b0068c5d762ed7mr964043qvb.46.1706746081232;
        Wed, 31 Jan 2024 16:08:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXrW6E1QlCIEvdGVX53QLZt5ZxVN2lYtBdrwhU8x8EI350kfPWELndRJ9m3hjLrqF+OA/jmM3H433A6hI5canmqO5rNjU3V95LIVKL6r5bvMVucwZxjY7Wzn2rcDvGDRxumln2g6oX7csjzoMbiqW/eCVi5sErdBf16+SKQ8SY1sxd7+bPHOq0VAavE6BO5lo2F48H3ALmH8KxSXpUrjDb+z0hd0IBkZv5QxSXXm7wR9UfEyNOTJUBWCZ4cLl9NtY7aZLRhXZ0MWKYPYkznsLZg1emSIWIvH3Ve86QFjMtSR/nq29VR77c9OMtXj2RRM3nSay4IPh9wOmWV38a0pTd7XTaFvNETUlj+cs4k0igz3oC8gTNu2VEwG7nBTPlc+N2LOI/JiPsM51rCXhQvxizYKrDABHRCsJqH2yVYnuwFN8G6fbw6IDH1sa+Bnw==
Received: from localhost ([107.173.73.29])
        by smtp.gmail.com with ESMTPSA id pc4-20020a056214488400b0068c6d0c3f5esm265608qvb.58.2024.01.31.16.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:08:00 -0800 (PST)
Date: Wed, 31 Jan 2024 19:07:57 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com,
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org,
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <Zbrg3aRFkgS7XCFE@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>

On Wed, Jan 31 2024 at  6:19P -0500,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
> >
> > I don't know, so just did the dumb thing. If the caller always guarantees
> > that the work items are never queued at the same time, reusing is fine.
> 
> So the reason I thought it would be a good cleanup to introduce that
> "atomic" workqueue thing (now "bh") was that this case literally has a
> switch between "use tasklets' or "use workqueues".
> 
> So it's not even about "reusing" the workqueue, it's literally a
> matter of making it always just use workqueues, and the switch then
> becomes just *which* workqueue to use - system or bh.

DM generally always use dedicated workqueues instead of the system.

The dm-crypt tasklet's completion path did punt to the workqueue
otherwise there was use-after-free of the per-bio-data that included
the tasklet. And for verity there was fallback to workqueue if
tasklet-based verification failed. Didn't inspire confidence.

> In fact, I suspect there is very little reason ever to *not* just use
> the bh one, and even the switch could be removed.
>
> Because I think the only reason the "workqueue of tasklet" choice
> existed in the first place was that workqueues were the "proper" data
> structure, and the tasklet case was added later as a latency hack, and
> everybody knew that tasklets were deprecated.

Correct, abusing tasklets was a very contrived latency optimization.
Happy to see it all go away! (hindsight: it never should have gone in).

Mike

