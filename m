Return-Path: <netdev+bounces-116553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD194AE1D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B271F24CF5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67795139CE9;
	Wed,  7 Aug 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBxTbUvO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793F13790B;
	Wed,  7 Aug 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047967; cv=none; b=kCWC5bqWgxRF+Lh621zDY8WPVdYqzbeKfXNsIvn3LSKyCrVr159e/2XTen47glJTtuVgdEbpQByBDJcajv2FX+mxq4F9+h7KNGZTaQYn7cyD5vFjLwnTzXYE9XzPqouavG7NekzxtPelMnTqfkgM0z9c3e13knHxWSnPbGMDLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047967; c=relaxed/simple;
	bh=NlfN2rUAhsrwn8aZBO67G/atzrzfQzCsN3/oacVA/zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By+3Or6ZWkgPtIzwf9OwRfelaCdgNEEDXc0L0gPkJzuSNxzr0BQLJOAKXOHxI8Um4vTQIKa8WnqUkvDq3k0CH7p+WmfnojM/WpKNTjfa0eo0nShDEzRIG+ThdKxZsf6TkIYEE2N32NhQIYO4htcrgEUmUdlvymg5/8E/J2MT7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBxTbUvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7050C32781;
	Wed,  7 Aug 2024 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723047966;
	bh=NlfN2rUAhsrwn8aZBO67G/atzrzfQzCsN3/oacVA/zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBxTbUvO8ZkKvCkQ2EamfsSUDd3YfpnSyzG9X2k9EdkBDIehfClv+dxq6A7TFkfDj
	 y7SS6xy0eY5f+8yM1+wwoVMAn8wYU3yWlNTtXCCb5SDE+4UPDqbKGKdB7subr2eK4Z
	 Rka51DVSnM4gZWUNujPkmzDtffjfubz9ys0JaX+P87veeLrUSXgA763bLBuzf0krfM
	 uhk9vMo+C4mL1+13n5kGwYhAaLeeSopahInWSh897efC9Z/xrf8rVp5UuMhONRM31N
	 GbSsThS3zK8NVsmHF6SaWOPbG05TBliutIttnlruqUPoO5irVhUpUGBpc+Yw1gKYt/
	 7YtdSoNvmwXfQ==
Date: Wed, 7 Aug 2024 17:26:02 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ethtool: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240807162602.GB3006561@kernel.org>
References: <ZrDx4Jii7XfuOPfC@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrDx4Jii7XfuOPfC@cute>

On Mon, Aug 05, 2024 at 09:38:08AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct ethtool_dump` is a flexible structure --a structure that
> contains a flexible-array member.
> 
> Fix the following warning:
> ./drivers/net/ethernet/chelsio/cxgb4/cxgb4.h:1215:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


