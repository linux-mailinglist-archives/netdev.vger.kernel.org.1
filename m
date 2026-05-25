Return-Path: <netdev+bounces-291227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIS2GuCpE2ptEgcAu9opvQ
	(envelope-from <netdev+bounces-291227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C05385C5429
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B8330075D3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217A26738D;
	Mon, 25 May 2026 01:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4C126BF7
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673504; cv=none; b=UuKUw4esy7m/hOeBaAb4/nBN//CPbkD9eG6Pliq/ER6/+TBuWM0ns8JkpWUwiWyYVZN3bJnycoNDlQ4Bk6sNXchF8+l41qan/qMy5iO1b//x5WUMnF4gb5d+Xrx8W33xEpM9mFWMQitIAr06NMpKOMuEX3mLKnGblROH9Gsh5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673504; c=relaxed/simple;
	bh=+14eTZ8VtyJzdfNVQswtJHX1DXqu3K/lj0s2rSOHQIU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZF4yyXohvVT4zqu36cbuT/jyucw6wFlSwbXvPri7KLQEGQ6G19IyhJeEowVOew4EqSw7COzlASYaGgJRiSVZmaDzrUaOKyH8D6ovMS9pzS6Znbslt7o61pHeeFHD9LYZikQzmzYyDSOPqkoaLCxdAiQB4rbxuY8riqSVMS8jAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1779673444t764t03035
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.246.224])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3582909503640721870
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<jacob.e.keller@intel.com>
References: <20260519080048.7448-2-jiawenwu@trustnetic.com> <20260522073415.2032087-1-horms@kernel.org>
In-Reply-To: <20260522073415.2032087-1-horms@kernel.org>
Subject: RE: [PATCH net-next v1 1/3] net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
Date: Mon, 25 May 2026 09:44:03 +0800
Message-ID: <03b201dcebe7$f79804a0$e6c80de0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLkRPU2ZnUlM+SD3AwLFGPPdddf0gK8Y8Ecs/lid6A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MeFNLUIt+GJ0POwXfNXa518ilf5hqaRPGyjGuvU3Ce0L7jx3JyNhwiWx
	oOhor96mdldrJpK2unFCKefumShzR5lsENbaIRoVAC6+kr/DubTBUbkBPLoJRaK0tqcLBMo
	G2basnM5w7JlPsIrEh0U4NeNkNbzxo907kHKPUHGGqmxMCdl6D9fckQAeMEXPBtp6OnYu5p
	MErOT6AhCJpnUG1SgY7PxHYX6YQiQ+CTE0LKGDYWqz4ZqLQDb0kPAxSikqzlMuL5Kts+BnV
	tblkvqt8NJjhikxCfFZUUrXn4UZhh3i6HdXp25boZJpYwC4mv4PWhwKlHrSEJF2yieoZmZr
	tPI32EtmHG7QxJ3UxKThFs9Y/M3sFB7ggR89qy3gqbcmZgQskjFYNhJ2SH+Q4VzD/OteQpk
	jdt29q6PnqTVgnmeHZtUoAJnFQtHidI9fmZTjKIAs7zmc3Qdlq6oN65wJYqzDJYLmVfqhGd
	NfcrGZYE8iJH6rDRanNPU124LcjsCRxIHnX7zKjigFkkWu4dvHl86Fi7ecIctw2CqCCp+ft
	I7LHufuiiLjYTwviLySfcPwqglRmjM2PS+JifmVfMug6SicCYSEbOczZ2zY4bkzJaOHx2Ml
	WhPkPxwOMEdkqM5FuD9yzlNURHqlMsOa11D6GwfbBwtsIe1BaATUVBZaU/GGXNDs283tYlf
	SMuitXfRS+jqLPShGQ1GtiXEiGpLAvDuNFkxN0tnqqpUyIGXwt3mLIt/h6BZeTRmAxkdVky
	wwuZuHLgOSQj5P3WHUthfm6GbNVFdl9rAMIPw95pLIXI6bYI5dX+8BWUkwgj+QxzKmhQNG8
	HFVTRi3PdicjGz6hvUnyIRjqEW+TW0YcLefI4YmJLVMJQ5DQZRCzmF2ZPnVW/m+/Zgd+x6l
	SH0FT06ALtETVZ1FqmQGutM8bH1Nj1yV4GIrEoMvWEA1KCmtL7sGyS3pRtvO4mv4BRfTa2V
	1tLoAJh8xrAUpCMBWLSstSlTgcTu+pwlQyjkCAYh0neXGrMgL06fTwZfcFOPfBsvHag+8sl
	gWKGueaQxdDurSoYGnbYSLAV0eoW/pnRxDIueZmfZjG1z7/yTE8NlE5J9DZxTlK1XWeUUbE
	YJdzYz3+8aU
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.971];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:mid]
X-Rspamd-Queue-Id: C05385C5429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 3:34 PM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
> 
> Replace various netif_running() checks with an explicit WX_STATE_DOWN
> state bit to track whether the device datapath and interrupt handling
> are operational.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index 746623fa59b40..69fe197376796 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> [ ... ]
> > @@ -3314,7 +3316,8 @@ EXPORT_SYMBOL(wx_set_ring);
> >
> >  void wx_service_event_schedule(struct wx *wx)
> >  {
> > -	if (!test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
> > +	if (!test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state) &&
> > +	    !test_bit(WX_STATE_DOWN, wx->state))
> >  		queue_work(system_power_efficient_wq, &wx->service_task);
> >  }
> 
> Can this leak the WX_STATE_SERVICE_SCHED bit when the device is down?
> 
> If WX_STATE_DOWN is set, test_and_set_bit() executes first and sets
> WX_STATE_SERVICE_SCHED, but the second condition evaluates to false.
> This skips queue_work(), meaning the service task is never queued.
> 
> Because the task does not execute, WX_STATE_SERVICE_SCHED is never cleared.
> When the device is brought back up, subsequent calls to
> wx_service_event_schedule() might always fail the test_and_set_bit() check,
> permanently disabling the service task.
> 
> Should the conditions be reversed to check WX_STATE_DOWN before setting the
> service schedule bit?
> 

I'll fix it in V2.



