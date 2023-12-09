Return-Path: <netdev+bounces-55507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F64880B153
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2934B1F2126A
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7127FB;
	Sat,  9 Dec 2023 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnBjlmg9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A7628
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B66CC433C9;
	Sat,  9 Dec 2023 01:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702084544;
	bh=pS7MlfNbwl/Fhu3GrSIjw0yO1cc0pZZG21Lsn10Aahk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YnBjlmg9axdBsBOudX3MhpFZxt5NM0IClStBSJBRD1fkcfmkwot7ga0Gkqx+C3ZF/
	 +uv8zET9hz0fLr/b9Hw4jhhbroBrEqtj9HDlqZhdhmUkfRWsbEDPbMM0IwcfcbdC5m
	 TnKEH6fG931dw8l+RlujMQsKF8uIw2vhHT7iJQVWN/69YDEIn44sWIE3nx9r9ZZ0dK
	 ZyrZaYVL0mSXCCRxwzGHW9fbaS/paBfpvjvfYkNCoisXBqMPKBZznWJb4yIyHUW+0s
	 o3NrD3DhFYj7Inn/cozQb1eKNStRTLvu3JlwfD44OK4ZppHbYev42RVMDaemcYfbx2
	 e/iw5EnKCT+aw==
Date: Fri, 8 Dec 2023 17:15:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, David
 Christensen <drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Paul
 Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 04/12] iavf: kill "legacy-rx" for good
Message-ID: <20231208171542.30699419@kernel.org>
In-Reply-To: <20231207172010.1441468-5-aleksander.lobakin@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
	<20231207172010.1441468-5-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 18:20:02 +0100 Alexander Lobakin wrote:
> Ever since build_skb() became stable, the old way with allocating an skb
> for storing the headers separately, which will be then copied manually,
> was slower, less flexible, and thus obsolete.

This one has a conflict on net-next :(
-- 
pw-bot: cr

