Return-Path: <netdev+bounces-36980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C27B2CBC
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9E92B1C20982
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31862C12C;
	Fri, 29 Sep 2023 07:00:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FB28E3
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:00:48 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA041A5
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:00:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-578b4997decso11004651a12.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695970845; x=1696575645; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHaZrm4yTpvdH9+LanAVTqzIGu4mYLJm8CLa6yJRB00=;
        b=BxsVHQ/KK0atasO/+vDoxISMMfOdwfPEOHHbT9MfMd6XLnIf9GBwLIO9tdsQaaeMpu
         Eoat8lLK8XSuI0X6qxNOvcPFR7fVFaV37U6vy4pxfcxK5EgqcvXlyAiCYKScxpQFV+4p
         BRRFJcmJF88mhJqcBXtrYl8GZ5sqqsBRIKQeJ5Tb37jRv6NuF0GIcoy0xxAD/uwPzEzy
         FTtgnVt+F1apwtW45ZDcpR50HG/Frt1LW4v2jBHllwV9DrpwVQjA5cCyqWyXb9X7I5w0
         Z03iNCALdVgzT1B8W/e1xnprS/ktvU1B6ZIvz4u30MjT7GNNlCxXPmkuKDbwcwBfueLT
         2iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695970845; x=1696575645;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eHaZrm4yTpvdH9+LanAVTqzIGu4mYLJm8CLa6yJRB00=;
        b=vqxIqGXYHiqmAhIVjV9VFJh+JsuRX0E93eKmo3llTPKS+GowjLJjkYeW6oGecoo07q
         nwTGyFU6DkuPA+GfVFJ1bVScx8g39DxnGbgprqDn4VEos1nWbhVbe7C7bgQk1VJF4wF3
         uAPqD9kui+f3SEv9dqUCvIUv6Ij+rKp22x/YXjRKZ8exxXTifUxETwSYqDN20/oxTzEr
         e/QMlagTozjivdNfaU8DitxfxubrIhWdTARb+cM0Qous6EosxNYk1SziE/v+JWWCXVys
         9r1gyEoUUO4bUY7iE15+aavSYH1bygy0FdQfdo8qG1nFtiO5gRzkfwDVFC7hQBq7YsXF
         QZvw==
X-Gm-Message-State: AOJu0YzKtIJvlmPzJmot8GCa5tOI2vtKe9jLdHaJItATZLAvIfkdH9Lu
	3mK5M/+u55MSfTIyUoE4X+A=
X-Google-Smtp-Source: AGHT+IF+/idGGdfM8EqzIHZwI4DdficBfoQ2kd1O1CPP8K40rXou21PoVZlTO0hgXDCbguh5i72KGQ==
X-Received: by 2002:a05:6a20:158e:b0:15c:7223:7bb1 with SMTP id h14-20020a056a20158e00b0015c72237bb1mr3474238pzj.20.1695970845336;
        Fri, 29 Sep 2023 00:00:45 -0700 (PDT)
Received: from localhost (58-6-231-19.tpgi.com.au. [58.6.231.19])
        by smtp.gmail.com with ESMTPSA id f25-20020aa782d9000000b00690d1269691sm3486559pfn.22.2023.09.29.00.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 00:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Sep 2023 17:00:24 +1000
Message-Id: <CVV7HCQYCVOP.2JVVJCKU57CAW@wheely>
Cc: <netdev@vger.kernel.org>, <dev@openvswitch.org>, "Ilya Maximets"
 <imaximet@redhat.com>, "Eelco Chaudron" <echaudro@redhat.com>, "Flavio
 Leitner" <fbl@redhat.com>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aaron Conole" <aconole@redhat.com>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <20230927001308.749910-5-npiggin@gmail.com> <f7tfs2ymi8y.fsf@redhat.com>
In-Reply-To: <f7tfs2ymi8y.fsf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri Sep 29, 2023 at 1:26 AM AEST, Aaron Conole wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > Dynamically allocating the sw_flow_key reduces stack usage of
> > ovs_vport_receive from 544 bytes to 64 bytes at the cost of
> > another GFP_ATOMIC allocation in the receive path.
> >
> > XXX: is this a problem with memory reserves if ovs is in a
> > memory reclaim path, or since we have a skb allocated, is it
> > okay to use some GFP_ATOMIC reserves?
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
>
> This represents a fairly large performance hit.  Just my own quick
> testing on a system using two netns, iperf3, and simple forwarding rules
> shows between 2.5% and 4% performance reduction on x86-64.  Note that it
> is a simple case, and doesn't involve a more involved scenario like
> multiple bridges, tunnels, and internal ports.  I suspect such cases
> will see even bigger hit.
>
> I don't know the impact of the other changes, but just an FYI that the
> performance impact of this change is extremely noticeable on x86
> platform.

Thanks for the numbers. This patch is probably the biggest perf cost,
but unfortunately it's also about the biggest saving. I might have an
idea to improve it.

Thanks,
Nick

