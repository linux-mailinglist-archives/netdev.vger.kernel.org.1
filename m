Return-Path: <netdev+bounces-14060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1A73EBA3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5651C20988
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22014270;
	Mon, 26 Jun 2023 20:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD414A80
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8163C433C8;
	Mon, 26 Jun 2023 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687810678;
	bh=9T+7daHgx1xtss02IAOpdNskFIch4WssAJyVD94wQPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNjo0SOxC5EgergGPGlU5IVCl6HU50kzS0hd85d7QosQmNfvCgkojzodGslc/N6tH
	 5TLMEr3y8aK3fB/4y99aGdDFUR7PNBplWlubSl8zQZ07D4NtwzQ2+1Dyw10pzKDqrl
	 K1/N/lITfLOX5IUVWcCERHlralJ5M3SXmjeu7U55OQpPfh/3VxciBnJRiuGTgYfZpT
	 KL9W5I+PYn1fFI5zpZMKT5Mbs/0nNdVoGuU3GLK+YzXzy3SECy6eTGRWxMGWAkwN6S
	 5IKws6V5seP1aylnJZV27J20YxjMZCr1f+XYUabwFvSMSFYPzPAOf99djTupqKqBpW
	 KtlewcdP4hCaA==
Date: Mon, 26 Jun 2023 13:17:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: ngbe: add Wake on Lan support
Message-ID: <20230626131757.3a7b04c0@kernel.org>
In-Reply-To: <934157CCB15D2775+20230626083708.47930-1-mengyuanlou@net-swift.com>
References: <934157CCB15D2775+20230626083708.47930-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 16:37:08 +0800 Mengyuan Lou wrote:
> +	if (!wx->wol_hw_supported)
> +		return -EOPNOTSUPP;
> +	if (!(wol->wolopts & WAKE_MAGIC) &&
> +	    wol->wolopts != 0)
> +		return -EOPNOTSUPP;

AFAIK core (by which I mean net/ethtool/* code) already checks that
bits outside of ->supported are not set in wolopts.

Please post v4 after the merge window (in 2 weeks)
-- 
pw-bot: cr

