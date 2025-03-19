Return-Path: <netdev+bounces-176215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9E3A695DF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE090462E4F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF5E1EF38C;
	Wed, 19 Mar 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrjnXtUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440B1EF378;
	Wed, 19 Mar 2025 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403910; cv=none; b=tq9hnxvBnHna3TMeFtsRPqCvOoeDfVejHpXFm68UNpZe2rKpJFtn50Yl+COqXL6hcLAYeqOCma+8siv/TgLaMyxo8/ZxSAQqself4F21yqhM67Ct7CywRvu3YVHhGMu+bXVtt45rtyuzYmAZFTbRwN67sWUjVIkevPeCnR9lD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403910; c=relaxed/simple;
	bh=LxhaxXY+BOiIS+smWX5/vghYsXB18bs4PhVE9YOK9pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id3xrhxAX8404474H9lKdA8ADk91tupMe8XW5z4Ao5ZfENpLyBbmv04I4Cdiu68OhMOmEhbkm/ZNlznSsOXiAaNJHknbJmVP6Rmngkjvc5VRP0S41w34RdrWIXba3zjTaFowijL3GLGBxampd7NtQvXZDvYzm7Ggt2RD4hY2n5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrjnXtUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12CDC4CEE4;
	Wed, 19 Mar 2025 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742403909;
	bh=LxhaxXY+BOiIS+smWX5/vghYsXB18bs4PhVE9YOK9pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrjnXtUPtoAQLXyIdyweocuutDAsEk+djIyHFfUuHlaLGvQKAGUmIdqJw55VVEqvw
	 68nqhCN+p3RJ2eCQF8/AEC6Kejln6XWJUlCsI6HB4xaDnMQVnTdN3AgKOUgNo+cAmI
	 aR+F3JmaiUqayiyjJo0ZupI523Gu5dq/rwk1vK7XLl5gFxfLCZLNHvWk0fPD2+QoRV
	 xlSxfFMp1SSZRbwQXCkfa43HRYh4zFp/6ecaFLmIjaIcqFwPWQbIaucnjBY9o+uJZM
	 uRZ9lRcbLPj3KD56eZoxSYCfWsButxbOgTQRJ7z+bkZYasyAqtZWwD2VCIpx0DWNnM
	 gt4jRggQ5EQsg==
Date: Wed, 19 Mar 2025 17:05:05 +0000
From: Simon Horman <horms@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, idosch@idosch.org,
	pabeni@redhat.com, kuba@kernel.org, bridge@lists.linux.dev,
	davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH net-next] MAINTAINERS: update bridge entry
Message-ID: <20250319170505.GH280585@kernel.org>
References: <20250314100631.40999-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314100631.40999-1-razor@blackwall.org>

+ Roopa

On Fri, Mar 14, 2025 at 12:06:31PM +0200, Nikolay Aleksandrov wrote:
> Roopa has decided to withdraw as a bridge maintainer and Ido has agreed to
> step up and co-maintain the bridge with me. He has been very helpful in
> bridge patch reviews and has contributed a lot to the bridge over the
> years. Add an entry for Roopa to CREDITS and also add bridge's headers
> to its MAINTAINERS entry.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks to Roopa for all her good work.
And thanks to Ido for agreeing to help out.

Reviewed-by: Simon Horman <horms@kernel.org>

