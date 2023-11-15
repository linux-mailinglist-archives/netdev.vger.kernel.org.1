Return-Path: <netdev+bounces-48146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362167ECA21
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA797B20986
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB713DB86;
	Wed, 15 Nov 2023 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjZCRnfu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12469196
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:59:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so244a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700071162; x=1700675962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz6XK+dxbk3UUD9irdSydkqDAK7oRCmEbZL3DCJxl5o=;
        b=vjZCRnfudEGbZ0b4Yl8QPc04PLsEalWFLoKm+g/IoEBnQi+6URNBNbvB+JHD85i4Kr
         jbyVddUpOGJm6Z4mRbc6eRNcmmu55SYZh07cVNRoPAqVuLt/xuQ2ruGacfEa4IWlQEdo
         yWxryg2d9U+ZQEPPVPrNU53Db4ji3E5k6DdouXWN/HmmawEREppQBOl+2iVI7A6BAdjO
         Dker6hxteVX81iEIvkrIpLHHqbDJw5p40Llwl5zZmETHidl6hE//cejHxiCRnM+ILvBC
         KVyyLdrrPSp/C+ZZ8yQ/72RCPpsZJOWp5yEFSGmvlHo0htkt+k7j4686wfjTfQk632kD
         lmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700071162; x=1700675962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz6XK+dxbk3UUD9irdSydkqDAK7oRCmEbZL3DCJxl5o=;
        b=I7awf0AFl5CqjaCwxMa4sPzDQnF4mx0ilKq4iAgKkQeQDBqYtMMAPz2VLXvkab2Dxr
         rZ0LECRGbpu+RkA0li7IsmUYiXFuRze1H1wzSM68JMRpCRhR9HoALOdw8SSm4jITdOST
         p/IpInnyjx/zw3iH8ibaDyyefMid//58UHD8QQrcvd5sRvk4MxTBbSU4Hi49rf/TqpfQ
         SyUeqyIBV1AsNSCjlXFUKVY07SuF5W0HDfTvPaTyPA7vLQknY2jXkZ1kzY6M23Yg8J+W
         +YnjA5haPWFXWR/CrQ7ST/vhnsIDx4AdTXqrVe459My8w13aIG1jehIARbI5wLu1lHcT
         aYNA==
X-Gm-Message-State: AOJu0YwPZImdPofcMwJ3DQlsVUxBuoTr7v2m0KR3bI/XMBKVtzrJdNtV
	B76v05bYCT8ebPHO0SI7ueze/I2MLokoPFCr6fJukA==
X-Google-Smtp-Source: AGHT+IHCQ7Sw74JYAFKeM5pf9FjrV9DDONvVUlok/YLN+WlI2LuYomtYLe9Y7UsdKQ7nKkUcKWtwoF007LrVhVEMwRQ=
X-Received: by 2002:a05:6402:268d:b0:544:e2b8:ba6a with SMTP id
 w13-20020a056402268d00b00544e2b8ba6amr192734edd.3.1700071161637; Wed, 15 Nov
 2023 09:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113233301.1020992-1-lixiaoyan@google.com>
 <20231113233301.1020992-2-lixiaoyan@google.com> <20231114233056.5f798249@kernel.org>
 <CANn89iKtXMMgX7AMb3J8+0sgm-GWnCST+8JQsGmEaiL1fkVCzA@mail.gmail.com>
In-Reply-To: <CANn89iKtXMMgX7AMb3J8+0sgm-GWnCST+8JQsGmEaiL1fkVCzA@mail.gmail.com>
From: Coco Li <lixiaoyan@google.com>
Date: Wed, 15 Nov 2023 09:59:10 -0800
Message-ID: <CADjXwjhJgFDQQjJH+vG97H10AJmn+Fu8LM-heF0J7JTrsQn8Gw@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:07=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Nov 15, 2023 at 5:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 13 Nov 2023 23:32:57 +0000 Coco Li wrote:
> > >  create mode 100644 Documentation/networking/net_cachelines/index.rst
> > >  create mode 100644 Documentation/networking/net_cachelines/inet_conn=
ection_sock.rst
> > >  create mode 100644 Documentation/networking/net_cachelines/inet_sock=
.rst
> > >  create mode 100644 Documentation/networking/net_cachelines/net_devic=
e.rst
> > >  create mode 100644 Documentation/networking/net_cachelines/netns_ipv=
4_sysctl.rst
> > >  create mode 100644 Documentation/networking/net_cachelines/snmp.rst
> > >  create mode 100644 Documentation/networking/net_cachelines/tcp_sock.=
rst
> >
> > Can we add a small MAINTAINERS file entry for these files?
> > To clearly state who's taking on keeping them in sync?
> > Maybe Eric?
>
> +2, I am the one ;)

Sounds good, I will do that in the next patch, and thank you Eric!

