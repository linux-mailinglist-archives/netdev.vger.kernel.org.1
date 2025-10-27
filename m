Return-Path: <netdev+bounces-233317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A20E1C11B6C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C551A63A93
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06E2DAFD2;
	Mon, 27 Oct 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bK+S7cqf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F82E092D;
	Mon, 27 Oct 2025 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604234; cv=none; b=YCAa64ghOeYtasgi4BxvVj0js6DLwcoT9Mo0bTGocE+EX3jIT7Dl2fs16As/o2YuBCfwTUfH6H6/4bZUwahe+M65rgGOK18GBUxxZ6k9beVjAdDLATA0ns9NnnLAAc2TS+ZIMYMzr2qA4ND3sY4E8dvwhqJ8oDJqKJ5Uv7QkLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604234; c=relaxed/simple;
	bh=PUExZlzelglFJnu5PzrDtAcNO1FsDeFqop202nIj9Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyj1RDAfUNxOqiJUKloRlV7a3ADSZ3Xst6v93dYdmlq92rY5G9Rt3KYBjLtEi4yN49uP2oxNwjYKDbpC0PpJhnNPnB8lX9Zf+dyEO5gukmcd94Q1tR1Xjqnr0B1ZSRmEpQCkNSszv3eL0vMmHPB7TI4iJejwKvsg2hjHUO1Nemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bK+S7cqf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761604232; x=1793140232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PUExZlzelglFJnu5PzrDtAcNO1FsDeFqop202nIj9Ms=;
  b=bK+S7cqfhOj0ZdfYCFo2OCqxbHJJrIDFJcaX2iXTdest5IgokESWO5tw
   vy91dJJ4AcR3NbLMMGCQ+7nQ2Gn+G3DuE8QNTYwZXjJhlxmfsGuIjs6Zm
   rtIoZ9/a8F64A/zfqp+W212sI0zULYxfrGxh7NGj6iOUnCn2WcsR95U6c
   siHEQO9TbVTx4XIFqTqNd5au0HfklCJwt7BS1o66FOXFgA+FS8VvG8qXt
   wCrjBQodLC59f7Xbdhvhx5bNqDdNUuVi8NtA5ciRHS0FiqWeftssSGzFB
   aeFchReCWZuESFywB6K0hZo5nt9Gz6y0/WPpCDNlF8B5DVUPMIrP4tsb0
   A==;
X-CSE-ConnectionGUID: Rpo9Deg+TcaFx+Ibruc7rQ==
X-CSE-MsgGUID: QpuVQpymSwWSwrfY0wLOXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63733661"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63733661"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 15:30:32 -0700
X-CSE-ConnectionGUID: PZO6RrJGQQqqhiaIGvhGog==
X-CSE-MsgGUID: 9pRK8rJ5TIOUDoUppIYEYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="222378959"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 27 Oct 2025 15:30:29 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDVjO-000IWr-1x;
	Mon, 27 Oct 2025 22:30:26 +0000
Date: Tue, 28 Oct 2025 06:27:44 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Hudson <nhudson@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Nick Hudson <nhudson@akamai.com>,
	Max Tottenham <mtottenh@akamai.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: add a new ioctl VHOST_GET_VRING_WORKER_INFO and
 use in net.c
Message-ID: <202510280631.i6odx2RJ-lkp@intel.com>
References: <20251027102644.622305-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027102644.622305-1-nhudson@akamai.com>

