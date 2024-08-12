Return-Path: <netdev+bounces-117846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE794F8AB
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF781C22343
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E310197A6E;
	Mon, 12 Aug 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="REOfW6ms"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C643136349;
	Mon, 12 Aug 2024 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496334; cv=none; b=QBhgg5lNLf3VVTyLwuWyNoNhIqh90tyMAK+ntLQ6Sw9oWymNvbKroB1yOfBiCcuSMk3IOQNZ0O+3s5HjDm2WLGFkH4bX8M5vJQU9jmRi1tcrYrBWHED6ktX0ZxDWpg6wYaBPgRU8t+y/njrrsg4XvLPGO3nfviNQSNx66E8Udow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496334; c=relaxed/simple;
	bh=vz+39rjKUM9q403si214Cohvqxo4sz177rPScX+K2V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAzpgYzbD3THE4kZWBlEUd3U5IEfuZu/u5hquR5aO8EOP7fRwP5nfJijgSDmwGZ59vK6WqG5JiJPbh2MT30dhNzda3ChGRNedxpCv/hMOq1FyjDsinp8xIMdJbqiojL+x3p+U1NxpusFWvpTJdyXSNmOayYmP29ZF4dmO7mAdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=REOfW6ms; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GvB+Z09Tk6MAdTET7p9iKM8bkuIPaBr8WJ3nZCC5ECA=; b=RE
	OfW6ms+Vmwjb8LbL1OuWf2o52EBz3tw0Xdll7MnUXdXXSdZlDpnwDvwpREJqOgnrB2ODj7J+fLwcD
	sbMiQhOWFrzADiFib2ihwKyyYHbkj0Qm2UBeq3/QcaGtoo/+K2hfnC18zhJU4FnzrgFR8kIK7BYyn
	l/jT5uTXL7d/lMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdc7u-004cPT-Ar; Mon, 12 Aug 2024 22:58:50 +0200
Date: Mon, 12 Aug 2024 22:58:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] net: fec: Remove duplicated code
Message-ID: <6e0f958f-b48e-4933-914e-cdf66f353ee9@lunn.ch>
References: <20240812094713.2883476-1-csokas.bence@prolan.hu>
 <20240812094713.2883476-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812094713.2883476-2-csokas.bence@prolan.hu>

On Mon, Aug 12, 2024 at 11:47:15AM +0200, Csókás, Bence wrote:
> `fec_ptp_pps_perout()` reimplements logic already
> in `fec_ptp_read()`. Replace with function call.
> 
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

