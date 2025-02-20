Return-Path: <netdev+bounces-168166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC16A3DD87
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827463A00D7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063F1D618E;
	Thu, 20 Feb 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQGaiDz8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C041D5CFD;
	Thu, 20 Feb 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063512; cv=none; b=V41yaG+JAqzim17tWHsysggatypv02044ZdZ4Pdy5O0TJvvWqSoogEpmXPgSNg3mGdSfhC8OVNcNGJhJfRR1MOf9Lm2p0MtWhgN4EqKJ+Ny81XeR2HEGhh5t3gvBiII3VlmgfCT8zw1C0CSOzOgiSbvJA9L3RbKNt1nPzSYDIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063512; c=relaxed/simple;
	bh=/tfx1qw2RHTeEteUmz3XyOvcWQ/CBxZI1aQubqaoy9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq3/87Q5cJ7n5Mqqz9OaEMF4n/OR648FiaY1KB0rTaRVIsoAZtnDxOill7p8rNvU6sILO/2FMwUioCX5YUsWLImd64ud4Yduxl8mDhloLYx6bErKMi6gjfhsIm24Gf3PXLPmfGXZRbQHcQYKRqntlvRr3VOxbF4FU+smPJ3lYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQGaiDz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C84EC4CED1;
	Thu, 20 Feb 2025 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063512;
	bh=/tfx1qw2RHTeEteUmz3XyOvcWQ/CBxZI1aQubqaoy9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQGaiDz8BhXds1NsVdgsL5C5QKPMG2nNe3+dsJXy+s8MR0iMZZLsdM+YnCzeM/jwe
	 eW/HWx/i1fTV8mbN7OQ1vv0nK4GdaWL0wNw4vvW7GW03tfWGZfmX80HjlM+cg44TC3
	 XiGEJqJ+1iCvX0EE1iRhddMS97BAtY17/nG45aOfpAtK9V8Q+BMJ5i4pTD7Ke3IE/3
	 OSCD10I3dQdyD8mbJU2KwyIdWsJ3YI3VeMr3soOiRGLiqL4p7Qh4Ne05/rfqCzFlyp
	 rLbP6N2wk/eyeuADd5XRRo1LPgELVDjZEl6aoyk0N+DZC6S9UdIZ/U/k+XPUz48qWj
	 gavE5LtITPd0Q==
Date: Thu, 20 Feb 2025 14:58:27 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: Re: [PATCH iwl-next v4 4/6] ice: remove headers argument from
 ice_tc_count_lkups
Message-ID: <20250220145827.GB1615191@kernel.org>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-5-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214085215.2846063-5-larysa.zaremba@intel.com>

On Fri, Feb 14, 2025 at 09:50:38AM +0100, Larysa Zaremba wrote:
> Remove the headers argument from the ice_tc_count_lkups() function, because
> it is not used anywhere.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


