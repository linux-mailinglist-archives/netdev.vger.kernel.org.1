Return-Path: <netdev+bounces-262203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GySN/RKo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:07:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D951C7E9F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA0B35ADE28
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3DD3E559D;
	Sat, 28 Feb 2026 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCj3L6X+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9FB27B32C
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305664; cv=pass; b=kE1714+AcXkFjcM4v2/uyvMHMRzwNJqDbat0kSCgVhKkYNOMzQVT2fXP6ukkdzACmLrpPpKamPIAyFCr3z/uXP6uhoDRc5+nDktI7FBtnJcllNTv21+WmZ6flrC0Ivel3iQtVRLfyOgamIw40/7lHA6g9sXq2wief/58RcXMgqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305664; c=relaxed/simple;
	bh=14+R5nE+M9ItJChGseO6U0qagpODFKbD38ujYs+cis0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1ssBI1PFQ6Y3yIXp8h6lRj0D2MD8KDpahyjnDjpOiM9dXCnUR17UfYcFAVXj6M/KneHEDwa+He8WVHh9ArG/9FKCffE+a/IcI3IcYZcdBtrdYW4KPcc+1FSBrBERmGYGkYJAL5lcyL51aIB2vFkDpcMWHhDf5joakJ1uTbAaFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCj3L6X+; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732165d1eso3339746c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772305662; cv=none;
        d=google.com; s=arc-20240605;
        b=PzdAr09z7nYopWz0kIw2eLjwdghSlgIowzHVNgoqAWcHHu42mPrd13QaL+gsxrUOxH
         8CflYyxoXxk1asqrplZvKWaXo26pv/8iD5Fc/PXk/r/WXg4hEUWZ6i6Ns/wCtDwP2ICo
         Npn/svOvRhO2SN/3K0JpM3wjLDkRt0XSAZH5Cf5As0rxa7TGYY0rvTG2nTsGOfJI5m3o
         3tg57D+/1yPBY1vDvIyIbUsbGx690I9/0WhtUcCZtHOqlYZZ/UYc2tm1evwlVJO0du7+
         KaxOVdV8nt8b+MUXFMA6qQBZ4uKREbBN2bOxiWY1RfyncKqy8IzVB0Ttrue/voGQWH2K
         jXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=14+R5nE+M9ItJChGseO6U0qagpODFKbD38ujYs+cis0=;
        fh=u3ApkpDtcnIEOIDjAK0YN4SXull1EDqdN0WbOAFC9UU=;
        b=VSJPoxHGP2hVyqQsmTymY+ERlPB+bQE89s6NQOJC5uL4V8aL8fi1u0kinZvp0b96UX
         knPN9jlhuYkQCI26/V4eS1BVh/H7cb2ftJNavGMOvbaDIX+2p6WXYEGdtwz0nUiXgKCp
         NobdYmoGmTe0DI7y8TgbwOc3QkfJ5wXenuT0H5Cy4PgSAaq9zQZf/7myb1Pv5+Bpj7jX
         d/QJkHJWkOWJUuosFc8CNjVi2L2esYA16CFe+21XpO4rukM2tdWk3gDUaFdrokhn/H+J
         Odt+T3s9ixS4BD4bhhgU82FV0qUokBkvIen+HeMvZTFggaJ56hoXR5zTiMUzabKjyfwg
         TG9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772305662; x=1772910462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14+R5nE+M9ItJChGseO6U0qagpODFKbD38ujYs+cis0=;
        b=wCj3L6X+5mzbS+inM6wVrKlF6W8PKyyaMjKsOPQ+Y/LDjoPrRKEldJQKNbPS+/z5gc
         kvTjxg4ycg02iDy5SsLBwmfX/rGfKhYqNq4Tq4zk5MXMnAQ7xUtx6jQ688FD8rchxNCJ
         snwtw7wCrb5mlMzcSTycV+oE0RUyBaeqzOiqv0VSC1qgPeJdGRn2/nojErkD3fj9FILS
         H9J6N1DCsnUJsW74QbmucoaG/peL5ToaOYR+TiXyaCZDImLSxdNu6yiYUHFgIj12JKjl
         h8wWw4zZmidYhLwPNMoJKfJpb/WjvZUKXZKz1VGeSKj47OYdQxTk3lKWdCDJpXUQ7v+B
         EW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305662; x=1772910462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14+R5nE+M9ItJChGseO6U0qagpODFKbD38ujYs+cis0=;
        b=O6vySAiCCcOo5Fzm7SNYiJZYEuXXD707HLlmTShUqFmMQsFzfFN4Jv8NWflY5rYW2t
         zEKdY6sF56KKVuAiYUzIFC+T7ixFmNz+wQns3ePqS/vTIdoZ3Vq45Qjm8BR92MVnBnn4
         n5wyyHCLJaaKBNQDz7JRTJORb51zpS7Pw0eeKTfylulA5vb7UUS1oNwjTmB0CSVGzftB
         Q3MaUJjLDHTEBx+9SpGiWMS+cZKX1LyXPeEQazu9WmK23g9fTnt37WjjQqD9g1YH7KBE
         zo6wmRxb3pxzieNjB1MXdt4If+dmR0y8Irp32/AlkY642ddIxZUItyJc4X+zo+0u9SPR
         oj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdQfCro/oYejtoXbrG2Fmx4p7UZi/Ls1PmCB97+jF8AuAA0XKnet27JLzjQ/AEChrEISUBcyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAk1TO6Lz9wiM0KdvjjfpVX+aZyyZCFpspXnUe/zDYtgesx4TW
	ioLICVrUUHTwiO4cBfUAvrG9A4aer8NgBxKAwWEhDNPwMrZSUx9oIn6wnI8zWpBJvHVlXPqekH3
	PRm/wswzpdNOi/Vg6fwEasXL/+oPQC6V6OHUUwFYc
X-Gm-Gg: ATEYQzyoEGNeFOOdkOZ4pG25EyRGyc6/Z8u8gVneq4xs/QhXxQWWukjKoaChSq4+Opl
	SFsQTgFMGIkXouky9/qMzDps3UTQt8E6tTxn9HI91pq/hftp9K2+MXkXpdAmPfjJ5AD7UbfGaGT
	l8eOfdWfddN9Kv+hfE39KSG72PMTjh7EZLsknz0ekqLszMj9QN4AVzMuyw4IpkKFAQrZj4Ymsyy
	JZNAKQlui1ayj7j4l6btFUK4/bvgq0536ViSs6++oXVJ8XBfdLSXt3Fksbpaprz6TR2El7mygHY
	Ubb8a0hXyWhrXP+j7ddIJMv91IvSUkvJmZD6QGDieLpuayQECGMgUDCYc5sp4Dfg1JYth8rB
X-Received: by 2002:a05:7022:69a0:b0:119:e56b:98bf with SMTP id
 a92af1059eb24-1278fd1bff1mr2544200c88.38.1772305661920; Sat, 28 Feb 2026
 11:07:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228175715.1195536-1-edumazet@google.com>
In-Reply-To: <20260228175715.1195536-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 28 Feb 2026 11:07:30 -0800
X-Gm-Features: AaiRm50Y_lqQbxKks1likExb06iSKY3Bx-7AhRs9xMSN6opMtD_yBeNtQiZ2Z0A
Message-ID: <CAAVpQUAM0gPpa8j49B61GzjpfdpJZ3dXAJ3ktD+p=ok8jwmy2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] mpls: remove test against ipv6_stub
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262203-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 49D951C7E9F
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 9:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> ipv6_stub is never NULL, let's remove this test.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

