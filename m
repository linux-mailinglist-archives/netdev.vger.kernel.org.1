Return-Path: <netdev+bounces-284761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JQ5FEkF+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B94D85C2
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B381302800A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630C39448F;
	Wed,  6 May 2026 09:06:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380E328243
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058369; cv=none; b=CrlejWJIcZd8KXn0HZNspVQ2YhPylt8RitfTRuqFe3docj5/7I0G4HAAdePgefc+2gPB6h4u0jmTby9dFYXKJyFEJQIc2E8Z9n53eTOAAdz8R5BA0p0NDBdEt1XeX7iuXbDQdlFmraNDCD3zM5Frc1sEHeDTx5gK90h68exa11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058369; c=relaxed/simple;
	bh=XbRuN6PNXOwcdw6LZsErcTppiiguuPEgAsUFiSfaEwA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdCQS6si6Pjs/zV6SD/DxJTpfSwwxQyt89Wkglx3tY1/AT4oeIODicGWI428GUbtknpJvKAjHXw9HmshmIzPkYKivvBuzajRxIWU4IInk0gpOmzFiTJZnHwRNR+RTG8ZMYgoi3aPCYy9+Xent0CszDc44FrvLfRg4Pa70BhS55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1778058331t817t01902
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.244.4])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1360027347392152451
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>,
	<joe@dama.to>,
	<jacob.e.keller@intel.com>,
	<fabio.baltieri@gmail.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>,
	<joe@dama.to>,
	<jacob.e.keller@intel.com>,
	<fabio.baltieri@gmail.com>
References: <20260430082517.19612-2-jiawenwu@trustnetic.com> <20260503021529.4127250-1-kuba@kernel.org>
In-Reply-To: <20260503021529.4127250-1-kuba@kernel.org>
Subject: RE: [PATCH net-next v2 1/6] net: ngbe: implement libwx reset ops
Date: Wed, 6 May 2026 17:05:30 +0800
Message-ID: <051c01dcdd37$7d3cf940$77b6ebc0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLO64Xb/xrrlI322E3lowBCbGiCtQKGkvjZtAhe8xA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYzMHWjxYhxlGsqEitUhjkWn8x61vH+Zzc6c1I7PJCTd0OmPIHB1MGkG
	97bFg5qSTf6SLCCmKymUTEcQ/HvKRJ8T24sxBUd0UA9YIsH0HDDW0mRlnF/mV2VYOUO8FDW
	1aiIOLVvIP5zcJ5pfOJ4igWGOR0jlNPGsYjo3wAgApujIZypnqIT+d+BeHAxznCT8g7j6fj
	tLEuoI1h9GHF28eUbtrFU/4TtQdMXvzVrcUs9kbeuRzvSKfCXvwZ/nWaI0q/vUY7XZ8U4OD
	60+B0gIpp1kQiqJ1n4R+x9PwsWffgWw/JQh+7b2NH/OXrAVOO+mw6uWftMWo0zKsU+MuLa8
	0yWpI/oTW6/W/EB6b1tEXNAna0h+4Ra5zwytStGYjiVn//h7uysx99gaPNU19Wl1kA08Rs6
	NBfPGRRKPXGxHicUz6vDIrG/1KZdp6uCnuPkVZdVwkPVw0I7e8P3YM7amaQjgeodSoacepe
	UCuc8Y3T1qvISQQFt6hRpzCyq3limHSmdvETQNThIdwLAjUEmrKV8qaUyDyC23Urapzqa3x
	qOwuEPJZpE7YB/cgHUtZRMF3mGk58qx+nxGqqXOxF0R+nodP03QpZ2nDUrsYkXGiJZOwtYR
	IKrQA7Vr8ni2G2GDJAshu/uxEfzAi2vNSuG7AiGiYhg24qNIU5rBQVfZEZTFyv3IU5v+Awg
	5hKE152iWbAnbozwh+cwvyhQbMmvMbwuWb14ek0rq4YtRuePo0ul+ushG4TsYLGUAB13R2t
	z2AjiT3T1D3FS+RzIexsEdgIoAKHeVXKZkBahpvw5j6VIAnHbzaZcjoLw/3t8dDzpSvl67g
	AnqfOKaDYjFs8QE2n+ByJogiROeYwJ4qG3vWE7nuoFx8Y6IZqvDdNshFpcVYKCrfjPw/dqy
	1r/AStsc1wxGlUkh9xhOD7KLsLy6Uam7aQhlQJhmR1dXJRy9fPQ3uKbFG/CYohnTcwUov5r
	Pn6cKWz6pU8yOj5S8YAEYse0DAwVKK70eYWzrN+5KJZs17MGLqrTfG1H4wOOq1ck4OAWIXE
	G5mOQxopF8yJDlILBzZbPR+rDFQbGUF7NaEH6WE3IS3AqBmrjQl7XC4nUnXZUN4RyF+abB5
	7i3V15XaRhUqK4E069NnUQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 7B2B94D85C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284761-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,intel.com,debian.org,dama.to];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid]

On Sun, May 3, 2026 10:15 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: ngbe: implement libwx reset ops
> 
> This commit implements the wx->do_reset() operation for the ngbe driver,
> allowing the library module to trigger a reset by bringing the interface
> down and back up.
> 
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index d8e3827a8b1f2..bd905e2675758 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> 
> [ ... ]
> 
> > +static void ngbe_reinit_locked(struct wx *wx)
> > +{
> > +	netif_trans_update(wx->netdev);
> > +
> > +	mutex_lock(&wx->reset_lock);
> > +	set_bit(WX_STATE_RESETTING, wx->state);
> > +
> > +	ngbe_down(wx);
> > +	ngbe_up(wx);
> > +
> > +	clear_bit(WX_STATE_RESETTING, wx->state);
> 
> Does this introduce a regression by using WX_STATE_RESETTING as an ad-hoc
> lock here?
> 
> While this pattern appears to exist elsewhere in the driver, adding it
> to ngbe_reinit_locked() relies on a design where background readers might
> check test_bit(WX_STATE_RESETTING, wx->state) without holding reset_lock.
> 
> Since the flag check and subsequent accesses are not atomic, a reader could
> test the flag just before it is set and then proceed to access shared state
> concurrently with the ngbe_down() and ngbe_up() teardown path.
> 
> Could this result in torn or corrupted reads, and would it be safer to use a
> proper synchronization mechanism like RCU or a shared lock for readers?

I think we have come up with a good way to deal with this in the previous
discussion:
https://lore.kernel.org/all/990c010b-f716-499d-b3ca-e8296003c37e@intel.com

Currently, only wx_update_stats() in watchdog that needs to test bit
WX_STATE_RESETTING, because the hardware statistics cannot be counted at the
reset time. Even if wx_update_stats() test the flag before ngbe_reinit_locked()
set it, the work task will be canceled before the reset.

> 
> > +	mutex_unlock(&wx->reset_lock);
> > +}
> > +
> > +void ngbe_do_reset(struct net_device *netdev)
> 
> [ ... ]
> 


