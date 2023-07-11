Return-Path: <netdev+bounces-16737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982A74E98E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67E7281450
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3770174F1;
	Tue, 11 Jul 2023 08:56:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1F168AE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:56:10 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ACEBF;
	Tue, 11 Jul 2023 01:56:08 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F44361E5FE01;
	Tue, 11 Jul 2023 10:53:08 +0200 (CEST)
Message-ID: <f1f9002c-ccc3-a2de-e4f5-d8fa1f8734e3@molgen.mpg.de>
Date: Tue, 11 Jul 2023 10:53:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 00/10] Remove unnecessary
 (void*) conversions
Content-Language: en-US
To: Su Hui <suhui@nfschina.com>
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
 yunchuan@nfschina.com, linuxppc-dev@lists.ozlabs.org
References: <20230710063828.172593-1-suhui@nfschina.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230710063828.172593-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Su,


Thank you for your patch.

Am 10.07.23 um 08:38 schrieb Su Hui:
> From: wuych <yunchuan@nfschina.com>

Can you please write the full name correctly? Maybe Yun Chuan?

     git config --global user.name "Yun Chuan"
     git commit --amend --author="Yun Chuan <yunchuan@nfschina.com>"

I only got the cover letter by the way.


Kind regards,

Paul


> Changes in v2:
> 	move declarations to be reverse xmas tree.
> 	compile it in net and net-next branch.
> 	remove some error patches in v1.
> 
> PATCH v1 link:
> https://lore.kernel.org/all/20230628024121.1439149-1-yunchuan@nfschina.com/
> 
> wuych (10):
>    net: wan: Remove unnecessary (void*) conversions
>    net: atlantic: Remove unnecessary (void*) conversions
>    net: ppp: Remove unnecessary (void*) conversions
>    net: hns3: remove unnecessary (void*) conversions
>    net: hns: Remove unnecessary (void*) conversions
>    ice: remove unnecessary (void*) conversions
>    ethernet: smsc: remove unnecessary (void*) conversions
>    net: mdio: Remove unnecessary (void*) conversions
>    can: ems_pci: Remove unnecessary (void*) conversions
>    net: bna: Remove unnecessary (void*) conversions
> 
>   drivers/net/can/sja1000/ems_pci.c             |  6 +++---
>   .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 12 ++++++------
>   .../atlantic/hw_atl2/hw_atl2_utils_fw.c       |  2 +-
>   drivers/net/ethernet/brocade/bna/bnad.c       | 19 +++++++++----------
>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  2 +-
>   drivers/net/ethernet/hisilicon/hns_mdio.c     | 10 +++++-----
>   drivers/net/ethernet/intel/ice/ice_main.c     |  4 ++--
>   drivers/net/ethernet/smsc/smsc911x.c          |  4 ++--
>   drivers/net/ethernet/smsc/smsc9420.c          |  4 ++--
>   drivers/net/mdio/mdio-xgene.c                 |  4 ++--
>   drivers/net/ppp/pppoe.c                       |  4 ++--
>   drivers/net/ppp/pptp.c                        |  4 ++--
>   drivers/net/wan/fsl_ucc_hdlc.c                |  6 +++---
>   13 files changed, 40 insertions(+), 41 deletions(-)

