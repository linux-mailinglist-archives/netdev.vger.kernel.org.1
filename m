Return-Path: <netdev+bounces-60423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9168881F244
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 22:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338D1B214DA
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A05E2CCCA;
	Wed, 27 Dec 2023 21:46:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84947F68
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.29.66.158] (93-34-6-18.ip47.fastwebnet.it [93.34.6.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4BB7861E5FE03;
	Wed, 27 Dec 2023 22:45:13 +0100 (CET)
Message-ID: <5ae1537b-73dc-45a1-94a7-669e63dc74db@molgen.mpg.de>
Date: Wed, 27 Dec 2023 22:45:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid compiler padding in
 virtchnl2_ptype struct
Content-Language: en-US
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com
References: <20231227173757.1743001-1-pavan.kumar.linga@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231227173757.1743001-1-pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pavan,


Thank you for yoru patch.

Am 27.12.23 um 18:37 schrieb Pavan Kumar Linga:
> Config option in arm random config file

Sorry, I do not understand this part of the sentence. What Kconfig 
option was selected exactly causing this behavior.

> is causing the compiler
> to add padding. Avoid it by using "__packed" structure attribute
> for virtchnl2_ptype struct.

Did the compiler emit a warning? If so, please paste it.

> Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/virtchnl2.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 8dc83788972..dd750e6dcd0 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -978,7 +978,7 @@ struct virtchnl2_ptype {
>   	u8 proto_id_count;
>   	__le16 pad;
>   	__le16 proto_id[];
> -};
> +} __packed;
>   VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
>   
>   /**

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>



Kind regards,

Paul

