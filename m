Return-Path: <netdev+bounces-31519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13678E7E3
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5461C2097C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6BF6FCE;
	Thu, 31 Aug 2023 08:25:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4FC33D7
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:25:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC555185
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693470353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYjlS8xYetQB65Gj9ZtBHGyY7Wxd5IHokOyjYA/2UXc=;
	b=Gey5HM2EsR3L6kmt+NxN3fRD8bfPRptaSrV3WSHyBCjY0o1McXPfsxUGL9PCzjw8Hyr6zk
	StooNQ4r5tJ8rfCn4QSl9CHtH1avdQO4ZrxNm5Ue7KPLct7O8FrA1RgeHH/fU2cMMryt2P
	KRP/4+0SeF6mg6fNuaEJk2OjXnyP7U4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-PeWnxU-uNXyd4XmDHsMVkQ-1; Thu, 31 Aug 2023 04:25:51 -0400
X-MC-Unique: PeWnxU-uNXyd4XmDHsMVkQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9d5bc6161so1153961fa.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470350; x=1694075150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYjlS8xYetQB65Gj9ZtBHGyY7Wxd5IHokOyjYA/2UXc=;
        b=jwng46TTN71dgmHWpyKeJqrZ2nyvwSZL7AZqbFjkj3QjYSobd1La2LLDQd7HTzUXm7
         fsYm3P4KNntksFSdieKqEolEzIgmVR9Uzshfzo5ELlVBJIKO8X507LQr0qY+vp+YpBY0
         0pqKVDwrsVnTg1RBH7UuODBil71Gr+OiRlnegAp0+zvsqVh60+oXQH2hs7sjj5dWe3Jz
         fG9skLv3zJlmdqaD5RuQoVOXBrxZfBUKvVka62b1QsPVtbFYd0YxI2o1qceBIJULug+W
         ZLo21MzhX8o07WiIWk9vc+lbxbs9W0zV6BYlRpJxpDKhj9nYs7crm886Bq6igwJNlh+T
         CeRA==
X-Gm-Message-State: AOJu0Yyprdq1yTUpJkLFhNCDYN0ExX8Bsdshz2c4qjn6piuZqXS/xlQf
	1M+BBX8aQZOgyTvmXJvSgblcfpBeVpGBwyzywdfU9LifpXVWbtvDRnSal7TIMIVfvk/qT7dlbf+
	7PuB4EJLa3FDZ0cEL
X-Received: by 2002:a05:651c:198b:b0:2b9:a156:6239 with SMTP id bx11-20020a05651c198b00b002b9a1566239mr3631052ljb.1.1693470349991;
        Thu, 31 Aug 2023 01:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVv2p+9WibGZqNFXmTo77VoU6L6B729OHCWElGXTLXrayWlDa1sueU5Ewx43phqJNNRihKGw==
X-Received: by 2002:a05:651c:198b:b0:2b9:a156:6239 with SMTP id bx11-20020a05651c198b00b002b9a1566239mr3631041ljb.1.1693470349631;
        Thu, 31 Aug 2023 01:25:49 -0700 (PDT)
Received: from gerbillo.redhat.com (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b00988dbbd1f7esm480675ejb.213.2023.08.31.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:25:48 -0700 (PDT)
Message-ID: <60d9d5f57fdb55a27748996d807712c680c4e7f9.camel@redhat.com>
Subject: Re: [PATCH v2 2/5] net: ipv6/addrconf: clamp preferred_lft to the
 maximum allowed
From: Paolo Abeni <pabeni@redhat.com>
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org, 
	jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net, 
	hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org
Date: Thu, 31 Aug 2023 10:25:47 +0200
In-Reply-To: <20230829054623.104293-3-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
	 <20230829054623.104293-1-alexhenrie24@gmail.com>
	 <20230829054623.104293-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-28 at 23:44 -0600, Alex Henrie wrote:
> Without this patch, there is nothing to stop the preferred lifetime of a
> temporary address from being greater than its valid lifetime. If that
> was the case, the valid lifetime was effectively ignored.

AFAICS this change makes the ipv6 implementation more in compliance
with the RFC, but on the flip side it will also break existing users
(if any) which set preferred > valid as a way to get an unlimited
validity period.

I'm quite unsure if the above is really the best option, but I think it
should not threaded as a fix.

My suggestion would be to re-send the uncontroversial patch 1/5 as a
stand-alone fix, and the following patches as a series targeting net-
next (no fixes tag there).

Cheers,

Paolo


