Return-Path: <netdev+bounces-79090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD74877C94
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71057280E68
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042415E9C;
	Mon, 11 Mar 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWRx4Lxx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488451B599;
	Mon, 11 Mar 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148990; cv=none; b=QAhr3Qdvy+3NCL5C/txZFe0CFJTLW8lAIkScasYvU9DjixPKEdNwaw2mmc+1T7KKFFTv332n1k6sO0eE3wrRoJLpVlgC8m8bK1DeO6+HBQ3mH5d6rX1dQ3ev7CFMdNq+DqHOIMyCZtH8JmUvSqSbu4k47hMJ0VAUFsgVPbRhF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148990; c=relaxed/simple;
	bh=hUEExdekwn2teEEHi8Ifmh4xp47B7vKJeVRleq/RipA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtYNTsoZRvlvEb5ncmzrkP4QzuONBGCaSc17/ddiiHmLc/51o3gG5hCw6QPDkdLcagYXrLiaNDDwbQExvXWSX1/cJudi1BZKc1ga5I0FEF0wb8IJnrRp8Tvw9D5qT4huShp7GG5oFBIlGxefL7XCTOacPLacUXIl5WL8tsjBJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWRx4Lxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB513C433C7;
	Mon, 11 Mar 2024 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148989;
	bh=hUEExdekwn2teEEHi8Ifmh4xp47B7vKJeVRleq/RipA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWRx4LxxSkEOBjhJsdqpXqDgWFfE4FEXqgPfo3x9ITi/B+vWT9MEXPwkp+z0YE+AV
	 csCWl6nGt2rCaPlfu4ezf4CFHDJcYKMDzFW9dy5YxS8VOtBIaN9Sw47ml4f0QfKMmB
	 /O+lRT89xZsO9ZuXFoIWMCDti2+NYWpoi7lho0wO+8tPux9CGJnXzet+hhoaCObsxg
	 0uHn0LUMyEFuAXvXBmk5p5s630zZdToPpwzPPFm2TnIYuXeJxR2n0BrywFOVDSEmqI
	 IO/0uL+AqO1GW03+sqPFRZTtnzgBWH2leXUoMeai8p9zOYbH5EUBK7PV55YkPrtC/b
	 akSnP+YXiW7hg==
Date: Mon, 11 Mar 2024 09:23:02 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net-next PATCH v3] octeontx2-pf: Reset MAC stats during probe
Message-ID: <20240311092302.GH24043@kernel.org>
References: <20240308181544.806928-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308181544.806928-1-saikrishnag@marvell.com>

On Fri, Mar 08, 2024 at 11:45:44PM +0530, Sai Krishna wrote:
> Reset CGX/RPM MAC HW statistics at the time of driver probe()
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

