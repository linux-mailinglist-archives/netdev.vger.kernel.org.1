Return-Path: <netdev+bounces-141303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CF9BA69C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3757E1F218E6
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA4176233;
	Sun,  3 Nov 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMHVIV1g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91C15854D;
	Sun,  3 Nov 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650662; cv=none; b=TgY9jUE3A7rUXGb37snOIrPwICJ3Lzmp8Sbnrdfa9lnDXwkInq+JM0nkS7kUYmG0OegYubtBVjaU0DyPleHKxMFOhXNT62Pu4WCsi+dLLCP0oFgy5X9+56JgLN+k+07ljE7b/Sj44baj1NQ0kjFwk1m9gMyKNExoyZ2ElpLJ/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650662; c=relaxed/simple;
	bh=XIzMIxVyr9UwO9xjkg6VivDTjFH5NwPJ2f17VWoBbkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWgxGEtPdLe0tUPHb26Isu+cwL/tAuJTOaD+eyeZnz7nE8uPf3AvwzEbH6iSM02amN04ihUUhQvMNy/HnSmWzJWXF04guEEz5IAFlR/ggKa5XkX5lqHZs2g2NgJ47vfCR9qBlmyzRicgbALL19NAcXusqvAxWOBd4XbpvPAN9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMHVIV1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10845C4CECD;
	Sun,  3 Nov 2024 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730650661;
	bh=XIzMIxVyr9UwO9xjkg6VivDTjFH5NwPJ2f17VWoBbkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMHVIV1gbvsnmPCglnLG+MV8oI82ft7xTmHkrT7GnBmfkoFqIqRy5H694IADhNPq1
	 MBzS7ECVSd92vK+7eBp/dXzBF5nrKdl5NTaUwha8cIqE6Jo3oXICQZPQADkoD/6JH3
	 SLJePNqiGCOeU/zsNJ7ptf5RbO7v6zwF0hL4lK0U92T41slMXnLz2uHPkQZJOuoWKV
	 pycg2SnwZNFWDWsWOcnziSYYul6v5j/1wY4BXTdwTrdPIHhw1Z1WlRkVyi0Vpgjwoc
	 PDBdqEtUcOTimq9gDS+ALv2sWgTYfII9FOqDZUNGEoaKrlPpXNLDzTZ5YBpuaC0zdR
	 +5bY5ZyKXTqKQ==
Date: Sun, 3 Nov 2024 08:17:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers
Message-ID: <20241103081740.7bc006c1@kernel.org>
In-Reply-To: <20241101083910.3362945-1-andriy.shevchenko@linux.intel.com>
References: <20241101083910.3362945-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 10:39:10 +0200 Andy Shevchenko wrote:
> Subject: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers

What is a "proxy" header? Guessing by the two patches you posted - 
are you trying to get rid of of_gpio.h?

> Update header inclusions to follow IWYU (Include What You Use)
> principle.

I'm definitely on board with cleaning this up, but would prefer
to make sure we can validate new patches against introducing
regressions. Otherwise the stream of patches will be never ending.
What tooling do you use? Is it easy to integrate into a CI system?

