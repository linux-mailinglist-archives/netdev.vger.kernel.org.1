Return-Path: <netdev+bounces-166697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E9A36FC6
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E307A217F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593E11E5B7C;
	Sat, 15 Feb 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWZ6cxqT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1817B50B
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640569; cv=none; b=NUfXc6UbwM/76hwkBTUONfcuSJNn4wk2j8+d3j4mAinSvmhSd/R8ASawSalul6tsb7Fqiev6hlDl5N9ytQaVYifjpOYq4K+PgaAHVQLN7QZfbhvKEoP1QFHbynYZdh73/KdLp9LYYludPPx9PVHc8jqC6FfWzF4HQlenF2b+LY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640569; c=relaxed/simple;
	bh=IK6h/4TA/Iti4V46nu69BclTQgANpyGTmyc/wI2SVZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLaRNCQ0kHhkfLoHJHFWwrDjzJ7vpYpldUpPi96Q2FQlHBWA5mb0aYY+rIKQ959CunJByq+GGfrNgOnS8YLUnuhEIbAJ+c0muy/Ug297RF9VHHq+6jJ3ifjFK50n8oN30ZAiFhDCAytfdftE9GsZkgwF7S0aa+HaxXM+sM8fyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWZ6cxqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D475C4CEDF;
	Sat, 15 Feb 2025 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739640568;
	bh=IK6h/4TA/Iti4V46nu69BclTQgANpyGTmyc/wI2SVZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWZ6cxqT9XxRP9y3hkypd8VcpSr9sMxROT2H4C0mYerIefJIO6usUbdO2NwbEBkLJ
	 uUTN+S6x0OjiDIAr6yIQ6NRWKGGu3uy1RshcV/kHxt2THB0hB32AFaUwxFyNkpeRoI
	 rVOnpDHTj1gCiDYoi75maa2RSp6qlaaxjWHHhUYnzsSv1Go5WjIycYcjiC69LsAegA
	 BXNsiE5xTvTLohRbbGONCh1r+c2Dbcd5ryQdM0mYJV7b+l2xXbuLzhrqPR3oSOJ3su
	 xPPi98y9hS8aK04vtDJIAcDDTVPIw7uKDuUVoFbpMiB31d11xvps1AJipMce5Wlgfz
	 AfHDGGok6BHRA==
Date: Sat, 15 Feb 2025 17:29:25 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	andrew@lunn.ch, pmenzel@molgen.mpg.de, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4] ixgbe: add support for thermal sensor event
 reception
Message-ID: <20250215172925.GT1615191@kernel.org>
References: <20250213074452.95862-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213074452.95862-1-jedrzej.jagielski@intel.com>

On Thu, Feb 13, 2025 at 08:44:52AM +0100, Jedrzej Jagielski wrote:
> E610 NICs unlike the previous devices utilizing ixgbe driver
> are notified in the case of overheating by the FW ACI event.
> 
> In event of overheat when threshold is exceeded, FW suspends all
> traffic and sends overtemp event to the driver. Then driver
> logs appropriate message and closes the adapter instance.
> The card remains in that state until the platform is rebooted.
> 
> This approach is a solution to the fact current version of the
> E610 FW doesn't support reading thermal sensor data by the
> SW. So give to user at least any info that overtemp event
> has occurred, without interface disappearing from the OS
> without any note.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2,3,4 : commit msg tweaks

Reviewed-by: Simon Horman <horms@kernel.org>


