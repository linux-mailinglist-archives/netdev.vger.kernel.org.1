Return-Path: <netdev+bounces-199908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD96AE2199
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9D7A3ED0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416F2E9ECB;
	Fri, 20 Jun 2025 17:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2B2E11AD
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441991; cv=none; b=CHxuJOQsMHVGT+BjoLI+SIo+ajaXS9S63USRyU5MJ2juFa9uOqUS1IY1KPbsGt5MXyvVRdX9NqsSp6AU1PBbySyXEnhFyByRtyKbKHWQbXS173Ka0tYbHXn1AZB0d3+t1jmURx66s6fN5vKskrVyxz725vsOeP+4lBdvVT2urvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441991; c=relaxed/simple;
	bh=ppnP+YOgJTWDNoeqySzrfcoTdg7eRvjLG6TUmnHr8AY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ouvS8OeWCiIX8hAm9saeA7+I9wfQE2C9olkpnT04qIooWYSQ9jFJwyXVhHlUdpkW+Nb8hJKfIEpD+oTrP/zeCdF415qcfmcUpA+2um07dI22DhEEaqeq/uNDuIPrakCGBM5mXKJyjehdBCXtWUAv3SR1HcxqPHCFU1ji/RWe2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net; spf=none smtp.mailfrom=davemloft.net; arc=none smtp.client-ip=23.128.96.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davemloft.net
Received: from localhost (brnt-05-b2-v4wan-161083-cust293.vm7.cable.virginm.net [86.11.207.38])
	by mail.monkeyblade.net (Postfix) with ESMTPSA id CCD0D841F1AF;
	Fri, 20 Jun 2025 10:53:07 -0700 (PDT)
Date: Fri, 20 Jun 2025 18:53:06 +0100 (BST)
Message-Id: <20250620.185306.226334434825096879.davem@davemloft.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, leitao@debian.org, joe@dama.to
Subject: Re: [PATCH net-next] netdevsim: fix UaF when counting Tx stats
From: David Miller <davem@davemloft.net>
In-Reply-To: <20250620174007.2188470-1-kuba@kernel.org>
References: <20250620174007.2188470-1-kuba@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 20 Jun 2025 10:53:09 -0700 (PDT)

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 20 Jun 2025 10:40:07 -0700

> skb may be freed as soon as we put it on the rx queue.
> Use the len variable like the code did prior to the conversion.
> 
> Fixes: f9e2511d80c2 ("netdevsim: migrate to dstats stats collection")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>

