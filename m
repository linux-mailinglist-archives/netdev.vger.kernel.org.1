Return-Path: <netdev+bounces-294323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VSQ/La0bH2qZgAAAu9opvQ
	(envelope-from <netdev+bounces-294323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:06:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE13630EF9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:06:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xf9g6v7i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294323-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294323-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7D9B3001CCA
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1C3FBB55;
	Tue,  2 Jun 2026 17:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93653FBED1
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:57:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423048; cv=none; b=NpTWsO0+LZ2paMCAHDdrsq95hx7DjEaqoMG4CKD7So8ojLnS4Kq8Ibbu5ShcxkR4dF0gW/v5S4xCkBcC7WgtHjzjtelTcZDOCu7iMpv3PVkihNJ8ZdruV3RJe3lahZCsJHflf3sFvK0pAhUklDKymIrlkoTrkUc4uhmfgphVRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423048; c=relaxed/simple;
	bh=+H5khT1igs06tcVp2SJ6MrROItDkv5Kidh39fsxTtfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtRIJUkb3ihcqqekE0yepxyun1JVHzpSYgo5MpcnPbNJm3svVJmFVRsUqDg5Claoewn0itJAJdCp2AZIQTcBA0j1lc8XKzn7XM6heSpriXQuZ89q7eqxcFgM31h7+Em4KNzI9URJPYARlW7RKvvxYnfi1Qc1wT5LiMIH0MS3MO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf9g6v7i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4007D1F00893;
	Tue,  2 Jun 2026 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423047;
	bh=KXVo2+aTdUwzqk7OXEt1bo6fJ/JcSPZbYEmo9RtyLe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xf9g6v7ir/DIbk+qMJ0OdZHY7pcx8ih4csvoMZTYrC+dAwp5/CtKfDNrcq2exK6wt
	 G+XXm+vhVWjd0J5tA5HHwZkPDnrZBQ0519E5dL+KQGvkGplHnkTkZMGBJpCEn9zUIb
	 5Syean92TTtgIa6bV/wc8tBiCMclFn80xBgVCFpWvVU6tlXWC3n58ONwgRhom4YjWe
	 ch3BREJx+AC15r3Vtscp3PrhSyrMlfRUAT8tmi2CeIDlCGrzTR4MkLFW7M+mPQ1Ox7
	 3bkOeec2lExMv+hAc89+wDoM2E6UcA40uS0ksMwPeejpfgvRMWP+j525/NEV95avnn
	 ABh+bNf+aGWDg==
Date: Tue, 2 Jun 2026 10:57:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] rtnetlink: use dev_isalive() in rtnl_getlink()
Message-ID: <20260602105726.0f7f0d8b@kernel.org>
In-Reply-To: <20260602091319.1753654-1-edumazet@google.com>
References: <20260602091319.1753654-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294323-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:kuniyu@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDE13630EF9

On Tue,  2 Jun 2026 09:13:19 +0000 Eric Dumazet wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 74507c006490f180d2fac6594f6dcf2c86d53919..bfc847bc47fd957b58174dc4d2b82e2e8b461405 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5660,6 +5660,12 @@ static inline const char *netdev_name(const struct net_device *dev)
>  	return dev->name;
>  }
>  
> +/* Caller holds RTNL, netdev->lock or RCU */
> +static inline bool dev_isalive(const struct net_device *dev)
> +{
> +	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
> +}

nit: could you put it in net/core/dev.h ?

Or alternatively rename to netif_isalive(). We should try to avoid using
the dev_ prefix on APIs we export via include/linux/

