Return-Path: <netdev+bounces-178819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD6A790A5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDF71887F41
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7A33993;
	Wed,  2 Apr 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNM0G15I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA817BA9;
	Wed,  2 Apr 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602521; cv=none; b=tWQtgDfXhsaMeBTIMf//4IwXbmPe65yszO8uvCi8mtOYl/CRxMqDCyDn+MTBoH2Eo4wWZJr0E/Kru2GzHWi91OxUzk18oVE9tNJKHSOnx0R0p4plMT/ORZn7mpgeKOC+6toLC+z8JrCWWJvTr1wj5mt2naLZU+PaJt7CBwpUNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602521; c=relaxed/simple;
	bh=qv4cI4IVPumb8gQlQrRDmy3higF3YPD27DBX4liEeVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC2ITNCp6FOSWQtIeOXBxOP9p77++2DOx9ekhxqvXedWxIVS+vT3Mnmnx8swYzZR7oDyDW0z1CIYcS0cPgo/ih/blNswn2R+G603VQGg5Rpw79izgRBAjHb6MXgLo4D/0kks3jsLMce7hc1lNV1d2V41ibc27sz71xMSxf+2pYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNM0G15I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A434EC4CEDD;
	Wed,  2 Apr 2025 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602520;
	bh=qv4cI4IVPumb8gQlQrRDmy3higF3YPD27DBX4liEeVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNM0G15I0imaT8eiWhXWeyPjobe4XO9GumN5JmqtiLmjDyCVar0EjcxzmJzetBLyD
	 PXYUadepbQEkoMg61BBcuxBNhF2aXIeRDQJceZJfCp7mpnNWLRycMXYoxomQrDAcEA
	 a6hQ5yTmBAt63YSH3J5uc0hA98Ff4RbW/PJgpGV6DE5h2ThLxx+cWn+lRy8rdNbbKf
	 zsTUuVifUEUGR2faKBbR/OZ2yBS55Q6OeHyRVIi6M8B9bIpaYcHAlcdUaBIMPkfNZQ
	 0q91nJyDaljd+rlI6urFClTI1VuponIAD3OorNf743e5TfO+8kK06lu44TSgSBhAN4
	 J1r6TgdQtV8yw==
Date: Wed, 2 Apr 2025 15:01:55 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: hns3: store rx VLAN tag offload state for VF
Message-ID: <20250402140155.GR214849@horms.kernel.org>
References: <20250402121001.663431-1-shaojijie@huawei.com>
 <20250402121001.663431-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402121001.663431-4-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 08:10:01PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> The VF driver missed to store the rx VLAN tag strip state when
> user change the rx VLAN tag offload state. And it will default
> to enable the rx vlan tag strip when re-init VF device after
> reset. So if user disable rx VLAN tag offload, and trig reset,
> then the HW will still strip the VLAN tag from packet nad fill
> into RX BD, but the VF driver will ignore it for rx VLAN tag
> offload disabled. It may cause the rx VLAN tag dropped.
> 
> Fixes: b2641e2ad456 ("net: hns3: Add support of hardware rx-vlan-offload to HNS3 VF driver")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
> index cccef3228461..1e452b14b04e 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
> @@ -252,7 +252,8 @@ struct hclgevf_dev {
>  	u16 *vector_status;
>  	int *vector_irq;
>  
> -	bool gro_en;
> +	u32 gro_en :1;
> +	u32 rxvtag_strip_en :1;

FWIIW, as there is space I would have used two bools here.

>  
>  	unsigned long vlan_del_fail_bmap[BITS_TO_LONGS(VLAN_N_VID)];
>  
> -- 
> 2.33.0
> 

