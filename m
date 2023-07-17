Return-Path: <netdev+bounces-18208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB8755CEB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83EA1C20A26
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7768831;
	Mon, 17 Jul 2023 07:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95569848D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:30:50 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 541FA187;
	Mon, 17 Jul 2023 00:30:46 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id E0DAA6077AB0A;
	Mon, 17 Jul 2023 15:30:33 +0800 (CST)
Message-ID: <f1e0ecfd-b9b3-2c4b-f548-c08f7615febe@nfschina.com>
Date: Mon, 17 Jul 2023 15:30:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next v3 8/9] can: ems_pci: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: yunchuan <yunchuan@nfschina.com>
In-Reply-To: <20230717-clash-kerchief-afdf910e2ce6-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/7/17 15:07, Marc Kleine-Budde wrote:
> On 17.07.2023 08:52:42, Marc Kleine-Budde wrote:
>> On 17.07.2023 11:12:21, Wu Yunchuan wrote:
>>> No need cast (void*) to (struct ems_pci_card *).
>>>
>>> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
>>> Acked-by: Marc Kleine-Budde<mkl@pengutronix.de>
>> Please add a space between my name and my e-mail address, so that it
>> reads:
>>
>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> nitpick:
>> You should add your S-o-b as the last trailer.
> BTW: The threading of this series is still broken. Make sure you send
> the whole patch series with one single "git send-email" command. For
> regular contribution you might have a look at the "b4" [1] tool.

Hi,

Thanks for you suggestions, I use 'git send-email' to send patch.
I messing up the patch's order in different patchset. This might be the
reason of the broken threading.
Really sorry for this, I will take careful next time.

Wu Yunchuan

> regards,
> Marc
>
> [1] https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1
>

