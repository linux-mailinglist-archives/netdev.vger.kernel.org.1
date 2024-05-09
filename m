Return-Path: <netdev+bounces-94896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506DD8C0F6D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0002823FD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57D13174B;
	Thu,  9 May 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmcNEuKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724912F5B3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256915; cv=none; b=uWkQiXizzQ4bc6VvfY1HEhgxcn+bUq1jkc7DDmOnXvCIcaWn0cCPUoVwWxM4BT6U7NT+2XFurPss1MicqGp/zqlBAjbVjxi+zYMybrsti+lTnh5p/7BUXv6/w/g7Rn17Wshv0tyugYMCya7kGawrU/lBljXtl8lsy20AU34ev0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256915; c=relaxed/simple;
	bh=Ue6KloG1ziBkqaZvwiTzYUyrAzs0sPzwmwfZuCahWMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEPvQbERI4amdNoQrN+Ab48Rbbgx/b/uvyYjJb4zGoS39KM/NWI2gTd5DvGqF9dLqNkFCEnSrckqIgh6LVBLVYLJTxpvEyprbt7TRRFfgLtOTq1AGgYVwBLAyVCboBcqxd0pLXq7SaLzsB5QyUmPF/OA+AhzArubzjaN78xxdlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmcNEuKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBFFC116B1;
	Thu,  9 May 2024 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715256915;
	bh=Ue6KloG1ziBkqaZvwiTzYUyrAzs0sPzwmwfZuCahWMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmcNEuKITbgV+UKzLSmGAjzZKDzUY+J+0CLhtbrUZs/8y/dy7aIvpCxqAJy6pG3Pt
	 Q0xHk4eKSpZ0u/zhaCQezhWyDLCHmubxcr5tfE1RSaS2CWCLxk3S8Ib/oFzsYdiEEd
	 TTlj7cMMUgUUoYioEMepGlarzaS+rBft43Gkmz6XCaN9I/BLeKye2BSB899eLuLcNk
	 sfJFAvOKS87BhZCSKAvd3QRqo2/qf7Exd+rsYC29G12lGI06WlSz5sN/83WFxH9BFz
	 oDg4ZOeuyoqb+2ypJmfn7roPRzeVY7pcs61VepFUX7naNwo7/HVoPP6YgOXfyLJv1X
	 U8MIxg/VeEIxQ==
Date: Thu, 9 May 2024 13:15:10 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 03/12] gtp: prepare for IPv6 support
Message-ID: <20240509121510.GM1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-4-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-4-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:42AM +0200, Pablo Neira Ayuso wrote:
> Use union artifact to prepare for IPv6 support.
> Add and use GTP_{IPV4,TH}_MAXLEN.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


