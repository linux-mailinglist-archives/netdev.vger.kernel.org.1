Return-Path: <netdev+bounces-14770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D613F743BE3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 14:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8501C20BC0
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BAB1FAA;
	Fri, 30 Jun 2023 12:30:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C4154A6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 12:30:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096D12728
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688128209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeZ8AOOh1eRMsfcuGIFSW+6gzuVyvDlV0vRUcrvvSlI=;
	b=BUySA9rQPmpR0iNftwpWNepe4fOpt5vg4MB8qmTvViVrCoqTvQQw3Ucd0tap+3pmQ2u6t6
	enapXZfJIlPm+AI5jcUH2s0HllTIrcLczHtpxyS1OKTxaefKLYrW7Qf9qQexUcSPCm0LuX
	s86yvQcVc3pj6m+7GSnDcYnsEZeD1PM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-US9JNQmuPOaT3nVDcqeo_g-1; Fri, 30 Jun 2023 08:30:00 -0400
X-MC-Unique: US9JNQmuPOaT3nVDcqeo_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5752F8022EF;
	Fri, 30 Jun 2023 12:30:00 +0000 (UTC)
Received: from localhost (unknown [10.22.33.248])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 343DEC00049;
	Fri, 30 Jun 2023 12:30:00 +0000 (UTC)
Date: Fri, 30 Jun 2023 08:29:58 -0400
From: Eric Garver <eric@garver.life>
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net-next 2/2] net: openvswitch: add drop action
Message-ID: <ZJ7Kxlrh3iRLKIib@egarver-thinkpadt14sgen1.remote.csb>
Mail-Followup-To: Eric Garver <eric@garver.life>,
	Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life>
 <ZJ6j5anO1CTzO0j4@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ6j5anO1CTzO0j4@corigine.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 11:47:04AM +0200, Simon Horman wrote:
> On Thu, Jun 29, 2023 at 04:30:05PM -0400, Eric Garver wrote:
> > This adds an explicit drop action. This is used by OVS to drop packets
> > for which it cannot determine what to do. An explicit action in the
> > kernel allows passing the reason _why_ the packet is being dropped. We
> > can then use perf tracing to match on the drop reason.
> > 
> > e.g. trace all OVS dropped skbs
> > 
> >  # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
> >  [..]
> >  106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
> >   location:0xffffffffc0d9b462, protocol: 2048, reason: 196610)
> > 
> > reason: 196610 --> 0x30002 (OVS_XLATE_RECURSION_TOO_DEEP)
> > 
> > Signed-off-by: Eric Garver <eric@garver.life>
> 
> ...
> 
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -32,6 +32,7 @@
> >  #include "vport.h"
> >  #include "flow_netlink.h"
> >  #include "openvswitch_trace.h"
> > +#include "drop.h"
> >  
> >  struct deferred_action {
> >  	struct sk_buff *skb;
> > @@ -1477,6 +1478,18 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >  				return dec_ttl_exception_handler(dp, skb,
> >  								 key, a);
> >  			break;
> > +
> > +		case OVS_ACTION_ATTR_DROP:
> > +			u32 reason = nla_get_u32(a);
> > +
> > +			reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
> > +					SKB_DROP_REASON_SUBSYS_SHIFT;
> > +
> > +			if (reason == OVS_XLATE_OK)
> > +				break;
> > +
> > +			kfree_skb_reason(skb, reason);
> > +			return 0;
> >  		}
> 
> Hi Eric,
> 
> thanks for your patches. This is an interesting new feature.
> 
> unfortunately clang-16 doesn't seem to like this very much.
> I think that it is due to the declaration of reason not
> being enclosed in a block - { }.
> 
>   net/openvswitch/actions.c:1483:4: error: expected expression
>                           u32 reason = nla_get_u32(a);
>                           ^
>   net/openvswitch/actions.c:1485:4: error: use of undeclared identifier 'reason'
>                           reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
>                           ^
>   net/openvswitch/actions.c:1488:8: error: use of undeclared identifier 'reason'
>                           if (reason == OVS_XLATE_OK)
>                               ^
>   net/openvswitch/actions.c:1491:26: error: use of undeclared identifier 'reason'
>                           kfree_skb_reason(skb, reason);
>                                                 ^
>   4 errors generated.
> 
> 
> net-next is currently closed.
> So please provide a v2 once it reposts, after 10th July.

oof. My bad. I'll fix the clang issue and post v2 in a couple weeks.

Thanks.
Eric.


