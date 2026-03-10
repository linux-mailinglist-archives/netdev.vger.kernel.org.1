Return-Path: <netdev+bounces-265893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHY3Ctiwr2nrbgIAu9opvQ
	(envelope-from <netdev+bounces-265893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 06:49:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE5245847
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 06:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF9C2302A9E4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 05:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA491DF970;
	Tue, 10 Mar 2026 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tXC2RbA5"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB9F4FA;
	Tue, 10 Mar 2026 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121749; cv=none; b=iIEMLwghc9DgIBxFve426h/oaf+HE0/mR3GvCBafEmOlqVFKY981fqFRwLOcZg5KXMkUt7iZWZbjPf/Q4JdG2rLA+1Ec0SihAxU7+iWkkAXLmaAve18hiKDCPxGYB26mE3B8wk1lopkLSrByBaOJlcMxJUk29Js+RSJNMAKIajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121749; c=relaxed/simple;
	bh=inTJ4RiT66cwtILyiP+TRzObVIOKVcmZTSglIFd+BPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCOs40r6pCHo+FTD6kWblOmtwvkPnvQLILNIHl0fJA41EQLenc595zUbmF2wbrbN0P7kqEpvGY8U5NJYYE32JRvUZxn3QULmEm3uuDNyAx+7wXV0d0RuoUB0lGpJDXp/zPkkX5Cj1Eetc3YFc6iyaqfjnHaaOVcdRB4M/oiibmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tXC2RbA5; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773121742; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=KgERvp3Zd6HKrE1IZEhDd8xhZg6rlFUC5JACfjNthtc=;
	b=tXC2RbA5qfAjWgaSR1gdqqvx1dQuZ6+F0HIclP9+UwVtxTiSJGZ9/1lzNtKi8K4ucCmV7rVV80NGbTrNLDj31jW6gs9ajIqiSXOEZbnoyhGBPheEways33eHqkhpf32/ArzFXvftyHYqF5bwydFJrlwcoFbiALIOosY70WVAAK0=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X-eu4DB_1773121741 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 13:49:02 +0800
Date: Tue, 10 Mar 2026 13:49:01 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: sawara04.o@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/2] smc-sysctl formatting and missing entries
Message-ID: <20260310054901.GA40558@j66a10360.sqa.eu95>
References: <20260309124541.22723-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309124541.22723-1-sawara04.o@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Queue-Id: A4BE5245847
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265893-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,alibaba.com:email,j66a10360.sqa.eu95:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:45:38PM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> Hi,
> 
> this series updates SMC sysctl documentation in two small steps.
> 
> - patch 1 fixes indentation in the smcr_buf_type section
> - patch 2 documents missing sysctl parameters limit_smc_hs and hs_ctrl,
>   including values/defaults and hs_ctrl usage notes
> 
> No code or runtime behavior is changed.
> 
> Thanks,
> Kyoji
> 
> Kyoji Ogasawara (2):
>   net/smc: fix indentation in smcr_buf_type section
>   net/smc: Add documentation for limit_smc_hs and hs_ctrl
> 
>  Documentation/networking/smc-sysctl.rst | 43 ++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> -- 
> 2.43.0
>

Thanks for your contribution. The whole series looks good to me.

Reviewed-by: D. Wythe<alibuda@linux.alibaba.com>

