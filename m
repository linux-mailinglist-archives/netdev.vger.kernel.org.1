Return-Path: <netdev+bounces-265940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA7CC7fbr2kzdAIAu9opvQ
	(envelope-from <netdev+bounces-265940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:52:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DAC247A7E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E203130B2664
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858D436379;
	Tue, 10 Mar 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfoLbIQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7C42DFE6
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132398; cv=pass; b=Wr+V7h5pUA0ysVyoBojCRw+62gRx5k2fHdpVszwHEcIdM2W54s5RF4/Tf0TwgkuSscZsYicdo9ihjoImuK2LiGW1AM0OR58ktArJbk3ELELQe0NbSo0SnTLIgS0QMbsSRpN1Ibf+7i7zwsppurZjSnHGbgDgjAugvjOCl2639z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132398; c=relaxed/simple;
	bh=RszETrACILeYN/zC7YLvxSjKCkmrXHy7cyN9O/Mz3ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxNUSzSHTxHpq4i021rhPCv6XzDFIdSbo6hJGpf1vXdaj1PbsAsLPVzfawQhJlz9bXJBDB7/mT4XlveVXtl7tfZfnbbN2eJUcmYTbsbmxDLhZAK2/0IH5UoJZ5BmTnUWfhs/M/lzQ51mJUZ1psN8++RRbJOD2dExHRG9JGrfgl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WfoLbIQA; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509101189edso20607971cf.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132396; cv=none;
        d=google.com; s=arc-20240605;
        b=iXWifr+BPHcVbb6McbaQ1lbtJuVOPGFXS7PvcwtAqKrc0BUIJ/kJvnmYiB+zqtU807
         6KdQEFsr/UAozD0Ak6yWILjeYOGyAp216hWPsSYIsI6yyykL6Z3eKsGtaJLgMXzJtYP2
         9rC26SO391K1WlCGfp7CFu8ZQu21sKy4lFsAZegWbHyKKwq438I+X1900qJGXTjjsWqj
         O+sFEx9s/oD4fCpP+C4kDnDHpuue2PZxNj7yDmJTpxF3Vy9JCxPc94EnUeCX2xqt+9Oi
         q1xXGF0xSdhiwcKWRNmvxMi1ewt+Mk7UkbZmzXJFzylDcPGpebrsRejdQfeHQNujFHm8
         5X1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nEimDqly9kpV/fuktlYtnq2NPSlAX7VPlv+iNqng0A=;
        fh=cSixMBV8eAAC9MLm+Di3C7EN2rsVVA5FA8GNzoN1PIs=;
        b=ZVExOdxOyHgRfKFllJEg9Ajjq2AIQPreKiJC6upn5j6kHXwm4HlO4y1toZ71IPLo8N
         BplK+aV8WXiQ8GJGOOBQjzf9cgqmwh4fG9lfBebfjkC/dEqtod0cGYYvK0wT8ujS7cHC
         JbEVUXNN8Du9ip29Z+9aVKJaVh5eOdgvP/djnjW8dnte5/tqAZBB4DNCTr4rVLGBqrGs
         wB+3iC2zKYqDM4Hmiv0PhY05A4xUpTO+vkoyqXK8Aluw+UFWg3WoXoY4blJmmcyIrDJJ
         JQ91VzmjVLxfNQ3yGX/0qSwiTDrJVQZXb1zfGbzA75c5fPlc2A7au//PhoMtSd3oiDS8
         EBgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132396; x=1773737196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nEimDqly9kpV/fuktlYtnq2NPSlAX7VPlv+iNqng0A=;
        b=WfoLbIQAD6GXIH2YYz4hBqNgFaASWppvh7aqRvCgMSoJK+r9lpVxAjRyzI69G5zxAM
         GCZYAQS6+GZyBzp2OxNDykljQK3vnDfi7y14Yea7YvEUhvTz2XjTgRbsagmtQ9bCmRM7
         /A68e0V1XxoDf5c3TZswd2LYDIqW7iIijVLbQmMlYau0H2m25MZRILLfCYwGacgvSPKL
         gRTgExW6j6eiTxE+VzNWqYWdUX5TWdWML8Hd+b0l5anKjAIaoiPIOdJd+8sFcjUlT35I
         2xe6xItTljxBeWLasuLgyjxvrD/lPRi0RlnTWarmTN+zKfvlTVR0brk8bN0sT9ZNsjTe
         kmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132396; x=1773737196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nEimDqly9kpV/fuktlYtnq2NPSlAX7VPlv+iNqng0A=;
        b=cOXAcK9kFq34jUaOGLpN0X/Zgp+tFqRYD4uTMoJgjIBERb4UYbOhzHW/Wi6oFwIC+y
         uYGRTFTR6oNGiYwSOPkVDDEI0igLzCGOQzKqQH3yt0ROBvsJd7pernfCI4k0EQWN797r
         jf6Br1pVUwaVhDxfxkheLcWdT6cAZIYVDQY7GOTktCWIBHFxnWmFggiPiJ+8j+5Ybymk
         Rrx7Guj8N5CqTqk49Sg2E2a1paJ95eH2Rd5b8gxpFYwwOUDl3GzRL7Ovdm7kCqTj5C0L
         mpkRqWixZ3dVIrpOwwbks+uvfyIqktMesdoRxFhG3R6fqFFMLHDJHiwhJSnooPMplARt
         xCIg==
X-Forwarded-Encrypted: i=1; AJvYcCVr10BibB6uBU11ZKAzkvLNL4hqs2UCHESqBXkkwVp3KR6DVKqjny+BDbxYudFRSePOLPkQISk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jIvsr1aN3xiZ8SJTDumoUR+t/EOoqYvT32xwUZPH/tB79g4k
	xFGlhV08rmfzTkguJt0KPFVUsjfTrP+kSvk0KWBg7PqLyDUhZRBGv+yimlnRKi19WeOmr1iMr4u
	vPAcgJHA4taBRgIzM9oa19gw97vFs1W04rwXtwuJp
X-Gm-Gg: ATEYQzxuCMXhxDlBqbzN3CAU/gP/40LGc8drNk74jeCw/mZmv6OMFyyg/B37T1NgsIo
	V3CNEiv1FHvM71nHiKj6YdUgqLHT6mGPPRPF5wRUBY9pI24WZWqKHNV+R7lds77HtR663/nRlV6
	J+y7VCtSFNtiO8dUDSCUTnaIbwCSq064X9kM1Q9irxCaduHfFRFprkwSj93Pa03+XWCFt9eEGRV
	03FAHnIUpwlaAws8Z4MhAi10dnkYV5h+C6Pg+fZTM5jQuLFd/8D764PDWfqV74kxryJGHkY2t2c
	mKa3jx18WUkKYqL4fw==
X-Received: by 2002:a05:622a:1a84:b0:509:21f6:df9b with SMTP id
 d75a77b69052e-50921f6ea75mr47026791cf.15.1773132395635; Tue, 10 Mar 2026
 01:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:46:24 +0100
X-Gm-Features: AaiRm50AVSa2QQoRJnA4Sp6RmxAkhC4YiZSP7XkFIO_4j9Qiq68pO__J-NefzKc
Message-ID: <CANn89iJU2ejyGSm-OyBeRUNZpdzds6H-bNA8KnR085ekF+W0dw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] mptcp: keep rcv_mwnd_seq in sync with
 subflow rcv_wnd
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B4DAC247A7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> MPTCP shares a receive window across subflows and applies it at the
> subflow level by adjusting each subflow's rcv_wnd when needed.  With
> the new TCP tracking of the maximum advertised window sequence,
> rcv_mwnd_seq must stay consistent with these subflow-level rcv_wnd
> adjustments.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

