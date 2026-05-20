Return-Path: <netdev+bounces-290038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACAENkn9DWoo5QUAu9opvQ
	(envelope-from <netdev+bounces-290038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:28:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8625963F6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8688530874D5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23113A6B6D;
	Wed, 20 May 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPilAgUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892703D5647
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300761; cv=pass; b=VcN+clvFr77aLSLesTjDuhEaEK+ZIdvtM9aq4okMJjd/TCdyuUYF5kJ5yhbEnqOOdGJo8C5SEQwuJp+aEwmC7beEjOVAFxJttdl7HmVfFgan9fQBJu6Ze47+0RCPbLTpPsXiuNFIzNNVhzyIk1Z/ksmMA2gYpNBe5EM9wsN4T3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300761; c=relaxed/simple;
	bh=wchdTj3LxKmXT7X7x0m+2ZtiEJSduJaU2fpigkUEdPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qX/W7jUM0rSVyTFr8FMOiIpjsMHsx+T4tEcPgI13UR/FY6VQ6k1z2K1ONYc6lVxuB8eG97S6q35Fv/jQMNbivQdY2pdPlBBwpB2knUPB1C74tQJy8pjfayAi3RF+Q0rYyHnI6TujBP3g1+HqFRqTfUtzko2yX5AziriGqV1FaCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPilAgUy; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132d1b2519eso12087721c88.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779300760; cv=none;
        d=google.com; s=arc-20240605;
        b=XGLTcVuFXCNaZm39xCYZ52VsT+HY6Zhmd5k+vKZLkdcYgBEmMzkY8Bdoy1Rvwy3adz
         xLx/Te+UWhNlNJUajHB2cEj2SGfm3NYmp+xSMYeg3CC2rwyjw20OF5sFgbRKmZibf4qI
         JXFvgbDPSwASOXcD+8km7DXguJWv0DDQ3dd+1CYdtkj3iMVX7m01f4th7UDf7btetm9i
         xtOMElEALkLkDd0plHG/DwiN1ihXEe7Pb8ToMtnO6TeMuU+MerIZHm2a0AwsQtZUrgcO
         QbvnRiPbdJkKS0z23/gYrUdD9QfvQzlOyd3rXH8gjIX3tyST5umgp44N2yo0ad0IXTnU
         RVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sdU4pIR9GEFmUiowF5+zoSCvVIVv3g6BVDDhCzEtXBY=;
        fh=YcZMj0rCX6gBEcFjijImZBB2uKsyoVqFIOu2WQnkF74=;
        b=NUQTiuw6UYvbTzIhEgH+LShf7zAGCTBb6VkY9ih1SwfMle460D0e5qVcNm8GWapgII
         wkQKHX+eDyOhrOXdUofUv6g/kjn+QsvOBtOVLRouc/7CVmIggTlRi6wUdaxHSbaBDb57
         yVev40uKvLdORKGYO8tlRsEZ3NbATbDRMzbhT9Ac3UYX+6BxTlDr4ghePuO96Dagn6zb
         6sdlSC7PO790sx42UNm0PCC/WOZlzfhI/nO3dfTjggcLGXHE/en0JJgTQYto4IS0D8yr
         6uLuVjEP1/y1eLm35y2ojRPgDfZilA2ZXxzVV5CU0QES7i5xpqk57PZ6NvJ3fX3GwMX6
         yYAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300760; x=1779905560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdU4pIR9GEFmUiowF5+zoSCvVIVv3g6BVDDhCzEtXBY=;
        b=OPilAgUyr7Kp77RVJmgINtsXMQ5V5zB3x4lew9fiqu1Sy3tks4wpNpjdx+mmb5sn7i
         +Ch8ltqSeRH25KlLGxyBydDvl9l0wtHlLKtagEZxA07diNzWr9wDDN06Il+FMHwd8zyq
         cFk7YewQUK9Y1NoaHw8MKg0969p9r9wqLoMsPdbKvrp91vrJZ2oJgeiPQXWzbJeRBFyi
         SiLvK5K8682QXqDHjxdEGeHgy1EFxrFsWCfm9YmDHn7RFkSkA4EOMhMtce/GZdJr7pq8
         z4xiDSWnHP+GBp/hBRTP8429qzLcshvFlIN8eECH9ci7ctQOoPk0G+hkmoy8UFkQNBCS
         dhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300760; x=1779905560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdU4pIR9GEFmUiowF5+zoSCvVIVv3g6BVDDhCzEtXBY=;
        b=cLwN83inL13BCfA6diU4bUOUv/QLy9OR5Xe2Cmcqmdj0+1PSg2L3hWy9ieCtNSAhmY
         dsGzY1FSazvzJKNIRf9/ZSw+vRpY83RHT83DSjdTMF+e/gvpJpWdZ8pQQPLvyv7csRJS
         7Le8P9RXT1GscQuJKxCFJEClw01nFxCmdDyegNnIqEfeiHWq3++xQma/fopop43MbEka
         93Wi4hrlGtIvm6LEuC+XqI97rWrwu268UR+A+iJ6bwZwd5Ey7fHuQQRH5biVG3P5iEjw
         UsslT4Pl8BOcg5JwcWoLwLO0kfyg/JCnXlII35dNxzXkYg2sZgA6MTBiKwvWCmU845HN
         nOsA==
X-Forwarded-Encrypted: i=1; AFNElJ918/G1+UOPdfAywXnhhLjJFJL2gJ/rpTQTPfwfaK2hzmbH6Lrkf6FeJ7CUNC3jEgHui+Ril3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPb/yUxWxHDJgC9OVJA4dBK7GKDav9Z9eV0FQ6jndHLNlzaI/
	FvhUTsY/TjMRvKGodtoXW5DPzkeJfdh9ffZpNRGbRR9X2AnFyRocm+zOHXpvnY8BkPCfozwV+kQ
	AKSigxAYwPw+XoA2AaAZ1hjfap8v+fg+k/S6AmPrl
X-Gm-Gg: Acq92OEa4QXrOhhxHaTds3/0uMTSHPIAD35BxhG4pgGKCqCb5zFPLl4GA7rN07mzuHV
	txPdSHlMr65U2ACqpV+/ZfMEWlJt73pW4pN0+pg3A7Wwzzns2gT3Ne3QqrL5Xow795FBFLy17RC
	1e/iCg27rvsvz2ObxpEj/9NbmApSv544ikd9RrBnQqSav4TFyAr9vEKg+9FrgW3bWYmkM1mi5ak
	8iA3+xjLXpDtfOuOdRIkUC4BT0jm4tBvVqh2gSMP+iGcbWGMNXhdseOnMkRGncPJlHreQS3LuE6
	OOKXYB3znvvI7+EkoE8nUYoSEZQQPkpJAKDd62N7B2SRrHIummQq4KlolrT8D+MkmfCDPkNru2O
	aWL3bkEkPM4tSZ+8w7ku6wBVZpqFt6vm+FZazFwN0N19qz18kdWZLnQnO2Bum9jQ=
X-Received: by 2002:a05:7022:6b9f:b0:135:52d3:d9de with SMTP id
 a92af1059eb24-13552d3da0dmr8811519c88.15.1779300758956; Wed, 20 May 2026
 11:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519084611.2485277-1-edumazet@google.com>
In-Reply-To: <20260519084611.2485277-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 20 May 2026 11:12:27 -0700
X-Gm-Features: AVHnY4I_dsz02rirRTut73ph8KwOYkaswxPyj6xc3PplZZzK4QfjYjqdZ9ph1k0
Message-ID: <CAAVpQUDUQ7Sae3os1W=F5-c5j4UPCVQnfQZ9S-ewXu14vOsDNQ@mail.gmail.com>
Subject: Re: [PATCH v4 net] tcp: fix stale per-CPU tcp_tw_isn leak enabling
 ISN prediction
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-290038-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,meta.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8D8625963F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 1:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Blamed commit moved the TIME_WAIT-derived ISN from the skb control
> block to a per-CPU variable, assuming the value would always be consumed
> by tcp_conn_request() for the same packet that wrote it. That assumption
> is violated by multiple drop paths between the producer
> (__this_cpu_write(tcp_tw_isn, isn) in tcp_v{4,6}_rcv()) and the consumer
> (tcp_conn_request()):
>
>  - min_ttl / min_hopcount check
>  - xfrm policy check
>  - tcp_inbound_hash() MD5/AO mismatch
>  - tcp_filter() eBPF/SO_ATTACH_FILTER drop
>  - th->syn && th->fin discard in tcp_rcv_state_process() TCP_LISTEN
>  - psp_sk_rx_policy_check() in tcp_v{4,6}_do_rcv()
>  - tcp_checksum_complete() in tcp_v{4,6}_do_rcv()
>  - tcp_v{4,6}_cookie_check() returning NULL
>
> When a packet is dropped on any of these paths, tcp_tw_isn is left set.
>
> The next SYN processed on the same CPU then consumes the non zero value i=
n
> tcp_conn_request(), receiving a potentially predictable ISN.
>
> This patch moves back tcp_tw_isn to skb->cb[], getting rid of the per-cpu
> variable.
>
> Note that tcp_v{4,6}_fill_cb() do not set it.
>
> Very litle impact on overall code size/complexity:
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 2/1 up/down: 8/-15 (-7)
> Function                                     old     new   delta
> tcp_v6_rcv                                  3038    3042      +4
> tcp_v4_rcv                                  3035    3039      +4
> tcp_conn_request                            2938    2923     -15
> Total: Before=3D24436060, After=3D24436053, chg -0.00%
>
> Fixes: 41eecbd712b7 ("tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per=
-cpu field")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

