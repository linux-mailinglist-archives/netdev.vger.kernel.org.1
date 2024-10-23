Return-Path: <netdev+bounces-138167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A159AC766
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8655E281F65
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26219E961;
	Wed, 23 Oct 2024 10:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEF19D8A8;
	Wed, 23 Oct 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678081; cv=none; b=XwB5i9a5XVdW9N9l9Ox7H6d2F0OSPRTZDEG/K0/4tJbf9lDGXQrXD1AZEIeGHCfDD33iONvxFlHOEBpK9uQgJZzZdKUTH3k905iHh9M+QvT5I2VTNiR24D5jG2vubOKLKTtcpfOPU+OSW5KApffhD3Zm23ehEsQozWtfDEQ4biw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678081; c=relaxed/simple;
	bh=Um9wWeTpi2FA8+/imAlkC8DCSIcWIMMm8Du0TfwLqdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTjShI5z08zSSHDssOa8P2MtmeDT55vCFN702kgJKdVU9t3G6Teb7jBqABv+0zbvIEK61RW1QATGt732+Y/8PeOtvPH2tG+JJNdfyZgXSLGxpob88V1XIx3g5oZj16SABKLozYPW8NgZYlPAycbbBsuRnEcvS7sMjdwMDnQmxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeec7.dynamic.kabel-deutschland.de [95.90.238.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 66258600AA698;
	Wed, 23 Oct 2024 12:07:07 +0200 (CEST)
Message-ID: <fd443617-0460-4c44-84a1-3563c0c76033@molgen.mpg.de>
Date: Wed, 23 Oct 2024 12:07:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/3] pldmfw: selected
 component update
To: Konrad Knitter <konrad.knitter@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, Marcin Szycik <marcin.szycik@linux.intel.com>
References: <20241023100702.12606-1-konrad.knitter@intel.com>
 <20241023100702.12606-2-konrad.knitter@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241023100702.12606-2-konrad.knitter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Konrad,


Thank you for your patch.

Am 23.10.24 um 12:07 schrieb Konrad Knitter:
> Enable update of a selected component.

It’d be great if you used that for the summary/title to make it a 
statement (by adding a verb in imperative mood).

It’d be great, if you elaborated, what that feature is, and included the 
documentation used for the implementation. Also, how can it be tested?

> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> ---
>   include/linux/pldmfw.h | 8 ++++++++
>   lib/pldmfw/pldmfw.c    | 8 ++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
> index 0fc831338226..f5047983004f 100644
> --- a/include/linux/pldmfw.h
> +++ b/include/linux/pldmfw.h
> @@ -125,9 +125,17 @@ struct pldmfw_ops;
>    * a pointer to their own data, used to implement the device specific
>    * operations.
>    */
> +
> +enum pldmfw_update_mode {
> +	PLDMFW_UPDATE_MODE_FULL,
> +	PLDMFW_UPDATE_MODE_SINGLE_COMPONENT,
> +};
> +
>   struct pldmfw {
>   	const struct pldmfw_ops *ops;
>   	struct device *dev;
> +	u16 component_identifier;
> +	enum pldmfw_update_mode mode;
>   };
>   
>   bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
> diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
> index 6e1581b9a616..6264e2013f25 100644
> --- a/lib/pldmfw/pldmfw.c
> +++ b/lib/pldmfw/pldmfw.c
> @@ -481,9 +481,17 @@ static int pldm_parse_components(struct pldmfw_priv *data)
>   		component->component_data = data->fw->data + offset;
>   		component->component_size = size;
>   
> +		if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
> +		    data->context->component_identifier != component->identifier)
> +			continue;
> +
>   		list_add_tail(&component->entry, &data->components);
>   	}
>   
> +	if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
> +	    list_empty(&data->components))
> +		return -ENOENT;
> +
>   	header_crc_ptr = data->fw->data + data->offset;
>   
>   	err = pldm_move_fw_offset(data, sizeof(data->header_crc));


Kind regards,

Paul

