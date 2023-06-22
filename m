Return-Path: <netdev+bounces-13149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B172273A7CE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAAD281A48
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301220699;
	Thu, 22 Jun 2023 17:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB3200C7
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:55:35 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EBB1FE7
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:55:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-553a998bca3so4191660a12.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456533; x=1690048533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv7NlJfJhJSvHtOnzF0Vw0AvAYP8oSd8rqwNEKRHDJQ=;
        b=y3aeYLTTAtFq7eOyfvpRn0uncmtH9t7hY7Pp5UG0oRzmiS0tk9TINsyxY2a7yMjs4U
         VGQiWVKv3gmW/a+hb4B09yZ+XbFNFPNwUx6qzw+Ny4ouYwvZH6NDJhjxzdFuU06w/AYP
         bhx2eVKJppZ4KFCKM9LLPc9U84Hoe5HeXj5AECft9MlX5cm3JsG7TMAyenTtHBznFxA6
         kdfKeSTqmdJtCGComcs/k3ah1F+BkXECdNDNmlbohTMI7WrbfKBZHBlHpHpmEfwAzhgx
         eUdYMG1Q1pnvhlSO4pupQCUd2r76mDV+AkDChZIBWTfdHMC7RumTwl+mInKH5IlphdaY
         btLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456533; x=1690048533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv7NlJfJhJSvHtOnzF0Vw0AvAYP8oSd8rqwNEKRHDJQ=;
        b=C6/X0uKsf8jQMoBeJYQMyGKt7cp68tHjGKrk5LefkdBNebXCKImQQdBVnsAosUL98f
         FBDYXbncH7N+2HwBeUEySb7Hg3DumgHtq3Jbt786Gud+lUyewGppFQxfVebOGVeEYH3G
         SGBRBbEWkLbDlwj2NIihXhC1amUjLGssHwdpyJyfwjkfC4K/5pY11tt6/977jdwTJ50g
         1se/bEVPYrzHq5WAoQKuY97622pSEjnMkYYH2698aCsuqeJ6fvkGO0Nas/0hc76C5rFp
         PpeUX5addZ+6E/a5EVeqggecNPHLre6HmCnP35KxrCWj20c4wv+gJsis8KIJ2fxdPUfS
         1rhA==
X-Gm-Message-State: AC+VfDzWMX2DCE2irA/ntoqZeJyL/1w6c9/S/t/uowOegeqhJsEmt5gf
	lIUnSRFj9T09OBAmSKo/edNZb4aihdYO4iZjhMqtmQ==
X-Google-Smtp-Source: ACHHUZ5QIwVB5YCGccw2HBwN2qrXi2UYIkc6hSX23YS76M/7HZEdu4t/xFsxQHLbFSVYVJkts9IOTTiAdGVFxWgJrsg=
X-Received: by 2002:a17:90a:9ae:b0:25e:a643:adeb with SMTP id
 43-20020a17090a09ae00b0025ea643adebmr18044669pjo.39.1687456533344; Thu, 22
 Jun 2023 10:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <e53ffd61-4b2d-4acd-7368-8df891aa0027@redhat.com>
In-Reply-To: <e53ffd61-4b2d-4acd-7368-8df891aa0027@redhat.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 10:55:22 -0700
Message-ID: <CAKH8qBtJ+8LQ+J67ybxXg23NRqpNr4sCx=hA4CuV0d5hiAQPyw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 00/11] bpf: Netdev TX metadata
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, netdev@vger.kernel.org, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 1:41=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > CC'ing people only on the cover letter. Hopefully can find the rest via
> > lore.
>
> Could you please Cc me on all the patches, please.
> (also please use hawk@kernel.org instead of my RH addr)
>
> Also consider Cc'ing xdp-hints@xdp-project.net as we have end-users and
> NIC engineers that can bring value to this conversation.

Definitely! Didn't want to spam people too much (assuming they mostly
use the lore for reading).

