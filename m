Return-Path: <netdev+bounces-260162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHURBKOinGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:55:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D617BE03
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16227301CCA9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2B369220;
	Mon, 23 Feb 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwB2ewHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291E34029C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872927; cv=pass; b=cajAoOkGJmE81GNhivchJ59dxauBC1/6r0eneHqDSd4KjY8RbdPiyZV7jlOnEtNsWsxJpvjUWmri/kSzsAVCcXziD3APhmGfPtA1Qm3yWlWtn/FFpW5C7uowEyb6T+x/jF3pv3gWMqf2rdDMc2pH3QNZZVO5TYOX3BsTIC+/Ygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872927; c=relaxed/simple;
	bh=7hmltgxZHQES2Sj8jCNnN9LlaDPvBeRUBRQzjGzIMx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4/hUTTnTO2gkGv7Oq/KhgfgI8aK1BbqFWclxzQS5n/2hctpdHR9q1zBgCJLXPnfjV0bl2gYwICpTUboIT+4ajrni1DX71Q0GDcKAHGCF/qgMCE6KvGOf1nDI9C+0YhEdOBlVqH4EzjiJ6A75xn6j5HcNg8jk+U6wfeDW2gI7bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwB2ewHH; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1273349c56bso5551667c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771872925; cv=none;
        d=google.com; s=arc-20240605;
        b=hw8jV1FuUHjqdDyUQJBmZsrPmn0pfH9h7tuDyWfmKFB3lVZM/jWUhVFavf03zJ6SMm
         7nM3FpQd98DVqBWfzHmmV6juSEOrmbuo4sIogmqbCEjaKtZdU85ytoQoWnTD8kY99sG8
         X7ljZDMfcdfo0ouHlMQMHaW0l0Y+TqXKaWtymIdoN+YE1X0ch9iJEzij9BqXOVS/QBTR
         UBVe5inpCFNTMv4iOegAdbLb6rc4cOHY45MzKBATWVoWAePwwMX35KbSO1BP6TrNvwNc
         LQPLREYmRxiFs4thl4GU5ojHCrJRAZY8ltkpY5ZF+g9jXVtFpgQJ+3yV+DVjQJqZAwBp
         WQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R+L1UR19C4/I+h8TqLMxZqP216UFq0bDzwSOTMfEVFo=;
        fh=Malbfk827R1nGB0+G8eXr1i+5pKu3hCTfpqfxbGkwok=;
        b=e6876iq9yMjSGK0c9rK3hp4D4+x8pNmi8ZZm+xmP09OwZLK30QBwLuxJ2h/1SVzeSO
         R7Elqi72M5oa9FoNfa8nykaYsvVeNo1fCh1ZUJuaizWCFLoI2wOdbgVrbk5Njuj/CFMW
         Ar3hoL2N9rG93PESLWg4yFu/mWEEYFOtqPUUKidwKul+Plr/y1yrnn4WJA2Z2bvGg6pr
         H4XUWSL0n8HwWzoRrJrJ+ee4AROcyrewxpIodwceMHCkRUyWvqfZscxAKdXghNFMl9l0
         50HUlPZX4XD90c8ADCc+xUsUkSII4EP9qzYBWDiWrE/6pZ5Ffb75ZouQMKzZW6d7qyCl
         ZwsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771872925; x=1772477725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+L1UR19C4/I+h8TqLMxZqP216UFq0bDzwSOTMfEVFo=;
        b=GwB2ewHHm2HGJI29eJTKU9UEW8kW07ff0bCca4GJ3vm4K/TKS/hrXKenf5qPpybztg
         Mt5WICupOAv8xRy+GkzBsOVDk8WuQ75E5m5JA4Co+M7TbzHKLNJNRWbXr1X/omF3ig3S
         u1U/yNaCfg3wHdlhqNfrUhzdWc6kHjiyeueO6yPfVXw3n4t5zQAJf6Dm7Wld4Rkeqm6N
         nxTV9OTqnbtp8FCh6N9JuLmaICVCquA73ZtlalIYom1RMAG0X7YUML2lunjhE5RbFg8Y
         lqVFOS24mPIQ0hWKhUNH9+1mWrXTRVl0hi8JoLi+MVaI/El/gYEzaMI7kBEF/NNub2Ri
         BICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872925; x=1772477725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+L1UR19C4/I+h8TqLMxZqP216UFq0bDzwSOTMfEVFo=;
        b=qM/toPBZoyT1hzvqNRlWTPpgz4s4a3ldxQCUSQJUPsV2Uruz9MuVcyEgMOX6+1St8j
         Xl6Xqh3oc8jgqXUmh28z2/9hOn+bwrXRB5ac4xlsiyDJ1eCsvAKahNE7hWBDj4lZR63m
         BqIQB9XLKH+uZkNr4DPTTxSHJrNWIZe2ZzYJN8/2DlkT07sjMIRdgG7IK290yE3qSZtq
         5+UXw/Bah4elyc6sTes3lYAKeYKPbwyEkBDZXUPbAIc9uKX4yXEQpbGrYwSb/mg6tsbS
         gSQqLg5Ip6se9/DVuDgcgRDJLtApXpEwS0/zjikmiZ3lhpxofSLmstm5Vsb3Iw5t5/jD
         io5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4MxZRr17C3zkQw8mFZ4Qz8s5SY5kiuMn9WL2ejJPjxIcDDCkucGXiNNOYuY5Ep6bIc/c+ZAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi74KDRNXmUhZo1kiMu0jW9wCDSDCFEkANippCNgJLf5k0YsiL
	Q0N9Jo+bTYZ69oDyQZmvemIiTaTyhBnle9LrHGoutPf0xZCyEZTaEKmgzTq3bi7HeRVuqJQPSdQ
	EohulVEFy/0qAetirCP5gx4Ebg7W5qld42OLVBfKa
