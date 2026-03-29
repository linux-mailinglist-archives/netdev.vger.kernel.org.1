Return-Path: <netdev+bounces-272966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CRRnOp1tyWknyAUAu9opvQ
	(envelope-from <netdev+bounces-272966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:21:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 201CF353950
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A37300FEC5
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5435AC09;
	Sun, 29 Mar 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yx7t29BF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5036C9C1
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774808474; cv=pass; b=jyDmgkonq+yXEcJwN/ZmcVN8DILLujrOQYycolCGksg1rnOx+16Vwa4jrsBxgoP4OjBaKMUo8DtHLRFYzPCTwum/vdcVJB0Csz6h0vVuf2i/ZfpAJU2De8hrJZLLu/6E9pUpIf/sixtHAn+bSF9Q7NG9UsSL6O/rGh/29CrUYMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774808474; c=relaxed/simple;
	bh=73C3WJ5RDdrF8tYjSQv5wkqlalnH2x0/urChDim3kU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OV1nJoExDgld7pBrBqoVTHaUiKybqckGfYDk06NvucVSa7zSz6Rodi+JjRF/mwsr6+F7cRQXaUgmRUWKmsZoNiTwTAD+oRK8vKzeBtUjYq/sIJDJGmpvCdGJE6HRMm9S0/E7ZC8P1Zeb2k/A4RCvjg2WPqL8GQGQ7jEy96/plFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=yx7t29BF; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82985f42664so2098741b3a.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774808472; cv=none;
        d=google.com; s=arc-20240605;
        b=b+wnrENAy39cBo5a8yjOAZHO+RdQCIsXguz665p1dU/uJcurnanQh843/hxLcfed9V
         owy6k0+SDcKWUSCdHmqzk0ONXwWf7UnxgL+zoBa7sq23LjLYBrGZzPI/m4oV63vyCQyO
         2FCA6NXw9/cDQpfiEfcrJdv+7VHvxK8qR9+GBcfI9sb8giyZNNnx0naHH+Egm3KyObJM
         SPnjWwRn9SgyfEFgRoFmSlLJe5auxEi1gQGOEGBoWTiYrAFG6wJOJkPDEU292zx2OzVy
         z+E61TO1U6wx2d45nUsKkiO4IMVrEhxM84v/s+0Y9sc1B3WeSLduFwXNmFdaBDfAgGXm
         DIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MIbiC9CIBCj/IwMBGBcCXDh2saNYgnIsmNxfBy8jHLk=;
        fh=YC9frv2iphM4JV0oG8akhBJrDMgKjONtYBga8WRhVhU=;
        b=lzHYPVjzbpjwswhVz3FL2lmYsprni9trzX5zWnQwGy+Ukce3h8mkP+0MJdLJvCNkSI
         sz+H8H359c7xN+6eb0GZjsNm0IHcdvRWZOwxof4Z2ZjYreFHx7hzIZrRem3PM0XIuh2x
         kvfmBK+2i1ATXJHLI3+WseG9ySxxJdy2CP7QKz94/gSbMdUlAgfYITE9v94yGkInprpg
         HIO51OrmWkL/F7JBwkXzdd2lVcbOaFBZcrOFBgC4XZlLEwjuYZiDeaolUJRy7VAvvpTC
         qSjOE5Oejyw24Zfhdshu42pxF0Du6ICZbwoP4t85qmIP1FuaFYJttIjHVn+UrlO3RkjV
         991A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774808472; x=1775413272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIbiC9CIBCj/IwMBGBcCXDh2saNYgnIsmNxfBy8jHLk=;
        b=yx7t29BFp9wtBqUSWgiUaYxOCN/hv6g9OHm3QOmuf0RD+9KwH4JBTz6mwvLvhJaowY
         iyDwwOa0Mjcc+6s/L4xEw66hFsqabUwNKg0JjNSekJASN6k4v3h9uAvwhx9aJnlnSlYa
         Fgtjf9iBUVWQQzVOOmMBnCXQ2VFMetELf9tj7guuliAl5Ld49Q3N4i8n6kfu585GXC/f
         00jhyE1tA/z8E9bSOWP7jLfZfd+hff6KYEGmeZzob3ujMJsCTXs9qWtv32/KJT7HowJX
         rymVP4IXl8TfYLZSm2kzkckN3iO5Jl2c7SFUYQwgn8ZNZaK2oONdG0OSoCZ71G1UgHs6
         79gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774808472; x=1775413272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIbiC9CIBCj/IwMBGBcCXDh2saNYgnIsmNxfBy8jHLk=;
        b=HLILGhHKlDdZYKvy67p48/8jwra6x0i4dOiYLqbQfsU5/AbTP28wbhb/bSkVci4Do/
         pRVeOC+TifvG5U0X0dbexVlgkVcrWL9gIIrr7Q1xxGRm/40nWccUEtKXghJyxATrJjqI
         f+QuWZ9vH81wUK+320n6EiIOqjdk4iKGLKNoCcEYujB/rgb1wVIwIUAvEPY1fFS5csoq
         6LZidm1cvPrruUgwUM1foSda9orDtwLFIfz0c0IlxwM+ZNxXXYqGrpVjrvZHppaXr8Vc
         xPLxyixknFrT4vPwY44XSGsbpp0K9YOtYPKk84So1Xw6RSCsPJELZbpwsogQovc1Y5VM
         d8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY3d3r58hgGK1c7mJDnm6DkaGkncpgYa0rbVSBtiyEIi6evlyoQ5ouK7FsCF0MtOFzJQjQt/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VUQ/LbsAFM6pHXaUuW9s2WdlD2bx7AbWgzLPPgjoQMgcwK1w
	wzHD6J+BQwnqFToJadlzIbnoNszl07279QViWo1H4rRRHAa/3Iq8lvlVYONtYIvS7huD5BAhPUW
	4S/7kR44P11Lrohg/rNQDNAevsLTBaNkoCGXnXayL
X-Gm-Gg: ATEYQzwCbxGW4kjtu9xuLPWRc0PaakHJ/0SmM4PQEdZBxKPSb+TqjxZ46FbM5gc2Zot
	Vtys7QXx5fJUjsAY9DyCxBFC9dHGvh2QkjZyRi3IFEkDGzATwzeMDgIFjzM6vCNgZOxS8FhEThu
	qKO7phUIUX1Frx1wW5c4Vx+zgsycBJB2tp5fXFcOckMlaskTeELA4Mu2+iSONk9FlDZ8UPwUd+H
	xh02nnzy5GwAf6ZquzogkgXkgNWsJ9uk9RASxY8vnmYgQj+kwk0wJQE2PPd3VOWrQYJphhGvJTw
	yDUMqJhplJZLMaoSAdI=
X-Received: by 2002:a05:6a00:bc90:b0:829:803e:6798 with SMTP id
 d2e1a72fcca58-82c96038f67mr9133226b3a.56.1774808472151; Sun, 29 Mar 2026
 11:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329165306.241079-1-tpluszz77@gmail.com>
In-Reply-To: <20260329165306.241079-1-tpluszz77@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 29 Mar 2026 14:21:00 -0400
X-Gm-Features: AQROBzA7ad3fCVZHSypyzzIibsJKqNTFgVF76S8A5IHJyu-hiuH38vIzokcphdU
Message-ID: <CAM0EoMks=GPU=2uzCNZ903=+huyStr0Zqpuy15dMqDbM-xU7Zw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: skip reverse bind walk after failed class delete
To: Qi Tang <tpluszz77@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272966-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 201CF353950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 12:53=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> __tc_ctl_tclass() unconditionally calls tc_bind_tclass() after
> RTM_DELTCLASS even when tclass_del_notify() fails.  On
> ingress/clsact qdiscs with shared blocks, the delete always fails
> with -EOPNOTSUPP, but the subsequent bind walk still runs.
> tc_bind_tclass() reaches tcf_node_bind() which calls tcf_block_q()
> on the shared block and dereferences the NULL qdisc pointer.
>
> Only perform the reverse bind walk when the class delete succeeds.
>
> Triggered by issuing RTM_DELTCLASS on an ingress/clsact pseudo-class
> that carries a shared block with a classifier using bind_class:
>
>   $ tc qdisc add dev veth0 egress_block 22 clsact
>   $ tc filter add block 22 pref 1 protocol ip handle 0x1 \
>       fw classid ffff:fff3 action drop
>   $ tc class del dev veth0 classid ffff:fff3
>   RTNETLINK answers: Operation not supported
>   Kernel panic - not syncing: Attempted to kill init!
>   exitcode=3D0x00000700
>
> The NULL dereference occurs in tcf_node_bind() when sch_tree_lock()
> is called with the NULL return from tcf_block_q() on a shared block.
>

Try these patches:
https://lore.kernel.org/netdev/CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEq=
CNqu6bw@mail.gmail.com/T/#t

Same for your other issue.

cheers,
jamal

> Fixes: 07d79fc7d94e ("net_sched: add reverse binding for tc class")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/sched/sch_api.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index cc43e3f7574f..50d311ff1f2d 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -2251,7 +2251,8 @@ static int __tc_ctl_tclass(struct sk_buff *skb, str=
uct nlmsghdr *n,
>                 case RTM_DELTCLASS:
>                         err =3D tclass_del_notify(net, cops, skb, n, q, c=
l, extack);
>                         /* Unbind the class with flilters with 0 */
> -                       tc_bind_tclass(q, portid, clid, 0);
> +                       if (!err)
> +                               tc_bind_tclass(q, portid, clid, 0);
>                         goto out;
>                 case RTM_GETTCLASS:
>                         err =3D tclass_get_notify(net, skb, n, q, cl, ext=
ack);
> --
> 2.43.0
>

