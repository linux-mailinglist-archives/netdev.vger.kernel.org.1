Return-Path: <netdev+bounces-184633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE1A96900
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBFB17D6D4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7CF27CCCC;
	Tue, 22 Apr 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COcXoeJJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869B202960
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324471; cv=none; b=fMeSt6fkWtUOMfgImvpGIFcUciM93sw24JU5VpwSg96BLV7ayGbMff6tmG7Zj9/m2EbakTxRWC2jtYdHu+lq8k2urtXwlhsoU0XJmoh9qO/PFYDLszT/lEyy653rr/r/u26AKDj1EfnyQVAJW6Ks2s1aGG1P+To4lah0vEz06zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324471; c=relaxed/simple;
	bh=UkGLXk7kMq5D1ZBzI1XZJ1G7b1qF8z+/maQ3l+yeu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrIjmNzFiWwRbqoU/oHKTkl+y+VI2dLFlnbzNLT6z9WNg/eXenZamg7A63t0HI2XWfRxxZH/M4zlUAhPFvchWFzb8b1eQV/rp/GFvy3pY09uNdD62O1WUTSsHD939mMHbrJnmSPd/VbA7KiNvQczq+RdTouzuxLoslEgxDF38Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COcXoeJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B337EC4CEE9;
	Tue, 22 Apr 2025 12:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745324470;
	bh=UkGLXk7kMq5D1ZBzI1XZJ1G7b1qF8z+/maQ3l+yeu/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COcXoeJJwlaJO+onyn7iAriK90zBeTbSijaIEAcaeYnzFZbEE31UI7+VUphpLfT3J
	 ROy2uyjUlrELQQ3FiriTFMzUb/TN7K6mjOSLXLXl9AJvEFJa99bfaDugzMrhL1grIi
	 3sKvHFJ3SaJ066kON+MyH/UrSLMB4ajwM6ONHcBrCllovDiaCqVjRVt5L30XoeUFAL
	 W46wyimiiFX/afMmpubm10xUYDYQpBNUWLjjdthzPUowQjXrB5C9l+l+dd79JEnXf+
	 cOuHiEgZDNWplG57NPDNPQiR6jtuoVkdwdT3aeWk9xtFiC7EoVqJNZ3sETu++DWBb1
	 YXmnpDdvTIb9w==
Date: Tue, 22 Apr 2025 13:21:07 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 3/3] net: ibmveth: added KUnit tests for some
 buffer pool functions
Message-ID: <20250422122107.GD2843373@horms.kernel.org>
References: <20250416205751.66365-1-davemarq@linux.ibm.com>
 <20250416205751.66365-4-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416205751.66365-4-davemarq@linux.ibm.com>

On Wed, Apr 16, 2025 at 03:57:51PM -0500, Dave Marquardt wrote:
> Added KUnit tests for ibmveth_remove_buffer_from_pool and
> ibmveth_rxq_get_buffer under new IBMVETH_KUNIT_TEST config option.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


