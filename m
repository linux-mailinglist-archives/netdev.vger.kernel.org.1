Return-Path: <netdev+bounces-196972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E91AD7370
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FEE1892182
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5F21CC71;
	Thu, 12 Jun 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njRwJk8A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D719049B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737430; cv=none; b=EcYLo+k1spLXr/y/k6qy9btfVtKlIAeDkiVasetoWi8SUZ2qvqV/pC8e0BbSarKiftaLpQml5NMe8gNZHZc/DqVQLlTY+fs9q7/wTufmTbIRcVOEBCACE4PDRk0weJ9sn48SD/vNOYFVmNvBKZ2DmA1bbrFxfV1kehGeE0ZZZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737430; c=relaxed/simple;
	bh=7LDR+tM95amJuBuGmRsKMY2yHpGWWBEwIEmct/59TQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQuHxPJtSYSXqsQu3sOGiCkHfZVxzaaF67HOYK5577vqb+FCDAJ/tLgFFbwW4J1JSlgMHNmxjjSdlAT23Qp78Q4qdk3X6UGTcVDr2+ZKBrVofeMcsXnNY4vlHFY9spCvv3u4A2TBu5aJLYrQZc/U6vlGm4Rs4TA3lzR/CNl1wSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njRwJk8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EDAC4CEEA;
	Thu, 12 Jun 2025 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749737430;
	bh=7LDR+tM95amJuBuGmRsKMY2yHpGWWBEwIEmct/59TQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=njRwJk8A/3LIMraOhaDMXr/pMAI1rY+klqU/QEk9Ax4AxcMfjZRpVIG3dOlA7FX6e
	 qo4qHIQ722F/Zm0yvXjhM5XHz28JwaQqr+miuDKzHK7WYIsiUvl3W3ixBi98MojlHU
	 iYn0QvWGBR4EdzJ22EAagASkbt1rAL1//EbDibCtxHm8umMcBgynioBgbSKPnYmcvq
	 tdKxymyyT4EfTtrzcwkENAnJ0OCajgOCEs+ktg2bIhepOPN+auDyLoJ58PfqpX2Q0z
	 t882XzLSGaS3cdG0Uo+hEI28zUA+VZyS1VGwN2F1X8atHxCqmyrWMyb/v4/iXqeMQf
	 nSQ7npgQGGbIg==
Date: Thu, 12 Jun 2025 07:10:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <20250612071028.4f7c5756@kernel.org>
In-Reply-To: <5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-20-kuba@kernel.org>
	<5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 11:56:26 +0000 Dragos Tatulea wrote:
> For the hypothetical situation when the user configures a larger buffer
> than the ring size * MTU. Should the check happen in validate or should
> the max buffer size be dynamic depending on ring size and MTU?

Hm, why does the ring size come into the calculation?

I don't think it's a practical configuration, so it should be perfectly
fine for the driver to reject it. But in principle if user wants to
configure a 128 entry ring with 1MB buffers.. I guess they must have 
a lot of DRAM to waste, but other than that I don't see a reason to
stop them within the core?

Documenting sounds good, just wanna make sure I understand the potential
ambiguity.

