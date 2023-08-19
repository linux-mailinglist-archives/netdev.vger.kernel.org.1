Return-Path: <netdev+bounces-29051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E7781768
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 07:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932D81C20E1E
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719317E6;
	Sat, 19 Aug 2023 05:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651F139F
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 05:03:31 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A133AAF
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:03:30 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aed0d.dynamic.kabel-deutschland.de [95.90.237.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 470C261E5FE01;
	Sat, 19 Aug 2023 07:03:06 +0200 (CEST)
Message-ID: <fd4b1f89-ffd5-421f-81bb-5715afaf7fca@molgen.mpg.de>
Date: Sat, 19 Aug 2023 07:03:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 7/7] ice: Enable support for
 E830 device IDs
To: Paul Greenwalt <paul.greenwalt@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
 <20230816235719.1120726-8-paul.greenwalt@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230816235719.1120726-8-paul.greenwalt@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Pawel, dear Paul,


Thank you for the patch.

Am 17.08.23 um 01:57 schrieb Paul Greenwalt:
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>

For the commit message summary, it sounds a little strange, how to 
enable support for a “device ID”. Maybe:

     ice: Add IDs of 4 E830 devices

or

     ice: Hook up 4 E830 devices by adding their IDs

> As the previous patches provide support for E830 hardware, add E830
> specific IDs to the PCI device ID table, so these devices can now be
> probed by the kernel.

If you could add a paragraph describing your test system and stating the 
test results, that would be very useful in my opinion.

> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d6715a89ec78..80013c839579 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5630,6 +5630,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
>   	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_10G_BASE_T)},
>   	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE)},
>   	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP)},
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE)},
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56)},
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP)},
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD)},
>   	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT)},

I’d add the entries after all E822 entries, so they are kind of sorted.

>   	/* required last entry */
>   	{ 0, }


Kind regards,

Paul

