Return-Path: <netdev+bounces-44923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6A7DA3F0
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DE91C21123
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133A405D6;
	Fri, 27 Oct 2023 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA7lzF9E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B338BAC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 23:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED63C433C7;
	Fri, 27 Oct 2023 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447932;
	bh=NE+81gfyy96xKk7IPcqnToO7uQkc2vbU5rV52eM5mvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kA7lzF9EFrorsFxlsI39nNjDJCQiBFQ3pTy+JoPwRX9FGkdE+mZ9v/WEvVyDRLcL3
	 XlAVb4Jtaibz/vb775fnQs6BELMUNHQsCx5RyBR0UdxAJbcTu3FT7A+pf67z9/PuK7
	 O8yoj6zWb6EQC11R2Ez0AQbMDXDOQlhFcVxGrKnh0jkXnJzjqU9ocF3jH47HgdVczN
	 MnKilTW9YIKH5h/lBwP7LGcTpAJ/bANYABP6QxRzSiDNExHTeTbuFpXwY2hmMOPvCC
	 AyD1QntogF4ZKBu4ulPT+KkBbmPcnupD0qKv86VrEAgo38Q/3FPl9ptVfS35BFeP0O
	 t/9jqQXjTdluQ==
Date: Fri, 27 Oct 2023 16:05:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: microchip: ksz9477: Fix spelling
 mistake "Enery" -> "Energy"
Message-ID: <20231027160530.5cc4ef5d@kernel.org>
In-Reply-To: <20231026065408.1087824-1-colin.i.king@gmail.com>
References: <20231026065408.1087824-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 07:54:08 +0100 Colin Ian King wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks.
-- 
pw-bot: accept

