Return-Path: <netdev+bounces-14474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4F741DFB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 04:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48801C203D8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9585E139B;
	Thu, 29 Jun 2023 02:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865DC1380
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 02:10:55 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 6ADF61FEB;
	Wed, 28 Jun 2023 19:10:53 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 23C4C604D34EE;
	Thu, 29 Jun 2023 10:10:39 +0800 (CST)
Message-ID: <72784932-8390-4f82-fbaa-5086804025df@nfschina.com>
Date: Thu, 29 Jun 2023 10:10:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 00/10] Remove unnecessary (void*) conversions
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hao Lan <lanhao@huawei.com>, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, irusskikh@marvell.com, yisen.zhuang@huawei.com,
 salil.mehta@huawei.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, steve.glendinning@shawell.net,
 iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 mostrows@earthlink.net, xeb@mail.ru, qiang.zhao@nxp.com,
 yangyingliang@huawei.com, linux@rempel-privat.de, ansuelsmth@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: yunchuan <yunchuan@nfschina.com>
In-Reply-To: <ecd70c28-1629-4b6c-96fc-a0b8f8713a04@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/6/28 22:39, Andrew Lunn wrote:
> On Wed, Jun 28, 2023 at 04:37:43PM +0200, Andrew Lunn wrote:
>>> Hi, Hao Lan,
>>>
>>> Sorry for that, I just compiled these patches in the mainline branch.
>>> I know now, it's also necessary to compile patches in net and net-next
>>> branch.
>>> Thanks for your reply!
>> net-next is also closed at the moment due to the merge window. Please
>> wait two weeks before reposting, by which time net-next will be open
>> again.

Hi, Andrew Lunn,

Understand, and thanks for your reminding!

> Your email threading also seems to be broken, there is no
> threading. That might cause pathworks an issue.
Sometimes it doesn't work, but I also receive email from email list.
So I can read your email from email list although something is broken.
Thanks again！

wuych

>
> 	Andrew

