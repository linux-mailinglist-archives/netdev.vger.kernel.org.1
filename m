Return-Path: <netdev+bounces-162287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1EFA2661B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28EC164C6C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADF520F06B;
	Mon,  3 Feb 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xKdkt2Ri"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2378F54;
	Mon,  3 Feb 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619518; cv=none; b=ITR1fYPhtsc63MpriBQrzE0Ts00s9eGQGROsL1ttLv49RKWQC8dQ5oVsFZxc5wmOZrt2HemBabtY6iMHv+lxi6GOhWbPAbZwuGTL+kj1lgkOe4pd9kCQXXkmLMb5/Vz1t4dId6/TAjqzqAImGjsNB5Q3pwcXW83FOiwDlSQzHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619518; c=relaxed/simple;
	bh=728BrBv206yX7DgvBTDxxW1BhKgtOFRBXnffHS/zVtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZSfCM8zziwJG3dd7tZ14NOeEIS1VaT2WX+71c/fqNRb3Q1aCYIRR6f4YVT6O+J/BN9XuJuv6Hg/BY/hVfsenbBRAfiBtbrXGZs564oBa1uZTw/2EjTszFc3Yqwpdw+QVFgI23yyX7nWP7MQ/REvLxmhOUjmdEieXl9hwQbJQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xKdkt2Ri; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NKIGVS9TsZAEjbJBcEBnZELE8gnbQlRrAdJ9mthvRmc=; b=xK
	dkt2RiersZjg+SHtkRW4B1kKho3yC4vfB7CKHht9Z1WskfPB78q0/cR9VwG6KOpMqSz1u2iHI76m4
	oN+vIpCzKvF3ReYV4Mv6mxpsBNuZlv3vKo4voVGVJd4Fwh4QBUCtfF4A5hHoZA3atGQSRzJnlwvs8
	NfU//cmkVdSkO0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tf4M9-00Aemq-N7; Mon, 03 Feb 2025 22:51:49 +0100
Date: Mon, 3 Feb 2025 22:51:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] ptp: Add mock device
Message-ID: <1be7f0e7-b8d5-482d-9474-dfd252f94fed@lunn.ch>
References: <20250203-ptp-mock-dev-v1-1-f84c56fd9e45@weissschuh.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203-ptp-mock-dev-v1-1-f84c56fd9e45@weissschuh.net>

On Mon, Feb 03, 2025 at 08:50:46PM +0100, Thomas Weißschuh wrote:
> While working on the PTP core or userspace components,
> a real PTP device is not always available.
> Introduce a tiny module which creates a mock PTP device.

Since netdevsim already has this functionality, lets drop this patch.

    Andrew

---
pw-bot: rejected


