Return-Path: <netdev+bounces-23852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE876DDD9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62476281F55
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1673D7C;
	Thu,  3 Aug 2023 02:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836DF7F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A104CC433C7;
	Thu,  3 Aug 2023 02:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691028456;
	bh=aik8cH2XF43pgGb9ZpqXmB3JGeEEzKxjYTCA21AGLdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/GMCVBtRYzR+qRDcAHfrU8Clk/JaJLRqhadqtp2mAjmovNCraINJRf/N1SQETtx5
	 VXIUvDtdnqgR9uKFJKIgxpbtaE2Ac6886lLg2+iaHo+mLm3LmPMBr69EsUDtSTURe2
	 czcjdaa29AQr8C/J10vXvr5pOqB9vBeyOCBgwcY16UohFHaURQ3DRmdHD9PngD4Htl
	 CHnHii8YWRquax4d0RfOaAH6ma7Q2MJ8jcsgyTsxHIaSoKlQe+Z3q0JBj2pYFs+DPW
	 e6rGxQtBBrYgRIsTd/HIfPmfY8zfcF1B3YNC36W+RrLGjlUA5u5vep6C5yasgYfx6k
	 QYUqG6LQuTe4Q==
Date: Wed, 2 Aug 2023 19:07:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 00/11] devlink: use spec to generate split
 ops
Message-ID: <20230802190734.4a9f9c0a@kernel.org>
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Aug 2023 17:20:12 +0200 Jiri Pirko wrote:
> This is an outcome of the discussion in the following thread:
> https://lore.kernel.org/netdev/20230720121829.566974-1-jiri@resnulli.us/
> It serves as a dependency on the linked selector patchset.
> 
> There is an existing spec for devlink used for userspace part
> generation. There are two commands supported there.
> 
> This patchset extends the spec so kernel split ops code could
> be generated from it.

Looks good! But you need to reshuffle stuff in patches 7-10
because there's a temporary build breakage. Some squashing,
reordering and maybe splitting patch 10 should do?

Feel free to post v3 without waiting the full 24h.
-- 
pw-bot: cr

