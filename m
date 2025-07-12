Return-Path: <netdev+bounces-206352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF74B02BB0
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0377B3AB664
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696B27E7DA;
	Sat, 12 Jul 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIIv2vTK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D501531E3
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333835; cv=none; b=DCO5rGIW3fYbTV3ZczTV0W+1ZYlUVI6fXLZiI6FUTfL0TyhmGJDbnSFWi9GNN/JV/4bsJe2zyk1fdCdJYmy/+fN/HzxEHUapai3XG9POnjqzU6fRi1WWfElAM90vvGUM0skpWJbIaji2RNy5U/1IKhgWC6xQsO8GkAI8vl8HbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333835; c=relaxed/simple;
	bh=PjsUO0UClfAkA+b+/0+/6rE6ZOMSXgo6sfri7W70yfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/YQbkjYmK7NirQCOOf1uz7TQtecvshuMscQv6RSwXCohGXo5F5qiN5XfzbFdLH/siWj8XYOsqOhLhzBNbBXNNLkferGZVtSABUhio8ncIYSoZSjfRYiFmF9pHahm9fCVQaQY9nTFQwfQVlLyN+iGYAR9ihgAyyjjUd+d2oNz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIIv2vTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4FBC4CEEF;
	Sat, 12 Jul 2025 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752333835;
	bh=PjsUO0UClfAkA+b+/0+/6rE6ZOMSXgo6sfri7W70yfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIIv2vTKaFNM9rgj1pj6HSQZpgFFhYdefmSHna+tFZnPjK7dLd969qY7j8tEhPe5e
	 OK1TVvzZjD0sitgjNbnbXvy9ur5ZLqpcWXgW4g1/ZuJtMW0b4727aP1NKNi8Aj2Jlz
	 M18NYSAJu2z4Ik0Z8eujcKtcgqniePad2MB+snYuy3Bit7UeKokpYoJaNvOo5WEp6I
	 fr4XekLefnJjpgaYThZou1guDtQx4SR9TacbDPO9XBQawdDPgpATDN3A1dEol0Znwl
	 +4SoP/6fwJj5k4inqT16fRRVdD+jJbsaJlRWIMaj6e/mKjLGwx5uSZM4QM9dzNZs/b
	 1JuAhqmVEhqKw==
Date: Sat, 12 Jul 2025 16:23:51 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next] selftests: drv-net: add rss_api to the Makefile
Message-ID: <20250712152351.GE721198@horms.kernel.org>
References: <20250712012005.4010263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712012005.4010263-1-kuba@kernel.org>

On Fri, Jul 11, 2025 at 06:20:05PM -0700, Jakub Kicinski wrote:
> I missed adding rss_api.py to the Makefile. The NIPA Makefile
> checking script was scanning for shell scripts only, so it
> didn't flag it either.
> 
> Fixes: 4d13c6c449af ("selftests: drv-net: test RSS Netlink notifications")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


