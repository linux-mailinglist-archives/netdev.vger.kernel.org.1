Return-Path: <netdev+bounces-257141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDLpJlqFhGl43QMAu9opvQ
	(envelope-from <netdev+bounces-257141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:56:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4CFF21A7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813AD301494E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DCB3B8D41;
	Thu,  5 Feb 2026 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe2wTKU2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFE3B5303;
	Thu,  5 Feb 2026 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292518; cv=none; b=ii8Vg2HeF6uXW6j5G1xk1575sc97ioDraHmJP3IcxCg08GjA3qnNavKR1UITB18IF34Bo3Jst/qUjFi5OtKhG2Eg76tURYcLkAHtnSuNFmLN1+HaGHbwKM3CB7kHO5WKlPOH4YDaPCD4KDTO0K9kEqxsXPneaQjhM97Il/ez1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292518; c=relaxed/simple;
	bh=vL96u07IieBDDsrKJi5YS65hKp6UbQzyncWbCYn6dLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2bQCKJA8bOqUNFIgptywq05UEGVXfoJs2P7NQOn24TwaFpUDz1otScliXU1KXmCH/c05bLB8gR+eQioa3uyHqVdNFPeKm0rjveWnU6LV/5olRfKRePztCGRVkHfOz0Pfaqg9z5Q+nsNmQKlEoEwSEVyjcbejf+BEVkJouibzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe2wTKU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCB1C4CEF7;
	Thu,  5 Feb 2026 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770292518;
	bh=vL96u07IieBDDsrKJi5YS65hKp6UbQzyncWbCYn6dLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oe2wTKU2Zjb1ONJDJvHQMOYmHRew4YZazNHKEF/77JIPy3LS4P+39/2cFxXyFVhqv
	 IxmVGOxoFICGOmoZxbLVLxTN7r+3nuS7L36a/23vsky/WwQkecfx+HemQaJrFHlofy
	 fFHQYF9hov03stZXZTH9n8ukY9YyYU1M3fSRSEyAKlIDxiUZnvSiZL5H9kYP7eYOAj
	 igWnUcFkivModP0SGJ/OgCAz8GsfK78W2Gswi0X9v4CVW/A/mbropGu5jrW/7GEMFr
	 W1odFnFQLbLibTXQQz/CHd4zpMw9I2jXJdGNZHqG8PovPN7bkYZeSPWn5U8HspFvhM
	 pQYVfUsvnXZMg==
From: Simon Horman <horms@kernel.org>
To: lucien.xin@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	steved@redhat.com,
	marcelo.leitner@gmail.com,
	aahringo@redhat.com,
	alibuda@linux.alibaba.com,
	jbaron@akamai.com,
	hare@suse.de,
	kuba@kernel.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	daniel@haxx.se,
	quic@lists.linux.dev,
	jlayton@kernel.org,
	tfanelli@redhat.com,
	dhowells@redhat.com,
	linkinjeon@kernel.org,
	hepengtao@xiaomi.com,
	pc@manguebit.com,
	kernel-tls-handshake@lists.linux.dev,
	illiliti@protonmail.com,
	xiyou.wangcong@gmail.com,
	andrew.gospodarek@broadcom.com,
	mail@johnericson.me,
	edumazet@google.com,
	pabeni@redhat.com,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	smfrench@gmail.com,
	metze@samba.org,
	mbuhl@openbsd.org,
	chuck.lever@oracle.com,
	dreibh@simula.no,
	davem@davemloft.net,
	sd@queasysnail.net
Subject: Re: [net-next,v9,05/15] quic: provide quic.h header files for kernel and userspace
Date: Thu,  5 Feb 2026 11:55:06 +0000
Message-ID: <20260205115506.2195311-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b3e81a27cc3e4c03fa8357c2c77b238997e48610.1770042461.git.lucien.xin@gmail.com>
References: <b3e81a27cc3e4c03fa8357c2c77b238997e48610.1770042461.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C4CFF21A7
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
quic: provide quic.h header files for kernel and userspace

This commit adds quic.h header files in include/uapi/linux and
include/linux to provide the necessary definitions for the QUIC
socket API.

> diff --git a/include/uapi/linux/quic.h b/include/uapi/linux/quic.h
> --- /dev/null
> +++ b/include/uapi/linux/quic.h

[ ... ]

> +enum quic_msg_flags {
> +	/* flags for stream_flags */
> +	MSG_QUIC_STREAM_NEW		= MSG_SYN,
> +	MSG_QUIC_STREAM_FIN		= MSG_FIN,
> +	MSG_QUIC_STREAM_UNI		= MSG_CONFIRM,
> +	MSG_QUIC_STREAM_DONTWAIT	= MSG_WAITFORONE,
> +	MSG_QUIC_STREAM_SNDBLOCK	= MSG_ERRQUEUE,
> +
> +	/* extented flags for msg_flags */

This isn't a bug, but there's a typo: "extented" should be "extended".

