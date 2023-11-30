Return-Path: <netdev+bounces-52535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02217FF115
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC4E281E2B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42741482F3;
	Thu, 30 Nov 2023 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCP2R1Rq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC21196
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:02:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso9968a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701352931; x=1701957731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxBMiGcAEd4doX2T6kUaaKToconnxbKJJPNo5nm1fd4=;
        b=OCP2R1RqAZDCq6wXGz74eZL+wxQIbqkSreG/uMzQADiOjLifhVwbq9Rtu79e/RTiUT
         g+BjpyARHtw2DSG1Yk/IJDtRNu9ckZvENcYrhc/oJFf28XTUK2WA4GDxX+zCSdyxKBoJ
         GMjCKG3L6V9K+DCtYmKgpWVf0nQpMuLDMbfg8h1Bj271OnpMx3TU/PA/jQZglZILAM7G
         aasOYD2bm254PNgOEmuM1U7o4QnbufgjrClkPhAwRUuTQkVcWBL7dxV3BXrtSZV4mk74
         v0C1EzdsMLIoo/u2+HKtB1x3Ts/KlvnFWHfD1xOM4LwT+J2nbaXd8JYkoq8eJyniQ3GC
         t6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352931; x=1701957731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxBMiGcAEd4doX2T6kUaaKToconnxbKJJPNo5nm1fd4=;
        b=pCpPZ8kPETOypu7i64F+nZayZ5b7YeeiKw55QLAsMX+4Ag66cuRqJ+7gSyD29b7GdF
         KDXIPMZmZyIeXIHf+KPdRxHrKcXLVcW2Bt5fiXG9RaA293UHf/6Cg8UIuGdD/vwisbsA
         iA79U4JrNw0PUVff9Ih8h8RFabCbTUPl58+E2cZ2KLzGGj60XhsFvTYNyU4fWdPwTifa
         YOm+lby1d/o/EVDyaDD6zVA41C/A57GDpScX75OA9eLq4iT4+4Js3SdOBUargZqzW17i
         NkevbvF6xZBUpFPSa4fAs+msl+00tS6+fa5r+Ja/aab0wwuI74bwy6f6gP/4BfUuF4FB
         gIjg==
X-Gm-Message-State: AOJu0YxNWdjdusyIkNNctqao6N/iFxUlOctw731UuZMpbLmgSXuqRGLY
	HSwhKiftEwjN8FOS57utQ2uQObuREjtTxMGgCOp30Q==
X-Google-Smtp-Source: AGHT+IEVq5eaRqCUGxQslevokHcou3lYVimBUmZu/Cymvq6zNuxmXKwBkEpc68x5OOLtst4kFtL6VTT+EwfFF1xjZC8=
X-Received: by 2002:a50:8a8e:0:b0:54b:bf08:a95f with SMTP id
 j14-20020a508a8e000000b0054bbf08a95fmr167000edj.6.1701352931041; Thu, 30 Nov
 2023 06:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 15:01:56 +0100
Message-ID: <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com>
Subject: Re: Bug report connect to VM with Vagrant
To: Shachar Kagan <skagan@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>, 
	Topaz Uliel <topazu@nvidia.com>, Shirly Ohnona <shirlyo@nvidia.com>, 
	Ziyad Atiyyeh <ziyadat@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 2:55=E2=80=AFPM Shachar Kagan <skagan@nvidia.com> w=
rote:
>
> Hi Eric,
>
> I have an issue that bisection pointed at this patch:
> commit 0a8de364ff7a14558e9676f424283148110384d6
> tcp: no longer abort SYN_SENT when receiving some ICMP
>

Please provide tcpdump/pcap captures.

 It is hard to say what is going on just by looking at some application log=
s.


> Full commit message at [1].
>
> The issue appears while using Vagrant to manage nested VMs.
> The steps are:
> * create vagrant file
> * vagrant up
> * vagrant halt (VM is created but shut down)
> * vagrant up - fail
>
> Turn on a VM with =E2=80=98Vagrant up=E2=80=99 fails when the VM is in ha=
lt state. When the VM hasn't been created yet, 'Vagrant up' passes.
> The failure occurs in the Net-SSH connection to the VM step.
> Vagrant error is =E2=80=98Guest communication could not be established! T=
his is usually because SSH is not running, the authentication information w=
as changed, or some other networking issue.'
> We use a new version of vagrant-libvirt.
> Turn on the VM with virsh instead of vagrant works.
>
> Stdout[2] bellow.
>
> Any idea what may cause the error with your patch?
>
> Thanks,
> Shachar Kagan
>
> [1]
> commit 0a8de364ff7a14558e9676f424283148110384d6
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Nov 14 17:23:41 2023 +0000
>
>     tcp: no longer abort SYN_SENT when receiving some ICMP
>
>     Currently, non fatal ICMP messages received on behalf
>     of SYN_SENT sockets do call tcp_ld_RTO_revert()
>     to implement RFC 6069, but immediately call tcp_done(),
>     thus aborting the connect() attempt.
>
>     This violates RFC 1122 following requirement:
>
>     4.2.3.9  ICMP Messages
>     ...
>               o    Destination Unreachable -- codes 0, 1, 5
>
>                      Since these Unreachable messages indicate soft error
>                      conditions, TCP MUST NOT abort the connection, and i=
t
>                      SHOULD make the information available to the
>                      application.
>
>     This patch makes sure non 'fatal' ICMP[v6] messages do not
>     abort the connection attempt.
>
>     It enables RFC 6069 for SYN_SENT sockets as a result.
>
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Cc: David Morley <morleyd@google.com>
>     Cc: Neal Cardwell <ncardwell@google.com>
>     Cc: Yuchung Cheng <ycheng@google.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> [2]
> Vagrant up stdout:
> Bringing machine 'player1' up with 'libvirt' provider...
> =3D=3D> player1: Creating shared folders metadata...
> =3D=3D> player1: Starting domain.
> =3D=3D> player1: Domain launching with graphics connection settings...
> =3D=3D> player1:  -- Graphics Port:      5900
> =3D=3D> player1:  -- Graphics IP:        127.0.0.1
> =3D=3D> player1:  -- Graphics Password:  Not defined
> =3D=3D> player1:  -- Graphics Websocket: 5700
> =3D=3D> player1: Waiting for domain to get an IP address...
> =3D=3D> player1: Waiting for machine to boot. This may take a few minutes=
...
>     player1: SSH address: 192.168.123.61:22
>     player1: SSH username: vagrant
>     player1: SSH auth method: private key
> =3D=3D> player1: Attempting graceful shutdown of VM...
> =3D=3D> player1: Attempting graceful shutdown of VM...
> =3D=3D> player1: Attempting graceful shutdown of VM...
>     player1: Guest communication could not be established! This is usuall=
y because
>     player1: SSH is not running, the authentication information was chang=
ed,
>     player1: or some other networking issue. Vagrant will force halt, if
>     player1: capable.
> =3D=3D> player1: Attempting direct shutdown of domain...
>
>

