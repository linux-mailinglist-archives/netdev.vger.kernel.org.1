Return-Path: <netdev+bounces-226123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CAB9C831
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7081888654
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055B429C323;
	Wed, 24 Sep 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4sR1eIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806527FB3A;
	Wed, 24 Sep 2025 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755917; cv=none; b=Ltp5wFDDjfxTwLsSHvbV6fYa9K+0zQg0CcUZGi63iSchT80EnRby5jDxdTJ5N0Ocnikewg9Gqfve6FM0o6DMcHEq+pi7ZIDSewGp7MEVzBwgk5X3C+t2PRY1PhVjeghmPYGh9OVSGaZTuWUJJI05z7zom029jn0940feO2Gu3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755917; c=relaxed/simple;
	bh=x7ZqVQk51v3d2Lpo9+PSfq8QuKf6vRqf/7i2Bky6SxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o25N3qOv54Vfl2khd5E6TiC7p/PP0HGREmQC1eiziIIntjNqASrZfVIPMZ/FeLrbhu64laDjtudnnd8o8BTPHEzNh3CuWX9lL9r9ZfUYXTgs4DmB2L7P5WWUnLHJYM7ujXl43xYtkI4vNOrP2SOISG9TgCh+0nSxlIe7wsV4Z9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4sR1eIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809C1C4CEE7;
	Wed, 24 Sep 2025 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758755917;
	bh=x7ZqVQk51v3d2Lpo9+PSfq8QuKf6vRqf/7i2Bky6SxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o4sR1eIaf9Yq6PXYWekCnGOAhrZa6t/Yp6Tccb1kShC+YdiQtSNbOit2H4FSQzVI4
	 pGpCwPg7O0qVvIzXwMt8WpKglki7+C8q8p0XThG3rk4XpHmD+DbBynN6+BgZkhb/Ef
	 gq9ofkoGY59enKEg1ylBK0CWGU59sOysvN/0dcBC85EUJE7c8kOZjjcOHNUxa5GtQ7
	 zqS9X6vqHJ3GySlbbqN5pL/abaYvNwtdFC5C9Gz8EDUp4s+x+++v9u8hGRvKlpqHSL
	 0xwNj2kq9rj/Z+BbXj2xxilOZFHKm3MX/QCFSZECbo9ErLbDL7T75zDGkRadsnlTf0
	 ciz8Ger+EGXpA==
Date: Wed, 24 Sep 2025 16:18:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: michal.pecio@gmail.com, edumazet@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, petkan@nucleusys.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924161835.63e9a44f@kernel.org>
In-Reply-To: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 19:13:50 +0530 I Viswanath wrote:
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

Sorry, one more nit - please spell out your first name, not just
the initial (in Author/From and SoB).
-- 
pw-bot: cr

