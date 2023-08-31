Return-Path: <netdev+bounces-31473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8B78E3F4
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E67280CD2
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79E620;
	Thu, 31 Aug 2023 00:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4F6FA2
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 00:30:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A9BE
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 17:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693441827; x=1724977827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKp9XMtMl1LHo14SxmBKuBjjdH6S8/WiE+fvtsfFxS8=;
  b=eFG28CV+6wTsZeL4Auw//NMxQ+X7H2cWmEBv4CVAYrita3GSXquKAijp
   mIbEjrh1+LJOEjIhg02vCqAfs6poAZ+ZvXEDOTQDPg/5XTtWXWcKdfm1n
   SZg5tc+mmbFr0ix980HCzY53Nj/twZ6KrNe7nH/2/GFlNtoMcTperOMa/
   fRAeivgE0p0mIZ37b8yAdW9i1Q+Qw4T7GtqI8K8zRE5WJ9MWR/e0eT1wB
   0w18546WfLPDvN/gWw7RjsUE38EB2XK6GuRzGAaLA55mbeId7MIDMCOvO
   ThvM8WWlgXpSj3LNwLQMvn1fp95+3qp+5uPXBORf2noDb04qZdNSvmV2+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365984332"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="365984332"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 17:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774286717"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="774286717"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 17:30:25 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qbVZo-000APF-0i;
	Thu, 31 Aug 2023 00:30:24 +0000
