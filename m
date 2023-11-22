Return-Path: <netdev+bounces-49868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08F7F3B63
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AB9282AAD
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067B5393;
	Wed, 22 Nov 2023 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk6ZT7NR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9EE46A6;
	Wed, 22 Nov 2023 01:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC4FC433C9;
	Wed, 22 Nov 2023 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617380;
	bh=YCYSa/A3qGr3xygl+kOwHA+qN3D8bBICw2GWRrWzZmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pk6ZT7NRdKj3r39HnJeyqmOsqwjj8HGrXerZ4Dnr9puFEcaBrh2p4gwNk9Jkn6ooX
	 yyazQOcCfRtocQ3POjfe8GxmcAQZ8FlMwZ4rvs4fFE9rT/3zSbAKf4FjvRJuBzft85
	 mX5DW88vHVHJJfDwIfXARirDFMfbTTHpMNrrJ0e7PbYMwlQpq5K2Fxj4XLhXmQLwTK
	 HAHFuSnXrXQt352o9PSm5rrkkzsU1+Yr91hftrmt4KDEezUhEvnKmptAm/c6Ok/ycd
	 pTQkRUtxT571tvVH2hT4m/7YZEhiKCFue8CCUxlRCCcPVawryBtvg9RqAptuZBGIjs
	 M5URt2NNm2qMw==
Date: Tue, 21 Nov 2023 17:42:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] USB: gl620a: check for rx buffer overflow
Message-ID: <20231121174259.54f11073@kernel.org>
In-Reply-To: <20231121134315.18721-1-oneukum@suse.com>
References: <20231121134315.18721-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 14:43:15 +0100 Oliver Neukum wrote:
> Signed-off-ny: Oliver Neukum <oneukum@suse.com>

s/-ny/-by/ ?
-- 
pw-bot: cr

