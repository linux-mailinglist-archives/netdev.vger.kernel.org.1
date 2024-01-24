Return-Path: <netdev+bounces-65348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1383A21E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 07:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B85281B12
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B434BE5C;
	Wed, 24 Jan 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH81EEbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E0F9D7
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078075; cv=none; b=TcT597P5X336XtBumyaJ8W5Qc3ha1lAarQPAOUOnxxAVProlGlXlYWV2ZwDFT7tPvfe9ZccLk877pIBTmn8Z5PEmYbzwHUQ5TZlbammUtKQtY6Ov0obbqmN8kZ+SlkVxkJoBi+EErxgDsAGRxlkIMnKilRY87nqGNZhY2gjXxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078075; c=relaxed/simple;
	bh=96QamTLIcdD3uMKWaCTBcqiZHUEN8/W35z7kkGurbKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPkTF2Zx7bkOuaj6S7jCfZUoZ0bxjuGAzvSVL/ws85QSYNdntmjFFNlwmHRU91WJqcli6TMAkiHio58m6IY1JLqXbdoWnFo9mh8Rvc4DXFuu646j+rcEljO2VD5QYj/dQIZErudXRxdAKY6WkyBrsevzuARZyFzqOhw8KHhsxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH81EEbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D657AC433C7;
	Wed, 24 Jan 2024 06:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706078074;
	bh=96QamTLIcdD3uMKWaCTBcqiZHUEN8/W35z7kkGurbKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH81EEbcIo6McUovC1U8a1MO3Vc5WFDlGC5zyMuDo26qBWsAOM1uRsaKg/Burw5fD
	 Nmg+oSuRNhXBXjRIhXbD65Xo3nXVsH08FoBwAVesTYnVsYpzoUrWFC8AvfSOCOp9dH
	 RcGeNzCzyqmGC5w9T+LoCk4QRC8SckI/SE+GQjp7h0XPX6nv1mEleg6OcJY78kxsno
	 7eKKhcu5q/bWEhMkBhNnyBri7f9fLb2cdBpyKPzKUa9J78yxelYRrc6h03FwomLbph
	 ay2YQPLDWp7S3juAG/MmXYYfN9lnCVgYDGluCLMzxn6cDvsRMjDRxkUHch6Dqr7e3a
	 IQfaVy0SgHuaA==
Date: Wed, 24 Jan 2024 08:34:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH iproute2] rdma: fix a typo in the comment
Message-ID: <20240124063429.GA9841@unreal>
References: <20240123121657.1951-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123121657.1951-1-dkirjanov@suse.de>

On Tue, Jan 23, 2024 at 07:16:57AM -0500, Denis Kirjanov wrote:
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  rdma/rdma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

