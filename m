Return-Path: <netdev+bounces-37706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA27B6AF8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 16E8928172D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675F2E641;
	Tue,  3 Oct 2023 14:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7322F505;
	Tue,  3 Oct 2023 14:00:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D589BAF;
	Tue,  3 Oct 2023 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696341648; x=1727877648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s30GRJRYo+hm6YhVGNnw6HtgOobxap3zx2uU/nc+4gs=;
  b=KjxPr03NV52026kSpL9ax4zGErpjdIatIGUMoi32LSS24zHqhXTu4tYu
   JFoGlo7taF323BJr/KwJRDsmK7SSCjY6xteL0LjeMZppByldQeeOi6ZAV
   tfJq72by24BGcpjtDeIt65d8qv90s3TQBRMHvCw/BOvmwJ85frge8Ib25
   Cmyh99aBc6AsIvgWi/dCHNlJMMYbTQGKEz4+W1dV2Oi71ZfURf6H6aumx
   bL+pJoNRXXzktj9u4vX32LWXrYK/h1gzA+y9hSlL/HBVIEGd49h0wC0sK
   9rx2pCP4zKkc2wljUBe1LGgD9zdCPYAjggHVskc+mDGa0oMoIY5dTlEyw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363143839"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="363143839"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082019676"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082019676"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 07:00:13 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qnfwZ-0007AW-0c;
	Tue, 03 Oct 2023 14:00:11 +0000
Date: Tue, 3 Oct 2023 21:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>,
	linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v3 3/3] mctp i3c: MCTP I3C driver
Message-ID: <202310032142.NaWYwlZc-lkp@intel.com>
References: <20231003063624.126723-4-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003063624.126723-4-matt@codeconstruct.com.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Matt,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/dt-bindings-i3c-Add-mctp-controller-property/20231003-144037
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231003063624.126723-4-matt%40codeconstruct.com.au
patch subject: [PATCH net-next v3 3/3] mctp i3c: MCTP I3C driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231003/202310032142.NaWYwlZc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310032142.NaWYwlZc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310032142.NaWYwlZc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/mctp/mctp-i3c.c: In function 'mctp_i3c_read':
>> drivers/net/mctp/mctp-i3c.c:121:9: error: implicit declaration of function 'put_unaligned_be48' [-Werror=implicit-function-declaration]
     121 |         put_unaligned_be48(mi->pid, ihdr->source);
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-i3c.c: In function 'mctp_i3c_xmit':
>> drivers/net/mctp/mctp-i3c.c:380:15: error: implicit declaration of function 'get_unaligned_be48'; did you mean 'get_unalign_ctl'? [-Werror=implicit-function-declaration]
     380 |         pid = get_unaligned_be48(ihdr->dest);
         |               ^~~~~~~~~~~~~~~~~~
         |               get_unalign_ctl
   cc1: some warnings being treated as errors


vim +/put_unaligned_be48 +121 drivers/net/mctp/mctp-i3c.c

    98	
    99	static int mctp_i3c_read(struct mctp_i3c_device *mi)
   100	{
   101		struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
   102		struct net_device_stats *stats = &mi->mbus->ndev->stats;
   103		struct mctp_i3c_internal_hdr *ihdr = NULL;
   104		struct sk_buff *skb = NULL;
   105		struct mctp_skb_cb *cb;
   106		int net_status, rc;
   107		u8 pec, addr;
   108	
   109		skb = netdev_alloc_skb(mi->mbus->ndev,
   110				       mi->mrl + sizeof(struct mctp_i3c_internal_hdr));
   111		if (!skb) {
   112			stats->rx_dropped++;
   113			rc = -ENOMEM;
   114			goto err;
   115		}
   116	
   117		skb->protocol = htons(ETH_P_MCTP);
   118		/* Create a header for internal use */
   119		skb_reset_mac_header(skb);
   120		ihdr = skb_put(skb, sizeof(struct mctp_i3c_internal_hdr));
 > 121		put_unaligned_be48(mi->pid, ihdr->source);
   122		put_unaligned_be48(mi->mbus->pid, ihdr->dest);
   123		skb_pull(skb, sizeof(struct mctp_i3c_internal_hdr));
   124	
   125		xfer.data.in = skb_put(skb, mi->mrl);
   126	
   127		rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
   128		if (rc < 0)
   129			goto err;
   130	
   131		if (WARN_ON_ONCE(xfer.len > mi->mrl)) {
   132			/* Bad i3c bus driver */
   133			rc = -EIO;
   134			goto err;
   135		}
   136		if (xfer.len < MCTP_I3C_MINLEN) {
   137			stats->rx_length_errors++;
   138			rc = -EIO;
   139			goto err;
   140		}
   141	
   142		/* check PEC, including address byte */
   143		addr = mi->addr << 1 | 1;
   144		pec = i2c_smbus_pec(0, &addr, 1);
   145		pec = i2c_smbus_pec(pec, xfer.data.in, xfer.len - 1);
   146		if (pec != ((u8 *)xfer.data.in)[xfer.len - 1]) {
   147			stats->rx_crc_errors++;
   148			rc = -EINVAL;
   149			goto err;
   150		}
   151	
   152		/* Remove PEC */
   153		skb_trim(skb, xfer.len - 1);
   154	
   155		cb = __mctp_cb(skb);
   156		cb->halen = PID_SIZE;
   157		put_unaligned_be48(mi->pid, cb->haddr);
   158	
   159		net_status = netif_rx(skb);
   160	
   161		if (net_status == NET_RX_SUCCESS) {
   162			stats->rx_packets++;
   163			stats->rx_bytes += xfer.len - 1;
   164		} else {
   165			stats->rx_dropped++;
   166		}
   167	
   168		return 0;
   169	err:
   170		kfree_skb(skb);
   171		return rc;
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

