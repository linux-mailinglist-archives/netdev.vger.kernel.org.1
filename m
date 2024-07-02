Return-Path: <netdev+bounces-108303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B8391EBDD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3D9B21651
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCA3D6D;
	Tue,  2 Jul 2024 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SySC2hP8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063933C38
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880656; cv=none; b=ENy8j/BLuI+CkonOIIs73RDx8+LLySTtm1S7hWto2XU17unjN6Sv1/eteB7qQKZow8SAm5qFeVOxz4gCTbSE6kmv87nS/nmHMOFyT+uOPmnmd5dicz0xJuU+BZ0l6HacaX/NRvpItqb/clnv8ecGoEBLhXHWsin102q3THZ9uyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880656; c=relaxed/simple;
	bh=SN+6Yj99dLy3hj0KjB16fv1r+X+ZdOjEi5wONvqex0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsk7U1bxnKBP9bQFiPkihJtZEo4gueP8FF55T0Wpu2EfszZ8xGzz4isJoubr3ffOKRW9UQqxuNmBRwfOHE80qUe6fuUb1owxDmgZqq15NfUzoEmUgFonhnlu3MricxOTLzj/E8cq+jHfKE5WPY4bERb1RG9TWmq2NjORlRXl9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SySC2hP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE61C116B1;
	Tue,  2 Jul 2024 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719880655;
	bh=SN+6Yj99dLy3hj0KjB16fv1r+X+ZdOjEi5wONvqex0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SySC2hP8l1sFXvXZxoCtwXT8K9RnKMuLNSFIBAu5HRHsBhiYCtujewWc2McV05EWa
	 OJIIZXshrgk+13e4jNHyGKZlntPOtd9erOS83R+WSYccn/hTBW8Gmrztc3ZaTT07Ft
	 LC31QDqCauwg+SL1kTETiMKYbyIJRYUqbHG7mZzZDbk6Jazp1A7ZE5DO/x2MnAhuK5
	 axK9CbsKxPyuLqDjet8AmOct+gKNGPj6DUms9kau73BQVPELGL0Bf1oAieqq+MtKly
	 0da7A2iUDDPxgFmJy1JgMcsOLToquFi05uaWLwj2Ht9M/tCkb3qYPTPG4AOacmsr+N
	 2mWDY/X/TiXKQ==
Date: Mon, 1 Jul 2024 17:37:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
Message-ID: <20240701173734.14df1ad6@kernel.org>
In-Reply-To: <ce6eff278a2df55fbdadf7fd3af7b1d9bd7f50a2.camel@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
	<75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	<20240628191230.138c66d7@kernel.org>
	<db537cf129f23b012d09f7067146c4daee31cf4c.camel@redhat.com>
	<ce6eff278a2df55fbdadf7fd3af7b1d9bd7f50a2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Jul 2024 17:50:17 +0200 Paolo Abeni wrote:
> > would require some patching to ynl-gen-c.py to handle the s/_/-/
> > conversion in the generated file names, too.  
> 
> I mean something alike the following, to be explicit:

Great, thanks! I wasn't sure we're actually ready to make the family
name use dashes, since we don't have any precedent. But since you have
the patch - please submit!

