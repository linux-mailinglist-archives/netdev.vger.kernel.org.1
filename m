Return-Path: <netdev+bounces-261606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEgvMKrFoGnImQQAu9opvQ
	(envelope-from <netdev+bounces-261606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:14:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4521B03C5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDE2C300DCE6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8E4657EB;
	Thu, 26 Feb 2026 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEwUhX95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01347A0D1
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144038; cv=pass; b=L0pMriuTNMP5SkwnGKIW2ZOFdA/xJuoixhDoDrBtQTdSqoXqIacPcVP6oNKIkql6f9hR84X3H5TUp8sj7qiCgTh0DLZAFaK+2E1LKQLgpvwAO1ZEJj+9R2mgoIEH7Z8mQVGH+mjFdbtPsca3HW375U72XOMBU6uhTOqwu8gfSp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144038; c=relaxed/simple;
	bh=+9u+e+BI92hZ1vTS6uJcHWQ8sifadcjEvbHxP26B1NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFcpjkRa0H1hy2Ts1R6vZ1hCrIgq9eaoNak4lNAXretfSKR5Ej+csmKncTVEyjK/S0PR04ZLztRUKNYOiYon3ndqEwfurXdAcrykzpeU+wtFBAduSyJRkreD/ne52KadcV9UkQkE5Gisucj1wT2XWmZrdbB8JOFuYzPsr144hCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEwUhX95; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1273349c56bso1675980c88.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:13:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772144036; cv=none;
        d=google.com; s=arc-20240605;
        b=XCAjNCKwZHk/EH/T1a5CQZt7tGjTyfq6bzBKjx5JcwY75EcVshd17Zj3ne5C3jmUEb
         cz4ZOpjZcHYppCZrBD8y85+Rw4p8eplXbXX1+gt4pSMK5IYNmUM6dfZ33L43O0h2KQ6z
         7B0y20u3qMxv9RTgNUt00jZJ9/rnzWJ1Ep3ZMJMHOMxs2CwCHSjcNpKXA5eZcWbzJzup
         nZANkBC1YYkL60NMJGtmFibLgJdnrwKEORGa1Rs6FcHxCSSl6pVTu+iW3qTlse+Ns+KK
         M1kTLALTzvRPAlrojpaYl1lxoIZ7ldzD0pdZpsa4fleDeJumgQL6Tyw5DnTj1f2EHgIa
         Hkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+9u+e+BI92hZ1vTS6uJcHWQ8sifadcjEvbHxP26B1NA=;
        fh=T9A42ZYtelaT/zV4Cm9foh7O1h5/zCCNmJAVmxcfcfk=;
        b=JJ01M1C5Gwqcp1TsKT/EtOALX4uR/wR7yEQafngVuHhekG1RactouZhSOWYBO+idoB
         zaRw00BLb13DMm/bKh5C+7r2jN0GvahdAZ3mFVq0x+hAnHN6l6bOPG81yYvb/rGji5lV
         rZIJgKWiKsSILOSkrU2CcIg8mCZX405kBfBmX5yi1rUJLB3hYajxls8yCjM0Yo0WgBOy
         GJQRUJQN7Akw0kyJ0vETuMv5cygTWHiTlv+999CRuxtJCxHJv91IoDxEF7Id831h9x5R
         4BTU2YMlczuYkuGXEK0YtBTzg8FtROMdIC4KoYg1k2k9rPDhK1cZjT9qWADJ7L8vBDo7
         nuag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772144036; x=1772748836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9u+e+BI92hZ1vTS6uJcHWQ8sifadcjEvbHxP26B1NA=;
        b=YEwUhX95JlnrsUYiCCkwsG4HFsjZW8QJfSbmC0Z1JKFAphiBzHISUgB4eltVQOZ4K+
         UmI365MY3s0wwtOUbYeEh9l/keFRdMLsCTJJiJklt53dmRQ8hlaHj352IG9h5xFW9yl/
         RBU0QWfsnqPaEeWJk2jWOi7RUGP4rq6pSidcYg1N4i1BKGEyGE1uF2T+CPK00UYse9Pq
         Giz09e1OV3ecdKn8ae0F2O/CKsgj6cTLCbrQUKBgIkDQjD16vK/mq9I9N5JpXtgqfEuX
         iameGlfGdf3wcHb2UZZzTljlLM37xPIe9a2Bo0hKPJ1m4T6YAXA6xBg4Y47DO7C+/YHQ
         ji8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772144036; x=1772748836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9u+e+BI92hZ1vTS6uJcHWQ8sifadcjEvbHxP26B1NA=;
        b=WtRr6IgBq3DrW+n16b1SXlQZOdV2L0eiVDztD2u7yHi2qmNZxnpYysf1Fqx2uVgqnu
         JaqeJ8fM7MkExXJwWSwuyDH5io+wtlh06B6goplaAU+yxRKjn2rpH+xXA9CpQxD0zd98
         98aSqmdI10dbwcdkJBrnWjG3TH6YA3DQU4LDMPef3c+l7XOuiBtS+zRqkQt6giMzlA4a
         psTw2II45ugzXPlAuDPqk9dKKjYhTLfyljDVmZHWlAEOchooMTCOBWrA4H0SFYZad2K7
         gd8MxaZbapnHJ8pTu3gvHRTbPZfMyKE7HzCZ45980hngrtzufep2CWnAhJ0XHEo4K8V1
         DxOw==
X-Forwarded-Encrypted: i=1; AJvYcCWM0xH1irLVW1tyibSnHcLoQW9S9NDIxEjsp3WJ04iirm3yLrC3GsXASHhYny55XkarQf4E7GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYAIsV1ugcPGZxPzSroNvNQVAJGIPWYSzeCQC0O03URxvOl35
	RT5iu53XN+lYVzL9pPu4uYBlas557sNugucEFLhI8rJHGVQGHPwN2JbeiLRJ014ia3vGJcpLf+j
	NBM6Vmzc2qwiGtV3IvovJPIVSFboK2gOMnIUSvQJm
X-Gm-Gg: ATEYQzyaSnSWLm07O4GLqyrgLQqooaIcuUuZ8EdV5r8wKiWft1a3+8M5coSoRlIATAX
	WgCGrN88b5YiwgaW99kzCP4BZdSbdtk3a+BnGvWXP4ivrZZ+ROP8nIH8DgmUvbcsBCIJiJf+p8D
	ChpfkVivyxOFDQCCwN+x/x+DzSngaZahojD3fvBTIB6FWxOaBQ0ZPPTGqlCCxXPf/cv/j1wP7KA
	8JUNq1iQISV8yEgeCbBIS9s6Ytosw9/8VEtcUzWnxu05x1oI8cBHcD7Vez0PLb02sjkPLe773ut
	UxTQKqj1jFzcVdJtM4KsqkoN9qWzxpcpEcDqw5jRr9MED+OoDy3njvfHN80nVdJD5OV5Sypd
X-Received: by 2002:a05:7022:68d:b0:127:33e0:ea40 with SMTP id
 a92af1059eb24-1278fb90249mr212274c88.15.1772144035089; Thu, 26 Feb 2026
 14:13:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225131547.1085509-1-edumazet@google.com>
In-Reply-To: <20260225131547.1085509-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Feb 2026 14:13:44 -0800
X-Gm-Features: AaiRm50z5-IEO27cE2AiL93Kb963BxTneyI_xMsgmlSkKDvw_e5XZAb3_1Jssdw
Message-ID: <CAAVpQUCc1LRCx5+C7_yQ_HuFZCSBAS2E6fyG9qNSNqHyhaJAOA@mail.gmail.com>
Subject: Re: [PATCH net] net: annotate data-races around sk->sk_{data_ready,write_space}
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261606-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,iogearbox.net,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,87f770387a9e5dc6b79b];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F4521B03C5
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 5:15=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> skmsg (and probably other layers) are changing these pointers
> while other cpus might read them concurrently.
>
> Add corresponding READ_ONCE()/WRITE_ONCE() annotations
> for UDP, TCP and AF_UNIX.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Reported-by: syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/699ee9fc.050a0220.1cd54b.0009.GAE@=
google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

