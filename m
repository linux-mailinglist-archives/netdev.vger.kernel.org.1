Return-Path: <netdev+bounces-144564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B749A9C7C8C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2772819AA
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8F204F66;
	Wed, 13 Nov 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNm9+9Tf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F47762D0;
	Wed, 13 Nov 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528198; cv=none; b=DNBFK646H0Nb/Ae0EQaDpUHQHIfc2H+n/itEHvEHrO9ZboISTraqCqqulzpGFrz53UT3vBC3XIVCK17ydVs72aRBBrNoO/fxKY1KlRSNU/qKaguTXjzIGHviwZ6CFdjzwpKUT07svnpRw1PdPogjA2U/yefPWYGStlIS+G5wLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528198; c=relaxed/simple;
	bh=zcMAHlefZFsi/k1EjrY+em8s7MIU+BFRYMgBXt5h6DY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnAXw5TICWPiE3nbkLJWuCU12Ljy/scFak+zr0MqDyyM6WYRSKS3dSA1GmCtVXwmjSlbFuSb3Ta1bbnxsHHVDu9uHIsaE1BWOa+2/NwOLj1e6AoTqul9H2p6RMmSLgg6fiySAowMg7D3TnMKD2E3wgYlbWM6djYPa5qsZCmCljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNm9+9Tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584C5C4CEC3;
	Wed, 13 Nov 2024 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731528196;
	bh=zcMAHlefZFsi/k1EjrY+em8s7MIU+BFRYMgBXt5h6DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNm9+9Tft5ZKjTrm/kUaG2VCVhL5UrSdg5Q5jPxAwvHBU+1igdnuvdkmW//I31aeF
	 g7SOgw5Zc7pPRSHIwCnyj+EqmRHlwQGEjqZwyRr88E4SC6/t7tLjK0I7DVqalSuIBv
	 Z52PnqAKjH3rByanh4pAiB0C+agHgWGDmNAaROi5E5LrXn0FCv1TIVdUtJpxwIcEF/
	 PzAJlcN0lWrKv7vwAoJQmS+w8szwxDKC2w3YgLOSYRcA8tEHM1A9MF02Ic+QgsX5Q7
	 MGALax95Y+dgQRqWrTWbaYGbrFX3fxuCqUWF2AtBtWknCRVv9I+3aT6cPGC8LJ/Pq4
	 84jGu5/UhUiJA==
Date: Wed, 13 Nov 2024 12:03:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, kory.maincent@bootlin.com,
 nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 1/7] ynl: support attr-cnt-name attribute in
 legacy definitions
Message-ID: <20241113120315.303d8ad5@kernel.org>
In-Reply-To: <20241113181023.2030098-2-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
	<20241113181023.2030098-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 10:10:17 -0800 Stanislav Fomichev wrote:
> This is similar to existing attr-cnt-name in the attributes
> to allow changing the name of the 'count' enum entry.

why attr- ? we have similar attrs for cmd and we use cmd- as a prefix,
so I'd just use enum-

I'd put it into genetlink-c level (you'll have to copy/paste into two
specs), all the non-functional stuff related to C code gen is in the
genetlink-c spec

Please double check Documentation doesn't need extending

