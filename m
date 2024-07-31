Return-Path: <netdev+bounces-114541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599D3942DB5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FF81C2171E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05C1AD9CA;
	Wed, 31 Jul 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TLoIfv0d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679518DF93;
	Wed, 31 Jul 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427555; cv=none; b=LpoHVazcEJF3kKtOFZPRI/ghU1WNs98gca3Wk9i7Iz65KNg0l893P9+Xbpb2diJpOGN8Vqt2gGJ4y2VY6c7bmxvEsawprDPG8fMXSl2FEzFVYlxohlGViaadDLTq7AZ9cXw/KeOBu3P8Le8OaVnCkouCwB6grdfkW1o0Th55fR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427555; c=relaxed/simple;
	bh=016eNJKS6cVs7YfgG2xWkYfhtcwVUoDKIihnbe1ddv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgbCvQ6sBN7plQ33L1b2nHqJSOBkoz28TpX6QlrSFd/dY2issXT+a7KkZPVvTVNSoZmFwo0LweOyTQX0vt7oBEkjqbrYAZH+oyUGFmY3ZSBJEIoyKsOvkmgm2CIsGPvNGz6YETSHqPCxYF3z79+Vor3QRzGVTUQYBMLIf9JQHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TLoIfv0d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hH3IGZdp3E55VPOf6SKMrVfSLJZyPDh774CBFbCB63o=; b=TLoIfv0drgmqzlSeFO1hDio7Cu
	t7ra7jLWeYBxkRczQjDds6YWHK04wwy9J7d0PGqbMSIVuPqoScMmsOmsOofgeH/yRxwCQMCMdXo1Z
	DwQ0kgZpbwWqM25LjxqAImaV5IXAgQn7mk/vTc8uYBw+fcQvxSVWtyIH1ih2xoacayik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZ85E-003fZm-H0; Wed, 31 Jul 2024 14:05:32 +0200
Date: Wed, 31 Jul 2024 14:05:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com,
	Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH net-next v2 1/4] net: axienet: Replace the occurrences of
 (1<<x) by BIT(x)
Message-ID: <f0a9a77b-8575-4913-a083-5fe630fb5d76@lunn.ch>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1722417367-4113948-2-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722417367-4113948-2-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Jul 31, 2024 at 02:46:04PM +0530, Radhey Shyam Pandey wrote:
> From: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
> 
> Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
> "CHECK" output "Prefer using the BIT macro".
> 
> Signed-off-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

