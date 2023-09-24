Return-Path: <netdev+bounces-36046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19667ACAAA
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 18:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 4092D1F23148
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4694FD50E;
	Sun, 24 Sep 2023 16:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB45D279
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 16:01:01 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA81F1;
	Sun, 24 Sep 2023 09:01:00 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so1497118241.1;
        Sun, 24 Sep 2023 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695571259; x=1696176059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am3voQeukfK3Fa9MI7o7NoFaSzEtIQEuGq0/yQAOzzo=;
        b=j0cBx221dklxEpvyAdea59Vq2cfq1eKLjxSeyhFQETNUJhmhXPkj1DJycFJJxicGJb
         8BH86pogCeSxYzR5+2Wr2oa0IEjSEAJNZiAVUO+/oJKIiTogqtjfQAiPF/Sx4tiPQlyB
         FLm46/q+EsJoPcBzR3sJTNtoLffc9g3VVpitt9oeH07RW4fShvHr/N4eKqZIFvxtif49
         IxlxBOlPsYgKl0Kk0jlkhHGQjBE4y/xBea8mI4RPQ9fhzJl0mRIeqW5CvzgocFq8X639
         ZSwJBNKaYoazFXzK4aKzu9Fkqj8W/b0Gm29wXp6k4DK19iww86yxXymxwhBDettiwLKT
         G+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695571259; x=1696176059;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=am3voQeukfK3Fa9MI7o7NoFaSzEtIQEuGq0/yQAOzzo=;
        b=WnIpllFskmAxvDTRGgpZMSaM6TP251k+o/ujW/fcvJQ5H+YyyKiA3LRk5ZTb9f/CbT
         SaLgZ/gtAoOLSXl8kppaNcv18C6sXq4MTXchy8t8XHlS+tg7xtu2LL0CDwPjRYYqAzfW
         RHKcJfSCw+Y7bJdY21y6pNr4aHxLaczOc5QbPQBL00/GcdLbuWTpPRVWiPQLgARAepKL
         6zVM+FXG05Cfq5i7R3m1/tPBXUnomcpCc0DtNcEeDuRO9pmtVi+HEnyb0NGI+pFSdn0E
         YLPcyDdlC7e2iW4baoGovMykDvPDDcsHpzmZ3+InbWUNwRc5mx+87PxdKW/nVl2ho94H
         JU/w==
X-Gm-Message-State: AOJu0Yxm+eILDYV9abtfbiyTXc4pL+2hzusU1G2MScPxE4Aeb3hsUMbI
	cLqxs+wudHKeg51YoFVJ+Qc=
X-Google-Smtp-Source: AGHT+IFt8v6Fy7hiLfyklLf9mVM0sH6wNHKf6sJ49B+sz6r/itsik2Tbe9+p8BTWMtxvHePpqipvRw==
X-Received: by 2002:a1f:cb03:0:b0:495:dc43:7440 with SMTP id b3-20020a1fcb03000000b00495dc437440mr1457729vkg.9.1695571259574;
        Sun, 24 Sep 2023 09:00:59 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id s7-20020ac85287000000b004108d49f391sm1270041qtn.48.2023.09.24.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 09:00:58 -0700 (PDT)
Date: Sun, 24 Sep 2023 12:00:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 netdev@vger.kernel.org
Message-ID: <65105d3a8e70e_12c73e29410@willemb.c.googlers.com.notmuch>
In-Reply-To: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
References: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next] udp_tunnel: Use flex array to simplify code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christophe JAILLET wrote:
> 'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES	= 4 as a maximum. So there
> is no real point to allocate the 'entries' pointers array with a dedicate
> memory allocation.
> 
> Using a flexible array for struct udp_tunnel_nic->entries avoids the
> overhead of an additional memory allocation.
> 
> This also saves an indirection when the array is accessed.
> 
> Finally, __counted_by() can be used for run-time bounds checking if
> configured and supported by the compiler.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  net/ipv4/udp_tunnel_nic.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 029219749785..b6d2d16189c0 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -47,7 +47,7 @@ struct udp_tunnel_nic {
>  
>  	unsigned int n_tables;
>  	unsigned long missed;
> -	struct udp_tunnel_nic_table_entry **entries;
> +	struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_tables);
>  };
>  
>  /* We ensure all work structs are done using driver state, but not the code.
> @@ -725,16 +725,12 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
>  	struct udp_tunnel_nic *utn;
>  	unsigned int i;
>  
> -	utn = kzalloc(sizeof(*utn), GFP_KERNEL);
> +	utn = kzalloc(struct_size(utn, entries, n_tables), GFP_KERNEL);
>  	if (!utn)
>  		return NULL;
>  	utn->n_tables = n_tables;

Should utn->n_tables be initialized before first use of
struct_size(utn, entries, n_tables)?

