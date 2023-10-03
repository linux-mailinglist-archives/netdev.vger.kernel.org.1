Return-Path: <netdev+bounces-37805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1952B7B73FE
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C487C281359
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0A3E466;
	Tue,  3 Oct 2023 22:12:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1773D99E
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566CCC433C7;
	Tue,  3 Oct 2023 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696371137;
	bh=q6Dyt5FLueLuidAVO6CSqngPH4jdGpeS1FwXNN8jOvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BgdwRZUzLtjU1j502sgJEyqQ+dYb74+GZ33d6lrbtWVhyrhZl1zsmLq4V+JhBesuQ
	 Ajj0lSVsuSnt1/rb98YiNlkZVMEI+X5noSJsxbhKxHeuykAPkOSIq97q0vDbtf6O5Z
	 QDPcPDN7QnVs5iJYlgBl/fFe5X97mjKLKuNvm0THOPeHMxHito0MX57FLWdkcItY8N
	 ewLjJNeOMaT847b4fLqG+1bc5aLhKT4NYY1EQYBtA++jDcGczHDOKFSCGX2ICo0DKQ
	 q+eZ+V3PfenUripubJ+kl3FiEZjQTeLy8qiMGDEPwzBwKiQQ+XzOJKJaZjbe4ZO8bK
	 I2MaOl5PaWoFw==
Date: Tue, 3 Oct 2023 15:12:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>, Liang Chen
 <liangchen.linux@gmail.com>, Guillaume Tucker
 <guillaume.tucker@collabora.com>, Matthew Wilcox <willy@infradead.org>,
 Linux-MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
Message-ID: <20231003151216.1a3d6901@kernel.org>
In-Reply-To: <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
	<20230922091138.18014-2-linyunsheng@huawei.com>
	<b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Oct 2023 09:45:56 +0200 Paolo Abeni wrote:
> I think it would be nice also an explicit ack from Jesper and/or Ilias.

Also a review tag from one or both of the Alexanders would be great!

