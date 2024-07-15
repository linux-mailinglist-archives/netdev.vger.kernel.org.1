Return-Path: <netdev+bounces-111408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B8930D15
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 05:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468A4281276
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 03:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0F1581E0;
	Mon, 15 Jul 2024 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzrGkvXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B8A3F;
	Mon, 15 Jul 2024 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721015174; cv=none; b=ZuIZ9N/5vzCG80PUt34w71UjyO/sxfTcrdIrCke3q2d2oiMSEacJ7amo6Wl4xZ8dvd8ayDnZTYtQ2aET52I1Wm9nM/B12Xops2YIPEbps+k1MlNoIxE8LX6ZcybG0VL62rF8jPzV/0LYYkUGDbzO6cnfsaOJNIsaEJHT1ZMvtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721015174; c=relaxed/simple;
	bh=BnTY0qL2c3hdlYBlphIlWIkesSRGIJ4d6MG5sMGRRFY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=U3t+/cO/ecE3xkPljM5ucBP9icr141t1KOVGs7YJ3HPT4TfgyxQforRM5FVZYEXhon8eqz8BqXbXc7VLMiwsyZIeVZNXHrCPe1WqGSf+tVNP1a2ILCJiCByrYxMnn7dcxs94qbE0jhbMSy7Pc6wLRW4Z2BcD8TXqChn/Wuvd/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzrGkvXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDE7C4AF0B;
	Mon, 15 Jul 2024 03:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721015173;
	bh=BnTY0qL2c3hdlYBlphIlWIkesSRGIJ4d6MG5sMGRRFY=;
	h=Date:From:To:Subject:From;
	b=DzrGkvXAD5IxNxuWM/wB3mB6g0TFR/Rqmox93XaO8D4+MfyPFeO4oGpXhf9M+twO7
	 CRePwKJ4h2oW4seVgHiGp717HCfCwjOvwPQqcKySRuk15SrBYDAxxkpqNUbkkdHVI5
	 t+4iwfcQ4NgnqahJYcJeL1UAAKMx7sgJohkYhwHEThxuHUkeVAFxqg48/9JiYWxoJp
	 A2xyFZ41inp9aOrVPeWULA8XR5thq+xkocagEfb4/pbOYRzIrgjy9XiIUyMRGw5FZb
	 4Z+JqyUyz48y4H9R99TZ7wyzxana0SQEnjEGOdPRl8NwTRjYIQFV1pxRdmHa2Z5nDf
	 Diysoq+SREryQ==
Date: Sun, 14 Jul 2024 20:46:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20240714204612.738afb58@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged v6.10 and, as is tradition, for the duration of the v6.11
merge window net-next is closed for new submissions, until v6.11-rc1 
is tagged (on July 28th).

We will still look thru patches already in patchwork at time of this
announcement.

