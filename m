Return-Path: <netdev+bounces-256787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MOHBzaEg2llowMAu9opvQ
	(envelope-from <netdev+bounces-256787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:39:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64799EB0A9
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C86301A708
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33D32E122;
	Wed,  4 Feb 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dznvGs0o"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469B3126CA;
	Wed,  4 Feb 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226622; cv=none; b=I+rKezR4Wq2ABiUhVzhncRxCK6T5Cw7w1IeZ0qQ+xRmzlQOlCZVNAyZ44PPIimdQ+dN1P6VCARwVF74rJ2m9t6InTShIvbBnQtspux+oCEgdipFY0eQMjhNrq2PqC7p06/WmbqzX6xvDbc5UXB+EQ/1rrtmv4HrkVtbgX5Urap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226622; c=relaxed/simple;
	bh=J2jhiLUXHNETK2K/WGWGWhQG5ZFzPf+8CA9bAvmEsLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5FCGsOYVocDCuMGNsf7R8l4VYHqD38d9DgLcHrgr2nkG+XgtI2qhzbS94e4NBu0vqIVEmL2o6d225vEOLMhDiv24Bynu7IAzfzOJztXyVA9/hXibdoNGi5LWb/eRwyvVc5E4b3MlN4fsN/wUNy5mE+vhwyujXJS+kG5FVLE+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dznvGs0o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QWG6XA1USI93n7EaNAxIq7oC93YNnSuGbppQJOFb4SY=; b=dznvGs0o7RqqFD9nveYtENGHB9
	Zo7ZZyh/oVQrjWAPJZ+rCnsaB4ojIFyE6tqsNmaf303yXiJ7llXXmV0qloWCwwd9NjQXea1opVAAe
	0k3AbdNS4P4LYzkRddhuTuv2rtmoyLkz70C82u6gQJtywZkdfBOHixhFK1GPbckGlnBy37ahfrsga
	T0qPKvExIjKaRiN15sMvcQZoKlZfBw3CJcAFn7zyjE7XVA1lRI/tOLpbwb67tbntJ8a9ArwrVgvS8
	/RdGtD+5f0dZ2MYVx8SrbgFrIlJb7KMzJF9Fo5dqABXftijUPXvpeUCHC530o1duiKUiZEdJOwSXQ
	ZB5pSELA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vngoD-00000008rOR-2BNf;
	Wed, 04 Feb 2026 17:36:57 +0000
Message-ID: <989c798c-c320-4cf3-9609-43dea5e5d478@infradead.org>
Date: Wed, 4 Feb 2026 09:36:56 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] mptcp: fix kdoc warnings
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
 <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-3-cb559fb6b50a@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-3-cb559fb6b50a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256787-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 64799EB0A9
X-Rspamd-Action: no action



On 2/4/26 8:57 AM, Matthieu Baerts (NGI0) wrote:
> The following warnings were visible:
> 
>   $ ./scripts/kernel-doc -Wall -none \
>         net/mptcp/ include/net/mptcp.h include/uapi/linux/mptcp*.h \
>         include/trace/events/mptcp.h
>   Warning: net/mptcp/token.c:108 No description found for return value of 'mptcp_token_new_request'
>   Warning: net/mptcp/token.c:151 No description found for return value of 'mptcp_token_new_connect'
>   Warning: net/mptcp/token.c:246 No description found for return value of 'mptcp_token_get_sock'
>   Warning: net/mptcp/token.c:298 No description found for return value of 'mptcp_token_iter_next'
>   Warning: net/mptcp/protocol.c:4431 No description found for return value of 'mptcp_splice_read'
>   Warning: include/uapi/linux/mptcp_pm.h:13 missing initial short description on line:
>    * enum mptcp_event_type
> 
> Address all of them: either by using the 'Return:' keyword, or by adding
> a missing initial short description.
> 
> The MPTCP CI will soon report issues with kdoc to avoid introducing new
> issues and being flagged by the Netdev CI.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/uapi/linux/mptcp_pm.h |  2 +-
>  net/mptcp/token.c             | 16 +++++++++-------
>  2 files changed, 10 insertions(+), 8 deletions(-)

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

