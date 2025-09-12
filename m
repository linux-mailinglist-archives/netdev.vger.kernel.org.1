Return-Path: <netdev+bounces-222371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAEEB54005
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93735A59EA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A35188580;
	Fri, 12 Sep 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWsNbdkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAC15747D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642108; cv=none; b=goq1AC53EeZUhGy2cOHcs0cpvs4pL5I2ExCV90qAL8f5QM0/31DxOZ/ksHL/ubXZo6YjbmxNd11KSbL/WdoVLPwWxL2FjOGGacZBAmoBLrRa4pCLmDBhTPVQbKVhlxaXJ5kVVkhXiRbSJSQU7o5Mwf4Kv9tyT7++YZkyATnOulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642108; c=relaxed/simple;
	bh=5a1jEIztMLYNtjBJ73gZ8z7N7ZBItwfbbwqIexbercM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTkLj+xtBciDjIJMpcCAmvHEwZ+1tGV+OELHGD9YK7jogQMK6qlxQlEoF6UelVKDyr+GfAbUVgWQ778SMiugZrICNPrQ5dvQ8fiqpbDAe9USijfmzuCVW6PVO5uMoAwpxQwyM/v+ZBTZayW5mmztnykv3ty49MU4OOKUuWb/p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWsNbdkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77F7C4CEF0;
	Fri, 12 Sep 2025 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642108;
	bh=5a1jEIztMLYNtjBJ73gZ8z7N7ZBItwfbbwqIexbercM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IWsNbdkJ+w9kAJ1vDn3eAkXyOWDesKAnjJPTGFV44rbzEEP4nt/hcHvNe1g/LiyK+
	 V6cvnEMzuzJGANnK7QvGtZ9m5kfTcVDjqiqYWbAsZqecAbOkQVX6WbANYmUKrr2F/t
	 GhkEjt2O5hcAOUulA4OGo86PcE6DhJNEGTEEvc8m70kzMD7CtIFJrISYCvEkKgqaEb
	 v5bsPHhx1JosKOn4T5Tebd9YkGzuDH/htQFimilNwr6WbfUNkU5YEEVZmpJenmjo+l
	 E3N/OAXey7ehx5/gwgttbEgym/Ch0CQfUdafayhiGMolaOeB8zqwVO3Xqmuq3kA5cd
	 dVqgUVPkWYuZQ==
Date: Thu, 11 Sep 2025 18:55:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: mvneta: add support for hardware
 timestamps
Message-ID: <20250911185506.6ee85d94@kernel.org>
In-Reply-To: <E1uwKHe-00000004glk-3nkJ@rmk-PC.armlinux.org.uk>
References: <E1uwKHe-00000004glk-3nkJ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 13:50:46 +0100 Russell King wrote:
> Subject: [PATCH net-next v2] net: mvneta: add support for hardware timestamps
> Date: Wed, 10 Sep 2025 13:50:46 +0100
> Sender: Russell King <rmk@armlinux.org.uk>
> 
> Add support for hardware timestamps in (e.g.) the PHY by calling

These are _software_ timestamps.. (in the subject as well)

Fixed when applying.

