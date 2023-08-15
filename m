Return-Path: <netdev+bounces-27678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C877CCE7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46EF1C20D2D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE06111BA;
	Tue, 15 Aug 2023 12:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9148832
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:49:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A3E5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692103754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+l55HTddVYwEg/eLFK4VwzVELui+1PXrZDBowROvDQ=;
	b=DVwnvMIQx+17uc8xJdYWpMkU1i/ixa8uxqyBK7p4JpiNhZK+6F0cHLfYOZvrga/Lf35f/L
	hlWwO+6CUsPuiB48ANALzoPzIa2X3xLYvrcGEqfL5cD+JZ8zW975UfkZla0YBaEkekyO+5
	iTGrPlbU9ww4d2jWuoOSgPqcHC1GbLE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-ll15gl-GO-y5SNsQYGgXKQ-1; Tue, 15 Aug 2023 08:49:11 -0400
X-MC-Unique: ll15gl-GO-y5SNsQYGgXKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D42F1C07588;
	Tue, 15 Aug 2023 12:49:10 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.9.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F70C15BAD;
	Tue, 15 Aug 2023 12:49:09 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  axboe@kernel.dk,  linux-block@vger.kernel.org,
  jiri@resnulli.us,  netdev@vger.kernel.org,  dev@openvswitch.org,
  philipp.reisner@linbit.com,  jmaloy@redhat.com,
  christoph.boehmwalder@linbit.com,  edumazet@google.com,
  tipc-discussion@lists.sourceforge.net,  Jiri Pirko <jiri@nvidia.com>,
  ying.xue@windriver.com,  johannes@sipsolutions.net,  pabeni@redhat.com,
  drbd-dev@lists.linbit.com,  lars.ellenberg@linbit.com,
  jacob.e.keller@intel.com
Subject: Re: [ovs-dev] [PATCH net-next v3 03/10] genetlink: remove userhdr
 from struct genl_info
References: <20230814214723.2924989-1-kuba@kernel.org>
	<20230814214723.2924989-4-kuba@kernel.org>
Date: Tue, 15 Aug 2023 08:49:08 -0400
In-Reply-To: <20230814214723.2924989-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Aug 2023 14:47:16 -0700")
Message-ID: <f7twmxwxygr.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Only three families use info->userhdr today and going forward
> we discourage using fixed headers in new families.
> So having the pointer to user header in struct genl_info
> is an overkill. Compute the header pointer at runtime.
>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Seems the OVS side didn't change from v2 so still:

Reviewed-by: Aaron Conole <aconole@redhat.com>


