Return-Path: <netdev+bounces-212285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2EB1EF0F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F155A05969
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709228851D;
	Fri,  8 Aug 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgk4dUpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2E2877E5;
	Fri,  8 Aug 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682773; cv=none; b=thsn6atLP5Nk2bo3wyssrwvzp/lRJiiIYng3NEvBgYb0MtdcutuxQbl4AsyuZd0lzc/5HfZOTNlGgISzX/SHSBuzA2hfnM1BL8538HlNgBu9R0wrAn8XWYpJgnEe1qVMwA4z5kuw6QVg9WntmzbeSWsqQLenL7XoOWEtAt3WYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682773; c=relaxed/simple;
	bh=sSGceVwWr8E8AI5m4Dn7u6VzglTM5soJAk6hGXZRXiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQ2SqgAu4iId0+EC1OeGpClt2+KbbOL/JDrHHZ6Ss+GwsFnHdSA15bBaLmGNVdT+EjeFFaXGW9offVe2rikOSXjG3yFYpwH+dR7ErLCJlRMRz0yqX9uZ+EddfzNKRHVuVz1j2vNwKzB8GjkoUbhn5g7dHJ5Yf2prUsy+H+3xDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgk4dUpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A3DC4CEED;
	Fri,  8 Aug 2025 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754682772;
	bh=sSGceVwWr8E8AI5m4Dn7u6VzglTM5soJAk6hGXZRXiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgk4dUpxc6WBzwvc1EIGtU53EuFoWun386wNek/OLT6LoFvKVz9joCcejevvioXZA
	 rnrOv6lCI70Hv3YtRv0vjgOBQ4euBJVuQmVP0g5ofa2vi7LOYvPqYQ3ZuYb2REIZJH
	 iJ9IijJ+RIB22sNgdzDunotR1slieLkS/3fWgbf0a0CCTEZEutYtORzvXB+D6CsJ1p
	 thowon2alk3PNwlqUoM91qEDrQbDAx/jRZVu7JNiFhZGGcyLJXRqyZEFGwYgK5dQFC
	 YHQIOnmWA+XYK1tJ13kpyofaNDN3nQjIqCVv/VQ6VFe8Wtsvt3rEqPBKOr2119NDcX
	 RuW88K0sESgFw==
Date: Fri, 8 Aug 2025 12:52:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <zhang.enpei@zte.com.cn>
Cc: <chessman@tux.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ethernet: tlan: Convert to use jiffies macro
Message-ID: <20250808125251.527e8ecf@kernel.org>
In-Reply-To: <20250807201722468rYsJszSAHXqlVrVHEIuAz@zte.com.cn>
References: <20250807201722468rYsJszSAHXqlVrVHEIuAz@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Aug 2025 20:17:22 +0800 (CST) zhang.enpei@zte.com.cn wrote:
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
> 
> Use time_after_eq macro instead of using jiffies directly to handle
> wraparound.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v6.17,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


