Return-Path: <netdev+bounces-254066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOhzKRhzeWn2xAEAu9opvQ
	(envelope-from <netdev+bounces-254066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:23:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACB9C35F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87D0C301DB99
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742E28FFE7;
	Wed, 28 Jan 2026 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq4Sp8PR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886228FA91
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769566974; cv=pass; b=X31xYqPYQoNWXaWRgd7r6Ws9A96XTXU/8EmPmdkp28XrGrha+nacPlZVno2kJBjTpazkjZr0+q5QoRXiy3sWKGx+xXV35CemPz7x/aU/YUDzTJG3bmQq0tj85pIiYQJhZMYqGnDT4Fra7ezR0CSz3Apdqq/iD+hPDmXuyG+09+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769566974; c=relaxed/simple;
	bh=rzVBwGEKD9+ms/f2H1Fg5eYwEYAqKpGQeQ1ZekhzsGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVz8F3E/Pyh/nVYHyrL6s34tx5ZFi1z0YKKYD8EE8rBku7a0Lr9YaQ3pfOmYBDIGzS6trZ8SFCjsNfNjKICafs3OANOWwLal/TX5MYiqTHp9+QUWAl5dhI0xCd77SIM0DFh3uDBGPIc8a5sXueTZujWv/P9KdI6E0MqpJX6DN9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq4Sp8PR; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-383122fbc9bso47741021fa.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 18:22:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769566971; cv=none;
        d=google.com; s=arc-20240605;
        b=NWfckEV1UsAaHom20JllZD7eSvRNyxvUfYEiZJF7ezBcpaZCsbNMNznXW6Q1PbBFtg
         ysHGzkzF7rHLWgT8z48Ds6X56TC2zOhu0dryG1VE0FFDFp41/TvL0hJMoRfGX+cOgaUR
         ZB4wr3cXgNJWBy2zN72rUzA4IPq6rq31snjSdCbmucJBsKgD1u6DcFf+ykEe+hnAKzeD
         yhnOHme1X6rSnx09NeaiuSGVDODJZLpwIYTTErl7mQlmu4+7Qt+sbATPcp3N1qjlCviw
         pD3kOzw8ieoTfxAMHKqJrBEg7/3ytDuP9njV7+S/C0eZ9nmj9tvsPQ0NObcWLOOUXqlh
         Ac1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rzVBwGEKD9+ms/f2H1Fg5eYwEYAqKpGQeQ1ZekhzsGU=;
        fh=1pVVwuRsUIsH0ya/BN0fF/OgV25miU9LjB3N4m0aW9I=;
        b=BX7RfvoZ+XzuLn2r78VdqgowbfwzjupxrLoI1WmXgelOt7BPF44Tdk1Niv+Th5HC4H
         FqInMFxHrZp8v5CW2m7QcNxAm2EmWTL/yLpLaAxEDS2/yHT1j7Pjr0BT1QDVDim3RmYa
         cmtVqsVr6QkyPKHqSSSidvW6JenRRq8q/3/1WY9gGsR9hZnUjFMyk1UeHCZmTGBhzXeX
         +bEwlCAhYrnu2ImkB/Qe5NIP5axZkKNgeZ3C3KiPoShgRmJINWCeyrnOh3oo21fvCA9K
         5hVEqBqi9sab5HVu6DYBssE4GEbacr58A235JFPr+odTk8rZrv7TRLk/OiLYkGFUur0A
         H3RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769566971; x=1770171771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzVBwGEKD9+ms/f2H1Fg5eYwEYAqKpGQeQ1ZekhzsGU=;
        b=Oq4Sp8PRYrMXuHtRp0rfMO4uhaF+8WU2Ij/EqgdaDWJemL1O/4PZddAMjY1/p9EvpU
         CqoVWr6WQRnwgpELUWVNza9lzSYVEIod+PbPvOFcjjTdD4VCLEFxvlB5ffPd/7ugXvV7
         lCGpxpVF8uD50DBABdXRn8Hfa6Pp4DikT5UPW7TJC5QcvvjRNT3RAB4mZCgWU5YP5OCQ
         +c+NYovnMzw7gh+xUN7quQb7XvfqxcfbNQuNhpvJva1IKLwZ0LweCd6YtKHu9ReRAWjV
         uOFWsFfs0TZ2qoZm4TgeFmglCwahCuBUENnHIK61q5+DPoC6ZdTvgAczkx+DRn+37VVi
         R/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769566971; x=1770171771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rzVBwGEKD9+ms/f2H1Fg5eYwEYAqKpGQeQ1ZekhzsGU=;
        b=EpgHvsd9GJ/7KiViCpLvGlFgKDsfbaKju2hsuZkp5ISrJB4HT+ewlekU629dHijM8j
         B+ttb4bWinFykuwRgXY3HFrr7jNsNZskD+zxH2rRMHdcvVrWqwxRWeV2buj4Xl8vi/6c
         94zkvUztgridPvVhSQTsD7jWPYTLKNuUDgbqzGO5CjFMCDHZL1w+X6VLCFa6wmrm7SEK
         OsC0PpYqVvQFq/tV9fzC+m5yPsFQIyGxE99TImzGD1nGBYUgiaHmv2g/Dt0TWoi/0ztK
         lc5Vz1rhQHWdfqVQHs9zg9auKWEijdAZLLvMhCy+0Ih7DXqR5UoiuOdOGdrGqlfmuIEf
         I45g==
X-Forwarded-Encrypted: i=1; AJvYcCVfVj6NEzlMgsErfHQdNj11duFyAQ3AFQDO2sRll+qy4Ga5/NH7f6wsnKKd/5uDvPrL5VEdMQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoN3yorwEFixQuVcChcQJDc7BmyNoaC6UuQdQp/46d92ho3Hq4
	wjVWgY7sWg/732REniqUVmbjd7cWYBYnFbJ/3wq4unLR29Yzi0i077UDRFBJRRy88rhmRbMNn/K
	PDhWGPZ59Gi1r4S1APOvo4jBYHJ36H3g=
X-Gm-Gg: AZuq6aIKaMkgfxmoOo7+nzNmL+X+zbirGSJuEPmJlrQZOCyPXLZi83X8M23IZgbTk4C
	KjKK66cEYqWoRKB/jcYxs3PDb3S1zzn+f6sZ47NTbig+V7JxXlw+DKsMDMJ/aasq4kWVA+ZqpwD
	0j6vvzBM3FLFI3hRYo5NRzWqjt0BgS6ORSHvkXt9XpQ2DIYA60yhaDkrsbjVWy1u282M+EHV4+M
	yhg/r4qNZ70LYRVxolB/SxfVVv4G0+naPxEzKf92ACWPs3/oJTQlhOyvxg8HejaofvWlJkv
X-Received: by 2002:a05:6512:3f1c:b0:59d:f66b:8ed3 with SMTP id
 2adb3069b0e04-59e0401fccbmr1510532e87.15.1769566970509; Tue, 27 Jan 2026
 18:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127123828.4098577-1-edumazet@google.com> <20260127123828.4098577-2-edumazet@google.com>
In-Reply-To: <20260127123828.4098577-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 28 Jan 2026 10:22:13 +0800
X-Gm-Features: AZwV_Qi3xuKgR9VTkjPwgjaQs-WRB0Kewi3yJB9NyVH4KwgtPw_Y1e4jAydljhM
Message-ID: <CAL+tcoB6RXXxL4f2hrbWq8gHX6=7VOY3c2+VLXiumewUefR11A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: tcp_tx_timestamp() must look at the rtx queue
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254066-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 22ACB9C35F
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:38=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_tx_timestamp() is only called at the end of tcp_sendmsg_locked()
> before the final tcp_push().
>
> By the time it is called, it is possible all the copied data
> has been sent already (transmit queue is empty).
>
> If this is the case, use the last skb in the rtx queue.
>
> Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Great, I failed to spot this case... It could be reproduced when
'wait_for_space' is triggered. I strongly feel that more packetdrill
tests are needed to observe the behavior of socket timestamping.

+ Willem

Thanks,
Jason

