Return-Path: <netdev+bounces-270625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFnPGA97wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:40:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FF22FA29C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61AD830DD484
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982B3C5548;
	Mon, 23 Mar 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxMqQpA3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683E3C5523
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285914; cv=none; b=j9YO9wzWynb1VX/tkSEvfL6n9iPSFZ9Slab5pru0PctxhhV69c9kYux4y0Uhlk2AWSsdBasUlWEnxZD/Ds5zPysPE/vOxfgx/wrbeABE4bCBFDgOEZ0M/6u8OmxqrHqWX2SfVcXAwGAlzOLfRoiOctA05Xq/mgquaLZALglhj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285914; c=relaxed/simple;
	bh=W0XAkUwSM4VxOYH/R67L3H5rwcd0A/5oL6ZOO+VED7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2f/d7f2hCIfsUC1cTqeupRbgKdxx2CjiwLPMbUsiLI16KDUziGxlFK1A/3qH/eiCntBwdilVgXIOPefPY3iBivxOmSj4gAktz8nAQcpCDk6oDEKwxzFrR4bNz39gTnCenEL4ftJ9LxcyRy5ao3d8b9Vv3AKYs+nRHz9jUBF7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxMqQpA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFA8C2BC9E;
	Mon, 23 Mar 2026 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774285913;
	bh=W0XAkUwSM4VxOYH/R67L3H5rwcd0A/5oL6ZOO+VED7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxMqQpA39T2wuiZWCZbjm4dSkGLtP9zEyclMbUfH6fZ46Ks4cEyov7ScfHNBTwFUx
	 qolWJIT8RZZWof6gVB+/yoNMQ2qO5moFI2Jnwm10kJgEY+lmVzHZ/yBwyq21e5l8SM
	 eGic/1NkGi/VrURgiwmd1LBcoeEsiHd2991EZU2eq/QsbQaUee8ymped+fk+HTEed+
	 nYQOr/hGpULmAPPQpsrMhwICKjHqC6E+PqSBFg9V/Gv8RScGL6BWfKR++KWqLLUsWw
	 A7bCd8FpNGiufEH5m9T6c+JbdmO9NSihvc42GkXqwhwoXdbvKPvccPL8iMhkc9ofx/
	 7sv+ELtjF/7Fw==
Date: Mon, 23 Mar 2026 17:11:49 +0000
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: gongfan1@huawei.com, cai.huoqing@linux.dev, andrew+netdev@lunn.ch,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next 1/2] net: huawei: hinic: correct IPv6 version
 check in TX checksum path
Message-ID: <20260323171149.GA111839@horms.kernel.org>
References: <20260321165238.647948-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321165238.647948-1-alok.a.tiwari@oracle.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,linux.dev,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-270625-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,oracle.com:email]
X-Rspamd-Queue-Id: D2FF22FA29C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 09:52:33AM -0700, Alok Tiwari wrote:
> The TX checksum/offload code determines whether the network header is
> IPv4 or IPv6 by checking the version field. The IPv6 case incorrectly
> checked ip->v4->version for a value of 6. Use ip->v6->version instead to
> match the header type being parsed.
> 
> Use ip->v6->version in the IPv6 case to match intent and improve
> readability.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Hi,

I see where you are going with this.

But I discovered sashiko.dev a bit earlier today and it's AI generated
review of this patch-set points out that the same pattern also exists in
offload_tso and offload_csum in this file.

And likewise, for patch 2/2, the pattern exists in get_inner_l3_l4_type()
as well as where you updated it in hinic3_tx_csum().

-- 
pw-bot: changes-requested

