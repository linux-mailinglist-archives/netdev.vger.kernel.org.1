Return-Path: <netdev+bounces-95447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C868C24BD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4FA1F25D4B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477D32F873;
	Fri, 10 May 2024 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPfKtJFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67216F0EE;
	Fri, 10 May 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343820; cv=none; b=roOpn5PeuSx1sXWTE2yiK1WHOunBtZtgtH1OksJqze1rtBk6Xcn5Cb/FGOgoSk8KAdStfuDX8Z2Q86z0SzgNoCUKhk0O4Va6Hqpy0vtEZcJSFVEzljHc+Lq65I3oRznfOyPzXp0rkRvuGI1bnQe7dJ4IK0gm3SJ6jVsuNXM25ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343820; c=relaxed/simple;
	bh=y7dJaaI5df0DcwFh4y63s/191kBy/jFRwdA9FnaZHV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwhMe50dFqHkVDR7aTeKwOmQtFYyV5gW/qz7IyMtRfTJNeyeOscH+HBP57TBnwPe5BV8BOUbN6o+mZoDzBnPw5irNAYCznKvmZ46itSj44JPGtdGtrjzuI/GOS8tmHQtc3lbRzwinaoG206KDVv9CuSa6MFWtCo5DOG8cvQXKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPfKtJFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CE0C113CC;
	Fri, 10 May 2024 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715343819;
	bh=y7dJaaI5df0DcwFh4y63s/191kBy/jFRwdA9FnaZHV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPfKtJFb9m/QvpyElofqVmM697Q80kESzjsaSZFsWd7H46KgLSzT2++mgcXZcjsyX
	 Aaf2QOnpMtaqgz14H02iuv1GV5r+C7pzhWIsr+PckbSepLC6bWt/o7D38okqyO++b+
	 Fyf39WdgM0TaaPaOm04GAPQHp1tMlElCzZzV7d4m20xIZGXiHd43cqaNPst2riBd0d
	 t76iiRXcqc5j4wl9mNpjj0/kCjtaTDFuZqKd/JR5Y4LeCLdn1yd07va2OaCvpKghPV
	 kJSbTOgIPBn0y+bHFUCBs0MwTuQbIfX/Ex+/WHroIc01tiVDJlnyz8j07VZ5Adx8kR
	 Yd16eghe+JpTw==
Date: Fri, 10 May 2024 13:23:33 +0100
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: microchip: Fix spellig mistake
 "configur" -> "configure"
Message-ID: <20240510122333.GU2347895@kernel.org>
References: <20240509065023.3033397-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509065023.3033397-1-colin.i.king@gmail.com>

On Thu, May 09, 2024 at 07:50:23AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


