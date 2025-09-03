Return-Path: <netdev+bounces-219572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB610B42014
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668CC5E7054
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829730103D;
	Wed,  3 Sep 2025 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUBDokaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352E3002CE
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903880; cv=none; b=rlow4SEbTVtn70hckDWh2EuWf1iRsWJ0FobO4Kz/5ArNtdscAqnj956rRp1xIKgonfC3K0CTZ5Js5KF5gwIPerrJJWnzvs0a9XnAehXwm9Jko2hiAGjFLiZwbUa1mX7K+sXP0nS4qw4L6MTzM/r2FBgNU282JGfOCrfKdfRlXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903880; c=relaxed/simple;
	bh=N0Bcbv50hPYmO0pEUw7i4h6uGwwARCZteWWx5lzuoA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIoQrpyVYKFRFOBaG6bxgWAG6D8RUgFiaM8SFn0m+D4AIOuXeIu3odN64iWbKgf/MNBG3FwwTR+WAHyScAEOuh1Kg6nGg72e6PGa/Yf4BH40nG2K20MLXM3c0uUX1NgR1z5xLcQ6Vs7kJFfgNcSWj0RaezD3jgb9eu33GwPXpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUBDokaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786CCC4CEF0;
	Wed,  3 Sep 2025 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756903879;
	bh=N0Bcbv50hPYmO0pEUw7i4h6uGwwARCZteWWx5lzuoA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUBDokaF6DcRW6QH3ytrPJc5Q3LTxaGR/svJowJby3x46AlPy6/W2GNLnU99o8CPY
	 pOZtlgu2L/P1Dh7xaDM30wX+ibdRjQc7fMNqZuvV9FN6Y146cv9Qo/3iD/fSU34h+z
	 hHRr0kFfuTTLlWifjj1amhusdu7OSItEdR/VfbbtwO3D3WdlaTZGtB2/8znjLDJ/12
	 tf0LrIrJBupxpgPdezyypVbZQMEbOBrcdSPQxAnvdTeFWnfdIk86j2/QdOMk6K2uSm
	 DHQrdgdM87VYCAlhuNoGkwUc68xVnFDF9CarupugnMgLZVxIQLz1JKeZKGfnERety8
	 4g6OmGJG9JrEA==
Date: Wed, 3 Sep 2025 13:51:16 +0100
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, madhu.chittim@intel.com,
	netdev@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net-next v4] idpf: add support for IDPF PCI programming
 interface
Message-ID: <20250903125116.GC361157@horms.kernel.org>
References: <20250903035853.23095-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903035853.23095-1-pavan.kumar.linga@intel.com>

On Tue, Sep 02, 2025 at 08:58:52PM -0700, Pavan Kumar Linga wrote:
> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
> on our current generation hardware. Future hardware exposes a new set of
> device IDs for each generation. To avoid adding a new device ID for each
> generation and to make the driver forward and backward compatible,
> make use of the IDPF PCI programming interface to load the driver.
> 
> Write and read the VF_ARQBAL mailbox register to find if the current
> device is a PF or a VF.
> 
> PCI SIG allocated a new programming interface for the IDPF compliant
> ethernet network controller devices. It can be found at:
> https://members.pcisig.com/wg/PCI-SIG/document/20113
> with the document titled as 'PCI Code and ID Assignment Revision 1.16'
> or any latest revisions.
> 
> Tested this patch by doing a simple driver load/unload on Intel IPU E2000
> hardware which supports 0x1452 and 0x145C device IDs and new hardware
> which supports the IDPF PCI programming interface.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Hi Pavan,

Should this be targeted at iwl, where it applies cleanly,
rather than net-next, where it does not.

If the later, I think that a rebase and repost is appropriate.

...

