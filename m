Return-Path: <netdev+bounces-26521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E658777FEC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012931C21175
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8AE21D21;
	Thu, 10 Aug 2023 18:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5121512
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:05:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E624D8E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691690727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmR7efEMDfdlROeOWqAlO64siQonsEXKEMGYYhMABqo=;
	b=NGwYsEKknmpwjWttDDnXSuIUXXRMnwyr6C7/dwVu5+qE3/S0+Xs7GFUnrhcuQdoDQxEIJT
	a8axW082mLw4TYk/3ZJ/CPVTSsp4MJTHcx7HHviJRPq/8Ulcy7zc5QPgaqRqAr9mwrEWK8
	aaqLCFdSbOB65WBs/KBkHDjPTjPBKfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-HiDaTBcEOZmjQMYlhIcTDA-1; Thu, 10 Aug 2023 14:05:25 -0400
X-MC-Unique: HiDaTBcEOZmjQMYlhIcTDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADC18101A528;
	Thu, 10 Aug 2023 18:05:24 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A1DF2166B25;
	Thu, 10 Aug 2023 18:05:24 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  i.maximets@ovn.org,  eric@garver.life,
  dev@openvswitch.org
Subject: Re: [net-next v4 7/7] selftests: openvswitch: add explicit drop
 testcase
References: <20230809153833.2363265-1-amorenoz@redhat.com>
	<20230809153833.2363265-8-amorenoz@redhat.com>
Date: Thu, 10 Aug 2023 14:05:23 -0400
In-Reply-To: <20230809153833.2363265-8-amorenoz@redhat.com> (Adrian Moreno's
	message of "Wed, 9 Aug 2023 17:38:27 +0200")
Message-ID: <f7tjzu222os.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adrian Moreno <amorenoz@redhat.com> writes:

> Test explicit drops generate the right drop reason. Also, verify that
> the kernel rejects flows with actions following an explicit drop.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


