Return-Path: <netdev+bounces-298781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y1HCNIVgLGqVQAQAu9opvQ
	(envelope-from <netdev+bounces-298781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2D67C19A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pPeK0p1p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298781-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495CE300C984
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D5375AD0;
	Fri, 12 Jun 2026 19:37:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E4349CDE
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:37:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293066; cv=pass; b=gbutAatLSKuU/C0jhKTHacu3ywiQNh3y2AYn0QEeBvF9q+NvOujdIJ0TW2zHL0xvcvfy//EcqgamOZRspD7jEM5gXEiZbAhkl+FXFlQUlrMpdh0re60qcaVhEPGiCKSt1NGaNsoWfgRwA978oxFmt87jRI7d4315MmKXAqqMz/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293066; c=relaxed/simple;
	bh=QEUU0s90pEvT4hfT4qXSU5rJ24bOjblDhPsz3FQQoIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edLyCHGhXhztmVYf+tRLilQiq5ZfU9N7gLgDwP3Qs4/BjbPYUCYpog9Pca9PFxokWSr9of+xI1rpIZs8Abvhiyjeu5frx+uFqyq0rK2CBOdyo3H934SjKwg7RdrB9OSWghd2umqposT8mqAnWZxKD8OatSRwANeYFB/QN/OM2fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPeK0p1p; arc=pass smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c855599a77aso761477a12.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781293065; cv=none;
        d=google.com; s=arc-20240605;
        b=b+xYcT02tCGpbhxk/jxxqc60HecR71oKiSxQ2TcTykTvhuwE+zKlFPUBELQMxi0kTn
         ZWv22eZEXQF+SudEa/VW/p9xisiwsYykBzDFOAu5dvJXfVRb8BjkiA9JZ8U6schqyBS7
         JQO+Iza9z+9SpoIuHo7ZcxYZdT05+GRzNkVDG7Or9MvjRnLLIplSkd4tHgN6FsXD31fw
         7XZY7z4T2EE/1IhDLcs7QpexpeytWCBrq3mhZs5jXpKOi4H2BEUms9jN4SScD3I4D1ID
         4uaNJgSqMGy/lCGY582j2CZRX+YPIUMfIcOEcXSHswZo07AF6UL5BVmUHpjHMWG1jMqC
         hjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QEUU0s90pEvT4hfT4qXSU5rJ24bOjblDhPsz3FQQoIs=;
        fh=pqM/IHKozT5n/ugnyQLDk4/nPc4DMMAsaO459tHppXU=;
        b=GpWio0xbHSbqu3ozZx3LtlU2h9Z8H/r7YRFWmKokWUM9RlAgLimpcbxoRf2h+/Plv7
         swAWJsyuocAl+v7PibuK660C3CIWAba6SkaTJHLgrJ79smuS1/Pbu3uqxonhvCtlQluT
         2PktwEQIulS5ZZcB52UUQAFWbHQPL7o46wcKStS5qD38vulBEd3QOP25iUm9MZifPo/1
         R9mPmJ1MsGdpZtpXbeSRZrFiQMKosE0TqhChvL47w+omAJLRSZZXEr4i9RbEFTRswUxX
         AVQRGJTAMUpKStoH7HorPg+KLz84U2PtwXzodKdhLUl5e/DNlu+Zxrl34luiV4sScKi6
         orBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293065; x=1781897865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QEUU0s90pEvT4hfT4qXSU5rJ24bOjblDhPsz3FQQoIs=;
        b=pPeK0p1p+H2Stw/gIDmIEtvzYV7T8dn0cxMytCd4A88Z4lvAWO+BCS2RSElRBNQ9i4
         iI+Ky+99b3tUnqTLGLiXpbnPzDJ2+gmBg27EGCMOMxOfmenUofUi7jlVUlzJJgErv+vm
         VBzVw+fNQ2JAzPDUWUYubHrAkGYv5v9anvl4I+elqoBnM/wccdPdZjJ/Sz2J82iGl3pP
         Ezn3/TgI5qw7JFysi/CF4Xre5+kgajC6q9D0z+/rbXhFBqO5nSvh9PfS606o7K0S1yKW
         bk8slfH4rettH7FKzJeHTQLgI8vEgwpIzAkjFoeO5TC09FDuIUpRtnK3EmEEcfL/bNmN
         ynXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293065; x=1781897865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEUU0s90pEvT4hfT4qXSU5rJ24bOjblDhPsz3FQQoIs=;
        b=bIp1YVhX1TzXFnA6+FVIVAUzfs7Vvt7KT1JKMjzK6ByUUWfFGFSNnVRfvEiA7PEpw8
         MFqKOZ69greav09/rmIntUjf4w2DS/Kovg88sV+QA9l6FpJzmBtvKS5EuyIG9619Rbdn
         ko+sPLZkZyU/xP8IDfMSrS1L2D1G4gDlEr8LiW4lSMLOl/a8PP5OTUgMDlmRJlSRMUJT
         d/QDyd3mM89ThA8L2aiBDHTCYY8xLpyRBGPJhVIHb2ghW196fmtwXmIrLAT1MCAsAeTd
         ANLDwhN99vrL791zQX5ki9ngstWG+yojcBNrIVJrU9qfNX6E1pJHC8tlchHbe2LsdHzQ
         vbRw==
X-Gm-Message-State: AOJu0YwoqJ7NpKKnZlqN7+hMT0JPxVhMyv1t6wDi4oKdc7q2fp9RQGqJ
	iqWwow0PeVCccLvaBXr91FrLGLaYzxmeYg7Xeai1SpR9tEoJMpB3k1wNz/Ys9iOhJQJINwjhTzC
	RbrOPBCvUvWkHlhf7s9m31r5i/Swi0OSf9+LhVjk=
X-Gm-Gg: Acq92OHeWmEcZJrcIVgLknl5f3xltxAsb5AE5CxJXpYLN9Fy2r+YVlJv0LicrtwpTzy
	ceKnOXEXnAeHxOk0wEX0xpOPo6dluCsUWdqDz/SNs+TB3O5nHrICqJz3HsnDAxNe09vYrXfQk/Y
	2VO9/5RJpWoIXFX4qDayPHWmBWooq2pSGCQZlu9Ztv2KHsCy5RQdNZWT/4ORiVx/abLPU/19XKn
	RbSx3kTOnVKEmqCWXSBi9I+jExZ3841E2ay6iJlRNoTwQd/3ls0GPK8rw7zGkwvSSvr4wyfzToE
	Do6LgISaHySTq7QuhhvKC/HgnegMCnafYlDFMzoXrGU2TgXSCZek0kXkfOxMaKthfC+3jgAp5Vp
	ihCVaGQ==
X-Received: by 2002:a05:6a00:1391:b0:82a:5d55:5807 with SMTP id
 d2e1a72fcca58-8434cb01ac7mr4736200b3a.6.1781293064808; Fri, 12 Jun 2026
 12:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780855296.git.lucien.xin@gmail.com> <465489e5fafa9326b4a21c4851e420d344bbfdfe.1780855297.git.lucien.xin@gmail.com>
In-Reply-To: <465489e5fafa9326b4a21c4851e420d344bbfdfe.1780855297.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 15:37:33 -0400
X-Gm-Features: AVVi8CcBYZ4beNIIRotqS0HdShlGTPsplHhO3h8wRDUTXq00moRwOci60wjQJnA
Message-ID: <CADvbK_c_qBNuad6HkYTZe0MpgMSbMdYSsSAz62DhEYaEapaCTg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 09/15] quic: add congestion control
To: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>, 
	kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298781-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AE2D67C19A

[sashiko-gemini]

> + case QUIC_CONG_CONGESTION_AVOIDANCE:
> + /* cong->window is never zero; it is initialized by
> + * quic_packet_route() during connect/accept.
> + */
> + cong->window += cong->mss * bytes / cong->window;
Can this arithmetic permanently stall congestion window growth or cause an
overflow? Since all variables are 32-bit integers, the division could
truncate to 0 as the window grows larger than cong->mss * bytes. Also,
if bytes is large due to coalesced ACKs, could the multiplication wrap
around U32_MAX?

This looks a legit one, will confirm and fix it.

Thanks.

