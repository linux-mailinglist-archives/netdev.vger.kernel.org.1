Return-Path: <netdev+bounces-28785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04328780B09
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC5C28237F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114D182BF;
	Fri, 18 Aug 2023 11:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08EA52
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:22:35 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC4449F;
	Fri, 18 Aug 2023 04:22:13 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 90689427C1;
	Fri, 18 Aug 2023 13:22:11 +0200 (CEST)
Message-ID: <49c2e556-fd75-751e-3b0c-c51c3245f94c@proxmox.com>
Date: Fri, 18 Aug 2023 13:22:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: "Use slab_build_skb() instead" deprecation warning triggered by
 tg3
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Cc: siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, jdelvare@suse.com,
 Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
 linux-hwmon@vger.kernel.org, keescook@chromium.org,
 Linux Regressions <regressions@lists.linux.dev>
References: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
 <ZN9SId_KNgI3dfVI@debian.me>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZN9SId_KNgI3dfVI@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Am 18.08.23 um 13:12 schrieb Bagas Sanjaya:
> On Fri, Aug 18, 2023 at 10:05:11AM +0200, Fiona Ebner wrote:
>> Hi,
>> we've got a user report about the WARN_ONCE introduced by ce098da1497c
>> ("skbuff: Introduce slab_build_skb()") [0]. The stack trace indicates
>> that the call comes from the tg3 module. While this is still kernel 6.2
>> and I can't verify that the issue is still there with newer kernels, I
>> don't see related changes in drivers/net/ethernet/broadcom/tg3.* after
>> ce098da1497c, so I thought I should let you know.
>>
> 
> Thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: ce098da1497c6d
> #regzbot link: https://forum.proxmox.com/threads/132338/
> 
> PS: The proxmox forum link (except full dmesg log pasted there) is in
> German, so someone fluent in the language can be helpful here.
> 

At the moment, there is not much other text: The user says that they got
the trace after a recent upgrade, but cannot notice any real problems
and I'm telling them that it's a deprecation warning and that I reported
it upstream. If I should ask for some specific information, please let
me know :) But not sure if more information from the user is even
required here or if the fix will just be similar to the one in
8c495270845d ("bnx2x: use the right build_skb() helper").

Best Regards,
Fiona


