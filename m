Return-Path: <netdev+bounces-200003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD701AE2B03
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8876A189387C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2826A0E3;
	Sat, 21 Jun 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edsIdgaH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932E22DF8B;
	Sat, 21 Jun 2025 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529499; cv=none; b=KcLcWZYUbtSr9zKy8JvQRE6jpQ2T3JDMmWqa/jQsCXxf4MXtvWqKi9xKuDOvb6zmQr5mmzdfJYVyfHVqZSoCKNJvjS1SLl4tothpPni2PKgSkuQhOHfTGW7GIRvctN9JqYQraU7mPYmZK+r5PO3mX7fZvlN52/oDtdVYBr8xLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529499; c=relaxed/simple;
	bh=KT4wZwZ4quP9dkmzxRITSCwt3l+q2gBaDsp4pfn3cw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCle23gs0/Wd1/rvhZ1n3oO18pkSXzJwKZvjCrkECYTW/xa1kOtS6CKSSRg3Y9OZF0jzjkCgaEBfqt7KP96KBdfMXN9YS9AshzINg7pkyiGV2t9nOH2iSCGqS8PNA1ktdwZlaBYQWMCXxv0mbI7gqusUm3UmuXdJU17sctVphek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edsIdgaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A20C4CEE7;
	Sat, 21 Jun 2025 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750529495;
	bh=KT4wZwZ4quP9dkmzxRITSCwt3l+q2gBaDsp4pfn3cw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edsIdgaHi20jfAkaZwiFIIalrlv3YzUxrXdkVV4wcna9xXZJElrOjeDO8tqnm++65
	 +S8d3FL6oW7NTymckkAZo3dOgkyzjgkte6mtqGbQUbr03l5/aVla1ZnYrvQe7xj/lZ
	 zhSB4rAflr8biWklH6mQK7loZPHOLASd5Q3D/eigZrTELHEu98QmcQ4SoPp5YD7Whl
	 2f5+Bxojfq7Nk+W0NO3ZcjEwA9ZnfyivNrKvqj8wdWHNMhFeB/cXn/kSWkDNjk9tFv
	 O+thx+F4tqRn7lMvOOhJi+VhyD53O81eP+y0NL2gKhQzzeHyT9czSxafRR8axMMoyj
	 dKdbb5N4116Xg==
Date: Sat, 21 Jun 2025 19:11:31 +0100
From: Simon Horman <horms@kernel.org>
To: Faisal Bukhari <faisalbukhari523@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix typo in marvell octeontx2 documentation
Message-ID: <20250621181131.GG71935@horms.kernel.org>
References: <20250621103204.168461-1-faisalbukhari523@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250621103204.168461-1-faisalbukhari523@gmail.com>

On Sat, Jun 21, 2025 at 04:02:04PM +0530, Faisal Bukhari wrote:
> Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
> Fixes a spelling mistake: "funcionality" → "functionality".
> 
> Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>

Thanks. I agree this is correct.  And I see that this is the only spelling
error that codespell flags in this file.

Reviewed-by: Simon Horman <horms@kernel.org>


