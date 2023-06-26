Return-Path: <netdev+bounces-14076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275973ECCA
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DB31C209EC
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0114A9E;
	Mon, 26 Jun 2023 21:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48515482
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ECAC433C8;
	Mon, 26 Jun 2023 21:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687814578;
	bh=m5tAbNXuwzu/wTbTJhZUflS9MvTlLgnUmPd2W8oqPUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d49M38lPe12UNxthVPgEwPskrnE7j0e7lFnrZqCgvgUIcPWXRGJjlTxOHSMLp4PBU
	 j36UQSceNqPOYJtYYXZrg3vJo4LFaP7gJuBdHAi1yU2Eydtr+tr3Pi9+gw7N2/tF5w
	 zzi3IugQnNheyRplFzh6DQ+Agyj8lkootV/Z3nCjmLaSyjmXCQFss7VDnVrRFLI2u8
	 mzjRDgpxaaBtSmN5bZ8B8tBN5cHkhgt0Tj+JQ+jbWRlCAV75N04UCOAVblSRZCOsg3
	 CEu3Y3GPVCA+Yg5MLuM/fSBQOA0Rkw+R1WZ0nQ5wxrLWyiDArslc+1p67yVj9V9zOD
	 AFF5C8KvghIBw==
Date: Mon, 26 Jun 2023 14:22:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
Message-ID: <20230626142257.6e14a801@kernel.org>
In-Reply-To: <3112097.1687814081@warthog.procyon.org.uk>
References: <3112097.1687814081@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 22:14:41 +0100 David Howells wrote:
> Do you know if ->sendmsg() might alter the msghdr struct it is passed as an
> argument? Certainly it can alter msg_iter, but can it also modify,
> say, msg_flags?

I'm not aware of a precedent either way.
Eric or Paolo would know better than me, tho.

