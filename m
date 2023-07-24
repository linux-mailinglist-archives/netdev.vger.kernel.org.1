Return-Path: <netdev+bounces-20376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BAB75F370
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CD11C20B60
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FF6ABA;
	Mon, 24 Jul 2023 10:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DEE100D8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:36:36 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE0E6
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690194992; x=1721730992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bO8nTFIe7M7bVl0r8YUD+3gUO5FWmnkLDH3idl28Gbg=;
  b=dKPb04ZEGBWCXtLEub28navUyrBUVY5Fg86et6proqqRpUsbsvG+KzZP
   C+uZTvBfSNW0bkUnoMVep/aqOSQDee4oQcCxZtAPbToOT3oO4LuhhW9jF
   ta22FdGxuy3LtNBR/kYzu/m/PncYaBi4Qdyfq5b2vuDcBNAufkLeO54ub
   U9vnpIIcZeEVYqMkMvZEMroe8qbOL+FT2/vZ/1mJXUftpqY0sRXmlfoTm
   yLa+dJBVdRc2/ZH00iMqY1SduSqC1TInR54D9azim9giJ+dPuloIyumqG
   rQsmbtseRSYcSGTLx5Cn8CP+2vjFgl5BxQuJK1Yg96a/dkablf9dLi9jb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="433649082"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="433649082"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="899453197"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899453197"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.237.140.125]) ([10.237.140.125])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:36:30 -0700
Message-ID: <0aab3ce1-d92d-3df1-2dd4-60796bf9bf38@linux.intel.com>
Date: Mon, 24 Jul 2023 12:36:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH iwl-next v3 3/6] pfcp: add PFCP module
To: Andy Shevchenko <andy@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
 aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
 simon.horman@corigine.com, idosch@nvidia.com
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-4-marcin.szycik@linux.intel.com>
 <ZLqcDf68HgB6Knnk@smile.fi.intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <ZLqcDf68HgB6Knnk@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21.07.2023 16:54, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 09:15:29AM +0200, Marcin Szycik wrote:
>> From: Wojciech Drewek <wojciech.drewek@intel.com>
>>
>> Packet Forwarding Control Protocol (PFCP) is a 3GPP Protocol
>> used between the control plane and the user plane function.
>> It is specified in TS 29.244[1].
>>
>> Note that this module is not designed to support this Protocol
>> in the kernel space. There is no support for parsing any PFCP messages.
>> There is no API that could be used by any userspace daemon.
>> Basically it does not support PFCP. This protocol is sophisticated
>> and there is no need for implementing it in the kernel. The purpose
>> of this module is to allow users to setup software and hardware offload
>> of PFCP packets using tc tool.
>>
>> When user requests to create a PFCP device, a new socket is created.
>> The socket is set up with port number 8805 which is specific for
>> PFCP [29.244 4.2.2]. This allow to receive PFCP request messages,
>> response messages use other ports.
>>
>> Note that only one PFCP netdev can be created.
>>
>> Only IPv4 is supported at this time.
>>
>> [1] https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111
> 
>> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> Co-developed-by: Marcin...?

In this case I'm only a sender, I didn't help in development.

> 
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> ...
> 
>> +/* PFCP according to 3GPP TS 29.244
>> + *
>> + * Copyright (C) 2022, Intel Corporation.
> 
>> + * (C) 2022 by Wojciech Drewek <wojciech.drewek@intel.com>
> 
> Is it approved by our Legal? First time I see such (c) together with Intel's
> and correct authorship.

Right, I'll leave only first (c) line.

>> + * Author: Wojciech Drewek <wojciech.drewek@intel.com>
>> + */
> 
> ...
> 
>> +struct pfcp_dev {
>> +	struct list_head	list;
> 
> This is defined in types.h which is missing.

Will add.

> 
>> +	struct socket		*sock;
>> +	struct net_device	*dev;
>> +	struct net		*net;
>> +};
> 
> ...
> 
>> +	dev->needs_free_netdev	= true;
> 
> Single space is enough.

Will fix.

> 
> ...
> 
>> +static int pfcp_newlink(struct net *net, struct net_device *dev,
>> +			struct nlattr *tb[], struct nlattr *data[],
>> +			struct netlink_ext_ack *extack)
>> +{
>> +	struct pfcp_dev *pfcp = netdev_priv(dev);
>> +	struct pfcp_net *pn;
>> +	int err;
>> +
>> +	pfcp->net = net;
>> +
>> +	err = pfcp_add_sock(pfcp);
>> +	if (err) {
>> +		netdev_dbg(dev, "failed to add pfcp socket %d\n", err);
>> +		goto exit;
>> +	}
>> +
>> +	err = register_netdevice(dev);
>> +	if (err) {
>> +		netdev_dbg(dev, "failed to register pfcp netdev %d\n", err);
>> +		goto exit_reg_netdev;
>> +	}
>> +
>> +	pn = net_generic(dev_net(dev), pfcp_net_id);
>> +	list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
>> +
>> +	netdev_dbg(dev, "registered new PFCP interface\n");
>> +
>> +	return 0;
>> +
>> +exit_reg_netdev:
> 
> The label naming should tell what _will_ happen if goto $LABEL.
> Something like
> 
> exit_del_pfcp_sock:

Another convention I've seen is `err_what_failed`. But yeah,
exit_reg_netdev doesn't match either convention, will change to your
suggestion.

> 
> Ditto for all labels in your code.
> 
>> +	pfcp_del_sock(pfcp);
>> +exit:
> 
> Shouldn't here be
> 
> 	->net = NULL;

Good catch, will add.

> 
> ?
> 
>> +	return err;
>> +}
> 
> ...
> 
>> +#ifndef _PFCP_H_
>> +#define _PFCP_H_
> 
> Missing headers:
> For net_device internals, bool type, and strcpm() call.

Will add.

> 
>> +#define PFCP_PORT 8805
>> +
>> +static inline bool netif_is_pfcp(const struct net_device *dev)
>> +{
>> +	return dev->rtnl_link_ops &&
>> +	       !strcmp(dev->rtnl_link_ops->kind, "pfcp");
>> +}
>> +
>> +#endif
> 

Thank you for review!
Marcin

