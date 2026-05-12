Return-Path: <netdev+bounces-286877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMeIIR1wAmqZswEAu9opvQ
	(envelope-from <netdev+bounces-286877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:11:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0604517C83
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4E033021E7A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B55137750;
	Tue, 12 May 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI/Ujth7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E672621
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544615; cv=pass; b=FILggORmyrta3qb0hOVy7KMDFVk18JpxkhyxFnm1+Yok75bRj/3QHx3MqK0Yzz07HAtswMDci28+8Roj8sgs+klYwHmBxkJ8xoRlmZanZxCZOKSgArn1BC5ru9IZ2H/K8+3Yvh/vZfyrWHmTjcgcKfq1c6CDWC6jxjpHXtIp6mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544615; c=relaxed/simple;
	bh=Nav32E1ZhKus7lBbmXoYa1FKgFA9x9p6nlTH8DJM4E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6GUG2ThtmwLJz0hKolNJudvIygM38d61yPdq1OBm7zlRrJdBuStKnV9dt8zj1nea7Yv40Q2zz9+ZrRqtDXS0r9ndWotO+O8zP3BH8HpI9+MEjKp1Elg0ZR0szYtvt6sFgjDfqgYHVKQ2qzcx/eHLe8A6/qsG6nrscSkFLLL98M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI/Ujth7; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-13246950f3cso6128222c88.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778544613; cv=none;
        d=google.com; s=arc-20240605;
        b=jF8K8jTWmkQRpFEswgJnfe4+uM8X6DQOUQFmFCTPpVkUayRF0cKjU1URp4p5N87z/f
         HmGIzcMtOG2OHxWN0cp5JG6FFBlIRNS4+noxIQga8WnW7WQW8WFDnULxK3u6B1O8R/YU
         yJUCUSyepWNUVLGiPdLmwpGiktlB93Z6FVwMmL4RKvXYIvcZrEQd+IEw3dQnOxP/mOmT
         nOEaIfk9p26cvyOe2D5VZAWETppHhtbWCgSK1e9LZWGLuVVWaz6RmwX1vJz4Sa7VHvkJ
         u2+YdlkDDerlDT/r/8GiFiAA3F6bkSIYzexl+qXnRbV+08ZIJ3NCOLp0tW44q3kjSBfF
         AKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nav32E1ZhKus7lBbmXoYa1FKgFA9x9p6nlTH8DJM4E4=;
        fh=DQdwxDu658r2nudQaOcGSbwUfOrUdw3zQh5t8nyZJqA=;
        b=OJyoh8EOYkElgsCOMsYnbqfQq465ctfY6J2CuF0FUnoV2k9+QlRt6AxtWpyOClCfkE
         q9V/fFKQEurDUbWsfVvXhpHQrh9FMbyeOr0vvdJSZB4BTTYGCiU7pjdGKtm1qJrGw9Br
         TnFkcGqI3RYVZ2ZYrDE43N/jHKvQJMYh4eSyo2m3FuNj5W/io3wQp2PSSz3LhtCsMqYT
         mRISGusF26i2y9159rEt6FcHHPrHwT+1FFiqyiLpclYb9ecpXb0SJAjOU4I7dkt2lbD5
         hjQnt2VoeiAneoiwIGlSRolMIXfNzw1xrUYSBwf70BY10xGt/C4E6X3SY60JTx4J0gV6
         7Iug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778544613; x=1779149413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nav32E1ZhKus7lBbmXoYa1FKgFA9x9p6nlTH8DJM4E4=;
        b=RI/Ujth70USgRYYQTk8AZSp7u5kOwIW1tdxnveQc1PHpAIDa6AiJqp0R92jHesUAY4
         0B/FjYRInF+rzEUhaW1/3sZOW/D2X34+W8FcdDIPNJvbgsWzKAs7LnE52Z3RQ4Y/DCJO
         3WkcCDaZkSwUaeI2tJAY0Wls1M4jyFRxfPGph4SHAQj0o7sc5s2IIlZc/j920ymNellM
         ftzW3GMd4VR0Geno0Q/KOtabFmw9kg7v0TVFE6XLGGR5uZ5A3f0ab40/gBMrYc/vcv+8
         H1rfnyUcawRZkyNwjYCSVWgHsVxloLCa/LwgUY4JHKgi7Qk3+huxgVLXa4u0GF40qizW
         a0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778544613; x=1779149413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nav32E1ZhKus7lBbmXoYa1FKgFA9x9p6nlTH8DJM4E4=;
        b=Zm3LACE2mlo/SXOJ25xw8pKC9Xgw3QQ7jQ26Y8ZpRQxBNj7rBLebsY9x6tOCh1mTyB
         tdHiUiWvNwlUPp0rZlPxchGyGacx9/utY7N4RResaCbBCvDs2IqqyI0FFDYrNfUo2UG2
         FJL8pFq2Evpqvec247ur/2OAhfcEAtUM/eM33Gay0yJu8eowiWm4jGNvl7nSZXqhqOf9
         b7fObTpPZUNiU9RiG49xAYRmLK+qgJu/lnJC6Meu/TqX/jEVhaCdos4YOp8UP0ci8OMe
         A04g3JegMCRhz76sSgjTRPUV6Sx8CpDiPPSz+ztp9EEASqHPHoE0+jwLZsXNL29cqM67
         U7Vg==
X-Forwarded-Encrypted: i=1; AFNElJ+3H6oVijalwUWLRpxLHxd0OOW/iWRToWlBpKx1HV5uFDfv5SmrnJufqBP3lvOWPgazGClxQEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKzAGWXc3z1wzYGS0iWftoqaI2GiYGxQJ9B9Y4KZe2WkQoxyu
	OoOmcFr3aqgNcvGxpTWMIl6cvpd3sC/JTU4jknF3Pf8hn7Olz0jqCAccrfqrhrXhcXDj/XJfnJr
	+WtKJtTqcEIW3YQPzf6Cd89Y81Gdp/os=
X-Gm-Gg: Acq92OEZ1dhyPSMEJNsvILfWDs5hKU7U5ZxnUMUs2gnSYl+iYRvTVKw3DvwcV/WxuQy
	AbCuH3ApOlO8oJZKdfoHeCeyl6qcqxFAyMuineG5a9zaRQGm+wJ6/J8ZezuqSSaJAbITbvZPkLe
	n27qDLxS/4M7c/HlIG8Wdu+WXsIoCOhcqO/r5f4QB6ABPkyFVLceA1SZDQ4hG9D9fn0gY8eNE16
	iOlJ7JcF8M9BhqLxL2qU/c6e6eq7Lm7Z9faPb1XwoJl6p8w+AFT8vuPdS8EAZXwRUBFEPDayshi
	6IlDtjo=
X-Received: by 2002:a05:7022:2225:b0:12d:b205:c737 with SMTP id
 a92af1059eb24-132a7af0230mr6558239c88.17.1778544613263; Mon, 11 May 2026
 17:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
 <20260511161320.358cfaad@kernel.org> <CAFFJMPzw8pcwX9g7iv3F=FpHQyovUgZZ28P7XfH3gmiay-JfpA@mail.gmail.com>
In-Reply-To: <CAFFJMPzw8pcwX9g7iv3F=FpHQyovUgZZ28P7XfH3gmiay-JfpA@mail.gmail.com>
From: xw x <v3rdant.xiang@gmail.com>
Date: Tue, 12 May 2026 08:10:03 +0800
X-Gm-Features: AVHnY4JqKmu46_bTEFE4KXbwU7WrD3lLWcd1BRnhL1VnnDpepuyyL7h-S9y8kms
Message-ID: <CAFFJMPwtWZDrD0=hANXk2cdZGt2ArQEWROGRswKPyiZ+FrG1XQ@mail.gmail.com>
Subject: Re: [PATCH net v4 0/2] net/tls: fix UAF when TLS_RX is set on sockmap socket
To: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: jakub@cloudflare.com, sd@queasysnail.net, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	Jiayuan Chen <mrpre@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D0604517C83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286877-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[cloudflare.com,queasysnail.net,davemloft.net,redhat.com,kernel.org,vger.kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 7:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Just to check - how much of this code or the patch do you understand?

I think I understand the root cause. Based on Jiayuan Chen=E2=80=99s
feedback=E2=80=94that we should deny TLS_RX attachments for sockets already=
 in
a sockmap=E2=80=94I've prepared my patch to do exactly that. Do you see any
issues with this approach?

On Mon, May 11, 2026 at 10:13=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> I think sockmap + TLS_RX has no useful semantics(fix me if i'm wrong).
> sk_skb sees ciphertext and the TLS keys are pinned to this socket, so
> redirect is meaningless. And both sides racing on sk_receive_queue is
> what produces the UAF.
>
> The fix should be to reject TLS_RX when the socket is already in a sockma=
p.
>
> Note TLS_TX + sockmap remains useful and unaffected.

Additionally, my changes seem to trigger a failure in the
test_sockmap_ktls_tx_no_buf test. Specifically, it attempts to set
TLS_RX on a socket that is already in a sockmap within
init_ktls_pairs. Since I didn't author this test, I=E2=80=99m not sure if t=
he
TLS_RX requirement there is essential for what=E2=80=99s being tested. I co=
uld
use some guidance on whether the test should be updated or if my
approach needs adjustment.

