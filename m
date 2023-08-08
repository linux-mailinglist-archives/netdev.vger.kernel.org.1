Return-Path: <netdev+bounces-25433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7F773F32
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C801C28107A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72BF14F81;
	Tue,  8 Aug 2023 16:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00E1B7F3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:41:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9313CD12
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691512875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWRdZahFUET1lQAvtSxacCSmpRGTS4hm/2XK3/6b3Gk=;
	b=HuYklpdRZYFC27tG4nToYwEsUTP4l+06DW/6lwTykPYrUtUA0cKzFtdp/EVuqXN0sYI0ic
	ySqVgKW5H4Ejkv0rxIS4poEw7JIH/fEo4Cu0amSWqQUnWinsUH67V7TRsD0boJTq5WvwUC
	/adpmpdfsnVvZNLxjSrTpf9re8KVLE0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689-jtD4iQeaOIuNmzchnUJXtA-1; Tue, 08 Aug 2023 10:36:46 -0400
X-MC-Unique: jtD4iQeaOIuNmzchnUJXtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCE5C2932484;
	Tue,  8 Aug 2023 14:36:45 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.8.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A61140E962;
	Tue,  8 Aug 2023 14:36:44 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  i.maximets@ovn.org,  eric@garver.life,
  dev@openvswitch.org
Subject: Re: [net-next v3 1/7] net: openvswitch: add datapath flow drop reason
References: <20230807164551.553365-1-amorenoz@redhat.com>
	<20230807164551.553365-2-amorenoz@redhat.com>
Date: Tue, 08 Aug 2023 10:36:44 -0400
In-Reply-To: <20230807164551.553365-2-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 7 Aug 2023 18:45:42 +0200")
Message-ID: <f7tjzu54n43.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adrian Moreno <amorenoz@redhat.com> writes:

> Create a new drop reason subsystem for openvswitch and add the first
> drop reason to represent flow drops.
>
> A flow drop happens when a flow has an empty action-set or there is no
> action that consumes the packet (output, userspace, recirc, etc).
>
> Implementation-wise, most of these skb-consuming actions already call
> "consume_skb" internally and return directly from within the
> do_execute_actions() loop so with minimal changes we can assume that
> any skb that exits the loop normally is a packet drop.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


