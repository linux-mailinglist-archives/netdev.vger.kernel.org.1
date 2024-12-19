Return-Path: <netdev+bounces-153385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883C9F7D0C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED09F188B90D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8322541A;
	Thu, 19 Dec 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vATuLOpz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF66225404;
	Thu, 19 Dec 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618280; cv=none; b=j7zmDTOM640WVzcQLgVWjeK2lB5RLmZ76A2oPeTuuYZ4KRIktBWLR4Slp+pL90IryrcsajnJk/0Acw+BgdyCtoBe3HzdAfIrVyhzSckimOVAwuKubDGTxlWB7I9N9T3yh+A0iFbkn13osD7vAr/WQcngZHX0HcCkiMnTqbe1xa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618280; c=relaxed/simple;
	bh=BU3sv4G/7lDvxRl3k7R+zi2g4pa89CroB5GbFcn4rkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHBywwnuMfq+uDDFyf1BVdL51YJuYAWq1vE5/9bja0Kc4qwlVTujLjbrmr6j+sAS4bcNoaMnw37978y/oYjgThHCi5kjy+VkryR9nVnkD86iqKRAqYjyb64PYWtTSM5abibpOVVwx/9qAqPKGMLLUyvQBstbG6Lc9HIZcmpqQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vATuLOpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C6CC4CECE;
	Thu, 19 Dec 2024 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734618280;
	bh=BU3sv4G/7lDvxRl3k7R+zi2g4pa89CroB5GbFcn4rkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vATuLOpz4sH8f5yehTfRo6EPOd0SGyf1w7a7Oira9WREkS8fkbsXyVm278WWKo8h7
	 BEuw8p9vhoMH5zk/SD5AGSxiPG6Lmie6u3cmXuRAVoGwymExRguzI6Mw3AOdeJFSOt
	 mGiT5w5LsYFEFKfc0aAxXRrj3R6ajce3OBkIRYifW+dcAw3XvMcnHYdvFFYFrEe660
	 aaiNIQEgYv5eOPnfuqC89M5KJXp+krZ1WP2g3brvxiHRMvhA0JMTNR9DCxtML+IHbv
	 a2H0kqEaGDOXzjBQzNJmwvrZqweI3jcalGXzUY+9wX2IiFduGSCCJ3iFWpg3ZEqOi2
	 3Fwuun8wcYubg==
Date: Thu, 19 Dec 2024 06:24:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guowei Dang <guowei.dang@foxmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Yunsheng Lin <linyunsheng@huawei.com>, Furong Xu
 <0x1207@gmail.com>
Subject: Re: [PATCH net-next v1] net: page_pool: add
 page_pool_put_page_nosync()
Message-ID: <20241219062438.1c89b98b@kernel.org>
In-Reply-To: <tencent_76E62F6A47A7C7E818FC7C74A6B02772F308@qq.com>
References: <tencent_76E62F6A47A7C7E818FC7C74A6B02772F308@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 11:11:38 +0800 Guowei Dang wrote:
> Add page_pool_put_page_nosync() to respond to dma_sync_size being 0.
> 
> The purpose of this is to make the semantics more obvious and may
> enable removing some checkings in the future.
> 
> And in the long term, treating the nosync scenario separately provides
> more flexibility for the user and enable removing of the
> PP_FLAG_DMA_SYNC_DEV in the future.
> 
> Since we do have a page_pool_put_full_page(), adding a variant for
> the nosync seems reasonable.

You should provide an upstream user with the API.
But IMHO this just complicates the already very large API, 
for little benefit. 
I'm going to leave this in patchwork for a day in case page
pool maintainers disagree, but I vote "no".

