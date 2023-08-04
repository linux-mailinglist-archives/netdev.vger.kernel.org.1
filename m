Return-Path: <netdev+bounces-24351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2E76FE83
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CAB1C21804
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86DA946;
	Fri,  4 Aug 2023 10:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E08814
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50467C433C8;
	Fri,  4 Aug 2023 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691145057;
	bh=LisFYqrHrFx436SkEAziF8A92P7uY+qSA0OgMAPh/Bk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HlF/5mCQOEUrJx14dljhhBCHpirfYCLy6M1w9mj7gncmtLrJMYh0vwf244TKRZ/Gq
	 zg6N/uEGVqdVBMSk0A/GsF+n8MlwudcVTwpvddOyOTUSeObVPquDd7cA5Q2QMuocoU
	 Ly1J9cw/xJkm9wQGDkl5yTC6FsXOC4AD1CY91C7LE8/dYn9/+hpygf0tAUEDSfqfQg
	 ozBRkyYXD4xPyCAIgaVHojJ+NyZ9QJwvnVgScvDp+L1cNo0d5T8WbWDQtUANXxzDuH
	 qkMp/zBzq5KMl2puFlB//tIEVKF+C2bkIMsd11AeN43zF312M32FHnu7RHeHQI06hN
	 z5fVyS/iZQ0Cg==
Message-ID: <e9196324-e228-d160-4c8f-ae45b4773633@kernel.org>
Date: Fri, 4 Aug 2023 12:30:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] page_pool: add a lockdep check for
 recycling in hardirq
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20230803182038.2646541-1-aleksander.lobakin@intel.com>
 <20230803182038.2646541-6-aleksander.lobakin@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230803182038.2646541-6-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/08/2023 20.20, Alexander Lobakin wrote:
> From: Jakub Kicinski<kuba@kernel.org>
> 
> Page pool use in hardirq is prohibited, add debug checks
> to catch misuses. IIRC we previously discussed using
> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
> that people will have DEBUG_NET enabled in perf testing.
> I don't think anyone enables lockdep in perf testing,
> so use lockdep to avoid pushback and arguing :)
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> Signed-off-by: Alexander Lobakin<aleksander.lobakin@intel.com>

I like this.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

