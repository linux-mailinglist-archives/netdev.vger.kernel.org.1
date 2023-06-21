Return-Path: <netdev+bounces-12437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C178273790F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 04:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E691C20D71
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 02:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113DE15BE;
	Wed, 21 Jun 2023 02:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379315B1
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48409C433C0;
	Wed, 21 Jun 2023 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687314194;
	bh=U1t8y2o+4DilbMZCVXTVXaO4HA6npnBe2I6NhhKYhtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DRdptX3/5QiVzn7Dju9Fm9BPxEUuvVD9fSsFt9PtD6bBiJcwgdKQ/YzE4xsc2bDxX
	 dlR6g+JjNT05oJknIbf7V/CBwsLksymSiJVQVOmo28lyqc6YEyluGZ9rctrpPxmohb
	 qVEYgFGf5xVWLlowcku8vp/TGCx0958kGTzyeb6knCkh0okkTkNPLDpH2LBS3hsBFZ
	 yE5EvrYjSQQRN44ejeCBT3pKoSX2aS6XH7EWeHM1jQWRU8tCWDQy5g0IvMyth5Ffzp
	 TTxVLpBUtsZfEWf+SJjIcw3ehX45PXv2Q97bkdQychVjbg6AbsVpIbya09i80F8Sau
	 nHdOQd/ysWg/w==
Date: Tue, 20 Jun 2023 19:23:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxim Georgiev <glipus@gmail.com>
Cc: kory.maincent@bootlin.com, netdev@vger.kernel.org,
 maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
 vadim.fedorenko@linux.dev, richardcochran@gmail.com,
 gerhard@engleder-embedded.com, liuhangbin@gmail.com
Subject: Re: [RFC PATCH net-next v6 0/5] New NDO methods
 ndo_hwtstamp_get/set
Message-ID: <20230620192313.02df5db3@kernel.org>
In-Reply-To: <20230502043150.17097-1-glipus@gmail.com>
References: <20230502043150.17097-1-glipus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 May 2023 22:31:45 -0600 Maxim Georgiev wrote:
> This stack of patches introduces a couple of new NDO methods,
> ndo_hwtstamp_get and ndo_hwtstamp_set. These new methods can be
> implemented by NIC drivers to allow setting and querying HW
> timestamp settings. Drivers implementing these methods will
> not need to handle SIOCGHWTSTAMP/SIOCSHWTSTAMP IOCTLs.
> The new NDO methods will handle copying request parameters
> between user address space and kernel space.

Maxim, any ETA on the next version? Should we let someone take over?
It's been over a month since v6 posting.

