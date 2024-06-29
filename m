Return-Path: <netdev+bounces-107867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98791CA75
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 04:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7961C21B8F
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 02:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4253AC;
	Sat, 29 Jun 2024 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M94RdB7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F284C9B
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626596; cv=none; b=jYSM1v4oT2/eI/Qwzhe07RQpSbqWqdg+JncjL4qs5Uffp1IhPSAkOTs9EluSNXZY0Mkl/GJypuev4TJW95SPhmbfs45XXtdy/Bdo8htDlPcj4/useth5WxaAc+3MC35/gaAQLDenz+uWHMdhpcVZGIZLw0ICFGKikdA+TnIKeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626596; c=relaxed/simple;
	bh=4jh1b/tUzU/EXtwGt+hxv5cw1omKKpupSzRFBY6FEyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIa3PxAgRPvLwLWKOvncJGGVgfXsNHW/rbUyaCbwg1WANZniFlx2axAie/raGLWiLc012T2SdKJzRORX5zUvUQsi64ZF6GJyq231k2PMQXhISrZO4E/aLglKguWLkjlLqp+1Jyq8iGUCsGt3DD3FVU/qgUbWQ027jrLy0wY5u14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M94RdB7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03093C116B1;
	Sat, 29 Jun 2024 02:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719626595;
	bh=4jh1b/tUzU/EXtwGt+hxv5cw1omKKpupSzRFBY6FEyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M94RdB7GsSlrT7TTDyr3aMPS5+k1PghHFIIfMeHtlP/QaDHFbQUBFhqob8uwRNf86
	 /YQZsQz/cdKil0TSuEA5fKIAJqXzX9nyC4UqsbGEWNCezxYWv6DLXPsvekYsSa9hmJ
	 n4M22YmlMwWnlxCsPpfGeNpCkS0+SjKwzucwM+flKvv99eUytXPPUX4QotSix95510
	 oV4s75zmxrXkHrep8oqQ4SO+7C1ey5Azh4hUpHBD5gt0CxAJht9tnMy8Po8GmU8lX0
	 M1bcZWEhCOPxI1l8QJ1IkkGB3ZqoUkqcw3I8FHc0k5lhxLaA4Yq21sQJiKh0vsO+9Z
	 WngsrcvYtxV5A==
Date: Fri, 28 Jun 2024 19:03:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH net-next 0/5] net: introduce TX shaping H/W offload API
Message-ID: <20240628190314.7d1841fa@kernel.org>
In-Reply-To: <cover.1719518113.git.pabeni@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 22:17:17 +0200 Paolo Abeni wrote:
> The ice driver support is currently a WIP, sharing the current status
> earlier since some APIs details are still under discussion.

Let's stick to RFC until it's ready? Quoting documentation:

  netdevsim
  ~~~~~~~~~
  
  ``netdevsim`` is a test driver which can be used to exercise driver
  configuration APIs without requiring capable hardware.
  Mock-ups and tests based on ``netdevsim`` are strongly encouraged when
                   vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  adding new APIs, but ``netdevsim`` in itself is **not** considered
  a use case/user. You must also implement the new APIs in a real driver.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#netdevsim
-- 
pw-bot: rfc

