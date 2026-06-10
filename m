Return-Path: <netdev+bounces-297421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgVgI/7ZKGpsKwMAu9opvQ
	(envelope-from <netdev+bounces-297421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AD6659FA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:29:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lDnRWEKC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297421-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297421-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33DBC3045034
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C312F5A13;
	Wed, 10 Jun 2026 03:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB702E1F06
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:28:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781062138; cv=pass; b=HIGQ3pZBWlGqhtMcxBlwi5m5+Dv/RNZRE0v0y6l8OirBucI/F7utk7czbT498M3vboAfeurITW2LWjMGIqh5pDIB1phcvqPZQbv8XHbkbRMCP6joj5blgbjYnccWN9yUZP9JyXaVvoXDh/SmKd20Anb2dZ2XxsBMsyNQEVgFCoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781062138; c=relaxed/simple;
	bh=AVyxrK7F1hivU1KSvYRRyBdGtfS4Ey6fmUyTva+EX9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFU7FWUnMJPptuh39Dh5fl5eq55xBOH0HIgMHzKXjHNe7Ae+U5IDI8kdxe3ldL9ip4IBKxpsZRgFFJis3G9tnFibg/oBpFI89LK4PHzWfkuIqJM2bzjkYS/htLuq+j9nro5KR3pEK0t63W4Zf73GlsU+j63SjLGbBkv5v/n0zw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDnRWEKC; arc=pass smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91591f19716so770773985a.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 20:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781062136; cv=none;
        d=google.com; s=arc-20240605;
        b=LLQbAGf4d+W7IQKekl/vsrSCQAg0KmxBUJuFXwdxJCzc0nvZzwtbU6OJsuSEIlnTjp
         0CnJZ0CweUFqJ6JXkWsK/KW8y2cKLtleowFhwKmbIq1hsqQixavf5LZWHBA106dPdauM
         wcxlxKczLey2t6aYHbAinyvt0pf+S5+rbqMS0dYIdRV0xfcdzhc4Vxe+jM7TAeoKLp9G
         1DW2aZZRxd0+YTXObQZdAG5qzLVi+ZE+ST72t1q4KPF9zxTrh3Ck87PlTTg5kjL/z90p
         WYNcueIOMQ9MImjKlegulLYPpHiYxWuTSBSK2CGgonyfh3KvMUGTqEuUip0jbv6/gwmZ
         S2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tOMr6MR/E886sg7UjeSOoJLRUlxQEJ8wFCxpIB5f+Ew=;
        fh=3CMiqw1PDygEvKa8IohPNJyNpxgORWpK46Y1Amk9ZAo=;
        b=fldLJyajcJgur/nawq5sIy2rXqtRv/tpOqavXm1F7a7fWsWqHFmShxTlE5ZYF70Sma
         J4S60sSU6akj/2/WKoBq0o7KnmGaymmRq6sEMHpZKq070+GMjiV+H8zqT66zFBOVIrLr
         saXZOabF0z1i9C8TATvBvP5CWDgsUpeXo7w4y+yD/K0pkGMaREtuxjNTURCBAyZIPwtd
         tOgnKCf/2jETIhVo08HCl6kbEEU+hrXa2+QqNsMJMDLnWlI3QJsTtcALOCLvXsc4W/IA
         4WPA8na7ZbdoVXmGbh5Vr7g+wtPxDzMeCOX9fnzHpj7WudFMWwk/ggpQyxfKXYQXy9Li
         qf6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781062136; x=1781666936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOMr6MR/E886sg7UjeSOoJLRUlxQEJ8wFCxpIB5f+Ew=;
        b=lDnRWEKCnxMLFdklnv0ecpHkKbigKWuDRCEK1iE5gXL1U9BEdNudBN4spMvOWyDWnG
         TeYA4p01VrtKZCl8YHO6Mn2QnBhE+XLypFVoVPZHAaVXVY+8fU/FWDSCDqI/lTPjlvFQ
         OiXHL9MVGrAqnvrZj3rxsTn7tu2izNeoljL54tPXaeewUd/UdHE0bQme4IbSdgrC0e1e
         IWNuofihMmC89gT0Ifqgi8AsQ05rHQ8+Tkz+oQRlULa+/AeH8Azq9y0ibVuAFJ/GQP23
         PP2xe/U9bqaMJgbFSttdvlkEPYIWRqJ97JKjZxOa+4bftl+e1nhqb/AONAxrtSkd17GB
         jILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781062136; x=1781666936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOMr6MR/E886sg7UjeSOoJLRUlxQEJ8wFCxpIB5f+Ew=;
        b=Oh3ZPN4LDniUs3eO1KA+8ra0nkxkHh+ThFjcaj3/jiTLfpiKRK8xz63ZnB5wn0Sxo2
         mZhiuZ9iJjYf+63/GDuuC3+0fR5bOPtcwu6dki3UIoauea3K4AEECxe+2RI3aVBJptUH
         G8hpb293G7Vv3RlrI23EivF1796rPZjWduhPm5gzjCphyfUk0dyJR6nVDUeD3jtI+M0v
         eC6mQhbZQ4vnHdnzWGJgaXeOI+OUWQKl+tztYLN899kI0ACE/Z4Q/UjwFJmYxUWLm+P3
         qTJFDxeXMAswDkMcOPtczBtPTZjJugiBGkNEr/EICrvzua3keebOwFJpi/LGFTGegzpp
         +ljw==
X-Forwarded-Encrypted: i=1; AFNElJ/mM5mF8VE9D3ECSXHY80FxiyVNV1zWdN9D4ZPw/j/pgn13NLqwQ3xtKb8gmY9wV8vKBU7i968=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7VyIDCipn48ISMkqmE9hXTspYDnas/z65vdvuei9/lBK+RLbc
	etyg6MbSZIEmH5Zqn6mOnaLYO7UrbkpR6tLcr7+S8/bjBmvqKz3K2lRWVKBh5ehEKsiRhiE9woc
	7ZY936bes9QOh8FgxjAihqn5wLdF4n3ZCyoGPVn4F
X-Gm-Gg: Acq92OEm29DYD30pdHoC5D+digVsfr8EJnlCzOzDyuvP/kYRrPcdXhykC4H/nfDOQYS
	Jh86wjY2CPFMsMih+0bvp5MaImgfbWmxztwSxEZgnfIHGF5xaXgEFlyK/N6aIV1wejJi4boFXpO
	5CO2Q9ZF9Xhufwi1G4glUiTph1CT+iV+IzXlvJ9lGuDzypWFkkdMlKcL6g8f8gO+LyXz5H2arzP
	1XU3r4thlxwpxUXHqvPiJ7hdUARs/CBY+dAuq3BnWfsNqFAlbvrq2tA5sFr7gLIC0wmulayyRoo
	/8utif8jaGN8gR0RJx90VJR6dQr7+tq+Fnjz6Hc9lAeHah5CPlzodbg3Zijv+ipffejsb9Rc1TC
	IEam4CnbmNmHll5f8Heog37ezKCW0gQ==
X-Received: by 2002:a05:620a:1d01:b0:915:9e84:85ee with SMTP id
 af79cd13be357-915a9ca7655mr3552654585a.15.1781062135550; Tue, 09 Jun 2026
 20:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609001013.1234755.d884b9e2028f.codel-limit-zero-bypass@trailofbits.com>
In-Reply-To: <20260609001013.1234755.d884b9e2028f.codel-limit-zero-bypass@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 20:28:43 -0700
X-Gm-Features: AVVi8CdeUEWKnGQezRCub004y9bj2mJhlndRNE42M4jk0XLTxxVNgl75mYQiFkM
Message-ID: <CANn89iJdrwPtMkexacercdV+2qDAZ=JYwGjW8xA1aKZTk3muhg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: codel: refresh CAN_BYPASS when limit changes
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297421-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB4AD6659FA

On Mon, Jun 8, 2026 at 5:12=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> sch_codel and sch_fq_codel update their packet limit without refreshing
> the queue bypass state.  Changing the limit to zero can leave CAN_BYPASS
> set from the previous configuration.
>
> The enqueue path can then bypass limit enforcement even though the new
> limit should prevent queued packets.
>
> Recompute the bypass flag whenever the configured limit changes.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

We can't change sch->flags in a change() method even under qdisc
spinlock, look at __dev_xmit_skb() which reads q->flags locklessly.

pw-bot: cr

