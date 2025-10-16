Return-Path: <netdev+bounces-230141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0D0BE45F7
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC431A64B5D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331034F479;
	Thu, 16 Oct 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNDMTo7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B334DCD2;
	Thu, 16 Oct 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630115; cv=none; b=S7pQGVH1Cq3piami0k3dpONvWNBHAfrNK5KKPn6Mk1ywd3ZYp/YngeLsA1rsGtvkwMqqX2/H8wBshMIg/RrLVBfFvkBK43Qj1gKTpnPUWXjFFD3nrGRsfqGmN1W97yGk1z434Kx6hn+9UrX3/3MCRnt5qCxkcykYrBQKTTmtX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630115; c=relaxed/simple;
	bh=mUd/cKwzucs5sz4MLIoHp3MJMXcZOqAnIjxG8j8Iy6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq/Q0EDjDPmotsXd9bqeNbwgfdxEm9eAiyCLNxbkBAxSJtsYIB6iOrLig/SvB+Nj2Ahf22tfUsmSosKb2rhO9wHBJ0T+8rr+C6r38Mw165G9UP+CVoEsKonBQH+AZGQD7EJm0CLbPkHaBHJ2nMaXbq8iJN3Fw2Tq2OKa7Zbh40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNDMTo7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A0BC4CEF1;
	Thu, 16 Oct 2025 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630115;
	bh=mUd/cKwzucs5sz4MLIoHp3MJMXcZOqAnIjxG8j8Iy6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNDMTo7AK5kSVF306sECe0SdK8OIZY1DeC5SQzKnfh8vIOZVH6SicOMXWlgWCcwgD
	 VOkoVQSS5KPJankKA92WwI5ULiPm0ondHbrarrDxd1gO6jd3yIcxIcPX7nfiiyV62z
	 3jht84mMTOW49pguSl7/B9m/tykDQowSYRTPFX8y7Grbmsb2G2xXvJ/ZsIq77ut3hU
	 nmZeGfN0zaBAul4IdbhxayFqEErErCvxH6zXT9nT3VysNfD7WH5IbgLXkMWhdiO33X
	 kM3ltWOvaZn4TtEwIYXXKmXLgnk/I6A4CnBp+ffJWL9NY1gzyjkpq1NkoIkojF+uD9
	 5cJ5QdZJVE+LQ==
Date: Thu, 16 Oct 2025 16:55:10 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/13] net: airoha: Add
 airoha_ppe_get_num_stats_entries() and
 airoha_ppe_get_num_total_stats_entries()
Message-ID: <aPEVXhTE2_qFz5zz@horms.kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
 <20251016-an7583-eth-support-v2-3-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-an7583-eth-support-v2-3-ea6e7e9acbdb@kernel.org>

On Thu, Oct 16, 2025 at 12:28:17PM +0200, Lorenzo Bianconi wrote:
> Introduce airoha_ppe_get_num_stats_entries and
> airoha_ppe_get_num_total_stats_entries routines in order to make the
> code more readable controlling if CONFIG_NET_AIROHA_FLOW_STATS is
> enabled or disabled.
> Modify airoha_ppe_foe_get_flow_stats_index routine signature relying on
> airoha_ppe_get_num_total_stats_entries().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