Hi Nick,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master v6.18-rc3 next-20251027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Hudson/vhost-add-a-new-ioctl-VHOST_GET_VRING_WORKER_INFO-and-use-in-net-c/20251027-182919
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20251027102644.622305-1-nhudson%40akamai.com
patch subject: [PATCH] vhost: add a new ioctl VHOST_GET_VRING_WORKER_INFO and use in net.c
config: csky-randconfig-002-20251028 (https://download.01.org/0day-ci/archive/20251028/202510280631.i6odx2RJ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510280631.i6odx2RJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510280631.i6odx2RJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vhost/vhost.c: In function 'vhost_dev_ioctl':
>> drivers/vhost/vhost.c:2403:17: error: 'worker' undeclared (first use in this function)
    2403 |                 worker = rcu_dereference_check(vq->worker,
         |                 ^~~~~~
   drivers/vhost/vhost.c:2403:17: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/scatterlist.h:8,
                    from include/linux/virtio.h:7,
                    from include/linux/virtio_config.h:7,
                    from include/uapi/linux/vhost_types.h:16,
                    from include/uapi/linux/vhost.h:14,
                    from drivers/vhost/vhost.c:14:
>> drivers/vhost/vhost.c:2403:48: error: 'vq' undeclared (first use in this function); did you mean 'rq'?
    2403 |                 worker = rcu_dereference_check(vq->worker,
         |                                                ^~
   include/linux/rcupdate.h:532:17: note: in definition of macro '__rcu_dereference_check'
     532 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
   drivers/vhost/vhost.c:2403:26: note: in expansion of macro 'rcu_dereference_check'
    2403 |                 worker = rcu_dereference_check(vq->worker,
         |                          ^~~~~~~~~~~~~~~~~~~~~
>> drivers/vhost/vhost.c:2404:65: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
    2404 |                                                lockdep_is_held(&dev->mutex));
         |                                                                 ^~~
   include/linux/rcupdate.h:483:52: note: in definition of macro 'RCU_LOCKDEP_WARN'
     483 | #define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
         |                                                    ^
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vhost.c:2403:26: note: in expansion of macro 'rcu_dereference_check'
    2403 |                 worker = rcu_dereference_check(vq->worker,
         |                          ^~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vhost.c:2404:48: note: in expansion of macro 'lockdep_is_held'
    2404 |                                                lockdep_is_held(&dev->mutex));
         |                                                ^~~~~~~~~~~~~~~
>> drivers/vhost/vhost.c:2406:25: error: 'ret' undeclared (first use in this function); did you mean 'net'?
    2406 |                         ret = -EINVAL;
         |                         ^~~
         |                         net
>> drivers/vhost/vhost.c:2410:25: error: 'ring_worker_info' undeclared (first use in this function); did you mean 'print_worker_info'?
    2410 |                 memset(&ring_worker_info, 0, sizeof(ring_worker_info));
         |                         ^~~~~~~~~~~~~~~~
         |                         print_worker_info
>> drivers/vhost/vhost.c:2411:42: error: 'idx' undeclared (first use in this function); did you mean 'ida'?
    2411 |                 ring_worker_info.index = idx;
         |                                          ^~~
         |                                          ida
>> drivers/vhost/vhost.c:2413:60: error: implicit declaration of function 'vhost_get_task'; did you mean 'vhost_get_desc'? [-Wimplicit-function-declaration]
    2413 |                 ring_worker_info.worker_pid = task_pid_vnr(vhost_get_task(worker->vtsk));
         |                                                            ^~~~~~~~~~~~~~
         |                                                            vhost_get_desc


vim +/worker +2403 drivers/vhost/vhost.c

  2352	
  2353		/* You must be the owner to do anything else */
  2354		r = vhost_dev_check_owner(d);
  2355		if (r)
  2356			goto done;
  2357	
  2358		switch (ioctl) {
  2359		case VHOST_SET_MEM_TABLE:
  2360			r = vhost_set_memory(d, argp);
  2361			break;
  2362		case VHOST_SET_LOG_BASE:
  2363			if (copy_from_user(&p, argp, sizeof p)) {
  2364				r = -EFAULT;
  2365				break;
  2366			}
  2367			if ((u64)(unsigned long)p != p) {
  2368				r = -EFAULT;
  2369				break;
  2370			}
  2371			for (i = 0; i < d->nvqs; ++i) {
  2372				struct vhost_virtqueue *vq;
  2373				void __user *base = (void __user *)(unsigned long)p;
  2374				vq = d->vqs[i];
  2375				mutex_lock(&vq->mutex);
  2376				/* If ring is inactive, will check when it's enabled. */
  2377				if (vq->private_data && !vq_log_access_ok(vq, base))
  2378					r = -EFAULT;
  2379				else
  2380					vq->log_base = base;
  2381				mutex_unlock(&vq->mutex);
  2382			}
  2383			break;
  2384		case VHOST_SET_LOG_FD:
  2385			r = get_user(fd, (int __user *)argp);
  2386			if (r < 0)
  2387				break;
  2388			ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
  2389			if (IS_ERR(ctx)) {
  2390				r = PTR_ERR(ctx);
  2391				break;
  2392			}
  2393			swap(ctx, d->log_ctx);
  2394			for (i = 0; i < d->nvqs; ++i) {
  2395				mutex_lock(&d->vqs[i]->mutex);
  2396				d->vqs[i]->log_ctx = d->log_ctx;
  2397				mutex_unlock(&d->vqs[i]->mutex);
  2398			}
  2399			if (ctx)
  2400				eventfd_ctx_put(ctx);
  2401			break;
  2402		case VHOST_GET_VRING_WORKER_INFO:
> 2403			worker = rcu_dereference_check(vq->worker,
> 2404						       lockdep_is_held(&dev->mutex));
  2405			if (!worker) {
> 2406				ret = -EINVAL;
  2407				break;
  2408			}
  2409	
> 2410			memset(&ring_worker_info, 0, sizeof(ring_worker_info));
> 2411			ring_worker_info.index = idx;
  2412			ring_worker_info.worker_id = worker->id;
> 2413			ring_worker_info.worker_pid = task_pid_vnr(vhost_get_task(worker->vtsk));
  2414	
  2415			if (copy_to_user(argp, &ring_worker_info, sizeof(ring_worker_info)))
  2416				ret = -EFAULT;
  2417			break;
  2418		default:
  2419			r = -ENOIOCTLCMD;
  2420			break;
  2421		}
  2422	done:
  2423		return r;
  2424	}
  2425	EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
  2426	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

