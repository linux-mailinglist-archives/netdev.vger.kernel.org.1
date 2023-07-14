Return-Path: <netdev+bounces-17772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A0753042
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F632802A8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6646AB;
	Fri, 14 Jul 2023 03:59:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EE46A0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:59:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D44126B7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689307140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0IXrRel0Jf5sI6yYnB7ussn8KJNTKMqE2zSLssKxOs=;
	b=ddcyXoitP7tXQ0P6AR9Kutjwt7zLz6VFa4jvDbDT9heWVmWw9i6hydBHek+RozusxKJobh
	wuH5PCtqvOvuT0GaOCxeO6WcR7TQsw4K/aJ1cNkweC8O2MSikowwNXgGTzjjXQ8IcOLEUX
	yb/mEOmgC0m0ZJTdQLuM0wupYq1w4uM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-kMEWGF8OOUSNKsaM1eQbMg-1; Thu, 13 Jul 2023 23:58:58 -0400
X-MC-Unique: kMEWGF8OOUSNKsaM1eQbMg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b69825cca2so14511681fa.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307137; x=1691899137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0IXrRel0Jf5sI6yYnB7ussn8KJNTKMqE2zSLssKxOs=;
        b=fuTBYPGnft69MRIlxUZX7la8PuuFkfoJQ4ZjF6WHKDH17yhE/42C3F3rgTEXFjxusC
         5xV96FiFNdOvZQ/Vj9m6Oul5N41UkSAcFC9A/O6xh6FRgwzKNSNPpfUkWBO8ZJ2rlJPX
         YL+LVpYygJxYFBa8GBS9hH+r9d/PmsbDaTgJEk8XP4ShFDCOTelwavV57acx1aJKSq6j
         52kBRB5YNxN7CzXh+UAwT0ocjyR8ISl5qZE1CDbdTkn+pN6Wu8k+IyZzMONsAvHZiYxq
         cPIrfkJiVHZzrja01nzB9C7mh71ydaUhjy9MHKz1lu7HO8mS1v3rTrs7FZyVgrkfAwpg
         C36w==
X-Gm-Message-State: ABy/qLYVfwqb9b+WnaJW4d9QW+aB5z1ot5mbXwhIuv2vdKB3riS0k0BC
	gX6ECn7P6qK8sOSrblKotr1ORDwkdM/RBKSBJebKyCPU07+8UG1OdH9BuMDGGDtpIEkuKhQ3Q6E
	P+Anr6XBeY650FM1EBN7RPBIMknF8kHTz
X-Received: by 2002:a2e:2c11:0:b0:2b4:8446:82a9 with SMTP id s17-20020a2e2c11000000b002b4844682a9mr541691ljs.17.1689307137502;
        Thu, 13 Jul 2023 20:58:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHM/PKtNMaPwkVCmNF7IN6cguTIWBujbOGf1vp5W5x6EOmDtNkZ8J0NSeeeKGnFbM4DzMfzYz0QkyDhMOKB7zc=
X-Received: by 2002:a2e:2c11:0:b0:2b4:8446:82a9 with SMTP id
 s17-20020a2e2c11000000b002b4844682a9mr541689ljs.17.1689307137231; Thu, 13 Jul
 2023 20:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZLA0ILTAZsIzxR6c@debian.debian>
In-Reply-To: <ZLA0ILTAZsIzxR6c@debian.debian>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Jul 2023 11:58:46 +0800
Message-ID: <CACGkMEvq8h_yYhxBWD4oPBBwE8xzDMt7VqbW4wz+oqjfYbiQfQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
To: Yan Zhai <yan@cloudflare.com>
Cc: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Melnychenko <andrew@daynix.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 1:28=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation:
>
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28K=
zYDg+A@mail.gmail.com/
>
> This change restores the expected behavior of GSO_UDP_L4 packets.
>
> Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packet=
s.")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> ---
> v2: dropped modifications to tcp/sctp on DODGY bit removal after
> validating gso_segs. Also moved the UDP header check into
> __udp_gso_segment (per Willem's suggestion).
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


