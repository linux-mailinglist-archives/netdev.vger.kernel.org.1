Return-Path: <netdev+bounces-14008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07173E5EC
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1221C2074E
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCD611CAC;
	Mon, 26 Jun 2023 17:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02538D506
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:00:25 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEA0E71
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:00:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262e81f6154so685251a91.2
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687798823; x=1690390823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqjSz8yZ6wDdkprghGJk37iQX8j9CwFY8v5AHtiiG6g=;
        b=t4Q7dZoaeJtL3uGRu+zlF/xQJ6WFzMxVbmsDIqP4yWxz063qfRmxo6E3w0jmXKJEW0
         Wf9JV1GoJNxGhFW55uyD5TvXFuI/PPXsbXBYG+TD0ejvbw1PN3dJsFyMYuAQ+ozOU6zU
         zu93mF+agp9/eYNzIFKUeS5oz+y8sSqWTyR/UhhNHGQcPE8tiD+RDjL+NZ/pfQ/xVNJZ
         Fq6xep2eD2EqLfA//6EnP2EIhN8oP6o30gNEvOCbrPbCx43cjk0/N4VkQEBpET0r5KMw
         M4Qhj7foFnKNdzj8gnXVJF4QhLaRasH4IMBYZ10/MVvCz+EuEAHKiUomOIPbo+Ouxa2P
         RKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798823; x=1690390823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqjSz8yZ6wDdkprghGJk37iQX8j9CwFY8v5AHtiiG6g=;
        b=ebxzn2/VSOcdKYz0sNlIuwEzMNuhN/trNwg+oaOjGJJyyNFUCcq9IWUldLqHrk79j9
         nR6Istf/2qICtS//0Vx/pAgCergvhXUbebpZa7OmIFVPPt952/MQyf41+v5PNAaPbzIy
         9Kkexvm1eSGRnx9Qh54SENjOf7SW24OwCJ8gNminCbkbdjI8U7q1+avuHFAVqr8x89F5
         OaOpfqni8rXinbIh6cFHnSAgMAZeOKnEvMM/6E7spT6yVlhIOy6V19lw2EFV6thQpk/v
         zXmF+zk/fOcok7u6t/WFWG7PswSWxcHtpJ9Law+rR+a8nUPu1I28xQMCRzELOSrPjy8S
         6b1g==
X-Gm-Message-State: AC+VfDwBjfFIAI5fMQCpNZIR2uipgROxdfYOSIaHvk0Fezy/ZubvrHDd
	JFQf/WWPmH8VWh1AZKg4WoaWZrZuPNMVWY8SAizagg==
X-Google-Smtp-Source: ACHHUZ6el0TiyKsqERqIs3vBXm+hqKeysm/fzKNcHYC56XTaGPgbw6477TOvW6FX3cS1ynV7OLje0sWfA/Cb+sXeVPA=
X-Received: by 2002:a17:90a:ab8a:b0:260:ea8f:613d with SMTP id
 n10-20020a17090aab8a00b00260ea8f613dmr11028729pjq.20.1687798822888; Mon, 26
 Jun 2023 10:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-7-sdf@google.com>
 <87edm1rc4m.fsf@intel.com>
In-Reply-To: <87edm1rc4m.fsf@intel.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 26 Jun 2023 10:00:11 -0700
Message-ID: <CAKH8qBt1GHnY2jVac--xymN-ch8iCDftiBckzp9wvTJ7k-3zAg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 06/11] net: veth: Implement devtx timestamp kfuncs
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 4:29=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > Have a software-based example for kfuncs to showcase how it
> > can be used in the real devices and to have something to
> > test against in the selftests.
> >
> > Both path (skb & xdp) are covered. Only the skb path is really
> > tested though.
> >
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> Not really related to this patch, but to how it would work with
> different drivers/hardware.
>
> In some of our hardware (the ones handled by igc/igb, for example), the
> timestamp notification comes some time after the transmit completion
> event.
>
> From what I could gather, the idea would be for the driver to "hold" the
> completion until the timestamp is ready and then signal the completion
> of the frame. Is that right?

Yeah, that might be the option. Do you think it could work?

