Return-Path: <netdev+bounces-19058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27500759740
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98780281828
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479B13FED;
	Wed, 19 Jul 2023 13:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903313FE4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:44:46 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA03189
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:44:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so64137185e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689774283; x=1690379083;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxEa7ZwmbtgvUZmyPwt7LvypfZDgVVCC3R8/YAt2SXA=;
        b=Ye6BA598dBDYf1XKC40Vlgb6lcjT0j/ASLtOw8IE0Ecnnr7Ri+S4jJwtNlfNxxQMkV
         VEKymcXNZkZAuFn8Pi4zJOFHNiod6v1LpNqzNRpYccNUxrtL/PiNxN3SINw6+YhimgtN
         7SOR0TfGR0x3QQl4E+dkdZr8lu1mxT8ScjsRwfqeZhUnrqvcSSPTLN2KlqMXJOTXnDtD
         3mIkDM0yzj4zCAKar6qoH4tK5CF1W2a4tsDEjP6HvNVXdWe8bFPX1NeA7S9I0soABQBv
         nMuVZ1wHqp8e8Yyc6488I1/CIJR6O2+LsbJsI/B+MYEHxIShuHAoSnbMzAPXQ8zmdf6G
         j3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689774283; x=1690379083;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxEa7ZwmbtgvUZmyPwt7LvypfZDgVVCC3R8/YAt2SXA=;
        b=Fc/AgEsCQJ35bPmG7vFOSCEUcCXrSCODy/nyNirZ+yyEb5vXnGtbSBCiwWuTLgQNB1
         cJZz9ZXZneIbUS4vm9ZOmFnNAzVA1kt5I6CA0GZ03BjE7hZjKK3Sr1DFIQNgskcOXdIo
         WQUJyTf0pqc8q7hnv509bjJdx7ZhgDFkNQn8qbUuMu3pzJNEg8Ec2G6OaiQQoyKLzaYJ
         hyT+UG56W+OHoFaqlKvoavccYiLWRp2K4Oi+9QjG8ZzimpyegNg/D0JSeaxQksTwaOdJ
         7icHECCGmn5erzEpKglCS1IlBfJj8VcbXRpDNrxmHTXAmauN8QFcQLD19gemujrgIVah
         WM4A==
X-Gm-Message-State: ABy/qLav2Ltiq9yx7AOV3/ER19R4aRCGDn6HAHCDT0jZaMsGGIdNMbMO
	7yFkbJEYJoPESaTWpTtduR7Z8A==
X-Google-Smtp-Source: APBJJlGRAbCaxxekeDgGVO/og5aN4wlb/W1+ZPJxbkKSNWedMnsl46RdKW0o44vi2mkr4L7iQMTUag==
X-Received: by 2002:a1c:e913:0:b0:3fb:9ef2:157 with SMTP id q19-20020a1ce913000000b003fb9ef20157mr1929582wmc.28.1689774282928;
        Wed, 19 Jul 2023 06:44:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b0030c4d8930b1sm5397706wrr.91.2023.07.19.06.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:44:40 -0700 (PDT)
Date: Wed, 19 Jul 2023 16:44:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Patrick Rohr <prohr@google.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Patrick Rohr <prohr@google.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [net-next] net: add sysctl accept_ra_min_rtr_lft
Message-ID: <8ab106ad-d153-4c3e-8b4a-de4826d29da6@kadam.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718213709.688186-1-prohr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Patrick,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Patrick-Rohr/net-add-sysctl-accept_ra_min_rtr_lft/20230719-053943
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230718213709.688186-1-prohr%40google.com
patch subject: [net-next] net: add sysctl accept_ra_min_rtr_lft
config: x86_64-randconfig-m001-20230717 (https://download.01.org/0day-ci/archive/20230719/202307192116.N4bDjayg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307192116.N4bDjayg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307192116.N4bDjayg-lkp@intel.com/

smatch warnings:
net/ipv6/ndisc.c:1501 ndisc_router_discovery() error: uninitialized symbol 'lifetime'.

vim +/lifetime +1501 net/ipv6/ndisc.c

  1279  
  1280          if (!ndisc_parse_options(skb->dev, opt, optlen, &ndopts))
  1281                  return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
  1282  
  1283          if (!ipv6_accept_ra(in6_dev)) {
  1284                  ND_PRINTK(2, info,
  1285                            "RA: %s, did not accept ra for dev: %s\n",
  1286                            __func__, skb->dev->name);
  1287                  goto skip_linkparms;
                        ^^^^^^^^^^^^^^^^^^^^
This goto happens before lifetime is set

  1288          }
  1289  
  1290          lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);

Set here

  1291          if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
  1292                  ND_PRINTK(2, info,
  1293                            "RA: router lifetime (%ds) is too short: %s\n",
  1294                            lifetime, skb->dev->name);
  1295                  goto skip_linkparms;
  1296          }
  1297  
  1298  #ifdef CONFIG_IPV6_NDISC_NODETYPE

[ SNIP ]

  1464  
  1465  skip_linkparms:
  1466  
  1467          /*
  1468           *      Process options.
  1469           */
  1470  
  1471          if (!neigh)
  1472                  neigh = __neigh_lookup(&nd_tbl, &ipv6_hdr(skb)->saddr,
  1473                                         skb->dev, 1);
  1474          if (neigh) {
  1475                  u8 *lladdr = NULL;
  1476                  if (ndopts.nd_opts_src_lladdr) {
  1477                          lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr,
  1478                                                       skb->dev);
  1479                          if (!lladdr) {
  1480                                  ND_PRINTK(2, warn,
  1481                                            "RA: invalid link-layer address length\n");
  1482                                  goto out;
  1483                          }
  1484                  }
  1485                  ndisc_update(skb->dev, neigh, lladdr, NUD_STALE,
  1486                               NEIGH_UPDATE_F_WEAK_OVERRIDE|
  1487                               NEIGH_UPDATE_F_OVERRIDE|
  1488                               NEIGH_UPDATE_F_OVERRIDE_ISROUTER|
  1489                               NEIGH_UPDATE_F_ISROUTER,
  1490                               NDISC_ROUTER_ADVERTISEMENT, &ndopts);
  1491                  reason = SKB_CONSUMED;
  1492          }
  1493  
  1494          if (!ipv6_accept_ra(in6_dev)) {
  1495                  ND_PRINTK(2, info,
  1496                            "RA: %s, accept_ra is false for dev: %s\n",
  1497                            __func__, skb->dev->name);
  1498                  goto out;
  1499          }
  1500  
  1501          if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
                    ^^^^^^^^
Uninitialized

  1502                  ND_PRINTK(2, info,
  1503                            "RA: router lifetime (%ds) is too short: %s\n",
  1504                            lifetime, skb->dev->name);
  1505                  goto out;
  1506          }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


