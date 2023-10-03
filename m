Return-Path: <netdev+bounces-37699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E367B6AD5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6A8E62815FC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B742941C;
	Tue,  3 Oct 2023 13:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0169F2770F
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82818C433C8;
	Tue,  3 Oct 2023 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696340810;
	bh=Dwbea6D8KUSYEnmFFyh+l6bz5hKq3AOojgORJeK5KGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lk9lvtXbRNP2OnYh3CE/VtihNkES2ujGUVR+ueC2QmePzqOR+dHIyvkpYGlVbCL/w
	 edhUVtjmqfBy09rYzmrdXKhS0LleEB6fOm7QVWgwK3hWLPjJhLzt9fkQfUBRUp5RuR
	 y3zfW9odG/YqTVjGp67h0v8jYxMd2HpWBwvjlUeh6PD3vhaf7hOzPOczVBoh95IFmc
	 AXgZOsGLbioHbtU4jMCmU8v1oB2f0JRnKGdLsSp6wER4ESl5U9Y+T6ZzGv0zfYcATG
	 bT3AqyjjsozR+M0vqhtnVniZ5Wq/1NmaMOrzTL1TqgvppXthNiGG2HkD6hX6Q4C+Vu
	 FxB6NMhaAa63w==
Date: Tue, 3 Oct 2023 06:46:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, Michael Riesch
 <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] net: phy: dp83867: Add support for hardware blinking
 LEDs
Message-ID: <20231003064645.470ed55c@kernel.org>
In-Reply-To: <20230907084731.2181381-1-s.hauer@pengutronix.de>
References: <20230907084731.2181381-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Sep 2023 10:47:31 +0200 Sascha Hauer wrote:
> This implements the led_hw_* hooks to support hardware blinking LEDs on
> the DP83867 phy. The driver supports all LED modes that have a
> corresponding TRIGGER_NETDEV_* define. Error and collision do not have
> a TRIGGER_NETDEV_* define, so these modes are currently not supported.

FWIW I think this patch got marked as Deferred in patchwork because it
was posted mid-merge window. Could you repost?

