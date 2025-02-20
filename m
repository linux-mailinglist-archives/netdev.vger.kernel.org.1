Return-Path: <netdev+bounces-168142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2783BA3DB04
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13731786E4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA71F8EFF;
	Thu, 20 Feb 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY4dba5Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492DA3C3C
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057234; cv=none; b=Jp0ahM4wCBVPR98RtbdtxWnrVwO7Hf/pxD64R0MHGyHozWFr6uh9Zs74MUNjTMKCeay0J/lt8ELAnaCPAMUTasdqgL+uwpTSlnsuRi+K1vNlBG6fEX0QdgZfIIYNfN2W1Yjj0s94/++PdOfS/s+8UA01fTUbEMcqZdFbQu2HNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057234; c=relaxed/simple;
	bh=/Ciqt9+VmCU3tG3mttYEOW1/IAdXU9Lb/5EGlSTFg18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXky7o69hDoRkSCIKpsExgPHYeullDK6sCAhLoC2OjxDkyPQCkHrIhNo0+yJGgWugidr7HTetsb+iPN7PTTOyEPatH+d09ceKtbK2rdkTmZ1DOaaTu2pHnjj+u2eNkiq6WTTSW/wLhADDlKuCWCZZVi3qhD5UyprFxh5dnqhdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY4dba5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A076FC4CEE6;
	Thu, 20 Feb 2025 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057233;
	bh=/Ciqt9+VmCU3tG3mttYEOW1/IAdXU9Lb/5EGlSTFg18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nY4dba5ZZputj+SHsvqo1hN6IodEJipUgETNhg02/WKGJhhgskbCcPgffSkGMfKta
	 D8Yp0YwDpqQe+uRe7zKNeLCIq3+YcPW94ZhJleh3q4TfSdtwiMyjFd/vrM1LzyIaqb
	 nZbfyqaT/7pWjXFmOv0PQ3rldFyIwaDG4wD/1pDbk2XQUZ0ZK0Lihsy/PsfEVQbXtP
	 XKrIzz0ov/Qwwdi9hSRsuapTwaft2+GQUzfyUP0N6xi4AQl6rbCT0TH+Jq5ehQLei9
	 8//EF7i9SXEYiwTCcP8epYwbt5n0tc2XIyt4pcZ1UB/KlDuLyMpNPjH48rGCWtHiC1
	 k+2Sfas6SjMzw==
Date: Thu, 20 Feb 2025 13:13:50 +0000
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next 3/3] ice: add ice driver PTP pin documentation
Message-ID: <20250220131350.GX1615191@kernel.org>
References: <20250207180254.549314-1-arkadiusz.kubalewski@intel.com>
 <20250207180254.549314-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207180254.549314-4-arkadiusz.kubalewski@intel.com>

On Fri, Feb 07, 2025 at 07:02:54PM +0100, Arkadiusz Kubalewski wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Add a description of PTP pins support by the adapters to ice driver
> documentation.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


