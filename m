Return-Path: <netdev+bounces-32142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE3793055
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EF22810F6
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5BDF69;
	Tue,  5 Sep 2023 20:51:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A78C14
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF0AC433C9;
	Tue,  5 Sep 2023 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693947065;
	bh=IAfZD62GpmBQoVGiSUG9EApPenk0Eiw2bjCJMCsRqyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n9LEKj/AoIxy36nnexsV6oqzkMZkl9gynD9E6ojvBpffxxQVRz816uTmHvLZg4sFo
	 NN57OGAR0rV6mxxgUA6NAFrDnSjn9rZ8N/VxkXyq1TppUgXaBNwOo7DZZzXlOWb6rc
	 bvAsBxk54AHgNLe3uYYw6WXw7JbXJQpjWx50HDIhL9N3bBBgxExKob/9ybRAl8nm8v
	 9cQd+1bLrqOuVo0qZ0jchYJlbjfpQjhz9jQxsW0Fy91wUZWx54vME6lPktNNc3dwgH
	 Ua7q3i/fobLiaB+Wkwpbr73SlUgm1QoRAC9A0uGuF1uQltel6QeByTVXKh5PFAtCVD
	 N7irBo0mhMZVA==
Date: Tue, 5 Sep 2023 13:51:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Felix Fietkau <nbd@nbd.name>, Maxim
 Mikityanskiy <maxtram95@gmail.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <kernel@axis.com>
Subject: Re: [PATCH net] net: stmmac: fix handling of zero coalescing
 tx-usecs
Message-ID: <20230905135103.04649841@kernel.org>
In-Reply-To: <20230905-stmmac-coaloff-v1-1-e29820e8ff6d@axis.com>
References: <20230905-stmmac-coaloff-v1-1-e29820e8ff6d@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Sep 2023 13:32:48 +0200 Vincent Whitchurch wrote:
> Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
> coalescing timer but currently it gets programmed with zero delay
> instead.
> 
> Disable the use of the coalescing timer if tx-usecs is zero by
> preventing it from being restarted.  Note that to keep things simple we
> don't start/stop the timer when the coalescing settings are changed, but
> just let that happen on the next transmit or timer expiry.
> 
> Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

This does not apply cleanly to net, please rebase and repost.
-- 
pw-bot: cr

