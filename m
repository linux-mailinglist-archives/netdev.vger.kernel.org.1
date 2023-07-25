Return-Path: <netdev+bounces-20736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB9760D1E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842571C20E83
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66D4C97;
	Tue, 25 Jul 2023 08:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C538C00
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:36:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE14199B
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690274201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRJ1CmvViBO90LLupL/ZIcIGAWRPQSZPYPsqPyzbbTY=;
	b=CfsFQVrypP7loRqnl25yYHoZFuvQ4z1pe2IClNNSC58UI5JLDdmgLHbH26wLM/QSu+iY6H
	TOlLgtXYqZMPo3r9AVjoC8i3ZqFDlsdMxugJ6A92BfLun2kjJ8kqleHqRl4F/PbbzSN22u
	DjrwFFZz3WmHJqbAabN/7XacZtISXA8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-QPdmZOocOmmD0UBIdNoXag-1; Tue, 25 Jul 2023 04:36:36 -0400
X-MC-Unique: QPdmZOocOmmD0UBIdNoXag-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4054c24173dso10494491cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274195; x=1690878995;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRJ1CmvViBO90LLupL/ZIcIGAWRPQSZPYPsqPyzbbTY=;
        b=a7rp2pMYgmamxzEdZhiZg8me18zQDpZxJ+L5CM7Cv1Wvp3B+tekmO2sRbCK0r6F+t/
         HC9d2JCXD1jKcQrZwwExRqe6LAAcsSkgeMfIEXVCMRojj3voQxuvwqHOt0Xm+JY3aWLh
         1ZZubdwfloJZfgrIj8mnrgkTLU8sP2F+lQtsrgQW89GHlVsS9thLaEw4TMmty8rRN3di
         kJuuaGN/F8P7pyaCCMqjCkYU3Hi/BycXSTsRRCEvhHoRYLTbWFnHN7I8v8SMya1Zxrh4
         8LU6MmXBgmQNN4fiXQOmuHAi8e5wUSrZYgm+DfahP1lGHlE5FuJYwlTwQYHkKYGhyuYI
         z8YQ==
X-Gm-Message-State: ABy/qLbvkpjJnJ7guov4TU0RMhefPd1nGM6RXaq0yZEp6SXzl9OYJxKa
	r84N1x2CpIL0TvA0JX2Qt41OSBYZ5JJTnl/qnAPN1B8rjGJW091gUW5JZbcrlqu88jUHFmQflS1
	78WIWjWXE96xe0eDf
X-Received: by 2002:a05:622a:16:b0:403:59f8:25d9 with SMTP id x22-20020a05622a001600b0040359f825d9mr15914099qtw.2.1690274195691;
        Tue, 25 Jul 2023 01:36:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHJvGI4vTQypOyC8OSqS5tYMPQeLVDYvXPKxsS+ky+cFAkbILJGR2gOPsE6NQi0ZS7cuBXjw==
X-Received: by 2002:a05:622a:16:b0:403:59f8:25d9 with SMTP id x22-20020a05622a001600b0040359f825d9mr15914081qtw.2.1690274195496;
        Tue, 25 Jul 2023 01:36:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id r26-20020ac8521a000000b00402ed9adfa1sm3924850qtn.87.2023.07.25.01.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:36:35 -0700 (PDT)
Message-ID: <87ca1394a3110cad376d9bfb6d576f0f90674a2d.camel@redhat.com>
Subject: Re: [patch net-next v2 00/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 moshe@nvidia.com,  saeedm@nvidia.com, idosch@nvidia.com, petrm@nvidia.com
Date: Tue, 25 Jul 2023 10:36:31 +0200
In-Reply-To: <ZL+C3xMq3Er79qDD@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
	 <ZL+C3xMq3Er79qDD@nanopsycho>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 10:07 +0200, Jiri Pirko wrote:
> I see that this patchset got moved to "changes requested" in patchwork.
> Why exacly? There was no comment so far. Petr's splat is clearly not
> caused by this patchset.

Quickly skimming over the series I agree the reported splat looks
possibly more related to core netlink and/or rhashtable but it would
help if you could express your reasoning on the splat itself, possibly
with a decoded back-trace.

Thanks!

Paolo
>=20


