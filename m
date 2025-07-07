Return-Path: <netdev+bounces-204546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE2AFB191
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41C61AA1F3D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604AC28DEEE;
	Mon,  7 Jul 2025 10:47:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DA288CB2;
	Mon,  7 Jul 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885233; cv=none; b=Lj7Kml36Hp5VgxPhAyr/i0V5AyCIGPY7YBHxmqmSwOejpEYIyEpnU+X0QKHEQkqLahpCLyMXr9VvnrqbC5OzzD+zvF3uOCjFlcMM3bnRdbLVbVz6ijqCIQOBcyktHn8x5Pu3ZDr04TCFay06kEh+iZHOZjwubxPVJSfEoWo42po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885233; c=relaxed/simple;
	bh=AHW8Pu974MQbEtBUk7tWFfLCPbD4JU1hydUTWObK6Hk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=CRWMdOGXinThGMvm5Qc9tqIuDDIcDzjSMQRBr0G3gEkqLcow/ERiUiAHo2+5sDxSMaQ2GWb/kIrbKcQxZQi/w8ShM0ZxVFSUF/2fGUjq6eDqlVhrmIrE8Q+Ru1SK07g8r7bas8d/1pTe7Bc9Mvyr0aomnBqe8uhgclL5GQasuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bbLXJ1d95z4xPSj;
	Mon,  7 Jul 2025 18:46:56 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 567AkhB1004402;
	Mon, 7 Jul 2025 18:46:43 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 7 Jul 2025 18:46:45 +0800 (CST)
Date: Mon, 7 Jul 2025 18:46:45 +0800 (CST)
X-Zmail-TransId: 2afa686ba59535f-afcd3
X-Mailer: Zmail v1.0
Message-ID: <202507071846455418y7RHD-cnstxL3SlD6hBH@zte.com.cn>
In-Reply-To: <CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com>
References: 20250701174051880riwWtq_0siCJ5Yfsa6ZOQ@zte.com.cn,CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <edumazet@google.com>
Cc: <kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
        <davem@davemloft.net>, <horms@kernel.org>, <dsahern@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2Ml0gdGNwOiBleHRlbmQgdGNwX3JldHJhbnNtaXRfc2tiIHRyYWNlcG9pbnQgd2l0aCBmYWlsdXJlIHJlYXNvbnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 567AkhB1004402
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686BA5A0.000/4bbLXJ1d95z4xPSj

> >
> > -/*
> > - * tcp event with arguments sk and skb
> > - *
> > - * Note: this class requires a valid sk pointer; while skb pointer could
> > - *       be NULL.
> > - */
> > -DECLARE_EVENT_CLASS(tcp_event_sk_skb,
> > +#define TCP_RETRANSMIT_QUIT_REASON             \
> > +               ENUM(TCP_RETRANS_ERR_DEFAULT,           "retransmit terminate unexpectedly")    \
> > +               ENUM(TCP_RETRANS_SUCCESS,               "retransmit successfully")              \
> > +               ENUM(TCP_RETRANS_IN_HOST_QUEUE,         "packet still queued in driver")        \
> > +               ENUM(TCP_RETRANS_END_SEQ_ERROR,         "invalid end sequence")                 \
> > +               ENUM(TCP_RETRANS_TRIM_HEAD_NOMEM,       "trim head no memory")                  \
> > +               ENUM(TCP_RETRANS_UNCLONE_NOMEM,         "skb unclone keeptruesize no memory")   \
> > +               ENUM(TCP_RETRANS_FRAG_NOMEM,            "fragment no memory")                   \
> 
> Do we really need 3 + 1 different 'NOMEMORY' status ? 

Yes, different "NOMEM" status pinpoint exact failure stages in packet retransmission,
which helps distinguish which process triggered it. Beneficial for troubleshooting.

> > +               ENUM(TCP_RETRANS_ROUTE_FAIL,            "routing failure")                      \
> > +               ENUM(TCP_RETRANS_RCV_ZERO_WINDOW,       "closed recevier window")               \
> 
> receiver
> 

Thanks, will fix it in V3.

> > +               ENUMe(TCP_RETRANS_PSKB_COPY_NOBUFS,     "no buffer for skb copy")               \
> 
> -> another NOMEM...
> 
> > +
> > +
> 
> 
> > +               __entry->quit_reason = quit_reason;
> >         ),
> >
> > -       TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
> > +       TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s quit_reason=%s",
> 
> quit_reason is really weird, since most retransmits are a success.
> 
> What about using : status or result ?
> 
> Also, for scripts parsing the output, I would try to keep  key=val
> format (no space in @val), and concise 'vals'

Good idea. Will fix it in V3.

