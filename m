Return-Path: <netdev+bounces-281251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HpeLzcV72kQ6AAAu9opvQ
	(envelope-from <netdev+bounces-281251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:50:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630646E97D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E02300DF7B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB23976A4;
	Mon, 27 Apr 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIqkDOtY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323B346FD2
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276183; cv=pass; b=oaFpqK51oOKwiGT9/cYQN6p9HTtS9Wl2O5ipDqolV38y0wT5pG1eZPbU7jZgiBH1YjlyTqHvN5ECPT/Qa/anmCzGMH2phITcawpJOuXQMeIDXP1VA3fn7dNm7uuOpOy7wfbZRq6udQO6PrmCS4GFKHIwpiHaEZUMUizKrrpi+To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276183; c=relaxed/simple;
	bh=OYDZ71/1SwpRCoM/dcY2szAvizPLoWiOdpWmp82no88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuSapvb5EJIyJhfagdVjyYiA3aEJDp3YCA3EDTp0mNy257AOrHJa/ML+2EPB9ZyaeFb7e5ji8LxZSKoFmf0SwZYRt1EH/yBdZLTEytXHE1iA745Lvd4tP5q6W0g9+nuOo4pMr+PSOclk9m35jmMFUcKQWTH1FMNG8LnVjaGKUZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIqkDOtY; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fb1ad3734so51915831cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 00:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777276181; cv=none;
        d=google.com; s=arc-20240605;
        b=P4DjeQ8GNztcqMLuyKBYNppBsf4SmfIFlvdxk5KYOJg7FK+26YjWZytvf7pwlNdT1W
         RpWyZk3u8neff+XzkT/fDT6qOoI3lFFRHm2oa3tBTmszEg+t2wbkk9zWx0kwZ6hO1c1l
         278jvqbzwFfj8pQyEhVxekDvOpKsuM+khZXwy9IppFarWsug4cBCGeuUJiUYRBl1CSS/
         l0xpVZF6CadwOlKRUJPFHXI0VJJ4UFPKhSxOMkVoB+2bvz7Bi0C+9HQX8ln/ZjxySRxd
         PdYNE6GegzvGMnP9aZ0kGpE2Q/91iU9eH3IWo0yzFxR/x1St6sX9wjfNd5kZKs80mYmU
         E3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OYDZ71/1SwpRCoM/dcY2szAvizPLoWiOdpWmp82no88=;
        fh=NHvh7ULzMSbgCyymc6uv7lkkfuk8AF65EMT5bqYPRd4=;
        b=P3F0gmqToA+Pn/8x3TAAgZ2QLmnkGjDfwGa3XCripM7Fl744AxJN8TQSzAs69p0Oyf
         xj/qAmOCOzz7R5b4vKSLOpO33eSpXVSRifan5xCbP7rTeEQjimRXUqw9sAvucPZpEEGs
         ES0YX0dWDAkMaoEhJcVUhRXoXdU574WWZA8bh/1quCqVWtVsW1fdxqoUEcagALcQjUBD
         7UsbyrXD2rYHyaBSOSuj1Bm4todU2Rbmx+9VZTs9KH0RAvf1q/P2ipVPjpnANC7j9w9k
         XowjemILj+F55bfsdBD9fo2UvviCZ/4ih/x8LRcacFw+O+sDiG4O7u8lQICKfeJu2GdJ
         0Ecw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777276181; x=1777880981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYDZ71/1SwpRCoM/dcY2szAvizPLoWiOdpWmp82no88=;
        b=QIqkDOtYxC001VE9LdWzRQyNW/3RWwZ/PspVwzBPLS0n59keG8hLp5Xv8IyPgFnMme
         8N7Zj1KCCKvPf0E7dpADvNdGHKzj4rPauIcDHDuFqYClqdvfgRwkczvjVoW3WjSGPXUO
         zJQkW21Z7XUsNwwLWJR1kFwdoDkDHXrLAi08DdX7uODoy+I78yqtISI8ffbkZpZyzARA
         2Zf2K8KkFUTvsh/BxEBKg36D96jctFhT3C13Tubu7FnAjFa0lk5QN46+BX4RsZ4NsBVs
         ur21Hk+nOOe53LTQaiaNDIUZHKLMhB+tu9gP2lXyxb22oMStWge4Ey5NUB+nlmWSy8fs
         qR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777276181; x=1777880981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OYDZ71/1SwpRCoM/dcY2szAvizPLoWiOdpWmp82no88=;
        b=E/hR0GTO5mm3zTu1hsjfJCWpXdODUurs7UN4yvQiu33EhTF6gwjlGq19gJac86JyQd
         dx6xOdTl/qqlS8YigRe3mGRVq/kY8F1WTK87GaZYOCSZWJCBKlpmxxs0Hd+Iio08+gOE
         3nJieEwDoLeur1Idmz2jP7wX6R0342Dead8LqT/rwArBI4ax0fmUKck3yz6IawSNRXms
         Qj1+yNjFNvdRMonf8W2M79dv0oAhsHN9fhRe/hbP0PiTR8TKtftkKQ5rIDppguch62+R
         tLu/T07lnYT4RKGvEGwpdlmf6v19+oeQ1ZrRs3lS6oDP45NJ2iBOyX5a0CjriADDWQ5Q
         ZjDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SDal6c8g2HkJT2KyVgxaCUofS3LtCsKjTAlvxNFdjmTmzQoliv6yXZvZqtiMOPPbd6Xnm1Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4z0pwDt1ls8rFmqjwy7s3KLxuDBH5AqYit+mvoLmSW0ZlnoXl
	TO4l5jPmmcjtzlpjJycldXeOx9eQTqnNXcDqJy8bRY+1PfXUHzykSmJxZ2UyE683DXMxPXfdTXU
	ytFORy64P+eHE0ogjAKAfHfTuBp4bcCiLGmLDa+1A
X-Gm-Gg: AeBDievs+zcMi+lBT3SikCb0jVUGQJRg6UJDMossbJZFTaSPaXHH6YkJSuZAtZlvUJN
	ymeLb20LkzA0sm1C/lnfOBPo2vez9MAeLlilnuuGnv/6SwOWMDdcTGGt38mtyDoFUDvFj0khBBd
	HWCNxoAYt95k8BVEGOSJK2/pKZrg34K8PTnLQCFf7v0TcdcRQIJwiOcwIQlOKUMf95/h2sI0VSs
	w2TYU84p0TOhWJbQ6OOroQ5IXG2zfzMParDfrl8jygUG/Sp/6quS4GzHzhi244cEhnDrKchz2jS
	Tt1iGPqZpUBgl6jM0vvUj/DTbWEOUIJ+2xdQoz//g3+IDdehIhrbdgi+drRarQa6C2Msjx0q4YM
	yNukd2CpDrpKVmMa1XEo=
X-Received: by 2002:ac8:5a0f:0:b0:50d:a8f5:fa94 with SMTP id
 d75a77b69052e-50e36738adfmr539084501cf.21.1777276180321; Mon, 27 Apr 2026
 00:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426201434.742030-1-zlatistiv@gmail.com>
In-Reply-To: <20260426201434.742030-1-zlatistiv@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 00:49:27 -0700
X-Gm-Features: AQROBzCiSwtedP0Od5ymQ6VSISfA34i47cxEDKcdXON8K1RMfGy6_I9jWKDTi2w
Message-ID: <CANn89iLE06TZJwSqOvuThjTC2_MEi1w3S001m4HejTxs+ZQCgg@mail.gmail.com>
Subject: Re: [PATCH net v2] netdevsim: zero initialize struct iphdr in dummy sk_buff
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2630646E97D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281251-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sun, Apr 26, 2026 at 1:14=E2=80=AFPM Nikola Z. Ivanov <zlatistiv@gmail.c=
om> wrote:
>
> Syzbot reports a KMSAN uninit-value originating from
> nsim_dev_trap_skb_build, with the allocation also
> being performed in the same function.
>
> Fix this by calling skb_put_zero instead of skb_put to
> guarantee zero initialization of the whole IP header.
>
> Closes: https://syzkaller.appspot.com/bug?extid=3D23d7fcd204e3837866ff
> Fixes: da58f90f11f5 ("netdevsim: Add devlink-trap support")
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

