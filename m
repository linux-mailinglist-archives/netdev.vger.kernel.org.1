Return-Path: <netdev+bounces-47911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4AA7EBD57
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 08:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10DC8B20B08
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 07:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC52E849;
	Wed, 15 Nov 2023 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1mbosZs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC714416
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:07:22 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFFDF9
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 23:07:21 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so9984a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700032039; x=1700636839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfcFysjIr9TqyTxRI4vH5GxZK+CUP4M6Ew3Hyv78EmA=;
        b=P1mbosZsVZYp3/8Lw8OOAHtNh/KFc6iNCcJW4izgujXWh9flMRTmaZjFEnlvaY7rUA
         GDIadhmYgqdBvIJ4TH16PU50y8RykAg99dtjM/15vYqjDJWcrpah83Bd6ejlc3f1CH1/
         qF5pUzejwfipS4vsDFLyuDCXUgpF+JuMB68tLzh9HyytiImPF0Svlp6+Ol4sgBanQhct
         oMyD6vBd7xNdpsmayqWIacGhEfDeqvolKPXQcbk2VrfyBmWFpgyAz/GcSLz/9kPcLsZh
         eETmOM549W/e7wkvvX3ovhzzE8q44XFIuFSzmGR4MvokCf6beMYjkVhixgPYrIkUgzwP
         koGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700032039; x=1700636839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfcFysjIr9TqyTxRI4vH5GxZK+CUP4M6Ew3Hyv78EmA=;
        b=RcW9SGyMfbWaZBA6UfjscFaX1qCv9JxlSeZmggd7vvG0dzDCTUlsNUxqVdEGEnvh/y
         7D13wwo7klrX1omRSjR5nudkvaxKHgpGrBaZ1SVLuAj3P41VmmozqVkliHgkBpwoLPNn
         XFgIZBBdDN+tG3lahaPb2bmCjKA62PDGEciGJDID2JiD+4YMPZrPVC0py54Zf35qUWoE
         ya9fTxsmOY1DeEzvvCSQQSmy6UM7vWTtAJsmBALji1K7YGNlKXtT8zFjvUT16SSEpypE
         NfAHm/nBCEN9lGwLK/Pi+pdve5RFAVL9dkr0sad+B3F3oU8U3v4iw8l2bIgGtzXommmW
         /QOQ==
X-Gm-Message-State: AOJu0Yxx2sqqEgvvKgMGiHODPrABXlYJRZG7OEgKBbD6wgAupoaWnQpD
	Fkf170Tmcf+vWoiU2a6OrOyFVBvuLhUYSw8b2x79pQ==
X-Google-Smtp-Source: AGHT+IGOLauAwxi/BVJJJqHU1QJ0WaHUKOi8vg43jvV0SnYXaSneautYd/FXuCN9zH7eMhIxdWsktlry1dmzNP9/pp4=
X-Received: by 2002:a05:6402:e95:b0:544:f741:62f4 with SMTP id
 h21-20020a0564020e9500b00544f74162f4mr116505eda.0.1700032039377; Tue, 14 Nov
 2023 23:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113233301.1020992-1-lixiaoyan@google.com>
 <20231113233301.1020992-2-lixiaoyan@google.com> <20231114233056.5f798249@kernel.org>
In-Reply-To: <20231114233056.5f798249@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Nov 2023 08:07:05 +0100
Message-ID: <CANn89iKtXMMgX7AMb3J8+0sgm-GWnCST+8JQsGmEaiL1fkVCzA@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Coco Li <lixiaoyan@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 5:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 13 Nov 2023 23:32:57 +0000 Coco Li wrote:
> >  create mode 100644 Documentation/networking/net_cachelines/index.rst
> >  create mode 100644 Documentation/networking/net_cachelines/inet_connec=
tion_sock.rst
> >  create mode 100644 Documentation/networking/net_cachelines/inet_sock.r=
st
> >  create mode 100644 Documentation/networking/net_cachelines/net_device.=
rst
> >  create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_=
sysctl.rst
> >  create mode 100644 Documentation/networking/net_cachelines/snmp.rst
> >  create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rs=
t
>
> Can we add a small MAINTAINERS file entry for these files?
> To clearly state who's taking on keeping them in sync?
> Maybe Eric?

+2, I am the one ;)

