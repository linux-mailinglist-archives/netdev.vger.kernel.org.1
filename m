Return-Path: <netdev+bounces-136031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A829A0017
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 06:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9A41F260E5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778B188731;
	Wed, 16 Oct 2024 04:17:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DE4204D
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052265; cv=none; b=NXbgTV2eH3VkWKHvtqhhwt7u/JuWf29Bzv3bLA7Htbottu+Q/gSztLQy5FTpWbOG8GoOPcA2bQ2Gm/BkS6bZciReD4gSFRohP+k+sibHmdyJWCdHDBSQoSt2GWZRvh8svAqH6iiBMf2OG3wy/qRb1x+MBxiMS8m5mj0YXxTX3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052265; c=relaxed/simple;
	bh=c39NLr0D/YOUQUeYP6LcikwSkSonEBtSdpM1B8QPgvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjhScH5MjTteEAxXdgO/VqQSY5f46v+fz94cmTTselU7GA3s2jxZtIuLAX3aim+tUa68Upi0lyS6WnU66+MGuya2hhutoYOdQNM3oGv3sOBxgQkXdYf6NXsPii//q9zWW/UJUwa1yyzQTmnl0STMq724lYqiJ3xN2he5ne1WVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae84f.dynamic.kabel-deutschland.de [95.90.232.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C8A7261E5FE05;
	Wed, 16 Oct 2024 06:16:56 +0200 (CEST)
Message-ID: <2aa7370c-648d-4353-8f49-555af4391d6b@molgen.mpg.de>
Date: Wed, 16 Oct 2024 06:16:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] virtchnl: fix m68k build.
To: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Paolo,


Thank you for the patch. I’d remove the dot/period at the end of the 
summary/title though, and maybe I’d be also more specific:

virtchnl: Introduce padding field to fix m68k build

Am 15.10.24 um 15:56 schrieb Paolo Abeni:
> The kernel test robot reported a build failure on m68k in the intel
> driver due to the recent shapers-related changes.
> 
> The mentioned arch has funny alignment properties, let's be explicit
> about the binary layout expectation introducing a padding field.
> 
> Fixes: 608a5c05c39b ("virtchnl: support queue rate limit and quanta size configuration")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410131710.71Wt6LKO-lkp@intel.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   include/linux/avf/virtchnl.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
> index 223e433c39fe..13a11f3c09b8 100644
> --- a/include/linux/avf/virtchnl.h
> +++ b/include/linux/avf/virtchnl.h
> @@ -1499,6 +1499,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
>   
>   struct virtchnl_quanta_cfg {
>   	u16 quanta_size;
> +	u16 pad;
>   	struct virtchnl_queue_chunk queue_select;
>   };

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

