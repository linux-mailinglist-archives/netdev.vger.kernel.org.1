Return-Path: <netdev+bounces-29905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BC7851CA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6835D281094
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07386A923;
	Wed, 23 Aug 2023 07:39:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A3A922
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:39:16 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47F10D0;
	Wed, 23 Aug 2023 00:38:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so83357211fa.3;
        Wed, 23 Aug 2023 00:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692776318; x=1693381118;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X93G4juBaauyVG2kaKgcKVH7sFLyXLSIrqncTBPbMm8=;
        b=MLFKTL/Lu/ep0RXtA1mXz3rTSnwhHLJllV1OR6x3kblt6ivPJmyHwMp80XrgtbY8h1
         ZhnQqBXDrTxjnYIBp359Oxfe16ufXxq/pJwNlV6imoWIUf4kGWZrsU3rrlOdaChZXYxJ
         BnoNvw8mKuSP7la+s2qKqwBlgUh1hCr1HnUef1uqndAWgFUEANKZ0NT3z6qMea8AdbhA
         oLZNAaYryxqrglVkZMIXJJ9ilaOvfmt8ZiS7aYLcK/4Z83wsy2dRRnIlh/U9/N+4+Axw
         L3B5INBu1aerD01ReVsz8c4sQV1GH5SW4MmhMl6qsVi/d2wgdTKApTeNYgjSFnjx5gYU
         xjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692776318; x=1693381118;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X93G4juBaauyVG2kaKgcKVH7sFLyXLSIrqncTBPbMm8=;
        b=Pwb2bYQUwb3dcvsZ9JMYLlSCb980iZgCawnG5qrA9X9+tDMCIwEC2YgiiVxXl9ZYnE
         xQVE3J295PFaVLZiFH4UJLJULMnM+u0REki2eYKrfgXLLicdv8ID+zUgfXo7UJGGqbEk
         a9zs14mhRk74cFG2MVvrWkB+lA58YChRQxGIkb9LMemiyYJeb1kHmfvatwi0dQ76VGm0
         GJ2SiV5MCS0h9cjn1luipq83LudDp+z4Et2JKPOLxsoRXp5rfm2J6FjnA52FYcQesEnm
         T329JfS8kjTLNe/0M6rYLOeZ4LP9jBiOPO4V5RJlpUCnKwNUe04SFBYVaEAL+foLohnH
         pGwg==
X-Gm-Message-State: AOJu0Yz5EbChzAI769B+lcCU4aBVrnM0TJYvgYxHwbgUnwnfFoKBGusY
	c36IIxD/82G4HkA5KRnUQEQ=
X-Google-Smtp-Source: AGHT+IHDQgIB3D41uwK6kbMsEJIAZTOA1ymV0XNGh9s5VUnZT2ABk6iGLMbj7x/aKp0NMchsurhf4g==
X-Received: by 2002:a2e:2404:0:b0:2bc:dcdb:b5dc with SMTP id k4-20020a2e2404000000b002bcdcdbb5dcmr668185ljk.39.1692776318221;
        Wed, 23 Aug 2023 00:38:38 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e4cf:1132:7b40:4262])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c280900b003fe539b83f2sm21436983wmb.42.2023.08.23.00.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:38:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Jonathan Corbet <corbet@lwn.net>,
  linux-doc@vger.kernel.org,  Stanislav Fomichev <sdf@google.com>,
  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 11/12] doc/netlink: Add spec for rt link
 messages
In-Reply-To: <20230822194304.87488-12-donald.hunter@gmail.com> (Donald
	Hunter's message of "Tue, 22 Aug 2023 20:43:03 +0100")
Date: Wed, 23 Aug 2023 08:33:53 +0100
Message-ID: <m2r0nugqla.fsf@gmail.com>
References: <20230822194304.87488-1-donald.hunter@gmail.com>
	<20230822194304.87488-12-donald.hunter@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Donald Hunter <donald.hunter@gmail.com> writes:
>
> +operations:
> +  enum-model: directional
> +  list:
> +    -
> +      name: newlink
> +      doc: Create a new link.
> +      attribute-set: link-attrs
> +      fixed-header: ifinfomsg
> +      do:
> +        request:
> +          value: 16
> +          attributes:
> +            - ifi-index
> +    -
> +      name: dellink
> +      doc: Delete an existing link.
> +      attribute-set: link-attrs
> +      fixed-header: ifinfomsg
> +      do:
> +        request:
> +          value: 16
> +          attributes:
> +            - ifi-index
> +    -
> +      name: getlink
> +      doc: Get / dump information about a link.
> +      attribute-set: link-attrs
> +      fixed-header: ifinfomsg
> +      do:
> +        request:
> +          value: 18
> +          attributes:
> +            - ifi-index
> +        reply:
> +          value: 16
> +          attributes:
> +            - ifi-index
> +    -
> +      name: setlink
> +      doc: Set information about a link.
> +      value: 19
> +      attribute-set: link-attrs
> +      fixed-header: ifinfomsg
> +      do:
> +        request:
> +          attributes:
> +            - ifname
> +    -
> +      name: getstats
> +      doc: Get / dump link stats.
> +      attribute-set: stats-attrs
> +      fixed-header: if_stats_msg
> +      dump:
> +        request:
> +          value: 94
> +          attributes:
> +            - ifindex
> +        reply:
> +          value: 92

The operations are missing detailed attribute lists. I'll fix in a v4.

> +mcast-groups:
> +  list:
> +    -
> +      name: rtnlgrp-link
> +      value: 1

