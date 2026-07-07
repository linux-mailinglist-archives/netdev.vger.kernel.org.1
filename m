Return-Path: <netdev+bounces-305416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LbhFHm/dTGqSrAEAu9opvQ
	(envelope-from <netdev+bounces-305416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:05:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C0D71AC31
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:05:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LsgZiBer;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305416-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305416-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 896B630A7A12
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCCD3F54D8;
	Tue,  7 Jul 2026 11:02:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF53F54CC;
	Tue,  7 Jul 2026 11:02:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422135; cv=none; b=I/49HpsPJhFyzcZdYypA5KaleumFo4oKIqOoBZpjyOOUBsfRRJmqiIJPwJZnqP2reX4CmHad0PvTp3gKvUQxBsgxKgBDdwQ1ZAq8XAdG3W11Q/2xooUiuJGwcLbL50ePlkuFsv3Mgx4Ur/7DMu2FMK3Wy8Lijoy2D56KZnY5BJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422135; c=relaxed/simple;
	bh=v7zg2qCQsTEo10UD+roP0qnbDkvm4NPLPvXdiuiUP/g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aZxxHd6i4OcqS5jJw7iSkW5Du4lgyjkBOmhP3vRVUrwK4VCaz3HuRvyr8k8yBf/dD3HV1LRF0SWpapulL6u07Ekq53MU1wyzMdlsmMovW+WKB8gwhsci0BkQBuxf2Trd7ejm5o/osGTVkAsgDT9qHPXGl2KRn31I3460QSh9Wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsgZiBer; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319711F000E9;
	Tue,  7 Jul 2026 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422134;
	bh=ZZSMUzOXrzSnSc5a15tq3LDEwCotl56yX4e8egwm56U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LsgZiBerlYXDzZCJeZfm/poKFwL/nWxwgiKopIDaOo1mp4s6b8JqcwMn5tZb7TQe3
	 yKEfEyCFn3xIvNTndPfQFTVDdIBuhN4EgGTX0U2iVl3F3l+CbyJAIR0rj+93s3sKZ3
	 FnUKWkYPi6tDe+nJm9mBw3K/n5cUMjUhAesc4gEeVo6w9rFqg6t2+xy1Axats23+8c
	 acG4MiNflcLJgmfE/6fKWpyhQrVePCZbFCAXHJffrOfjm6uo5vD7y+Na3ew0pq/dpk
	 7ZXjhmyA/Av5LO6WmhhVIyymKxaZBXpxmI8xtJQMr7zu+vKHMepUNyCOGRwpeMZLPL
	 5irBMvWgHhI7A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v4 2/3] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260705123826.3818443-3-jkoolstra@xs4all.nl>
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl>
 <20260705123826.3818443-3-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 13:02:05 +0200
Message-Id: <20260707-werkvertrag-walzen-anteil-4aef3ab6e47f@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2985; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v7zg2qCQsTEo10UD+roP0qnbDkvm4NPLPvXdiuiUP/g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53Nms2OlisytFlMtOYCNbzdIVDInRbicuyM6+1tKkp
 Nn2dP75jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncX8nwT2vV7E020/fb3y9v
 kN711yXscvoZDiZfnnmWi8OeeLG3HmZkmC+xJzja/u1cY3/JJRMWOIvz9+g6PJT84/uj+/WbdUZ
 P2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305416-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xs4all.nl:email,vger.kernel.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10C0D71AC31

> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
> 
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot.
> 
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +		    bool notrunc)
> +{
> +	int error;
> +
> +	if (!ufd)
> +		return -EFAULT;
> +
> +	error = security_file_receive(f);
> +	if (error)
> +		return notrunc ? put_user(error, ufd) : error;
> +
> +	FD_PREPARE(fdf, flags, get_file(f));
> +	if (fdf.err)
> +		return fdf.err;
> +
> +	error = put_user(fd_prepare_fd(fdf), ufd);
> +	if (error)
> +		return error;
> +
> +	__receive_sock(fd_prepare_file(fdf));
> +	return fd_publish(fdf);
> +}

Seems good.

> +
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
>  {
>  	struct cmsghdr __user *cm =
>  		(__force struct cmsghdr __user *)msg->msg_control_user;
> @@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
>  		return;
>  
>  	if (msg->msg_flags & MSG_CMSG_COMPAT) {
> -		scm_detach_fds_compat(msg, scm);
> +		scm_detach_fds_compat(msg, scm, notrunc);
>  		return;
>  	}
>  
>  	for (i = 0; i < fdmax; i++) {
> -		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
> +		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
>  		if (err < 0)
>  			break;
>  	}
> @@ -542,8 +566,14 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>  	if (!__scm_recv_common(sock->sk, msg, scm, flags))
>  		return;
>  
> -	if (scm->fp)
> -		scm_detach_fds(msg, scm);
> +	if (scm->fp) {
> +		struct unix_sock *u;
> +		bool notrunc;
> +
> +		u = unix_sk(sock->sk);
> +		notrunc = READ_ONCE(u->scm_rights_notrunc);
> +		scm_detach_fds(msg, scm, notrunc);

Minor nit: Really no need for the boolean. Would be enough to do:

scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));

-- 
Christian Brauner <brauner@kernel.org>

