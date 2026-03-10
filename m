Return-Path: <netdev+bounces-265982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG64CrTxr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:25:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0D249560
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F77F3126C4A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC823E7179;
	Tue, 10 Mar 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtQcZu/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249C3AEF4C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138257; cv=pass; b=Xh9p17xv3snbVS1OBhIAVLNtCtd8HCj5xAECM/1VySqQeeUtCLneLJSuLP60XGfqxxzjE8VdSROqqSpKfSFSh/+uJA66Xyr91eRTixY50svhyXnuJrofN9PW6nmEb/TYq5EeI/eN7Mv1ljHDYxHyU9tNmeKb4sjGPMz7hREUZOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138257; c=relaxed/simple;
	bh=KED1USN9qGSdhzd02iHp3mLXob4EqfERUJ89PHWkvhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAmJxBkUZsx7WbzlCL2Y6EfuYeNE7MB1bDO8UK5lGCoYHO2P9Y3tzWl9zIro1Qu4+B9Poy6iBiT7qx9AjJaJ7G3FNqnCMjjAFmXWPWfs0XbfoC4GmqsinGgLImNGL2xfMuao1E+akphArhJEft5GbxMJmkhWny17Z5QrMaeGCmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtQcZu/o; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb40149037so1351006685a.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773138255; cv=none;
        d=google.com; s=arc-20240605;
        b=J78uLP7CeoakkuJYKjTsX4p3nCXVnFmeQ27RFn7VKGykLaTcFE5pbqPNYK0AuaheFy
         I0kYCY4esEqjAaCZnDtytLHjQsbf24YU5thyKlCB9xi21S6kwJQp2BjHB0yIXTQd0QHt
         uN2QGUcqWX0zIihy5KU+WVKJvD3yTFZRjh/aXaYKKfyL/EoGeqdGQwpEvZsEAl8fYeL4
         WyRQ4TVkl3h1IsDJi5Xq6zjtCV1CNYPkYHrKBDieorue47LO054FKiZMU/rU1rD9icsd
         Js+SH2afkIf461RZV5R/9dGHFCnL1+BU3+r3QbN+T3dTUzOHSRoNxGEZdFkAZesHQ8OU
         fXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+93VfqTtOd/2Fz2y7boXGRznfmsClCZhtRbObtkOrJ4=;
        fh=hux52t6MlBhOPQx3OzcBGRN8RbvhBSDNtwq9NLkK4tg=;
        b=fn1rCNRDy56uyQdPX7ETO14OBlFv75ovbonk+pYn6H2lMILp0bUnCLmXmV4gfji3zS
         fVKnyCQyvKjdLl1BjfthVYm4hZUngYAuSSxrxveKV9yB6fn6xnSy22RksD3RR1PLx+vz
         RtaxeeRpUziAv9OK5HEX8IZSkVnMlSBIGT7bVZhke0T44+dboSfatgg5E1TYGnB7/hA0
         ZwhQZhASInwTJEIRbLSqsle+2dzwa5snUasfqhzOrE0pIebtSexdcY7DOMaNsEB1hCym
         8YhWzl3AAlElnr+LctiMJdv4SWa2mltvpy22zPkZ75iwlbFIYPHuqa+k18OqArStG/yF
         SG/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773138255; x=1773743055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+93VfqTtOd/2Fz2y7boXGRznfmsClCZhtRbObtkOrJ4=;
        b=jtQcZu/okRjcJhG9vE4lAHMIlKH78v+kNCao0DyvlKPuAAPaHmHOMGRWvIWg/hQ8ue
         COJZPHS7Hz75xNrGKKVgEkR8bFe66sXbnZfFk4mlz//9iESBNEqqm6vWT0MiOssDezv+
         EUHwRJgfrpLeMt4O5H9UMZ/pyLpItnPnWa0iHGFApu6om4NXwMPUGwn+A6yHNz4ejc34
         WyRvvjP6HKtU+dhOs+q+e2j7itiUk9wp52EezYVAphfUoBF9AvPne7xbHKYOJsg++Kh1
         xS388FYMplbw/0P7gN4ptT3OUhRgtsa1DYTta02z6JZwU1Jm8Z3qdJtsu1htHOBjNv4p
         sUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138255; x=1773743055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+93VfqTtOd/2Fz2y7boXGRznfmsClCZhtRbObtkOrJ4=;
        b=QXCpFTfMgQn/E6ve13qcfEkdAGH5qVMlfNfP8z8ph/mUi64itf98PS+6WGmDjX1cXy
         VlMdkHquEOpMaFOAeftRMWnEp+Jffatu0PoQfacnGfbW0yqBFplp8lKdJi4Irmu7MLXw
         RxCVuZjpYFepy5Bz9RRiuYW++fEu6nh1lJ8lut84VDKAcmlOzEPLaZwr2W8NOpgAUpx1
         Y2wm/R2ErfYTUKu+7WOhJttaulHsbnO04I6Kcm/MnDy36TYoBboQ9VZG6JHVjX+0rFWZ
         rdxpS6JDhiASIdH+M+24uV1TUBwbfyjuMW3OL2NsSa4d8cuV4qn+RTSoghdP/+IgTsp/
         /ncw==
