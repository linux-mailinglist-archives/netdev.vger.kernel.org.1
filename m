Return-Path: <netdev+bounces-137685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 344529A9515
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980991F23AAF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231D1E51D;
	Tue, 22 Oct 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auCu8i+p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B014A07;
	Tue, 22 Oct 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558026; cv=none; b=UH1EE1hPBoxlDtfMlTORBleoMLi5pftTbtkPdDzzks9AU4CffVLjfmGJro4vVEQH9wMS4PF0X4zNtYHeoidw9BE3xU6uJt1j8MbOiwV9gGskEuWN+37GVxs0Rb+/QisAn/0ewcmYRucWqSrcm4Vo3je1x8esUT7W/rHAU9is5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558026; c=relaxed/simple;
	bh=vbFuTYjjAQ0TvYgntMtH52VUEhpkcz61eBePH1uZ9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfAPl4XOAmonEVd+Q+HeP8eQ1OryvgAUpBP9UpykVHz0zlwwF2X3xDJ0Hvi14bfdZizzt05LxPy6Cbfz5/NbykHnuQv8lZD/gh+5Lb69aR3DBX+YLSNZ8Wp8heVLXFji78d2Ml1/sIYBdCiWd6u/0LkkZZA/J5DUnzb0pWGsDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auCu8i+p; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729558024; x=1761094024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vbFuTYjjAQ0TvYgntMtH52VUEhpkcz61eBePH1uZ9d4=;
  b=auCu8i+p2gGZQXgbWH6YCqdfje7tH6FVgxfR+9CO5jj8ZIcb+ebDtIwg
   PxCsURKIiLC07mERmhmaxsI9PGKO0yU5CmrZ8BbVIU0tshSGeZTj6yNY9
   QgZMoYmlVPOnuHuUTZWWvoIovIozVQeDL1clf0nqhWnVqdwk9B5mIiN64
   mwC1audzrXFV8oVC9AbHg/w1Wkos+9YUI7oGRnqivb/a7hvVOLLk8tRTF
   dK48ydSFpzGCoiNleykQ8vJzEnsBKw/2kFi2b/mmUO0ArA7S2dAtSmbYN
   JXEHCs/BNIMgjYVA+RmkcMiDyvplRAWbb9uWxZE8SZmJ/yvVfMaSvrKJf
   A==;
X-CSE-ConnectionGUID: aGSyZmC+SDurwK6qdEffaw==
X-CSE-MsgGUID: JmGoPeoETBKdmhsDIHSVaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29226649"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29226649"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:47:03 -0700
X-CSE-ConnectionGUID: QEbf8TR5RNGSaIrRtB69Tg==
X-CSE-MsgGUID: Ydf4D+qTQYmUv2ErVF60Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84298082"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Oct 2024 17:47:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3334-000Sqe-1j;
	Tue, 22 Oct 2024 00:46:58 +0000
Date: Tue, 22 Oct 2024 08:46:04 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: vsc73xx: implement transmit via
 control interface
Message-ID: <202410220836.TtUmbpFx-lkp@intel.com>
References: <20241020205452.2660042-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020205452.2660042-1-paweldembicki@gmail.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Dembicki/net-dsa-vsc73xx-implement-packet-reception-via-control-interface/20241021-050041
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241020205452.2660042-1-paweldembicki%40gmail.com
patch subject: [PATCH net-next 1/3] net: dsa: vsc73xx: implement transmit via control interface
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241022/202410220836.TtUmbpFx-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410220836.TtUmbpFx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410220836.TtUmbpFx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:64,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/net/dsa/vitesse-vsc73xx-core.c:18:
   drivers/net/dsa/vitesse-vsc73xx-core.c: In function 'vsc73xx_inject_frame':
>> drivers/net/dsa/vitesse-vsc73xx-core.c:766:30: warning: argument to 'sizeof' in '__builtin_memset' call is the same expression as the destination; did you mean to dereference it? [-Wsizeof-pointer-memaccess]
     766 |         memset(buf, 0, sizeof(buf));
         |                              ^
   arch/m68k/include/asm/string.h:49:48: note: in definition of macro 'memset'
      49 | #define memset(d, c, n) __builtin_memset(d, c, n)
         |                                                ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +766 drivers/net/dsa/vitesse-vsc73xx-core.c

   750	
   751	static int
   752	vsc73xx_inject_frame(struct vsc73xx *vsc, int port, struct sk_buff *skb)
   753	{
   754		struct vsc73xx_ifh *ifh;
   755		u32 length, i, count;
   756		u32 *buf;
   757		int ret;
   758	
   759		if (skb->len + VSC73XX_IFH_SIZE < 64)
   760			length = 64;
   761		else
   762			length = skb->len + VSC73XX_IFH_SIZE;
   763	
   764		count = DIV_ROUND_UP(length, 8);
   765		buf = kzalloc(count * 8, GFP_KERNEL);
 > 766		memset(buf, 0, sizeof(buf));
   767	
   768		ifh = (struct vsc73xx_ifh *)buf;
   769		ifh->frame_length = skb->len;
   770		ifh->magic = VSC73XX_IFH_MAGIC;
   771	
   772		skb_copy_and_csum_dev(skb, (u8 *)(buf + 2));
   773	
   774		for (i = 0; i < count; i++) {
   775			ret = vsc73xx_write_tx_fifo(vsc, port, buf[2 * i],
   776						    buf[2 * i + 1]);
   777			if (ret) {
   778				/* Clear buffer after error */
   779				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
   780						    VSC73XX_MISCFIFO,
   781						    VSC73XX_MISCFIFO_REWIND_CPU_TX,
   782						    VSC73XX_MISCFIFO_REWIND_CPU_TX);
   783				goto err;
   784			}
   785		}
   786	
   787		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MISCFIFO,
   788			      VSC73XX_MISCFIFO_CPU_TX);
   789	
   790		skb_tx_timestamp(skb);
   791	
   792		skb->dev->stats.tx_packets++;
   793		skb->dev->stats.tx_bytes += skb->len;
   794	err:
   795		kfree(buf);
   796		return ret;
   797	}
   798	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

