Return-Path: <netdev+bounces-46225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC997E2A3F
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9AFB20D67
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE82942F;
	Mon,  6 Nov 2023 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fywR6Dsx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8129409
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:47:40 +0000 (UTC)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A804D4D
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 08:47:35 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4abe6a78ab2so1581732e0c.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 08:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699289254; x=1699894054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw9LT+eDkqBWCWgoT5gi4svTWg+hExM31Ju8qjxl7aE=;
        b=fywR6DsxejjryKQmtuf8jBf3eaO3m1hy5d+NVcbtCDvVRxa7AbXma2f/1sXOBPCqIh
         kWA0LlfiaF5eYHNGtD6/oDPjQWSHn+RLQe/W3XWtqG8oywNa081l52idw8dG/IQtE8HK
         Kzmv2sfOyzxSFCkA2b8qCl89cHnKV+d4vvbJCEa/ZGqu5bm4Do1zPstXK06QOpxOP5XM
         aKWTwdKdZ38i9mCORpXVvZleLdaqMhBlc65rspdbR1/afD35JYiyEYaDDPEfNl6rfuav
         TEMJkIH8MDmP4bY5Ivtv0OR0iuCCdmtctoscvDaP9HfAk6HeAW5QUQX7ygGaZnvqixeA
         JxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289254; x=1699894054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw9LT+eDkqBWCWgoT5gi4svTWg+hExM31Ju8qjxl7aE=;
        b=csUZYhZyUY4oy9BQLR80/GSl5xLctf50vPVjkMMS+SfYvWQ4CnnYS/AGrJ1p4zSIRc
         ckuXeCB7amfRb7syxTMY+sRvra6jg33l0G1vFHnbgTNpHRZLoHBqGJW46ck4Ol4GSpFk
         N4aHVK3U8W/CcYsQbIC70Qbuj/rqwg7ipMYekqmMhtSEg9twqipJ2RzUmz9rhyu8lETr
         9kEZ+ZQ8jL7Z+ycDR0wp74ectL/5xEyZsuFnNv8Rv5GBSZBMmTGBlwcXV9ylXaqVoMRJ
         F2T9kDtY6C4fhVP8J/9VOlqIhdaEfkuCYDI+IH/9MCHCMqR92mhyoznaVZy4UYbQrXQw
         Cldw==
X-Gm-Message-State: AOJu0YzyJpiIGVKIsJ+4WO2krEwFxJ5mXiv8zrkTwdEnJTJ+FTIEBN9U
	KAvWpaBh6Z84t/c+JAW1RwdKHvmTWF9xOHi4BEMXlQ==
X-Google-Smtp-Source: AGHT+IEWgd0iAWCXHfwBGzTrmQrVtW+FMzo5zH4VLf6g9k7F1yhIUlz2cfDSSNKnvFKDG81xgnLwp0Rk+xxKWMedRq4=
X-Received: by 2002:a1f:1e97:0:b0:4a4:d34:421b with SMTP id
 e145-20020a1f1e97000000b004a40d34421bmr27136954vke.7.1699289254490; Mon, 06
 Nov 2023 08:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com> <20231102225837.1141915-7-sdf@google.com>
 <20231105124514.GD3579@kernel.org>
In-Reply-To: <20231105124514.GD3579@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 6 Nov 2023 08:47:23 -0800
Message-ID: <CAKH8qBvg7oEZ0PVrAVFS-av_9uxvS28W+kMvc00AGvbYUCQmtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 06/13] xsk: Document tx_metadata_len layout
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

On Sun, Nov 5, 2023 at 4:45=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, Nov 02, 2023 at 03:58:30PM -0700, Stanislav Fomichev wrote:
> > - how to use
> > - how to query features
> > - pointers to the examples
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> ...
>
> > diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentati=
on/networking/xsk-tx-metadata.rst
> > new file mode 100644
> > index 000000000000..4f376560b23f
> > --- /dev/null
> > +++ b/Documentation/networking/xsk-tx-metadata.rst
> > @@ -0,0 +1,70 @@
>
> Hi Stan,
>
> a minor nit from my side: an SPDX licence identifier tag should probably =
go
> here.

Ugh, thanks, not sure how I missed it :-(

