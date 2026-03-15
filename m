Return-Path: <netdev+bounces-267927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A4eIRPYtmlfJgEAu9opvQ
	(envelope-from <netdev+bounces-267927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:02:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B529155A
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EDB7300602A
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA6366074;
	Sun, 15 Mar 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0ze5lFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1113612EC;
	Sun, 15 Mar 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590541; cv=none; b=uFEnXTG8XSiReH+JAucue/pveUzQvGBwSYw+vvGoBElMxTvk8Vc8oh01NUFD3M0O3FgzDtXb30Ay357KCU8gC0slH2G7HuH8W02VAOOeAjAY+Eg4Y5Uz5G9q+/a34IRq1XEIuO+zRHR0JC+ITfZjpluho6NhjJFCz6lT7Eac67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590541; c=relaxed/simple;
	bh=g37uOew/Ysp4He6RhgYqU2PvBldpmfoVonmrNv2Somg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9wR6WlOg5tp9FDSfsOiiLv0Htlbasark/OX37Cn3pAl1pmvFa0m4Ab4jxf56bSN9ICuLYVVz6nC0Tpe5dXgIf/EIJcC+aqisX2l72AgS5D3sy5nDZKhVO24a5OVvI0Zh7iuag4Hq59IlDujs5BWFMZwCyTf5E+T5tI9DSUphvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0ze5lFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB70C4CEF7;
	Sun, 15 Mar 2026 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773590541;
	bh=g37uOew/Ysp4He6RhgYqU2PvBldpmfoVonmrNv2Somg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0ze5lFVO2T4YDScVpzAtRdOahwMsgESjbmrBZv0K1ZPUskKUP4uV/DT4XhQ6cqXz
	 yIcJ3WXoXwNfPicx01dPFhhLnLUzN5nMNpUetUgL3ur9POK7IuC8dRrVNRROvS7yX0
	 QG8gcxF6wAk5B51f4ARlB/YECg7S//ZXl/uSrDytP5RhcPERJLmXrgFsCtT+/US8dR
	 vkOVO6YaZnCPiJxF4ttgLwe6KALemGyyBSCy/0QDN8Sp7QNH+5z+h065lrbMTGWGAm
	 Y0LjY5LqdBloZ485ZFowdNATlIUR8le+m+/0StxpGIvB4gd54XDSMgwPp3y0lVLU7E
	 vGrs2vIwMMr6g==
From: Simon Horman <horms@kernel.org>
To: heminhong@kylinos.cn
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	andrea.mayer@uniroma2.it,
	kuba@kernel.org,
	edumazet@google.com,
	david.lebrun@uclouvain.be,
	pabeni@redhat.com
Subject: Re: [net,v2] ipv6: sr: Add NULL check for idev in seg6_hmac_validate_skb
Date: Sun, 15 Mar 2026 16:01:59 +0000
Message-ID: <20260315160159.1394504-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313022634.51885-1-heminhong@kylinos.cn>
References: <20260313022634.51885-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267927-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 866B529155A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ipv6: sr: Add NULL check for idev in seg6_hmac_validate_skb

In seg6_hmac_validate_skb(), the pointer returned by __in6_dev_get()
can be NULL if the network device lacks proper IPv6 initialization
or is being torn down. Add a NULL check to avoid potential NULL pointer
dereference in subsequent code.

> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
>  	int require_hmac;
>
>  	idev = __in6_dev_get(skb->dev);
> +	if (!idev)
> +		return false;
>
>  	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
>

The patch adds a NULL check in seg6_hmac_validate_skb() to handle the
case when __in6_dev_get() returns NULL. However, does this fix the
complete issue?

Looking at ipv6_srh_rcv() in net/ipv6/exthdrs.c, there's an earlier use
of the same __in6_dev_get() call:

net/ipv6/exthdrs.c:ipv6_srh_rcv() {
    ...
    idev = __in6_dev_get(skb->dev);

    accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
                      READ_ONCE(idev->cnf.seg6_enabled));
    ...
#ifdef CONFIG_IPV6_SEG6_HMAC
    if (!seg6_hmac_validate_skb(skb)) {
    ...
}

The idev pointer is dereferenced on line 384 (idev->cnf.seg6_enabled)
before seg6_hmac_validate_skb() is called. If __in6_dev_get() can return
NULL as the commit message states, wouldn't this cause a NULL pointer
dereference before the new check in seg6_hmac_validate_skb() has a
chance to catch it?

Should ipv6_srh_rcv() also check for NULL after calling __in6_dev_get()?

