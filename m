Return-Path: <netdev+bounces-183358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520BA907E6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DD85A17B6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC21A08A0;
	Wed, 16 Apr 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIbXq5Rf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAED40849
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818108; cv=none; b=eMjZEkp8CR5Jvs/kv7uxam5Ib471YisRLUgPq/sE3fEK6l05QZu+/k4gZKO+DdFxe5ch2g2g7ukY4FU8ntQILHvzKa0JGv8BhgzfZKrbmEJ37rIQAOFpEjyotGZNElWuTHwJ9moBuUJbViCgd9wjyvc/8mlnBEi0DjriYdQ7Gnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818108; c=relaxed/simple;
	bh=vQNpjmpFpTsHsEWunk4OoC7WEKC5Hn03PMynv3OZZgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eri3eN83KTAaFIpM1hn6vrJGRPqcx+J7ZUMVYe6EjcXXqs6eKOpefzlX/aRO2TUc5NZAp5WRQjRSfylIZVvmewb0uFcCrhwgNycHbzy2MptRWBk4QQ9LzFUNkjfLEBoYozurk/jR6ogatvWs+dbJmdDkKpn5bYrqcT0cCq43De8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIbXq5Rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D03C4CEE2;
	Wed, 16 Apr 2025 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744818108;
	bh=vQNpjmpFpTsHsEWunk4OoC7WEKC5Hn03PMynv3OZZgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIbXq5Rf0HiKSulusgu7kAbaQvSZzlyI1M1o8/JFXWug16EbyLGZpscDMsEx+nZgi
	 Rma4Ms96IbQqP2p4+qDexz1E7eglSpZCpJu2sfMRWVrmUZ1GPh1sRHcWwoC4mLMZt5
	 5CBiw3s3ibKb5noF7YniwSyV5vxgi5sEvCuBXbttJ7KD71a5W4PXd5MRH/RaltzvTT
	 WLA0O5Gs8ZX53DHoT0mMlMlH6S5uGUYeZTplfHF/C5dDFNlWoat70zsFij2PSS97vD
	 XkB+s/k9FenNxMdYVAJWV9CBwSCPUgyVVuOo/OQOp4j+R+ZKevbUZ/JLfcWI2a417t
	 lGDlmmMki2qLQ==
Date: Wed, 16 Apr 2025 16:41:44 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <20250416154144.GT395307@horms.kernel.org>
References: <20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org>

On Tue, Apr 15, 2025 at 09:27:21AM +0200, Lorenzo Bianconi wrote:
> The official Airoha EN7581 firmware requires adding max_packet filed in
> ppe_mbox_data struct while the unofficial one used to develop the Airoha
> EN7581 flowtable offload does not require this field. This patch fixes
> just a theoretical bug since the Airoha EN7581 firmware is not posted to
> linux-firware or other repositories (e.g. OpenWrt) yet.
> 
> Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..16201b5ce9f27866896226c3611b4a154d19bc2c 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -104,6 +104,7 @@ struct ppe_mbox_data {
>  			u8 xpon_hal_api;
>  			u8 wan_xsi;
>  			u8 ct_joyme4;
> +			u8 max_packet;
>  			int ppe_type;
>  			int wan_mode;
>  			int wan_sel;

Hi Lorenzo,

I'm a little confused by this.

As I understand it ppe_mbox_data is sent as the data of a mailbox message
send to the device.  But by adding the max_packet field the layout is
changed. The size of the structure changes. And perhaps more importantly
the offset of fields after max_packet, e.g.  wan_mode, change.

Looking at how this is used, f.e. in the following code, I'm unclear on
how this change is backwards compatible.

static int airoha_npu_ppe_init(struct airoha_npu *npu)
{
        struct ppe_mbox_data ppe_data = {
                .func_type = NPU_OP_SET,
                .func_id = PPE_FUNC_SET_WAIT_HWNAT_INIT,
                .init_info = {
                        .ppe_type = PPE_TYPE_L2B_IPV4_IPV6,
                        .wan_mode = QDMA_WAN_ETHER,
                },
        };

        return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
                                   sizeof(struct ppe_mbox_data));
}

