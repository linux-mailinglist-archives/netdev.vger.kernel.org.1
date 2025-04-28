Return-Path: <netdev+bounces-186548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE12A9F97B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F997188BF97
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B6296D30;
	Mon, 28 Apr 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAYyduUF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B926ACD;
	Mon, 28 Apr 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868405; cv=none; b=qBYDOmkh4LiqstT7z/TTrWNot6UvWvntJXx01lRlaKScQC9FX4u7Au4JoZga/1ihEr2xRYskDIjdsssuU6d8WeMUteDKpMbAu9pkmVtUVgOq/KNukJFk4oWr+D1rmTzyf7aTsoZo0PN4F0GaZKkCfxrdxxYGrW0M9LeVywMQCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868405; c=relaxed/simple;
	bh=v0hAVrPtXwhVJ85L2AWNBboKFK9n0RKvzoSlSm9DmWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ13nfUpdAk8AH/PN3TIzMbIN8smzUA3efMCXbfkTFMofl+VCioobtcOGY46gNxMhJSxgYg2MxuCD5upD71Rn4mXvyUFQtA3nhLWZ6I5xmaBhb8ekLBxK4bq/ByNQSgkv+o5pytT4Zy1CysrAPfmo5LWRfyA0GEkq4YjlgESt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAYyduUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA27C4CEE9;
	Mon, 28 Apr 2025 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745868404;
	bh=v0hAVrPtXwhVJ85L2AWNBboKFK9n0RKvzoSlSm9DmWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAYyduUF4KMFHFh6cdud+D60G8Mj3ObINkLH/RSqsLkn7oKS9aJttnHZMpXkR0UHS
	 kWY4kuoLIezdjgnNkpaIZx+9QizmadZLq7fGAxnFqNz24Vy4GOiPLuojTE/m0603G5
	 HNVx1BUodMDu1kQB9+luwkmHB27gx6nzbVvA9h3vXyNZvFRrt9kxknxiWAW54Da2Gt
	 fSUa+KVDyvfJtCHRigSHXSAhV5sDyDUI//FWGU1LRTIpNrSaTxpfYaO48b+BruqPTn
	 dYeKEZUDWLNjehBvhjziHi1BCeYqxmrWrrDg4azhinW/y24AK+SOdSymcTyRgM5Tg4
	 Q6LA9ABeydLLg==
Date: Mon, 28 Apr 2025 20:26:40 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] pds_core: init viftype default in
 declaration
Message-ID: <20250428192640.GJ3339421@horms.kernel.org>
References: <20250425204618.72783-1-shannon.nelson@amd.com>
 <20250425204618.72783-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425204618.72783-4-shannon.nelson@amd.com>

On Fri, Apr 25, 2025 at 01:46:18PM -0700, Shannon Nelson wrote:
> Initialize the .enabled field of the FWCTL viftype default in
> the declaration rather than as a bit of code as it is always
> to be enabled and needs no logic around it.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Thanks, this looks like a nice clean-up to me.

Reviewed-by: Simon Horman <horms@kernel.org>


