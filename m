Return-Path: <netdev+bounces-35597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4E7A9E31
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4078F28198D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D80182C3;
	Thu, 21 Sep 2023 19:58:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC017743
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:58:42 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013FC3583
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:58:39 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414ba610766so90921cf.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695326319; x=1695931119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FfisnjYNsOL8cGxpX9K2HnFfkT4nFMBwQIPYmNAGaM=;
        b=DohyFrj5ueb5UIv15uZCeZD62asacUfPm4Fwbouisr2CHv2+V4pzfby22+TCYL9O4o
         LpmEc+ap+fcvDVBqB73CX9ahfdy8fCqJXIOsioTGGUZB666VpC2w5X5qsm94GC0GMHqw
         9KLX0aVF1DsLDmfjTJ8wsf8gh+AlhAVCUYLpI1G+9tVJm/lQjwzaX1J88UpXdri/3wkf
         gyfbiOcbUVwdJ+0WLRTA2UXeXuvHSLi56pv6/v36Qjj+JwPvCxiBfa11aVfqWgQN0GZB
         LpgHPmSzYAp6zdjFNHqlkZgLS/Vxw916p5s3yKbyRBrCHwSiovUvUb3BvE/eCXtUOhpG
         gv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695326319; x=1695931119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FfisnjYNsOL8cGxpX9K2HnFfkT4nFMBwQIPYmNAGaM=;
        b=DNlchFSE27NmbWsenZiJZpfejI403WvkYFgdSAHbvPa1BllF91C6JAfgkhn/v7Ie6M
         kpwVblTTQhjCBfI4pKUAPlTg1JcSyFrAePA2/NP41oF9wZiSShjDPK1cv0abos19EywW
         FK1ia3vF2XS/LFpdDdYlNGFfNQSdwJkhjv7W7PJWgNUELtvNnbiwXHL25v6A+S09gpNm
         5n0Xc3pwqPzjfHLEuLXtZr79xrhZw5IIP0LAZQmbwcZywTxRzqPJ2h6iMT3e4784OmtD
         TpiEVpUMCr5YWn8kSC86c8V1skjkoeVfr/NjrfTgO6zkfdFZx6WIwjhnEquwmQ8IuAiK
         rGmw==
X-Gm-Message-State: AOJu0YwM7WtF6sOtpHE0Fs2wz8NPiCv9QZmW/1WtufmTGI/ILRvHEkHQ
	ggMXU9n8nn0NpI994htXVvjDMvCtxElmkUdg3JPBLL1CZr8goB8R8fY=
X-Google-Smtp-Source: AGHT+IGJ6jwXUXExcyx4muo67lAz2nyvdpM5sjjvIUw3AuPhH7KtatRQfNyEvOVD8w/QtrqegvvcUU5CU/+Dkj3DoD4=
X-Received: by 2002:a05:622a:4d1:b0:3de:1aaa:42f5 with SMTP id
 q17-20020a05622a04d100b003de1aaa42f5mr1926qtx.15.1695326318747; Thu, 21 Sep
 2023 12:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921194314.1976605-1-i.maximets@ovn.org>
In-Reply-To: <20230921194314.1976605-1-i.maximets@ovn.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 21:58:27 +0200
Message-ID: <CANn89iJxrsgeS_FOivxPdYLhPyLC6Lo8VBzLjdx9-mQKXxqjwA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] openvswitch: reduce stack usage in do_execute_actions
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 9:42=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
>
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
>
>      a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp
>
> NSH is not a very common protocol, but the space is allocated on every
> recursive call or re-entry multiplying the wasted stack space.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

