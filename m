Return-Path: <netdev+bounces-16743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B637574EA2D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8932814C0
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773917754;
	Tue, 11 Jul 2023 09:20:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38817723
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:20:55 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 6C57F1BD2;
	Tue, 11 Jul 2023 02:20:52 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id BFBE76062ABFD;
	Tue, 11 Jul 2023 17:20:29 +0800 (CST)
Message-ID: <c9b37dac-7f13-210b-23f7-57ece0f7d1c6@nfschina.com>
Date: Tue, 11 Jul 2023 17:20:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 00/10] Remove unnecessary
 (void*) conversions
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 irusskikh@marvell.com, rmody@marvell.com, skalluru@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, yisen.zhuang@huawei.com,
 salil.mehta@huawei.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, steve.glendinning@shawell.net,
 iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, mostrows@earthlink.net, xeb@mail.ru,
 qiang.zhao@nxp.com, uttenthaler@ems-wuensche.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linuxppc-dev@lists.ozlabs.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: yunchuan <yunchuan@nfschina.com>
In-Reply-To: <f1f9002c-ccc3-a2de-e4f5-d8fa1f8734e3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/11 16:53, Paul Menzel wrote:
> Dear Su,
>
>
> Thank you for your patch.
>
> Am 10.07.23 um 08:38 schrieb Su Hui:
>> From: wuych <yunchuan@nfschina.com>
>
> Can you please write the full name correctly? Maybe Yun Chuan?
>
>     git config --global user.name "Yun Chuan"
>     git commit --amend --author="Yun Chuan <yunchuan@nfschina.com>"

Dear Paul Menzel,

Thanks for your reminder!
I have already changed this  to my full name "Wu Yunchuan".
Should I resend all these patches to change the author name?
> I only got the cover letter by the way.
> s
Maybe the network met some problems.
I will send this patchset to you separately.

Wu Yunchuan

>
> Kind regards,
>
> Paul
>

