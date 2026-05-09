Return-Path: <netdev+bounces-286113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEh9J97f/mlxyAAAu9opvQ
	(envelope-from <netdev+bounces-286113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 09:18:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F724FE6D0
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E1B3300B45D
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCCF384224;
	Sat,  9 May 2026 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPd9L6Cs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045D37DE90
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311119; cv=pass; b=sULziq720uHatQZ0I1bkAuYCWpckpCkLP6xUM5gKR+lL9eP37UFg1UvXnzGpPeT8xsCASo2jvPYokYKvt/NYgABQqtvFk25y0uI6rVgVWvK9bmqft9zetNUuiY1xImN2koVjPlc1kfnN6jQOPXULnROHaeVwFXHuOW6TSL11a4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311119; c=relaxed/simple;
	bh=pbICpdMRCZvZ50IHhxVma1ZkYUoOVniItWErjrjKK/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9nVVsNfKM3/vyD7t408+bSXO4qxDLzsKnAL3sKGADXy4Q98EVJN61UDtGivN0LcyoLmpEMIyK9KSwXOjdgVaBWRyuIMsq2XQNJdEGNoIV5fZTxg6OKX70tDJkXJm4T6UCYc4es50f3Vs0x0YYeYYYVHG1qeb4zsNebA2bWw3J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPd9L6Cs; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso2519435e87.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 00:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778311114; cv=none;
        d=google.com; s=arc-20240605;
        b=QM4uzGB9GnoiL+OvX1BC91qbuXqqQyh4pvCE6uq+/ofXfp3GIM1J6ceGFN0zkS2mbB
         qYw53meQz11viO54YtG53uiIyaL+CDIhYSy21wgBhGiVWYYLG+4Wv6xobqIuZuvTi45J
         MsAJ0QUWXpoqqz7rUT/D19ZBK1W6GpkDNAMNm5h9RAK3VkgJDiFnow0/OQ+ucI2tQtRo
         nbHGjA8KVwSUR9vh2HUvmgeA23q+R3GnpNDrQmLzCznGmIvQux0y8GWFc2ZdiQzZgnYK
         D6BMc03Gi3qrHBaoytut9gkAKda9/2WrW+VJsIg6SKd2724RLMmNUWa+x7yp/jcr4N0H
         CPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OGTzXJA9ES0mx7H989TSSSZHimLRqgQzpIBVyzdPw84=;
        fh=nm1bo9FxU91BKlOB6h/fKd4HBXB4X74gsa/YT7JRUAY=;
        b=JDODNGJGbk/kwOjc4uOIVnTCx/0XEYiwmvrlMPnWsdf9x1J4EK2K1GYQ7G1vdveItm
         NMqeZz/0dz57MTFHElqBmxCJnt+lzZ3mY4vS3FeWtU0KXXLn4njF+zQQxrO/eJgY/4iE
         t+c6u1xvLamTqMUH+OCuPwkP/Up3+ztWlGjpL4MnHorlk89/pVSfguK9RQ6KGOJFsyiP
         Q7AfdEC4x275kMnUxsd+NwNP+5M/J2f6Lb3Rug9b5A8d5eAmY0lbl5B7pVOcPyY0GhIj
         wU2Ca4dxn0SltlmiVK+R7BXsg2VdPNVRopwxD81ljiNU6UpcOsc7l70Ybr9Fzl8jZq3c
         5uQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778311114; x=1778915914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGTzXJA9ES0mx7H989TSSSZHimLRqgQzpIBVyzdPw84=;
        b=mPd9L6CsCGyGRSbcNGVrlJ3sy+4xS9eySw2QE9TXc5X2AEZbEGMeqto0DHlcbVxkwU
         RamhYpmQE3/yKAId6wnO7PvPWtpEKoxIDkh+aYo6IIU2tS5zohzkfBFWYydswVHyI5aj
         g5zu1ngY7sxQhKqsLA4nqZIUIMB4mRI9qh58XYtQ5khWAjnTK0/lpL/9snwvDmkRV2YX
         Bm+5SLygw45vD2/HMgv9nXWe5jxFKOlza5anSvvjH4vASSZkAEeFpkP8aayikTPUPlKT
         3v9ryBCMH5zp/xkk+d2pFtnvSxqSlSDfKVyCq8FHbbwpAk5sSz22Sea+ms7hSKRPPeSj
         QycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778311114; x=1778915914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGTzXJA9ES0mx7H989TSSSZHimLRqgQzpIBVyzdPw84=;
        b=k2t9+rPbIm18bWzb3DP8JTKjRkoP7BAZ+sh3WZMKG02UmvexBzW1M8iAm2Jv3FvKRt
         TuMKFx0X/6g+Wo7/CITb0UVpblLjDr5UFlSgTSpvVHG79BKvsqIGl9AM3LZMY/gMrdx1
         4e5UHxlH0f7vWAkoYFwuSmrMslw9qzS+VjfnzxtuvwT7cqmRHiBppbXeie/G8c3TmaAv
         4erNWGh7CYrm/J/PNjgkC1DE1cKk5Vkz3gUuvrhGEmp5B4EF1kYaxRvh4U5ap7gzcvEl
         Vli7MPIJxayhx2+MW7cAdof+jcCPRN+fVJyfYHMJDld6ayITsyrpIRWDc/NcEqN5HfHK
         hzRA==
X-Forwarded-Encrypted: i=1; AFNElJ8CPYOVbHxuB4fO8/OEyQQ30DibnEgMU/4bk6aNk08n7Dg54l4XMHdMqHy4gnFwQOfEleCeKdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XZacJMPtxj5DCwQpik2z+u6rvBWvri4gu/+frwC1RUG4hlLY
	gN8v2UnABeM4rsmu14k7GDKG9/JsBZm0CntZwJcnXMtl6NMQJS5EzJnlXVYSCUhSgzB/cxes5rG
	BqtgAYkCVgqkWTQ6iVN6Apb51nD3E2Xc=
X-Gm-Gg: Acq92OGDsgUkuTNgiNppC/MHWrY5hCN3BuEyfvevefHcDiLE5AHL+vMk+J49Qy8KInT
	q/ZDMUspjGQDvwXURzhcPtH2/9kbPp2w0IzJ1TA90nA29XadYcWsf17kRrmIaUZ43KPikujhuT1
	gQw8ahxLHX83+S77F5xGFLsvXYgOa6YJlFJy78NVeDBiUmH94MMY4/5TPjELThxzEo0nhUe5rtS
	zhmDhalnft9Fy1JlTtfsZ5RQ/xgeOYK0hfEK/U2bB/bnuzJKus8xf7ZAXjUmIzMcgl1P43OKeXs
	gf4v8ZNVBYqNauOUtKZgUtw1iugmdrGL1Qgssoli
X-Received: by 2002:a05:6512:3a88:b0:5a7:470c:daed with SMTP id
 2adb3069b0e04-5a8b6ca6e5bmr601388e87.16.1778311113737; Sat, 09 May 2026
 00:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508144344.694-1-linpu5433@gmail.com>
In-Reply-To: <20260508144344.694-1-linpu5433@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 9 May 2026 15:17:55 +0800
X-Gm-Features: AVHnY4JlMp6MnmwMwsLAGRRLfDaSg7w4dUAGrqXeTvNSXYdNN12sv-gwcBYGaKw
Message-ID: <CAL+tcoD4QARiHjwyW4RPBAQT-XmnLPPnathHfTSz6Uy2qJcAVQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4] xskmap: reject TX-only AF_XDP sockets
To: Linpu Yu <linpu5433@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, linux-kernel@vger.kernel.org, 
	tanyuan98@outlook.com, yifanwucs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 45F724FE6D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286113-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,outlook.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 10:43=E2=80=AFPM Linpu Yu <linpu5433@gmail.com> wrot=
