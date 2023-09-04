Return-Path: <netdev+bounces-31895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F9791409
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8337D280F70
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19EB1384;
	Mon,  4 Sep 2023 08:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58607E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:55:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A50131
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693817702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0+D9s0B3rEwkJlC1rPYXTBqDO2niCy+wJy2STYhsXw=;
	b=RUuCDZtZQ7ySCBlLvHORUFYFqnD9dLjcJ1dZm9wUelHHjcEBBiOwS0o4LwYuoua6hEO2jf
	DBzJvXLc/l30Le1dJ34k5uhpShb5JeuW7WpLGRXk1u0HgZPQ16kN71guzsd/xJOgjloo9b
	ZJHpx0c9NFW9swH8U9XLUiZV91ETtK0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-3tiz3aioOPOQn5H7Mxq0Ug-1; Mon, 04 Sep 2023 04:54:57 -0400
X-MC-Unique: 3tiz3aioOPOQn5H7Mxq0Ug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FD663811F25;
	Mon,  4 Sep 2023 08:54:57 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.40])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D372493114;
	Mon,  4 Sep 2023 08:54:57 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A576AA806F3; Mon,  4 Sep 2023 10:54:55 +0200 (CEST)
Date: Mon, 4 Sep 2023 10:54:55 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] igb: disable virtualization features on 82580
Message-ID: <ZPWbXzc+deQolIrR@calimero.vinschen.de>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20230831121914.660875-1-vinschen@redhat.com>
 <169374675330.16952.10821656752298867430.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169374675330.16952.10821656752298867430.git-patchwork-notify@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sep  3 13:12, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Thu, 31 Aug 2023 14:19:13 +0200 you wrote:
> > Disable virtualization features on 82580 just as on i210/i211.
> > This avoids that virt functions are acidentally called on 82850.
> > 
> > Fixes: 55cac248caa4 ("igb: Add full support for 82580 devices")
> > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Here is the summary with links:
>   - [v2,net] igb: disable virtualization features on 82580
>     https://git.kernel.org/netdev/net/c/fa09bc40b21a

Thank you!  Will my first patch

  igb: clean up in all error paths when enabling SR-IOV

https://lore.kernel.org/netdev/20230824091603.3188249-1-vinschen@redhat.com/

get applied as well?  While I reproduced this on 82580 only, there might
be some other reason why pci_enable_sriov() fails, independent of the
actual NIC.


Thanks,
Corinna


