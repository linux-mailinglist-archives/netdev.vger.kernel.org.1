Return-Path: <netdev+bounces-28529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562777FC21
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77971C2149E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ABB1428E;
	Thu, 17 Aug 2023 16:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617E1B7C9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51024C433C8;
	Thu, 17 Aug 2023 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692289848;
	bh=ltwTI0YOVOhXNo5fZPWlYF6RrBeTO7y8wp8NcJ4OnaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/C7YCO3f4zJ0aXbqvxTuiIVXZYExo8q5pPI9k0xjhG1xGfFbbBfxntldYArAF5C0
	 q2Jyl6ueTOatoKIRIxmvGLC/XKOJtfwzKlY6We2HqljYDkC0ME17uI1OZjY9Uxsq+F
	 0PE7QZ5qoV4pjtyZ3WsrTarxehWJGbqNIJ64+2tE1ULZ1U22Y6Za0DawIToSZUaO24
	 hQG3val954kG7I9RCsGAwe9Vfjkm+lWU7NDtADNwLR9GmD0zqLGapLOtg2svvxMQQ8
	 5bZk+tdPEj3GUPOOlcn31vu/45mbKKhxSSO/37dMW1z8VXEt2b7cUbi0dLnJg2eaKf
	 xL/TwwCSYpajQ==
Date: Thu, 17 Aug 2023 09:30:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
Message-ID: <20230817093047.28a2b11d@kernel.org>
In-Reply-To: <20230814141739.25552-1-josua@solid-run.com>
References: <20230814141739.25552-1-josua@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2023 16:17:39 +0200 Josua Mayer wrote:
> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> for active optical cables supporting 25G and 100G speeds.
> 
> Since the specification makes no statement about transmitter range, and
> as the specific sfp module that had been tested features only 2m fiber -
> short-range (SR) modes are selected.

FWIW this got marked as "changes requested" in patchwork by DaveM.
Since we didn't get an Ack from Russell, would you mind fixing
the comment style and reposting?

