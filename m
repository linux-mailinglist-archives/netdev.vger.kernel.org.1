Return-Path: <netdev+bounces-250401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB7D2A3F7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96628301B4B1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF5337B9D;
	Fri, 16 Jan 2026 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN+3WpFI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335A30DED4;
	Fri, 16 Jan 2026 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531269; cv=none; b=Gmir7TzegwWbAXYrpGREejihsSk9byw7KGzCN4r/UvJjtXrs5Au+L5UFXAdw+pVEKFerp87tIFMemycpJZ00vncaZ2GlSlgU1ZW/5P0tiQDNJxcEmgaQYgAu8fZxmZhbbm0PjKo1uX4+8YQGkd/EHSe1FhT/uw+VmaPxB1Cfqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531269; c=relaxed/simple;
	bh=RULr7YUHgWNRR14lLmWrwcq5L94Tp9HOfL2OuKu39fY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKd3XPP1+V/mr9fmtmkvoje5XVxdapKTpRRT9Bberh4xjikWSjevrCA7G2g7vcQP2cVN7w3XvvIv+ZytedMsbCr7koPxQ1/mXYAe6g43g8eHzlYQ1FbrW601pHe8OErS/p6+5zl2GiIb3UMGFhwMMVU8lF0Lvx6wJU5jOZXMHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN+3WpFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0594DC116D0;
	Fri, 16 Jan 2026 02:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768531268;
	bh=RULr7YUHgWNRR14lLmWrwcq5L94Tp9HOfL2OuKu39fY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vN+3WpFIe70fUQ175HpXQb3E0qdJw/5mykMzULKlnkjUo1Z31sH2Af0le883snSVW
	 wbN+cFwfZoTzKU0qgnY02GTMQsPFe1NyqYcZSSsD4v4Gd3kuPIQMY/aFHTInHZHoVi
	 UeUNgJnjQQZsbII9XkJett14CgtRa1hqtAloT3+U2M8UCdV5du0Z+Wv71oc/R9C6RZ
	 6Z++bkV0npMMiHpVLdNF3BedLX/s4k/+a+pIhouajd0Hu/81FxjkkSbPjr4TS/MF4h
	 tUUVEtitaQaXD8za3+MigdX8k7IDeKGQnL8MXGJri88sxjPntt+xciVOaKhoREfeFo
	 ZuHDdzuP2W+lQ==
Date: Thu, 15 Jan 2026 18:41:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Slark Xiao" <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v6 0/8] net: wwan: add NMEA port type support
Message-ID: <20260115184107.01975f7c@kernel.org>
In-Reply-To: <41675d06.99df.19bc178277f.Coremail.slark_xiao@163.com>
References: <20260115095417.36975-1-slark_xiao@163.com>
	<41675d06.99df.19bc178277f.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 19:43:55 +0800 (CST) Slark Xiao wrote:
> >Sergey Ryazanov (7):
> >  net: wwan: core: remove unused port_id field
> >  net: wwan: core: explicit WWAN device reference counting  
> Ignore this serial since a typo which lead to build error.
> See next v8 version later.

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
We request that you wait with reposts _especially_ when they are caused
by your own negligence.
-- 
pv-bot: 24h

