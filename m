Return-Path: <netdev+bounces-116927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E591094C19E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F433B25983
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8172918FC6E;
	Thu,  8 Aug 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egEjUjGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9618EFC4;
	Thu,  8 Aug 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131645; cv=none; b=l94r5ZA12Bclc9HlhdHn0YgZBFrHsVE/QLocN0kqqGUisyoqjYi5xWH6J08ldSmVwjJQrf+d+k2xTAGqHtoxlRYZeDyrwRHKpQAiWblrOR07EzljxNZQ1xKXq5rxhAtb/fW9KGKNgyAH3JxGJLB12NmIMLj+4fEOFnYZS4SDr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131645; c=relaxed/simple;
	bh=XzRroisM2MzQRUaEBJjjKzBrHlzZ5AirjqQMKQISeBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzrgRELXKvlKiS5O3WsvXnPQhJ79gYGxpTPCRTb4Ly0SaxA6eXsZ1/eQErpMboL/NqeQnUjm3620xX7OXSVh+juDXXGx50YkCyNMGacRE72ZKHjlY92OUD5pdu9tuS6gTQAvs5IKLQJHHdIlP4Wq2WJemqe18g2xyWNGnTuxeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egEjUjGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625A7C32782;
	Thu,  8 Aug 2024 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131644;
	bh=XzRroisM2MzQRUaEBJjjKzBrHlzZ5AirjqQMKQISeBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egEjUjGf+8bqXvq5dN8q8vfZnFO5wWcHxW4sfyQEU+5XkpvxyY6qGWSb6R3jXk+Su
	 0yJRJiWd3B8VIedhJ5Li9Y4qJep1fHZqHRw+IJf6zcIdFfL0K1BY4l4i5OY+jGM9tJ
	 WwcN7Y0hz6uGkhbk0dAzEPug3Vcecjjh/48moXAfhUsR4UgeKaBl0FsMs6WIeH/7R/
	 9/VzmxYZ9hm9QvpNEBffLJsJ8Wo3yJMq9O60StPnw8f+9Cw7FuaAu/EAQtxoieXsst
	 zN5K0kKG/ExVaXczkCrj2dFmGBU0eTrxi656Q/IG6F4S0dFGsCakXfkwCD6dN7BR1u
	 4/2ERFNNYuscw==
Date: Thu, 8 Aug 2024 08:40:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, timur@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: emac: use devm for alloc_etherdev
Message-ID: <20240808084043.0f1fce75@kernel.org>
In-Reply-To: <20240808035800.5059-1-rosenp@gmail.com>
References: <20240808035800.5059-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 20:57:51 -0700 Rosen Penev wrote:
> Removes the need to free. It's safe as it is created first and destroyed
> last.
> 
> Added return with dev_err_probe. Saves 1 line.

Again, do you have the HW to test this?
Please don't go around "improving" old drivers which aren't broken.
-- 
pw-bot: cr

