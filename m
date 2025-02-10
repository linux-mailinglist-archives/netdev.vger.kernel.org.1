Return-Path: <netdev+bounces-164815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB4A2F3D7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F80E3A82C6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBAA1F4634;
	Mon, 10 Feb 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODK7qD1V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2B1F4625;
	Mon, 10 Feb 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205712; cv=none; b=nw1Gm5t5wMEPfHTNYQfm0TNKyhPIqBK7wXTdkJlGLO14GmtR0WzHFUiPwse1fT6ZEXm7Vf+MV8CU4wkqXh4S9cfk0F5CoyjSqJzBIO13X71IN5a1myRHHzP4ltEWlJ46OFm4xaQyJvmoaXwRw4TgFLkusIved7jiMAjXVqnRzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205712; c=relaxed/simple;
	bh=QpeiK2sRkZo2IkL69SEukYBewbXtcL/h1uTz1zaXmac=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=FoM4pVb1WVOtr4nwdt92A6Vu7ApBeiyOq/qV3evlrbCGX7tD9a4AV+/7vbRNufk4McHMMkveMxgIMD32plkQx6QwkuyOOOF+G8U23jhEC3cp5zoeakssCGJTVzHB3zLIT3GgaccYpGDxleaoqLyDo4eFs3LiA2Whh0zAP2pSxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODK7qD1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13170C4CEDF;
	Mon, 10 Feb 2025 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205712;
	bh=QpeiK2sRkZo2IkL69SEukYBewbXtcL/h1uTz1zaXmac=;
	h=Date:From:To:Subject:From;
	b=ODK7qD1VXKLlYEvVnv5qk2bYM/zvc6qP/rON9+WFZ/sveu1lRHzo1H9VVkTMt+s0q
	 wshqhv348Kd+MJkpXhaUvSTmGYX8Zpx4mp56cvhGUOZHjGB9VW2B+GLodmHwxnKjz1
	 aAIFtS25Go6kXw/w+BS2Q5mJWh/l231WxrE77PRs+GIUJERa1oilHymVMrT5+HgreZ
	 hHO7zcHKxhKvQIQVEnRRxCBiZEvwSTK33gU2sh4aC7yBH+T88K1HoN7qBs/5PWSthE
	 rpu66LfQ5g1STdqPqidXqU0S/DJ1+v8Z1VeqNMOBy+1/yPfxO4jHy2ZpOC6+CNQm6k
	 9JfeF/vMJWBKg==
Date: Mon, 10 Feb 2025 08:41:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Feb 11th
Message-ID: <20250210084151.160d5d4f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

I'm not aware of any topics so please share some, if nobody
does we'll cancel.

