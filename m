Return-Path: <netdev+bounces-26529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27277801B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CDB1C20FEE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0576C22EF1;
	Thu, 10 Aug 2023 18:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC842150C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:18:02 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D478A1703
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:18:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586c59cd582so15434297b3.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691691481; x=1692296281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5FxDrQGRNHVD4XGJGx3cDrnzdGTl5fZ/cPir9/nLmg=;
        b=tzKTK8wujY5vlAUhpIKqFluuqQNBtLCObAzmYy7wkvEzDXw57KtchezEgOPKoEV/QR
         474nQekQzCeKq3X3foz50mRGW/7K/faaQOdUHHTHPTQuni0otK/L9Za6WB87Xu3qhRBx
         xRfHyUHDTmPaSBUSjcKKCEtNTvE/eMHHIwzpiGuRFLNWbIkxEDCknoAH4+haRmShe8Rp
         uUf6tEOppqWC2MKNT53xABNJEder676zseyISTuNR1KAxjQ8t3FPEZHFIRnN1YLlcivs
         p+e3K1YxuB1JHjiHfns513BNmJyaZt6WRrN6LJ6XnxDJUZh6N6tlIN2YNdu3h2l0P1WA
         bTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691481; x=1692296281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5FxDrQGRNHVD4XGJGx3cDrnzdGTl5fZ/cPir9/nLmg=;
        b=MoSm6aGLNZC+dl0dyRaKEBivXaiMJ0yVZz/Nyje8P2A6myRAfP9OojnlJ4rpuctj5C
         OMlrtQ9sD+AzYqDPHkZjYzwAi9yhilzpYuaSlL2APwg3sKAy/4zeefoIXfMJEpxI1jZK
         vxMzdCvMxLI3Cd4tIjO6JdSifP0HA1RzOg1Atli6ZLzTx4N2NB2U4Y148yuH4yiJnqPy
         aIE3QwQNANXlBd+sotL6H4u+JeNXJ+4Eqw/gP40M9+b9FGpngc79pjMc8Bw3XzuIYkg5
         cPEuhvUXfqaccuobFCq/jdlsdhxxb88QhWeLJluLbzwFOC6gkVa/1Pp6FApTY3RCMm6H
         4vdg==
X-Gm-Message-State: AOJu0YyPRNfgC0v3Tyd9EpOuGSJ6n3JmYJw4u4PwF47xp96Pym1wkjAt
	xKgipgxsYPy94+pLTv/nWRGrrr8=
X-Google-Smtp-Source: AGHT+IEdQ3gmAyi/Pl8ZKEmGkf7fUIz4KEEUpVgm7kYgDYhbgPXA/td2quoofSpHYyQ3IHicqvevuQw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b609:0:b0:583:591d:3d6c with SMTP id
 u9-20020a81b609000000b00583591d3d6cmr55830ywh.0.1691691480988; Thu, 10 Aug
 2023 11:18:00 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:17:59 -0700
In-Reply-To: <54dc8831-a001-c17d-7b7e-ab1337c7f75c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com> <20230809165418.2831456-10-sdf@google.com>
 <54dc8831-a001-c17d-7b7e-ab1337c7f75c@kernel.org>
Message-ID: <ZNUp18O6CqxegAog@google.com>
Subject: Re: [xdp-hints] [PATCH bpf-next 9/9] xsk: document
 XDP_TX_METADATA_LEN layout
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/09, Jesper Dangaard Brouer wrote:
> 
> On 09/08/2023 18.54, Stanislav Fomichev wrote:
> > +Example
> > +=======
> > +
> > +See ``tools/testing/selftests/bpf/xdp_hw_metadata.c`` for an example
> > +program that handles TX metadata. Also see https://github.com/fomichev/xskgen
> > +for a more bare-bones example.
> 
> Will you consider maintaining this AF_XDP example here:
>  https://github.com/xdp-project/bpf-examples
> 
> E..g. the kernels old samples/bpf/xdpsock program moved here:
>  https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

Sure, I can put it wherever. Didn't want to put into the kernel tree..
 
> --Jesper
> p.s. Compile fail for fomichev/xskgen on my system

What is it complaining about? It's very ad-hoc, doesn't user proper
libxsk and has super simple hard-coded make rules :-)

