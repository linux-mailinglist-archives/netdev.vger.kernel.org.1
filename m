Return-Path: <netdev+bounces-228092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C445BC14EE
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 14:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3953034E80F
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD092D97A0;
	Tue,  7 Oct 2025 12:07:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9B2D5C97;
	Tue,  7 Oct 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838872; cv=none; b=BoNJP10ol1/E6anzhl6pHNQ8xgPUNSd0a3PFjrm7ktOEg0DZ9TftpXWhg+wrSn7GWHaMXA03a6HUYx3/jglDi4iMkjzXrWfIj4dLkA8DqkxvmJZ+dt1lGcv+dQJ0UHG1g8wql/rPnHjEYP3oW9Zn9NbzqweclNrokRxELZOThGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838872; c=relaxed/simple;
	bh=Acme0zZaYGYhgMzcQcSrHiZpudbZHw6ERYGh8/xYTN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S52wYzolKsChlLxzNYWLYf3d/nt1uhaJyuPYmuAOBnXPh8/pc5e0aXt37xali7HD1JSMLH26WEZnMX1IPOoJ4otXxxO0jlBy8qKUCswPA3LTyIEImy/zOMoT0A5WAg7kSUdRrfmGmyQbS4/LBKMYVeyKCBpDGJpEYAu7oElhMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.12.217] (g217.RadioFreeInternet.molgen.mpg.de [141.14.12.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A09D060288276;
	Tue, 07 Oct 2025 14:06:56 +0200 (CEST)
Message-ID: <355b43c3-fb0b-4e94-b49f-a008843f1267@molgen.mpg.de>
Date: Tue, 7 Oct 2025 14:06:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix LAN memory regions
 command on some NVMs
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Chittim Madhu
 <madhu.chittim@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251007114624.9594-1-larysa.zaremba@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251007114624.9594-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Larysa,


Am 07.10.25 um 13:46 schrieb Larysa Zaremba:
> IPU SDK versions 1.9 through 2.0.5 require send buffer to contain a single
> empty memory region. Set number of regions to 1 and use appropriate send
> buffer size to satisfy this requirement.

Where are the SDK requirements documented?

What are the current SDK versions?

Do you have a reproducer?

> Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index fa3ce1e4f6ac..af8b3ebee4d4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -1016,6 +1016,9 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>   	struct idpf_vc_xn_params xn_params = {
>   		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
>   		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
> +		.send_buf.iov_len =
> +			sizeof(struct virtchnl2_get_lan_memory_regions) +
> +			sizeof(struct virtchnl2_mem_region),
>   		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
>   	};
>   	int num_regions, size;
> @@ -1028,6 +1031,8 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>   		return -ENOMEM;
>   
>   	xn_params.recv_buf.iov_base = rcvd_regions;
> +	rcvd_regions->num_memory_regions = cpu_to_le16(1);
> +	xn_params.send_buf.iov_base = rcvd_regions;
>   	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
>   	if (reply_sz < 0)
>   		return reply_sz;


Kind regards,

Paul

