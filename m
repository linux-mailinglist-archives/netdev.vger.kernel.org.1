Return-Path: <netdev+bounces-37014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35EF7B3201
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 85C252827B2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0746E18644;
	Fri, 29 Sep 2023 12:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B51863A;
	Fri, 29 Sep 2023 12:05:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D159193;
	Fri, 29 Sep 2023 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695989112; x=1727525112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VJMaG13OJcHThIk080sju328yDFylyW8tGrNgtZsgxo=;
  b=T99rugG+g/W0bpY6iMYXy67u/1mVaCtjZZ/Hng1VXZL9It94hZ+cX3gU
   2MhJ5/BiQYrN/25WFytzL6uOkz3FTda2zjcsvgWQvg99oD+0jB/RVfJ2A
   BECOPPbPPVysOMWuWlwDMu1lfIAYBS3f2Us5bsEB0Q26TDL9Vm4iarWwE
   Ga+uCH8k6NfNIxLP/K+FJ8jr5JpDHb9MzjLS7voHYMVXcz1jOa8TIHDr5
   5tOHCMpF5Qvouh71PhB8UhJ03RHo729MSf5jKBYiwQETHeaJhjTYGcJQG
   iQQZJP3mAGfy8Uq0w1N7M/kaZd+Xwf4BNYXWk219bOxXWWL9b+0BZkG1C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="385099129"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="385099129"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 05:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="820192781"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="820192781"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2023 05:05:05 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmCEx-0002q2-0n;
	Fri, 29 Sep 2023 12:05:03 +0000
Date: Fri, 29 Sep 2023 20:04:44 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v7 25/30] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <202309291924.OBfdyhXb-lkp@intel.com>
References: <20230928070652.330429-26-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928070652.330429-26-herve.codina@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Herve,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/soc-fsl-cpm1-tsa-Fix-__iomem-addresses-declaration/20230928-151746
base:   linus/master
patch link:    https://lore.kernel.org/r/20230928070652.330429-26-herve.codina%40bootlin.com
patch subject: [PATCH v7 25/30] dt-bindings: net: Add the Lantiq PEF2256 E1/T1/J1 framer
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230929/202309291924.OBfdyhXb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291924.OBfdyhXb-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: 'oneOf' conditional failed, one must be fixed:
   	'type' is a required property
   		hint: A vendor boolean property can use "type: boolean"
   	Additional properties are not allowed ('default', 'enum' were unexpected)
   		hint: A vendor boolean property can use "type: boolean"
   	Additional properties are not allowed ('default' was unexpected)
   		hint: A vendor string property with exact values has an implicit type
>> 	Documentation/devicetree/bindings/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: 'oneOf' conditional failed, one must be fixed:
   		'$ref' is a required property
   		'allOf' is a required property
   		hint: A vendor property needs a $ref to types.yaml
   		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
   	2048000 is not of type 'string'
   		hint: A vendor string property with exact values has an implicit type
   	4096000 is not of type 'string'
   		hint: A vendor string property with exact values has an implicit type
   	8192000 is not of type 'string'
   		hint: A vendor string property with exact values has an implicit type

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

