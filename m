Return-Path: <netdev+bounces-67213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD38425E0
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B095F1C254C0
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332C6A32D;
	Tue, 30 Jan 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2uErQRl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465860876
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620319; cv=none; b=O06XlmmxEhshQyugTjg1EKboDbDVqQXfqZ1xSlJKBfGxiwu2qPj5qdeXCRBpiKPT5Jly/31oX7R2BGJFmE7a1SXVDJWBeIB6rj0wv9WHAcjU5xwKaKgqTMVNcaWQYzrLTrSPYWZNDOHgH5fwAlwJ204ghf6bPBZEbK5PeU/xHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620319; c=relaxed/simple;
	bh=EJ7lOS3Ds/Vj4BBISEpE3TpcTQc+OaYbGCsQqTvbFTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfwUfwrqkBZuhh1hseu1VVm/2JnRB/Wj4mjfH1jr7zkGv8GJSgtWKRn0VlrjK/38kOGvxPRuKpzIJtFafRUKQ17j/SXSz7IYUPURc5RyitlcDH8RjiWIBR/RuEFGHpdgTIW9fYFklow5jeeuS3LVwl4UBZFldzcGRQxpC2W4MgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2uErQRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12BAC433F1;
	Tue, 30 Jan 2024 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620318;
	bh=EJ7lOS3Ds/Vj4BBISEpE3TpcTQc+OaYbGCsQqTvbFTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2uErQRlD08eQ7ERt8Ru9DLzLIVy/uvJ3xUgzzW4e49v67dTtFngHQXX3A5Js2pwN
	 +dKMV+T/4sI9y79Z+LYA/DEuFz81Haf7E2sktHAqBhl4qPUEcdBdLQ7k8OdnC+jWxx
	 7zyvd9eT05Ek12b68PNaA9rFiqFuH9sO3Bb7p00sORoHfNidnYtWL/lkNQNip8Eyuq
	 cC93/1llLN5Fect6XXuPbwNf31TuKuXksoADSqTGv28ujHbMeHTfk7Q2On1anzBadb
	 i8yDziEuftqwzfj9HklzPZXzRod+LUJg4E6R2P3eWsYmI/eYT9v0yZ7/NL96eAAfLc
	 S8eWXPVnIbWow==
Date: Tue, 30 Jan 2024 13:11:37 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH iwl-next v4 3/3] ixgbe: Clarify the values of the
 returning status
Message-ID: <20240130131137.GH351311@kernel.org>
References: <20240126130503.14197-1-jedrzej.jagielski@intel.com>
 <20240126130503.14197-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126130503.14197-3-jedrzej.jagielski@intel.com>

On Fri, Jan 26, 2024 at 02:05:03PM +0100, Jedrzej Jagielski wrote:
> Converting s32 functions to regular int in the previous patch of the series
> caused triggering smatch warnings about missing error code.
> 
> New smatch warnings:
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2884 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 ixgbe_enter_lplu_t_x550em() warn: missing error code? 'status'
> 
> Old smatch warnings:
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2890 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
> 
> Fix it by clearly stating returning error code as 0.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202401041701.6QKTsZmx-lkp@intel.com/
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Thanks, nice to see this cleaned up.

Reviewed-by: Simon Horman <horms@kernel.org>

