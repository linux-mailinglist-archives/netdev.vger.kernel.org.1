Return-Path: <netdev+bounces-139552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383409B2FE8
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E4F1C244B7
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC118E778;
	Mon, 28 Oct 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mgtkup+w"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7831D7982;
	Mon, 28 Oct 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117578; cv=none; b=j9LsSJRshkPMXQtZbfdWTGml2D1x6cqfdZkiz3JjAez+9E5fiQXk2ViegALe93ikExrHkQXmwW63f0+5aD9WGEHeOebhUHPZINmtBF4fb0P0DMvi2CYPoO0YZW7AeDEHV4sSGhZ5Niv3YEdagsFN7VmcULQ8r9gJq7/68Hmdqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117578; c=relaxed/simple;
	bh=1UUETNFUD4kivyXbN+Uk5x79jZSmLY3Fg5MmGDvdzfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeqQg55RrGEeShwOp3oVi4CUS/HfITIj7Q1HppOOrMPWH4oBr4NYBxkqpqeO+NlpQM1JExUAxK1D7UKtvU+XLEuY7UyLFQycSqr0Wo/wdNL6gx4dyHdjnle0tduZxKdRy7o1EuL8s0wZl3l/IwVYWH4cjtY3+7yvHkkeKbeBkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mgtkup+w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7i2YECRB/bozAkFcEXDnmtUZXJNHHUMUdwAHJ9qlN4c=; b=Mgtkup+wyRHeXOvez20yHXrvMS
	y+k59ruuLRxOqmZVnSICbtxLylCATHBa2I4AWjRPQcqqf0VOmGFBoLhQbowcCTHbR0HzfVzmF3Gcy
	T2PgLSXFdIvathqSfXww0j8G0r5HVJv/gt+7aieZEpymke8yXaTrqDGBr80HvgKmVSDAelfXaK7Hr
	HyQdiuTTXFMT+nP8N+AFTT5XsYMKqUS8gFuW6ZmFZR0IKQ40I1Fe9QRLUKTOZTnecLxBst5wO1WUq
	HjHdV6rsW3Ip5fnuZ1I9TRbg8MFjYP+8yE7XsjWWsuycskSsMfp7wdUcBoMDwziedpes+OfHFKfLe
	+iCapKMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OcC-0000000Ahk3-0exj;
	Mon, 28 Oct 2024 12:12:56 +0000
Date: Mon, 28 Oct 2024 05:12:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kees@kernel.org, mpe@ellerman.id.au,
	broonie@kernel.org
Subject: Re: [GIT PULL] Networking for v6.12-rc5
Message-ID: <Zx9_yOLrWzFS_DoC@infradead.org>
References: <20241024140101.24610-1-pabeni@redhat.com>
 <ZxpZcz3jZv2wokh8@sashalap>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxpZcz3jZv2wokh8@sashalap>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 24, 2024 at 10:28:03AM -0400, Sasha Levin wrote:
> Days in linux-next:
> ----------------------------------------
>  0 | █████████████████████████████████████████████████ (14)
>  1 | ███████ (2)
>  2 | █████████████████████ (6)
>  3 | ██████████████████████████████████████████ (12)
>  4 |

Can you replace the full block filling "characters" with a say "+"
characters as in diff statistics to make this hurt the eyes a little
less?


