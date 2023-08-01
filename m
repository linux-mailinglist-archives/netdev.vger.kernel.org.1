Return-Path: <netdev+bounces-23057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D6C76A89A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E35E1C20DCC
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F38046B7;
	Tue,  1 Aug 2023 06:02:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51C4A0E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178E1C433C8;
	Tue,  1 Aug 2023 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690869726;
	bh=JiTXGLYJWPJsg2TfI3p8egkq8itI6r7RrUkb+0gpOKQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=m+rxfq4V/I0DfPvvwO/NW44g6r3HcAX81KglDqByLhm/0nfB6A8Jj54OQrHE6vJKl
	 7KZOSe1AkHmbGGlvCzaQbyuchARp7aRcRQUBedNk/f38I3NyHg9N1pBd6D+iO0MvSy
	 okOWvNZn9PNdqCjNEXHTPiI/hLJZmlgKDS3TqhRDzyDD3K/dAnUiTDcmWl0fnrmgrc
	 EieY1XAhzOMUUxfsL7kHW0WuJili3BeHnTaYscztcp2JY9nxj2vqATJ3NC3ZxTm8DG
	 z17YW0Fv4u+KGq4U/yYlVD6b9SbO5x4QYEAzIHEHF0ofddGndIEfT0ZaW7xdMQk2uU
	 GgisnK/0dXEtQ==
From: Kalle Valo <kvalo@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <johannes@sipsolutions.net>,  <davem@davemloft.net>,
  <edumazet@google.com>,  <kuba@kernel.org>,  <pabeni@redhat.com>,
  <nbd@nbd.name>,  <pagadala.yesu.anjaneyulu@intel.com>,
  <linux-wireless@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mac80211: mesh: Remove unused function declaration
 mesh_ids_set_default()
References: <20230731140712.1204-1-yuehaibing@huawei.com>
Date: Tue, 01 Aug 2023 09:02:22 +0300
In-Reply-To: <20230731140712.1204-1-yuehaibing@huawei.com> (Yue Haibing's
	message of "Mon, 31 Jul 2023 22:07:12 +0800")
Message-ID: <87jzufz4ep.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yue Haibing <yuehaibing@huawei.com> writes:

> Commit ccf80ddfe492 ("mac80211: mesh function and data structures definitions")
> introducted this but never implemented.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/mac80211/mesh.h | 1 -
>  1 file changed, 1 deletion(-)

The title should have "wifi:" but no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

