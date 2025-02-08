Return-Path: <netdev+bounces-164264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E36A2D291
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B00188BE7A
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4C1DDE9;
	Sat,  8 Feb 2025 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAClaqM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548A2941C
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977462; cv=none; b=VHURJpL4bJFXt8rqWVob2GcakKOYcrmyM0I/rXeIVNBXNmhgbiNXxG0gmnECFfCxsk+4KSD6PU237+hDaTl5mFvEQ7MP9Q90O4GsSI398nCV4wTD6dxHpbxOBdwaIl+k2zdclKI0nTlVrvWRJ0ZISLVcv8vPkzLj/olA9U7KSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977462; c=relaxed/simple;
	bh=8go0K19rHG4znXWdLSjjsVe1WOQEmsS6YfquwLlt3q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7pTMBGp5r9ICvyEqEW4su5BnM1+Y70XJ+SI0IGRDSJWLLwVafH9+Wxkx640fMgcGPLGHLz/xpGgCBTjMK+4jbA8ez7yIvgG8UT7GZiyCqS7c3pABXgM/izCEe297o6OFtuvPQyTkTodfPDt0duKVQluFWCwM+OsdTqQ3xdh/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAClaqM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65B8C4CED1;
	Sat,  8 Feb 2025 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738977460;
	bh=8go0K19rHG4znXWdLSjjsVe1WOQEmsS6YfquwLlt3q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qAClaqM3nXXZghVStgryrAmNy1+ZetwAnBDjL3ApSX9z51THfnQesMoQmauM3m/kS
	 oBlBr+NEDHIJAtDIl/YXNdymNZm17OOs3pFZ9qfllzEj2Hcx6xqz6hmCXgZPBM6zn8
	 R8AftNNlfJ3CdpkA7OlUeErD55w2y/2xuLQIVr9PbqSCx/D8oHrIMIqf4Z21vgYmL7
	 kbhocImhcdrc9AETuK9bgbDKqL1v7qWNkP1w4Pf7u+6nBobv1rMP/TDG69Vn8sYNlp
	 CYqdKg2srPAiac5iQ3vK2LDC0jO3HCtnVQewlVlWUDirsWmpV+rYO/Q+3J9IvjhAWv
	 BcQycE4GMSIfA==
Date: Fri, 7 Feb 2025 17:17:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mengyuanlou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v7 4/6] net: libwx: Add msg task func
Message-ID: <20250207171739.7ab11585@kernel.org>
In-Reply-To: <20250206103750.36064-5-mengyuanlou@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
	<20250206103750.36064-5-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 18:37:48 +0800 mengyuanlou wrote:
> +static int wx_negotiate_vf_api(struct wx *wx, u32 *msgbuf, u32 vf)
> +{
> +	int api = msgbuf[1];
> +
> +	switch (api) {
> +	case wx_mbox_api_10 ... wx_mbox_api_13:
> +		wx->vfinfo[vf].vf_api = api;
> +		return 0;
> +	default:
> +		wx_err(wx, "VF %d requested invalid api version %u\n", vf, api);
> +		return -EINVAL;
> +	}
> +}

How "compatible" is your device with IXGBE?

static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,                
                                  u32 *msgbuf, u32 vf)                          
{                                                                               
        int api = msgbuf[1];                                                    
                                                                                
        switch (api) {                                                          
        case ixgbe_mbox_api_10:                                                 
        case ixgbe_mbox_api_11:                                                 
        case ixgbe_mbox_api_12:                                                 
        case ixgbe_mbox_api_13:                                                 
        case ixgbe_mbox_api_14:                                                 
                adapter->vfinfo[vf].vf_api = api;                               
                return 0;                                                       
        default:                                                                
                break;                                                          
        }                                                                       
                                                                                
        e_dbg(drv, "VF %d requested unsupported api version %u\n", vf, api);    
                                                                                
        return -1;                                                              
}                                                                               

