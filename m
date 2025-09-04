Return-Path: <netdev+bounces-219962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2578B43ED2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E581C88047
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F5330DEB4;
	Thu,  4 Sep 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvUs8DD6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D0307AC6
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996132; cv=none; b=cmS9KrJpbOq/a2llDiVbyXYytUjm7qLqHvniqakKSBfAJTjL25mFdP9CpuVXjHHcNzPw2Fb4nQyZT+382yBc0uLDTZAOFomoAW5KlC4dqA0yjRP7Dxpamji7TBpmsW25EI/gvSBqMVSFq5ja7lC0nHLNlCxe22vCh7tJ0TDOrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996132; c=relaxed/simple;
	bh=iemAXjP6bJjw8GwcJ41g4c70nmja6vnq0CHi0l09YDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGI+5FEy69Cg/oGmf+x8q3tcoTn884n+7qLSuV9g/m+Fql3Y1vfmS8TvoppT9DcBRXmT4melKHqPyFiQpxKi+T2FO3Gji+kwYRh/iNdv3b+n51ODHvwOrUbrIhErD0/FzSf8TvZh8OrPSyWN8yQK4p/j7pFwV/zwDaOsxS+Z6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvUs8DD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B555DC4CEF0;
	Thu,  4 Sep 2025 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996132;
	bh=iemAXjP6bJjw8GwcJ41g4c70nmja6vnq0CHi0l09YDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hvUs8DD6KQbDPLTQDPHN/fTeTgnOAF57w1uKF3+TS+AEOuCfads+NJHKeSFgnH7Gs
	 tlNUvLXpmvWYRELth0xebC8gyZPlWCCEB+7BuGghXu/hIa4okfoAKOLVf9NjeRMhXh
	 DkJlyyC8kYnPg+wACIlPm2/GurXbu+T8pktbKpq78ppIVXzLXZ9ta9z9gnRX01xi9x
	 TeRS0t/lf1DD3HOB9Kgk6WQ0kPdIed3jSnyFbp8OB1T90Pr1seF3vIicUjAflou+iE
	 oTUObrPIluN4die1d3GjX2XsIAsar+A182l1Cg77Kf/poRcBXhUlh/Qisw2QftwncS
	 dN0O7wG29+CCA==
Date: Thu, 4 Sep 2025 07:28:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Simon Horman <horms@kernel.org>, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [External] : Re: [PATCH net-next] udp_tunnel: Fix typo using
 netdev_WARN instead of netdev_warn
Message-ID: <20250904072845.045a162b@kernel.org>
In-Reply-To: <e022df33-8759-4fa5-a694-d0d16c51d575@oracle.com>
References: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>
	<20250904091832.GC372207@horms.kernel.org>
	<e022df33-8759-4fa5-a694-d0d16c51d575@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 19:15:57 +0530 ALOK TIWARI wrote:
> since WARN() triggers backtrace and dumps the file name
> it is not require here. The failure in udp_tunnel_nic_register()
> should just be treated as an expected operation failure, not as a kernel bug

You keep saying that without really explaining why.
I can make a guess, but the motivation should really be part of 
the commit msg.

