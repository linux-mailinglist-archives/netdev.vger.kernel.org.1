Return-Path: <netdev+bounces-102011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC225901185
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E961C20EC8
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC25176FC0;
	Sat,  8 Jun 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBH9ukbS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4226AF5
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851394; cv=none; b=oBMEl8vXGpZWwewKJ2bkl33esPjWfj0W1fX2uiikjle5kKcNNOF2wZLBek6z1VE8k8GOiqPwXyfd4yI9uAyIxDCZXcNTMKVeGEtXROeOksNF8XaiYvGUtSicHCFxD/YTE7wBQ9A9RB3aSjHtD3C7Rb70nCYJMFD2OTbxgzJBFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851394; c=relaxed/simple;
	bh=/RlJo9WnsSn1XLBS9ggjnNyuELQapyKJA1TQXRzbb/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1o/Rd/hzd8QajY8vDEUoTUn7BKIs21LJIcumGubiXJFreOrxIJ5z88t9rjc4/Hm1mfl7rLYFp0g2ZZYlhaaTvam7V8Gpe2FskWQLG/ISWgh6q9RGmoNsd9KIxfKnVp/gFFoE/qXikVrCNpt9BcybuMAEzoXPzmSrGdDPKVhQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBH9ukbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F367C2BD11;
	Sat,  8 Jun 2024 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851394;
	bh=/RlJo9WnsSn1XLBS9ggjnNyuELQapyKJA1TQXRzbb/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBH9ukbS+pWltnD58a99574ux2Cqp7Oj2cdcLWswGA2JX7apSIvtPjkWOdWPaG1E+
	 oDiVmlmInCaW2MyLR60rOxKAk1RT+WHCNgFLoVU58N7sfcZKuwSkM+T7kKBzTjvhiJ
	 mlL/F8+D9em/5xi22XWCluelGmndMDzaapIxrAtKkJ2jeujVkc5X7e5fDSOJEjpdm5
	 O5GObw10hWQgcYFqOZxbvlpdnicVv2O7Og3DRSXv2/9Yi2oQ2CewXCC3UcGq6mNWLJ
	 RL+WTz0lRQlfYxCqVwlcgmrmUjA24fN6YY7dqohz7CYvksAJ4ObMcpcziFF1ux5Eaw
	 +e7kLoD6PrHPw==
Date: Sat, 8 Jun 2024 13:56:30 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 04/12] iavf: add support
 for negotiating flexible RXDID format
Message-ID: <20240608125630.GT27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-5-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-5-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:52AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Enable support for VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC, to enable the VF
> driver the ability to determine what Rx descriptor formats are
> available. This requires sending an additional message during
> initialization and reset, the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS. This
> operation requests the supported Rx descriptor IDs available from the
> PF.
> 
> This is treated the same way that VLAN V2 capabilities are handled. Add
> a new set of extended capability flags, used to process send and receipt
> of the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS message.
> 
> This ensures we finish negotiating for the supported descriptor formats
> prior to beginning configuration of receive queues.
> 
> This change stores the supported format bitmap into the iavf_adapter
> structure. Additionally, if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is enabled
> by the PF, we need to make sure that the Rx queue configuration
> specifies the format.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Hi Mateusz, Jacob, all,

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -262,6 +276,45 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
>  	return err;
>  }
>  
> +int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter)
> +{
> +	struct iavf_hw *hw = &adapter->hw;
> +	struct iavf_arq_event_info event;
> +	enum virtchnl_ops op;
> +	enum iavf_status err;
> +	u16 len;
> +
> +	len =  sizeof(struct virtchnl_supported_rxdids);
> +	event.buf_len = len;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
> +	if (!event.msg_buf) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	while (1) {
> +		/* When the AQ is empty, iavf_clean_arq_element will return
> +		 * nonzero and this loop will terminate.
> +		 */
> +		err = iavf_clean_arq_element(hw, &event, NULL);
> +		if (err != IAVF_SUCCESS)
> +			goto out_alloc;
> +		op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
> +		if (op == VIRTCHNL_OP_GET_SUPPORTED_RXDIDS)
> +			break;
> +	}
> +
> +	err = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
> +	if (err)
> +		goto out_alloc;
> +
> +	memcpy(&adapter->supported_rxdids, event.msg_buf, min(event.msg_len, len));

If you need to respin for some other reason,
please consider wrapping the above to <= 80 columns wide.

Likewise for the 2nd call to iavf_ptp_cap_supported() in
iavf_ptp_process_caps() in
[PATCH v7 06/12] iavf: add initial framework for registering PTP clock

Flagged by: checkpatch.pl --max-line-length=80

> +out_alloc:
> +	kfree(event.msg_buf);
> +out:
> +	return err;
> +}
> +
>  /**
>   * iavf_configure_queues
>   * @adapter: adapter structure

...

