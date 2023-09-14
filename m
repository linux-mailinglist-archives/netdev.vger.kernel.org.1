Return-Path: <netdev+bounces-33768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEA79FFD6
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8925A1F22926
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6892224E4;
	Thu, 14 Sep 2023 09:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBB801
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:17:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1031B1FC1
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694683065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoLGq0no9Mbpki88Y0pc399X/pHu1m7TzHX3ZA/tfao=;
	b=A8uhgb6YeU9fepwRyKeo4R93UqfyOizJMID4poEjDcVjyzIXZP3H1/GvdQQy9W8M0BynSH
	P3veVAWnHez5CGfY8+JOCLHlB1zMrM4uRpr/H+7kWysgd1xTY4l2pTJs+Bp2l1/IEVUfbW
	xHRogPN/s2dKPRhPmSWgzoEooaDzPfM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-G2Xg6dv3NA-zhQ-IyHGTUw-1; Thu, 14 Sep 2023 05:17:43 -0400
X-MC-Unique: G2Xg6dv3NA-zhQ-IyHGTUw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9aa25791fc7so18232166b.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694683062; x=1695287862;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoLGq0no9Mbpki88Y0pc399X/pHu1m7TzHX3ZA/tfao=;
        b=bJGvZDljlW+FXSwVNQ0apM+97SPCjHg+K+Y1FxHcsx/MHVk0Qp2qQ3p1M3zYIYyggC
         QQmswvRTEP7VX+Gq8h2L32mkrqiXQFav3azh/1XAGCc7Ypr5den43ORHDny4oKcyG/9o
         27imFQbSga3/v4OAB0y23zMhPdHmJ+G7DbNQa3MxEC0i3pvr3Jl/HnHMpebDgTytS45w
         0x1749tzGdGUxIWb1ZHy1yrLwirygtyc4qg8n7yI97aRrpR/Wfh9Mn0t7LuVXir7lT+P
         EWKg6FfBAPvkOkxfGsxL4jlaonXkdMM+hC8WgdYHkAfBU6vlI7sJcPO3AT0+bFteXA4C
         Wrqw==
X-Gm-Message-State: AOJu0YwDgqlvz6M0mVHODi0v9cW7k6guMSGLZjTdGuhTQW7lBa3bPeFt
	6sjG51Ex8c5Hvh+IyWJM2nKLs6Xfx5xaan6wImKvh7XLXSuRLIc0RTkuvkdmnU77OLtuJi3vyYN
	00rJBLBvyfpDk2X7c
X-Received: by 2002:a05:6402:268d:b0:51e:5dd8:fc59 with SMTP id w13-20020a056402268d00b0051e5dd8fc59mr4554991edd.1.1694683062403;
        Thu, 14 Sep 2023 02:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGrOu/VdTRidn7WdZxGw3Z+QqSifnrIL+jv0N3mzMlfmetmChM7z+GpK4b9WnTJVbNd06aig==
X-Received: by 2002:a05:6402:268d:b0:51e:5dd8:fc59 with SMTP id w13-20020a056402268d00b0051e5dd8fc59mr4554975edd.1.1694683062074;
        Thu, 14 Sep 2023 02:17:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-187.dyn.eolo.it. [146.241.242.187])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b005232c051605sm660419edw.19.2023.09.14.02.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:17:41 -0700 (PDT)
Message-ID: <ec738a108981c42604fa50f89c4551942b9e281b.camel@redhat.com>
Subject: Re: [PATCH net] fix null-deref in ipv4_link_failure
From: Paolo Abeni <pabeni@redhat.com>
To: Kyle Zeng <zengyhkyle@gmail.com>, dsahern@kernel.org
Cc: vfedorenko@novek.ru, davem@davemloft.net, netdev@vger.kernel.org, 
	ssuryaextr@gmail.com
Date: Thu, 14 Sep 2023 11:17:40 +0200
In-Reply-To: <ZP/OjT62OGVxwa3t@westworld>
References: <ZP/OjT62OGVxwa3t@westworld>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 19:35 -0700, Kyle Zeng wrote:
> Currently, we assume the skb is associated with a device before calling
> __ip_options_compile, which is not always the case if it is re-routed by
> ipvs.
> When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> This patch adds a check for the edge case and switch to use the net_devic=
e
> from the rtable when skb->dev is NULL.
>=20
> Fixes: ed0de45 ("ipv4: recompile ip options in ipv4_link_failure")

I'm sorry for the nit-picking, but please use 12 chars to identify the
blamed commit or we risk (future) conflicts.

Please also add a subsystem tag inside the subj. Finally include a
revision counter into prefix, alike:

[PATCH v3 net] ipv4: fix ...

(I'm not really sure about the correct counter here, since a few
versions flied without it)

Note that you can retain David's ack in the next revision.


Thanks!

Paolo


