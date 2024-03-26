Return-Path: <netdev+bounces-82034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F4988C22E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F64B22A26
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF001CA9C;
	Tue, 26 Mar 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h4VK2CBY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487A1879;
	Tue, 26 Mar 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456478; cv=none; b=R3rRz/8dKUZvWG0KfObL4Ay9tU0wdKLzN/PF3s+vmvnISGBKhPekaxDsut0ohyMhtckV7vPfMBSrlPvfj0d2NyaSd13sr+a0a8rSHNyCbTj+SQbZAGUoOJftYdDNQZHguWRrpaYBmZpns2aOjqe3eG6kvy34G0fW+SckBlQndYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456478; c=relaxed/simple;
	bh=imsBLXuiEZoVOgJ4mjiaqPCnq+W2zsTxvp1hFGf3zAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWsizpYJ/2QcZivCJ3DsMPJemO126ijI9+ZArmVFjc8F7bWyxY/XwAb2axWS5QCHsaV6kJFw9EE7DIziNECPyXQJ2bQbKUwsAzzsxqeN6RY3nGSu//HAeDgXOJcKWCKKIHMBN/Ee09bhb4wqoLlk7g71kzd2nJRxPdK0GivYDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h4VK2CBY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Orm4WurnniLQazZMhjb1dqf8mHT6lMPhTqxgx/AlZcw=; b=h4VK2CBY28LZwG0T1J7DeM3iGS
	/WZTJ10iuLgV9SAc+CPtOxIQiOboElZEbKkuHJE44X+81beawAJGc/TM6NVMVOKvZ7G0HmE1DImc7
	FOqviiTCxOTQS6JwX871mKGWxH+oBj7NNvzuaSnC3jcGATy+O7Frr5m9pilUHagbQCjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp60f-00BH5w-7V; Tue, 26 Mar 2024 13:34:33 +0100
Date: Tue, 26 Mar 2024 13:34:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org
Subject: Re: [TEST] VirtioFS instead of 9p
Message-ID: <4c575cc7-22b8-42e0-a973-e06ccb82124b@lunn.ch>
References: <20240325064234.12c436c2@kernel.org>
 <34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
 <20240325184237.0d5a3a7d@kernel.org>
 <60c891b6-03c9-413c-b41a-14949390d106@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c891b6-03c9-413c-b41a-14949390d106@kernel.org>

> > And the Rust that comes with it doesn't seem to be able to build it :(
> Did you try by installing Rust (rustc, cargo) via rustup [1]? It is even
> possible to get the offline installer if it is easier [2]. With rustup,
> you can easily install newer versions of the Rust toolchain.

I guess part of the problem is that $RUST does not have a stable
meaning yet. The rust in the kernel seems to need a different
definition of $RUST to this package. And this machine is all about
testing the kernel, so $RUST is set for how the kernel wants $RUST
defined.

Maybe, eventually, rust will become stable, and you just install a
rust compiler like you install a C compiler, and it just works for
everything. But we are not there yet.

	Andrew

