Return-Path: <netdev+bounces-57640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8743813AEB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75760282FA2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE2697A3;
	Thu, 14 Dec 2023 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCwS1Eid"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1769794
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819BBC433C7;
	Thu, 14 Dec 2023 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702582930;
	bh=PX0ecoAXEz9Cl0MWSXtDnwlLpv7C/aIBTFzfnHmjRio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pCwS1EidBkgB2zDM1zZavKwnTHCdbEciauXLQT+KEHt8qw+vdg+5xFSGjXx4gowX4
	 rUtbDoc5NEN/qocvhiDZxd3N16GlksXxflm/hHlDosxiR5RPpuOY6ZZH7gFrqRfalt
	 RAprABB1RBc3jOzBEXXLz5NyrrZ/vuc5Tn68kfCQySwNS+zn16cHi+u6wSP7lbDR5F
	 Bh4P6+cmhsaI0ug7j14E2IsSANzisAdXqsuhJpmFix6i51+rIPnsxTLyCY0ed2lTJf
	 9J/w3oqZPYiGWmHpzKH1TBpxevtepO6y78XTPQxVldUAnCKmJWc/xqvZ4J4t23N7ET
	 6RladxgZXjHbQ==
Date: Thu, 14 Dec 2023 11:42:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2 0/2] net: mdio: mdio-bcm-unimac: optimizations
 and clean up
Message-ID: <20231214114207.54606a5a@kernel.org>
In-Reply-To: <20231213222744.2891184-1-justin.chen@broadcom.com>
References: <20231213222744.2891184-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 14:27:42 -0800 Justin Chen wrote:
> Clean up mdio poll to use read_poll_timeout() and reduce the potential
> poll time.

This is supposed to go to net-next, it's not a fix?
No need to repost.

