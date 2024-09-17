Return-Path: <netdev+bounces-128721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F097B2A3
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D5C1F25804
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58461714CB;
	Tue, 17 Sep 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sabeag0s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776315B57A;
	Tue, 17 Sep 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589436; cv=none; b=qIYbR6nDKsbquWv4dqCt2r2mGKj/th+93IEJkHZ47sujMja2I1XNcNbmxm8i2SELym36CifUIFU5PkEpJVMoOnw85wElHGNA7F4tWVCaIucbmg6PxZ7zxu9DW7J2JDA069OyxRPd+nDNkgYOtJ+8UXEeBKzCeM2MyZBFmuDR7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589436; c=relaxed/simple;
	bh=VVhwN0XVxHSEiQ8/qkRJe1SOtTslXAvZyuME+F4wlRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3GTi4Hi+bpNotPmCS1ZrHDxvUc/zceEvMEZ8XEjE6ReVlUmJDVMUWz+c/19MQo2VkVjuGA8PnrXRFXYgVCrJWp3ZMnxxfbmcbb5HmmuHeFdqAF+9rA416JKdHIgdjstgDBwEDbfKyKs3QddcNrWM9MKXqW5tcmjaUCess0dzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sabeag0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0D3C4CECE;
	Tue, 17 Sep 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589436;
	bh=VVhwN0XVxHSEiQ8/qkRJe1SOtTslXAvZyuME+F4wlRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sabeag0sed9+o1r05QjYjEtqBEtxzjatHopH+Q9sYJcCJZflEx5Tn4mYAql1/2jPK
	 7Kv1XKN2KCMtKIocOLGNA99DEZZPLQHTiv0FxiNMusKn2FuZtsGz7FKGjax7JKXtrQ
	 txrcydaMM6IkWm2f7pkMHRWRmV2Uh8Tc2SdxdhYQRL7/FO4K54Sm4QF9wgBVHu6XHA
	 rA/m28YfRbgnpmgA1H8vj+jm4pDdzvBlmg/Bzq5/NJboLNt7siXU2AVbnly1ewx2GX
	 4mtFE0t7l/Mt2pRp5A3Xj19V2Y4t83qJmIZLmNBSTU/OlaHKPcHFYNUJQwqfEniAKJ
	 fDb0F/4FZtpZw==
Date: Tue, 17 Sep 2024 17:10:31 +0100
From: Simon Horman <horms@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry of the oa_tc6 header
Message-ID: <20240917161031.GO167971@kernel.org>
References: <20240917111503.104530-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917111503.104530-1-lukas.bulwahn@redhat.com>

On Tue, Sep 17, 2024 at 01:15:03PM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit aa58bec064ab ("net: ethernet: oa_tc6: implement register write
> operation") adds two new file entries to OPEN ALLIANCE 10BASE-T1S MACPHY
> SERIAL INTERFACE FRAMEWORK. One of the two entries mistakenly refers
> to drivers/include/linux/oa_tc6.h, whereas the intent is clearly to refer
> to include/linux/oa_tc6.h.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference. Adjust the file entry to the intended location.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


