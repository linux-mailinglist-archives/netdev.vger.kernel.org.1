Return-Path: <netdev+bounces-205954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D01B00E95
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BA67B4FD5
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EEE214807;
	Thu, 10 Jul 2025 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ+xg+rt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1114884C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185730; cv=none; b=GjrZblwptvRueq0CDyj1ccpP+JaX9u6f9nnXpTkjV0z9DOxsskF+97rjzIApLQM+LlfGuUM60j1e4jjsEEnNCskWHhwudHkZlsRzAZhmotoBtcH2e64++BuRt+ePHxmAV3puAAFJtT1jmGFuA2g2+XJr0vss9+Z5by8uSC//bAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185730; c=relaxed/simple;
	bh=oDThJ0rB5TjhLVGRtBNDMn0rYqSeh4hn6ZTo52OSs7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNRTUo5N/EMhT6Ts3aEYk66Kgf3ReQ/q6cTCmSZklIdZvZrYUJHdgjBj8A+W2kiRjYzUiZV/i8aim3nTzLYLFnEYrQnqr5kAibBq/nr+nNCBi2R1g9nltJtDVZNu58rUFsG8HlYa1iiAbjLJ7U9rDWeqc2lmcntreBXJbjJrkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ+xg+rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9D8C4CEE3;
	Thu, 10 Jul 2025 22:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752185730;
	bh=oDThJ0rB5TjhLVGRtBNDMn0rYqSeh4hn6ZTo52OSs7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZ+xg+rtoPr9FPUKmN2b3VcOMlPWpdulvnJknC7+Yar+N8F3lMA5eWPp1xdz5xIQw
	 R5A+27Qt9OzMJ/wTY0/M+RQnqlmFhwKYIeNsTocL+7d2WyHcM36+faoG4LjUAsT+Td
	 wuYWrptBhgGcoXycNOGM+qulCmofURwBwWl4Cz7EWwya3wPNFEvVrRzyrSpa560SR7
	 wIbi5USenM1kT+UJL6wrtY6B2T9Y1Ls/tGzg6BIf4dJTljE4fCIjfe25SsjAXNCYg7
	 KB9KOgRVRwy0YSYbfqgOKB6RIl2rN6lCYGJdrAXXtyOBw7WJqEkBQjPaqFcVFXzD1E
	 ZLQ+y1g7v3bsA==
Date: Thu, 10 Jul 2025 15:15:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/11] gianfar and mdio: modernize
Message-ID: <20250710151529.0f8244c7@kernel.org>
In-Reply-To: <20250710204032.650152-1-rosenp@gmail.com>
References: <20250710204032.650152-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 13:40:21 -0700 Rosen Penev wrote:
> Probe cleanups for gianfar and fsl_pq_mdio drivers
> 
> All were tested on a WatchGuard T10 device.

devm_ conversions for old HW are definitely not worth reviewer
bandwidth.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject

