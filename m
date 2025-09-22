Return-Path: <netdev+bounces-225367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981AB92D64
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1BC445EE6
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA832E2847;
	Mon, 22 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwOqxwNm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842525F780;
	Mon, 22 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569653; cv=none; b=mkV5vYpxUQ8UuxqxK2e6z1kkarOOA4zyFeDktcPvmwDmQZWs072iHh5U3EdzLenau5xA3dzwRf9F+iw5sZ5GoBf4J/GMTohgf8DlbhXiOwyY0p3OOfPdrdx3J6e2n3svDDrzMQ/u3mCf3ni/ywdXi/zTDYWoDrCX123iZcTzu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569653; c=relaxed/simple;
	bh=Ey6sKutYZ1Fijp8PnsV3SkaM5E4Pys9qDHMWqOLcV24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlpJfdqbjUJ6NxSoombz2JLLc1Qo57BqW9dbly4sP7sIpYjK/sUQ0v+oei7YhP03fvWwTaw+TalmtAMv7GD3oV+qkRxbIwnGkTt1I7311tmh5T/D0ky7qdqB0bgqZsvZq0nHdzbohHwq0DltPzfJdE65VFfVEQBVGfKPXKfPxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwOqxwNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6456BC4CEF0;
	Mon, 22 Sep 2025 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758569653;
	bh=Ey6sKutYZ1Fijp8PnsV3SkaM5E4Pys9qDHMWqOLcV24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AwOqxwNmLgiUDqiuf0HQ3Hu47E9Ln37sAknF6LmfrIZIaRfYMAC8cMwSiXFYF4Idg
	 PI/qVLkLxIRYcEQyIppq0fpZqw7kyXj1Sok4sol+x8Ip9qhEfeuXm54yE58h1LZoUt
	 KHSoa0uweAK0ARmZUnqcGWnpKNVluW5ovv6AbplUoGaxzddIIUPKDfQAAfp6ClkjJs
	 5cEfhJVA5I86E4t/YwWTVY33rwGd1DS46DRsVTWb8y854NNISkqv/IsN/bZzUsZ4I5
	 xtOrKcqUCCM8MP3yVd/6JdzyY6a3M0OWSN8A+J+BJ4NQLPFwCXs+vNdZfKk2X//Rll
	 jFlkvbjIk4oDA==
Date: Mon, 22 Sep 2025 12:34:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2025-09-20
Message-ID: <20250922123412.0ab3140a@kernel.org>
In-Reply-To: <CABBYNZJ6DcUPHgCrDquW+_q340yxJHfudVDzUFWuXMTFvqPEbA@mail.gmail.com>
References: <20250920150453.2605653-1-luiz.dentz@gmail.com>
	<20250920133841.38a98746@kernel.org>
	<CABBYNZJ6DcUPHgCrDquW+_q340yxJHfudVDzUFWuXMTFvqPEbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 09:59:44 -0400 Luiz Augusto von Dentz wrote:
> > On Sat, 20 Sep 2025 11:04:53 -0400 Luiz Augusto von Dentz wrote:  
> > >       Bluetooth: MGMT: Fix possible UAFs  
> >
> > Are you amenable to rewriting this one? The conditional locking really
> > doesn't look great. It's just a few more lines for the caller to take
> > the lock, below completely untested but to illustrate..  
> 
> I guess the idea is to have it open coded to avoid mistakes like
> unbalanced locking, etc, right?

Yup! Makes it easier to read the code basically.

Thanks for the v2!

