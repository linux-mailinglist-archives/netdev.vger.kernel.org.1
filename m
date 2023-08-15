Return-Path: <netdev+bounces-27542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C8177C5CD
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA881C209E8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC17617E1;
	Tue, 15 Aug 2023 02:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359117C4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C87C433C7;
	Tue, 15 Aug 2023 02:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692066153;
	bh=KuOjhbkQfW8nBcfCW1VPKI10VytwrdKLMPsc9fioNEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BqtYyJD+QrLoDCvmoG/7UNpKiXLi2mSLMZswHt+TrP2XNIUmP3gLFrXjpP2rdLDGB
	 x+ix0Ztb8f0s2kcKLCRhIuoPOruA4IYuSjl8TAEP53mlmIta/77S9AhkwW13aSJc+s
	 k80fFgAogoHgaBs65b9W6hlpQ2VN9je/uyPgw1BGFXHHz95/8F2ab7P2YjCY8WSxHO
	 yZ9QYFmo+6uWz7Rhsa1UZPXIlee9bJXKmfH9uq+YvZbFPPjRF2Irk2ko11ANS1ASU8
	 EhJDkk8lyd91XYHCyh5ND5MOMjILyHlJZEUsnUEOa1h4X6uSeaeYqe4led8hruHiYQ
	 /P9Gyx4WKD0YA==
Date: Mon, 14 Aug 2023 19:22:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] gve: add header split support
Message-ID: <20230814192231.12e0c290@kernel.org>
In-Reply-To: <20230811223938.997986-1-ziweixiao@google.com>
References: <20230811223938.997986-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 15:39:38 -0700 Ziwei Xiao wrote:
> - Add header-split and strict-header-split ethtool priv flags. These
>   flags control header-split behavior. It can be turned on/off and it
>   can be set to 'strict' which will cause the driver to drop all the
>   packets that don't have a proper header split.
> - Add max-rx-buffer-size priv flag to allow user to switch the packet
>   buffer size between max and default(e.g. 4K <-> 2K).
> - Add reconfigure rx rings to support the header split and
>   max-rx-buffer-size enable/disable switch.

Someone on your team needs to participate upstream or you need
to get your patches reviewed from someone upstream-savvy before
posting.

Anyone participating in netdev reviews would have told you that
private flags are unlikely to fly upstream.

One part of an organization participating upstream while another
has no upstream understanding and throws code over the wall is
a common anti-pattern, and I intend to stop it.
-- 
pw-bot: cr

