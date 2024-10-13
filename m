Return-Path: <netdev+bounces-134893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAB99B846
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 07:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914AC2828CA
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 05:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857B136657;
	Sun, 13 Oct 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/8lr/eL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740154EB45;
	Sun, 13 Oct 2024 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728796604; cv=none; b=O5CG8q5W88+hsg4SnUblLU5G68LzuZw9gjYPNz5Gug4wACxbl4htVkn3QZm4ZfGwbAOW++GHVw9GrkZjztyRDNGg+QIEpHPOrtCsUmFFhwlwy/zepJ0Lrd6pPeOfxr+kauGFP30sdwFtmEPI7Dl5zS5fWxfRVMolHh+aLcLMXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728796604; c=relaxed/simple;
	bh=dDEb9KPSfDkk4dMvl8+gZX9+2Yq+zVtsM2W8q+8arOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG8oRAht73JmxR6hi09UcF6F5tV7ER/RE59lis+LmjXVdk4eBzPTmqhwvxilUn3n8z8lCrO9peOCGdxenq4WJmjKm3iRYLvkbExSndAS459+mSorg6WP7dtcvrzZRRNBrU9NnwlbO6KGWb5mglQ0z9cxulJQ4ZuEkRRTYnrkMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/8lr/eL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728796601; x=1760332601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dDEb9KPSfDkk4dMvl8+gZX9+2Yq+zVtsM2W8q+8arOk=;
  b=a/8lr/eL6DPAeSIKFdH/ktYrjYYYnKTvMVi8VjKCJU/HN8LsyXhj6YOF
   7c47R+4QY+56NfmEv5IZ+3v5fvllkrlQSAY7SavKGez2zvVCRh9+H5yBz
   5iGkbyZ6tErNzI3+uPiexZh4hi6mM8jT0IhGMYrU1jbzBjkBE5lyZ7+mU
   q7slLkMchGpUrATRO9QJVkaJB2rUSmjsYJv8+xvGSED5Or/qrmZz88UZk
   VPACfWAQe4IWQqmAlbfVGnb/tx/UCA8/4x8MPGkwlpRQrakSiJKGF28xr
   SBl7nFAEXhJXILp7R5m494nGfbYc+Yv9rabd+Bs1C6WKduADSOIR60uVB
   w==;
X-CSE-ConnectionGUID: 43ZpfFfyTZSdkD4CesCGxw==
X-CSE-MsgGUID: WfU3mLKrTSSbK+JSgZ6wLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28253431"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28253431"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 22:16:40 -0700
X-CSE-ConnectionGUID: O5AzXYBFSjqv1gceKNBZhg==
X-CSE-MsgGUID: nLYs637tQfuP3qnB4gLT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="81274022"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Oct 2024 22:16:37 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szqy2-000E75-2s;
	Sun, 13 Oct 2024 05:16:34 +0000
Date: Sun, 13 Oct 2024 13:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <error27@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid
 potential warning
