Return-Path: <netdev+bounces-100400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5918FA655
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0891F220F5
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F08288C;
	Mon,  3 Jun 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYwEfWrx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D27FBC4
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456674; cv=none; b=UPJLEzHv+8vQ8X2tAGAAxo0vMznI3hbucocX/1UtalQYh1rYN2xW03Pfsf8EfBm3eMKv+kSCKCXct5Ig/wupPrIxX5ufY0TpOzJ4Pl2o1zqtW7H3kLEr4BZDRAgQvGu0L3ElVuqb1Eo7r3BpO1FMsY/J243PLd+mX3oobNBs8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456674; c=relaxed/simple;
	bh=W3fxcxFe4eisF2Sj6pQ+CpXEAxbRDO/oP7sVkIWBBRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHen2l1fG9QuWfAqnc9099C2N5sih3MHEJ8t9wK6OWUAKVgOFKXFK6no6e9YyPOAjdsxRdsrqfCqkHhmkap+oKkRCMvQ0YXCsT0eZsS5rJSMLQJUCeUejGrgzm2YEnLSkgz2usLOyyTjtG8IXO3DOi/nabL4KpHmv75JKplU1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYwEfWrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853B1C32781;
	Mon,  3 Jun 2024 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456673;
	bh=W3fxcxFe4eisF2Sj6pQ+CpXEAxbRDO/oP7sVkIWBBRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SYwEfWrx4dUdYxr7qSajr2u1F3zKf97IkG7NrCwJG376T+deTj6zJ4YhUWYqLTo2g
	 osXFYwdJiLEcegGJ81ucQwCGOEXSI9YX0EL/gVE7BTpe2ZuqM9/zGAtVHrA7GbsyAR
	 t1XwbDbUJab117ilxH4dcjKu4P/TCvgBCXc3TNJOoBTgc/7z1gZVrm6LQ1uP5sDTLq
	 x6E7y7RP39eceMX3VUwtkUllm30xudrH1PGB3lTruofYJ206wxb3B+BGbSbPsGzNIk
	 xFTYnqvM3IraeNQLwnwZWnqyYrvKi1R+MK+X0L3FrHTb4EEPAoTf6L3bqLbZPw2gt+
	 YPP7tDxKu2sCw==
Date: Mon, 3 Jun 2024 16:17:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
Message-ID: <20240603161752.70eee7a4@kernel.org>
In-Reply-To: <b062c791-7e4b-ca89-b07b-5f3af6ecf804@gmail.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-2-ahmed.zaki@intel.com>
	<20231121152906.2dd5f487@kernel.org>
	<4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
	<20231127085552.396f9375@kernel.org>
	<81014d9d-4642-6a6b-2a44-02229cd734f9@gmail.com>
	<20231127100458.48e0ff6e@kernel.org>
	<b062c791-7e4b-ca89-b07b-5f3af6ecf804@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 19:54:49 +0100 Edward Cree wrote:
> On 27/11/2023 18:04, Jakub Kicinski wrote:
> > On Mon, 27 Nov 2023 17:10:37 +0000 Edward Cree wrote:  
> >> Yep, I had noticed.  Was wondering how the removal of the old
> >>  [sg]et_rxfh_context functions would interact with my new API,
> >>  which has three ops (create/modify/delete) and thus can't
> >>  really be wedged into the [sg]et_rxfh() like that.  
> > 
> > Set side looks fairly straightforward. Get is indeed more tricky.  
> Looking at this now, and wondering if the create/modify/delete
>  ops should use Ahmed's struct ethtool_rxfh_param, or keep the
>  separated out fields (indir, key, hfunc, and now xfrm) as in
>  my previous versions.
> Arguments for keeping the separate arguments:
> * Ensures that if the API is further extended (e.g. another
>   parameter added, like input_xfrm was) then old drivers will
>   refuse to build until fixed, rather than potentially silently
>   ignoring new members of struct ethtool_rxfh_param.

We add "supported" fields to the ethtool_ops (e.g.
supported_coalesce_params) and reject settings in the core
if the driver didn't opt in.

BTW I have no attachment to the existing cap_rss_* bits, feel free 
to rejig.

> * Avoids potential confusion by driver developers seeing the
>   @indir_size, @key_size, and @rss_delete members of struct
>   ethtool_rxfh_param, which are all superseded by or at least
>   duplicative with parts of the new API

Can we avoid the confusion by careful wording of the related kdoc?
"context" is the current state, while "params" describe the intended
configuration. If we move the "no_change" bits over to "params", 
I hope it wouldn't be all that confusing.

>   (struct ethtool_rxfh_context has @indir_size and @key_size members;
>   the separate 'delete' op in the new API obviates the need
>   for a 'delete' flag).
> However, you presumably had reasons for wanting the arguments
>  wrapped in a struct in the first place, and they may still
>  apply to the new API.  Guidance & comments would be welcome.

