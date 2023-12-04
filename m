Return-Path: <netdev+bounces-53562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA49803AC7
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379C52813F2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593A26AE4;
	Mon,  4 Dec 2023 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTqIpLlK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD300B0
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:49:01 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4b2e74da92cso286397e0c.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701708541; x=1702313341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZihpDGnUtD/iC6Gp6VZpj1EirN+qsxVwkpIT6BK/co=;
        b=PTqIpLlKL2sEZ/fbZmOBgS5qTH880WmtR8jcJd+g/EEVz2f3J4mthQ8eg3t5k9u9QW
         yQ57yT3VRwpuMUNNpo8Bg6vUiwdgUiMFU68FHlFDMgJBCgmu5i8OVvPHOch8GJGgAi3r
         zcc/pUwPpL4Kg+kWEzhUdScR2MVGnFV3xNgb8t/TjQ5q2lftaQlHWiVWiJI+0NtFF8w5
         +p5NbrvacbWKrFj4MGS1Cr0obxTYfZTi6eDvhBPlWKGFVW/p9i4xoeeKSuDm9aN3D1uy
         /AvCNbomSSaSTiDR3B40GDWihghDGL44rMX4IqgRd0XfkE2dsBWD8dyFQ171RTlI5oSn
         eDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708541; x=1702313341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZihpDGnUtD/iC6Gp6VZpj1EirN+qsxVwkpIT6BK/co=;
        b=PkEGc+cLv6lK0AKPU1hOdeo8dMuRby4Zlwl5PsUVYZSK+octmZlwCA1ASY7v3YAZUM
         7p9KTIvVe157idD5/R5LAhYCPitRKNfY5IT0BRgDpypZACWABowlUbSyjSEormj1K6JO
         +kBrhWxgoCeRRdI6BYT3lXZOTyhpXHEENw8ZYp6EvfeqiA86AnM4HUMIt6Imq3rBb4RJ
         juIoUWGYhdAKaDZl/Ba7shUuqM7lvbWRVm5R7wBZYjLNcPQkGb3tvWMpn8qjfT95XZi+
         HtwSg3l0qxg+fb7SfN3YQY6XzKccg/lhQaJ9xDWXnJy7qANT4JJ75btURl1+KIZLtDnU
         itMg==
X-Gm-Message-State: AOJu0YzqZvUWA2h15B2CSmVzBAxCKDh15XIKEBcjtF1KjS9nAt0hvK6C
	DlPW8TbiWa06cOXoJg2/av528PIkAFjoTkQmKI8WJQ==
X-Google-Smtp-Source: AGHT+IFk6TaOHi77KENSYXFz5VpWEvbyvpmiKH3ls0N5InUXBPclH+FfOg8tx6d1RfMZjgZY5qAmVNPh3QUqdF0Ggbs=
X-Received: by 2002:a1f:c605:0:b0:4b2:99a4:ff9 with SMTP id
 w5-20020a1fc605000000b004b299a40ff9mr1754699vkf.13.1701708540762; Mon, 04 Dec
 2023 08:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com> <20231127190319.1190813-7-sdf@google.com>
 <20231202170952.GB50400@kernel.org>
In-Reply-To: <20231202170952.GB50400@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 4 Dec 2023 08:48:46 -0800
Message-ID: <CAKH8qBvk695byc6TdXyxWR9RmQa+_-0OQAvEsxgOgT6O0amN0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 06/13] xsk: Document tx_metadata_len layout
To: Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 9:10=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Nov 27, 2023 at 11:03:12AM -0800, Stanislav Fomichev wrote:
> > - how to use
> > - how to query features
> > - pointers to the examples
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> ...
>
> > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentati=
on/networking/xdp-rx-metadata.rst
> > index 205696780b78..e3e9420fd817 100644
> > --- a/Documentation/networking/xdp-rx-metadata.rst
> > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > @@ -1,3 +1,5 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  XDP RX Metadata
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentati=
on/networking/xsk-tx-metadata.rst
> > new file mode 100644
> > index 000000000000..4f376560b23f
> > --- /dev/null
> > +++ b/Documentation/networking/xsk-tx-metadata.rst
>
> Hi Stan,
>
> could you send a follow-up patch to add an SPDX identifier here?

Hmmm, I vividly remember adding it here after your initial comment :-/
Will send a follow up, thank you for catching it!