X-Gm-Gg: AZuq6aJsEej7uDSYc1pKlYAhaGG6fG87DzchNwsPImuUzhNnUpOad0oNK2LRIgkd+7s
	0OWfoWbTsrPV145MDpbK6/phHRJwDppOFaMjzvZe16OfuQzZeLO1yQSk7ncmuX1nNj6RQTeGOv1
	xQuCNmpejopPI15SQVx1ccis7oaJacV2Snh2FXTQ2gYZLsjs/6fJuP4BOT8YvfWzBDhsEej7rT5
	/WUVBgDT726bMuUOjOAK2VjM9FqYUmEtW8hCyNM1AGHLQbbhjmVVaoqjBbdyPhlNqlsTeFaYV/j
	ijSqvQAqLY9RbOzXvpCRdBReqdhU9iQnrJ3DK2cmkHx9edad9NLRa7cBS829EM78o94y2fpf
X-Received: by 2002:a05:7022:f96:b0:127:5cfe:1ee0 with SMTP id
 a92af1059eb24-1276ad18623mr3923940c88.21.1771872924531; Mon, 23 Feb 2026
 10:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223100729.3761597-1-edumazet@google.com> <20260223100729.3761597-4-edumazet@google.com>
In-Reply-To: <20260223100729.3761597-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 10:55:13 -0800
X-Gm-Features: AaiRm50DO3dooVX2yw740rcE5bmGXNq6smtNEdQjLO0MZCs3IXpi_i4cEXjFNW4
Message-ID: <CAAVpQUC9CGTMvY=bzGgjyFPqNv1Vpo8+69VeDdwn4Jp0=EQ6pg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260162-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A94D617BE03
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_v{4,6}_send_check() are only called from tcp_output.c
> and should be made static so that the compiler does not need
> to put an out of line copy of them.
>
> Remove (struct inet_connection_sock_af_ops) send_check field
> and use instead @net_header_len.
>
> Move @net_header_len close to @queue_xmit for data locality
> as both are used in TCP tx fast path.
>
> $ scripts/bloat-o-meter -t vmlinux.2 vmlinux.3
> add/remove: 0/2 grow/shrink: 0/3 up/down: 0/-172 (-172)
> Function                                     old     new   delta
> __tcp_transmit_skb                          3426    3423      -3
> tcp_v4_send_check                            136     132      -4
> mptcp_subflow_init                           777     763     -14
> __pfx_tcp_v6_send_check                       16       -     -16
> tcp_v6_send_check                            135       -    -135
> Total: Before=3D25143196, After=3D25143024, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

