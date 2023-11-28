Return-Path: <netdev+bounces-51802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECA7FC390
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 19:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5D3B210F8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190153D0A5;
	Tue, 28 Nov 2023 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B40109
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 10:39:31 -0800 (PST)
Received: from [192.168.0.183] (ip5f5af0c0.dynamic.kabel-deutschland.de [95.90.240.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 174B561E5FE03;
	Tue, 28 Nov 2023 19:39:10 +0100 (CET)
Message-ID: <aa574a42-ebd9-4bda-abe0-a85d969a8eef@molgen.mpg.de>
Date: Tue, 28 Nov 2023 19:39:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: Print NIC FW version
 during init
Content-Language: en-US
To: Sachin Bahadur <sachin.bahadur@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20231128183505.1338736-1-sachin.bahadur@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231128183505.1338736-1-sachin.bahadur@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sachin,


Thank you for the patch.

Am 28.11.23 um 19:35 schrieb Sachin Bahadur:
> Print NIC FW version during PF initialization. FW version in dmesg is used
> to identify and isolate issues. Particularly useful when dmesg is read
> after reboot.

Please paste one example log line into the commit message.

> Reviewed-by: Pawel Kaminski <pawel.kaminski@intel.com>
> Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 1f159b4362ec..71d3d8cfdd1d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4568,6 +4568,12 @@ static int ice_init_dev(struct ice_pf *pf)
>   		dev_err(dev, "ice_init_hw failed: %d\n", err);
>   		return err;
>   	}
> +	dev_info(dev, "fw %u.%u.%u api %u.%u.%u nvm %u.%u 0x%08x %u.%u.%u\n",
> +		 hw->fw_maj_ver, hw->fw_min_ver, hw->fw_patch, hw->api_maj_ver,
> +		 hw->api_min_ver, hw->api_patch, hw->flash.nvm.major,
> +		 hw->flash.nvm.minor, hw->flash.nvm.eetrack,
> +		 hw->flash.orom.major, hw->flash.orom.build,
> +		 hw->flash.orom.patch);
>   
>   	/* Some cards require longer initialization times
>   	 * due to necessity of loading FW from an external source.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

