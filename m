Return-Path: <netdev+bounces-307265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Sc8BVE2VWoAlgAAu9opvQ
	(envelope-from <netdev+bounces-307265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7739774EA22
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:02:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=JMVm1WFp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307265-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C5D63016D2F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72233F8B7;
	Mon, 13 Jul 2026 19:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04A2D46B3
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 19:02:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969342; cv=pass; b=ZC6xJCxbennBv9d4UqWRAzHxiN/1yTyQMBp1nVrt6XuffOD5XlZURA+MrFy/Dhls36NE6TLIXqqSzRekLwDhQDCS+GSKB0ccRU6fAWo4D7z2fzbWe8dedTh+sxJ/Jci+wwbwshuLceRH5zMvHqQx4dLjware2ZSog1kDHzNTm8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969342; c=relaxed/simple;
	bh=LMuqfZdWNwDdBh+LD9S3nyT7cT9j5t4BEatyJl8ieNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9F6XV5XnvliO/EId1i54dPgxNa2UNetMUryLmKJ3O+h+LRvGqSxEhYj6cUpwWdHSvf/XhxSlUAXfcXrvaNpxJK5+gmGRQDL8JdbxXYbnApyw86UXAnAh8z6+NkpeoOGDHpYBLIvfefwQYezi8zMGxPclLn9tyQZgndjQzlovgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=JMVm1WFp; arc=pass smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-902f92b8504so26989476d6.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783969340; cv=none;
        d=google.com; s=arc-20260327;
        b=JxRge/+XH5XUIb3SUIKG1FlB8ix1bhlw1XlzFzoSCMnOtVO4nPHIvbsIic5uwvqbRc
         69785/52Pcfx01bL+2HGi0sbI1extkDWZ0/JUJX67AAaafTFhbRQHADV4IHYgF+ng0DC
         EKJTVnr/poXhX7ayHcTpLH04faK0Ew57/DSLuOLQVwCFHOlh/yjEmDbf8jWo8GLrVzB+
         T90Aya2W5vpn7dxrdbj7k4axIvgEFp2i9YxeCIP8JeqrTe+vsmpcxVhH+yId/VSZXYnz
         5dLGAl5DoWTTOX1DOh84BFZJl+m0JEv5DBadCjkW/MYrGP0axYUASh+yWiyEI17du5TZ
         6cDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ND4QVlZryHNvw3JTPiSudd8z751cUXLs/D6Kbqr80w8=;
        fh=1WdjelLpGkkVgwdBOyv1JI2Es2iXNKl77AKy9a5yoKY=;
        b=LhAl1ZLUNpNH7REkNsE0nahF+gc6DLElSeJ8GeKMDQ8Yv1oFt7cVLq50hFHkZQAiBz
         I41uPASlzg1azX/uEFzgId1DmHcZS1CYYN34XfMzH2cPrsGktSMgpQipw0DSrax+zuce
         w+BcchhH7NlgVFC/8/jcC+bL9XWFnSsp01r6JR4aX8DmESXfxPan4eajrw1Xc/WV40lN
         5j5fuun59Sm3ORsH5mfjgm8oyub1tCpO8W06+5XsD59gzzPHvgxhonI9v20dEMnvH9M9
         r+75Rj+xYRjGRkICVDSuVoK34o/QkeKJQBlGzRhExChwW018YRIjntqf0KvAY1yHacLb
         /xmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783969340; x=1784574140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ND4QVlZryHNvw3JTPiSudd8z751cUXLs/D6Kbqr80w8=;
        b=JMVm1WFplqYsrXcPLs3AedRTScc0vYo7irVLJLwx7bJPljsuhiB4h9UYsNvfAsHr+b
         4tkw6+h5cJ6sQ6EjIWJFhqRoO4iwi2798JyZABNCWPsaODJp4x+QN7hxThCtkb8qf9Ea
         LLQB6XvtGzGzYrBVcTN7muBxPoQgKALcGeg2gIKV/7jFEzDcgkONjLIFMup6Q25A/zEi
         lzQXzcKBQRXpB4/wWU8uQbJwuKjzYZClkRD7qKgX90TT1YNVFG6knNUzAga7vL5hjcIm
         bSTlTffrAFfIUeqWqbyN78eN1D/V7mqsRl02l0Zox2fTkSfRjtH95P5sOGFqdwBJDKK0
         P0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969340; x=1784574140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ND4QVlZryHNvw3JTPiSudd8z751cUXLs/D6Kbqr80w8=;
        b=WpHz/wZeVy8N7GzNCaOtIo6VM5FxD//D9biFLHGTalD4sZ+IjY8AYWcL501+XLNoo3
         0sciJqVYzJjDoDn41gputAcoq2YeDVzY9XMw1e8G/2YA4vSPVEBXd8cJIHHK8atlL4r5
         gEFPLO5cXYcIxXAZUmUbUw1enzDZahupBQs+eB4l4nzZUSpQM3oEVRA0wMPSf6T3lKz6
         422rCTIHviXRx2vc1EWr4yVo6gJVfC0XSWseWCbeoWQ4QRWNa3S2Zsiae/glK4fZ8/0r
         30O8p+hUyvdjy1kZyyiX1lmoCJRHB1fj0+jRREJT6Bgy2QptO/XLGAwVEapijrFDL8wN
         JksQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3YX3xE9pvnzThjXbU96bv9BA8747xd6fpof+hgBnawEFfFto8JoNY+N2hCc8Ss4K1y+WaUt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySs83iM+/2xAOK3NfjnOaBIe1jG6Bew8aOvxhHyISu+qXWYxSv
	+j3IjFZvTph52Nqq/nAHCk9PdwDWVSuklfnKbK32JW4rbh1m7ifbdhwOqeULtIlQfloA24HoD6z
	OfhQyLlO1/2g+TsQmoksijrKuKpQbuUljFQ5rK6Vjkw==
X-Gm-Gg: AfdE7cnPqvh3UAQ+GL5+xEPkks4dQtadwzAaSJDzrFlHE4r7RM2h5hvBI6GXTQ1AAdH
	epRbip21XuoFz8OdSaOEy6TJGg0frNUSRfrTKFAU4BBvFsmm1xPQ+ekBWpgiPBz+IGMDPEguxjV
	FezlKgETk1rl/p6yYbPNqJ6ECU27XGfKGI8BVUGXu94QABS7oHJ4/1Bs4TY59N+LoBwDH2/PEW5
	k2WGoA42/LF7JEjidB0datkensxSiNSlm9KNS9S6NKpR30s87+wUFDVjxyYM5n17CPfyQL+
X-Received: by 2002:ad4:5f8d:0:b0:8fd:6de3:bba7 with SMTP id
 6a1803df08f44-904053d935dmr129372256d6.61.1783969339661; Mon, 13 Jul 2026
 12:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-2-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-2-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 13 Jul 2026 15:02:08 -0400
X-Gm-Features: AUfX_mxL4zz4204ui_yf_Z_RxH1muCe8ChhqbsvT5mXw7tis6KUbLq5ezLHCMTQ
Message-ID: <CABFh=a6kCQHztTXZpndBTRRo7FWAfZ1NtzZJm5a7qmY1gd_b4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/15] bpf: Remove __rcu tagging in st_link->map
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[etsalapatis.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[linux-lists@etsalapatis.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307265-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-lists@etsalapatis.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,etsalapatis-com.20251104.gappssmtp.com:dkim,etsalapatis.com:email,etsalapatis.com:from_mime,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7739774EA22

On Mon, Jul 6, 2026 at 2:59=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> st_link->map is always written under update_mutex. The paths that read
> st_link->map with rcu_read_lock() are not in the fast path, so they can
> simply take update_mutex instead. Remove the __rcu annotation and replace
> all RCU accessors with direct pointer reads under update_mutex. Use
> READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
> without holding update_mutex.
>
> It is a simplification change.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
>  kernel/bpf/bpf_struct_ops.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 51b16e5f5534..d06b3d9bcc13 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -57,7 +57,7 @@ struct bpf_struct_ops_map {
>
>  struct bpf_struct_ops_link {
>         struct bpf_link link;
> -       struct bpf_map __rcu *map;
> +       struct bpf_map *map;
>         wait_queue_head_t wait_hup;
>  };
>
> @@ -1257,8 +1257,7 @@ static void bpf_struct_ops_map_link_dealloc(struct =
bpf_link *link)
>         struct bpf_struct_ops_map *st_map;
>
>         st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> -       st_map =3D (struct bpf_struct_ops_map *)
> -               rcu_dereference_protected(st_link->map, true);
> +       st_map =3D (struct bpf_struct_ops_map *)st_link->map;
>         if (st_map) {
>                 st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, =
link);
>                 bpf_map_put(&st_map->map);
> @@ -1273,11 +1272,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(c=
onst struct bpf_link *link,
>         struct bpf_map *map;
>
>         st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> -       rcu_read_lock();
> -       map =3D rcu_dereference(st_link->map);
> +       mutex_lock(&update_mutex);
> +       map =3D st_link->map;
>         if (map)
>                 seq_printf(seq, "map_id:\t%d\n", map->id);
> -       rcu_read_unlock();
> +       mutex_unlock(&update_mutex);
>  }
>
>  static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link =
*link,
> @@ -1287,11 +1286,11 @@ static int bpf_struct_ops_map_link_fill_link_info=
(const struct bpf_link *link,
>         struct bpf_map *map;
>
>         st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> -       rcu_read_lock();
> -       map =3D rcu_dereference(st_link->map);
> +       mutex_lock(&update_mutex);
> +       map =3D st_link->map;
>         if (map)
>                 info->struct_ops.map_id =3D map->id;
> -       rcu_read_unlock();
> +       mutex_unlock(&update_mutex);
>         return 0;
>  }
>
> @@ -1314,7 +1313,7 @@ static int bpf_struct_ops_map_link_update(struct bp=
f_link *link, struct bpf_map
>
>         mutex_lock(&update_mutex);
>
> -       old_map =3D rcu_dereference_protected(st_link->map, lockdep_is_he=
ld(&update_mutex));
> +       old_map =3D st_link->map;
>         if (!old_map) {
>                 err =3D -ENOLINK;
>                 goto err_out;
> @@ -1336,7 +1335,7 @@ static int bpf_struct_ops_map_link_update(struct bp=
f_link *link, struct bpf_map
>                 goto err_out;
>
>         bpf_map_inc(new_map);
> -       rcu_assign_pointer(st_link->map, new_map);
> +       WRITE_ONCE(st_link->map, new_map);
>         bpf_map_put(old_map);
>
>  err_out:
> @@ -1353,7 +1352,7 @@ static int bpf_struct_ops_map_link_detach(struct bp=
f_link *link)
>
>         mutex_lock(&update_mutex);
>
> -       map =3D rcu_dereference_protected(st_link->map, lockdep_is_held(&=
update_mutex));
> +       map =3D st_link->map;
>         if (!map) {
>                 mutex_unlock(&update_mutex);
>                 return 0;
> @@ -1362,7 +1361,7 @@ static int bpf_struct_ops_map_link_detach(struct bp=
f_link *link)
>
>         st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>
> -       RCU_INIT_POINTER(st_link->map, NULL);
> +       WRITE_ONCE(st_link->map, NULL);
>         /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>          * bpf_map_inc() in bpf_struct_ops_map_link_update().
>          */
> @@ -1382,7 +1381,7 @@ static __poll_t bpf_struct_ops_map_link_poll(struct=
 file *file,
>
>         poll_wait(file, &st_link->wait_hup, pts);
>
> -       return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
> +       return READ_ONCE(st_link->map) ? 0 : EPOLLHUP;
>  }
>
>  static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
> @@ -1438,7 +1437,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr=
)
>                 link =3D NULL;
>                 goto err_out;
>         }
> -       RCU_INIT_POINTER(link->map, map);
> +       link->map =3D map;
>         mutex_unlock(&update_mutex);
>
>         return bpf_link_settle(&link_primer);
> --
> 2.52.0
>
>

