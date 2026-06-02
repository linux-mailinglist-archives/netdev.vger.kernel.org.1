Return-Path: <netdev+bounces-294369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dh3oHq4rH2qCiQAAu9opvQ
	(envelope-from <netdev+bounces-294369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:14:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC92A631559
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mLewJqOw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294369-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294369-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61641307AF32
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA143A48DF;
	Tue,  2 Jun 2026 19:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197ED3812F7;
	Tue,  2 Jun 2026 19:07:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427226; cv=none; b=nXaJgOlz2bmYxWBK8f/w5ReYuZ1Lw3xZwupaGiPeJbRl8MhyFiL2k/KjY2d8vkzdZlEDJ2+2l169BsDsAMeub8UghnN5jt6v74IX2Tlhda7t12bRB57oDLo6tj3wS/+ok9wQqC9daP5m+7mw9EJE0eAzBYzwLn4/XhDI+nc1Wj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427226; c=relaxed/simple;
	bh=dnHosAXl/coXl6ucrNy+LCig5YvUbBl/NXma3SYL6CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw+15eE/LyFdWW0LDWbNac+LepZjOiC4/re7eTRhRN1vpBQEArICPN4F2lXRiD/LgjfRzsMeat6num64IRgOXw/VuMDo3105E/Ylx+H5R2rM8c+CJCjaEK8JORA9sXiivo6DIDdai5QHpO5snYEjIzzuTJ97+alE2UB5hX5+oWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLewJqOw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410D51F00893;
	Tue,  2 Jun 2026 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427224;
	bh=PLN3wsI49Icr4aZEVDsCDDfXyKhloHxXkuEhGkxIAvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mLewJqOwmufLT5DSW/Astfb2BCGp6Ee2fhxWTsKLvFgk7Y2kggVJkYwxT0w0/7VsI
	 7wjX9O8K912c4y/CDMlo/xOJ3dCJ5X36KuV1eL4C0miY8aSq4lOARs4Y7RaetshpIn
	 6vV9Ty+rHJcBMjdhac4WgPl/SkTAYx9meWabg3aO99D/IfjNHbt0T7AVIGBflWZMTO
	 5x0jcLKwFUgGZVGLCreojzkGLh7Tpg6HCuiZqEqSdcdechhq4W95Byn+6lZfoFZnBb
	 6Mwo+tb7WIkneTtisdwB9vmL51g5+GrEdpgn+gDqfkOnu18Uj6Txx8jILJtSyJ0LWm
	 X+Uq9RT2nG0sQ==
From: Jakub Kicinski <kuba@kernel.org>
To: maoyixie.tju@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	fmancera@suse.de,
	jvaclav@redhat.com,
	andrew@lunn.ch,
	ap420073@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] hsr: broadcast netlink notifications in the device's net namespace
Date: Tue,  2 Jun 2026 12:06:59 -0700
Message-ID: <20260602190700.1920420-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601022014.1175348-1-maoyixie.tju@gmail.com>
References: <20260601022014.1175348-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294369-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:fmancera@suse.de,m:jvaclav@redhat.com,m:andrew@lunn.ch,m:ap420073@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,suse.de,lunn.ch,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC92A631559

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
hsr: broadcast netlink notifications in the device's net namespace

This commit modifies the HSR subsystem to broadcast generic netlink
notifications in the device's network namespace instead of init_net. It updates
hsr_nl_ringerror() and hsr_nl_nodedown() to use genlmsg_multicast_netns().

> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index f0ca23da3ab99..eb6d222535d8b 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
[ ... ]
> @@ -288,8 +289,17 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
>  	if (res < 0)
>  		goto nla_put_failure;
>  
> +	rcu_read_lock();
> +	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> +	if (!master) {
> +		rcu_read_unlock();
> +		goto nla_put_failure;

[Severity: High]
Does jumping to nla_put_failure here cause a NULL pointer dereference?

If master is NULL, the code jumps to nla_put_failure, which frees the skb
and then falls through to the fail label:

nla_put_failure:
	kfree_skb(skb);

fail:
	rcu_read_lock();
	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
	netdev_warn(master->dev, "Could not send HSR node down\n");
	rcu_read_unlock();

Since master was not found previously, the re-fetch will likely still be NULL,
meaning the dereference of master->dev in netdev_warn() will crash.

> +	}
> +
>  	genlmsg_end(skb, msg_head);
> -	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
> +	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
> +				skb, 0, 0, GFP_ATOMIC);
> +	rcu_read_unlock();
>  
>  	return;
>
-- 
pw-bot: cr

