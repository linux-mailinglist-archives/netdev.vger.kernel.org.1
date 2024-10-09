Return-Path: <netdev+bounces-133657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9ED9969D2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B2E1F25BFC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D35B194088;
	Wed,  9 Oct 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgskm8gG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9B193435
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476349; cv=none; b=JPtWXPEDozB5NN08VuLGv1IUrRSZ+RMOvklwiP6EO7PkQcNUiuMB+5icgSoHbSaaq0Ba+3hFXCqZRNk3gGQO/mkwgmxc6m9zgYrWvIH7YSpbgXSzG2mMcjAIk1H4ZU2jkRRZuDXFPlD5CzbuUxYBMNlxtXLW9pCiqqGB3155qQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476349; c=relaxed/simple;
	bh=Tu775y0L59c4BZ6RmOQIMcOmu+i1nmEKi/FTfgS9iEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvu/BrIDobt7Q5kCP75b/hcpJ55IPMqZOs+eID01j4z+oXva5YnWseI4c+DwkeJ9eWK14D7O+xg1cPHVhcMux/e0pjvBnUjMQtC1jQaF7HqS4o1oMiFeJ0p9hJsnGA2qamYakK0wSnbQiFzqeLN8sgYF2fP7e/1dey7VcmDC+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgskm8gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270B8C4CECD;
	Wed,  9 Oct 2024 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728476348;
	bh=Tu775y0L59c4BZ6RmOQIMcOmu+i1nmEKi/FTfgS9iEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgskm8gGIRrcArsGJYs5/qlxFVjYeneJmPRuuIc6hqh6vq+3hS8t+5aDoIM7ggZc2
	 DWUGtjwuy5kSXGNbtkob0Wq1OWoWJjIKv7xs7mcCMjJBsUnADgLU/J93gl26cqjXeN
	 Qy+3xbtLTs2vJHtiLjABqpheeHkgvcjkolgN4Qa7Iu2sEBEhXEErCuXFS3TwLJTnxk
	 1IDomFTxii2LnsEX1LD7y/j/CM7CY8o4/87jzT4uTAEOTgeQKJGQarkspksxGYuWB0
	 birrk8Gq8Sr/PNmbsN6s2J2KVyiQ/W3xHIdTRjSUUGeYsRQM/+90ZKYLq8t1v1/Ryv
	 KnLJiT0aytg8g==
Date: Wed, 9 Oct 2024 13:19:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, konstantin@linuxfoundation.org
Subject: Re: [PATCH net] MAINTAINERS: remove Yisen Zhuang from HISILICON
 NETWORK drivers
Message-ID: <20241009121904.GN99782@kernel.org>
References: <20241008153711.1444085-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008153711.1444085-1-kuba@kernel.org>

On Tue, Oct 08, 2024 at 08:37:11AM -0700, Jakub Kicinski wrote:
> Konstantin reported that the email address bounces.
> Delete it, git logs show a single contribution from this person.
> 
> Link: https://lore.kernel.org/20240924-muscular-wise-stingray-dce77b@lemur
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Hi Jakub,

I agree with this fix, but maybe this patch could be considered instead?

- [PATCH net] net: hns3/hns: Update the maintainer for the HNS3/HNS ethernet driver
  https://lore.kernel.org/netdev/20241008024836.999848-1-shaojijie@huawei.com/

...

