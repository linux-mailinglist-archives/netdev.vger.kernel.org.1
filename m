Return-Path: <netdev+bounces-25833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AFB775F4E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554C11C212D7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC0318019;
	Wed,  9 Aug 2023 12:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89E8BE0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FEDC433C8;
	Wed,  9 Aug 2023 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691584704;
	bh=5emtXBVJ+4iD+QynUDJ3lWrTMpqIu0E9WneaYyIy1Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBiXwpjsn2s07zb6UjcA5ksO/9VLyOZjqS+TWgsrxGB4nJTAkN/fBdG4o3cRGMFlK
	 3Qf9eTGRAUGpoqJlU2vUKStOzUwxx/KSHzIE92mEkMlWSTLodJSNbn4OVDLaOOq9SB
	 6KnGMljsrZdHEdJnzBq3mcsQrAl8wUXpR2M8tkaKzERzZ0Mcuu0ptOfj02y7ZZ1bLR
	 IkiaxCJ7h5ehjgXa6bSEGKovvE8vSjU1sWaPa68ZCPIjC2uvI0LiJxua4P+2M+nyZX
	 f6kufdthXFU+NqCb0gJBs2Q8n8y85AWOOx0CV0ZJrJq9SKNSK4M0F4n9GDJ9yHfvIK
	 TAdRCIAOhz3SQ==
Date: Wed, 9 Aug 2023 14:38:20 +0200
From: Simon Horman <horms@kernel.org>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maciej.fijalkowski@intel.com, andrew@lunn.ch,
	piotr.raczynski@intel.com, netdev@vger.kernel.org,
	yangyingliang@huawei.com
Subject: Re: [PATCH] net: txgbe: Use pci_dev_id() to simplify the code
Message-ID: <ZNOIvOrWyT7ET2cO@vergenet.net>
References: <20230808024931.147048-1-wangxiongfeng2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808024931.147048-1-wangxiongfeng2@huawei.com>

On Tue, Aug 08, 2023 at 10:49:31AM +0800, Xiongfeng Wang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to

nit: mannually -> manually

checkpatch.pl --codespell is your friend here.


> simplify the code a little bit.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Otherwise this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

