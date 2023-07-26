Return-Path: <netdev+bounces-21208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B660762D44
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC11C208CD
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5C58825;
	Wed, 26 Jul 2023 07:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE78F52
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:26:11 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9CF3A89
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:26:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666ecf9a081so5903725b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1690356367; x=1690961167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+zeJUC9bLKU1rvuVX6lYw88hUmzqKAeHPtzffozeycY=;
        b=tq09HWgUpDUq6byqrA2ODCQvkmm9az77yWJFeqeVMy0FdFbQydZS+cUOs64uJ2SB3t
         JVe6zLPb5fssr5t5MVQUOU3aAgE6xxOU2jteEAzPtsSb8VWd+wB8OkrdKfGE1jZhlj5w
         TjyyAjaB4CZbrKROQT36TogKeOKjWN45v44UiK/0cxwlhI07RMRGs/cyjwVDCOvRwded
         lUKql7WZYCe6f5lQSR03cISDY6tgj5wgcwRkwmI723xyLURdjFU3QXYzRwiEbnZzpb+Y
         l5EpmyZiiiT3lVpIPopVTNPz1HtZxyTgaW+3XYB75cUNHtZ/C6Tv2cVXxlw6MGh6VRdH
         zVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356367; x=1690961167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zeJUC9bLKU1rvuVX6lYw88hUmzqKAeHPtzffozeycY=;
        b=dYW07YrJaH3jIvoybAKXmyngL1zCBKUuRneMxT+4u/LxhbiF3QZ7h1UH1wXXt5YwCH
         FyAj6c5KTPpj8W84Nt1AJWfd/MmdTc4JpghHeXr5V5ftQcIUWvBJWfds4ZgXuvXdLj0o
         HLnbe96S7harLaIZFsy5986f3TEzWuBPVuhbOYEvfZJGXSbHRrPolcPg0aP2Qa0vCZQq
         YWaJXPokPHudbirZB6anR0N13tlaByMTR2syedX6gmcj+P6krQCEbC4KMcRq6jiJqtJv
         fclC2awuGU5al7FRsI64pvX3IPQBG3CUbInbI21n/N9vRnry6K1dPL3z7uQwB8hrKd0y
         TuQQ==
X-Gm-Message-State: ABy/qLZTI2dQ97+MCldHMFvQkIcBqdViuICX4HdZONLvOUX13KhnOGqu
	d0msi2RVSn6OTJCayhE5wyqvCQ==
X-Google-Smtp-Source: APBJJlH5b0OufxURLtAQUAf05ozn4hmRBD/Qn/v7OHyNHGefhP7kmXIN/eqXKV4z4NaYW1ZZNRUFVA==
X-Received: by 2002:a05:6a00:a0d:b0:67a:a906:9edb with SMTP id p13-20020a056a000a0d00b0067aa9069edbmr1921084pfh.30.1690356367307;
        Wed, 26 Jul 2023 00:26:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id r5-20020a62e405000000b00666e649ca46sm10751809pfh.101.2023.07.26.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:26:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qOYuK-00AfFC-0I;
	Wed, 26 Jul 2023 17:26:04 +1000
Date: Wed, 26 Jul 2023 17:26:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
	roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
	paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
	cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
	gregkh@linuxfoundation.org, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
	linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
	rcu@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	dm-devel@redhat.com, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 03/47] mm: shrinker: add infrastructure for
 dynamically allocating shrinker
Message-ID: <ZMDKjBCZH6+OP5gW@dread.disaster.area>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-4-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724094354.90817-4-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 05:43:10PM +0800, Qi Zheng wrote:
> Currently, the shrinker instances can be divided into the following three
> types:
> 
> a) global shrinker instance statically defined in the kernel, such as
>    workingset_shadow_shrinker.
> 
> b) global shrinker instance statically defined in the kernel modules, such
>    as mmu_shrinker in x86.
> 
> c) shrinker instance embedded in other structures.
> 
> For case a, the memory of shrinker instance is never freed. For case b,
> the memory of shrinker instance will be freed after synchronize_rcu() when
> the module is unloaded. For case c, the memory of shrinker instance will
> be freed along with the structure it is embedded in.
> 
> In preparation for implementing lockless slab shrink, we need to
> dynamically allocate those shrinker instances in case c, then the memory
> can be dynamically freed alone by calling kfree_rcu().
> 
> So this commit adds the following new APIs for dynamically allocating
> shrinker, and add a private_data field to struct shrinker to record and
> get the original embedded structure.
> 
> 1. shrinker_alloc()
> 
> Used to allocate shrinker instance itself and related memory, it will
> return a pointer to the shrinker instance on success and NULL on failure.
> 
> 2. shrinker_free_non_registered()
> 
> Used to destroy the non-registered shrinker instance.

This is a bit nasty

> 
> 3. shrinker_register()
> 
> Used to register the shrinker instance, which is same as the current
> register_shrinker_prepared().
> 
> 4. shrinker_unregister()

rename this "shrinker_free()" and key the two different freeing
cases on the SHRINKER_REGISTERED bit rather than mostly duplicating
the two.

void shrinker_free(struct shrinker *shrinker)
{
	struct dentry *debugfs_entry = NULL;
	int debugfs_id;

	if (!shrinker)
		return;

	down_write(&shrinker_rwsem);
	if (shrinker->flags & SHRINKER_REGISTERED) {
		list_del(&shrinker->list);
		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
	} else if (IS_ENABLED(CONFIG_SHRINKER_DEBUG)) {
		kfree_const(shrinker->name);
	}

	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
		unregister_memcg_shrinker(shrinker);
	up_write(&shrinker_rwsem);

	if (debugfs_entry)
		shrinker_debugfs_remove(debugfs_entry, debugfs_id);

	kfree(shrinker->nr_deferred);
	kfree(shrinker);
}
EXPORT_SYMBOL_GPL(shrinker_free);

-- 
Dave Chinner
david@fromorbit.com

