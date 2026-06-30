Return-Path: <netdev+bounces-303067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /8lRByyUQ2p5cgoAu9opvQ
	(envelope-from <netdev+bounces-303067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:02:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A956E2935
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:02:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AwsGvlgJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303067-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303067-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD3183018D00
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006303C9894;
	Tue, 30 Jun 2026 09:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D082317164;
	Tue, 30 Jun 2026 09:58:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813532; cv=none; b=XO59rw10IOZvSjlkBu7JQBjdJonkjdDSNUTppWjnNMn2EsuFscvkQWZldsVoX0rugEQlr87BDQOQxjQC3ZWDqGNELSCuujjJYm7FUyHU9g9iV7mc9NP/4GKA2Fi50qdTOsLdzeXKc0+WfUhyxxJW+zWA88UK7q7eF4ewM4dXxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813532; c=relaxed/simple;
	bh=R1HOq/Rc2e0mHhkp/cZR6s3G8VYvSRDfS6VPARRSjys=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=orBLQMAb/CzmM6SfvaMiXNHttTYnlSmsEMhcBP9UkyQh1Up+G0uAqkZcBQ7vhRwx1L0Jh/nsFMaQ4SB1pZSqcVV6Y+Ta0vE599OXB/XwBQ+dS/XTzQjbxK3oQD1nrTeoOKhE0h25drkM5U7qJgYoqUqzjlCvyM8FG6sj2WLGYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwsGvlgJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF4E1F000E9;
	Tue, 30 Jun 2026 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813531;
	bh=exCIX3lRbpsd86KnItXyPO8javiFP1yVs5ghoBTVi6c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=AwsGvlgJY9EljQQXeV1LIQ+0fXdp5LoarCwAuUGuaOVwiCZjKLEd/stK5HCYEixJt
	 NJuMWJNJpRSUPCr3c2bYC9KJ4AH/7+eVslUCHfNURi+HhhmBfmydzJVZixTPr2QSeL
	 d5iotlj3iR6rdpI6lfE4e7VFJmVEadL055Nc4tonjHFlKoqG5PmyAs3mMp5GwEpKjX
	 E4oC7vvIz4RnTiO3uBFcK2RL2+Id6MvLJBMaer2ZOuBDbbAArtW8QTrMu5ZGOL6kZ8
	 tHPO0avkmxMOKrSNYDOqdpoocQblzQeNN6ky4sXbz3H2HaRW6XYlgtSYicSulU0yJT
	 8In60av6DS9ow==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM
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
In-Reply-To: <20260629194327.2270798-4-jkoolstra@xs4all.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-4-jkoolstra@xs4all.nl>
Date: Tue, 30 Jun 2026 11:58:43 +0200
Message-Id: <20260630-getoppt-granit-gekrochen-78244e8979d9@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3893; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R1HOq/Rc2e0mHhkp/cZR6s3G8VYvSRDfS6VPARRSjys=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5T4745d8tLpli2PTMq6Xgy6YGf6fMjx533nbtNpvxo
 bnH0Dawo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKzzjIy/PJ8wfLhvPUd5eIg
 MbNyhWINvybm0w8MI6tMjkdaH+haw8hw4PGss4FLkjZb/3775EJQd9N8c0MLG3lbs9Vsm4w1E+V
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303067-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92A956E2935

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
>
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 34f53dde65ce..bb1b3dee02e8 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -49,6 +49,7 @@ struct unix_sock {
>  	struct scm_stat		scm_stat;
>  	int			inq_len;
>  	bool			recvmsg_inq;
> +	bool			scm_rights_notrunc;
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>  	struct sk_buff		*oob_skb;
>  #endif
> diff --git a/include/net/scm.h b/include/net/scm.h
> index c52519669349..761cda0803fb 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -50,8 +50,8 @@ struct scm_cookie {
>  #endif
>  };
>  
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
>  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
>  void __scm_destroy(struct scm_cookie *scm);
>  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> @@ -108,11 +108,18 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>  		   struct scm_cookie *scm, int flags);
>  
>  static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> -				  unsigned int flags)
> +				  unsigned int flags, bool notrunc)
>  {
> +	bool filtered;
> +	int error;
> +
>  	if (!ufd)
>  		return -EFAULT;
> -	return receive_fd(f, ufd, flags);
> +
> +	error = receive_fd_filtered(f, ufd, flags, &filtered);
> +	if (filtered && notrunc)
> +		return put_user(error, ufd);

This helper makes no sense to me. The boolean return argument is just
really nasty and you need an additional put_user() as well. At this
point, just drop receive_fd() and open-code it instead of using another
custom helper. Something like the completely untested:

diff --git a/include/net/scm.h b/include/net/scm.h
index 761cda0803fb..171b5ccd0b77 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -116,10 +116,22 @@ static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
        if (!ufd)
                return -EFAULT;

-       error = receive_fd_filtered(f, ufd, flags, &filtered);
-       if (filtered && notrunc)
-               return put_user(error, ufd);
-       return error;
+       error = security_file_receive(file);
+       if (error)
+               return notrunc ? put_user(error, ufd) : error;
+
+       FD_PREPARE(fdf, flags, f);
+       if (fdf.err)
+               return fdf.err;
+       get_file(f);
+
+       error = put_user(fd_prepare_fd(fdf), ufd);
+       if (error)
+               return error;
+
+       __receive_sock(f);
+       return fd_publish(fdf);
 }

-- 
Christian Brauner <brauner@kernel.org>