X-Gm-Message-State: AOJu0Yy3+OUc9Qw90pzUi+yT/nmeZYRndFKUoKKkIVeVZAm9sHIsXVNa
	lBd4G7z9XSCNB2nmloW4Mx3hX8CsrGJoQWXy148vB78muUqvrd99fv6qLMDeSof48t7pZ6I5X3C
	Hxa0qyFa+DfFuPRKxTjK42/AsNkaIlRtclrLoynDp
X-Gm-Gg: ATEYQzzhhbhavWbb8ixtwqXLnNw3tgCzEuJxc1HWylHpTZCPRgl9tlWfck+nzXxvecF
	dcUd99VeQM8y/lnIaxk8umVbklB3CvBrldVVSt85MOwKY/2rSClWI0inj5RaklhF4ryrNSzK7R5
	frwZjchHkGHqsUN0U7yVnP8ge9UgCPhNcdfDdppu8AT8kL1nwXZe2SWy5xmSXP63ergbB6Y1QGn
	VScqtoGZT8Au+jiRxeXVpyIpnYDVcxzeSzQLq5XkLRkoJ/kJ8EFgVBaHiwTbuUgSts/xliILtws
	ZBGxaMQ=
X-Received: by 2002:ac8:5a13:0:b0:509:3211:dc72 with SMTP id
 d75a77b69052e-5093211e380mr1902381cf.24.1773138254690; Tue, 10 Mar 2026
 03:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310101349.50993-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260310101349.50993-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 11:24:03 +0100
X-Gm-Features: AaiRm50NFF9NH7MViNvliA0vkJp1G5fS36V1ilnXLWtEU9Z8qMPMOCUnHuGJmFc
Message-ID: <CANn89iL3g7+MpkDrY8-v+Zswy5Woe_VvEMqbvHYRxQGpk_OSEQ@mail.gmail.com>
Subject: Re: [PATCH net v1] net/rose: fix NULL pointer dereference in
 rose_transmit_link on reconnect
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	Takamitsu Iwai <takamitz@amazon.co.jp>, Pwnverse <stanksal@purdue.edu>, 
	Ingo Molnar <mingo@kernel.org>, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7BE0D249560
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265982-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d00f90e0af54102fb271];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 11:14=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> syzkaller reported a bug [1], and the reproducer is available at [2].
>
> When rose_connect() is called a second time on an already-connecting
> socket, it overwrites rose->neighbour with the result of rose_get_neigh()
> without releasing the previous reference. If rose_get_neigh() returns
> NULL, the socket is left in an inconsistent state: rose->state remains
> ROSE_STATE_1 from the first connect while rose->neighbour is NULL.
>
> When the socket is subsequently closed, rose_release() sees ROSE_STATE_1
> and calls rose_write_internal() -> rose_transmit_link(skb, NULL), causing
> a NULL pointer dereference when accessing neigh->loopback.
>
> Fix this by:
> 1. Releasing the old neighbour reference before attempting a reconnect
> 2. Resetting rose->state to ROSE_STATE_0 before the new connect attempt,
>    so a failure leaves the socket in a clean state
> 3. Setting rose->neighbour to NULL in all error paths after
>    rose_neigh_put() to prevent use-after-free on subsequent reconnects
>
> [1] https://syzkaller.appspot.com/bug?extid=3Dd00f90e0af54102fb271
> [2] https://gist.github.com/mrpre/9e6779e0d13e2c66779b1653fef80516
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69694d6f.050a0220.58bed.0027.GAE@goog=
le.com/T/
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  net/rose/af_rose.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Normally, a connect() on a socket already connected should return an error.

disconnect is a special operation involving AF_UNSPEC

man connect
...
       Some  protocol  sockets  (e.g., TCP sockets as well as datagram
sockets in the UNIX and Internet domains) may dissolve the association
by
       connecting to an address with the sa_family member of sockaddr
set to AF_UNSPEC; thereafter, the socket can be connected to  another
ad=E2=80=90
       dress.  (AF_UNSPEC is supported since Linux 2.2.)

