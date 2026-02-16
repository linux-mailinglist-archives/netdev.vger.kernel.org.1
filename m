Return-Path: <netdev+bounces-258956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9XA6Jv2tk2mb7gEAu9opvQ
	(envelope-from <netdev+bounces-258956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 00:53:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D1148267
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 00:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 669963015D0B
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 23:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC93283FDF;
	Mon, 16 Feb 2026 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgGbvZ5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6F22E3E9
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286008; cv=pass; b=JvwPHXo4ogV9b8ivRgyY3FicE36tPnNYW5e7szcsWIt649rQRunLl4v0N8ixhFWKjeMXqXtEYaF0f4WbK7/lZr1/3yOWvfcM0AprOMrfyh9/K/4VbVmCFT5zcYMX1k0qZnePRhCAzcnzLkp0rs7AZVUl5+kS0NbpRjHLM72XSrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286008; c=relaxed/simple;
	bh=R/FmNj/1kQueB3UwpUyOQDG1Va/OCogyRr4w5R08mA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyeGei3uf5+ZaVshSFSmNC5KzrdaHZVCguPwxx/TYCwy0hycIRZOCiv15/Ff4WhDOof+5qbGWUqO/T4eP4bszkuymKf+ENVujszujlG9fk+wwjjiWQjwXd899r20VtxJTORkPTxIjkZDJUITrS8ti5E5nhCX6rWAWUSZlRdMh9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgGbvZ5W; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-386b553c70eso26370841fa.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 15:53:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771286006; cv=none;
        d=google.com; s=arc-20240605;
        b=OS4GuyRPgQolID+NLcJxn1ViEtE5rfBzI43Q+IdyBkyXu7KUx83AyfroaN/v5ez+oe
         BNx+aZHYcAGn+9M0rwVPt47g8ZiiXYcexHcLWgH7R5d5QlWgWFp56AdL/Bmy/xlFJ2iK
         tEeFmM207QLhCcyuLpGP7LFBKOjmnjq9D++S4VAB6f/sB4zbD9x3jLCDyL6uCE7Yibkq
         ox8oSIGYBf0pT6ntxAVZYfNQSoIgZ/C/yOSYN5CZX5x9/cMHeD+x2897Ygm5C7f2gmAp
         1QjSCIOsRFRwWXwAu1W5Mm19vvrLPx1CQkVW1muHvXtNCsNUVN7e5un1pPKE8fkv7XHj
         0u5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/FmNj/1kQueB3UwpUyOQDG1Va/OCogyRr4w5R08mA4=;
        fh=/ADmDerzPuSbz5reT9+iJ51am/cWD1sH2PNWEUYy0eI=;
        b=L6PO0IjOdTQROX+n0RJk4+qXrusbzIjffv3ROLOK/nHt9kMYMzZ6kLgbLKgp7zqsnm
         1GQ1RGnkym0nBChwS0UF3kAHzOR1U5bqP+zeHJ9VYXzAD5nZNaWqNaavKN2Qavv0Xaza
         xS5DqSFaHuYppeGEY9+f3YZXj9i48eBLSs+6Y+SrGJ9aRtabRmNZeOpZ3SHjkVE2Kfx/
         +dqdcjVIS62VTaz+z+K1RvY7g/KrGDhDRtPGjxgS8BpesS46x+IrNiXAZwBbGXtHIzJh
         Kn+591MgbDkDMi7Rt8MOPXfm86/fjmZvzOSZQbk+DrQFHJLMcEQBY8lSl0zVX/oR1v1X
         Og4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771286006; x=1771890806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/FmNj/1kQueB3UwpUyOQDG1Va/OCogyRr4w5R08mA4=;
        b=JgGbvZ5W86HIQ9ga5tFJbyBFCSnmPH4kr4jJ7xMiui2C7pE2Shv8Gn1yFClwwhzyxP
         OdRXrKlVgkkCc8MYYX2+bUrNcB2qBAwX/8MJX/j8hGSyfy4XYFUm3ZxXJtv9UpNAKAnH
         YuIHfUqlcWKcAq5lDN8DpIVQiuEAww1LNPSJfNjx4G7wVgsacKPChvFAhzIE9zlZwUIH
         GXwLn/llQRhaq6LRaDOLoXZv9hVdWM/57T1eQCwFBAlZHw1BcPrDANWn8FqJ7+83SHcJ
         Cfvz3aaT56wvag/2b2fe9VpcT410MIiYMyTMlbj98EBUiDxI7EL2RPSofkUBmSjSey6o
         sFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286006; x=1771890806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/FmNj/1kQueB3UwpUyOQDG1Va/OCogyRr4w5R08mA4=;
        b=rlsf7dMKSo3sAJ00FFpRutF76A1z81NUbgkSEGz+eKhrkgPEgN7g7R+229btqFpbeK
         tv5gYfL51rNy7hbwcY2CXUGJ+kHFXTyWrqWvwVQi05EWrT9zotLMNiBuYaC9y42tf9MX
         ROr/Yu/O2TsMct7tpfO6elnBmY48Xpvi0x8BCR04+xa8TIAAHmTfr4eDpFlRfd+csfAB
         FiuJ5azrZuXQCpXBzwEMNbC04RKzc9bRmM2MgLob/n705Sl3Iq3PPPEcdBbsGIjCMizo
         HUqCWUxFOGSl2+L5t9YHjt/hG0HlNg5BfdTzcsc4BUmC9eZKG0lTmpsKu2Q2paU2TK/1
         zMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJABbgxrhhmMCt3p28yjVYDDk36GY4f8d+pakwhbenZ0XbLV9xZsqNnA4gfek63y+wrp7y7Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWOewWvLhI+TWoxNbIhNTmYPtvWMg3ZSxfD//jzMFJjdOUS2e
	3ILSlltvGKW+003hStshoZ30a9o+zoS2hL9ZxxAZ2WxOrMf0LQaVpIhtvhFWs95Zj7WMKuUg74c
	Q2uSEeSxXIVpqZMYxobYNXELr7zn16iM=
X-Gm-Gg: AZuq6aKTfe3trluL1Ag89wFbGNBnQoGOv/tGrKCL3c7enpqDJYqhpEwRnFC52EBNoEW
	bB5vRognBpQAD/Ta7DsNNSbq3/s5ti/pgqvBC6S1PkJdIzYooD3VcISgMEC4uCuHoOTPJ5xBxzH
	jMpnhHZrnt4x+puBI0sZ9e3C+TEsNaOerqVTFtLcjGTc95vBdbvPsq46KJTZZnimfp7uQpdiIte
	En3gYvmi1y5txqkI8pCUs/8lp6mO+ILcyJh+TsBBCIyTHCZJa+ldixqDkFixd2IN7tKcIGBoUub
	RMlZUQg=
X-Received: by 2002:a05:6512:b96:b0:59e:4cdf:2f09 with SMTP id
 2adb3069b0e04-59f69c290aamr2830401e87.9.1771286005377; Mon, 16 Feb 2026
 15:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216193653.627617-1-edumazet@google.com>
In-Reply-To: <20260216193653.627617-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 17 Feb 2026 07:52:48 +0800
X-Gm-Features: AaiRm51tUbkmJMUb6jTK8ayt3P-tT_3kpPmPFjW-y_p6Qx1fMEjCwogmKUVpFAM
Message-ID: <CAL+tcoAA7PSA3pd0tSeZ9DkyDaYzGVMD9Cjxpus2UohpL1i5Zg@mail.gmail.com>
Subject: Re: [PATCH net] net: do not delay zero-copy skbs in skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258956-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 082D1148267
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 3:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> After the blamed commit, TCP tx zero copy notifications could be
> arbitrarily delayed and cause regressions in applications waiting
> for them.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

