Return-Path: <netdev+bounces-45925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C127E0712
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D91B21390
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7671C6AE;
	Fri,  3 Nov 2023 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6mgJybq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362F749C
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 16:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825A1C433C7;
	Fri,  3 Nov 2023 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699030618;
	bh=9r2Teb9LmUKE38493V8+tN4Nwput4XeDIrc8Gf3eW4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6mgJybqE9ukoRP1F84YJOboWy6zKjdoQ13Zwa7L9xQroBO/5O9WRjjdWLZFJ7Fdf
	 vQAZ0SQRHDBf0DxXOZSeAaNYm6oApvVye545UYR3nfw9XOxV3eACSwxHbr61hSJtk+
	 OuO8oxRWbUW8htMl2mqcrnqH3xHEbTLcpLUaTj9tUYCZOiadJkYeLZR7NkPi84qaC3
	 AehMV8F0Wj3yfjXQ3xMK69KQPv2gfJgRaOmXaJOotgkg46jRfyUhLoMP2pjsV2hce8
	 YMKl7hLVHIddvWK6JdkEP1NMiMOaJG81/FAau3aP0INwtJE4VMJRJihE6lJ3IlieCx
	 aANRaMeyAljUA==
Date: Fri, 3 Nov 2023 16:56:54 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	yahui.cao@intel.com, jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com, marcin.szycik@linux.intel.com
Subject: Re: [PATCH iwl-next v1] ice: change vfs.num_msix_per to vf->num_msix
Message-ID: <20231103165654.GC714036@kernel.org>
References: <20231024142010.175592-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024142010.175592-1-michal.swiatkowski@linux.intel.com>

On Tue, Oct 24, 2023 at 04:20:10PM +0200, Michal Swiatkowski wrote:
> vfs::num_msix_per should be only used as default value for
> vf->num_msix. For other use cases vf->num_msix should be used, as VF can
> have different MSI-X amount values.
> 
> Fix incorrect register index calculation. vfs::num_msix_per and
> pf->sriov_base_vector shouldn't be used after implementation of changing
> MSI-X amount on VFs. Instead vf->first_vector_idx should be used, as it
> is storing value for first irq index.
> 
> Fixes: fe1c5ca2fe76 ("ice: implement num_msix field per VF")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

