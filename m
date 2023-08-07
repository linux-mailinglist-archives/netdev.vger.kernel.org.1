Return-Path: <netdev+bounces-25118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D9773022
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B912814A0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC1174E0;
	Mon,  7 Aug 2023 20:09:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C616408
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FF4C433C8;
	Mon,  7 Aug 2023 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691438988;
	bh=qYWsNM5r7KU6Cd8OsjqQh7cSxa56PwYXzSXeTpvD484=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lBIGk9Sgqtp2SLMYrLtIXYquMrq7NoVnRLTmtW60SpEdGz1Lq8fqFDjTmmMOJA3pd
	 imgPShmiiwFa9g6FfQQFTgaa4L6u0Dun9rXEpXuxrJVYpZeFXYF2TzZC1S1uyqMIfk
	 tx5N6SP7gQ2iR7YrnT5JHrYNw0Dyjl0eZPSyQ2VbPis4hKX9p7ok1JSFchlNsxWE7H
	 iEN1AJ68ys3wNV9qxfYTf2riOcDKUpb55jYsoApqZEnLaXeB8Ks0EenpVo29SOn2uG
	 EPD2diNQWNg4XEEyOjAwG3+QTpKCIxia6muqW7WTtuqGYrnOfgldAgbcAWMxZW/6s3
	 DbHWrEvxGwY4w==
Date: Mon, 7 Aug 2023 13:09:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman
 <simon.horman@corigine.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/6] page_pool: split types and declarations
 from page_pool.h
Message-ID: <20230807130946.22da17b4@kernel.org>
In-Reply-To: <20230804180529.2483231-2-aleksander.lobakin@intel.com>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
	<20230804180529.2483231-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Aug 2023 20:05:24 +0200 Alexander Lobakin wrote:
> Split types and pure function declarations from page_pool.h
> and add them in page_page/types.h, so that C sources can
> include page_pool.h and headers should generally only include
> page_pool/types.h as suggested by jakub.
> Rename page_pool.h to page_pool/helpers.h to have both in
> one place.

I had to touch this one up a little when merging to fix build 
for the merged-in-meantime mana driver and also update the
patch in Documentation.

