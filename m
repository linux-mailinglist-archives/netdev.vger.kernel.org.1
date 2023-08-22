Return-Path: <netdev+bounces-29519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5BB7839C2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 08:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4401C209DA
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A12B210A;
	Tue, 22 Aug 2023 06:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC217EE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 06:12:34 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DF186
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:12:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c136ee106so536885866b.1
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692684750; x=1693289550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnGKiqPMsuE0dn3dn8HBSEXMJR14dLg/QIYHbhb1hzA=;
        b=EzjR0bYoG5RjWPSEgHJQEmM3Q8tIbOQqqhcDeyMVcpLLDVGYwYLI4dkxqDqtaAbNvw
         5523iqpMhbJqQ1w+36Y6i/d8cq1Ghf/GT2pC48tC54pdD4gw/CI9wECEdijZPLVnddlP
         VnNCYcjcStFMpSWZzybijoaB1GdBPBBMQuLZCjMC9qQbvuaK+mxzxHILqr1ykIH533JJ
         FOlQ8i9/V3Y3WxGjXgH4ZecVejccxi0jraqNhDoDmWac/aFq3zJS64pvGiCtds4/T4av
         im0f/7Sg5tbons4YY2qhFVBdmi9+REQLv2JOz3JD8q+Iomna6uoBMEFKH5Rhc1oLT1LR
         0TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692684750; x=1693289550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnGKiqPMsuE0dn3dn8HBSEXMJR14dLg/QIYHbhb1hzA=;
        b=jXzavvwlMGjf7ynm1IS0lgMSRGIsKWVPCfYqtw7StJIsy/kX4Txq0S/fpAlMw1GhjW
         Kh64Fxwtp6S7re2HxdslCuabEIAAY77tRZ8hxDgZ2wM4y+jPOiNTwRz4aBjRzaBrMjk9
         Kqd6149VSGniaFjd+pGWFz0YYCZQ7l/yLMDrma08JV0ic8SqzuwMQhZY6o4an2gbIPYr
         RmFBuIFXeAWZpSHzCh8sGu3RFVM1lfd129jXqCtY4e4GhlrWYCObXbzgr8J+EC5/cdrS
         zlgjO+rtfkgmHuzB1rd4+y1ntjeGcUoBXfnOdVxsSU0qM/yRVMijI9X8g8hwxpqTjsSg
         gYrQ==
X-Gm-Message-State: AOJu0YzoxBkVciy6mxAv6qn+VeSACOD294fFV4F/lduUheb8WhjAiihx
	aTT35YdhnrTBsDkF6o1q9fhxwGtP13ElQWhCGiBxoQ==
X-Google-Smtp-Source: AGHT+IHu/WbmGP7KWcvNbRneGmYLiQT6BxNC5f9tAOz1w7bfmERdCTS0JAlpKHE9ZQH+2KoDdYlGKA==
X-Received: by 2002:a17:907:a05c:b0:9a1:bd53:b23 with SMTP id gz28-20020a170907a05c00b009a1bd530b23mr357603ejc.14.1692684750049;
        Mon, 21 Aug 2023 23:12:30 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709062a5100b0099bc2d1429csm7722632eje.72.2023.08.21.23.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 23:12:29 -0700 (PDT)
Date: Tue, 22 Aug 2023 08:12:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Wenjun Wu <wenjun1.wu@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	xuejun.zhang@intel.com, madhu.chittim@intel.com,
	qi.z.zhang@intel.com, anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v4 0/5] iavf: Add devlink and devlink rate
 support
Message-ID: <ZORRzEBcUDEjMniz@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822034003.31628-1-wenjun1.wu@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 22, 2023 at 05:39:58AM CEST, wenjun1.wu@intel.com wrote:
>To allow user to configure queue bandwidth, devlink port support
>is added to support devlink port rate API. [1]
>
>Add devlink framework registration/unregistration on iavf driver
>initialization and remove, and devlink port of DEVLINK_PORT_FLAVOUR_VIRTUAL
>is created to be associated iavf netdevice.
>
>iavf rate tree with root node, queue nodes, and leaf node is created
>and registered with devlink rate when iavf adapter is configured, and
>if PF indicates support of VIRTCHNL_VF_OFFLOAD_QOS through VF Resource /
>Capability Exchange.

NACK! Port function is there to configure the VF/SF from the eswitch
side. Yet you use it for the configureation of the actual VF, which is
clear misuse. Please don't


