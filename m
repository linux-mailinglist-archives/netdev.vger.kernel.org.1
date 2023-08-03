Return-Path: <netdev+bounces-23962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309376E51B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06D2282053
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AB15AD0;
	Thu,  3 Aug 2023 09:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DE7E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA82C433CA;
	Thu,  3 Aug 2023 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691056754;
	bh=BFZpJsShnV7chFQ6j5N/0sdSDzzhIsWCO5shMzIbM/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f6TRORx24cAafVSY/2poXHwp7rxU18r1K2aJNN9yeq3kXCsxm4bI2hBcbOWs78KVq
	 HbsTA9sypvIIASMxyhj7/G84fO4EmdSEPdg9FH9UcSSEbnyiCCJRfeB8B1PPag+lcX
	 65F822tXdwVPsVCQ9ucJykAOer38/AAhlHNjDcCz8KVLUPFJoG38Kceta0YNqPbVq1
	 xZix6QfzbGfdiNe1rLUvmc7v0ysdO5RNr/maVjx0nkLz0SbFY4UHNT3ZspfACC/bpr
	 S3wuFm9JglB696Va/pFddQ/QMF7ATouYo1Lu24XYcnK0/xXuxQDBQ2oJw3amZw8Lze
	 Mx7I9EZeHORjA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so2366536e87.0;
        Thu, 03 Aug 2023 02:59:13 -0700 (PDT)
X-Gm-Message-State: ABy/qLYnLKdtOcro5OVRNu0JEpIgNXRgBJdjZoSkBF0QS5kSnaF/5wRm
	TAGOuDzxCRpRXvENygYiK5MWrif6g9T6zmvA38Y=
X-Google-Smtp-Source: APBJJlFw2V3wcRa5v0Vnt1fPUZW5N5QfqaQ6cwXmzUW+1y1w1ET8IiAveXFEKGiBw1l2gDcoGbIc2BvfscEj5e4U4I4=
X-Received: by 2002:a05:6512:158b:b0:4fb:7624:85a5 with SMTP id
 bp11-20020a056512158b00b004fb762485a5mr3778949lfb.0.1691056752072; Thu, 03
 Aug 2023 02:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <20230718125847.3869700-2-ardb@kernel.org>
 <ZMt4nkfpdCXxAkr5@gcabiddu-mobl1.ger.corp.intel.com>
In-Reply-To: <ZMt4nkfpdCXxAkr5@gcabiddu-mobl1.ger.corp.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 3 Aug 2023 11:59:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGn70sGAHgOttKkC6n6jfVZ9Y61NZ9ffLmJV8MK2Kh8nQ@mail.gmail.com>
Message-ID: <CAMj1kXGn70sGAHgOttKkC6n6jfVZ9Y61NZ9ffLmJV8MK2Kh8nQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/21] crypto: scomp - Revert "add support for deflate
 rfc1950 (zlib)"
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Haren Myneni <haren@us.ibm.com>, Nick Terrell <terrelln@fb.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Richard Weinberger <richard@nod.at>, David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, qat-linux <qat-linux@intel.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Giovanni,

On Thu, 3 Aug 2023 at 11:51, Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> Hi Ard,
>
> On Tue, Jul 18, 2023 at 01:58:27PM +0100, Ard Biesheuvel wrote:
> > This reverts commit a368f43d6e3a001e684e9191a27df384fbff12f5.
> >
> > "zlib-deflate" was introduced 6 years ago, but it does not have any
> > users. So let's remove the generic implementation and the test vectors,
> > but retain the "zlib-deflate" entry in the testmgr code to avoid
> > introducing warning messages on systems that implement zlib-deflate in
> > hardware.
> >
> > Note that RFC 1950 which forms the basis of this algorithm dates back to
> > 1996, and predates RFC 1951, on which the existing IPcomp is based and
> > which we have supported in the kernel since 2003. So it seems rather
> > unlikely that we will ever grow the need to support zlib-deflate.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Support for zlib-deflate was added for [1] but that work was not
> completed.
>

Any clue why zlib_deflate was chosen in this case?

/me also notes that this is another occurrence of the antipattern
where we use an asynchronous API and subsequently sleep on the
completion.

> Based on [2], either we leave this SW implementation or we remove the HW
> implementations in the QAT [3] and in the Hisilicon Zip [4] drivers.
>

That would work for me as well - dead code is just busywork.

> [1] https://patchwork.kernel.org/project/linux-btrfs/patch/1467083180-111750-1-git-send-email-weigang.li@intel.com/
> [2] https://lore.kernel.org/lkml/ZIw%2Fjtxdg6O1O0j3@gondor.apana.org.au/
> [3] https://elixir.bootlin.com/linux/latest/source/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c#L457
> [4] https://elixir.bootlin.com/linux/latest/source/drivers/crypto/hisilicon/zip/zip_crypto.c#L754
>
> Regards,
>
> --
> Giovanni

