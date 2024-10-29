Return-Path: <netdev+bounces-139926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356259B4A37
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6682A1C2212C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD4205126;
	Tue, 29 Oct 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h0/PLnnf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA3188010;
	Tue, 29 Oct 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206418; cv=none; b=Rb9Bx4YbC2hbevLpm7M+DOkWwYMGmuLKx6NrpLZBAKvqDYIWeJFoAwy2FSESsXk1R1VDUhZW7B/tlWK9MplDXBrCr65ga553BfDjaoXNEP1Y6uPP+vKujyjbI5Bkm7j5Jse4/UoxVGdKMdieZ+vKlr/nWfB7a63n1xdcWmoke1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206418; c=relaxed/simple;
	bh=Lb5u5GLF0cw8Rn6e+JknNi3ga1iEQ6ao6vKwWe2UUFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Dsn//E1LwOzWvIa1AYa+BWr3BqOoAUzJnaL0rB8Xyy83jV+jcups3pG43UJSMPPcxcBpROmZQxAvYdC1QAKjMKJU2lPk9B1BJ+0fI1aK6HFcnb3qGzU7/OpcUx4+f82XEaCLz1E06nno4oDrd26N0pD6NdI2pBTjzhqOqvq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h0/PLnnf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vs9AShkC7UCHtkM1AY7IODbX66QH+H0VrkAiInPtTHM=; b=h0/PLnnfXATnTJIyUzlHK+w/8B
	yRa3IsajUnP53qdTzdHyeMx4YkIKXtw0pRsVDkW5gqTLpIV+jyz3x00Xd/0HpCTdmStOwZ7tcTQ02
	rVfmoLy1BEzQ4vqR3MGkrv3vl2zXC0m+59x9osjqzc8dwcUQMqU5gaJ9W6kxd7X+WFxo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5liz-00BZmR-Hq; Tue, 29 Oct 2024 13:53:29 +0100
Date: Tue, 29 Oct 2024 13:53:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: add get_ethtool_stats in ethtool
Message-ID: <c0cafab5-7a8a-49a4-8d46-a79b47eee867@lunn.ch>
References: <20241026192651.22169-3-yyyynoom@gmail.com>
 <2502f12c-54ad-4c47-b9ef-6e5985903c1e@lunn.ch>
 <CAAjsZQwDG8m33yvXRf+ERpziGDxULwyiTTBU4Ph7Rq0MbfqoEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjsZQwDG8m33yvXRf+ERpziGDxULwyiTTBU4Ph7Rq0MbfqoEQ@mail.gmail.com>

> Regarding the RMON statistics, I understand that you are advising me to use the
> structured ethtool_rmon_stats for RMON statistics and to reserve unstructured
> ethtool -S (without groups) for non-standard statistics. The documentation[1]
> specifies grouping RMON statistics, but there are other statistics in my patch
> that are not part of the RMON. Would it be appropriate to group these
> additional statistics as well?

Groups are used where we expect drivers to offer the same
statistics. Having the group means we have a well defined interface,
where as in the past they were just dumped in ethtool -S, often with
inconsistent names. So once you have extracted the RMON stats, see
what you have left and see if they fit any of the existing groups. If
not, they are probably just what the hardware vendor thought was
useful, rather than being defined by some standard, so can be part of
the unstructured output of ethtool -S.

	Andrew