Message-ID: <202410131247.7EWZ1WLP-lkp@intel.com>
References: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 44badc908f2c85711cb18e45e13119c10ad3a05f]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/cleanup-adjust-scoped_guard-macros-to-avoid-potential-warning/20241011-201702
base:   44badc908f2c85711cb18e45e13119c10ad3a05f
patch link:    https://lore.kernel.org/r/20241011121535.28049-1-przemyslaw.kitszel%40intel.com
patch subject: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid potential warning
config: hexagon-randconfig-001-20241013 (https://download.01.org/0day-ci/archive/20241013/202410131247.7EWZ1WLP-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131247.7EWZ1WLP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131247.7EWZ1WLP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/core/pcm_native.c:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from sound/core/pcm_native.c:15:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from sound/core/pcm_native.c:15:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from sound/core/pcm_native.c:15:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> sound/core/pcm_native.c:2277:2: warning: variable 'target_group' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2277 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/pcm_native.c:2285:25: note: uninitialized use occurs here
    2285 |         snd_pcm_group_lock_irq(target_group, nonatomic);
         |                                ^~~~~~~~~~~~
   sound/core/pcm_native.c:2277:2: note: remove the 'if' if its condition is always false
    2277 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   sound/core/pcm_native.c:2249:36: note: initialize the variable 'target_group' to silence this warning
    2249 |         struct snd_pcm_group *target_group;
         |                                           ^
         |                                            = NULL
>> sound/core/pcm_native.c:2993:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2993 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/pcm_native.c:3001:9: note: uninitialized use occurs here
    3001 |         return ret;
         |                ^~~
   sound/core/pcm_native.c:2993:2: note: remove the 'if' if its condition is always false
    2993 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   sound/core/pcm_native.c:2988:23: note: initialize the variable 'ret' to silence this warning
    2988 |         snd_pcm_sframes_t ret;
         |                              ^
         |                               = 0
   sound/core/pcm_native.c:3012:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3012 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/pcm_native.c:3020:9: note: uninitialized use occurs here
    3020 |         return ret;
         |                ^~~
   sound/core/pcm_native.c:3012:2: note: remove the 'if' if its condition is always false
    3012 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   sound/core/pcm_native.c:3007:23: note: initialize the variable 'ret' to silence this warning
    3007 |         snd_pcm_sframes_t ret;
         |                              ^
         |                               = 0
>> sound/core/pcm_native.c:3028:2: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3028 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/pcm_native.c:3035:9: note: uninitialized use occurs here
    3035 |         return err;
         |                ^~~
   sound/core/pcm_native.c:3028:2: note: remove the 'if' if its condition is always false
    3028 |         scoped_guard(pcm_stream_lock_irq, substream) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   sound/core/pcm_native.c:3026:9: note: initialize the variable 'err' to silence this warning
    3026 |         int err;
         |                ^
         |                 = 0
   11 warnings generated.
--
>> sound/core/sound.c:152:2: warning: variable 'new_fops' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     152 |         scoped_guard(mutex, &sound_mutex) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/sound.c:161:7: note: uninitialized use occurs here
     161 |         if (!new_fops)
         |              ^~~~~~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   sound/core/sound.c:152:2: note: remove the 'if' if its condition is always false
     152 |         scoped_guard(mutex, &sound_mutex) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   sound/core/sound.c:147:40: note: initialize the variable 'new_fops' to silence this warning
     147 |         const struct file_operations *new_fops;
         |                                               ^
         |                                                = NULL
   1 warning generated.
--
   In file included from drivers/mailbox/arm_mhuv3.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/mailbox/arm_mhuv3.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/mailbox/arm_mhuv3.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/mailbox/arm_mhuv3.c:642:3: warning: variable 'fired_dbs' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     642 |                 scoped_guard(spinlock_irqsave, &e->pending_lock) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:650:3: note: uninitialized use occurs here
     650 |                 fired_dbs &= ~BIT(*db);
         |                 ^~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:642:3: note: remove the 'if' if its condition is always false
     642 |                 scoped_guard(spinlock_irqsave, &e->pending_lock) {
         |                 ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/mailbox/arm_mhuv3.c:634:28: note: initialize the variable 'fired_dbs' to silence this warning
     634 |                 u32 active_dbs, fired_dbs;
         |                                          ^
         |                                           = 0
   7 warnings generated.
..

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +2277 sound/core/pcm_native.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  2240  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2241  /*
^1da177e4c3f41 Linus Torvalds  2005-04-16  2242   * PCM link handling
^1da177e4c3f41 Linus Torvalds  2005-04-16  2243   */
877211f5e1b119 Takashi Iwai    2005-11-17  2244  static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2245  {
877211f5e1b119 Takashi Iwai    2005-11-17  2246  	struct snd_pcm_file *pcm_file;
877211f5e1b119 Takashi Iwai    2005-11-17  2247  	struct snd_pcm_substream *substream1;
ae921398486419 Takashi Iwai    2024-02-22  2248  	struct snd_pcm_group *group __free(kfree) = NULL;
ae921398486419 Takashi Iwai    2024-02-22  2249  	struct snd_pcm_group *target_group;
f57f3df03a8e60 Takashi Iwai    2019-01-13  2250  	bool nonatomic = substream->pcm->nonatomic;
d90950c6a2658e Takashi Iwai    2024-02-23  2251  	CLASS(fd, f)(fd);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2252  
1da91ea87aefe2 Al Viro         2024-05-31  2253  	if (!fd_file(f))
^1da177e4c3f41 Linus Torvalds  2005-04-16  2254  		return -EBADFD;
1da91ea87aefe2 Al Viro         2024-05-31  2255  	if (!is_pcm_file(fd_file(f)))
d90950c6a2658e Takashi Iwai    2024-02-23  2256  		return -EBADFD;
ae921398486419 Takashi Iwai    2024-02-22  2257  
1da91ea87aefe2 Al Viro         2024-05-31  2258  	pcm_file = fd_file(f)->private_data;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2259  	substream1 = pcm_file->substream;
951e2736f4b11b Michał Mirosław 2020-06-08  2260  
d90950c6a2658e Takashi Iwai    2024-02-23  2261  	if (substream == substream1)
d90950c6a2658e Takashi Iwai    2024-02-23  2262  		return -EINVAL;
951e2736f4b11b Michał Mirosław 2020-06-08  2263  
73365cb10b280e Takashi Iwai    2019-01-13  2264  	group = kzalloc(sizeof(*group), GFP_KERNEL);
d90950c6a2658e Takashi Iwai    2024-02-23  2265  	if (!group)
d90950c6a2658e Takashi Iwai    2024-02-23  2266  		return -ENOMEM;
73365cb10b280e Takashi Iwai    2019-01-13  2267  	snd_pcm_group_init(group);
f57f3df03a8e60 Takashi Iwai    2019-01-13  2268  
dd0da75b9a2768 Takashi Iwai    2024-02-27  2269  	guard(rwsem_write)(&snd_pcm_link_rwsem);
f0061c18c169f0 Takashi Iwai    2022-09-26  2270  	if (substream->runtime->state == SNDRV_PCM_STATE_OPEN ||
f0061c18c169f0 Takashi Iwai    2022-09-26  2271  	    substream->runtime->state != substream1->runtime->state ||
dd0da75b9a2768 Takashi Iwai    2024-02-27  2272  	    substream->pcm->nonatomic != substream1->pcm->nonatomic)
dd0da75b9a2768 Takashi Iwai    2024-02-27  2273  		return -EBADFD;
dd0da75b9a2768 Takashi Iwai    2024-02-27  2274  	if (snd_pcm_stream_linked(substream1))
dd0da75b9a2768 Takashi Iwai    2024-02-27  2275  		return -EALREADY;
f57f3df03a8e60 Takashi Iwai    2019-01-13  2276  
650224fe8d5f6d Takashi Iwai    2024-02-27 @2277  	scoped_guard(pcm_stream_lock_irq, substream) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2278  		if (!snd_pcm_stream_linked(substream)) {
a41c4cb913b53b Takashi Iwai    2019-01-13  2279  			snd_pcm_group_assign(substream, group);
f57f3df03a8e60 Takashi Iwai    2019-01-13  2280  			group = NULL; /* assigned, don't free this one below */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2281  		}
f57f3df03a8e60 Takashi Iwai    2019-01-13  2282  		target_group = substream->group;
650224fe8d5f6d Takashi Iwai    2024-02-27  2283  	}
f57f3df03a8e60 Takashi Iwai    2019-01-13  2284  
f57f3df03a8e60 Takashi Iwai    2019-01-13  2285  	snd_pcm_group_lock_irq(target_group, nonatomic);
e18035cf5cb3d2 Michał Mirosław 2020-06-08  2286  	snd_pcm_stream_lock_nested(substream1);
f57f3df03a8e60 Takashi Iwai    2019-01-13  2287  	snd_pcm_group_assign(substream1, target_group);
0e279dcea0ec89 Takashi Iwai    2019-07-19  2288  	refcount_inc(&target_group->refs);
f57f3df03a8e60 Takashi Iwai    2019-01-13  2289  	snd_pcm_stream_unlock(substream1);
f57f3df03a8e60 Takashi Iwai    2019-01-13  2290  	snd_pcm_group_unlock_irq(target_group, nonatomic);
dd0da75b9a2768 Takashi Iwai    2024-02-27  2291  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2292  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  2293  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

