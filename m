Return-Path: <netdev+bounces-273048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ez/GpreyWnh3AUAu9opvQ
	(envelope-from <netdev+bounces-273048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0B354C3D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CDE930094F1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64A391E58;
	Mon, 30 Mar 2026 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmRIGMgV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FA34405B
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837390; cv=pass; b=Cz2twHS6wva4fz09rXPxB3hLQg36rdomZQI0MsXmMifhQHJnZ3gGtvJiP/jjTKWm9QHf0eU0EJGsR1uY886+WLLxzctEbvrpQcoVhGbYSXgUaEi4Y2VxuL1G6KkKqspGIIoB8Ce4i4UCS7Zd+9ZrYEg5oXup5moAYqAOpcyX1iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837390; c=relaxed/simple;
	bh=B5l17OTVu2cjpFOePRpq3p9C6pV9J6gN+48MxLiURD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrRDQzyBT22J/5pzKRUcmIltD8PB3A8Eq4oPkeH1LNOdeseKKbcpjWeIa8qDJs1EqPAkLEX4wz+ppnGgzU0lV145ybSljl+sz9C6sZ1T3INMGNfzMUdtYZcno2FLbTq2D8Yra/zClD8NSa3rEk2nAD81zFTXmQVHky/FJVY9RRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmRIGMgV; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2b383cefaso1258998e87.2
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774837386; cv=none;
        d=google.com; s=arc-20240605;
        b=c6dYRudothxmaP3mIcmr48APdinGeaLZJPiMchGHDdSZkML8P/VebebwDGkNdbF7LH
         5fXoXIpdj8OimT6UhD7QXXneBnz9BdiDZ1q6FVJVyt2opMhZgrEs4MuVs+URH74kKjQM
         7Abe9k9NdQveTn0asZGuYDYA0BqPwWZAIhIeDO8M/tZc9OrIdRHOD5HEB4stW3RW2qg8
         TRa0bh6rXL4Q14wGKLsVPHyoU8/+LoN/ylrm/X7MXTx/7XwZvqZJ5gC/PhC8TuDio3cW
         1KC3EqbVnZ1tA9NFzQjan9ulJfh0obLq53lWu350aPnGOkaOuxGMH+nl531WjpSsNTbb
         B3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ek5GIhyIQVD3wLj7CUw7tIfTz6hifMBva7KkCCkNds=;
        fh=lgknjZmIdOGa/4jB8NmOFU5fdZChGiGSy69NgbS5P8Q=;
        b=WuaJBsbLT5EaIAM6EO/H8lDqG2wE8mtBKVJoBSUyVhk9o6X0X46bTXybCkccxGLrWm
         /6w4pgOesHrgmFfeOi8d1+3tyDJXt0UllDs2/M4OsJXpNc5Dn0SQ/MZai+TkpWNska79
         lDxNJZ1bGdXeHbIo50dj7SEx3bG80qE52mY66uGTX/XB5auerZ9kA0QQtqOuPZivToY7
         t8fKZlQ6upYVJ56UpitSqrQYDygErqDwj9T4EAVB0U9PgiRARF2YA7+UmXbePfc4egPX
         v6YrDgN1h2B8BtyZI5rrlPu0pQ5goAY5g9uM4Unea+zav829v1JH8zXpdsTJF4U7ZQRr
         3b0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837386; x=1775442186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ek5GIhyIQVD3wLj7CUw7tIfTz6hifMBva7KkCCkNds=;
        b=FmRIGMgVrUJGcBtoP/133eOBuwfrg/TxHiOSLyvg7kTMxya3DQg1GF5HLNfb1sb9lj
         B/QJprB8Emrp7pbGOBrpXHSQAehB+JnBLqtXLfSnRVJRHuH7IIYLPXQcebWQjR/3QKdq
         pYaT+PTgdWL/tldY7VPwm5wjVvcrtB5xx+RbXBcxBLxZZTIVVW8uAOqyTY4ALlhfsO+2
         X/nWwrHb1CVTliaC3HrtopttsG+SRlBLdzzMl+60MzUXLjUD759m42SluhuBmZXrXFRJ
         VTPGiQSnM0plIEROQ6781PiJAaKACSA2dOCwKMHja1qrYnQHDfphRpI8clcDTAQBsOgD
         OwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837386; x=1775442186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ek5GIhyIQVD3wLj7CUw7tIfTz6hifMBva7KkCCkNds=;
        b=oLQ25XrDfV2WF5bhiplmyr/lK5T/CvappWosBLlgSWwNujA8DnmrwiOGtu0AwAJDoz
         evxM5Be4Ffd0CuP7UKBrzo8VPgugwcPj0w9/8NksxvvN2kflytGp80N9QToe//1KsKYV
         ChvzDrT5NHR1tIzL8UhvFjvOrYA1ekgWKjRa/RFkbcOUoJJ3nO70DA3A5s5nogR4t6mX
         JzYNxVOZxGfCq1uxzTo7gJGPgf2C4XMA8E+73gZ+ilX779DN8AZhDnl61TkY05Qb5zzn
         Dh8xK2hggIJ79Z1FvACjrTrnKGwbStLToi66YN06zwc+dgAi49EJMwCkQg1pCRi6mQg5
         a38w==
X-Forwarded-Encrypted: i=1; AJvYcCVJmqvhm0x19OM/nqZgzfcCT2vwBjmiLZ/8awmH5XBs4Zk3Qc7LoNicIWU9xdpEawfzG/+rNs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRoF354N1ywc2PKC0UqNiE2gg2H680LdKfgbaxdztazymif4W
	rPMax1SQjsj1Fj/CsjLKgPXNCmoelSgxXLgCLbsQWNeZjrZU7jPJurOYFIQ4Mf0zzbYGlNAzzss
	0TZu5y8rCMU4XDqvbfbV3e7bR+J8Le7Q=
X-Gm-Gg: ATEYQzxOYlZw9uFyHchLBo+a0+ocqsGNCTfadcXdkkgc5h7veOZzuuNINqycSTzpNd9
	1NN3iGHuoUlFT7nTeTLSSh3Xs3SpJskHlI7naHaTDiAgQus5zIq1K8LvTwmr1WVfhhDTyaXQeWC
	l1EVvwfXS7z2NOyKfgygzEbEkm+OezZzkf+0J1ul3V0TZewjvvnbNElqSG5V4Hd988XlW2SqqIJ
	RwiPxmRklDIBb3prrfowgKvBLL7fOpKkQWMRx542j2INtaOY6O07uR6VV9QRZw7QFo75ijurjb/
	ZWB3FRrR
X-Received: by 2002:a05:6512:39d1:b0:5a1:3d7f:8fab with SMTP id
 2adb3069b0e04-5a2ab7e8bcdmr3190406e87.6.1774837385352; Sun, 29 Mar 2026
 19:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774701288.git.linpu5433@gmail.com> <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
In-Reply-To: <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Mar 2026 10:22:27 +0800
X-Gm-Features: AQROBzBGnDP9EEjcuGYNnnUp4mCdK5fKKNS026TLBUZX8qdJgLBo5d_G7k5Wzcs
Message-ID: <CAL+tcoAVFuBF48fK5yQs+jksU1w_wpEbLX5G_nzCAMoPP9dJ+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
To: Linpu Yu <linpu5433@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, linux-kernel@vger.kernel.org, 
	yuantan098@gmail.com, yifanwucs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273048-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AA0B354C3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 3:33=E2=80=AFAM Linpu Yu <linpu5433@gmail.com> wrot=
e:
>
> Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
> packets always enter the Rx path, where the kernel expects the
> selected socket to have an Rx ring. A TX-only socket can
> currently be inserted into an XSKMAP, and redirecting a packet
> to it crashes the kernel in xsk_generic_rcv().
>
> Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
> them from being published through XSKMAP.
>
> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE=
_XSKMAP")
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Signed-off-by: Linpu Yu <linpu5433@gmail.com>

Thanks for the exhaustive report and fix!

Please use [patch net-next] or [patch bpf-next] as the targeted tree
for maintainers to easily understand which tree to apply.

> ---
>  net/xdp/xskmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index afa457506274c..6dac59ebb5cf0 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map,=
 void *key, void *value,
>         }
>
>         xs =3D (struct xdp_sock *)sock->sk;
> +       if (!READ_ONCE(xs->rx)) {
> +               sockfd_put(sock);
> +               return -EINVAL;

Can we use -ENOBUFS as well, like how xsk_recvmsg checks the rx ring?

Otherwise, it looks good to me.

Thanks,
Jason

