Return-Path: <netdev+bounces-144189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB09C5F40
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E4281D77
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FC9213EF7;
	Tue, 12 Nov 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLjViL7I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333B213EDF;
	Tue, 12 Nov 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432933; cv=none; b=DYcYBfmD87TGTCfmQsm9k28HgBq1FppvCh9q3bfAMOVEhpxmSDIiQbe+NkgTbKe16R06YUu8RSW/AazLQAvu6MfkfEnRmfUjvPQXoKqjBVOf1r3BylYnCfueu5B+Jf0PTwpE/Xex47+0obcNKwY0bR218/5gJpz8SCJBir+cQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432933; c=relaxed/simple;
	bh=6CRh2bsdCGURSDHok/z3WM3hG7Hfbb1MDGPehTqteFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLPcAMQxC+JSvQSK1jjRvKYKV33rBmxplnkRqWiWpbd7OAAQh6Z+i8hx2Hnpr7JF+W0kClCe/TswPv2D1S0R24z9f9k6sTuS2T5cdk2hiwdYuSS/kFItJsabwG/d6/DSOKnc00COWyBqwUO6z2huyX5DdR5yxIhvR242qaVNx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLjViL7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D038C4CED5;
	Tue, 12 Nov 2024 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731432931;
	bh=6CRh2bsdCGURSDHok/z3WM3hG7Hfbb1MDGPehTqteFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLjViL7IPzCcJLUfTTHrgKbh+1aVdM1efdAO/SjZusQuxWkhaY4GxNXKoeagA6yLy
	 Z8bUmOEUDDshjCLntZYyS8SsGEj7l55WHptSfQT62HOsHW83V3Pzbx0efvYYVG2mLi
	 jFrKIKi5J6WJrzxdH2+pJkJiKCZ7UCTJ6cCjMXOnk8y77QwCExQYn54bKj5fILEmJs
	 g313c/GxEURIJX1IhMMEAHAVTpDAc+4K9BoO8VwkI2LNuDp/XAPdggZIVTViQSWg7U
	 OkF1J/kNd6l09AtYzb9kqY15CoRx3vNxFGf1r32P/66YGsXaJjkFx4PyVKNXQcW7tq
	 9/cF3IvOzleKw==
Date: Tue, 12 Nov 2024 17:35:27 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, hawk@kernel.org, lorenzo@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net] samples: pktgen: correct dev to DEV
Message-ID: <20241112173527.GT4507@kernel.org>
References: <20241112030347.1849335-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112030347.1849335-1-wei.fang@nxp.com>

On Tue, Nov 12, 2024 at 11:03:47AM +0800, Wei Fang wrote:
> In the pktgen_sample01_simple.sh script, the device variable is uppercase
> 'DEV' instead of lowercase 'dev'. Because of this typo, the script cannot
> enable UDP tx checksum.
> 
> Fixes: 460a9aa23de6 ("samples: pktgen: add UDP tx checksum support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


