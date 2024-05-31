Return-Path: <netdev+bounces-99806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6D8D68DE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5AB1F27370
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE7F17CA1E;
	Fri, 31 May 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeiSYweg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671AA77F0B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179466; cv=none; b=GabT/0baL+6jTpi+V6a1wJt5DAN5uDOWP2KhvVh4KQoIsujaF1aZh/uaVxNrtthwg5NVGgCcJKy/2QPCKzYtoBBNdqBMhx1wQr1co8oaK9yiTZHUNPFh0TCAbOCXvaXQ7p8MuW8Kr8tiVzZH6ssSlv6GK8AVgA2cycEX+C8PHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179466; c=relaxed/simple;
	bh=kZalsnTLkULIt/uoTSoEVR5Xcsq+eao/sF0mdh4bSUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt9uwZyR4Kke2JLxk2zuaeDPZtem7L76MmHd0OoKWtAFEip6VsSeaS4n+WJRzWoyhACyNpZljcfD6uFNJebdVnr5nnX+ZIVzG+n20WWszdd0NTh16B8tMQa6lc+Nk5rNLTu4CXuDpJclpNs6J8xtGHfLvdumP1RKDfCiIlbwFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeiSYweg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243CEC2BD10;
	Fri, 31 May 2024 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179466;
	bh=kZalsnTLkULIt/uoTSoEVR5Xcsq+eao/sF0mdh4bSUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeiSYwegPxhgwyKi9QkHsyhngUpyoSInWyP+jWgjHPH6dqTs3HnDVqKN9gpgb1xXY
	 +r6lo59nFv7IM0Ddv+6nDR8xROVs/ZzJmR3NBAMQurb/oKdBq4D2DMsejfTNElLFqD
	 PsaaB3XHgUuctooJBUUK0d/2tISSCDFJuF7Gdhlu0b3OWdSqUGTT+BsHgMR2poSq6g
	 Q1VD1lb9KvpGcmhyngLc1dVZ1vkQvkHxAQmncdNywg6WYCot3/JfdSUbPpil1hcofV
	 07tXSd39f+I5ILZJBfV/62GhmsgykNsFnUJwWYBYzkENgAn12Nye8I15J5TTf1SDRW
	 nNjRwDNJbwLhQ==
Date: Fri, 31 May 2024 19:17:41 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 11/15] ice: check if SF is ready in ethtool ops
Message-ID: <20240531181741.GN491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-12-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-12-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:09AM +0200, Michal Swiatkowski wrote:
> Now there is another type of port representor. Correct checking if
> parent device is ready to reflect also new PR type.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


