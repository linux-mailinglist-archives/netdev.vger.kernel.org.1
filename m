Return-Path: <netdev+bounces-35381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE47A93C0
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D08EB20975
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFEF947B;
	Thu, 21 Sep 2023 11:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697F946D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E967DC4AF6F;
	Thu, 21 Sep 2023 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695294557;
	bh=2kCSV6P6YfeKSmCvyz6qPCQfpRAvSYHPQsHOVANhBmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W76eLcPAw4H/BBi1wsSNGxZjZFUI3sArOoZWHS+54hEC0lrQ0mn+HZUhhD8bddLl3
	 vzsdCSFXS0E3diGzNDIUcTsOcTDN4aR1RccVZZEDtJepz0vIXJVtjHzC0qSaRmCuvJ
	 NTIlJoXiIHSrs42tUlRzfiZGrW3Xk6Z164Vfsjt6HV0rP9096saieHSLRW8IMmTEqq
	 X+GgsgNB2o3Owq4bRZzrYLaLfvnKNkcbaEiedgx4M7gYJkCdYWiIyIxzoUPbz9uwqH
	 UE/0/hy5KPo5ry9BXXh+GLc58TUBkRUy/xECrNjb4XqwWJoQwbR1RinkJOD18trAUk
	 njLkZPgI38MCQ==
Date: Thu, 21 Sep 2023 12:09:11 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	leon@kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH] [Intel-wired-lan][PATCH iwl-next v2] ice: store VF's
 pci_dev ptr in ice_vf
Message-ID: <20230921110911.GJ224399@kernel.org>
References: <20230912115626.105828-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912115626.105828-1-mateusz.polchlopek@intel.com>

On Tue, Sep 12, 2023 at 07:56:26AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Extend struct ice_vf by vfdev.
> Calculation of vfdev falls more nicely into ice_create_vf_entries().
> 
> Caching of vfdev enables simplification of ice_restore_all_vfs_msi_state().
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


