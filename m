Return-Path: <netdev+bounces-137942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F79AB394
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0077E281127
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765281B5823;
	Tue, 22 Oct 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iO3ycnOm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832141AA789;
	Tue, 22 Oct 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613576; cv=none; b=eodIKDnXlqnrwMWrhVvsNB31vcmbJPTtX+qanIojAYB2ueMuKicCRaOtFSU67xGxWCFh7dtUrQJKnMmqmX2p0r11+McwGbaNcdS82ivqjPl4nYLYQ7DinLiyPRLcKbkSuEizNspGR3bizuvuilF0l7JppehfJ6/t+3658N3c9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613576; c=relaxed/simple;
	bh=xSCXHGE6ZuWFJ+tdHGyQI+SGlPzEYUF4wSygdvX+78c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGDUel/dwej+QM51SWLWanCLoVzRjYYfEgkN6fjNW2U2bUotqt0txoLgrD1Pz+Q+rXDpaxIGfg/EM4nfi+yfPq+JNJVDRlkdKhSTNlenvKkVPyTgEH8bcVkyoTCab4QDmetVJUacPCGIl7usQrQ73FgjK34UuZkyBCRjeupgOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iO3ycnOm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=moTtkXueELjbJqzfurk/0XCb2iFlwGGMFHhjR6Q6KiM=; b=iO3ycnOmNECHSU/y/LmEQL1unv
	frvTHCRuEVEQ61OyDkk5RRXUw0QhlFyWJhrpBaNPNwUKqI5UlnzPNovnqN9r+UJNdS7ebxzzbmFA8
	Som9TWOhc714/8qbs27fJ1AK3lYu+Nprfc9pnhfSarXp29BCOVDqLRpftuXqnrFdEOdI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3HUv-00ArPE-La; Tue, 22 Oct 2024 18:12:41 +0200
Date: Tue, 22 Oct 2024 18:12:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] tests: hsr: Increase timeout to 10 minutes
Message-ID: <37f34544-b9dc-4d32-ae2f-8228cf50ffa3@lunn.ch>
References: <20241022080223.718547-1-jiangyunshui@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022080223.718547-1-jiangyunshui@kylinos.cn>

On Tue, Oct 22, 2024 at 04:02:23PM +0800, Yunshui Jiang wrote:
> The time-consuming HSR test, hsr_ping.sh, actually needs 7 min to run.
> Around 375s to be exact

That is quite a long time, if it is being used in a CI/CD environment.

If it possible to make the test faster? What takes all the time?

	Andrew

