Return-Path: <netdev+bounces-191448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A56ABB834
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3401891822
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9026AA93;
	Mon, 19 May 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmtG37zz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF535957
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645631; cv=none; b=XZgGkK72eseQGbhGQPXzw6d15G0NHumMRSranvKYcq6Q982+GQ37U3+qiVvyrfZ09htvsyMOAiXWQuPYorq2lxdlyBXiYNK3rqpAzybLuRY8uhnAz/Qj+BN+PiJm7V0bin8le+Snoac6gub8lf8pIy048wC38AbRqID5gejfISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645631; c=relaxed/simple;
	bh=XvRzz8T7W6RFlkeueUkzBwfdIZ2pK+0PD5oyIXEnF5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkhQzxzYD/JiXXoBPjQdob51H9HRlFKamUaPUzs8tgGuLV3GjJzU4w9WAKLdo4mt0SAI6wAz83sBwdNQvgzIkEHa/Lv+knPUkh8eS6tBRCOg8zWWnJtLJ3CkKLTI0pQDJfp6fv8MSlu6McrgX+/o5/PtFWzdy0KPR4JXkbEqEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmtG37zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A38FC4CEEF;
	Mon, 19 May 2025 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747645630;
	bh=XvRzz8T7W6RFlkeueUkzBwfdIZ2pK+0PD5oyIXEnF5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmtG37zzTkDtFUD9o4yR0G5xV7y0VfJCYKr/n2Fo1U1+ev1edoXN3ed3l4gn6D2dY
	 3jjVP5fujQb+TVFgKnrAmDjGz9dfD17cv80rB2A7nwbhiZda6o5hFLBuu0DuD/y50f
	 /wVV2CFplKiqM9Dd4cpKCLSOWqhQLalMJpi22/pVoBig5R6caWBJ+JtvW0Sa5RdnIW
	 kRT2n0ujdrppoPbUeiRYiMMFwmexWbxdyOUhSPLFtlK6037pSX2PPQAXZDz2cm/wWH
	 7U010VB2GAWq/WTNvXlXPSzxlQUfBujBZhRfnjvu34ZcRAb26okp4gGSJaP47iJvMH
	 jpAY3VyH+o/IQ==
Date: Mon, 19 May 2025 10:07:06 +0100
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next v5 2/3] ice: change SMA pins to SDP in PTP API
Message-ID: <20250519090706.GC365796@horms.kernel.org>
References: <20250422160149.1131069-1-arkadiusz.kubalewski@intel.com>
 <20250422160149.1131069-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422160149.1131069-3-arkadiusz.kubalewski@intel.com>

On Tue, Apr 22, 2025 at 06:01:48PM +0200, Arkadiusz Kubalewski wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> This change aligns E810 PTP pin control to all other products.
> 
> Currently, SMA/U.FL port expanders are controlled together with SDP pins
> connected to 1588 clock. To align this, separate this control by
> exposing only SDP20..23 pins in PTP API on adapters with DPLL.
> 
> Clear error for all E810 on absent NVM pin section or other errors to
> allow proper initialization on SMA E810 with NVM section.
> 
> Use ARRAY_SIZE for pin array instead of internal definition.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


