Return-Path: <netdev+bounces-14566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2E67426B8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8EC1C20A6E
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562B23D0;
	Thu, 29 Jun 2023 12:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BA23C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:49:57 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A526B6;
	Thu, 29 Jun 2023 05:49:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992acf67388so67723166b.1;
        Thu, 29 Jun 2023 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688042995; x=1690634995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1TREtoMSvk1yEBKKL2MbvxOq+n+nP9UwK4FxXL6vHw=;
        b=ZbWkN/j0q4MJWIdlIlMXcUd7O4PEPSH84ODON/bqgkHXUz8uALz90YnWUJKBFSe6QO
         jA9bLGdvu+9OH3PkRTjrMtBJt1UJxOpUuJt7PYjwvsjUFsDZGt8quweKb//0x48iaJIg
         1k2Ekx6BnJ23Vxk1vQoQpNq9zgpyIVHgzlSIuGfAzt5TnPFfNJzXkfTdXsCpR9WAiUB4
         DYdHfCSqe8r3bzCAE6j05GXJP6cgvnZYOOxXyPWUpZQtwMxYizAGDnN1akUkVDxltF9p
         jqrqEBA8qWE5ZsdcxjNEWA1LDWJyon9EMVI1A6iXcN1iq7ipVxNk89sHcGbvVszsQl/+
         47Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042995; x=1690634995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1TREtoMSvk1yEBKKL2MbvxOq+n+nP9UwK4FxXL6vHw=;
        b=eFwbJmfwPhux35A9YMVpMSaVGrkVwqDbF/v/vJfftN65EunjlagneQlumxogbXjEon
         QgEn45TrakXui88+WTP9y1+AyB6q9/SzawRnU9yYSg8C5+L0s+/F/OE/mpMXkPe2/Af8
         4WKBmqRCvvp43lhff7vUS4GA0yxnT+ku0ByeDOkSlt7WRNXRWUoP/Rqq/cK7fEC+g0Y6
         +4DErKDhmWvhCKvoG+gs1ePMnrYsoGpaVFPheLhRWfkXgMcXGLq9lbf/rIYLCzBXu9aO
         AVVOdnCADHurBBpW+15E4ZvZX+GYzcXnNnAEq0Ygto4GGyhxAO7qV0fl5zpqPKW9Fa74
         /6oA==
X-Gm-Message-State: AC+VfDwzcQLtOrVXMvj8QlGAA9YgoDKZONlrFxcZyGUa3TBoTmTEdt1W
	0v5RvpsoN0bi5R+ttPC6J6E=
X-Google-Smtp-Source: ACHHUZ5Nvi0Qi5FeV6MebItJV806wM+6jK5uICq2iiUdkLtjqpBg+NmgWTga9YVEwg92Qh+PY9Voeg==
X-Received: by 2002:a17:907:a42:b0:96a:48ed:5333 with SMTP id be2-20020a1709070a4200b0096a48ed5333mr30562917ejc.50.1688042994711;
        Thu, 29 Jun 2023 05:49:54 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id k12-20020a1709063e0c00b0098e2eaec394sm5735089eji.101.2023.06.29.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:49:54 -0700 (PDT)
Date: Thu, 29 Jun 2023 15:49:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH RFC] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Message-ID: <20230629124952.neteb2mcirduz4h7@skbuf>
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230625115803.6xykp4wiqqdwwzv4@skbuf>
 <6499c31c.df0a0220.e2acb.5549@mx.google.com>
 <20230626173056.zq77nilzrr5djns5@skbuf>
 <6499d3f5.050a0220.3becf.7296@mx.google.com>
 <20230627094916.maywojwztzdek5y2@skbuf>
 <649c3931.df0a0220.136ab.2fb7@mx.google.com>
 <649c39fe.050a0220.633cf.c865@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <649c39fe.050a0220.633cf.c865@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 02:53:35AM +0200, Christian Marangi wrote:
> Also sorry for the double email... I forgot to add that it seems I need
> to add a sleep 1 right after 
> 
> 	mc_route_prepare $h1
> 	mc_route_prepare $rcv_if_name
> 
> in local_termination.sh. Think the switch needs some time to enable all
> the port. Without the sleep 1 the first test just fails.

This makes sense. Those multicast MAC addresses are synced to DSA
through dsa_slave_set_rx_mode() -> dsa_slave_sync_mc(). Notice that the
calling context is atomic, so the implementation sets up a deferred work
item for later. So user space is allowed to return from the syscall
before the hardware is actually reprogrammed.

