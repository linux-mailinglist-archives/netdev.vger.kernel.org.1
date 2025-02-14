Return-Path: <netdev+bounces-166566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE3A36773
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127A1188DE54
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D241DEFE8;
	Fri, 14 Feb 2025 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB5hwIYT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44841C8616
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568199; cv=none; b=SVG6VDZqURldcGvbc7PK3SxRihA0DzZxEskQbqROA7RBaYcziurVgSav1U2daE6URwQHHHFCMoCnCaku2Xc+XxF70zslnX4kVssw9B+wFPA9OpaDh+3AWHAFf/tu6PM6Y4proWKxEA9wbG1orDE07e/SfqrWYVggl5i6o/Xp9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568199; c=relaxed/simple;
	bh=RvBQ4cRHe+DOZ8uE5NlDppOvcHA/QgQgKrwuFY7b6gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shMUYbmVzk/63NsdzG7HURjjYpJx0Zj8WUnJt5ypTP9ylMdYrJJFcFqA9yHimqToRrmZtkKrKkrRACHTzchbvkQui1U11ENJfEOkE3K2ELL9GvzK3IMywc+Kk3/b8dmEonicaiRWeeQNjP2fIFqlaZrNhiAKeX7cZI1X6kCf8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB5hwIYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881CEC4CED1;
	Fri, 14 Feb 2025 21:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568199;
	bh=RvBQ4cRHe+DOZ8uE5NlDppOvcHA/QgQgKrwuFY7b6gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gB5hwIYT9YnbxEfcz6ZxGd7sLiaAkuW2b/gDIFVhGRlKn6BMyyNJHn8Dfinasxu1v
	 mcfIj0AiyMgpNT/1hAYnUR8SFH5icPXt5141HwgLpCuOaqFuLjRjP9+WqoQs9P+vnP
	 KSC25k4POmah9LK1U2YPaYkxvxZ52AJGzl164ff96g8suhobZjAHZ4h6+vqYuitrV1
	 tvRAO05B4mxylKZTSs3MiixMAdrIvEgJDeIScu+ZwYBbB9wDWoINPAPpPc9Rd2ZQys
	 suoYAXR+pno7DzxjfB33cNyAPOSBB/mh1bbGSU+IrtFhXQ4r1w4eV35IEy/71YjhkM
	 DYK7tviQHRj5w==
Date: Fri, 14 Feb 2025 13:23:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Max Schulze <max.schulze@online.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, David Hollis
 <dhollis@davehollis.com>, Sven Kreiensen <s.kreiensen@lyconsys.com>
Subject: Re: [PATCH net v3] net: usb: asix_devices: add FiberGecko DeviceID
Message-ID: <20250214132318.3426db12@kernel.org>
In-Reply-To: <20250212150957.43900-2-max.schulze@online.de>
References: <20250126114203.12940-1-max.schulze@online.de>
	<20250212150957.43900-2-max.schulze@online.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 16:09:51 +0100 Max Schulze wrote:
> The FiberGecko is a small USB module that connects a 100 Mbit/s SFP

Applied, thanks!
-- 
pw-bot: accept

