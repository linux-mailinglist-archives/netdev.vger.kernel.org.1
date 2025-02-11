Return-Path: <netdev+bounces-165200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D81A30ED6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B347A13AE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A9824C671;
	Tue, 11 Feb 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czIi/RUW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5420B81B;
	Tue, 11 Feb 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285631; cv=none; b=ErwswfktA0KwMgbpbSFWfps1MmxAXsvc/U85RkbJU4IMWRiExrMIm78DWFHmXXiScEBd7jMpvaPsHH7aNs+xHm30zY+H0datJ+MQhZyyaZJ3Bxdzy9nNGW28/Q9otBDCWKlmwQN9BmZ0r5hKwZtAhTz0L8vp3vKI6eDGEOXYr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285631; c=relaxed/simple;
	bh=WdVAVaZxF6vQNa24ce3PcHCsxJB++m/FAab+HhTJpro=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDtqWZiEV6/zVz26Q0GtX+JjBdTdxqS0S83lopuwdhkLwwjGFQRALGCh1w1qHGhKZPbJir9/2pFe1Wk143qG9qU/mudBxK1ByPqSUxzuEJ/FQI/fNSkYkGa9B/GouQH5uvY6IqQlAQXTtbAehREPdv22tp1qyZh+mHBbCitJ6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czIi/RUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D928C4CEDD;
	Tue, 11 Feb 2025 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739285630;
	bh=WdVAVaZxF6vQNa24ce3PcHCsxJB++m/FAab+HhTJpro=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=czIi/RUWpUqH8Rh+boqotzR9d+kzHDUjZf0Z7z3wx9Tcv06NhsritCMdg2ZFDdhiB
	 mw8kZbgUtzuhHIWdWWz58DKF6zPKiIxXUvLJA9WDn8BJdbRtfkrpzU161MtLfITNvP
	 ALdRPhfmo+UO9vL//XKy4UZ6YAQcVRsmeohN7BJKUc3/PEkS3xHWr/fMD6OwNS5IUq
	 /M7Bg7DdJyTAww9+E95/B7qVTN83Y1ywt+qNglu76XIDshGp/b2jftyJ6T8YBcCIOO
	 758B0AeQrLoDsQGyfe990yo/7g2svl2JihZVGoxJQCE5Nf3hd9E6NTPYbS3X6gbcvo
	 RR6FNhRK56FAg==
Date: Tue, 11 Feb 2025 06:53:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Feb 11th
Message-ID: <20250211065348.24502ae2@kernel.org>
In-Reply-To: <20250210084151.160d5d4f@kernel.org>
References: <20250210084151.160d5d4f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 08:41:51 -0800 Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> I'm not aware of any topics so please share some, if nobody
> does we'll cancel.

Looks like we have no topics, so canceling.

