Return-Path: <netdev+bounces-210259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17384B12806
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0395874CD
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61390381BA;
	Sat, 26 Jul 2025 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX/BAYw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8B1EEE0
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489855; cv=none; b=jRV6prVsb+/RQz8OQSW+0+H/tWTOn5qY25OoUJREJJT+Q862T3zhlWEX2k/G5fzGG7PF8tY2pR9GMR6PtWO71d3NQPqdYTbxnMPp37/r4WYzIwFwMG490EK12XPkEE9wlxM2J90/5oBUx6oCb9cVv23cf5VPBQoEsy6abbyeYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489855; c=relaxed/simple;
	bh=TtmNPHMHkasF8T4cqZU2S+rHxXuhMzfXsoOZ0QlkS2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXi/M6Oa5qtIMT9wK+hWZlvWOecT1AQjSg/FtZEmUGFbOejNFF6QibR3HFFbQr/AggBj8dWCYhIgeOT9hfgexvoRXX1Al5Kf0hXA0vBUdwCp1DVjYV4wQQWG4gZGHeT1a44IIrmAT5AvtAUjZ7nGBV/2szzOJk0/HdS7yREh79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX/BAYw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802FFC4CEE7;
	Sat, 26 Jul 2025 00:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489854;
	bh=TtmNPHMHkasF8T4cqZU2S+rHxXuhMzfXsoOZ0QlkS2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uX/BAYw+gtqPljkkRt6/pWTK+ZBpUb5N3XIC6vfck+H01T2mahLjztuPVeS42cAEm
	 jGsjI4dM38zK30No0gyTFsM9NTujiROGn7EijpIRuHanI9m9DIEk47l94LFQMbMs+Q
	 x/ot7v1EkVMMNySuck38hWO1dOKnUxfwgHvcCzfV4L7iAbq4tZyMGPX6xDk6VeWhIY
	 jbR1k8eEGleoGCR00ut8RDVmO3vnagYBJ4im+zKZTk5K99sWE5DY9crDqDR3a34rA7
	 N/x+jZwFWVlz/5tz90AYQ4SLKiNAkaTBRz2Ud0gG7r2q9jsgb2Wwh1II1CfWixetAW
	 vICg/v4Ivijbg==
Date: Fri, 25 Jul 2025 17:30:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 1/3] net: wangxun: change the default ITR
 setting
Message-ID: <20250725173053.2145123f@kernel.org>
In-Reply-To: <20250724080548.23912-2-jiawenwu@trustnetic.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>
	<20250724080548.23912-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 16:05:46 +0800 Jiawen Wu wrote:
> Change the default RX/TX ITR for wx_mac_em devices from 20K to 7K, which
> is an experience value from out-of-tree ngbe driver, to get higher
> performance on various platforms.

"out-of-tree driver does it" + "higher performance on various platforms"
doesn't sound much in terms of justification. Shouldn't be too hard to
run a TCP_STREAM and TCP_RR tests and add the result to the commit msg..

> And cleanup the code for the next patches.

Should be a separate patch

