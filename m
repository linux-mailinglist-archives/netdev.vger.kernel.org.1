Return-Path: <netdev+bounces-170809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B4A4A01A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA241886733
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317741F4C96;
	Fri, 28 Feb 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDqbSAPM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB111F4C8E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763117; cv=none; b=MY5Z0Uhk1UKzBSODwFV30hyA6drj7jTSgvfH4/kutNIX3G8I2wyRq42M3PfuOM66S6BeLbKKbhi0V2nnn6ApPFRt/jlOuEYmYP5ie30HcczVmK1pkJsIbtTmSGc0UagRs6L7eEkvvzTfG6VGlKCUyEO6yA/0SX8iteAIsxWBVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763117; c=relaxed/simple;
	bh=kiAYDiNKPRsdXTw71BC5BaVg3ja1Aiiqb5jZ7oCOh6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulAyZ0lYUYTKnKXB7ePMh9VzRXz0NffkNVLRE0v1f/PBpFyIKzbJuz52FliArfJGwvF55N5/kaGj3N4Yk/nuy+yH1hVKWnq09Zhbq6Wx57AxJKeFCgVrYCzXYQWzzqI5lYJNOqkAjaKmtl/44V6NZh38eIBKPZnDSHZsuHl92g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDqbSAPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4E3C4CEE8;
	Fri, 28 Feb 2025 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763116;
	bh=kiAYDiNKPRsdXTw71BC5BaVg3ja1Aiiqb5jZ7oCOh6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDqbSAPMbhgp6yZl1jn4ChyyyHUe2w5jr1E46ydocLKQO66B0LHaFWSgkkJB37D8k
	 qX2DOOlxvNpf/ciMElQrnvB4pMF93JnuLMQNOZQjoAgGDckImCD0b2byGtG2uQbEHV
	 Ac0rAPeUi1ml8pk5jTS2D4BA6jV6CLr88khDhg48TcBjm0P8W4vu64oTW1GARMJvLe
	 LzeRz8rXu/3FqI/WG1+p9C7WfpUBBzlWypROMt6Bz2G2h3ocKABlyGRyIoDgF7yYsf
	 l3EeikKwkdYxF6zhcvwVaEd33WE8Mo2Zf1oh7+giRJQ/pgWE4i0GhPZyR3aSeNplwo
	 XAwRfVWSedsrg==
Date: Fri, 28 Feb 2025 17:18:33 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-net v2 1/5] virtchnl: make proto and filter action count
 unsigned
Message-ID: <20250228171833.GN1615191@kernel.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-4-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090847.513849-4-martyna.szapar-mudlaw@linux.intel.com>

On Tue, Feb 25, 2025 at 10:08:45AM +0100, Martyna Szapar-Mudlaw wrote:
> From: Jan Glaza <jan.glaza@intel.com>
> 
> The count field in virtchnl_proto_hdrs and virtchnl_filter_action_set
> should never be negative while still being valid. Changing it from
> int to u32 ensures proper handling of values in virtchnl messages in
> driverrs and prevents unintended behavior.
> In its current signed form, a negative count does not trigger
> an error in ice driver but instead results in it being treated as 0.
> This can lead to unexpected outcomes when processing messages.
> By using u32, any invalid values will correctly trigger -EINVAL,
> making error detection more robust.
> 
> Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


