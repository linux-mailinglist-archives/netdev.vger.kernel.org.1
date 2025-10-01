Return-Path: <netdev+bounces-227495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63EEBB1289
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EC41947489
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D527F00F;
	Wed,  1 Oct 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR12RdOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A091149C7B
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333452; cv=none; b=WAkMokMH7dORGG9XiXslmMXIryOMci9jWtJd3vVBJpoIV7NJUevrQMzCtYdxme6+6LL7GkejJXRxwA4NQbsqpE2ROgLHN5bojiD2mAjpLifuM5YhwsJiwL8MssU+CDbDe1dKoHJGxXXr9UVOTZzqzb49dRhluUxVYAFlMjop1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333452; c=relaxed/simple;
	bh=4uGLSlfl7grkABSuCWMiHF3qY7ZyGsOvz+I6a9PdYWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlx1DmJ67a+yufpSGfvRDWgSNOssgUUfvCIHNdnYrP8oB5JiEasT+4HVZG8bbppJ4/yUkiuGMQC2clQC/L1qAB6KjXLAZiJDXgiBNTGWYuKLifwNoLuOi486bEjvF130Q5Ny5XJcrFKyedUxxBjp1bATDEQ8sNNtGINbPhj830Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR12RdOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F13DC4CEF1;
	Wed,  1 Oct 2025 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333451;
	bh=4uGLSlfl7grkABSuCWMiHF3qY7ZyGsOvz+I6a9PdYWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JR12RdODcxsZVdbjCmhrl/803IIftzd/ojXb7N4QSQu0qagxnLnuBi1uN/sijpANp
	 u/EdPXjGe7tMfKJh3LsUtlPcpjPZ7Wj6I9565mZ+YQJkHolXjptK5MQD+BLoG2xjMd
	 CgWyAwwZqYgOiNjH8MY5PpoBB56w2ITWEmPkTJhst06YZwmDsaB70QY8YZX92pEIRO
	 dz6Jwk9DUPAamai0pYjp1BOF5XnworWkfheQ6hN9jtGHSGmPxWdE9pB/2HvChw55gQ
	 gIaAYT4eTtsNeWCtqP2N/q2ePualTb6ciRFKniGNd4RunYlF1G/IVG7LObMKXCy9b3
	 AZflh673d8Obg==
Date: Wed, 1 Oct 2025 16:44:08 +0100
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 iwl-net 2/2] idpf: fix issue with ethtool -n command
 display
Message-ID: <aN1MSIO27C24q-gL@horms.kernel.org>
References: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
 <20250930212352.2263907-3-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930212352.2263907-3-sreedevi.joshi@intel.com>

On Tue, Sep 30, 2025 at 04:23:52PM -0500, Sreedevi Joshi wrote:
> From: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
> 
> When ethtool -n is executed on an interface to display the flow steering
> rules, "rxclass: Unknown flow type" error is generated.
> 
> The flow steering list maintained in the driver currently stores only the
> location and q_index but other fields of the ethtool_rx_flow_spec are not
> stored. This may be enough for the virtchnl command to delete the entry.
> However, when the ethtool -n command is used to query the flow steering
> rules, the ethtool_rx_flow_spec returned is not complete causing the
> error below.
> 
> Resolve this by storing the flow spec (fsp) when rules are added and
> returning the complete flow spec when rules are queried.
> 
> Also, change the return value from EINVAL to ENOENT when flow steering
> entry is not found during query by location or when deleting an entry.
> 
> Add logic to detect and reject duplicate filter entries at the same
> location and change logic to perform upfront validation of all error
> conditions before adding flow rules through virtchnl. This avoids the
> need for additional virtchnl delete messages when subsequent operations
> fail, which was missing in the original upstream code.
> 
> Example:
> Before the fix:
> ethtool -n eth1
> 2 RX rings available
> Total 2 rules
> 
> rxclass: Unknown flow type
> rxclass: Unknown flow type
> 
> After the fix:
> ethtool -n eth1
> 2 RX rings available
> Total 2 rules
> 
> Filter: 0
>         Rule Type: TCP over IPv4
>         Src IP addr: 10.0.0.1 mask: 0.0.0.0
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 0 mask: 0xffff
>         Action: Direct to queue 0
> 
> Filter: 1
>         Rule Type: UDP over IPv4
>         Src IP addr: 10.0.0.1 mask: 0.0.0.0
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 0 mask: 0xffff
>         Action: Direct to queue 0
> 
> Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> Signed-off-by: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
> Co-developed-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


