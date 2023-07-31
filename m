Return-Path: <netdev+bounces-22860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E6769A5F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13661C20C6F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20B18C1D;
	Mon, 31 Jul 2023 15:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74818C17
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:08:48 +0000 (UTC)
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4910EB;
	Mon, 31 Jul 2023 08:08:46 -0700 (PDT)
Message-ID: <c545bc4f-6fe9-eca4-535e-2380fd639ea3@gentoo.org>
Date: Mon, 31 Jul 2023 11:08:41 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] rtc: ds1685: use EXPORT_SYMBOL_GPL for
 ds1685_rtc_poweroff
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Ulf Hansson
 <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20230731083806.453036-1-hch@lst.de>
 <20230731083806.453036-4-hch@lst.de>
From: Joshua Kinard <kumba@gentoo.org>
In-Reply-To: <20230731083806.453036-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/2023 04:38, Christoph Hellwig wrote:
> ds1685_rtc_poweroff is only used externally via symbol_get, which was
> only ever intended for very internal symbols like this one.  Use
> EXPORT_SYMBOL_GPL for it so that symbol_get can enforce only being used
> on EXPORT_SYMBOL_GPL symbols.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/rtc/rtc-ds1685.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 0f707be0eb87fa..04dbf35cf3b706 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -1432,7 +1432,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>   		unreachable();
>   	}
>   }
> -EXPORT_SYMBOL(ds1685_rtc_poweroff);
> +EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
>   /* ----------------------------------------------------------------------- */
>   
>   

Acked-by: Joshua Kinard <kumba@gentoo.org>


