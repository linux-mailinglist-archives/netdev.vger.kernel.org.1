Return-Path: <netdev+bounces-104103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF690B4C4
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0300EB3F746
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6071552F0;
	Mon, 17 Jun 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehsDc6ZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D7155328
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634375; cv=none; b=bvieO9kVx/vVDGIjtjA6OegiQqDwoTlbMMNr9Dsrzs7vcbWy7UEzM9JG7hXNhZ8g7kUb/9kQk5ouA++zS5PEzvqU2MUgshjiLD+fos5jphk5d9kFnkIDvfgr/hULcEDmiRaQKjCopfPdg2sMG/B7sRixwha5OvoY9cJ+tqP/wVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634375; c=relaxed/simple;
	bh=u3kkxlsf08GcFHMB3JWniDjpchrNMghlBz73+/xfFg0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=oL3uKnUMSYLRnNiqJBWBQ2XPjTLnFxHM72NAdvqyilqfVRN6g86RE7qiCosFi3lc1HYbHBtQqbuUsgPhC/JSXGFnomtxNpxF0k/VuX20+HDqBGVqMCsbwtzedDifdSqeVpmMOG/BIiW9Zb3Pxmvs/pE9Le03UyvvYNGbku4SXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehsDc6ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36659C2BD10;
	Mon, 17 Jun 2024 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718634375;
	bh=u3kkxlsf08GcFHMB3JWniDjpchrNMghlBz73+/xfFg0=;
	h=Date:From:To:Subject:From;
	b=ehsDc6ZBW5fTd9lkIm+qqFGmofW70TxNfwM6ho6tghAYGXBsxt4DtCNfahIbZT3G1
	 /iA37oLIFpyxUDOpY5ey492yEmdhrN3gXIGXMdaXZzkJ1eJwwZKjTgHARaqC/0VBZQ
	 3dkr1FED7RRG4mPCUNA+HMKx3bcMiPqUOSvjYblJlCX44IcGEeNO/Q1mchJewXsWgN
	 +W5Es8AB+AcI/cAgc9Zv0aidfQn4WRQ4tAsr43EvdABFabAMNTVfuX/BDZNzczFPzt
	 fh0DE2/Pc0tNOpHaBQSwMoNCs83X9WBy54UWFafMwPJVcfEzCqSHPvrwncukj3XDQ3
	 1VuN/H7Jql9Og==
Date: Mon, 17 Jun 2024 07:26:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [TEST] virtio tests need veth?
Message-ID: <20240617072614.75fe79e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jiri!

I finally hooked up the virtio tests to NIPA.
Looks like they are missing CONFIG options?

https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout

