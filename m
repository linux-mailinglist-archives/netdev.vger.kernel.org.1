Return-Path: <netdev+bounces-289373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO7NADM1DGoKaAUAu9opvQ
	(envelope-from <netdev+bounces-289373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:02:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE7157BCD8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21A47300E602
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DF4657FB;
	Tue, 19 May 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckEu7Kx3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4D3E1220
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184274; cv=pass; b=jKUL70IOtgu4arI5eUNNQK6tKSx4xVsECyBao9Qn3vh8SObKi7uT7uB0rGDME9/9bngSIdfNF4Ij1ChMief8t7SbaXgH10iqvTlGl20RL8nZImHl98uERp9j0BkjASlSikA4YqQ4yhyenkZMx3KWkERzsD53MeuBWDnxN3gfipg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184274; c=relaxed/simple;
	bh=TB/bJKw7MHs8Q9hGToh22DreZhJ4zZwPmafVNxSq/RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5TC4UXfIL0d52dMrWxQ6M7Ku2yWxP6anPUaO22LlQRuMGUfOlr3SZfEAdwFPaEnUqAGSHbUnE9EwWND+ZcldfxcOywH5rAsme1FuK+Z8Z1EGAteCqPzWKIyn4HB9bro0e8uhV0o0KpaFvYcKxc0vmnAWodQnlg+iQ+Z3YGkXAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckEu7Kx3; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ad135063so25751425e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779184271; cv=none;
        d=google.com; s=arc-20240605;
        b=jhWhW22Y6K1LR8aHVqpkp5NB5RG7Yb3zJVmhhdnva7zovAOZXdqT3/w/6T7RouVQSX
         IkCl+8/57lxgRlY2p86F58w063EcG5mfCzKPlXYEM5raZN9kVtlVRC+ZRAf0HZSjDUBO
         tjNkNye5WBUt2VU9nsasQF3chirMe5ALy60kQbNGbhUQGDrKYsk9r9YFpBwqrcWwQtTC
         VPsh8pSnAsupV0vhdvv9QVx1VJPLeGLYfBb2zYReln8HC4msuraueQn1mvItnPB6mnOj
         +f6q3I24EQt2sI/Q2FUtp4pm3sMTMTQapG6NtsE73oKuM0stHmoI19oi9yXOG9dl0K7S
         DIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzBciGV3pvoJiMk74fETh4aCWpr1Cl0HORpY1+OAFd4=;
        fh=wLfur8T6QYqHmd6C9lAoU08LePvM7BFqgdLPC3QYJdU=;
        b=RJIHNVRR8LZ6EX8mReWD3nEPenOCjRI1D0VbfjSH1PJSAah3EWj1toCQR5oEWODPAw
         bX93k7ZFxVNY/1J5ujOdPCvf7+Lpg6z6/zAAnKXTIdN3vhPpfjNqhnckpvtY915mrzQ4
         nhgn0jNwpFgt7QFTzpjpfNPEr5UALq34pK9mX81jy3OBMr9dezZeJ3ezV/ex7aVWyQtq
         6OFn8j8ZTi4Yn6O3XbrpTGUvdeoX9C526DL3gkvYxtJ/qwRlM/kfilWAY15/7j+G+6QL
         t0VXarQlDxX3dgDFfiz2ETFiHB7AeVMZ/nJDm8jJMQsSplGOjnNUX0w6qlc0fyeOb6HZ
         j9aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779184271; x=1779789071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzBciGV3pvoJiMk74fETh4aCWpr1Cl0HORpY1+OAFd4=;
        b=ckEu7Kx3t1sXVtdmEKKt39iV3kCD0szer8wpESRu/N4HPWaE9oOJmw/i9fco9tFjL4
         SzlOwOPMe7wzskUQ0F1VhemS8ciRtCZgqRuwZJQ6vvNcPzUkw0KgkMlQB9gl2r8Z0o8c
         tY6OXD/jwPJldZVYpwmFNnLdYdo6pMbhF9DSxfYJnZsmMrsHyl7NsGJo1/1bGgL/Nip6
         dPcJUjF0v0O8ubM6U+Svx9hoJk6UKhkYVp1xCjeIAOcI/h11ot/n8c8JgxNit//cgTZb
         zdvCHxVRW0IRWDUoXb4gVHmK3yiVSxRwHGH0+TtShCaQQAuxTa4kCvgcLXuBXGI+DFmn
         sMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184271; x=1779789071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzBciGV3pvoJiMk74fETh4aCWpr1Cl0HORpY1+OAFd4=;
        b=AnPMX9gEWGigdWp1UW4k8Gkb2skIxi0SadBKBmp43omODdpA0Etsr9uu7qlWvi2cpJ
         L1zO0oFUb+BuAsiq+lDvblTqFwJeHIG05/CO5HXtJrTc81bD/yslu+0GSwFHJF0fWzjY
         VuXCQxMN0V6JDAkAN1RSV8ze89EjiUI4WN1nyg1CrrxyZ4a1OUN/odkx+Fk2dzz//Yta
         rdCsqZ4IbbHw1v/DyC/URlWgV+f9S2xvweBqUOsZubc/5DIK/PAh44EcAAkb2ZMJQlon
         2ZEWGw6dlFnln9TmdpGIxIwunujFwwBEk5fNa18pepJSf5trzIVPaSABDR1B2KAh4yjA
         kEtw==
X-Gm-Message-State: AOJu0YzZ5WvzIGdj+SEqK2CwpzzNiZnHkOZk3cST7DpsiKPdqQ2cblv2
	Tn+Pl8yK5TSGnhH4tuFlaGEPwb5yMS4KVglHA5Th8h20aspvhjY3Wj+jEJUnG9TJYvR7feOSVsP
	8bgPEn7+q9pP04AljcR8LRIy8Fw/WxY8=
X-Gm-Gg: Acq92OG1hXWCMUgDvcsxhnaE55544vjE3O6HBmwv+PEAMr2jVUG5qeIEcFUo1viyOXo
	yhULm6DngKrY4irpO2Wvv9P5bma3cYXSd92VMtdot7W5IOi8YAgT56dSDdZXiJt/M+Bo6YVxIeB
	QxgnQUlIehmJO189wAO8rWISSLJQRhPbLm3Rq2Do6D5O+wTyTvdV7qlTLuFc2of+rdF8OC6efM1
	yjH0THZu0VQelaqfsmrdjYg2l8DqTc/vH6CVLojVf5WvQvqmTaUqPTMUjAlsWYug2eKgxFeQoWr
	DmQG7A2zbjp25zmh2A==
X-Received: by 2002:a05:600c:5296:b0:490:31e:d6f4 with SMTP id
 5b1f17b1804b1-490031ed905mr176358885e9.18.1779184270955; Tue, 19 May 2026
 02:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518164029.439928-1-houminxi@gmail.com> <20260518164029.439928-3-houminxi@gmail.com>
 <m2y0hfu41y.fsf@gmail.com>
In-Reply-To: <m2y0hfu41y.fsf@gmail.com>
From: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Date: Tue, 19 May 2026 17:50:45 +0800
X-Gm-Features: AVHnY4KcYbYyx-kseY_JI870sBNRUaJeN7IBKDXDbauadJ8hFG6-pioM-7K-T2M
Message-ID: <CAJ0BgHc7c9h_pOmGQjjKLZ2-dz_dvo8XxwjbUrPOWSOz+11g_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools: ynl: add unicast notification receive support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, aconole@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289373-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AEE7157BCD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Donald

Should I re-spain a new version to fix the yaml check issue?

 =3D=3D=3D=3D=3D=3D Checking the tree with the patch =3D=3D=3D=3D=3D=3D
New warnings added
--- /tmp/tmp.2uYmXlzyoK 2026-05-18 12:59:32.034644770 -0400
+++ /tmp/tmp.UAwK6To8IX 2026-05-18 12:59:32.187643683 -0400
@@ -0,0 +1,3 @@
+ovs_packet.yaml
+  3:1       warning  missing document start "---"  (document-start)

+
B.R
Minxi

Donald Hunter <donald.hunter@gmail.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=BA=8C 17:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Minxi Hou <houminxi@gmail.com> writes:
>
> > Add ntf_listen() method to YnlFamily for binding the netlink
> > socket without joining a multicast group. This enables receiving
> > unicast notifications through the existing poll_ntf/check_ntf
> > path.
> >
> > The OVS packet family sends MISS and ACTION upcalls via
> > genlmsg_unicast() to a per-vport PID rather than through a
> > multicast group. The existing ntf_subscribe() couples bind()
> > with setsockopt(ADD_MEMBERSHIP), which does not fit the unicast
> > case. ntf_listen() provides the bind-only alternative.
> >
> > Signed-off-by: Minxi Hou <houminxi@gmail.com>
>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

