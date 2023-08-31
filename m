Return-Path: <netdev+bounces-31569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E643978ECEF
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3D71C20A78
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A8111BE;
	Thu, 31 Aug 2023 12:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC08F74
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:19:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DF1A6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693484355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r44FJHyZKkNNi8TCBVOpCbHH7Y9gKQJrc4FVZ3OS63U=;
	b=bnjqqUfazCrJZE1bOGxI7UbXquTdcPSiZEiGh0HjN9c7l0S1iikpN2Ite8pMe56O6+3/4I
	MIgqhySDtIo8hEK8m0xD6K3fYrPIlLnsDLK223E1fqVK002MkVkrjc7pzNq+Dc1yppWX5x
	URFRwHqP1yplAQF3ORrQzhG5HRyvZro=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-Bj2w-xHqPXCqCoMoAT5uXw-1; Thu, 31 Aug 2023 08:19:10 -0400
X-MC-Unique: Bj2w-xHqPXCqCoMoAT5uXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EC3E1C07590;
	Thu, 31 Aug 2023 12:19:10 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CD95D2166B25;
	Thu, 31 Aug 2023 12:19:09 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 798BBA81EA3; Thu, 31 Aug 2023 14:19:08 +0200 (CEST)
Date: Thu, 31 Aug 2023 14:19:08 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, jesse.brandeburg@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH] igb: disable virtualization features on 82580
Message-ID: <ZPCFPBOPchpKUEyl@calimero.vinschen.de>
Mail-Followup-To: Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
References: <20230831080916.588043-1-vinschen@redhat.com>
 <b2dcff0db691a9b358c4f89cf7a5b65a5a7dc4c5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2dcff0db691a9b358c4f89cf7a5b65a5a7dc4c5.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paolo,

On Aug 31 13:41, Paolo Abeni wrote:
> On Thu, 2023-08-31 at 10:09 +0200, Corinna Vinschen wrote:
> > Disable virtualization features on 82580 just as on i210/i211.
> > This avoids that virt functions are acidentally called on 82850.
> > 
> > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> 
> This looks like a fix to me?!? if so a suitable 'Fixes' tag should be
> included.

I tried, but failed to come up with one.  When 82580 was introduced, the
conditional in question didn't exist at all and the igb_probe_vfs
function looked pretty different.  When i210 was introduced, the
conditional was created the first time.  So I was a bit puzzled if this
fixes the patch introducing 82580, or if it fixes the introduction of
the conditional, or if it's just kind of "new functionality".

Your mail got me thinking again, and I'm going to send a v2, blaming the
patch introducing 52580. It failed to guard igb_probe_vfs correctly.
When i210 was introduced, a matching conditional should have already
existed.


Thanks,
Corinna


