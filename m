Return-Path: <netdev+bounces-27705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81F77CECA
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CC028133E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D41426C;
	Tue, 15 Aug 2023 15:14:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391811097E
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6450DC433C7;
	Tue, 15 Aug 2023 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692112469;
	bh=IzNwg4CCiiXIeHaRgVo+rMcufOaTDrxQF84slft88c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZVDGF95gT3XgkvMortxqlPKycWU/tqCecCZWMWBozMUUIe7MJpCPJ5FzINRNe3kK
	 S8Zb0BlkIyU4i28Uf4oWsShtVGgEvvjAiqYUjjGGT1tEs0WBRML92De6umBQn3o2UX
	 7TkZafajcamBg4RVfsf10BGAFrhOca1/wWzqHFe0=
Date: Tue, 15 Aug 2023 17:14:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: kernel@openeuler.org, duanzi@zju.edu.cn, yuehaibing@huawei.com,
	weiyongjun1@huawei.com, liujian56@huawei.com,
	Laszlo Ersek <lersek@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pietro Borrello <borrello@diag.uniroma1.it>, netdev@vger.kernel.org,
	stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH OLK-5.10 v2 1/2] net: tun_chr_open(): set sk_uid from
 current_fsuid()
Message-ID: <2023081559-excursion-passion-07a3@gregkh>
References: <20230815135602.1014881-1-dongchenchen2@huawei.com>
 <20230815135602.1014881-2-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815135602.1014881-2-dongchenchen2@huawei.com>

On Tue, Aug 15, 2023 at 09:56:01PM +0800, Dong Chenchen wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> stable inclusion
> from stable-v5.10.189
> commit 5ea23f1cb67e4468db7ff651627892c9217fec24
> category: bugfix
> bugzilla: 189104, https://gitee.com/src-openeuler/kernel/issues/I7QXHX
> CVE: CVE-2023-4194
> 
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=5ea23f1cb67e4468db7ff651627892c9217fec24

Why are you not just merging directly from the LTS branches into your
tree?  If you attempt to "cherry-pick" patches like this, you WILL miss
valid bugfixes.

thanks,

greg k-h

