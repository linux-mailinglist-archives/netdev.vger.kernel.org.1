Return-Path: <netdev+bounces-232639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8FC07815
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFEC04E840E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677A332EAB;
	Fri, 24 Oct 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI1/mNXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F53330B35
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326038; cv=none; b=tjlGr/l9Cck9jdvWD0qXu6DlLfltD1DJ7CVJ58O1OBw+Nnfb7j+FlcYkATH5+64d9qnkU5Wv78Y65SO+dUFEVXqMyV+O90zCfs6CLLTfXRUzGt6KeX8cJwiQTwaM59Wm2u6QobeY86GOONWoAtOHZlRPVjd8WPCYirVa/Dc7ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326038; c=relaxed/simple;
	bh=vCj3JyBSagu2BqdN1iDi3uOBOf1FnuZwAY/n0Ks53ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGAGT2EGDdgrSDEMakZTQ1NNf6S9zjAAlRyH0jXolMPp7wQMZpXajcS3u5jkZo8u8Dg0Sb9wmQjO3KSgP8DHXjS3xwrgpXJdqyQaF/fLGJKpsYoNP+dVcVZEr+AdTFVf8PndjujCEcYjUV1k5tET0RtZYeOWOe2dIlS5hHofIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI1/mNXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F04C4CEF1;
	Fri, 24 Oct 2025 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761326038;
	bh=vCj3JyBSagu2BqdN1iDi3uOBOf1FnuZwAY/n0Ks53ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qI1/mNXqXdn+lotnU3ZMMjED/0E+/BBICY9wHwkh/vP62PWqpehsYDdw1axxAP+GN
	 exemOjBLewYW/tFcATTDwK00dKJuYGQ3dLmmAhEXFj309nMCAQsrlcoZnL/QAeunOk
	 ylFPgW2+3LJjvseLYXFTCrxe+riMdWO1tjXwRpXEsfwPiSTZdv8ZVhxYsaDL9LID8e
	 DMToEoGIPpZve+ktGTXwZfC0XmWM9rIluBIGnoq61vboIIPEmOhDo70RaLNrAnakBN
	 0o1VCLiiQ3PNprdZD3F7TCNrzohbk8kIQr6MBZsOPu3iRH9d7Bf555OBE2XJQst8un
	 ToE5MsogqDcaA==
Date: Fri, 24 Oct 2025 18:13:53 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] iavf: fix incorrect warning message in
 iavf_del_vlans()
Message-ID: <aPuz0XU-GBgp3uZj@horms.kernel.org>
References: <20251024134636.1464666-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024134636.1464666-1-alok.a.tiwari@oracle.com>

On Fri, Oct 24, 2025 at 06:46:26AM -0700, Alok Tiwari wrote:
> The warning message refers to "add VLAN changes" instead of
> "delete VLAN changes". Update the log string to use the correct text.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 34a422a4a29c..6ad91db027d3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -987,7 +987,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
>  
>  		len = virtchnl_struct_size(vvfl_v2, filters, count);
>  		if (len > IAVF_MAX_AQ_BUF_SIZE) {
> -			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
> +			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
>  			while (len > IAVF_MAX_AQ_BUF_SIZE)
>  				len = virtchnl_struct_size(vvfl_v2, filters,
>  							   --count);

Thanks, this seems to be a copy-paste error as the text being
updated also appears in the preceding function in this file,
iavf_add_vlans().

Reviewed-by: Simon Horman <horms@kernel.org>


