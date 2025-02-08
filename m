Return-Path: <netdev+bounces-164259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1016A2D279
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C3D16A1B6
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA691D52B;
	Sat,  8 Feb 2025 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb89z8mY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE71494A8
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738976997; cv=none; b=mXJCkL9XSOUp13LBKg1iqyEMZaP7ajVGa7a1LaOk/gJe8euX/vb6q5hhACl3HKA0ZLWRc1XyI1ss05vT4ckr7DUXwfJ4VpzzORduRUbWPNfEC+SdboDkO4vDZL2PQsWhwqNWB3oK/7M0ekhG53dNnGesbH+4mEk1CSdmwMcbcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738976997; c=relaxed/simple;
	bh=cCWGDn48M/4kWu3mmiYV0MDDho6Xvsw1YsRmoi7KFL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7+e0swf0K+Ojd9rfMx4yvcFJImp34UGA61FboJ75V53doPKhdnPyuHB+yNEzPyW7FRxo4835JRA353v5seudiXWsQhuBdIuMhZRPqGvDV4AyBaHU3SbJMlnvX92urIC5kCjfqUaJ0IJm8QhkXAlgyLwhx5zlYX1ZMFuPihHDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb89z8mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C842C4CED1;
	Sat,  8 Feb 2025 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738976996;
	bh=cCWGDn48M/4kWu3mmiYV0MDDho6Xvsw1YsRmoi7KFL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bb89z8mYOGvRhtKjmcfok9aoHcFdxCliyDzARBkNp3DnDn1Wa7Uih+tm9JWKWeiJ6
	 K2s0LdTYxeu278QHdgjr1NbYuuQc8k645mSRcCb3PC2e3nI6aq6h/kWGV2JsDGRRMK
	 tYIJP2z9Sw1WbaTCE8WJwl5wRNitcT6RzGh7FlpLFHLTiUKvGApoo3y/iBRwGoI7wX
	 WcE/GQJn7wZSGatsKNpCGOQW6iBU8jeQ2CGBF8wyvs2VPPIL70W5u1suWcA7hPQwUg
	 y4CJkSB8vQpIuyjiCSZFo2pmIIeqviQb6tolMdFtR35USD94In9/0lbTJSwb7BIY0N
	 nTREsels8AQLA==
Date: Fri, 7 Feb 2025 17:09:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mengyuanlou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v7 6/6] net: txgbe: add sriov function support
Message-ID: <20250207170955.7c5d97c1@kernel.org>
In-Reply-To: <20250206103750.36064-7-mengyuanlou@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
	<20250206103750.36064-7-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 18:37:50 +0800 mengyuanlou wrote:
> +	for (i = 0 ; i < wx->num_vfs; i++)
                  ^
nit: extra space

please fix if you have to respin 

