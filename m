Return-Path: <netdev+bounces-20430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C775F818
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34711C20950
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA648BF7;
	Mon, 24 Jul 2023 13:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D208468
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 13:19:48 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295CF5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690204786; x=1721740786;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9cSa9Pr63Zee1J/8qMmYF8Epv+z90Luvz/CAk4fTxM0=;
  b=A6KaKsP+SzCcv2kxPugvRm3VxFGLhK1m24vJBP4H01f+P/vlyc2wFQVu
   5eU3hFfrjXD+zci1j+u60kIiNX3lNTuwPozyFVULKwLLwuKD+x0zO2Lvb
   F2K8slOy7u2nvGGFQPdpvL0CW+Avi7u8eeoBiq6kfemUAuEOxPtmzsluM
   sCo13S9aOkZAjRf0of5eY1k189eKO1YbT+ld+XXZG6WOlPfr47He6VAHQ
   HovRUb/A+uBYetu02E483pr0jAw/I7wgiPtrVzBSEuVNYZPr7Nl3Hvxd4
   +8sj1n3hcc7+NhZCtCN34/Z5Zg7BreaO8sgnJUetvH7NlHNBLaPaEgujN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347040215"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347040215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="795779345"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="795779345"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.237.140.125]) ([10.237.140.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:19:43 -0700
Message-ID: <9c3da951-7a08-2b97-309c-e7939703d11c@linux.intel.com>
Date: Mon, 24 Jul 2023 15:19:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH iwl-next v3 4/6] pfcp: always set pfcp metadata
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
 aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
 simon.horman@corigine.com, idosch@nvidia.com
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-5-marcin.szycik@linux.intel.com>
 <ZLqeB/0aoe6GQUVi@smile.fi.intel.com>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <ZLqeB/0aoe6GQUVi@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21.07.2023 17:02, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 09:15:30AM +0200, Marcin Szycik wrote:
>> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>
>> In PFCP receive path set metadata needed by flower code to do correct
>> classification based on this metadata.
> 
> ...
> 
> + bits.h
> + types.h

Will add.

> 
>> +#include <net/udp_tunnel.h>
>> +#include <net/dst_metadata.h>
>> +
>>  #define PFCP_PORT 8805
>>  
>> +/* PFCP protocol header */
>> +struct pfcphdr {
>> +	u8	flags;
>> +	u8	message_type;
>> +	__be16	message_length;
>> +};
>> +
>> +/* PFCP header flags */
>> +#define PFCP_SEID_FLAG		BIT(0)
>> +#define PFCP_MP_FLAG		BIT(1)
>> +
>> +#define PFCP_VERSION_SHIFT	5
>> +#define PFCP_VERSION_MASK	((1 << PFCP_VERSION_SHIFT) - 1)
> 
> GENMASK() since you already use BIT()

Will change.

> 
>> +#define PFCP_HLEN (sizeof(struct udphdr) + sizeof(struct pfcphdr))
>> +
>> +/* PFCP node related messages */
>> +struct pfcphdr_node {
>> +	u8	seq_number[3];
>> +	u8	reserved;
>> +};
>> +
>> +/* PFCP session related messages */
>> +struct pfcphdr_session {
>> +	__be64	seid;
>> +	u8	seq_number[3];
>> +#ifdef __LITTLE_ENDIAN_BITFIELD
>> +	u8	message_priority:4,
>> +		reserved:4;
>> +#elif defined(__BIG_ENDIAN_BITFIELD)
>> +	u8	reserved:4,
>> +		message_priprity:4;
>> +#else
>> +#error "Please fix <asm/byteorder>"
>> +#endif
>> +};
>> +
>> +struct pfcp_metadata {
>> +	u8 type;
>> +	__be64 seid;
>> +} __packed;
>> +
>> +enum {
>> +	PFCP_TYPE_NODE		= 0,
>> +	PFCP_TYPE_SESSION	= 1,
>> +};
> 
> ...
> 
>> +/* IP header + UDP + PFCP + Ethernet header */
>> +#define PFCP_HEADROOM (20 + 8 + 4 + 14)
> 
> Instead of comment like above, just use defined sizes.
> 
>> +/* IPv6 header + UDP + PFCP + Ethernet header */
>> +#define PFCP6_HEADROOM (40 + 8 + 4 + 14)

Will change.

> 
> sizeof(ipv6hdr)
> sizeof(updhdr)
> ...
> 
> Don't forget to include respective headers.
> 

Thank you for review!
Marcin

