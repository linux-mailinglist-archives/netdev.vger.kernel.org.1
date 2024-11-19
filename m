Return-Path: <netdev+bounces-146237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C899D261F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDB1F245E8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8481CC890;
	Tue, 19 Nov 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a70Bd5Ma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DC1CC88C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020698; cv=none; b=oFaAnL2TcK4J62eW8NbZXvV5Si2yMA3kicvOYidirq5sojf34VbVrjMYX2YIQKSDwhULLyi1g7Y9oALK8az/i+qGWEkyCMfQoegpRZ8PFkllWjJ/tPMMgK0bsis0+jU9dsEdXAyPhvhkmsSsx+Z56kIe+X1OcqUhk6vgR/ZD07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020698; c=relaxed/simple;
	bh=+6yvH3P0hsBkjwshPygcMT837NKeNcdx2ur3DNpfmMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhJxZ/bsXQrKu/kxUOKV5XhUJCyOc7an/lTM3l+O6NRELRXW8G8hGGPhvdriuWLvm+YkWff9wuSs7niXCU95hlfshzhLZYEs2OQB0X9Vvf7gi2f9mdZSq6CfcTivIakOaZwnEvpvwW6KW4uMXtYZDk9v5RTbDwbdIf622kvIbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a70Bd5Ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A55C4CECF;
	Tue, 19 Nov 2024 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732020697;
	bh=+6yvH3P0hsBkjwshPygcMT837NKeNcdx2ur3DNpfmMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a70Bd5MaxSziiSEuolma9ISTDOef42wQDO+L96OQqU/g5MgJfBtPgWLN/ksIYcQRL
	 Gd+t9g0suSSH7ZEijjg9ZsvJ6vv3rMPqpXPPSQdNQoJK7g2piTc34BND/Dgp/BtUne
	 x4zG7n8SUcwVau/gVfedqKi6OAtvlfiC7Oxe7pNIOL0ODTnHvpuOCDRBqTJOr6oJH9
	 W0Lp0kfDQWgCUumeHkFVTFzjlHtLkX6naBuW4a+F0U9x9mG4YrcON2QWTAX06T+1mq
	 fuwPmTytC8hSBui6exUkLGtXYV7cDHNv1Ry+1JV8hulbqrlKjXbGyneYKtL3FtwgmK
	 ZGEXtuoICw7RQ==
Date: Tue, 19 Nov 2024 14:51:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20241119125133.GA26101@unreal>
References: <20241112192249.341515-1-wangfe@google.com>
 <20241114102706.GB499069@unreal>
 <CADsK2K-Fi7U+OwRquyjD-mwwVuiqaUk699g9zEJCdk_HA+tPYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsK2K-Fi7U+OwRquyjD-mwwVuiqaUk699g9zEJCdk_HA+tPYA@mail.gmail.com>

On Mon, Nov 18, 2024 at 11:28:01AM -0800, Feng Wang wrote:
> Hi Leon,
> 
> If you are concerned about the case when if_id is 0,   I can make the
> change to add the SA only when if_id is non-zero in the .  When the
> XFRM_XMIT flag is set,  validate_xmit_xfrm will return immediately,
> there is no need to check extension and flag. Are you ok with that?
> 
> Thanks,
> 
> Feng

Hi, 

You was already asked to respect mailing list email etiquette and don't
respond in top-post format. I would like to add to that request, please
reply in-line and don't trim whole message as it is impossible to keep
context in your emails.

For now, I will just ignore your emails.

Thanks

> 

