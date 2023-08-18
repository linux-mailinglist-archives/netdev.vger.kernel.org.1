Return-Path: <netdev+bounces-28732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E97806D8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84F51C215B4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A6168BC;
	Fri, 18 Aug 2023 08:06:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA314AA7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948AC433C8;
	Fri, 18 Aug 2023 08:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692345968;
	bh=DfL6ELNpmiDiKZgEEu9kk86DoHbt3AbGnuiaZBqEfzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=er/nFVBlQXYKGAhI98JCOsNprVwbhZD5YmsrEp8uG4KNxT0JOHJYqZOCi8lwhhaxV
	 y4SEiKc0M8mFonSRZnTqG0aEteyYrgscDelNYOI6hn7Sj425/Q753DcA4RjgftjaLQ
	 9eWNNJHlBdm65CxSU7AEGdZHOr0OdVVXt1LiZJyasDDdhNvnGKhdUiuYiDKENGHDBm
	 P8/Q/zORxkTNMX+IPB4Y2xsaUernZwXlBhXRvkYDC/RaDT6UihMASluuR7Zeix31YX
	 n8zlSCExAqOwI5X8TW3g3OT6OcF9b+ZcvdIUEMLuKjRM3S0vE63Emg0gjRYVVZEHma
	 S9NwsosO0FVNw==
Date: Fri, 18 Aug 2023 10:06:04 +0200
From: Simon Horman <horms@kernel.org>
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [netdev-next] net: release reference to inet6_dev pointer
Message-ID: <ZN8mbEnFGBCr3YLj@vergenet.net>
References: <20230816220203.1865432-1-prohr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816220203.1865432-1-prohr@google.com>

On Wed, Aug 16, 2023 at 03:02:03PM -0700, Patrick Rohr wrote:
> addrconf_prefix_rcv returned early without releasing the inet6_dev
> pointer when the PIO lifetime is less than accept_ra_min_lft.
> 
> Fixes: 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>

Hi Patrick,

this patch looks good to me, but unfortunately our CI got a bit
confused and tried to apply it to net, where it does not apply
because the cited commit is not present there, rather than
net-next, where it does apply. This creates a process issue for us.

I think it would be useful if you could repost the patch with
it targeted at net-next:

	Subject: [PATCH net-next] ...

Please feel free to include:

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: changes-requested

