Return-Path: <netdev+bounces-25371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D1773CF5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA55B280199
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84315AF4;
	Tue,  8 Aug 2023 15:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371111C99
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:56:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B116BD2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691510106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgaQEXtbREdc5BT0FBFMZnSeJR9zvumt3idhcLioagA=;
	b=GGwIGG4lRLzQ7H8jGBWj1BxUyBhQq7AFFms6Wu0X7jVCnOv7uIFUI2XqtfwLuFfHgUgaIX
	5mNmOutRnPhqPq4lH6QZd27pSNt6mdiLiS7GBTCB8KdzDS6cVTrrpkOHTKt4IJqcDI+5OS
	/hRRYxXmzvS/X9JV+4g8erjGHP3w/rc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-habB5WOTPHiKcB15HrA1zg-1; Tue, 08 Aug 2023 10:53:52 -0400
X-MC-Unique: habB5WOTPHiKcB15HrA1zg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6445B3C025C0;
	Tue,  8 Aug 2023 14:53:52 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.8.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 297F7C15BAE;
	Tue,  8 Aug 2023 14:53:52 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  i.maximets@ovn.org,  eric@garver.life,
  dev@openvswitch.org
Subject: Re: [net-next v3 4/7] net: openvswitch: add meter drop reason
References: <20230807164551.553365-1-amorenoz@redhat.com>
	<20230807164551.553365-5-amorenoz@redhat.com>
Date: Tue, 08 Aug 2023 10:53:51 -0400
In-Reply-To: <20230807164551.553365-5-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 7 Aug 2023 18:45:45 +0200")
Message-ID: <f7ta5v14mbk.fsf@redhat.com>
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

Adrian Moreno <amorenoz@redhat.com> writes:

> By using an independent drop reason it makes it easy to ditinguish

nit: distinguish

> between QoS-triggered or flow-triggered drop.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

>  net/openvswitch/actions.c | 2 +-
>  net/openvswitch/drop.h    | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 285b1243b94f..e204c7eee8ef 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -1454,7 +1454,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  
>  		case OVS_ACTION_ATTR_METER:
>  			if (ovs_meter_execute(dp, skb, key, nla_get_u32(a))) {
> -				consume_skb(skb);
> +				kfree_skb_reason(skb, OVS_DROP_METER);
>  				return 0;
>  			}
>  			break;
> diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
> index be51ff5039fb..1ba866c408e5 100644
> --- a/net/openvswitch/drop.h
> +++ b/net/openvswitch/drop.h
> @@ -12,6 +12,7 @@
>  	R(OVS_DROP_ACTION_ERROR)		\
>  	R(OVS_DROP_EXPLICIT_ACTION)		\
>  	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
> +	R(OVS_DROP_METER)			\
>  	/* deliberate comment for trailing \ */
>  
>  enum ovs_drop_reason {


