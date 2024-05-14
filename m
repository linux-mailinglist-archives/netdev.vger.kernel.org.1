Return-Path: <netdev+bounces-96316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A928C4F29
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBFF1F211DA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC913C689;
	Tue, 14 May 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiC7SazM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982A133402
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680603; cv=none; b=nT8CmL79Yh895hTIft1dolkow861CGr+fVqB5RG+CtMRhct2ZGQCWmz+W6cuuUCSmTel/nQ7sZx2OaOUK7ceLZJPNFINjbCY8L0JKa4udTt1vK7SvWEbPEHBtg7vLlD3/0WCQsX+cB1rPuDDUBzNPl2o8OKDl+M8wHBuRpDNpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680603; c=relaxed/simple;
	bh=gZrU37Bnrk2g/V7MyPmOEN+NfkYpCEkrj9K5YIMfcxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU2g3TMqWWn2UmTz1VxWoGAfwzbHGrl4yOQ7l553wCO2/YkY15Y1oJK8CU3uZ4mLbAO+GqOlEDFIY2CXLfNNUZZTFOwSMeBfZc35yaYw0IkDscfU6+Qqq5uwfy6MsnZJYUUbmOY0jTVPUnXdgSyyYo9jQsdL1rFCZ61vJvfubiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiC7SazM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD32C2BD10;
	Tue, 14 May 2024 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715680602;
	bh=gZrU37Bnrk2g/V7MyPmOEN+NfkYpCEkrj9K5YIMfcxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiC7SazMf72R5Ui1qCY3ZLZ6O0jD6kv9YD5T30415oP2P5Ti1wh6PHAh8jf50wXIg
	 Z1Podplr0v5ollmJ+NGZYEYApS+l25VfuKmTFvEoSuF3Q/MHq6ZegK+gzG5VWgQhE5
	 hnBH1fViJ8pHHTB6V8iT1pLyTNR8GPnvyQennhrHzNDIDC4Qgxxlcf9o7B1Tc8XSyo
	 CumnP4fe6RLeZAYHAcK+g6Ka73ssGBKiDonZkka6yP3papouIVHz7auawGWKN7xH3w
	 I+udsNmC74ndX3ymphtodX9PoIuQWkcHsgmlGD8wiw9OMLDy3IBFD0PxuTpfbmHRNC
	 BZFaHGGcHiPSA==
Date: Tue, 14 May 2024 10:55:05 +0100
From: Simon Horman <horms@kernel.org>
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, rob.thomas@ibm.com
Subject: Re: [PATCH iwl-net V2,0/2] Fix repeated EEH reports in MSI domain
Message-ID: <20240514095505.GZ2787@kernel.org>
References: <20240513175549.609-1-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513175549.609-1-thinhtr@linux.ibm.com>

On Mon, May 13, 2024 at 12:55:47PM -0500, Thinh Tran wrote:
> The patch fixes an issue where repeated EEH reports with a single error
> on the bus of Intel X710 4-port 10G Base-T adapter in the MSI domain
> causes the device to be permanently disabled.  It fully resets and
> restarts the device when handling the PCI EEH error.
> 
> Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
> introduced.  These functions were factored out from the existing
> i40e_suspend() and i40e_resume() respectively.  This factoring was
> done due to concerns about the logic of the I40E_SUSPENSED state, which
> caused the device not able to recover.  The functions are now used in the
> EEH handling for device suspend/resume callbacks.
> 
> - In the PCI error detected callback, replaced i40e_prep_for_reset()
>   with i40e_io_suspend(). The change is to fully suspend all I/O
>   operations
> - In the PCI error slot reset callback, replaced pci_enable_device_mem()
>   with pci_enable_device(). This change enables both I/O and memory of 
>   the device.
> - In the PCI error resume callback, replaced i40e_handle_reset_warning()
>   with i40e_io_resume(). This change allows the system to resume I/O 
>   operations
> 
> v2: fixed typos and split into two commits

Hi,

These patches look good to me, but I think it would be worth adding parts
of the text above to the commit messages of each patch. This will make the
information easier to find in git logs in future.

> 
> Thinh Tran (2):
>   i40e: fractoring out i40e_suspend/i40e_resume
>   i40e: Fully suspend and resume IO operations in EEH case
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 257 +++++++++++---------
>  1 file changed, 140 insertions(+), 117 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

