Return-Path: <netdev+bounces-218879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C45B3EF18
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5157E1B21ED5
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8D21ADB7;
	Mon,  1 Sep 2025 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaoXHVmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CF217F2E;
	Mon,  1 Sep 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756863; cv=none; b=Jdxx6wZ3hBUFBbJvz2ZtUx6gnDV5n/8SSU4YBcfoB1aa94/j5TKCBwtTJs3MFNIzsI2dW0/IHnpeGBwlmI7B/WoegYXT3pRv94TsE9vCspPn3JfYOepOuyYC7OVqy5SGTKkyeyeqdq70L/m+uTixks6Jd4qcshyjI0SWSZ425RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756863; c=relaxed/simple;
	bh=RZ9Mm/D/DjxOnCPyWTCS5WnaTMjOYfXDEqHDNtolB1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1xAKe3VQyIcbfAvDyt6hkIU2rPyo/guoSEQDIwNCk72sngj3nF+iew/DOGYIUp1VlbooYjrQbNt/plYACwAkKIg/cs/G1bLfET2k6WA1ilqSV2tG9oWJ0FaFXrsmqjbFB1Q/oFM/aMyGIuevj/uPjpfvUXTLezDII/jOSo7qCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaoXHVmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C82AC4CEF0;
	Mon,  1 Sep 2025 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756861;
	bh=RZ9Mm/D/DjxOnCPyWTCS5WnaTMjOYfXDEqHDNtolB1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iaoXHVmQVq33dOuDxXP6j3wbIr/3YOHKDcYHpGJEgFpPprYEX8JIPJ6/lxyRGeg74
	 RYYcY7Hug/S3kg/SWMR4tgRyLd/v3RuXAcGrWL4dRH0Dq035yQSpUXf/oVPBJRehmz
	 42OZuSoewZCtJGAocdRcXK2xS31wIXm1fV+SU7IAJogvjBoNlY8drA3YfrzWkN+RmL
	 SwQC9UfMTeLoR15XH7D7J5nHOTUJMU26Nqsd6eLBmr+ggC+6GQGV6rUIhiVBaBTqZE
	 37iQAfTCR7WFKqh3w8uhqa+WXng8lK/WJ5vJ5xo7rHCjMX486zVhfOPULcdCOYFWKD
	 bwA0kRjexWMBg==
Date: Mon, 1 Sep 2025 13:01:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com, Piotr
 Warpechowski <piotr.warpechowski@intel.com>
Subject: Re: [PATCH net 2/3] net: stmmac: correct Tx descriptors debugfs
 prints
Message-ID: <20250901130100.174a00f6@kernel.org>
In-Reply-To: <20250828100237.4076570-3-konrad.leszczynski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
	<20250828100237.4076570-3-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 12:02:36 +0200 Konrad Leszczynski wrote:
> It was observed that extended descriptors are not printed out fully and
> enhanced descriptors are completely omitted in stmmac_rings_status_show().
> 
> Correct printing according to documentation and other existing prints in
> the driver.
> 
> Fixes: 79a4f4dfa69a8379 ("net: stmmac: reduce dma ring display code duplication")

Sounds like an extension to me, so net-next and no Fixes

