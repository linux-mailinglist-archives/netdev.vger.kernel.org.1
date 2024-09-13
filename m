Return-Path: <netdev+bounces-127983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A840F977648
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D939E1C237D8
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E81373;
	Fri, 13 Sep 2024 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuKU5+o9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD310441D;
	Fri, 13 Sep 2024 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726189943; cv=none; b=Yx3ikgPZMY8KZfkI+cfoRGeIAVnY2r18R25xAQ9b8hPVVCtTvAJezjbbhvFPvC24hApRWdRw3eISm4p634PaSy3pkCg4vTTwFJth/Ue5SNV0by36lWqrAQymP3qrpLCecCnnsucTdNz7nsLi5TOoxn7DDVAKQ44jjvxPkSmWdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726189943; c=relaxed/simple;
	bh=3ylHhxxQH2V6NMByyNfCtwV6YdQ9OrbceQ9ESPbgmEw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=CvYxKRRLLjrYdlTb1yP5zZNATJNV4T/k7BZZbihyELHoJqM5aKUHX4hdVJCdYJKgeP8QK6UB/VMB0lx99LbXZfhU/al4siCLKGjvCCsrCWWjJrjJi8ih8ExnmsvpsVWxSlyROW0tdL6c8uqoZ9I2uzXmKdd5VfvKg33YhW0gteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuKU5+o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9FFC4CEC3;
	Fri, 13 Sep 2024 01:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726189943;
	bh=3ylHhxxQH2V6NMByyNfCtwV6YdQ9OrbceQ9ESPbgmEw=;
	h=Date:From:To:Subject:From;
	b=VuKU5+o9LaepQXxkS+YNCwoBwHDf52VAmPjgVZLzhc5tugtn7J+gqvCy0z02w0+bC
	 SL1pGPJx9OL1Lxk0dtXmDBDu/F/yVOW7DRXvLP6/McZysyH2qEwPvj+2DoUo2VHtcY
	 a6+EGIUR5c5x0KrXtLTwcF3ZaOSzD6rDXhsbApq0zxH+LKIDxNbedycJLzCiXAmAuM
	 w+ZJGl/KsanZphdmrbnV09AzCDY9mFjz62nC3FV+3bekcjNTQK2YZa5GNbFtQSLaH5
	 QwiJghgpAu20OfM9jZsBJIBNE4wnsC4GA7W8NCyncqmKNIk73LlS1kbAY6ZGk4sYh7
	 BgTfD5iwR4vdQ==
Date: Thu, 12 Sep 2024 18:12:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20240912181222.2dd75818@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We're closing net-next early due to LPC, as previously announced:
https://lore.kernel.org/all/20240820113034.73448a88@kernel.org/

Technically it will get closed tomorrow, but as usual there's a "review"
lag, so any "-next material" posted after this email is unlikely to
make it into the PR for 6.12. But what's on the list now will still
be reviewed.

If Linus cuts -rc8 we'll have an awkward week with two trees in "fixes-
only state" (we'll keep net for 6.11 fixes until v6.11 final is tagged).
Please use "PATCH net-next" for fixes which are only needed in net-next.

As usual RFC postings are welcome during the shutdown and the subsequent
merge window.

