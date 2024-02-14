Return-Path: <netdev+bounces-71806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5338551D9
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83C21F28A7F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F412C7FA;
	Wed, 14 Feb 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C3/w3P9h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055E129A81
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934329; cv=none; b=kz1M4biNVISix2XFyybkQbTZXuu8nWcpWU/1qlpYiytDrsdFk309+RjXhrtRWPedV0JgPRZfhyIagpjJLD9cZdRxGeX9/2gw+M+m5GQXj4I/k++cVc1PLovBUA7S5IT9GHt00qPOdWs8QljX2huK5hMtyLzJ4G100IMqVS2oHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934329; c=relaxed/simple;
	bh=T5b5jxJiTAIBVb5b0GyECXcw6v0/lKCNoMHW1cktSMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isfeFTMVcgbYnVOSA22CqaqseZ1wI74eghQQYpeK1n9Vbdy8wjBmR/bPDMP6iLmoaL/5SaqgpbZVRPvlS8nvBmmeBbYN30JRvvOW5p29IaEA3gcHywz8YRbPNRYQlLXdZbTGN5vyuBEvKVAZOn6LBJf/gR5mTKiDjACZvp+dROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C3/w3P9h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7ArFfODtXoKLBxdyTAxr6iUw8x20dk0Kmn1NzxS7Lxs=; b=C3/w3P9hBdiidxLuuFjoQUUwwm
	mMmu/m36Uy+6ee4lSQWYhNc7oF/kHIO5sWS1Gpn2fPjA+iJHMhrxkBJqes1RhHr1XGBtC962m7g2J
	FxcZlMPHzIs8ZwqWQEVqfr6JFfyU78ZOIoYP4fYC2FXqzhJs9V8dA0L6fbZDN/DoRoMM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJjz-007of2-Ut; Wed, 14 Feb 2024 19:12:15 +0100
Date: Wed, 14 Feb 2024 19:12:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH ethtool] ethtool: put driver specific code into drivers
 dir
Message-ID: <2951e395-7982-47bb-a9f6-c732c2affaaf@lunn.ch>
References: <20240214135505.7721-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214135505.7721-1-dkirjanov@suse.de>

On Wed, Feb 14, 2024 at 08:55:05AM -0500, Denis Kirjanov wrote:
> the patch moves the driver specific code in drivers
> directory

It is normal for the commit message to give the answer to the question
"Why?".

Also, what is your definition of a driver? I would not really call the
sfp parts drivers.

    Andrew

