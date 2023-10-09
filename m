Return-Path: <netdev+bounces-39193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4977BE49F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D717C281A0D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799E37152;
	Mon,  9 Oct 2023 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2c633xjx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DE37150
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC265C433C8;
	Mon,  9 Oct 2023 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696865040;
	bh=c+LVTQX5zg+keyPvguZV4kyGAzn9+JPENSKqzOGE7hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2c633xjx7Mcpya6U253bbXQQlkd0hCs2abRXezhj03ehtaSpOdrL0DK0/SMcIVTKq
	 4lGsx1SegTxLvvsIKGJ6fa1OFODDtv3fydxEIqeKRVFf1924btTe7bjkoG0lCaB0MI
	 oNez1/TAVgZmjtDn0+XT6SCdizxojYZCgf8tEzIU=
Date: Mon, 9 Oct 2023 17:23:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/10] staging: rtl8712: remove unused legacy ioctl
 handlers
Message-ID: <2023100953-ungraded-tutu-6128@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-6-arnd@kernel.org>

On Mon, Oct 09, 2023 at 04:19:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The .ndo_do_ioctl functions are never called, and can just be removed,
> especially since this is a staging driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rtl8712/os_intfs.c            |   1 -
>  drivers/staging/rtl8712/osdep_intf.h          |   2 -
>  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 124 ------------------
>  3 files changed, 127 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

