Return-Path: <netdev+bounces-116583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A980494B0E6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673D1281AFB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79441448C7;
	Wed,  7 Aug 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZaIOTu4/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F11459FD
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061210; cv=none; b=aVEDZCwYb4HgdsmorhHZlSu+0rkycKyBl9mlDqlzeduDlAu6hAs4h4IIhHBAjEQBgdGscUTmPJFtcQbqmBm/t0X517kuQW5NuAVuLSamPuZ6vou7tpRx4rYTN5E6lo7MY5UKqw5S95AlP6vdtQj3qwhSaCfIFEY4FKyz7licCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061210; c=relaxed/simple;
	bh=7N6XJgPolSVC/76xKfPgX64O/j08x0ke64Sfj9CEj5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLXlmSx0/Zw00QOmY6KJKgeEEriPRvW2U/nHpFUToVoLbsrpUA99YhlEpsavlbgZnq+kt97SuZq3nG99Dz+6WBHgo4OZyNh5YYBe2fWlo1WM0fVqMdHJZRwCu44FBbYsRasBTH8rpTT93ac2MCYdLj7uRQxJqrXfpux9KUkk49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZaIOTu4/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kS/UqiaWUPushdxEaxDhx2TFNch2UAtkne1JffpAIWs=; b=ZaIOTu4/R+UYSW7bD4Ut5QeZVx
	dF3Ukjnh0n+PCmXDX9NMm8icfihpYuE0v3UyZcpNA0eK5ZEz+DimGYD9rIhuiMumwFplvFN5I/GZt
	UDB1FI5rJLHIONZ3t9H6/VP1LsKiLtKZOJiArdN17D1XdyT5Q9y8fKeo9DUVIgfrZNjg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbmvl-004EMy-U1; Wed, 07 Aug 2024 22:06:45 +0200
Date: Wed, 7 Aug 2024 22:06:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: ag71xx: use phylink_mii_ioctl
Message-ID: <7c9291a9-7918-4980-98e4-74d6fda80b56@lunn.ch>
References: <20240807185918.5815-1-rosenp@gmail.com>
 <64e1f8a2-ba01-402f-81e1-e51da76a5db0@lunn.ch>
 <CAKxU2N8t0vNxq_xTxZFkjYgbrUG6GWBTQJAdt7T+XqD9YEb73g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N8t0vNxq_xTxZFkjYgbrUG6GWBTQJAdt7T+XqD9YEb73g@mail.gmail.com>

> Will do. As it would be for net-next, would it make sense to mark this
> patch as v2?

Yes, always use a new version indicator. Humans use this as well as
tools to keep track of the different versions of a patch. Patches do
often move between different trees, as they are reviewed and
discussed, so the version is not scoped to the tree, but is unique
over Linux as a whole.

     Andrew

