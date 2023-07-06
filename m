Return-Path: <netdev+bounces-15931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A8574A7B6
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 01:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2787280C32
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4AD168BF;
	Thu,  6 Jul 2023 23:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1ED2E9
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 23:29:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5FAB9;
	Thu,  6 Jul 2023 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=f9sZIfUgYTr1DblItYc9uUM3d2fixVGsi3Vy+MfgJ/g=; b=hufHYw9k12YtMfcjZHguIfXDWh
	D9cWiHR5YXNFBYQ2P+Brw1tgKlwxfeErZiV+r59wykNfxUue0MEw8C7rKaFZn378Cqwkmz1uyYBgr
	SvkkgKRJs0mBzLOo85lH+V8+FKkokYxxOLZEiR2B9LTZ2o3U+qtQ9eXY4/xbRZsMP2LbBKgPR0skL
	rARH3/LCpYXU1GEcr8SiAZYAyJVwFxRzKAQDq6MHNxKBSllYdaxduBFROGQh8J6LbESLRi4ybBw92
	HFJ9qAixDodzOITTIkUUld9ppsd/fD8Mbp9ZH/ObjlJlMzb85eBCWr6ItFyO1ssvT+erC9vg9reZZ
	QMvn9qDw==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qHYPf-002xpz-1q;
	Thu, 06 Jul 2023 23:29:27 +0000
Message-ID: <e2be9c20-4e0c-7880-ba0d-11b8f2c5404c@infradead.org>
Date: Thu, 6 Jul 2023 16:29:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: Tree for Jul 4
 (drivers/net/ethernet/microchip/lan743x_main.c)
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 Network Development <netdev@vger.kernel.org>, UNGLinuxDriver@microchip.com,
 Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>
References: <20230704134336.4c5d1772@canb.auug.org.au>
 <725bf1c5-b252-7d19-7582-a6809716c7d6@infradead.org>
 <ZKc2DLIroSNi4tgs@corigine.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZKc2DLIroSNi4tgs@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

On 7/6/23 14:45, Simon Horman wrote:
> + Pavithra Sathyanarayanan
> 
> On Tue, Jul 04, 2023 at 03:25:31AM -0700, Randy Dunlap wrote:
>>
>>
>> On 7/3/23 20:43, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do *not* add any v6.6 related stuff to your linux-next included
>>> branches until after v6.5-rc1 has been released.
>>>
>>> Changes since 20230703:
>>>
>>
>> on s390:
>>
>> s390-linux-ld: drivers/net/ethernet/microchip/lan743x_main.o: in function `lan743x_phy_open':
>> drivers/net/ethernet/microchip/lan743x_main.c:1514: undefined reference to `fixed_phy_register'
>>
>>
>> Full randconfig file is attached.
> 
> Thanks for the config.
> 
> I bisected this problem and it appears to be introduced by:
> 
> 624864fbff92 ("net: lan743x: add fixed phy support for LAN7431 device")
> 
> I wonder if the following change in dependencies is an appropriate fix for
> this problem.

Yes, that change fixes the build error. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> 
> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> index 24c994baad13..329e374b9539 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -46,7 +46,7 @@ config LAN743X
>         tristate "LAN743x support"
>         depends on PCI
>         depends on PTP_1588_CLOCK_OPTIONAL
> -       select PHYLIB
> +       select FIXED_PHY
>         select CRC16
>         select CRC32
>         help
> 

-- 
~Randy

