Return-Path: <netdev+bounces-192954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CB2AC1D80
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2D1BA2E49
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46621B9C8;
	Fri, 23 May 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ73satF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BE21B8F6;
	Fri, 23 May 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747984755; cv=none; b=JOB+sCKLMPH22ZxJqIAZx/eIuRmyZ2ZfdM4hbiNdmNzSw/ANV/PXnkjs1XQqEVmHHUE3YfcY0OSGtuiWW9ABMbjmMtsUyHKvTkZmGxutH7MeLaTVDu2bX6F8U0efA0k50/26sW4kRDNun3CQqm1LTtnM1QF1aj07rSnnjHqDtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747984755; c=relaxed/simple;
	bh=cF6q0OF3ObaHB4048Y7VWI+YiR+Cr3QfGImat8OqjCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ68lSZ2y3mRcmBUHJ8j3V1pk3DJG/oIcMTfwG0ZMhcMzXnoKh8VlNd9pSfTajk9dYl/KsuTlZEEdJFPHFQmQT2SZPg5wyG4lhfWRXPE6QUTuxK4ecTw8TfCxLHKKeZUsrwLPQ2fNKOOg2A1M8qeOFECGNtdqkT68GMdBv8xwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ73satF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55332C4CEE9;
	Fri, 23 May 2025 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747984754;
	bh=cF6q0OF3ObaHB4048Y7VWI+YiR+Cr3QfGImat8OqjCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJ73satFuXTVEnH5OOyw4KCJMCaxYOiGZR8TXbSN/JMNLWnpB1UJmybPYUWEWmktx
	 sssB2YYTB/4C79MWep/M2+eVRjjEn7Yrt/z1+60+jMAE80IUNfTG2tco2a7sWORlpX
	 rGEfL6OyqpLXLPISo9spiY2n1qucO9tTV0JhrPH+CJUN126EKjcYrzjVdNEEJEm61k
	 TlhgoETlYeSNm8W3xM8vMuJ+HeVZmbIH7CRPMN2P22cFLgF4LZiv/uY6pGrcDG/Unk
	 LVe2FjiQmkIAnpz4wJPG97oK1k9BKAlripxiXM+H9Fzc9fJItWvuxWR/5knm3zvlsp
	 JMaCSY6kgnGVg==
Date: Fri, 23 May 2025 08:19:09 +0100
From: Simon Horman <horms@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [External] : Re: [PATCH] ixgbe: Fix typos and clarify comments
 in X550 driver code
Message-ID: <20250523071909.GO365796@horms.kernel.org>
References: <20250522074734.3634633-1-alok.a.tiwari@oracle.com>
 <20250522172108.GK365796@horms.kernel.org>
 <ce71fa5a-32c0-4cc2-b537-5849d9bdea69@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce71fa5a-32c0-4cc2-b537-5849d9bdea69@oracle.com>

On Thu, May 22, 2025 at 11:41:00PM +0530, ALOK TIWARI wrote:
> Hi Simon,
> 
> Thanks for Your review.
> 
> On 22-05-2025 22:51, Simon Horman wrote:
> > > @@ -1754,7 +1754,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
> > >   	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
> > >   	/* If no SFP module present, then return success. Return success since
> > > -	 * SFP not present error is not excepted in the setup MAC link flow.
> > > +	 * SFP not present error is not accepted in the setup MAC link flow.
> > I wonder if "excepted" was supposed to be "expected".
> 
> 
> Yes, "expected" definitely reads more naturally. However, I noticed that in
> one place, the comment uses "accepted" instead — perhaps to imply a policy
> or behavior enforcement.

Understood. I did hesitate in writing my previous email as I'm not entirely
sure what the intention was. I do agree that accepted makes sense.
And I'm happy to keep that in the absence of more information.

> 
> ------------------
> static int
> ixgbe_setup_mac_link_sfp_x550em(struct ixgbe_hw *hw,
>                                 ixgbe_link_speed speed,
>                                 __always_unused bool
> autoneg_wait_to_complete)
> {
>         bool setup_linear = false;
>         u16 reg_slice, reg_val;
>         int status;
> 
>         /* Check if SFP module is supported and linear */
>         status = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
> 
>         /* If no SFP module present, then return success. Return success
> since
>          * there is no reason to configure CS4227 and SFP not present error
> is
>          * not accepted in the setup MAC link flow.
>          */
>         if (status == -ENOENT)
> --------------------
> 
> > 
> > >   	 */
> > >   	if (ret_val == -ENOENT)
> > >   		return 0;
> > > @@ -1804,7 +1804,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
> > >   	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
> > >   	/* If no SFP module present, then return success. Return success since
> > > -	 * SFP not present error is not excepted in the setup MAC link flow.
> > > +	 * SFP not present error is not accepted in the setup MAC link flow.
> > Ditto.
> > 
> > >   	 */
> > >   	if (ret_val == -ENOENT)
> > >   		return 0;
> > The above notwithstanding, this looks good to me.
> > 
> > Reviewed-by: Simon Horman<horms@kernel.org>
> 
> 
> Thanks,
> Alok
> 

