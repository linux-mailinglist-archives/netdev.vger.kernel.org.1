Return-Path: <netdev+bounces-22339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296127670FB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56872827A8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F81427D;
	Fri, 28 Jul 2023 15:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB31426F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE92CC433C8;
	Fri, 28 Jul 2023 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690559425;
	bh=7DFCo6qeekzwuWPEKZAyczH1RGTzlysIXVLTrOCoYTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ssPs83QcERvNqi05t+eltoSHZrWBX+5yll8ocUoJ5tvrPyVGdOXmXSQXX34MKYMAS
	 LJiEvvM8hZ47UKOV98143/z8syV08krfaTGFRfL9VWmwP7UKoAyxSvn49lx0hZD+NO
	 daHvXpoDM8PKR9rqNPoFHkdhRaiHZtE4fo26pkSRYONbtb8xKdZNzpffbZDPm6eqU0
	 f8t/atlEuugkpwJg/iTYxvJUs2oyV/ixdPn52u01abGmUY7WgkBwrMS9enDx5Q2dSn
	 uSPVpM/m1gNIhyrxexWWFlUZaHZVFt7CxkqSc+T5AAeADGk2BarQoeEbzdRiOzt9ZS
	 KzO31UWDItj+A==
Date: Fri, 28 Jul 2023 08:50:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Simon Horman
 <simon.horman@corigine.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags
 field directly
Message-ID: <20230728085024.684970ba@kernel.org>
In-Reply-To: <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
	<20230727144336.1646454-6-aleksander.lobakin@intel.com>
	<a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
	<6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 16:03:53 +0200 Alexander Lobakin wrote:
> And it doesn't look really natural to me to pass both driver-set params
> and driver-set flags as separate function arguments.

+1

