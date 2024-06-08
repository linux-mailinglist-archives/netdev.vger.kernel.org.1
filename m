Return-Path: <netdev+bounces-102014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AC390118B
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D681C20BB9
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0BA178370;
	Sat,  8 Jun 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0gAAVdi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B2178362
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851488; cv=none; b=j+wF88mu6eH/cuM6+dH4ZlpNZizIWqzBANI0bvkSzKjyBNET9WS+wHXKxz9bXbwQip3x5qPlQpcBEerSI232U3psgxuCRip9xKMbxPkbPVqixzD+TQNFK+NdvtT6cXKroNbr/bqqp8rB0RhWhj0SlsposwmZOyVK2yFPwHSmk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851488; c=relaxed/simple;
	bh=PRZGzRzXBZNnTRWY00hkQeI11V75QSfAxDrfYrcrius=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPgNcS/JTe00vXALvocbSrwRH6954yoJAXmzR/RyPVMMjnZ80Ku6Rjyl8RkF2H4kWmFV0+o4bjhwp7wS7rJpFKhkC9gtzlZAdENMvYV2ot6EpXqW7lmHZ+x/vdKC/JsptRaw/7sGxQEWWRrNbXs17ObIG7YpBdFQrXlMLyTU5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0gAAVdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69F8C2BD11;
	Sat,  8 Jun 2024 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851488;
	bh=PRZGzRzXBZNnTRWY00hkQeI11V75QSfAxDrfYrcrius=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0gAAVdinC5OSMDSUyxdUGCjZXTpEYE5rEk7L3QUZpOxwl7tstOZgqBRgguwtS3Xk
	 +SRFy61xtrHQfphDEAxZfbVfvd3bT6Pd+UVulV7PtyIBAlaQccaGi1nCmQRA8kXRSf
	 rhKojg0HEMkZAlB1u5mKrd3OgUm9akXWp66V3auMF31jgWF1+tedk8vNq9tM7332dl
	 CYG995UWiPv+NvVjJLRL+6F/fkrpOkA+tcBasQwg4OBRtiL0lQi+OB6I3KncWm1AF5
	 8ikrv3j326CLO1FJVpSEFQPiAsgOWdIYRnLpboC3Crk2tIP5oS7rFqix1xFUPWsn5J
	 VQ4kPymKoo+AQ==
Date: Sat, 8 Jun 2024 13:58:04 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 04/12] iavf: add support
 for negotiating flexible RXDID format
Message-ID: <20240608125804.GW27689@kernel.org>
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

Reviewed-by: Simon Horman <horms@kernel.org>


