Return-Path: <netdev+bounces-154301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53559FCB57
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528321628BB
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2561BD9E4;
	Thu, 26 Dec 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ehxrl31X"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F53647;
	Thu, 26 Dec 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735222438; cv=none; b=YRd70jW2VSFBJalfoGajbqk3vllqKg5qcPCa1ldkTyVtGX432c0rI0ipQxXWs0Qgb92M2UdWUS6KJFjj7Pgan3wJRkaSeMrS0rCr1cSUL9sAMCs9mol4p2qPpET5Uxo6CTzpMbRC3C6wYdnM22Zqw7WzrVLcrUEx/UK5ASi8fnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735222438; c=relaxed/simple;
	bh=gtOjdG786VyjFT5sY4lI7TMOpBqCZrWcCDAfKe5bHbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRwhlpLW5KUzPBgKCmWXFPym3c3BXr6AMJ+OXt/NmXjAjMAHvfAH8f0JCbm7+/+45fvR6JpKez/ezVBzSybynGdqseLzhONJCOnwFMXHmfKX/3O6l5NYTKUnhcgtkY1JYwfoFZAlkjyNbzlZyy3H89HRdjaW6MNsi0iY1xBvn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ehxrl31X; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Q6mxqG9UwKNRBKZlkuxVYoHOmhJWMbJHiF9VfBhjYXw=; b=Ehxrl31XCvYC3aCE
	HvEFeJD63NvSKL5M+2eanYtmWfkT+9BkL5YJ85UsDLh/xNgdftmIurpz2rSMHqGH2AdWydazqpETl
	OAPQhmn1GAgsqoOQgVvbaVhDcKtG0y1vVbJlp4rmUoT+tq4hNvKojakCAmt1bU5zn0pN4hCSr2XWn
	HRypCrZ8AckhSss3c0a9PYzAZZnxch8QJGabpKU2Xlhqy0IioJMWDYF/nonMoZETxszRE2tsh3DzH
	F9XLuakQGEwT3JcZ2QgEj4CL/tIcEUqohfRH0RbSFibVuHzOILsiNWBi6Q79lm8eGLk4Pck663gBK
	VDmEH6A6uTm39kwMCw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tQocW-007Hn0-0J;
	Thu, 26 Dec 2024 14:13:48 +0000
Date: Thu, 26 Dec 2024 14:13:48 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: kys@microsoft.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <Z21knM7ASMbu1ZHT@gallifrey>
References: <20241226140923.85717-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241226140923.85717-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:13:24 up 232 days,  1:27,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Oops, forgot to cc in kys@microsoft.com:

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
> commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")
> 
> but has remained unused.
> 
> The functions it references are still referenced elsewhere.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |  1 -
>  drivers/net/ethernet/intel/ixgbevf/mbx.c     | 12 ------------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index 130cb868774c..a43cb500274e 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -439,7 +439,6 @@ extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
>  extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
>  extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
>  extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
> -extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
>  
>  /* needed by ethtool.c */
>  extern const char ixgbevf_driver_name[];
> diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.c b/drivers/net/ethernet/intel/ixgbevf/mbx.c
> index a55dd978f7ca..24d0237e7a99 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/mbx.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/mbx.c
> @@ -505,15 +505,3 @@ const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy = {
>  	.check_for_ack	= ixgbevf_check_for_ack_vf,
>  	.check_for_rst	= ixgbevf_check_for_rst_vf,
>  };
> -
> -/* Mailbox operations when running on Hyper-V.
> - * On Hyper-V, PF/VF communication is not through the
> - * hardware mailbox; this communication is through
> - * a software mediated path.
> - * Most mail box operations are noop while running on
> - * Hyper-V.
> - */
> -const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops = {
> -	.init_params	= ixgbevf_init_mbx_params_vf,
> -	.check_for_rst	= ixgbevf_check_for_rst_vf,
> -};
> -- 
> 2.47.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

