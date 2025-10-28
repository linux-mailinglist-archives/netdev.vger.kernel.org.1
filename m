Return-Path: <netdev+bounces-233522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC4C14D00
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816D63ABC01
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553C2DA746;
	Tue, 28 Oct 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ucPQCc0C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB933E7;
	Tue, 28 Oct 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657912; cv=none; b=SW6noalhAzn3g8I6DtLhR1LqRp45QRJ9MbLT8StS/7N7g9ifLmmkQDoxA3v9JpszseDtqrXOD55wgaRq8mmMJjf6ktxGKtyGOwZsQUgSR8hbDROFR2XrWwwEynfJZfvumCR710u3DVdbJUxWeO2qeWrBHeKaO16aKEbKrvRN2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657912; c=relaxed/simple;
	bh=+73ES3vFky/WtRPYBzIKEqLPdiDRYFGkszb9lqjt6Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H94d8XHLYNZlqZRWt9Fk89VhL5s3JWFCedXKThbH9V+ilQY6vCYrwfzXJawW/qx+fEdJ9KShEU48z2TVTPc334LWWp/iePWf0oeIMd2AJ4rAfuqjOdULvnEHWPYmrIUSiFc8DPugnaio0l8n+xGtDW8OBP4mQQKt2JmuY1qce64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ucPQCc0C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LcpMDj9tWoxdju0hl6lEoaXx3jgSRxXpNSpSh7vQ4CM=; b=ucPQCc0CUvKJvPqiLRZcdJ8be9
	rzZDWziELaVIRjEiEoDeM1AsK30jqmeI1nlTVCEdrrcDVtax8U4bgM3r/CnYYFWEYHmR4e/9Zg4Mk
	e6IMXrNZbe3HSmJ/KpChTYGn5zAa6lWz5YaLB5P0pG1qpjJJSQeXq5c/+qvx8O6Wpbxk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDjh2-00CIUx-T4; Tue, 28 Oct 2025 14:24:56 +0100
Date: Tue, 28 Oct 2025 14:24:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: sammy@sammy.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: i825xx: replace printk() with pr_*() macros for
 cleaner logging
Message-ID: <fcb18197-af45-4f7d-a435-39796c51c1e7@lunn.ch>
References: <20251028100127.14839-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028100127.14839-1-dharanitharan725@gmail.com>

On Tue, Oct 28, 2025 at 10:01:27AM +0000, Dharanitharan R wrote:
> This patch replaces printk() calls in sun3_82586.c with appropriate pr_*()
> macros (pr_err, pr_info, etc.) according to Linux kernel logging conventions.

You have a Sun3? I've not seen one in maybe 25 years.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

says:

1.6.6. Clean-up patches

Netdev discourages patches which perform simple clean-ups, which are
not in the context of other work. For example:

Addressing checkpatch.pl, and other trivial coding style warnings

Addressing Local variable ordering issues

Conversions to device-managed APIs (devm_ helpers)

This is because it is felt that the churn that such changes produce
comes at a greater cost than the value of such clean-ups.

Please state in the commit message if you have run these patches on
hardware, and plan to do other work on the Sun3 driver, new features
etc.

    Andrew

---
pw-bot: cr

