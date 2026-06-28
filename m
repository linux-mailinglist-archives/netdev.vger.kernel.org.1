Return-Path: <netdev+bounces-302396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0uosAeUkQWqtlQkAu9opvQ
	(envelope-from <netdev+bounces-302396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:43:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF06D3EAF
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:43:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=emlw5B9j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302396-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302396-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546103009F34
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31AF3A545E;
	Sun, 28 Jun 2026 13:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A751819AD90
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 13:42:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654178; cv=pass; b=IkVCgNNElybpevPm33qeuieWJckEWEX6FizowiPH97RzfyZaB37hW8oRQX9bRZ7qePA4KzqwYzX4X15tkvUmNn+pzNe4w2QCMYxnODqjFLP7SyYV91kn+Eep5LjlanFfCJcKq6z116cDhgVwcQNCM2Qs5OD5Evj2ZscLFcfB6Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654178; c=relaxed/simple;
	bh=gXrXESSgzNC6pOhTJrNDjl+1Vbkn8Gm0CHDDEECssUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8y1mH5hunG3wqinezaZHk2fTeDah2N7bjL7g7Z3OHl+Cm82aUs4VUalxgNi21AHfL75PHGAuCm/HpSESR4g83tR9MwENQ/ofnYPfOXJA3nr1kyY4ohz5AqKRzi0qpEdfZ51L0qpR3QX+6bbFDKJ42S98sRQS+8dnuTdb809Y+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emlw5B9j; arc=pass smtp.client-ip=209.85.210.51
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e94d272a86so1783472a34.2
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 06:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782654175; cv=none;
        d=google.com; s=arc-20260327;
        b=Wwm7iuxnk4ONTdspMd03qgcT4vdg9InJQ3qGVRGufmueNUpSmIlAH1RJFOYHt31gGu
         x0N03Vf5PLTyo3JyJbJZLnK6RpeuY0fFdf9hU39KB4qV8E+05ocSWJ3swwlioB/Z5Y90
         2gMKo4QrzE5ppO1NfmjYXyKpQZRJh4eDO+1bTk5idsjyb/H+0lUhNA84ptA6qQDSxjvp
         k3os408Con56fojQ4CocJlVrSiumCzst4uo0ZdCiR7KvfEupbmjIZXQL2BygxxmAHWdI
         e/yUQhJO6h6WTXAycXbSmxPSbu0asD0NuA/dNeIAZ4hnEZiQ7LuHVDZBYhpty1GGLwDH
         18Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gXrXESSgzNC6pOhTJrNDjl+1Vbkn8Gm0CHDDEECssUg=;
        fh=QnFjqanEv1yzH4T5rB3gKgkxI+NSQULsuJfGUE/whMQ=;
        b=be9YJsqfwyEk/qTkhtujS2Am9rDoxCqzf+rUEeJgiHr6mZW89MAbB8osk17anK6cUd
         DAbe1T2gO1/P1D4iiZBWXMI3Z/wlRmyzaVl3KaS7wjKEBzQHodUHQU4RmD7Kgh2AL8cR
         wl2Fs0vrFZkMqu9biDm+m1n3B0NDirrx/5w2/n/bBjkPXvGcd3p1RyFvDtyK5xNoids9
         IvRexRqCdkQpDCfnkH73MYgCck9C8exAKjhbKYXeba0J8tv8dkzvBcJ/nzeQs2+vwImz
         oaXCn5RrbsA180yahmit3gMvro5WfWzNTIBASLJzCcNGwlukXj/JP0W+OdvXGIeuqx75
         yJsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782654175; x=1783258975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXrXESSgzNC6pOhTJrNDjl+1Vbkn8Gm0CHDDEECssUg=;
        b=emlw5B9jiuRRdW9Bpi1P7SIlOyjZwlnRl3nX7uK8ysHUngARxhukg75cce9nvLjqh0
         iGpUSPVudsZUiUJ33+XKU7PUurrjLXbhENsWUFYKSx2NDSlbK8eTbPRDx3kZ2WHXezg1
         laelbD9CjNQSLQEZ5BC6BLy7yYrNmw95mFR2bHu/VroouVo4ZTHTK5E1G2PSF/cJRp04
         hDDFbFI5kdeiJumkXaC5yLycMutrSQTvksqrLq+3L2kexSQBOarFcrOhsrbrzv1MKB6P
         Ei3y47SurG+Q1XCz+lArutVcgsKl4rqleVLQRolyBnNcXkTyJ6+SJkc42w5gX6XsPAWz
         EX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782654175; x=1783258975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXrXESSgzNC6pOhTJrNDjl+1Vbkn8Gm0CHDDEECssUg=;
        b=Eq1QFmW5+XRIGBW++Nx07PxXWw3W4mub39Xdm3PGxsjiu66HAkPPFwa2eFd6IDiVr7
         6x7j8NmF2iJ3mzkdBDFSRWelxr/IadClTVuIWwL8uoOhnfGDB6S60aSck67zxnE8iEVb
         OhWEAbUcSnHr529zVi67nkt0e8OGjE2xqJWlFaewO3qPXk3lW3bzEFQABGA/eh7EEYAT
         NZeCJeUQ/kj7qIg9g9xE6Gne4VxCQEs8vU1IiKddVN/MpO6zZxKcq/iQh1BdSYi/SnK8
         qSe+WDVaq6JfUfEYY4sy1aYrqYoQ3qXz4dzs4Lhjy/1nWw3ZdCBrbpIPIyjJuwHPaEWY
         7Tjw==
X-Gm-Message-State: AOJu0YwcAOozjK7LPmcFTizV05QtZhsDmwCQqG9+ExYvkBamutfJ88/D
	arO4jQbb3Ci/yIuoT9F3DjlVdbfIRpWDiL/n+8PQ9PH3TeP73JJ6hOCKBonZXH4nA4t9+IV781+
	ERcy9hIt6cgM9f/7DYykcxIlWCsYVcBY=
X-Gm-Gg: AfdE7cmIRqKQY6uza/2uw8SJbJUGl201ZkxmVGBuRuJzqr02qJddJcQ6uGTw5OAiaSA
	fvqIyFzlbeA2BkJWJNHzYhE2Se2RYmc0dZDFe+e2gMyEcvVbDaIUgg4f6Rddf8pf6XIeJgV2Z3/
	8EvYGVDDW3UPj4qPBagTapsengdsvl2YfB/Ja166o8eyMddBLoLMvBpfpjB2rNPZx1eAxT3IGm0
	KjWb0YwoaWm+YXAjJo20vOUPVpEyu+k+eZor04i+CW/Shel77wYv8LJkiWa36GA53lvn6+h
X-Received: by 2002:a05:6830:6186:b0:7e6:ca29:9609 with SMTP id
 46e09a7af769-7e99c214f69mr10746738a34.13.1782654175496; Sun, 28 Jun 2026
 06:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625055513.1841167-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260625055513.1841167-1-n05ec@lzu.edu.cn>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 28 Jun 2026 06:42:44 -0700
X-Gm-Features: AVVi8Cf4Du3pjCh9a-h-S9JzfiR2-Y7ErWWONS7KmJocwFDcOSEZt7Pb4lSP0dY
Message-ID: <CAHsH6Gupn_PVjZjOWPRLWL6LCL=-p8Gde6_BruGdetn+eP3NMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] xfrm: nat_keepalive: avoid double free on send error
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, yuantan098@gmail.com, 
	bird@lzu.edu.cn, qianyuluo3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302396-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:qianyuluo3@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eyalbirger@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net,gmail.com,lzu.edu.cn];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eyalbirger@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50AF06D3EAF

On Wed, Jun 24, 2026 at 10:55=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Qianyu Luo <qianyuluo3@gmail.com>
>
> nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
> send helper reports an error.
>
> That cleanup is only correct before the skb is handed to the output
> path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
> networking stack may already have consumed the skb before returning an
> error, so freeing it again is unsafe.
>
> Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
> and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
> keep nat_keepalive_send() responsible only for family dispatch and the
> unsupported-family cleanup path.
>
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP =
states")

Thanks for the fix!

Reviewed-by: Eyal Birger <eyal.birger@gmail.com>

