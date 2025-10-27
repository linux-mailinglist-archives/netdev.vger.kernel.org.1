Return-Path: <netdev+bounces-233134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D987C0CE13
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8378E404E53
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91662F6905;
	Mon, 27 Oct 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE1ta6m8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDED2F6569;
	Mon, 27 Oct 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559240; cv=none; b=FosGXDaZPjPEZ7lIm8MoLIjPFFZkyCFD/WAhrRTIFUzSX2ZerVak3+X5cIuQMfdoKXK+D65rPAfrXD70O3jwKDQndJaHPVW7ep1T1wOfZiizYfdbMLEktS6QCZk1wZNde3GNjxuSBQBDfOJMM90fOnydgh4sjVNtcoeJAGzo2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559240; c=relaxed/simple;
	bh=+xMfW2hYgWUM+DUd/Q4D7QQsf+nszvvdVnL2yFSt6Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1q9OVcFzP8WlOBpokrrfQNNJhww9GAQeavnfc/st7D0Ljgi/5H70ElHfb8TjKULDcc3utb4Zy3JQeFl1hJ1jpf9uhKPE1DxgYgmCtIxmNlrc2o/Hhae2aki/owaUxsH2y4lTwQbLxQQYFlQlcJ9M21/FQF4WZ1chZCRQ2K8UEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE1ta6m8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B176C4CEF1;
	Mon, 27 Oct 2025 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559240;
	bh=+xMfW2hYgWUM+DUd/Q4D7QQsf+nszvvdVnL2yFSt6Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pE1ta6m8XcyYS8r7GxUKvmy90HBEUoOVw0WeiSEQFRic39Eb48KbfkpRdvEiattVv
	 9HBcZOPx1q8E2EF2ouxuxabXs4FyhCMjux40rwGbDExeUXsvebwwwB8dNFJqiYGrw4
	 KOsi6eJ/wViCTdhET2xPpgZycWT1jBvnFlrAH8Of8gZysWvhCrpm2UOK9DHEcWf9z2
	 BSnldWQENrlL8uC/LDI8iKzPjFMa2rBD0YxcULT5G9YT/ZT7lzVck8Uh0XDgrP/fpt
	 GI8Ki4TK5sM9Ie9UmqFIUC/ogAppt66+uEACikr7o+8YemGff3sH2QgpR5cd5pr0+h
	 ma2igso0Uf1lg==
Date: Mon, 27 Oct 2025 10:00:32 +0000
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v01 1/9] hinic3: Add PF framework
Message-ID: <aP9CwKkLdgcqHvkc@horms.kernel.org>
References: <cover.1760502478.git.zhuyikai1@h-partners.com>
 <905df406fd870da528361f47c48067802588cfb5.1760502478.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905df406fd870da528361f47c48067802588cfb5.1760502478.git.zhuyikai1@h-partners.com>

On Wed, Oct 15, 2025 at 03:15:27PM +0800, Fan Gong wrote:
> Add support for PF framework based on the VF code.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> index 979f47ca77f9..2b93026845ff 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> @@ -117,17 +117,49 @@ int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
>  					 &func_tbl_cfg);
>  }
>  
> +#define PF_SET_VF_MAC(hwdev, status) \
> +	(HINIC3_IS_VF(hwdev) && (status) == HINIC3_PF_SET_VF_ALREADY)
> +

nit: I think the above could be a function rather than a macro.

...

> @@ -157,9 +189,9 @@ int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
>  		return -EIO;
>  	}
>  
> -	if (mac_info.msg_head.status == MGMT_STATUS_PF_SET_VF_ALREADY) {
> +	if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
>  		dev_warn(hwdev->dev, "PF has already set VF mac, Ignore set operation\n");
> -		return 0;
> +		return HINIC3_PF_SET_VF_ALREADY;

It seems to me that this custom return value can be propagated up
and returned by the probe function. If so, this doesn't seem desirable.
And, overall, I would recommend against the custom calling convention
that custom return values imply.

>  	}
>  
>  	if (mac_info.msg_head.status == MGMT_STATUS_EXIST) {

...

