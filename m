Return-Path: <netdev+bounces-270103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB29Cm/TvWlcCgMAu9opvQ
	(envelope-from <netdev+bounces-270103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:08:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E02E2394
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55BEB30440B7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F116F38CFEA;
	Fri, 20 Mar 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQRWy1i/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1F378D63
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048043; cv=pass; b=CkoBjgVxWsVruViYZ9l67ZNoKzhLJBNCkyUQYbWSB5K4Zbr8iyQyQlteAXESLA1BSCn/HsQA36bc6/Kax9xSyeKixoyixBV0Zeh8t6ncZapIrZcSekVNtXgwx8laorjwuQhmbfiYpyiaoDB6zuP1nePKBzyQ/hVxTisc76xcTxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048043; c=relaxed/simple;
	bh=M7a9HCv6xXQ/DntGRCwO7vfJIPELucv5vPfhF3R/d0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+9i+dDVgI6A6wy1DeWPWpLfzjS+KUOLU5MX2NO0B2f35yxNxjVyPWYNZIfJ8GoiHOxGHMFp1BW0VgbTkFf/ueKOFKS9mlp3eLJGzkXXUVcP1Sjvi2+0SL+ESpR8cKS/L3CHxe31nwBn8j2xwCqxR7cS60t2YliPoWsOutlPT2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQRWy1i/; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so3123130c88.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774048042; cv=none;
        d=google.com; s=arc-20240605;
        b=eDo3QhR164uiVL/tk76s+VCkIYKzoVGJ7zvuq5lSNVDYgoVLYcEKozqClbPJIgkhqd
         rJwPtpk/9gXkRC9jmk29HQwtz7DJZ3fuEMIqQ6xahwObaM/I9KvYbLmpZI/0hZ7iQRNZ
         Ef/nj7PIl6rDjj/8jkZ7UMbXv/BO0qyt2HaogdOOXJ7nb5cPz18t8OjFWeMNQAc7w+5I
         dy/pInVN2Ur6uTTFN45aJsE6i+rLTWd+ey/XhyJFhZgVAixdtBd6+uYtLt+gUpt8t46P
         y1EwGotMoUCliyL8ubMN2FjYLsidE6DSonBg8xW1TRu91dC4B7aU2zShgT6vqrhx2gtg
         GeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pZo3sMU6awb3wUgXn4zUrNq93WUztpgAarKG4X4Himw=;
        fh=nJP9VWOWTFbo/UfdmBZ92M/JphMXytqpI8mQgsJdQPw=;
        b=aIqm8hUTt3P/6bHOFYBLwSMSMObdDe38W6hKjvH1wsUTBC2t+jHqjTRBGScBJVi9T1
         U74G/2vE0VKuY/1qKqos0eSTyRoVLNSP3k4EdLjytuzNGvRZptFSUKjlldyT4E1Kri/x
         bVDiz1TvYS1ZdcqBCwhR7G4v4rOAYfI6myS89IUVRXSGacqvC6XhPz+7DyF3vEmUmySn
         T6RDfW+YQo9hZESg6PK7muXcyyjxp7vwYlS33KyEynZ69Jed6uKRZQ6V9OlA0zhinz0i
         m6ngkl2W3//sPAeUFwup5WgDYon6MMrjqUEXnLoLpPjwOedGSL7ZoecSWtE9hY+pBhI/
         jQOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774048042; x=1774652842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZo3sMU6awb3wUgXn4zUrNq93WUztpgAarKG4X4Himw=;
        b=tQRWy1i/7dswyLf6cytNu+KpQe4mAPHTNao83COZGfuGAz8UW9u78OhYo2CXaM1dwW
         us9MRHLvb6ID2dHhTOm3hir/7SeenCc55tt3dbhoWlDEjwGVy/+KyRexE1JpNYaPW3Xx
         +1u09bc2kSuMOfCFUwhjIQl51UzUUsQstUsQ3yUsKXrXP2kHAF3H+QTrK7wp4cGM6Xjc
         6s5T9fs6z/6CIaQ2syDXlM4y5JCDlAH698AR8JRj4GcUy9fN58rIepHsCcn8AVYsG6eX
         9Vm0pyFa7RvoABhvqq89OkZ8GK83tFSLvZ28Y35s8CtPgMblb8X0lv985uYpWfyQzSUD
         Qfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774048042; x=1774652842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZo3sMU6awb3wUgXn4zUrNq93WUztpgAarKG4X4Himw=;
        b=pXh2Uvm/3A6J4P9fAY6tzYO7IqHYbilwMVGuvpPI3XczSxAo09OeOylSJJC9nly8IU
         GD8I9eAoKtMKrSPtHwQS3iquUcHHofxKfvej9sInncIEz3igXcD8Rg2Y5ZA3AMD6jw0X
         xTX3mY9Z974GrGdu2n+J0CgCjbmiqYqUTynnLZWoduq40/D7yyHd2f0Q8+CEvbf02rvy
         me4gxnJUj/lba8h6fFtFks+Tny19xhz6rl/wpW3aPnwUDK36VR/25m60b7Zibug8KZHu
         HEIsd5kO3hH3nANzIgR5J5CKdBGWXGJ4MM2n4aATKiIbDRpwY/rGBm1O21wXaaqjwYYk
         I5Sw==
X-Gm-Message-State: AOJu0YxeluMm1VZx1sJdMB5mWhMei9s1EXf5/1tqydwy2JZDCgBovz7z
	fHQmar98oPmxQ6PGZxm1zSI8Eekb4GNrLwaGF9yUZwAzbdXXIXPFOKVkRkJKmt2eSmACdXugQmJ
	4JI21K17wm8bvvM6M/OJJkeU9t8xiQ+fhs1YuxCQM
X-Gm-Gg: ATEYQzwFUHrGf5fUI9mJEQPSxvXPgrKpTx4urK1jCqqXE5j46EeKQNy03fWMh4qegTJ
	9lgSUeV4bqjPtCV9oE3EcoI1PYELihnaxdrhQLZQ+pYJ9vSAmtJnQybsOrOI51zCrN8Bh/JmYOz
	PEnJrtUehY46HWIuw9h8wgQ0xyb9giSCyoFp2e7MRMfbsv/mfXQfPeyx2JaeV3J6vRw4C+TJktt
	db4VSakF86QxShJSLkyFv1Zaj4yINPY7EKuUuWlqCfPoydkuXr3w6MLaOFALDQh7NyiYyzDZNGh
	dy3RiIdxAfMMkB8dzczvnfP6FfTjU/s150PCaro=
X-Received: by 2002:a05:7022:439a:b0:127:35af:1446 with SMTP id
 a92af1059eb24-12a726f0f65mr2097489c88.36.1774048041125; Fri, 20 Mar 2026
 16:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319181817.1901357-1-martin.lau@linux.dev>
In-Reply-To: <20260319181817.1901357-1-martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 20 Mar 2026 16:07:10 -0700
X-Gm-Features: AaiRm52I251yAXEX3iacePh1OECgxBmRkjQFS7og6W0jWiC-RiQFSGKpEWd19ug
Message-ID: <CAAVpQUA2JhaewkprZHccQQu20XgnHmMgZ_q6AZWCP-V+e_YS4A@mail.gmail.com>
Subject: Re: [PATCH net] udp: Fix wildcard bind conflict check when using hash2
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Onyshchuk <oandrew@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270103-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,meta.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 866E02E2394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:18=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> When binding a udp_sock to a local address and port, UDP uses
> two hashes (udptable->hash and udptable->hash2) for collision
> detection. The current code switches to "hash2" when
> hslot->count > 10.
>
> "hash2" is keyed by local address and local port.
> "hash" is keyed by local port only.
>
> The issue can be shown in the following bind sequence (pseudo code):
>
> bind(fd1,  "[fd00::1]:8888")
> bind(fd2,  "[fd00::2]:8888")
> bind(fd3,  "[fd00::3]:8888")
> bind(fd4,  "[fd00::4]:8888")
> bind(fd5,  "[fd00::5]:8888")
> bind(fd6,  "[fd00::6]:8888")
> bind(fd7,  "[fd00::7]:8888")
> bind(fd8,  "[fd00::8]:8888")
> bind(fd9,  "[fd00::9]:8888")
> bind(fd10, "[fd00::10]:8888")
>
> /* Correctly return -EADDRINUSE because "hash" is used
>  * instead of "hash2". udp_lib_lport_inuse() detects the
>  * conflict.
>  */
> bind(fail_fd, "[::]:8888")
>
> /* After one more socket is bound to "[fd00::11]:8888",
>  * hslot->count exceeds 10 and "hash2" is used instead.
>  */
> bind(fd11, "[fd00::11]:8888")
> bind(fail_fd, "[::]:8888")      /* succeeds unexpectedly */
>
> The same issue applies to the IPv4 wildcard address "0.0.0.0"
> and the IPv4-mapped wildcard address "::ffff:0.0.0.0". For
> example, if there are existing sockets bound to
> "192.168.1.[1-11]:8888", then binding "0.0.0.0:8888" or
> "[::ffff:0.0.0.0]:8888" can also miss the conflict when
> hslot->count > 10.
>
> TCP inet_csk_get_port() already has the correct check in
> inet_use_bhash2_on_bind(). Rename it to
> inet_use_hash2_on_bind() and move it to inet_hashtables.h
> so udp.c can reuse it in this fix.
>
> Fixes: 30fff9231fad ("udp: bind() optimisation")
> Reported-by: Andrew Onyshchuk <oandrew@meta.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Confirmed this fixes the buggy scenario, thanks !

---8<---
>>> from socket import *
>>>
>>> sk =3D []
>>> for i in range(10):
...     s =3D socket(AF_INET, SOCK_DGRAM)
...     s.bind((f'127.0.0.{i + 1}', 8000))
...     sk.append(s)
...
>>>
>>> s =3D socket(AF_INET, SOCK_DGRAM)
>>> s.bind((f'0.0.0.0', 8000))
Traceback (most recent call last):
  File "<python-input-6>", line 1, in <module>
    s.bind((f'0.0.0.0', 8000))
    ~~~~~~^^^^^^^^^^^^^^^^^^^^
OSError: [Errno 98] Address already in use
>>> s.bind((f'127.0.0.11', 8000))
>>>
>>> s1 =3D socket(AF_INET, SOCK_DGRAM)
>>> s1.bind((f'0.0.0.0', 8000))
>>>

After:
...
>>> s1.bind((f'0.0.0.0', 8000))
Traceback (most recent call last):
  File "<python-input-9>", line 1, in <module>
    s1.bind((f'0.0.0.0', 8000))
    ~~~~~~~^^^^^^^^^^^^^^^^^^^^
OSError: [Errno 98] Address already in use
---8<---

