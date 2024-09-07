Return-Path: <netdev+bounces-126138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AE96FEF5
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909E61C21F18
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DFEA95E;
	Sat,  7 Sep 2024 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZG8bEHH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13631E541;
	Sat,  7 Sep 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672463; cv=none; b=tkSEFnjxKiQj/AG29ECFggJYjEkQjKzauoCyCT7UZ5V6uuqFcnQBC5u6V9HrhQADgCilqNe+tGtOkUx8GtPnDrSFOEmuyqGWs7ceZsSGq4OfJHaEa0oIgOWqSso9T9QtXzlW/p0l+1OnlQ+nhAloR1bFXsbLY85xosgMdd9xTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672463; c=relaxed/simple;
	bh=hhK9xyTK1dbDT4DJl2M8/bCWMPUnWTxRTPsbRPS2CzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMGGFjTA7fhBxq0jXER65/OdejIITVYlEh3V2mizhoNdK9MOTEQ0r1r1x4dnRM20GB3vxhZi0g9yqFzSnSi92mwiralQBZTQ0ZCrE5WiXGzFYMwGM09SunZLiBUdaTmXuk1+6bq2NMb4/e20h2C+qUDwd5V3pCmpvWTe+S2/WRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZG8bEHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C51FC4CEC4;
	Sat,  7 Sep 2024 01:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672462;
	bh=hhK9xyTK1dbDT4DJl2M8/bCWMPUnWTxRTPsbRPS2CzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rZG8bEHHA2O7BFu4H0RWDhMwoBA5w5RWvJqFFY/UA/MPEblrXkUXHWUN7iFljFSbj
	 78tOuEhmexFlPKBJj0pE0WOlmPJddRkQmNiqBiX2t4pATYvIobDP21FzK9vPyKAcXs
	 GX8phFR3J1K16Ev/6yo5zeRtinQS4+EDSZ/wtr2sDPrbbdhKoGG8EOAgMXodGQHiD0
	 VJBoFlSYxhGKBZ9+O3cMQNPrxUQgcqCOH2KkmEtS0+cGdCO+ST+jlH9E/zNO2xBJec
	 2oYQYp+9g2DKruFHyOG5qFqVpCg8EPOuX4Dgoldc+cLoegzwuEulLOSqjzSVp3Q6hu
	 ubijHGWeJYgmg==
Date: Fri, 6 Sep 2024 18:27:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] x25: specifying bcast_addr array size using
 macro
Message-ID: <20240906182741.5ed3da1c@kernel.org>
In-Reply-To: <20240905131241.327300-1-aha310510@gmail.com>
References: <20240905131241.327300-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 22:12:41 +0900 Jeongjun Park wrote:
> It is more appropriate to specify the size of the bcast_addr array using 
> ETH_ALEN macro.

Not worth committing, sorry
-- 
pw-bot: reject

