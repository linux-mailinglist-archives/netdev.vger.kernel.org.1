Return-Path: <netdev+bounces-63284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724BD82C20B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74F728574D
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ECB6DD13;
	Fri, 12 Jan 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aRDDlGZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B26A345
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e82f502a4cso55571577b3.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 06:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705070912; x=1705675712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WR73teShbJ9NEtb0Ox65z8xu9lXIgYdBOH7yn8rs2M=;
        b=aRDDlGZuhbDZQ9Fs++HFIkm/bRDl9hMjxCc5St1nrceJunjwhFBVHp24gjoEUD5pdJ
         XAaIU7WSi2dpTshMyfCj+MMt/Lj1xKGBRzlt5t5jkRqf5gyhn8J00gC5sdwYCxj7qbSG
         Ag+nnPPGROHo3F7ainUKG3z3daSa5zVrV1mBfUcw3fhdj1z+ku1ioF4QaOaXWeVBv84Y
         XzkvCDOGHEBWARCdyZbrx3UjgCRBwhzluG7Bwug9Fz3BkZyPPrMjcNwyzWrn0Xg785AD
         arT/D/ZsRHN9SJgfTNObuuI8+IIGgEPiTHGASJ9tAMmNmlZ5gCTeD2yTphbtFpZy6w4f
         nkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705070912; x=1705675712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WR73teShbJ9NEtb0Ox65z8xu9lXIgYdBOH7yn8rs2M=;
        b=voWkLHkoa6ByyNPbm+9GrtX9U77aspppQwBsq3kFtu7uslkWOtXtgNiHOh6YBDqhs2
         kkwniPQC03N54W5Tsnuar3/tYlSbscK4nF9CjyUYKuj1ddSfWyGoqUZMlUjIUMtzSBuI
         4YgMFYNgSeZx75rGv4322wFSFjZRwevRaWS3qiwble24N7cNLweMn4iP9zQWtLxUbfAd
         aQjd5eHDIKcyXOUSQ8Acq+XCCGX9NEufadh+/wpJV2g3oRca7SnRLSLOoA1LXOVnpCuP
         3imFP/wWciJqY42Tr2MI6JBy2DmmV/hRjp2pcI8aO+w583mf5ael4o8G/Uae46n75S0W
         T+xA==
X-Gm-Message-State: AOJu0YwtL83hcunKCw7SxCHbFrAnzSOvYwIdHDVN0ggajvN9PmkjHvIK
	F8xILGNa4+Du+VVuT2R8ifONhYKI+Ihet/ScDSRq/vlNuCmL
X-Google-Smtp-Source: AGHT+IF1anLH0ERgyLctOxNtdOCXTp8LOIFKrOy6Qa8zYfIYFyJefdGE+R+PPIj5LnUWQZs5E032nHesfjhnZhCOZCY=
X-Received: by 2002:a05:690c:3391:b0:5d7:1940:8df8 with SMTP id
 fl17-20020a05690c339100b005d719408df8mr1321278ywb.95.1705070912048; Fri, 12
 Jan 2024 06:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112113930.1647666-1-jiri@resnulli.us>
In-Reply-To: <20240112113930.1647666-1-jiri@resnulli.us>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Jan 2024 09:48:19 -0500
Message-ID: <CAM0EoM=sg9ivqey0sG7E3dC_Sh=_vMgNJpJrUzxp9OcPAdVr6Q@mail.gmail.com>
Subject: Re: [patch net] net: sched: track device in tcf_block_get/put_ext()
 only for clsact binder types
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com, 
	victor@mojatatu.com, pctammela@mojatatu.com, idosch@idosch.org, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 6:39=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Clsact/ingress qdisc is not the only one using shared block,
> red is also using it. The device tracking was originally introduced
> by commit 913b47d3424e ("net/sched: Introduce tc block netdev
> tracking infra") for clsact/ingress only. Commit 94e2557d086a ("net:
> sched: move block device tracking into tcf_block_get/put_ext()")
> mistakenly enabled that for red as well.
>
> Fix that by adding a check for the binder type being clsact when adding
> device to the block->ports xarray.
>
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Closes: https://lore.kernel.org/all/ZZ6JE0odnu1lLPtu@shredder/
> Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_blo=
ck_get/put_ext()")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/cls_api.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index e3236a3169c3..92a12e3d0fe6 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1424,6 +1424,14 @@ static void tcf_block_owner_del(struct tcf_block *=
block,
>         WARN_ON(1);
>  }
>
> +static bool tcf_block_tracks_dev(struct tcf_block *block,
> +                                struct tcf_block_ext_info *ei)
> +{
> +       return tcf_block_shared(block) &&
> +              (ei->binder_type =3D=3D FLOW_BLOCK_BINDER_TYPE_CLSACT_INGR=
ESS ||
> +               ei->binder_type =3D=3D FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRE=
SS);
> +}
> +
>  int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>                       struct tcf_block_ext_info *ei,
>                       struct netlink_ext_ack *extack)
> @@ -1462,7 +1470,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, s=
truct Qdisc *q,
>         if (err)
>                 goto err_block_offload_bind;
>
> -       if (tcf_block_shared(block)) {
> +       if (tcf_block_tracks_dev(block, ei)) {
>                 err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
>                 if (err) {
>                         NL_SET_ERR_MSG(extack, "block dev insert failed")=
;
> @@ -1516,7 +1524,7 @@ void tcf_block_put_ext(struct tcf_block *block, str=
uct Qdisc *q,
>
>         if (!block)
>                 return;
> -       if (tcf_block_shared(block))
> +       if (tcf_block_tracks_dev(block, ei))
>                 xa_erase(&block->ports, dev->ifindex);
>         tcf_chain0_head_change_cb_del(block, ei);
>         tcf_block_owner_del(block, q, ei->binder_type);
> --
> 2.43.0
>

