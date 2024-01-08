Return-Path: <netdev+bounces-62437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F482747B
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898D91F231D8
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A9951015;
	Mon,  8 Jan 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsFiMZc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA65101D
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557a615108eso9153a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704729170; x=1705333970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnC1nRHdPIGea5afHOCep4P+Uu/fQQgsePCdXyCMMdM=;
        b=NsFiMZc0lK6KHprUKWawkHd/bcedy96eEF0y/c7q5fCu4DyE1yK5siMnP+VrCnIANY
         4G1kHQifknYySo0a0mti6DESAQS9+g/LjYFXkxpKzU7hfxdwl2m84aGMRWuaLxcW3ptN
         bGs9djXcjTjCOzkTLYN6pqM3gmvlxXxJ9f5IMj/8jlDRz9TZXZpVqCnCzcGGu7qRPDqb
         RHX7dRnOVLrqnxT8rivIuSM84ZfIdgCr3gNTcWYdeVEgEdEomNJY0FpGnDlFEqgGuZuI
         Ft5XHXhMUq/TmQTENN4r8uTfVF2rGu+n5kAssKek2H79MCACzLNJjgb8onnmzPpo91fx
         xKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704729170; x=1705333970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnC1nRHdPIGea5afHOCep4P+Uu/fQQgsePCdXyCMMdM=;
        b=RWNMm+6a6AjNWUXV8RA0lpTn50VeGgztOr+OKL7aAHYxyNGj2CPQXzNV8yH4DQXEha
         H/jtBAXZlpj/gYkziSs+Pr0G8rSTyBeCCZ3ha9FyqjIPVV5HyLgP9ysRCr5BAsd5luX/
         OTGA8i0S5UVj6Qz21zWHSY+/a1n8TfxA2Apjb5sFRsXuNscyy3+HzG6xAcqMh8NoY1oS
         qS3UByDH1J1JepYRKQrKXuEAK6GRlhj6R13YT2gKyIU1Z3VlvmIHNuvNhXYCM3z4sA/i
         uytIDekgHd63CTDtVYrxxvovh5T29eHLkBAXCqdyC2x12YHJern931Yfjzqf0uXq7BPa
         Bg2w==
X-Gm-Message-State: AOJu0Yxy/U9io98TpWlnwqpF0KEsyHkPgBRew2NB74Wfvvw6B/pfSg74
	ep6A/M0OkhhQ2VIFvYBgQVkgELvSffJffNWrGitBNV3iJdbI
X-Google-Smtp-Source: AGHT+IF2kb4m5UrGbosCBMjSgyyFPt6cGXJMN0XWA5Zq84JzqVNy33ZVEZsllcFAbosyX0JSlEMyP0zBTv8KFjRMhcM=
X-Received: by 2002:a50:8a93:0:b0:557:15d:b784 with SMTP id
 j19-20020a508a93000000b00557015db784mr280370edj.2.1704729170271; Mon, 08 Jan
 2024 07:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
In-Reply-To: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jan 2024 16:52:39 +0100
Message-ID: <CANn89iLNGrZo_z1L184F3WetrWV8bQwYrfyEDgn2-gtnPndDgA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shachar Kagan <skagan@nvidia.com>, 
	netdev@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 10:01=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Shachar Kagan <skagan@nvidia.com>
>
> This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
>
> Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> very popular tool to manage fleet of VMs stopped to work after commit
> citied in Fixes line.
>
> The issue appears while using Vagrant to manage nested VMs.
> The steps are:
> * create vagrant file
> * vagrant up
> * vagrant halt (VM is created but shut down)
> * vagrant up - fail
>
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
> Fixes: 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving some I=
CMP")
> Closes: https://lore.kernel.org/all/MN2PR12MB44863139E562A59329E89DBEB982=
A@MN2PR12MB4486.namprd12.prod.outlook.com
> Signed-off-by: Shachar Kagan <skagan@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---

While IPv6 code has an issue (not calling tcp_ld_RTO_revert() helper
for TCP_SYN_SENT as intended,
I could not find the root cause for your case.

We will submit the patch again for 6.9, once we get to the root cause.

Reviewed-by: Eric Dumazet <edumazet@google.com>

