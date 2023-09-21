Return-Path: <netdev+bounces-35429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39237A979E
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B31F21134
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B151772A;
	Thu, 21 Sep 2023 17:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B2171C8
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:42 +0000 (UTC)
Received: from out-225.mta0.migadu.com (out-225.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978147ED4;
	Thu, 21 Sep 2023 10:05:38 -0700 (PDT)
Message-ID: <83d2d685-3c3e-1758-55f7-6c829957e51d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695307305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4F2fUPcR6NfJ9mAonWAyFBxw+y/d1QPP6AzZ+x+r3A=;
	b=FGYzkQEnCvr/opzfYOz86RJUtsE+p4cbQ1uePHwU1FuJipkFC8Zvor9BEatrhPYJyMQcai
	d4Y/oA4rVKCyx5STvMJN6C1ggz1j9m2F0ta5DChEfkS0NFjs91q7vcke5jtw8OYBft0VBn
	HdCPEkdKu4/74UtNrjyQDPSqIL6ITZA=
Date: Thu, 21 Sep 2023 15:41:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] netdev: Remove unneeded semicolon
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Yang Li <yang.lee@linux.alibaba.com>,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
 <0ae9f426-7225-ac4b-4ecd-d53e36dbf365@linux.dev>
 <b638de8abaa2e468bbcda116368c8e690a461a5d.camel@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <b638de8abaa2e468bbcda116368c8e690a461a5d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/09/2023 14:07, Paolo Abeni wrote:
> On Wed, 2023-09-20 at 12:10 +0100, Vadim Fedorenko wrote:
>> On 19/09/2023 02:03, Yang Li wrote:
>>> ./drivers/dpll/dpll_netlink.c:847:3-4: Unneeded semicolon
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6605
>>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>>
>> Hi Yang!
>> There was a report from Intel's bot too about the issue, could you
>> please add the tags from it?
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202309190540.RFwfIgO7-lkp@intel.com/
> 
> No need to repost, the pw tools import the above tags automatically. 

Ok, cool.

The fix itself is trivial.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

