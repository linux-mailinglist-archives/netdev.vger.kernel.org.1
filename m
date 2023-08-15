Return-Path: <netdev+bounces-27770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD077D251
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CB2281618
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538418036;
	Tue, 15 Aug 2023 18:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F818033
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:47:06 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638822128
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:46:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589b0bbc290so70099527b3.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692125121; x=1692729921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsrt+PiL4OQc0w1r/MsATpuKl0Y9Xd4SH/F6ewa1T0=;
        b=wOHiabJ3LIjpyxB2X6yAyPHihKHcNswhrpvCAshbITrgQdyf6aIoXFaeVB/zSoF13c
         +m1IDVEacvIj+aUE4Lx6Uzt5k6YZyMvxLPaMPndnVt4JjiCvroIkj4P/xJbxS0/JSf8V
         r9rWP68iL/mut2PtyXQpOJEiAnHVkKqz7F16sqYKnrSf78FePZmVVlqFaCjglCDKMSql
         bpI7wMYIEOBnBfzDYhMzf04KD+MkNpbEthnAM5Zqw+nT0jT1rVcw5bvV9fzC55BPJBRv
         0DZTc4nfRAi2y7iSLdamXLTXct7Rul2Nos4WBmbskP525McvHE+pRCWlJQ90Scni3l/n
         Y2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125121; x=1692729921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsrt+PiL4OQc0w1r/MsATpuKl0Y9Xd4SH/F6ewa1T0=;
        b=iau8xsN1wSfIUKbbDQEWKbcjgscsLhECZwuEFVw0qQ+1rZQjNf810ChbgieVDpfa0d
         52elDEJi7j2np6QsgrkKosqLQWMl8oH16e1bF7Ut/NqXoWOszmAObZgFX8GMSqxN9yOr
         T8wodx1Y1edb6ZS/eYwwG/EjZ7ct8vUtY6cJ4PbiLV0QfQ3WubNokEzUJdFuPhoV2gpN
         qIJSUTjAruLYssgRld4NcjMSn1bzL6FWepZhcoMpIg89fUHxzvW3ApGOLvYVwrHIB/bm
         pbua2nl754rtvtx0gZhyBS4+ubzOlgGH7NRA00ndltxHF0vMii4Jw5WNn83IlXcY0gPU
         SPLg==
X-Gm-Message-State: AOJu0YywivHG3bkEkUS8WHqJ9LSd0eTK+qmXpLNoxbLNeIAc3VrqWJlg
	RDOnxy4xEPRKIcXYkfndpiurB7A=
X-Google-Smtp-Source: AGHT+IEN2PBkoVD4NuRRK7kxDy/cn4+sZxakXZjjyJjZcxuiKUbPx2OfkpmxItG0ClceYq0bvL9nqow=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4413:0:b0:583:5039:d4a0 with SMTP id
 r19-20020a814413000000b005835039d4a0mr35594ywa.0.1692125121273; Tue, 15 Aug
 2023 11:45:21 -0700 (PDT)
Date: Tue, 15 Aug 2023 11:45:19 -0700
In-Reply-To: <20230811161509.19722-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
Message-ID: <ZNvHv7TZjGRjVOSG@google.com>
Subject: Re: [PATCH bpf-next v5 00/21] XDP metadata via kfuncs for ice
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/11, Larysa Zaremba wrote:
> This series introduces XDP hints via kfuncs [0] to the ice driver.
> 
> Series brings the following existing hints to the ice driver:
>  - HW timestamp
>  - RX hash with type
> 
> Series also introduces new hints and adds their implementation
> to ice and veth:
>  - VLAN tag with protocol
>  - Checksum status
> 
> The data above can now be accessed by XDP and userspace (AF_XDP) programs.
> They can also be checked with xdp_metadata test and xdp_hw_metadata program.
> 
> [0] https://patchwork.kernel.org/project/netdevbpf/cover/20230119221536.3349901-1-sdf@google.com/
> 
> v4:
> https://lore.kernel.org/bpf/20230728173923.1318596-1-larysa.zaremba@intel.com/
> v3:
> https://lore.kernel.org/bpf/20230719183734.21681-1-larysa.zaremba@intel.com/
> v2:
> https://lore.kernel.org/bpf/20230703181226.19380-1-larysa.zaremba@intel.com/
> v1:
> https://lore.kernel.org/all/20230512152607.992209-1-larysa.zaremba@intel.com/
> 
> Changes since v4:
> - Drop the concept of partial checksum from the hint design
> - Drop the concept of checksum level from the hint design

For the non-ice patches:

Acked-by: Stanislav Fomichev <sdf@google.com>

(I've added a bunch of acked-by to the previous iterations but I don't
see them carried here)

