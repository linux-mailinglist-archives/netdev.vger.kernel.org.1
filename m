Return-Path: <netdev+bounces-202357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD3AED88A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE11176DFE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AB23F41A;
	Mon, 30 Jun 2025 09:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445B23F27B;
	Mon, 30 Jun 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275308; cv=none; b=oy8IT2BijjCvpWW5o2p/ihmRzK/onQNnVDyaamUmlU+9US0KNirujU46auWIi2+QJfAillm8rLO/VE1iT8spWVbVtfnOafgBWlhp5PrAtF8rGyUoCwfJOvsBvDNOUlyASwgr42Z/OVlZ98eKMgU2Xuti941l2G669lm9vu4BaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275308; c=relaxed/simple;
	bh=0o5W8/0cAILHSI6HC3ZBYG/F978FraAhDVWatzRNlH0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=X8YCExNSqOXq3Ot5hWfPyq1anL01gp4uuVD2+ZA7Z5vsa+P9MHRQ3rsw5wTMd12C5nhR11lRiaM4XvxGO2/3eCISxdzbmb0rWzoeJ3FPscscPJt+YoB6+0qoh2+prPuz14d2J4EcmeU4QXTK8S5np0IZgM5df0HOK8vvviIYN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bW0z405gsz8RVF5;
	Mon, 30 Jun 2025 17:21:36 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 55U9LJaR085138;
	Mon, 30 Jun 2025 17:21:20 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 30 Jun 2025 17:21:22 +0800 (CST)
Date: Mon, 30 Jun 2025 17:21:22 +0800 (CST)
X-Zmail-TransId: 2afb6862571207f-b17d5
X-Mailer: Zmail v1.0
Message-ID: <202506301721223475hGdoPaiDtgihIpp82pZF@zte.com.cn>
In-Reply-To: <CANn89iK-6kT-ZUpNRMjPY9_TkQj-dLuKrDQtvO1140q4EUsjFg@mail.gmail.com>
References: 2025063016045077919B2mfJO_YO81tg6CKfHY@zte.com.cn,CANn89iK-6kT-ZUpNRMjPY9_TkQj-dLuKrDQtvO1140q4EUsjFg@mail.gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <edumazet@google.com>
Cc: <kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <fan.yu9@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dF0gdGNwOiBhZGQgcmV0cmFuc21pc3Npb24gcXVpdCByZWFzb25zIHRvIHRyYWNlcG9pbnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 55U9LJaR085138
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6862571F.004/4bW0z405gsz8RVF5

> >
> > From: Fan Yu <fan.yu9@zte.com.cn>
> >
> > Problem
> > =======
> > When TCP retransmits a packet due to missing ACKs, the retransmission
> > may fail for various reasons (e.g., packets stuck in driver queues,
> > sequence errors, or routing issues). Currently, these failure reasons
> > are internally handled in __tcp_retransmit_skb() but lack visibility to
> > userspace, which makes it difficult to diagnose retransmission failures in
> > production environments.
> >
> > Solution
> > =======
> > This patch adds a reason field to the tcp_retransmit_skb tracepoint,
> > enumerating with explicit failure cases:
> > TCP_RETRANS_IN_HOST_QUEUE          (packet still queued in driver)
> > TCP_RETRANS_END_SEQ_ERROR          (invalid end sequence)
> > TCP_RETRANS_TRIM_HEAD_NOMEM      (trim head no memory)
> > TCP_RETRANS_UNCLONE_NOMEM    (skb unclone keeptruesize no memory)
> > TCP_RETRANS_FRAG_NOMEM       (fragment no memory)
> > TCP_RETRANS_ROUTE_FAIL       (routing failure)
> > TCP_RETRANS_RCV_ZERO_WINDOW  (closed recevier window)
> > TCP_RETRANS_PSKB_COPY_NOBUFS (no buffer for skb copy)
> > TCP_RETRANS_QUIT_UNDEFINED   (quit reason undefined)
> 
> 'undefined' ?
> 

Oh, it's redundant indeed. Will remove it in v2.


> >
> > Impact
> > ======
> > 1. Enables BPF programs to filter retransmission failures by reason.
> > 2. Allows precise failure rate monitoring via ftrace.
> >
> > Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> > Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> > Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> 
> Problem is that this patch breaks the original trace point, without
> any mention of the potential consequences in the changelog ?
> 

Huhh, indeed. Will add a part description of the potential consequences in v2.

Thanks for reviews.

> commit e086101b150ae8e99e54ab26101ef3835fa9f48d
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Fri Oct 13 13:03:16 2017 -0700
> 
>     tcp: add a tracepoint for tcp retransmission

