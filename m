Return-Path: <netdev+bounces-262138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJJUCyv9omnG8gQAu9opvQ
	(envelope-from <netdev+bounces-262138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:35:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB161C3973
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 929A330341A7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391F31985B;
	Sat, 28 Feb 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drb9mAEu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED7309DAB
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289318; cv=pass; b=QGpW+AJ9QKWhZ4fQJ+cjk2Tt/LcOsZe0NokyKe9XSBhblxSGFhtp69hFup0/Gzs4ELXUbeJ5sUus/3t5/sovCSh04X4Lq2uyxKsT79CSsNdmVwUHvZFPXmIDcwH4cWbJqndanSpuNjdUjWV0dToVHxaqFHUdqI2lrL32cTcQiX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289318; c=relaxed/simple;
	bh=1m01vviT4f7E960ICQ27OqQpd7MEnNDFVcc4J7/VRIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeLGR+j8H11U/bKM2TbGXu9hCpBbXrt9/YW+rET+d/QPi/Uvjlg1lgn0VtqqOq6BEwzzvt69QPBnNqTG2blMUzGINg03+bFQ1bJcRg2+v9BXWvjf3Z2fClBlwZp+qYpoPihwg5Gc9EvUII/WJlHotcq4ND1uLES8gzHwckqpb5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drb9mAEu; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506c02ec1b3so35883491cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772289316; cv=none;
        d=google.com; s=arc-20240605;
        b=DFd9EgtB6/lxy3CR/fOMRtcx8tIAjP92Ocu5s1RN6frXF3jL1Zo+wtMdbv0JCS8Xvi
         D/jhSZxmhn8qqWVvySqlLnbiMtphisoFm60BnndzLZXgm7MUelSowBk0QToFf3XQJSoc
         UQ+nRoPYKyjE2ub0WuLcUXxrO7e+6u+3RHyozN698n68pGVK5VdVqt0GrgZdtlLxSGf0
         jatEw+94rfwQSMlisAbTSeYSybRrA38AT99jie0l4ov91lNoX8S30ThJeZrJCAu6lnUN
         heh/vrTpVQBNeajBRiyAnzFOTpIW/tIU+W4E29m4rJMksHUF8HkwrxhjnDyn4i3f65lQ
         SHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/hLOrLZhXuQdMDotqQ9Bvl5etQKdPXHisGPLX6sFNLE=;
        fh=FaKOKa+lfraK287LA7hQ9v+BDmpD/5qg+TfEyY3oXQs=;
        b=LRMgSeTMTDYSXDwKObkk7h7FFZmjG2BuRsovdpNz0boq3nBJ1eyHzx3CAz2jbkEfKD
         yt+wZLnm2r0eJBF2jNJOpcWfTk+MjcBWcwqbMN1tiwxKiEKXLSupD1B+RUcdxl4bOVL+
         QqgN/V6aWk8CTZT5quTtTYPsDkjaJ9So8Mh9DGNt5WnekhH5eVCgHYsYvrMg/4a6+nCv
         PTkFi0RZKn9dhaGoM6WDtWqYLOYiWRashSpgeIjYpLoRmsomVPeZ5R8MYC22Mdm6fywR
         UDAA+JriVEaJXSqwd8ojsVpPgKRVaNeMTRw0hGeldCNsMS6WMXCHf40OGnyXdBgJCObK
         DkuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772289316; x=1772894116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hLOrLZhXuQdMDotqQ9Bvl5etQKdPXHisGPLX6sFNLE=;
        b=drb9mAEuJpbclC9jsxcetn+ohKvHD/+6laYgg5yoznA69pbS2+/hv+srd0fP3b+5Ny
         WATeUNMHiVShaFFueZ7KVkeHGTg/lOCT6wDSE2gzQOqA197NsYZe8+/qFLMDxLZlnYbV
         LRQuv94+oURhWEMbmfeMi/j058B+nVPWDczhPT7dU1yED09roNy7DoqofHu8GUu+9B0e
         rUdOzvEVqxgVEIHbUomXF7sQaIBNx5qDROes7hYQfVXDYkxxMTaQO7fC8REbcRfvyJkp
         j4ATzFApx3LxB02ta2lwwYg8ZDZNQ+cYf7XOoUJJ6WsmX5JRy/nRam5r1tFZ8H1IFgaa
         MrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772289316; x=1772894116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/hLOrLZhXuQdMDotqQ9Bvl5etQKdPXHisGPLX6sFNLE=;
        b=ecp4w2YPDqg1ZuK0rYxQw94OiSMia/XCLvyJliiyo2klSNt2iAje9fBhpga3X7lsCZ
         XQrIBp5fYa4qWY+B6RIGgcXU3cPU/abIx0Sa+vOH0EZkUORjPXyu31Mci4ZvGHt7/w8l
         8eCJtIj3Tncz9+SsjzuIjgw9PL8XP4vfC7JavAnlrqkqU0ZB7AXFUCB8T4R+/JBSUYl5
         xez7ikFL1PbaZZA3Z/7NjahY2+OIfsQBTlCWDGFbrDgiLCGE8sHmQvnqfaVjpRG92MXO
         F2/37BS01pVgCwTOelswi828KlJ7vDl9vqWVhUe9VfVlb8KSCJNr+2ewUeWdlaUDLsvI
         H+3Q==
X-Gm-Message-State: AOJu0YwFvjgiuqkzcjiE4gg5Dvi57HG+TLiwvlyLr8isLURsCCfPe66M
	eO35gp5OWqhCasd46p8FhnBa40JdFDd+W39clIn80NEHcKmBcSCYff38VO5p21RcJt63QRhbGKU
	T3QUagMRiTtwNJeebvjaE1AAflObrRLTy27o9HGh/
X-Gm-Gg: ATEYQzzgF0bzvsRxcfy9nqLvwBIK1R/L9wt0pD+lFfjR2K8i46Tzz7ZsNCmsoh8NmSm
	hQTZbPTMC4ixDJxL03e4WUNQZnvBkYE4IBDaKc9CX1kKg7nMz5DXFs9BUmbvMfBYaBumTI0XVqC
	dAm2qO3UdhZDJYwLRMV6Eos+a7enZgcD1yeuW16+VqHgL1GUXw5nW19X64rKq4FB8GPeYvXPyJX
	QCE5EI7s38nM8Uftd4vIBtTpP/4by5g1MT9QJJdfnY6bREydkU8v2kfDJeRUr0Y3CJhKEWDMxtm
	FR+TF6hR
X-Received: by 2002:a05:622a:210:b0:501:51d4:df30 with SMTP id
 d75a77b69052e-5074433fc43mr139875071cf.8.1772289315270; Sat, 28 Feb 2026
 06:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228111319.79506-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260228111319.79506-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:35:04 +0100
X-Gm-Features: AaiRm53nhAMTYhhG5f-7gMegRJvoDTYPWAA_v2lfePsaGiIy-lArxvtTUIJh4ms
Message-ID: <CANn89iJ6cH9T6UZ=dGYxqHx9sLxX4mrD9U1yUm_DNrvyxYmSiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: fix sock compilation error under CONFIG_PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,google.com,redhat.com,davemloft.net,kernel.org,linutronix.de,goodmis.org,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEB161C3973
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 12:13=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
> brace-enclosed initializer rather than a compound literal, which cannot
> be used in assignment expressions. This causes a build failure:
>
>   net/core/sock.c:3787:29: error: expected expression before '{' token
>    3787 |                 tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
>
> Use declaration-with-initializer instead of assignment, consistent with
> how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
> DEFINE_SPINLOCK).
>
> Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

