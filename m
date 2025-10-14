Return-Path: <netdev+bounces-229218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13ABD96F5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F3819A09C0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74639313559;
	Tue, 14 Oct 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/AJM7S7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F0313540
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445941; cv=none; b=qzXlymN/Aa6Nm+96qDqxudjJN9KlMrs2D9IaCS5DYii1IwayqH5QzINqGDfgSt6W3QUera14zfpPXI6e9mbUih3U173huoIxd4c4uu3skNKEDclNNybCIpIejwNmAQqbp14waqzIQ7DF35VssA02N+Z73LgvaUyPYO/qidoW6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445941; c=relaxed/simple;
	bh=DNZQzkKLzCCcyXOUiBsFMGrslAjU+egsiprtpzTzpdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHOMBwqtWts+98neoOZig7kdEZYH5rZ/yqEugBkanms3CBw9YiI1mSKBWOHl9Gx5JrmIk1vt6/kKV9uIzkdfowznGtZhRbhNFPTIbzwZBVzt9MlGCijPK3MRd9/db3rkAWyHfJI3YR03RnYW0B604hLgvA1ygTzEe/8xuZVJW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/AJM7S7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9EFC4CEE7;
	Tue, 14 Oct 2025 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760445940;
	bh=DNZQzkKLzCCcyXOUiBsFMGrslAjU+egsiprtpzTzpdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/AJM7S7R81cKMeGPflAIoP1Ru4MkovM3FXUs0BRabtdF8EVATkWyuUwkCM7uL3Yq
	 Ui/3M7oFwjAMVrj+mJa2XHyVHt/bYCrIOMI2sZyGMlQQuVROL5OLK/mzBvLFrGxtgh
	 Od7I/9XrbpYdGnZJysmEIvlv/iSs0e+U5lCZJD7y75PuHn3nlPPHUIyBeOo7MeKoIM
	 DZ1k1lX2plDzuzA/eVAnR2yusnIJJ9DiHjO+7X6KfDvk6k4xQHaIM+CcB33KmwYVW1
	 Grj6ECE2tsAg6ijH6dSl68IFwS3rqZdkJ8NHnA1cKlPVvKayzAnrT3b5uz20odWv1G
	 LUmnMQIgfL4AQ==
Date: Tue, 14 Oct 2025 13:45:37 +0100
From: Simon Horman <horms@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: fbnic: Allow builds for all 64 bit
 architectures
Message-ID: <aO5F8T6FJlsrVCQ-@horms.kernel.org>
References: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
 <20251013211449.1377054-3-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013211449.1377054-3-dimitri.daskalakis1@gmail.com>

On Mon, Oct 13, 2025 at 02:14:49PM -0700, Dimitri Daskalakis wrote:
> This enables aarch64 testing, but there's no reason we cannot support other
> architectures.
> 
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


