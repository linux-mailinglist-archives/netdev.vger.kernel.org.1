Return-Path: <netdev+bounces-67214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF2842604
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52281B21DBB
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF766BB2B;
	Tue, 30 Jan 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAOV9sw6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D706A35D
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620357; cv=none; b=Uw0UY1xW9DiB07f4FRKSTkjWtB/AiLiCZOr70/fLYe747BE3N23P3ElYKGAuJcsc+nL21jo07RCPhNlVYD0gWf+VRWa6DCRndZ2If8LAg8RHYtYfppil2fYI68hW5MDaytFTVW1Fs+seAhjl/KmNgq/ij/sj80XVbVR4Lb2R8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620357; c=relaxed/simple;
	bh=zJEMnhEsbSau/vuSXwKgJowpq9X91ZF4cDUW9NsJboo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTLRth/tmbtNJOfqV/t4LTLTdCHUUKTHc5rPDp+RlMfhxsdeAa1WI12cGJuLvEyqlF2sw/xxTTsdlZkr+xoLW6mTs71DFn2j5EJQ+zsTcFdLMEeIlJ2fS+O9Ova8fGzQ3on8dXydzKqndKY0w89w5JUNrCdwcn7xNA0DCF3m61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAOV9sw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CF9C433F1;
	Tue, 30 Jan 2024 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620356;
	bh=zJEMnhEsbSau/vuSXwKgJowpq9X91ZF4cDUW9NsJboo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAOV9sw6SVot2WvXcnG1bTk52CPGXM1bXJ1f2iLd3FawJO3fcxwJUvg4xmBMoQp5O
	 UuszCIhnoHiScmobd1pXKDc/f9WkqAQK4TG2tekeaH1J4s0SU19aj5HyBieUFPKXFk
	 3mBHJkttqMAGvOcQvO3PJ1ODVlFZVlV4tCKhXvIb9G9Rl+tgP7mnWybTwVWzLdsYsS
	 JrfGIqr+txvXb6fVcTHR3EX+Wq6AQEXsmEJ3/1YcBHWuF3B1NFr3mFD5aSZqlEa8M4
	 wozyBrjOGmREbtq/KAADJT4fBsEPfi1GHq+6hAjSBiuHyKjgbVNk9/HOs5i1saQMEU
	 uTcXzJ66gflCw==
Date: Tue, 30 Jan 2024 13:12:25 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4 2/3] ixgbe: Rearrange args to fix reverse
 Christmas tree
Message-ID: <20240130131225.GI351311@kernel.org>
References: <20240126130503.14197-1-jedrzej.jagielski@intel.com>
 <20240126130503.14197-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126130503.14197-2-jedrzej.jagielski@intel.com>

On Fri, Jan 26, 2024 at 02:05:02PM +0100, Jedrzej Jagielski wrote:
> Clean up the code touched during type conversion by the previous patch
> of the series.
> 
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


