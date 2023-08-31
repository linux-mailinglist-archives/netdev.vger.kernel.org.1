Return-Path: <netdev+bounces-31585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2C378EEA5
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB361C209E3
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224BC11725;
	Thu, 31 Aug 2023 13:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AC11719
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:30:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34337CEB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693488599; x=1725024599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/B6R2COGG68IdHMTZEz9JdctT4imXaxwLwRp3rbSqM=;
  b=S7xV1y3R+V5tgXXcNyXXhNf0xHBaFsMWHinZ5hKCGIkiS48avsh2Hygs
   pzSuIeIr3B0L83Wg6Iewn/ibaBfsRsd/SHpdN4nr9O35JMqTGhSPQFysi
   d8xjH7dKR9MCzhQj3CfxhqGGfCpeTDlY90BWwVgwjMurGB1yxwNrq/smo
   1m4cqzd5kec9jvbZMlcPDUlMuaH5jW7fjpKbFwTzcgkvpeP2sg1esh4m3
   cjTKGMLYnHCT9PsjqlIutFMg/conFaY0EYJgoWf7qkviv4XuKGLwtmoDS
   1gg5tLuYDR1EKc67HJlK55c/6RYYVztiwkF4wjAtH4C4ZHqFd/MOUuCyq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373344340"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="373344340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689328256"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="689328256"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2023 06:29:50 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qbhk4-0000BL-2V;
	Thu, 31 Aug 2023 13:29:48 +0000
Date: Thu, 31 Aug 2023 21:28:52 +0800
From: kernel test robot <lkp@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, richardcochran@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	netdev@vger.kernel.org, ntp-lists@mattcorallo.com, reibax@gmail.com
Subject: Re: [PATCH] ptp: Demultiplexed timestamp channels
Message-ID: <202308312155.cA1uQaGm-lkp@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xabier,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master horms-ipvs/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xabier-Marquiegui/ptp-Demultiplexed-timestamp-channels/20230831-054428
base:   net/main
patch link:    https://lore.kernel.org/r/20230830214101.509086-2-reibax%40gmail.com
patch subject: [PATCH] ptp: Demultiplexed timestamp channels
config: powerpc64-randconfig-r026-20230831 (https://download.01.org/0day-ci/archive/20230831/202308312155.cA1uQaGm-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308312155.cA1uQaGm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308312155.cA1uQaGm-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/ptp/ptp_chardev.c:449:9: warning: no previous prototype for function 'ptp_queue_read' [-Wmissing-prototypes]
     449 | ssize_t ptp_queue_read(struct ptp_clock *ptp, char __user *buf, size_t cnt,
         |         ^
   drivers/ptp/ptp_chardev.c:449:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     449 | ssize_t ptp_queue_read(struct ptp_clock *ptp, char __user *buf, size_t cnt,
         | ^
         | static 
>> drivers/ptp/ptp_chardev.c:544:5: warning: no previous prototype for function 'ptp_dmtsc_release' [-Wmissing-prototypes]
     544 | int ptp_dmtsc_release(struct inode *inode, struct file *file)
         |     ^
   drivers/ptp/ptp_chardev.c:544:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     544 | int ptp_dmtsc_release(struct inode *inode, struct file *file)
         | ^
         | static 
>> drivers/ptp/ptp_chardev.c:556:9: warning: no previous prototype for function 'ptp_dmtsc_read' [-Wmissing-prototypes]
     556 | ssize_t ptp_dmtsc_read(struct file *file, char __user *buf, size_t cnt,
         |         ^
   drivers/ptp/ptp_chardev.c:556:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     556 | ssize_t ptp_dmtsc_read(struct file *file, char __user *buf, size_t cnt,
         | ^
         | static 
>> drivers/ptp/ptp_chardev.c:571:6: warning: no previous prototype for function 'ptp_dmtsc_cdev_clean' [-Wmissing-prototypes]
     571 | void ptp_dmtsc_cdev_clean(struct ptp_clock *ptp)
         |      ^
   drivers/ptp/ptp_chardev.c:571:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     571 | void ptp_dmtsc_cdev_clean(struct ptp_clock *ptp)
         | ^
         | static 
>> drivers/ptp/ptp_chardev.c:612:30: error: too many arguments to function call, expected single argument 'name', have 2 arguments
     612 |                         class_create(THIS_MODULE, "ptptsevqch_class");
         |                         ~~~~~~~~~~~~              ^~~~~~~~~~~~~~~~~~
   include/linux/device/class.h:230:29: note: 'class_create' declared here
     230 | struct class * __must_check class_create(const char *name);
         |                             ^
   4 warnings and 1 error generated.


vim +/name +612 drivers/ptp/ptp_chardev.c

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
   590	int ptp_dmtsc_dev_register(struct ptp_clock *ptp)
   591	{
   592		int err, idx, major;
   593		dev_t device;
   594		struct device *dev;
   595	
   596		/* Allocate memory for demuxed device management */
   597		ptp->dmtsc_devs.cdev_info = kcalloc(ptp->info->n_ext_ts,
   598						    sizeof(*ptp->dmtsc_devs.cdev_info),
   599						    GFP_KERNEL);
   600		if (!ptp->dmtsc_devs.cdev_info) {
   601			err = -ENODEV;
   602			goto err;
   603		}
   604		for (idx = 0; idx < ptp->info->n_ext_ts; idx++)
   605			ptp->dmtsc_devs.cdev_info[idx].minor = -1;
   606		/* Create devices for all channels. The mask will control which of them get fed */
   607		err = alloc_chrdev_region(&ptp->dmtsc_devs.devid, 0,
   608					  ptp->info->n_ext_ts, "ptptsevqch");
   609		if (!err) {
   610			major = MAJOR(ptp->dmtsc_devs.devid);
   611			ptp->dmtsc_devs.dmtsc_class =
 > 612				class_create(THIS_MODULE, "ptptsevqch_class");
   613			for (idx = 0; idx < ptp->info->n_ext_ts; idx++) {
   614				mutex_init(&ptp->dmtsc_devs.cdev_info[idx].tsevq_mux);
   615				device = MKDEV(major, idx);
   616				ptp->dmtsc_devs.cdev_info[idx].pclock = ptp;
   617				cdev_init(&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev,
   618					  &fops);
   619				err = cdev_add(
   620					&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev,
   621					device, 1);
   622				if (err) {
   623					goto cdev_clean;
   624				} else {
   625					ptp->dmtsc_devs.cdev_info[idx].minor = idx;
   626					dev = device_create(ptp->dmtsc_devs.dmtsc_class,
   627							    &ptp->dev, device, NULL,
   628							    "ptp%dch%d", ptp->index,
   629							    idx);
   630					if (IS_ERR(dev)) {
   631						err = PTR_ERR(dev);
   632						goto cdev_clean;
   633					}
   634				}
   635			}
   636		} else {
   637			goto dev_clean;
   638		}
   639		return 0;
   640	
   641	cdev_clean:
   642		ptp_dmtsc_cdev_clean(ptp);
   643	dev_clean:
   644		kfree(ptp->dmtsc_devs.cdev_info);
   645		ptp->dmtsc_devs.cdev_info = NULL;
   646	err:
   647		return err;
   648	}
   649	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

