Return-Path: <netdev+bounces-37508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E97B5B87
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9F6011C20873
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0755B1F95E;
	Mon,  2 Oct 2023 19:48:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0691D53B
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683FFC433C8;
	Mon,  2 Oct 2023 19:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696276091;
	bh=/l+oGxiTj0F5nFOj9e8/n4KY6PWGpjXt32hzruFtSnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSJkLUnp9coEyGjqZOi5NV0RHk6NCqf+Nj19/wZY4LKi4bz1hTC/mhPBuJi3xU4wa
	 U8JWmXfk2EB7lUlgjc7jRGfJPGPA/gcrRZJmhEuoNHluB/XGphKLHXkv53Pu4WAY6o
	 CpUBs+EWXbwVvzLXewAIphoyOX36IAET9E9fZBncDENOzWdCqbdPvbGd7MU2TCQkw6
	 SFvo6W2SjghaN9PAzBsQKAcJHc1a5ZSr5KPOItk+8mT68qSAmA+FfbC26vBRNOtosu
	 32PHifgxNaX1qty4QffUT47wgeCPP/CCyLUVBNLYZHyljEjxAjiN1lnoqWvsXDiKJ9
	 ncfUljmB8U/Jw==
Date: Mon, 2 Oct 2023 12:48:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, hawk@kernel.org,
 lorenzo@kernel.org, Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org,
 mcroce@microsoft.com
Subject: Re: [PATCH v2 2/2] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <20231002124810.62c772a3@kernel.org>
In-Reply-To: <uupabbfdmaxzkglgpktztcfoantbehj6w3e4upntuqw2oln52t@l6lapq6f4g4l>
References: <uupabbfdmaxzkglgpktztcfoantbehj6w3e4upntuqw2oln52t@l6lapq6f4g4l>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Oct 2023 13:42:24 +0200 Sven Auhagen wrote:
> Fixes: b3fc792 ("net: mvneta: add support for page_pool_get_stats")

Missing letters in the hash, the hash needs to be 12 chars:

Fixes: b3fc79225f05 ("net: mvneta: add support for page_pool_get_stats")

please fix/repost.
-- 
pw-bot: cr

