Return-Path: <netdev+bounces-26544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9BF7780E4
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2721C20D6B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9721D3E;
	Thu, 10 Aug 2023 18:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D598200A4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:58:39 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075072696
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:58:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76c93abeb83so92338085a.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691693917; x=1692298717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsyCys9Hf/cc75Fnr2tkebJ8N3paAQId+bMwmSwTxOY=;
        b=g7OHqXPvz9lvXEVQRoNwlIAWD3U3BVaszpP9c4VQfzVew2oR11nq/PKW4heanyaoI/
         6U1ByG/45vFJbE5DUQK46T0mZDn420p1KqetFU1Z18z/8O5hDYyqEsV4csvPtuJ2bet6
         1RxzlwHsoV2+r3lXpMpY6ykdbSzAT6VjZ+V5X6VkUFV99iOC2KYVAIoeBEBlG3YVzTQz
         vS4gAb3eK7oGEslty93LfhmwSi/0ADON52kge07ftO7YW0FKmIbCJA8WiZ1fMmfSqNHf
         VI/hzMwm7iLFsjCcH0TZhUWnPdUw27o0Osbe3rMLkjrT06iA2SeB0AEsvvsggfsmS6gI
         MZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693917; x=1692298717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsyCys9Hf/cc75Fnr2tkebJ8N3paAQId+bMwmSwTxOY=;
        b=JMK+brXrSQ06qH/E7YWiBxfqLGsP7vu6fQLEIBBbTz6xhdflXVL9OA9x34k8D+HlxJ
         YkSUj4xBLFJi9b6hX5/tzSNVB3vRXbsCVBWmqCnYb6asVxZCKWtURePK42jIoFEf7Pvh
         6m0u61O/0My0Vo29MegOckJWA2/WNwycVJooXwAfELv2IAMUdyY4gCfqYo9EYmHKC7XN
         pYCKOq3ENTyI0+/PG10/Bosjij0kqJDUHdw05FFUpsHELgNxkk7gF5A8pQnnIzWHvmwi
         OjYWh5GQJxncWThr6yIKmDc5jQaCbItijTi9nMxnCSOMc2eOkdNBthXOfOd7ZNnYZE3m
         vncQ==
X-Gm-Message-State: AOJu0YyVQXqq0rx4Di2aIwNDSf1M4TBMvvxnGjrvgY2I2RRBP2qT15HR
	46nOJgecD73l75eEs8SPWBTu4g==
X-Google-Smtp-Source: AGHT+IG2wYwwESDSTMeata50KjIGSTDd5oFZ54ICUMsQbCPWTAM07sDaAobSCA1IWHJxW0hVcjfxmQ==
X-Received: by 2002:a05:620a:4148:b0:76c:bc4b:92b9 with SMTP id k8-20020a05620a414800b0076cbc4b92b9mr3903660qko.11.1691693917177;
        Thu, 10 Aug 2023 11:58:37 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a14a800b0076cc0a6e127sm677945qkj.116.2023.08.10.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:58:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUArj-005Ifq-Qt;
	Thu, 10 Aug 2023 15:58:35 -0300
Date: Thu, 10 Aug 2023 15:58:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	netdev@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Hari Ramakrishnan <rharix@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org,
	sdf@google.com
Subject: Re: [RFC PATCH v2 00/11] Device Memory TCP
Message-ID: <ZNUzW3X3P0JvL4nI@ziepe.ca>
References: <20230810015751.3297321-1-almasrymina@google.com>
 <1009bd5b-d577-ca7b-8eff-192ee89ad67d@amd.com>
 <CAHS8izPrOcrJpE1ysCM7rwHhBMPvj0vQwzfOyVqdxsVux8oMww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izPrOcrJpE1ysCM7rwHhBMPvj0vQwzfOyVqdxsVux8oMww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:44:53AM -0700, Mina Almasry wrote:

> Someone will correct me if I'm wrong but I'm not sure netlink itself
> will do (sufficient) access control. However I meant for the netlink
> API to bind dma-bufs to be a CAP_NET_ADMIN API, and I forgot to add
> this check in this proof-of-concept, sorry. I'll add a CAP_NET_ADMIN
> check in netdev_bind_dmabuf_to_queue() in the next iteration.

Can some other process that does not have the netlink fd manage to
recv packets that were stored into the dmabuf?

Jason