>
>[root@localhost ~]# devlink port function rate show
>pci/0000:af:01.0/txq_15: type node parent iavf_root
>pci/0000:af:01.0/txq_14: type node parent iavf_root
>pci/0000:af:01.0/txq_13: type node parent iavf_root
>pci/0000:af:01.0/txq_12: type node parent iavf_root
>pci/0000:af:01.0/txq_11: type node parent iavf_root
>pci/0000:af:01.0/txq_10: type node parent iavf_root
>pci/0000:af:01.0/txq_9: type node parent iavf_root
>pci/0000:af:01.0/txq_8: type node parent iavf_root
>pci/0000:af:01.0/txq_7: type node parent iavf_root
>pci/0000:af:01.0/txq_6: type node parent iavf_root
>pci/0000:af:01.0/txq_5: type node parent iavf_root
>pci/0000:af:01.0/txq_4: type node parent iavf_root
>pci/0000:af:01.0/txq_3: type node parent iavf_root
>pci/0000:af:01.0/txq_2: type node parent iavf_root
>pci/0000:af:01.0/txq_1: type node parent iavf_root
>pci/0000:af:01.0/txq_0: type node parent iavf_root
>pci/0000:af:01.0/iavf_root: type node
>
>
>                         +---------+
>                         |   root  |
>                         +----+----+
>                              |
>            |-----------------|-----------------|
>       +----v----+       +----v----+       +----v----+
>       |  txq_0  |       |  txq_1  |       |  txq_x  |
>       +----+----+       +----+----+       +----+----+
>
>User can configure the tx_max and tx_share of each queue. Once any one of the
>queues are fully configured, VIRTCHNL opcodes of VIRTCHNL_OP_CONFIG_QUEUE_BW
>and VIRTCHNL_OP_CONFIG_QUANTA will be sent to PF to configure queues allocated
>to VF
>
>Example:
>
>1.To Set the queue tx_share:
>devlink port function rate set pci/0000:af:01.0 txq_0 tx_share 100 MBps
>
>2.To Set the queue tx_max:
>devlink port function rate set pci/0000:af:01.0 txq_0 tx_max 200 MBps
>
>3.To Show Current devlink port rate info:
>devlink port function rate function show
>[root@localhost ~]# devlink port function rate show
>pci/0000:af:01.0/txq_15: type node parent iavf_root
>pci/0000:af:01.0/txq_14: type node parent iavf_root
>pci/0000:af:01.0/txq_13: type node parent iavf_root
>pci/0000:af:01.0/txq_12: type node parent iavf_root
>pci/0000:af:01.0/txq_11: type node parent iavf_root
>pci/0000:af:01.0/txq_10: type node parent iavf_root
>pci/0000:af:01.0/txq_9: type node parent iavf_root
>pci/0000:af:01.0/txq_8: type node parent iavf_root
>pci/0000:af:01.0/txq_7: type node parent iavf_root
>pci/0000:af:01.0/txq_6: type node parent iavf_root
>pci/0000:af:01.0/txq_5: type node parent iavf_root
>pci/0000:af:01.0/txq_4: type node parent iavf_root
>pci/0000:af:01.0/txq_3: type node parent iavf_root
>pci/0000:af:01.0/txq_2: type node parent iavf_root
>pci/0000:af:01.0/txq_1: type node parent iavf_root
>pci/0000:af:01.0/txq_0: type node tx_share 800Mbit tx_max 1600Mbit parent iavf_root
>pci/0000:af:01.0/iavf_root: type node
>
>
>[1]https://lore.kernel.org/netdev/20221115104825.172668-1-michal.wilczynski@intel.com/
>
>Change log:
>
>v4:
>- Rearrange the ice_vf_qs_bw structure, put the largest number first
>- Minimize the scope of values
>- Remove the unnecessary brackets
>- Remove the unnecessary memory allocation.
>- Added Error Code and moved devlink registration before aq lock initialization
>- Changed devlink registration for error handling in case of allocation failure
>- Used kcalloc for object array memory allocation and initialization
>- Changed functions & comments for readability
>
>v3:
>- Rebase the code
>- Changed rate node max/share set function description
>- Put variable in local scope
>
>v2:
>- Change static array to flex array
>- Use struct_size helper
>- Align all the error code types in the function
>- Move the register field definitions to the right place in the file
>- Fix coding style
>- Adapted to queue bw cfg and qos cap list virtchnl message with flex array fields
>---
>
>Jun Zhang (3):
>  iavf: Add devlink and devlink port support
>  iavf: Add devlink port function rate API support
>  iavf: Add VIRTCHNL Opcodes Support for Queue bw Setting
>
>Wenjun Wu (2):
>  virtchnl: support queue rate limit and quanta size configuration
>  ice: Support VF queue rate limit and quanta size configuration
>
> drivers/net/ethernet/intel/Kconfig            |   1 +
> drivers/net/ethernet/intel/iavf/Makefile      |   2 +-
> drivers/net/ethernet/intel/iavf/iavf.h        |  19 +
> .../net/ethernet/intel/iavf/iavf_devlink.c    | 377 ++++++++++++++++++
> .../net/ethernet/intel/iavf/iavf_devlink.h    |  38 ++
> drivers/net/ethernet/intel/iavf/iavf_main.c   |  64 ++-
> .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 231 ++++++++++-
> drivers/net/ethernet/intel/ice/ice.h          |   2 +
> drivers/net/ethernet/intel/ice/ice_base.c     |   2 +
> drivers/net/ethernet/intel/ice/ice_common.c   |  19 +
> .../net/ethernet/intel/ice/ice_hw_autogen.h   |   8 +
> drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +
> drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   9 +
> drivers/net/ethernet/intel/ice/ice_virtchnl.c | 310 ++++++++++++++
> drivers/net/ethernet/intel/ice/ice_virtchnl.h |  11 +
> .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
> include/linux/avf/virtchnl.h                  | 119 ++++++
> 18 files changed, 1218 insertions(+), 3 deletions(-)
> create mode 100644 drivers/net/ethernet/intel/iavf/iavf_devlink.c
> create mode 100644 drivers/net/ethernet/intel/iavf/iavf_devlink.h
>
>-- 
>2.34.1
>
>

