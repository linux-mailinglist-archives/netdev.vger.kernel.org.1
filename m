Return-Path: <netdev+bounces-51196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47B7F983D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 05:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD5F280AAE
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 04:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD153A0;
	Mon, 27 Nov 2023 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blH7YA0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8480F0
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 20:22:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so4868794a12.3
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 20:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701058935; x=1701663735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49lWzY5XsjADwKty6dy2uWq7Mp+xzIHwxWbgErKH5RI=;
        b=blH7YA0qx2nkXShpvkXcMrYmJN6ygHHIiXFw8++4kzCEIBMLlo51HCdtSC4IPugbyb
         UjzlEs4x4MuuJiuN1I6y3VqGRLq7Lpuz9L4hZV7h3/15HWR0de3KnC7B8b5ZqaUfCjUY
         GBr/ZhamZrjtfXvJqBMUdYRPOi1nqEekvBLzRNaIpNFNFjQMN4KFEPdzIcfL6tWIbux7
         2hsuUuaN4g4mspDoJbVN35/WpUlhqztIYOWryUfQFW/a3E9UIVCr8ktOGNlue75JVcLt
         uJJGogQ92A5/MLikqCPV+Tpd+obtG9L7WlQEXu6k+Ou4swQ95xGvDR0DAsd4Fl3FfKqK
         RIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701058935; x=1701663735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49lWzY5XsjADwKty6dy2uWq7Mp+xzIHwxWbgErKH5RI=;
        b=CpB1DKyiFVZAla2QdfggDF9BTTarQgIxqvQC5lFA/CHydeenPLnimqh+t9C2j0CEOY
         8LBpKTTqR9KBdBmtWuB+24ZcIC2yEBKBOOTk5N5+nw1MN20QQK2m4kfKpsNKVCoaPaPC
         sYCrGAo3I7i0hfVsVLJChF7nLY+gkWCJ7NPNU1DJf5E5Xtqkx+EwWIPWq400zbmjfQF4
         dk0Uq2USN1L5jNIVowQLjjA3kXDOeoK03IJHiVH9Y9jmovpi0GpM7z2ChAZT3eL7FwWP
         QQspCsHUC+xgdJdHRWnuC7QEsJiCxAM5Tsn6IX+vFOgsmkkW1Qa0x1dREQO+AwbR5+jx
         q6Ug==
X-Gm-Message-State: AOJu0YzQjNd8GnVrbllwG2z9t4+YF6gNxyRtTM3ye6QIHT/9TnEbYaXE
	HQAkiV2waCmaIRaClajEWkN/cjXmvlZORbx22T8=
X-Google-Smtp-Source: AGHT+IGYyL89Nx2uLUsND9lmHCFnvT5aiPjbam5lSNpyum8obkASqpsCKEFqC0/TEkUPZB9jAPsBMFyttPDsR+8wSUo=
X-Received: by 2002:a17:906:abd5:b0:a10:b3ba:1942 with SMTP id
 kq21-20020a170906abd500b00a10b3ba1942mr295768ejb.27.1701058935457; Sun, 26
 Nov 2023 20:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
 <20231124073439.52626-3-liangchen.linux@gmail.com> <ed236fc1-fa6d-5ffc-54db-2c44448ea5fd@huawei.com>
In-Reply-To: <ed236fc1-fa6d-5ffc-54db-2c44448ea5fd@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 27 Nov 2023 12:22:02 +0800
Message-ID: <CAKhg4tJSaGAj07pysE_234zK_cy9b59pBET66EdCLuRS7CfZQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] page_pool: halve BIAS_MAX for fragment
 multiple user references
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 8:01=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/24 15:34, Liang Chen wrote:
>
> The title seems a little hard for me to understand, but the description
> below does seem clear to me, so LGTM.
>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
>

Thanks! I will change the title to "halve BIAS_MAX for multiple user
references of a fragment"


> > Referring to patch [1], in order to support multiple users referencing =
the
> > same fragment and prevent overflow from pp_ref_count growing, the initi=
al
> > value of pp_ref_count is halved, leaving room for pp_ref_count to incre=
ment
> > before the page is drained.

