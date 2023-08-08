Return-Path: <netdev+bounces-25391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B321773D8C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E31C209C9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED714013;
	Tue,  8 Aug 2023 16:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC93C37
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:13:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E21B21795
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691511138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BphEeYtOV9zgeEWNjAAPnJqug/4oD91+40xoocDsTI=;
	b=Af60RimPXaOBybsghK/WP19uy+SrOqnWtfSo2YIXJkFYxpm4qafOajrSr0WiYrHi3mBzjL
	A8Y8dobggIXlYq1e17Gf0Cr9ZQDCDIuhezhpKsyQ/POj99YicqKw0RO8osJpeAbg/oVibo
	AoUp1GoFLuJfoD8DlXozF++sE7ilXKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-g3UWjClnNt-URn9JkPDfsg-1; Tue, 08 Aug 2023 11:04:51 -0400
X-MC-Unique: g3UWjClnNt-URn9JkPDfsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3AB4101A52E;
	Tue,  8 Aug 2023 15:04:50 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.8.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B449F1121314;
	Tue,  8 Aug 2023 15:04:50 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  i.maximets@ovn.org,  eric@garver.life,
  dev@openvswitch.org
Subject: Re: [net-next v3 6/7] selftests: openvswitch: add drop reason testcase
References: <20230807164551.553365-1-amorenoz@redhat.com>
	<20230807164551.553365-7-amorenoz@redhat.com>
Date: Tue, 08 Aug 2023 11:04:50 -0400
In-Reply-To: <20230807164551.553365-7-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 7 Aug 2023 18:45:47 +0200")
Message-ID: <f7tttt9378t.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adrian Moreno <amorenoz@redhat.com> writes:

> Test if the correct drop reason is reported when OVS drops a packet due
> to an explicit flow.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