Date: Thu, 31 Aug 2023 08:29:58 +0800
From: kernel test robot <lkp@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, richardcochran@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com, netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com, reibax@gmail.com
Subject: Re: [PATCH] ptp: Demultiplexed timestamp channels
Message-ID: <202308310809.wcvhamyw-lkp@intel.com>
References: <20230830214101.509086-2-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830214101.509086-2-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xabier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.5 next-20230830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xabier-Marquiegui/ptp-Demultiplexed-timestamp-channels/20230831-054428
base:   net/main
patch link:    https://lore.kernel.org/r/20230830214101.509086-2-reibax%40gmail.com
patch subject: [PATCH] ptp: Demultiplexed timestamp channels
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230831/202308310809.wcvhamyw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308310809.wcvhamyw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308310809.wcvhamyw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ptp/ptp_chardev.c:449:9: warning: no previous prototype for 'ptp_queue_read' [-Wmissing-prototypes]
     449 | ssize_t ptp_queue_read(struct ptp_clock *ptp, char __user *buf, size_t cnt,
         |         ^~~~~~~~~~~~~~
>> drivers/ptp/ptp_chardev.c:544:5: warning: no previous prototype for 'ptp_dmtsc_release' [-Wmissing-prototypes]
     544 | int ptp_dmtsc_release(struct inode *inode, struct file *file)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/ptp/ptp_chardev.c:556:9: warning: no previous prototype for 'ptp_dmtsc_read' [-Wmissing-prototypes]
     556 | ssize_t ptp_dmtsc_read(struct file *file, char __user *buf, size_t cnt,
         |         ^~~~~~~~~~~~~~
>> drivers/ptp/ptp_chardev.c:571:6: warning: no previous prototype for 'ptp_dmtsc_cdev_clean' [-Wmissing-prototypes]
     571 | void ptp_dmtsc_cdev_clean(struct ptp_clock *ptp)
         |      ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/ptp/ptp_chardev.c:7:
   drivers/ptp/ptp_chardev.c: In function 'ptp_dmtsc_dev_register':
   include/linux/export.h:31:21: error: passing argument 1 of 'class_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
      31 | #define THIS_MODULE ((struct module *)0)
         |                     ^~~~~~~~~~~~~~~~~~~~
         |                     |
         |                     struct module *
   drivers/ptp/ptp_chardev.c:612:38: note: in expansion of macro 'THIS_MODULE'
     612 |                         class_create(THIS_MODULE, "ptptsevqch_class");
         |                                      ^~~~~~~~~~~
   In file included from include/linux/device.h:31,
                    from include/linux/cdev.h:8,
                    from include/linux/posix-clock.h:10,
                    from drivers/ptp/ptp_chardev.c:8:
   include/linux/device/class.h:230:54: note: expected 'const char *' but argument is of type 'struct module *'
     230 | struct class * __must_check class_create(const char *name);
         |                                          ~~~~~~~~~~~~^~~~
   drivers/ptp/ptp_chardev.c:612:25: error: too many arguments to function 'class_create'
     612 |                         class_create(THIS_MODULE, "ptptsevqch_class");
         |                         ^~~~~~~~~~~~
   include/linux/device/class.h:230:29: note: declared here
     230 | struct class * __must_check class_create(const char *name);
         |                             ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ptp_queue_read +449 drivers/ptp/ptp_chardev.c

   448	
 > 449	ssize_t ptp_queue_read(struct ptp_clock *ptp, char __user *buf, size_t cnt,
   450			       int dmtsc)
   451	{
   452		struct timestamp_event_queue *queue;
   453		struct mutex *tsevq_mux;
   454		struct ptp_extts_event *event;
   455		unsigned long flags;
   456		size_t qcnt, i;
   457		int result;
   458	
   459		if (dmtsc < 0) {
   460			queue = &ptp->tsevq;
   461			tsevq_mux = &ptp->tsevq_mux;
   462		} else {
   463			queue = &ptp->dmtsc_devs.cdev_info[dmtsc].tsevq;
   464			tsevq_mux = &ptp->dmtsc_devs.cdev_info[dmtsc].tsevq_mux;
   465		}
   466	
   467		if (cnt % sizeof(struct ptp_extts_event) != 0)
   468			return -EINVAL;
   469	
   470		if (cnt > EXTTS_BUFSIZE)
   471			cnt = EXTTS_BUFSIZE;
   472	
   473		cnt = cnt / sizeof(struct ptp_extts_event);
   474	
   475		if (mutex_lock_interruptible(tsevq_mux))
   476			return -ERESTARTSYS;
   477	
   478		if (wait_event_interruptible(ptp->tsev_wq,
   479					     ptp->defunct || queue_cnt(queue))) {
   480			mutex_unlock(tsevq_mux);
   481			return -ERESTARTSYS;
   482		}
   483	
   484		if (ptp->defunct) {
   485			mutex_unlock(tsevq_mux);
   486			return -ENODEV;
   487		}
   488	
   489		event = kmalloc(EXTTS_BUFSIZE, GFP_KERNEL);
   490		if (!event) {
   491			mutex_unlock(tsevq_mux);
   492			return -ENOMEM;
   493		}
   494	
   495		spin_lock_irqsave(&queue->lock, flags);
   496	
   497		qcnt = queue_cnt(queue);
   498	
   499		if (cnt > qcnt)
   500			cnt = qcnt;
   501	
   502		for (i = 0; i < cnt; i++) {
   503			event[i] = queue->buf[queue->head];
   504			queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
   505		}
   506	
   507		spin_unlock_irqrestore(&queue->lock, flags);
   508	
   509		cnt = cnt * sizeof(struct ptp_extts_event);
   510	
   511		mutex_unlock(tsevq_mux);
   512	
   513		result = cnt;
   514		if (copy_to_user(buf, event, cnt))
   515			result = -EFAULT;
   516	
   517		kfree(event);
   518		return result;
   519	}
   520	
   521	ssize_t ptp_read(struct posix_clock *pc, uint rdflags, char __user *buf,
   522			 size_t cnt)
   523	{
   524		struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
   525	
   526		return ptp_queue_read(ptp, buf, cnt, DMTSC_NOT);
   527	}
   528	
   529	static int ptp_dmtsc_open(struct inode *inode, struct file *file)
   530	{
   531		struct ptp_dmtsc_cdev_info *cdev = container_of(
   532			inode->i_cdev, struct ptp_dmtsc_cdev_info, dmtsc_cdev);
   533	
   534		file->private_data = cdev;
   535	
   536		if (mutex_lock_interruptible(&cdev->pclock->dmtsc_en_mux))
   537			return -ERESTARTSYS;
   538		cdev->pclock->dmtsc_en_flags |= (0x1 << (cdev->minor));
   539		mutex_unlock(&cdev->pclock->dmtsc_en_mux);
   540	
   541		return stream_open(inode, file);
   542	}
   543	
 > 544	int ptp_dmtsc_release(struct inode *inode, struct file *file)
   545	{
   546		struct ptp_dmtsc_cdev_info *cdev = file->private_data;
   547	
   548		if (mutex_lock_interruptible(&cdev->pclock->dmtsc_en_mux))
   549			return -ERESTARTSYS;
   550		cdev->pclock->dmtsc_en_flags &= ~(0x1 << (cdev->minor));
   551		mutex_unlock(&cdev->pclock->dmtsc_en_mux);
   552	
   553		return 0;
   554	}
   555	
 > 556	ssize_t ptp_dmtsc_read(struct file *file, char __user *buf, size_t cnt,
   557			       loff_t *offset)
   558	{
   559		struct ptp_dmtsc_cdev_info *cdev = file->private_data;
   560	
   561		return ptp_queue_read(cdev->pclock, buf, cnt, cdev->minor);
   562	}
   563	
   564	static const struct file_operations fops = {
   565							.owner = THIS_MODULE,
   566							.open = ptp_dmtsc_open,
   567							.read = ptp_dmtsc_read,
   568							.release = ptp_dmtsc_release
   569							};
   570	
 > 571	void ptp_dmtsc_cdev_clean(struct ptp_clock *ptp)
   572	{
   573		int idx, major;
   574		dev_t device;
   575	
   576		major = MAJOR(ptp->dmtsc_devs.devid);
   577		for (idx = 0; idx < ptp->info->n_ext_ts; idx++) {
   578			if (ptp->dmtsc_devs.cdev_info[idx].minor >= 0) {
   579				device = MKDEV(major, idx);
   580				device_destroy(ptp->dmtsc_devs.dmtsc_class, device);
   581				cdev_del(&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev);
   582				ptp->dmtsc_devs.cdev_info[idx].minor = -1;
   583			}
   584		}
   585		class_destroy(ptp->dmtsc_devs.dmtsc_class);
   586		unregister_chrdev_region(ptp->dmtsc_devs.devid, ptp->info->n_ext_ts);
   587		mutex_destroy(&ptp->dmtsc_devs.cdev_info[idx].tsevq_mux);
   588	}
   589	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

