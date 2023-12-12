Return-Path: <netdev+bounces-56548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB3E80F54F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954E4281720
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA037E775;
	Tue, 12 Dec 2023 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKwKGBqs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C255B5D5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F8C433C7;
	Tue, 12 Dec 2023 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702404966;
	bh=55v2YEAEajqeqknulyuWsJXXATDMpGT7WsJUIr0GI/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cKwKGBqs/hXYX/mV4mPQ1ZwkgUJrnnfWNcTPTyuiWBMJ/leiYEQSgENKdG3sfmvuE
	 bSxth5b7ltOcRFcXTlP8+X9n+jOnsalASL5N2T8+CKUnwMTofd6ykO/MA3iEjkEH1I
	 vyEo/J55wTxQRcgS8Z26G14QuLjkeJL/++nkTRr5TV82egehIoXsWMvKeHxZW1Xyid
	 HlrXsxTNt0sQBUanT+A3LL7p35sHXf4ZvAD3mpjk4w5JT0X9ECdORpdYkQ6uqWc+hj
	 S+MdnAXBQoDEF/jxjxTWyYFWDxeb6TrrrvUcE3mDsEqhmpugczKoOVcl1o+k1jfZrz
	 hwp9ZTajSJYBA==
Date: Tue, 12 Dec 2023 10:16:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Michal Kubiak
 <michal.kubiak@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Michal Kubecek <mkubecek@suse.cz>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] idpf: add get/set for Ethtool's header
 split ringparam
Message-ID: <20231212101605.766fbbcc@kernel.org>
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 15:27:50 +0100 Alexander Lobakin wrote:
> Currently, the header split feature (putting headers in one smaller
> buffer and then the data in a separate bigger one) is always enabled
> in idpf when supported.
> One may want to not have fragmented frames per each packet, for example,
> to avoid XDP frags. To better optimize setups for particular workloads,
> add ability to switch the header split state on and off via Ethtool's
> ringparams, as well as to query the current status.
> There's currently only GET in the Ethtool Netlink interface for now,
> so add SET first. I suspect idpf is not the only one supporting this.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

