Return-Path: <netdev+bounces-111248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACC930609
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 16:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7241C20AA2
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1413A402;
	Sat, 13 Jul 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A7m0OQU/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6383D551;
	Sat, 13 Jul 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720882561; cv=none; b=XnErfBdaCFU0jeY4/Vo/Zgj8HptxQ2SZQNNS0fA9oUM3E3YBSCdrh9JasNTaQyIO/UIIws6q/KL0uLHxll/+o6KJOTTDBP0YI9m8G50H8gcvn7KXKRpj4+DC8ymXzARgL1sL0lYej6AozhgwPC5PAukVfPcVXWMC9uTU01u1mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720882561; c=relaxed/simple;
	bh=TQsmBSthl86XTJ12+J/7nTjRz1Qq5ZSq36EhBxjRnZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBMvaT8iTN+mczP31nL4rRl/bucZlom82m6y8IZ6RSnOtxhaO1zHM7tG/5Kpo2CBwNsAMMj9FgrgCGkM0dcXQwYv1f074yaqiX52AXy5mYHI1XnhStamHmrPIUzTQPO483etIoPrdp4S+7lMyBMDTZ00braSAWHioxbqDKUqxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A7m0OQU/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QaAZ++ZM9NBcRNd1ZpY6LcHA9/xsr6Y6FWKUsz+R0Xk=; b=A7m0OQU/bE4bnF5J7TQkOumj+7
	cw3KMFvEPXWo0N/53ZroXPN6e4BgxSbez6bOLfGNqXpZHveWfyqlJRD5iH/gpkSX09fXcweA7U3+i
	GB9FTvuF7g6TFx0XMWIhS4bSav7xTiZlML0M3cozM8NNy1I8qWk+tXyuK3cdRkju98UQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSeAB-002Skk-F3; Sat, 13 Jul 2024 16:55:51 +0200
Date: Sat, 13 Jul 2024 16:55:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [LINUX PATCH] net: axienet: Fix axiethernet register description
Message-ID: <0291b98d-d91b-4c6a-ba01-396513137dff@lunn.ch>
References: <20240713131807.418723-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713131807.418723-1-suraj.gupta2@amd.com>

 > Since the changes are related to documentation, not added Fixes tag.

Please take a look at:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

