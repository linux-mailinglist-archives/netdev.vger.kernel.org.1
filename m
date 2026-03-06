Return-Path: <netdev+bounces-264624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEEXIOM7qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:28:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76021A9D4
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A49E300F529
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A689224A06D;
	Fri,  6 Mar 2026 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QaLLuQV7"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CA1A0BF3;
	Fri,  6 Mar 2026 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764128; cv=none; b=ad3yfc3zQbdZBbZ70M4iu4qLeSScL/9/hd7c6OtgxxyMb43FudUPNR+hQnZqkXdIWWhXKoPX33fyq5ipLOJFk2nu42WaWDSZpqtF9v3VAUBVg1hoSJShQochoL+GKp98bKslEmYK+OEo5+FWgMSB9wTdOw5HvTAxtvEHZQho3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764128; c=relaxed/simple;
	bh=x13O2jYUdVaEv7MWI0JqxXaTuDwYrIM3V27PTwPOX60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJan2ciQoZXORZfY0orhllG7QnmmFeaDx9sdX7Av1SpEp2xxoaQQMIkMVX8hKywRzCZArUSxa4vEDeqkCZRzbWkMHC2FxBGHqelorjawq4zh/nHAMP6f/R59jrQ6RDvCTRXQxnjbQTdEDmSGw5h4R5gBaqulB5Z+mAaByn9g9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QaLLuQV7; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772764123; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=gUSTZ87cLTOR+0JDrERzuuboMikdFfvlXB4/1xaThyE=;
	b=QaLLuQV7eO9vHl+A5u5thXsXE6Imob1MKufA/rpOd8pCDe1tz/8z8p2V8lJaSl4V+8Aeem0zAuokmI6biamCNK2v3l+NYr/yCPhexeErlYCSX6LmPCqVacJ4MsObGdpE9OfICRaV/ynxcKE/qJCK2Pk8/u8XbHLHMe/68b8oxAE=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X-LaX3E_1772764122 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Mar 2026 10:28:43 +0800
Date: Fri, 6 Mar 2026 10:28:42 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Kyoji Ogasawara <sawara04.o@gmail.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net/smc: Add documentation for limit_smc_hs
 and hs_ctrl
Message-ID: <20260306022842.GA85615@j66a10360.sqa.eu95>
References: <20260305092226.27379-1-sawara04.o@gmail.com>
 <20260305092226.27379-3-sawara04.o@gmail.com>
 <20260305112428.GA57792@j66a10360.sqa.eu95>
 <CAKNDObDc55sL1fuQGfEiw13GwzG4WuNm5_ZfAf+_gZNVXuGJQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKNDObDc55sL1fuQGfEiw13GwzG4WuNm5_ZfAf+_gZNVXuGJQw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Queue-Id: CA76021A9D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264624-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,j66a10360.sqa.eu95:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:40:39AM +0900, Kyoji Ogasawara wrote:
> > > +hs_ctrl - STRING
> > > +     Select the SMC handshake control profile by name.
> > > +
> > > +     The selected profile controls whether SMC options are advertised
> > > +     during TCP SYN/SYN-ACK handshake.
> > > +
> > > +     Only available when CONFIG_SMC_HS_CTRL_BPF is enabled.
> > > +     Write an empty string to clear the current profile.
> >
> > It would be better to clarify that this string refers to the name of a
> > BPF struct_ops (type smc_hs_ctrl) implemented by the user.
> >
> 
> Thanks for the suggestion.
> I updated the hs_ctrl description to clarify that the string is the
> name of a user-implemented BPF struct_ops instance of type
> smc_hs_ctrl.
> Does this address your comment?
> 
> ```
>  hs_ctrl - STRING
>         Select the SMC handshake control profile by name.
> 
> +       This string refers to the name of a user-implemented
> +       BPF struct_ops instance of type smc_hs_ctrl.
> +
>         The selected profile controls whether SMC options are advertised
>         during TCP SYN/SYN-ACK handshake.
> 
>         Only available when CONFIG_SMC_HS_CTRL_BPF is enabled.
>         Write an empty string to clear the current profile.
> 
>         Default: empty string
> ```

LGTM. Thanks for your contribution.

D. Wythe


