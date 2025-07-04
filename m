Return-Path: <netdev+bounces-204180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F8AF960A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F41C8651E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C121B87EB;
	Fri,  4 Jul 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkDeEF/a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960251917E3
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640753; cv=none; b=QVfww31OWJAxuGyyMFD3xuFyNTcXP0Ksr1CX4hr4eD+Td3G/JZLU0d3Fhptvrau+CotFem2sr/JBFq7TmiJf3xCxfdrMpouvXSQXbPr4jHT4g8YsndBuj96PFZ0kYUjKtk0CS9NejOy8JR/vkX5TTLHf0ZOmw2j7BldK9hd2Ois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640753; c=relaxed/simple;
	bh=wvOUH9o5gF0uSYr6gvxt4vxQuZRlLrBQ6mBTFf1tR+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPwBkF7zq+Dq7qtxAlRoZq5osEeTLhmjrWR24TefbYyTFNi+RPZ+ipLtB94lpLoObRFckz3zhlL3lJorEZWE0KiYx5ROwOfGqB2qMJy3MhFVLdUCXs7+S1Et/6b7hAqvFGIo+8npFG28gnpfToRw8rqGew+M7C/0geThg6zZyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkDeEF/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45462C4CEE3;
	Fri,  4 Jul 2025 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751640753;
	bh=wvOUH9o5gF0uSYr6gvxt4vxQuZRlLrBQ6mBTFf1tR+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkDeEF/aBKKjiyfySfAjHWe+wKIukH1FABhdvHAn5Focb1nEhYzIM0QS2MWnKCp17
	 SkWenXLA1NkTCT9p0SjGCICseqYQ3ZoHgXXyLCWUIOMHNVFl2A9b4psdS7MYRJZ+lM
	 tHlMG5+EYOmuCJL/KfaFn9fRZ6KCD5eGAGeARiEK5FmjtZ7ofBqjnfjzeAIrEcJ3Hf
	 CNQLW+Yy680g0P4W5Ew84TgJj3MFNiYJsqzD4qEw7yN7qqPpNqqqcgHW8cg68FAL1n
	 Sat727tIQTMcYeJteADAs1b/ryX051qt07Xv67OValRQ7mzDqIMy32Q614E0sqcb3Y
	 LFkWfSKsuK2qQ==
Date: Fri, 4 Jul 2025 15:52:28 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: airoha: npu: Enable core 3 for WiFi
 offloading
Message-ID: <20250704145228.GC41770@horms.kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
 <20250702-airoha-en7581-wlan-offlaod-v1-5-803009700b38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-5-803009700b38@kernel.org>

On Wed, Jul 02, 2025 at 12:23:34AM +0200, Lorenzo Bianconi wrote:
> NPU core 3 is responsible for WiFi offloading so enable it during NPU
> probe.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


