Return-Path: <netdev+bounces-139350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F397F9B1933
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BC31C20C6A
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D47603F;
	Sat, 26 Oct 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyHLXlDE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438C7346F
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956972; cv=none; b=g4wMFS6/KtwmM4F6/LcEtwkW8FrWn8/Y7AvDmi8K37RUGN+N6CxXTDQV8SIXzDkOZW8/fxWGUZnj1yGDoNHu7aWTYhcBm3eTTdMT+tAOqw07v8zdrHbvRn9lJG+Rfm1JQhLBXnOCkCKWxUu2LBlgJHc6k5EHu6TYbkn950OyY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956972; c=relaxed/simple;
	bh=kr9THPKfNgmiwexzsKaLL1ApL9cQhgOM5UcZba738CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9OO44kXMn4WzbSzkfNo7v6Slbg8xruwfMDvvgr+u75Mf4hKYHtpPb/jQvFfvOW70rD394LfV4NgvIZrXaDX4t35A5HDGh7ZkYalaExYPR+YLvdInr+y2fjmAd8ji8DQBZROe0XzXgJTQRaA29HeEYM+Ov98EDRzRkaHf126x4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyHLXlDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EC6C4CEC6;
	Sat, 26 Oct 2024 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729956972;
	bh=kr9THPKfNgmiwexzsKaLL1ApL9cQhgOM5UcZba738CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyHLXlDEBqVyRyPRycQzQXtfbkcjkCay0VYHW3e25LE1xFyfsnwOCvgcucgsktlyy
	 lKN3+b21uVFWLOKOfcqS1y4g4uz0ZfZOCPLoy+uib2q93jOUM5wJc4SNGPLdHZa39n
	 r7x/qdTUeZTjXgTX0wZTEEfzZgFDeveY+lWE5aD0d4vTLsDwwtpjdzGl6A/4Sxr9w2
	 5U7qFtvwM7eK71fYy2Bg0uEe6XcaVS1GzVTgC3i1mwVlsomB8UzgXlWDNzJ+H2WJ2l
	 l6uc6BFDNJ8sB4ZDOE+jqfoSF0FrMw5D9GqlUMjY68QF2OwwhCQxiYE0dafcr5It0L
	 6GRVM6czfizmA==
Date: Sat, 26 Oct 2024 16:36:08 +0100
From: Simon Horman <horms@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] bna: Remove field bnad_dentry_files[] in struct
 bnad
Message-ID: <20241026153608.GJ1507976@kernel.org>
References: <20241026034800.450-1-thunder.leizhen@huawei.com>
 <20241026034800.450-3-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026034800.450-3-thunder.leizhen@huawei.com>

On Sat, Oct 26, 2024 at 11:48:00AM +0800, Zhen Lei wrote:
> Function debugfs_remove() recursively removes a directory, include all
> files created by debugfs_create_file(). Therefore, there is no need to
> explicitly record each file with member ->bnad_dentry_files[] and
> explicitly delete them at the end. Remove field bnad_dentry_files[] and
> its related processing codes for simplification.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

