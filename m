Return-Path: <netdev+bounces-221192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFCB4FA00
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E3316EAAC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF27F32BF35;
	Tue,  9 Sep 2025 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnbLR2rP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05C321F20
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419864; cv=none; b=hrVudQrIIXTh+uz+xlrtQ/6acXL+4Lho1PYIC8NPgeEjPYOANP/RX7ZpYcSCtI4MRyJuRP1ucQuggx36tol/YmcR68fE/qJTeCyMelRL/AhlBc3+F5P6D5hx5SzO9WETeVBwcfQhHHWJ8U9adDJp2emX+g19juAG47ls7O4Ctjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419864; c=relaxed/simple;
	bh=aiJ0tX/AQNMjlej4nJulWq7xJVyTlW6Z15xIKStdrgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSuJF+yLh18N2Ys0p/H/Qgk3TZZLdcVYd6o2akFzNRhvni+o5JFgc3wH4dqIwIq8USS0gdQRayjlINcA6DeZkc9jdoIo3f3tsM/AL89hhjxyYVx9twxEA/KlmEXFuRmIa5eWBpPa9ohOUDeipgGo0XLnt2N3+MB4oiAbcdKVwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnbLR2rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F0C4CEFC;
	Tue,  9 Sep 2025 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757419864;
	bh=aiJ0tX/AQNMjlej4nJulWq7xJVyTlW6Z15xIKStdrgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnbLR2rP/AEHYJLHhylrIpWfhcIGNqYIB07vV5j2BdyqgvS6MI4zvW/cR23tcXcmt
	 89EJgi5ac+U/7dfplOHCa7t8ZZPE9fX5CmYLkgAsddOnE5vm7nJuu/xI9HuGlNiglC
	 10Zb3uG8YyOzTaa7dWnPBEyb2o5CuqLWC+DnVSrpnNZEV9dk52Bn2pSZSfMGtDCiEp
	 anGQ/hXnjxpRHWx7mIjSXBwVXduHqHzlWfGIauk7IUE7LltrtMC/NuOtOFTKuPSnkg
	 1+WeR1RJL17Crzu5T0bDNLzvA+sSqTXB29EbW4TDKADXLkPhCIZchi4RPsFlatWby8
	 L4yTxMmckVsBw==
Date: Tue, 9 Sep 2025 13:11:00 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: udp: fix typos in comments
Message-ID: <20250909121100.GC14415@horms.kernel.org>
References: <20250907191659.3610353-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907191659.3610353-1-alok.a.tiwari@oracle.com>

On Sun, Sep 07, 2025 at 12:16:52PM -0700, Alok Tiwari wrote:
> Correct typos in ipv6/udp.c comments:
> "execeeds" -> "exceeds"
> "tacking care" -> "taking care"
> 
> No functional changes.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Hi Alok,

I'm wondering if you could consider also fixing the following while
you are updating this file.

measureable ==> measurable

Flagged by codespell.

...

