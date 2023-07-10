Return-Path: <netdev+bounces-16348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B974CDDD
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13ADF280EF5
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4D5239;
	Mon, 10 Jul 2023 07:03:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27729522B
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:03:38 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 877BFE9;
	Mon, 10 Jul 2023 00:03:35 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 05916602B2DE0;
	Mon, 10 Jul 2023 15:03:32 +0800 (CST)
Message-ID: <9b5eb66d-984b-51b5-1eeb-7e71773958f7@nfschina.com>
Date: Mon, 10 Jul 2023 15:03:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next v2 09/10] can: ems_pci: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: yunchuan <yunchuan@nfschina.com>
In-Reply-To: <bbd3da00-1b6e-9e47-e1a3-e9c050efb8aa@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/10 14:53, yunchuan wrote:
> On 2023/7/10 14:49, Marc Kleine-Budde wrote:
>> On 10.07.2023 14:41:38, Su Hui wrote:
>>> From: wuych <yunchuan@nfschina.com>
>>>
>>> Pointer variables of void * type do not require type cast.
>> I like the idea. Please add my Acked-by: Marc Kleine-Budde
>> <mkl@pengutronix.de>, after you've fixed the issue:
> that's great, I will do this.
> thanks:)!
>
> wuych
>
>>> Signed-off-by: wuych <yunchuan@nfschina.com>
>> This patch is not Signed-off-by the contributing person.
>>

Oh, sorry for this, I just mixed the email because of some careless reasons.
The send email <suhui@nfschina.com> is my co-worker.
But the contributing person is me, sorry again!

wuych


>> regards,
>> Marc
>>

