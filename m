Return-Path: <netdev+bounces-39196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6083D7BE4AC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5429281B99
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162D33715B;
	Mon,  9 Oct 2023 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijsFJQuH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90F37152
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1506C433C7;
	Mon,  9 Oct 2023 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696865061;
	bh=zuaUKR5hhGmNwxo4/WYo0MDrdfEbXYhaQqjlY5wORiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijsFJQuH3aqI/SBO5lAJCxZJVFXUWWC8FEhcyW6rTBoE3ZX6YlRNxaDUZpAeSOhY8
	 E9HQvD7XLMGiHkRAixo5FoiPKrcQ+Q+DQHgHwHzZBOXceiQAvozpuQvIf1zymxNsuK
	 iltc+PaLqQoeKlBHp8/KG8e06LmJJkQ6fv3N4MFo=
Date: Mon, 9 Oct 2023 17:24:18 +0200
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
Subject: Re: [PATCH 04/10] staging: ks7010: remove unused ioctl handler
Message-ID: <2023100913-various-doodle-cfd0@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-4-arnd@kernel.org>

On Mon, Oct 09, 2023 at 04:19:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ndo_do_ioctl function has no actual callers, and doesn't do much here,
> so just remove it entirely as preparation for removing the callback pointer
> from net_device_ops.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