e:
>
> XSKMAP entries are used as redirect targets for incoming XDP frames.
> A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
> traffic, but xsk_map_update_elem() currently allows such sockets to
> be inserted into the map.
>
> Redirecting packets to such a socket on the veth generic-XDP path
> causes a kernel crash in xsk_generic_rcv().
>
> This became possible after xsk_is_setup_for_bpf_map() was removed from
> the XSKMAP update path, which allowed bound TX-only sockets to be
> inserted into the map.
>
> Reject TX-only sockets during XSKMAP updates to avoid the crash.
> They remain fully operational for pure Tx purposes outside XSKMAP.
>
> Fixes: 968be23ceaca ("xsk: Fix possible segfault at xskmap entry insertio=
n")
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Signed-off-by: Linpu Yu <linpu5433@gmail.com>

Even though AI suggested using EOPNOTSUPP instead, prior to this
thread, I pointed out ENOBUFS makes more sense because it is identical
to how xsk_recvmsg() detects the failure of the rx ring. If needed, we
can cook a follow-up patch to replace that in __xsk_recvmsg().

It looks good to me:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

> ---
> Changes in v4:
> - retarget the patch from bpf-next to bpf
> - resend after no feedback
>
>  net/xdp/xskmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index afa457506274..3bff346308d0 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map,=
 void *key, void *value,
>         }
>
>         xs =3D (struct xdp_sock *)sock->sk;
> +       if (!READ_ONCE(xs->rx)) {
> +               sockfd_put(sock);
> +               return -ENOBUFS;
> +       }
>
>         map_entry =3D &m->xsk_map[i];
>         node =3D xsk_map_node_alloc(m, map_entry);
> --
> 2.54.0

