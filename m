Return-Path: <netdev+bounces-55494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EB80B0C0
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF5AB20B83
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5A64D;
	Sat,  9 Dec 2023 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ska8AvZ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE6628
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 00:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FEFC433C8;
	Sat,  9 Dec 2023 00:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702080166;
	bh=aduvCOT8qpqm60Hp++3gS/bjqjCz0uHAStoHmv64nZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ska8AvZ8nkxsjFVCtPTlYftrAt777lcXmib1XQ4wertcqulpSs7iTvjmCrPlCYhKw
	 3JEvD93XFc3XLOCZMosA8Y5Rlf2r4+Y/L2Gs7oQ9vocAARozTiyeGSbACI0JS9WSvx
	 tDe+0F9hQtITNwA+2RCD9GHYC2wcbqJtUFiYXzdpzPYkb3xOygWk6VVw/M09N5lvZl
	 NTOOSwW7TTx424Ot9SXEzX6/acHmDVxFdxI2X4lne2YSMU6qOr47q4V6C5IePN5RVw
	 zXRST+QdUekvGT6GXWX3JRiIL70zeHH7a7UwUzrPs2TSlCu/1fnqkxAcE3hpXXGVzY
	 VgeDCXi147dAA==
Date: Fri, 8 Dec 2023 16:02:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: davem@davemloft.net, edumazet@google.com, imv4bel@gmail.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] atm: Fix Use-After-Free in do_vcc_ioctl
Message-ID: <20231208160245.3db141ba@kernel.org>
In-Reply-To: <20231206123118.GA15625@ubuntu>
References: <20231206123118.GA15625@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 04:31:18 -0800 Hyunwoo Kim wrote:
> +		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
> +			amount = skb->len;

Please run checkpatch, no assignments in if () statements.
This is better written with a ternary op IMO, anyway:

	skb = peek()
	amount = skb ? skb->len : 0;

When you repost please put [PATCH net v2] as the tag.
-- 
pw-bot: cr

